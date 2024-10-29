provider "vault" {}

data "vault_aws_access_credentials" "creds" {
  backend = "aws"
  role    = "ec2-role"
}

provider "aws" {
  region     = "us-west-2"
  access_key = data.vault_aws_access_credentials.creds.access_key
  secret_key = data.vault_aws_access_credentials.creds.secret_key
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
  instance_type = "t2.micro"
}

output "ec2" {
  value = {
    public_ip = aws_instance.hello.public_ip
  }
}