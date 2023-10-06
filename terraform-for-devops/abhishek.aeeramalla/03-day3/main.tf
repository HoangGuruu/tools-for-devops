provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
  source = "./modules/ec2_instance"
  ami_value = "ami-0261755bbcb8c4a84" # replace this
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-0f9406d3dd47449e6" # replace this
}