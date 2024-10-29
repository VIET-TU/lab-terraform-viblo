provider "aws" {
  region = "ap-southeast-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "hello" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type // change here
  subnet_id = "subnet-0bfee4d2c2038dd7c"
  associate_public_ip_address = true
}

output "ec2" {
  value = {
    public_ip = aws_instance.hello.public_ip
  }
}