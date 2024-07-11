resource "aws_security_group" "main" {
  name   = "${var.project_name}-SG"
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.project_name}-SG"
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
#   lifecycle {
#     create_before_destroy = true
#   }
}
