terraform { 
  cloud { 
    
    organization = "viettu" 

    workspaces { 
      name = "terraform-series-remote-backend" 
    } 
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