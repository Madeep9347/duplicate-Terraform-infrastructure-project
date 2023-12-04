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
  instance_count              =  2
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
  aws_db_subnet_group    = "my-new-db-subnet-group-12"
  allocated_storage             = 10
  db_identifier                = "rds-db"  
  db_name                      = "mydb"    
  db_engine                    = "mysql"   
  db_username                  = "madhu"
  engine_version               = "5.7"
  instance_class               = "db.t3.micro"
  manage_master_user_password  = true
  parameter_group_name         = "default.mysql5.7"
  skip_final_snapshot          = true
  final_snapshot_identifier    = "rds-db-snapshot5"
  # Add other necessary arguments specific to the databases module
}


module "security" {
  source              = "./module/security"
  vpc_id              = module.network.vpc_id
  
}
