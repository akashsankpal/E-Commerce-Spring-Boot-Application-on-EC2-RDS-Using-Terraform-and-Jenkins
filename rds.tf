resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id
  ]

  tags = {
    Name = "rds-subnet-group"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


resource "aws_db_instance" "appdb" {
  identifier               = "ecommerce-db"
  engine                   = var.db_engine == "mysql" ? "mysql" : "postgres"
  engine_version           = var.db_engine == "mysql" ? "8.0" : "14"

  instance_class           = "db.t3.micro"
  allocated_storage        = var.db_allocated_storage
  storage_type             = "gp2"

  username                 = var.db_username
  password                 = var.db_password

  skip_final_snapshot      = true
  deletion_protection      = false
  publicly_accessible      = false
  multi_az                 = false

  vpc_security_group_ids   = [aws_security_group.rds_sg.id]
  db_subnet_group_name     = aws_db_subnet_group.default.name

  tags = {
    Name = "ecommerce-rds"
  }
}
