output "nlb_dns_name" {
  value = aws_lb.network_load_balancer.dns_name  
}

output "alb_dns_name" {
  value = aws_lb.application_load_balancer.dns_name  
}
output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}