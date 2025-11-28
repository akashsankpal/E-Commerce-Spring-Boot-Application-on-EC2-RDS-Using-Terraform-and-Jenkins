resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = data.aws_subnets.default.ids
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_db_instance" "appdb" {
  identifier              = "ecommerce-db"
  engine                  = var.db_engine == "mysql" ? "mysql" : "postgres"
  instance_class          = var.db_instance_class
  allocated_storage       = var.db_allocated_storage

  username                = var.db_username
  password                = var.db_password
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.default.name
  publicly_accessible     = false
}
