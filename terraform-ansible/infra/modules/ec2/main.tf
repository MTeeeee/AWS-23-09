resource "aws_instance" "main" {
    
  subnet_id = var.subnet_id
  ami           = var.ami
  instance_type = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.main.id]
  user_data = file("${path.module}/nginx.sh")

  tags = {
    Name = "${var.project_name}-EC2"
  }
}