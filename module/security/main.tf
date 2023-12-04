resource "aws_security_group" "ec2_sg" {
  name        = "web_sg"
  description = "Security group for web instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [22, 3306, 80, 8000]

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"

      cidr_blocks = ingress.value == 80 || ingress.value == 8000 ? ["0.0.0.0/0"] : []  # Adjust as needed
    }
  }

  dynamic "egress" {
    for_each = [0]

    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "db_sg"
  description = "Security group for database instances"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = [3306]

    content {
      from_port         = ingress.value
      to_port           = ingress.value
      protocol          = "tcp"
      security_groups   = [aws_security_group.ec2_sg.id]  # Reference the EC2 security group ID that allows traffic to RDS
    }
  }

  dynamic "egress" {
    for_each = [0]

    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}
