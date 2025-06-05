resource "aws_security_group" "this" {
  name        = "${var.environment}-flask-access-sg"
  description = "Erlaube Zugriff von eigener IP auf Flask-App"
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTP von meiner IP"
    from_port        = var.port
    to_port          = var.port
    protocol         = "tcp"
    cidr_blocks      = [var.allowed_ip_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.environment}-flask-access-sg"
    Environment = var.environment
  }
}
