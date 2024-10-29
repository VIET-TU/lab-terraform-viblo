provider "aws" {
  region = var.region
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "ansible_server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.small" // t2.micro -> t2.small
  subnet_id = "subnet-0bfee4d2c2038dd7c"

  lifecycle {
    create_before_destroy = true
  }
}