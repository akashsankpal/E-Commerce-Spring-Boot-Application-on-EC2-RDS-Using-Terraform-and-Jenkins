variable "my_key" {
     description="master1"
      type = string
 }
variable "my_instance" {
    description = "my"
     default = "t2.micro"
}
variable "db_engine" { 
    default = "mysql"
} # "mysql" or "postgres"
variable "db_username" {
     description="DB admin username"
      type = string 
}
variable "db_password" {
     description="DB password"
      type = string
      sensitive = true 
}
variable "db_instance_class" {
     default = "db.t3.micro" 
}
variable "db_allocated_storage" {
     default = 20
}
variable "app_port" {
     default = 8080 
}
variable "vpc_id" { 
    default = "" 
} # leave empty to use default VPC
variable "my_ami" {
    description = "ami id"
  default = "ami-0d176f79571d18a8f"
}
