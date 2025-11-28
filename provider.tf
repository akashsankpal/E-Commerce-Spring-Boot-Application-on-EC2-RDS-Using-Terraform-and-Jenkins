provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "Ecommerce" {
  ami           = var.my_ami
  instance_type = var.my_instance
  key_name      = var.my_key

  subnet_id = aws_subnet.public_1.id
  associate_public_ip_address = true

  vpc_security_group_ids = [aws_security_group.Ecommerce_sg.id]
  user_data = file("user_data.sh")

  tags = {
    Name = "Ecommerce_server"
  }
}



output "ec2_public_ip" {
  value = aws_instance.Ecommerce.public_ip
}

output "rds_endpoint" {
  value = aws_db_instance.appdb.address
}
