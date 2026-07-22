resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "my-igw"
  }
}
resource "aws_subnet" "subnet-1" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet-1"
  }
}
resource "aws_subnet" "subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "my-subnet-2"
  }
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "subnet-1-association" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "subnet-2-association" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_security_group" "alb_sg" {
  name        = "alb-sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instances"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
resource "aws_instance" "instance-1" {
  ami                         = "ami-0b6d9d3d33ba97d99"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet-1.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  user_data                   = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get install -y apache2
    cat > /var/www/html/index.html << 'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Terraform ALB Demo</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          text-align: center;
          background-color: #f4f4f4;
          padding: 50px;
        }
        h1 { color: #e67e22; }
        h2 { color: #2c3e50; }
        p { color: #555; font-size: 18px; }
        .badge { color: green; font-weight: bold; margin-top: 20px; }
        .footer { color: #999; margin-top: 30px; }
      </style>
    </head>
    <body>
      <h1>🚀 Terraform Deployment Successful</h1>
      <h2>Application Load Balancer Demo</h2>
      <p>This web server is running on an Amazon EC2 instance provisioned using <b>Terraform</b>.</p>
      <p>Requests are being routed through an <b>AWS Application Load Balancer (ALB)</b>.</p>
      <p class="badge">✅ Infrastructure created successfully using Terraform</p>
      <p class="footer">AWS • EC2 • ALB • Terraform | Instance: instance-1</p>
    </body>
    </html>
    HTML
    systemctl enable --now apache2
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "my-ec2-instance-1"
  }
}
resource "aws_instance" "instance-2" {
  ami                         = "ami-0b6d9d3d33ba97d99"
  instance_type               = "t3.micro"
  subnet_id                   = aws_subnet.subnet-2.id
  vpc_security_group_ids      = [aws_security_group.ec2_sg.id]
  user_data                   = <<-EOF
    #!/bin/bash
    set -euxo pipefail
    export DEBIAN_FRONTEND=noninteractive
    apt-get update -y
    apt-get install -y apache2
    cat > /var/www/html/index.html << 'HTML'
    <!DOCTYPE html>
    <html>
    <head>
      <title>Terraform ALB Demo</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          text-align: center;
          background-color: #f4f4f4;
          padding: 50px;
        }
        h1 { color: #e67e22; }
        h2 { color: #2c3e50; }
        p { color: #555; font-size: 18px; }
        .badge { color: green; font-weight: bold; margin-top: 20px; }
        .footer { color: #999; margin-top: 30px; }
      </style>
    </head>
    <body>
      <h1>🚀 Terraform Deployment Successful</h1>
      <h2>Application Load Balancer Demo</h2>
      <p>This web server is running on an Amazon EC2 instance provisioned using <b>Terraform</b>.</p>
      <p>Requests are being routed through an <b>AWS Application Load Balancer (ALB)</b>.</p>
      <p class="badge">✅ Infrastructure created successfully using Terraform</p>
      <p class="footer">AWS • EC2 • ALB • Terraform | Instance: instance-2</p>
    </body>
    </html>
    HTML
    systemctl enable --now apache2
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "my-ec2-instance-2"
  }
}
resource "aws_lb" "alb" {
  name               = "my-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  enable_deletion_protection = false
}
resource "aws_lb_target_group" "target_group" {
  name     = "my-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id

  health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }
}
resource "aws_lb_target_group_attachment" "attachment-1" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.instance-1.id
  port             = 80
}
resource "aws_lb_target_group_attachment" "attachment-2" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = aws_instance.instance-2.id
  port             = 80
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}
