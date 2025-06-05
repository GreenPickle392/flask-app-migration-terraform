variable "environment" {
  description = "Umgebungsname (z. B. prod)"
  type        = string
}

variable "container_image" {
  description = "Image URI aus ECR"
  type        = string
}

variable "container_port" {
  description = "Port, auf dem Flask-App im Container läuft"
  type        = number
  default     = 5000
}

variable "cpu" {
  description = "CPU-Zuweisung für Task"
  type        = string
  default     = "256"
}

variable "memory" {
  description = "RAM-Zuweisung für Task"
  type        = string
  default     = "512"
}

variable "task_execution_role_arn" {
  description = "ARN der Execution Role"
  type        = string
}

variable "task_role_arn" {
  description = "ARN der Task Role"
  type        = string
}

variable "subnet_ids" {
  description = "Liste der Subnetze für die Task-Platzierung"
  type        = list(string)
}

variable "security_group_ids" {
  description = "Liste der Security Groups für die Tasks"
  type        = list(string)
}

variable "assign_public_ip" {
  description = "Ob die App eine öffentliche IP bekommen soll"
  type        = bool
  default     = false
}

variable "s3_bucket_name" {
  description = "Name des S3 Buckets"
  type        = string
}

variable "db_name" {
  description = "Name der Datenbank"
  type        = string
}

variable "db_username_secret_arn" {
  description = "ARN des Secrets für DB-Benutzer"
  type        = string
}

variable "db_password_secret_arn" {
  description = "ARN des Secrets für DB-Passwort"
  type        = string
}
