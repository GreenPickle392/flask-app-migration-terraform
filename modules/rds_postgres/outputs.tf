output "db_endpoint" {
  description = "DNS-Name (Endpoint) der Datenbank"
  value       = aws_db_instance.this.endpoint
}

output "db_port" {
  description = "Port der Datenbank"
  value       = aws_db_instance.this.port
}

output "db_name" {
  description = "Datenbankname"
  value       = var.db_name
}
