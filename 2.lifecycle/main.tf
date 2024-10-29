provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_s3_bucket" "terraform-bucket" {
  bucket = "terraform-series-bucket-10242024-update"

  tags = {
    Name        = "Terraform Series"
  }
}
