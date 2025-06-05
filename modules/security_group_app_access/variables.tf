variable "environment" {
  description = "Umgebungsname (z. B. dev, prod)"
  type        = string
}

variable "vpc_id" {
  description = "ID der VPC, in der sich die App befindet"
  type        = string
}

variable "port" {
  description = "Port, der für den Zugriff freigegeben werden soll (z. B. 5000)"
  type        = number
  default     = 5000
}

variable "allowed_ip_cidr" {
  description = "Die eigene öffentliche IP-Adresse im CIDR-Format (z. B. 91.12.34.56/32)"
  type        = string
}
