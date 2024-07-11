resource "aws_instance" "main" {
    
  subnet_id = var.subnet_id
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = "${var.project_name}-EC2"
  }
}