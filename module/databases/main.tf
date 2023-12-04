resource "aws_db_subnet_group" "example" {
  name        = "my-new-db-subnet-group-12"
  description = "my-new-db-subnet-group-12"
  subnet_ids  = var.private_subnet_ids

  tags = {
    Name = "MyNewDBSubnetGroup"
  }
}

resource "aws_kms_key" "example" {
  description = "Example KMS Key"
}

resource "aws_db_instance" "default" {
  allocated_storage             = var.allocated_storage
  identifier                    = var.db_identifier
  db_name                       = var.db_name
  engine                        = var.db_engine
  engine_version                = var.engine_version
  instance_class                = var.instance_class
  manage_master_user_password   = var.manage_master_user_password
  master_user_secret_kms_key_id = aws_kms_key.example.key_id
  username                      = var.db_username
  parameter_group_name          = var.parameter_group_name
  db_subnet_group_name          = aws_db_subnet_group.example.name
  vpc_security_group_ids        = [var.rds_sg_id]
  skip_final_snapshot           = var.skip_final_snapshot
  final_snapshot_identifier     = var.final_snapshot_identifier
}

