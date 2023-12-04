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
  default = "" # Replace with your desired default allocated storage value
}

variable "db_identifier" {
  type    = string
  default = ""  # Replace with your desired default DB identifier
}

variable "db_name" {
  type    = string
  default = ""  # Replace with your desired default DB name
}

variable "db_engine" {
  type    = string
  default = ""  # Replace with your desired default DB engine
}

variable "engine_version" {
  type    = string
  default = ""  # Replace with your desired default engine version
}

variable "instance_class" {
  type    = string
  default = ""  # Replace with your desired default instance class
}

variable "manage_master_user_password" {
  type    = bool
  default = ""  # Replace with your desired default value
}
variable "db_username" {
  type    = string
  default = ""  # Replace with your desired default username
}

variable "parameter_group_name" {
  type    = string
  default = ""  # Replace with your desired default parameter group name
}
variable "skip_final_snapshot" {
  type    = bool
  default = ""  # Replace with your desired default value
}

variable "final_snapshot_identifier" {
  type    = string
  default = ""  # Replace with your desired default final snapshot identifier
}

# ... rest of the configuration
