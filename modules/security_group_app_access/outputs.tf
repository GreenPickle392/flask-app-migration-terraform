output "security_group_id" {
  description = "ID der Security Group für Zugriff auf Flask-App"
  value       = aws_security_group.this.id
}

