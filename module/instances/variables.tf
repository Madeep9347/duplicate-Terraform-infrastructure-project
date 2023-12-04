variable "vpc_id" {}
variable "public_subnet_ids" {}
variable "private_subnet_ids" {}
variable "ec2_sg_id" {
  description = "Security Group ID for RDS"
}

variable "instance_count" {
  type    = number
  default = ""  # Replace with your desired default count
}

variable "ami" {
  type    = string
  default = ""  # Replace with your default AMI ID
}

variable "instance_type" {
  type    = string
  default = ""  # Replace with your default instance type
}

variable "key_name" {
  type    = string
  default = ""  # Replace with your default key name
}

variable "iam_instance_profile" {
  type    = string
  default = ""  # Replace with your default IAM instance profile
}

