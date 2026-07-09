variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "EC2 instance AMI ID"
  type        = string
  default     = "ami-03f1d2b3639314198"
}