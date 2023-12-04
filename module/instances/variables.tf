variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "ec2_sg_id" {
  description = "Security Group ID for RDS"
}

variable "instance_count" {
  type    = number
}

variable "ami" {
  type    = string
  
}

variable "instance_type" {
  type    = string
  
}

variable "key_name" {
  type    = string
  
}

variable "iam_instance_profile" {
  type    = string
  
}

