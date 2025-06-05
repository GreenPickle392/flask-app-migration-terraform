variable "environment" {
  description = "Name der Umgebung (z. B. dev, prod)"
  type        = string
}

variable "s3_bucket_arn" {
  description = "ARN des S3 Buckets, auf den die App zugreifen darf"
  type        = string
}

variable "secret_arns" {
  description = "Liste von Secrets, auf die die App zugreifen darf (optional)"
  type        = list(string)
  default     = []
}
