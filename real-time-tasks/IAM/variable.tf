variable "my_iam_user" {
  description = "The name of the IAM user to create."
  type        = string
  default     = "my-iam-user"
}

variable "my_iam_user_policy" {
  description = "The name of the IAM user policy to create."
  type        = string
  default     = "my-iam-user-policy"
}   