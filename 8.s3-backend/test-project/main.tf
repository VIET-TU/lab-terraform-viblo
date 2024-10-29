terraform {
  backend "s3" {
    bucket         = "terraform-series-s3-backend-10272024"
    key            = "test-project"
    region         = "ap-southeast-1"
    encrypt        = true
    role_arn       = "arn:aws:iam::287925497349:role/Terraform-SeriesS3BackendRole"
    dynamodb_table = "terraform-series-s3-backend"
  }
}

provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

resource "aws_instance" "server" {
  ami           = data.aws_ami.ami.id
  instance_type = "t2.micro"
  subnet_id = "subnet-0bfee4d2c2038dd7c"
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "Server"
  }
}

output "private_ip" {
  value = aws_instance.server.private_ip
}