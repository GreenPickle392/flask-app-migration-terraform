# 🔓 Vertrauensrichtlinie für beide Rollen (ECS darf annehmen)
data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

# 📦 ECS Task Execution Role (wird vom ECS-Agent verwendet)
resource "aws_iam_role" "ecs_task_execution" {
  name               = "${var.environment}-ecs-execution-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

# 📎 Anhängen von AWS Managed Policies für Execution Role
resource "aws_iam_role_policy_attachment" "execution_logs" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "execution_secrets" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

# 👤 ECS Task Role (wird von der App selbst zur Laufzeit verwendet)
resource "aws_iam_role" "ecs_task" {
  name               = "${var.environment}-ecs-task-role"
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
}

# 📜 Richtlinie für App-Zugriffe: S3, optional Secrets, optional RDS-Describe
data "aws_iam_policy_document" "task_permissions" {
  statement {
    sid       = "S3Access"
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${var.s3_bucket_arn}/*"]
  }

  dynamic "statement" {
    for_each = length(var.secret_arns) > 0 ? [1] : []
    content {
      sid       = "SecretsRead"
      actions   = ["secretsmanager:GetSecretValue"]
      resources = var.secret_arns
    }
  }

  statement {
    sid       = "RDSDescribe"
    actions   = ["rds:DescribeDBInstances"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "task_permissions" {
  name   = "${var.environment}-ecs-task-permissions"
  policy = data.aws_iam_policy_document.task_permissions.json
}

resource "aws_iam_role_policy_attachment" "task_policy_attach" {
  role       = aws_iam_role.ecs_task.name
  policy_arn = aws_iam_policy.task_permissions.arn
}
