variable "private_subnet_ids" {}
variable "public_subnet_ids" {
  type    = list(string)
  default = []  # Add a default value or replace it with your actual default values
}
// databases/variables.tf

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "rds_sg_id" {
  description = "Security Group ID for RDS"
}

variable "allocated_storage" {
  type    = number
  
}

variable "db_identifier" {
  type    = string
  
}

variable "db_name" {
  type    = string
  
}

variable "db_engine" {
  type    = string
  
}

variable "engine_version" {
  type    = string
  
}

variable "instance_class" {
  type    = string
  
}

variable "manage_master_user_password" {
  type    = bool
  
}
variable "db_username" {
  type    = string
  
}

variable "parameter_group_name" {
  type    = string
  
}
variable "skip_final_snapshot" {
  type    = bool
  
}

variable "final_snapshot_identifier" {
  type    = string
  
}
variable "aws_db_subnet_group" {
  type    = string
  
}

# ... rest of the configuration
