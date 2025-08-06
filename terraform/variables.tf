variable "aws_region" {
    description = "AWS region to deploy resources"
    type = string
    default = "us-east-1"
}
variable "vpc_cidr" {
    description = "CIDR block for the VPC"
    type = string
    default = "10.0.0.0/16"
}
variable "subnet_cidr" {
    description = "CIDR block for subnet"
    type = string
    default = "10.0.2.0/24"
}
variable "instance_type" {
    description = "EC2 instance type"
    type = string
    default = "t3.micro"
}
variable "instance_name" {
    description = "Name tag for the EC2 instance"
    type = string
    default = "ubuntu_server"
}
variable "iam_role_name" {
    description = "Name of IAM role"
    type = string
    default = "epm-ssm-read-role"
}