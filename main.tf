provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "statefile-terraform-bucket"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
  }
}

module "network" {
  source                  = "./module/network"
  vpc_cidr_block          = "10.0.0.0/16"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  vpc_name                = "my-vpc1"
  public_subnet_names     = ["public-subnet-1"]
  private_subnet_names    = ["private-subnet-1"]
  igw_name                = "my-igw"
  public_route_table_name = "public-route-table"
  private_route_table_name = "private-route-table"
}

module "instances" {
  source             = "./module/instances"
  vpc_id             = module.network.vpc_id
  public_subnet_ids  = module.network.public_subnet_ids
  private_subnet_ids = module.network.private_subnet_ids
  ec2_sg_id          = module.security.ec2_security_group_id # Reference the ec2_sg_id from the network module
  ami                =  "ami-0fc5d935ebf8bc3bc"
  instance_type      = "t2.micro"
  key_name           =  "terraformproject" 
  iam_instance_profile = "roleforec2codedeploy"
}

module "databases" {
  source              = "./module/databases"
  vpc_id              = module.network.vpc_id
  private_subnet_ids  = module.network.private_subnet_ids
  rds_sg_id           = module.security.rds_security_group_id
  allocated_storage             = 20                                  # Custom default value for allocated_storage
  identifier                    = "custom-rds-db"                     # Custom default value for identifier
  db_name                       = "custom-mydb"                       # Custom default value for db_name
  engine                        = "custom-mysql"                      # Custom default value for engine
  engine_version                = "8.0.33"                            # Custom default value for engine_version
  instance_class                = "db.t3.small"                       # Custom default value for instance_class
  manage_master_user_password   = true                                # Custom default value for manage_master_user_password
  username                      = "bar"                               # Custom default value for username
  parameter_group_name          = "custom.mysql8.0.33"                # Custom default value for parameter_group_name
  skip_final_snapshot           = false                               # Custom default value for skip_final_snapshot
  final_snapshot_identifier     = "rds-db-snapshot5"                  # Custom default value for final_snapshot_identifier
  # Add other necessary arguments specific to the databases module
}

module "security" {
  source              = "./module/security"
  vpc_id              = module.network.vpc_id
  
}
