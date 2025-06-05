resource "aws_ecs_cluster" "this" {
  name = "${var.environment}-flask-cluster"
}

resource "aws_ecs_task_definition" "this" {
  family                   = "${var.environment}-flask-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory
  execution_role_arn       = var.task_execution_role_arn
  task_role_arn            = var.task_role_arn

  container_definitions = jsonencode([
    {
      name      = "flask-app"
      image     = var.container_image
      essential = true

      portMappings = [
        {
          containerPort = var.container_port
          protocol      = "tcp"
        }
      ]

      environment = [
        {
          name  = "DB_NAME"
          value = var.db_name
        },
        {
          name  = "STORAGE_BUCKET"
          value = var.s3_bucket_name
        }
      ]

      secrets = [
        {
          name      = "DB_USERNAME"
          valueFrom = var.db_username_secret_arn
        },
        {
          name      = "DB_PASSWORD"
          valueFrom = var.db_password_secret_arn
        }
      ]
    }
  ])
}

resource "aws_ecs_service" "this" {
  name            = "${var.environment}-flask-service"
  cluster         = aws_ecs_cluster.this.id
  launch_type     = "FARGATE"
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1

  network_configuration {
    subnets         = var.subnet_ids
    assign_public_ip = var.assign_public_ip
    security_groups = var.security_group_ids
  }
}
