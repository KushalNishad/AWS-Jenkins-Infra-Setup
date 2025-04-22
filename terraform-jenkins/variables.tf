/*
variable "bucket_name" {
    type = string
    description = "Bucket name"
}
*/

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}
variable "vpc_name" {
  type        = string
  description = "VPC name"
}

variable "cidr_private_subnet" {
  type        = list(string)
  description = "Private subnet CIDR"
}

variable "cidr_public_subnet" {
  type        = list(string)
  description = "Public subnet CIDR"
}

variable "us_availability_zone" {
  type        = list(string)
  description = "Availability Zones"
}

variable "ec2_ami_id" {
  type        = string
  description = "AMI Id for EC2 instance"
}

variable "public_key" {
  type        = string
  description = "DevOps Project 1 Public key for EC2 instance"
}