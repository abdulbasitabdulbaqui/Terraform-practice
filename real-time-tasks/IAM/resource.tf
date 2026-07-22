resource "aws_iam_user" "i_am_user" {
  name = var.my_iam_user
  tags = {
    Name = var.my_iam_user
  }
}

resource "aws_iam_group" "my_iam_group" {
  name = "my-iam-group"


}

resource "aws_iam_group_membership" "my_iam_group_membership" {
  name  = "my-iam-group-membership"
  users = [aws_iam_user.i_am_user.name]
  group = aws_iam_group.my_iam_group.name
}

resource "aws_iam_user_policy" "i_am_user_policy" {
  name = var.my_iam_user_policy
  user = aws_iam_user.i_am_user.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["*"]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role" "ec2_role" {
  name = "my-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}