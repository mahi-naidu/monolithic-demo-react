output "frontend-public-ip" {
    value = aws_instance.frontend.public_ip
  
}
output "backend-private-ip" {
    value = aws_instance.backend.private_ip
  
}