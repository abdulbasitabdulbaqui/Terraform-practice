resource "aws_vpc" "name" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "practice-vpc"
  }

}
resource "aws_subnet" "practice-vpc-subnet" {
  vpc_id                  = aws_vpc.name.id
  cidr_block              = "10.0.0.0/24"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "practice-ig" {
  vpc_id = aws_vpc.name.id
  tags = {
    Name = "practice-ig"
  }
}

resource "aws_route_table" "practice-rt" {
  vpc_id = aws_vpc.name.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.practice-ig.id
  }
}

resource "aws_route_table_association" "practice-rt-association" {
  subnet_id      = aws_subnet.practice-vpc-subnet.id
  route_table_id = aws_route_table.practice-rt.id
}

resource "aws_security_group" "practice-sg" {
  name        = "practice-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = aws_vpc.name.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  vpc_security_group_ids      = [aws_security_group.practice-sg.id]
  subnet_id                   = aws_subnet.practice-vpc-subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "practice-instance"
  }
}
