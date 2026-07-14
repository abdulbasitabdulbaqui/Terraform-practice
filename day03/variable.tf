variable "ami_id" {
  description = "The AMI ID to use for the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "The instance type to use for the EC2 instance"
  type        = string
}
variable "instance_type_01" {
  description = "EC2 instance type"
  type        = string
}
variable "instance_type_02" {
  description = "EC2 instance type"
  type        = string
}
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "subnet_cidr" {
  description = "The CIDR block for the subnet"
  type        = string
}
variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
}
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}
