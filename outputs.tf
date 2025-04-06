output "web_server_public_ip" {
  value = aws_instance.web_server.public_ip
  description = "Web Server Public IP"
}

output "db_server_public_ip" {
  value = aws_instance.db_server.public_ip
  description = "DB Server Public IP"
}