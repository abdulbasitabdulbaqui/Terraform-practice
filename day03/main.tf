resource "aws_instance" "instance-01" {
  ami           = var.ami_id
  instance_type = var.instance_type_01
  tags = {
    Name = "Instance-01"
  }
}
resource "aws_instance" "instance-02" {
  ami           = var.ami_id
  instance_type = var.instance_type_02
  tags = {
    Name = "Instance-02"
  }
}
resource "aws_s3_bucket" "bucket" {
  bucket = "ansari-abdul-basit-bucket"
  tags = {
    name = "mine-bucket"
  }
}

