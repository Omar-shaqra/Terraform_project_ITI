output "public_instance_ids" {
  value = aws_instance.public[*].id  
}

output "private_instance_ids" {
  value = aws_instance.private[*].id 
}
output "public_ips" {
  value = aws_instance.public[*].public_ip
}
output "private_ips" {
  value = aws_instance.private[*].private_ip
}
output "private" {
  value = aws_instance.private.id
}
output "private1" {
  value = aws_instance.private1.id
}
