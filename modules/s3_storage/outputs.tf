output "bucket_name" {
  description = "Name des erstellten S3 Buckets"
  value       = aws_s3_bucket.this.id
}
