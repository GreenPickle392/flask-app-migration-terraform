terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"  # oder deine gewünschte Version
    }
  }
}

provider "aws" {
  region  = var.aws_region
  profile = "default"  # oder entsprechend deiner AWS CLI Konfiguration
}


module "s3_storage" {
  source        = "../../modules/s3_storage"
  bucket_name   = var.s3_bucket_name
  environment   = var.environment
}

module "rds_postgres" {
  source                   = "../../modules/rds_postgres"
  db_identifier            = "${var.environment}-flask-db"
  db_name                  = var.db_name
  db_username_secret_id    = var.db_username_secret_id
  db_password_secret_id    = var.db_password_secret_id
  environment              = var.environment
  engine_version           = var.db_engine_version
  instance_class           = var.db_instance_class
  allocated_storage        = var.db_allocated_storage
}

module "iam_roles" {
  source         = "../../modules/iam_roles"
  environment    = var.environment
  s3_bucket_arn  = module.s3_storage.bucket_arn
  secret_arns    = [
    module.rds_postgres.db_username_secret_arn,
    module.rds_postgres.db_password_secret_arn
  ]
}

module "security_group_app_access" {
  source             = "../../modules/security_group_app_access"
  environment        = var.environment
  vpc_id             = var.vpc_id
  port               = var.container_port
  allowed_ip_cidr    = var.allowed_ip_cidr
}

module "flask_app_ecs" {
  source                    = "../../modules/flask_app_ecs"
  environment               = var.environment
  container_image           = var.container_image
  container_port            = var.container_port
  cpu                       = var.cpu
  memory                    = var.memory
  db_name                   = var.db_name
  db_username_secret_arn    = module.rds_postgres.db_username_secret_arn
  db_password_secret_arn    = module.rds_postgres.db_password_secret_arn
  s3_bucket_name            = var.s3_bucket_name
  task_execution_role_arn   = module.iam_roles.task_execution_role_arn
  task_role_arn             = module.iam_roles.task_role_arn
  subnet_ids                = var.subnet_ids
  security_group_ids        = [module.security_group_app_access.security_group_id]
  assign_public_ip          = true
}
