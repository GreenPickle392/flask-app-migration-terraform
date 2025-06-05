output "cluster_id" {
  value       = aws_ecs_cluster.this.id
  description = "ID des ECS Clusters"
}

output "service_name" {
  value       = aws_ecs_service.this.name
  description = "Name des gestarteten ECS Services"
}
