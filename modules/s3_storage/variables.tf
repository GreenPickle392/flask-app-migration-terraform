variable "bucket_name" {
  description = "Name des S3 Buckets zur Ablage von PDF-Dateien"
  type        = string
}

variable "environment" {
  description = "Umgebungsbezeichnung (z. B. dev, prod)"
  type        = string
}
