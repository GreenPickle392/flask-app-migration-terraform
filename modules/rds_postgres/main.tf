# 🔐 Secret mit DB-Benutzername (plain text)
data "aws_secretsmanager_secret_version" "db_username" {
  secret_id = var.db_username_secret_id
}

# 🔐 Secret mit DB-Passwort (plain text)
data "aws_secretsmanager_secret_version" "db_password" {
  secret_id = var.db_password_secret_id
}

resource "aws_db_instance" "this" {
  identifier               = var.db_identifier
  engine                   = "postgres"
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  allocated_storage        = var.allocated_storage
  username                 = data.aws_secretsmanager_secret_version.db_username.secret_string
  password                 = data.aws_secretsmanager_secret_version.db_password.secret_string
  db_name                  = var.db_name
  skip_final_snapshot      = true
  publicly_accessible      = false
  storage_encrypted        = true
  deletion_protection      = false
  backup_retention_period  = 7

  tags = {
    Name        = var.db_identifier
    Environment = var.environment
    Project     = "Flask Dokumentenverwaltung"
  }
}