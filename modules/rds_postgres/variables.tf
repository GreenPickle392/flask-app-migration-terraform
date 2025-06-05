variable "db_identifier" {
  description = "Eindeutiger Name der DB-Instanz in AWS"
  type        = string
}

variable "engine_version" {
  description = "Version der PostgreSQL Engine"
  type        = string
  default     = "15.3"
}

variable "instance_class" {
  description = "DB Instance Type"
  type        = string
  default     = "db.t3.micro"
}

variable "allocated_storage" {
  description = "Größe in GB"
  type        = number
  default     = 20
}

variable "db_name" {
  description = "Name der anzulegenden Datenbank"
  type        = string
}

variable "db_username_secret_id" {
  description = "Secret ID für den Benutzernamen (Plain Text)"
  type        = string
}

variable "db_password_secret_id" {
  description = "Secret ID für das Passwort (Plain Text)"
  type        = string
}

variable "environment" {
  description = "Umgebungsbezeichnung (z. B. dev, prod)"
  type        = string
}
