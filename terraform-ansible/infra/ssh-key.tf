

# RSA key of size 4096 bits
resource "tls_private_key" "rsa-4096-example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "deployer" {
  key_name   = "tf-key"
  public_key = tls_private_key.rsa-4096-example.public_key_openssh
}

resource "local_file" "tf-key" {
  filename = "../ansible/tf-key.pem"
  content = tls_private_key.rsa-4096-example.private_key_pem
}