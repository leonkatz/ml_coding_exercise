output "ml_instance_public_ip" {
  value = aws_instance.ml_ec2.public_ip
}

output "db_endpoint" {
  value = aws_db_instance.ml_rds.endpoint
}

output "db_port" {
  value = aws_db_instance.ml_rds.port
}
output "db_username" {
  value = aws_db_instance.ml_rds.username
}

output "db_password" {
  value = nonsensitive(aws_db_instance.ml_rds.password)
}

output "private_key_opnessh" {
  value = nonsensitive(tls_private_key.hadrian.private_key_openssh)
}

output "private_key_pem" {
  value = nonsensitive(tls_private_key.hadrian.private_key_pem)
}
