# Create a VPC
resource "aws_vpc" "hello-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "hello-vpc"
  }
}

# Create Subnet

resource "aws_subnet" "hello-subnet" {
  vpc_id            = aws_vpc.hello-vpc.id
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "hello-subnet"
  }
}

# Create Routing Table

resource "aws_route_table" "hello-rt" {
  vpc_id = aws_vpc.hello-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hello-ig.id
  }

  tags = {
    Name = "hello-rt"
  }
}

# Route Table mit Subnet verbinden

resource "aws_route_table_association" "hello-route-table-association" {
  subnet_id      = aws_subnet.hello-subnet.id
  route_table_id = aws_route_table.hello-rt.id
}

# Create Internet Gateway

resource "aws_internet_gateway" "hello-ig" {
  vpc_id = aws_vpc.hello-vpc.id

  tags = {
    Name = "hello-ig"
  }
}