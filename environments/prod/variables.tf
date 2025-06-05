variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "environment" {
  type        = string
  description = "Name der Umgebung (z. B. prod)"
}

variable "container_image" {
  type        = string
  description = "ECR Image URI"
}

variable "container_port" {
  type        = number
  default     = 5000
}

variable "cpu" {
  type        = string
  default     = "256"
}

variable "memory" {
  type        = string
  default     = "512"
}

variable "db_name" {
  type        = string
  description = "Name der PostgreSQL Datenbank"
}

variable "db_username_secret_id" {
  type        = string
  description = "Secret ID für den DB-Benutzer"
}

variable "db_password_secret_id" {
  type        = string
  description = "Secret ID für das DB-Passwort"
}

variable "db_engine_version" {
  type        = string
  default     = "15.3"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "db_allocated_storage" {
  type        = number
  default     = 20
}

variable "s3_bucket_name" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private oder öffentliche Subnetze für ECS"
}

variable "vpc_id" {
  type        = string
  description = "VPC-ID für Security Group"
}

variable "allowed_ip_cidr" {
  type        = string
  description = "Deine öffentliche IP als CIDR, z. B. 91.12.34.56/32"
}
