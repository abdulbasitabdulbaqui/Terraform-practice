resource "aws_instance" "dev" {
  ami           = "ami-0e5497a77ef21b5ac"
  instance_type = "t3.micro"
  tags = {
    Name = "dev"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "abdul-bucket-1111"
}

resource "aws_vpc" "vpc-01" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc-12"
  }
}

resource "aws_subnet" "my-subnet-1" {
  vpc_id     = aws_vpc.vpc-01.id
  cidr_block = "10.0.0.0/20"
  tags = {
    Name = "my-subnet-02"
  }
}

resource "aws_subnet" "my-subnet-2" {
  vpc_id     = aws_vpc.vpc-01.id
  cidr_block = "10.0.16.0/20"
  tags = {
    Name = "my-subnet-01"
  }
}
resource "aws_internet_gateway" "my-ig" {
  vpc_id = aws_vpc.vpc-01.id
  tags = {
    Name = "my-ig-01"
  }
}
resource "aws_route_table" "my-rt" {
  vpc_id = aws_vpc.vpc-01.id
  tags = {
    Name = "my-rt-01"
  }
}

resource "aws_route_table_association" "rta1" {
  route_table_id = "rtb-06b33a0a59ab809cc"
  subnet_id      = "subnet-0d6472603acf66e9b"
}

resource "aws_route_table_association" "rta2" {
   route_table_id = "rtb-06b33a0a59ab809cc"
    subnet_id      = "subnet-0149702cf95a92db2"
}