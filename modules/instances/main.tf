data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["137112412989"] 
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"] 
  }
}
resource "aws_instance" "public" {
  count = 2
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.public_subnets[count.index]
  key_name      = "shaqra"
security_groups = [var.public_sg]
provisioner "local-exec" {
    command = "echo Public IP is: ${self.public_ip} >> outputs.txt"
    
  }
  provisioner "file" {
    content     = templatefile("./modules/instances/provisioner.sh", { alb_dns_name = var.alb_dns_name })
    destination = "/tmp/provisioner.sh"
  }
connection {
      type        = "ssh"
      user        = "ec2-user"  
      private_key = file("shaqra.pem")  
      host        = self.public_ip  
    }
  
  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/provisioner.sh",
      "sudo /tmp/provisioner.sh "
    ]
  }

  tags = {
    Name = "public-instance-${count.index + 1}"
  }
}

resource "aws_instance" "private" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.private_subnets[0]
 security_groups = [var.private_sg]
 key_name      = "shaqra"
 provisioner "local-exec" {
    command = "echo Private IP is: ${self.private_ip} >> outputs.txt"
    
  }
  user_data = <<-EOF
#!/bin/bash
 yum update -y
 yum install -y httpd
 touch /var/www/html/index.html
 echo '${file("index.html")}' > /var/www/html/index.html
 mv index.html /var/www/html/index.html
 systemctl start httpd
 systemctl enable httpd
EOF

  tags = {
    Name = "private-instance-1"
  }
}

resource "aws_instance" "private1" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  subnet_id     = var.private_subnets[1]
 security_groups = [var.private_sg]
 key_name      = "shaqra"
 provisioner "local-exec" {
    command = "echo Private IP is: ${self.private_ip} >> outputs.txt"
    
  }
  user_data = <<-EOF
#!/bin/bash
 yum update -y
 yum install -y httpd
 touch /var/www/html/index.html
 echo '${file("index1.html")}' > /var/www/html/index.html
 mv index.html /var/www/html/index.html
 systemctl start httpd
 systemctl enable httpd
EOF

  tags = {
    Name = "private-instance-2"
  }
}