# Create a EC2

resource "aws_instance" "hello-nginx" {
  ami           = "ami-01e444924a2233b07"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.hello-subnet.id
  associate_public_ip_address = true
  security_groups = [aws_security_group.hello-sg.id]

  user_data = <<-EOL
  #!/bin/bash

  sudo apt install nginx -y
  EOL

  tags = {
    Name = "hello-ec2"
  }
}

output "instance_ips" {
  value = aws_instance.hello-nginx.*.public_ip
}