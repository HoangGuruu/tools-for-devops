provider "aws" {
    region = "us-east-1"  # Set your desired AWS region
}

resource "aws_instance" "example" {
    ami           = "ami-067d1e60475437da2"  # Specify an appropriate AMI ID
    instance_type = "t2.micro"
}