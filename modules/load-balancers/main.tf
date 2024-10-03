resource "aws_lb" "network_load_balancer" {
  name               = "my-nlb"
  internal           = false
  load_balancer_type = "network"
  subnets            = var.public_subnets
  enable_deletion_protection = false
  tags = {
    Name = "my-nlb"
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.network_load_balancer.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}

resource "aws_lb_target_group" "nlb_target_group" {
  name     = "nlb-target-group"
  port     = 80
  protocol = "TCP"
  vpc_id   = var.vpc_id  
  target_type   = "instance"
}
resource "aws_lb_target_group_attachment" "nlb_attachment" {
  count           = length(var.public_instance_ids)
  target_group_arn = aws_lb_target_group.nlb_target_group.arn
  target_id        = element(var.public_instance_ids, count.index)
  port             = 80
}

resource "aws_lb" "application_load_balancer" {
  name               = "my-alb"
  internal           = true
  load_balancer_type = "application"
 security_groups = [var.alb_sg]  
  subnets            = var.private_subnets  

  enable_deletion_protection = false

  tags = {
    Name = "my-alb"
  }
}
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
resource "aws_lb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id  
  target_type   = "instance"
}
resource "aws_lb_target_group_attachment" "private" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.private
  port             = 80
}
resource "aws_lb_target_group_attachment" "private1" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id        = var.private1
  port             = 80
}
resource "aws_security_group" "alb_sg" {
  vpc_id = var.vpc_id
ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "alb_sg"
  }
}