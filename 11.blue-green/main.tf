provider "aws" {
  region  = "ap-southeast-1"
}

variable "production" {
  default = "blue" // change here
}

module "base" {
  source     = "terraform-in-action/aws/bluegreen//modules/base"
  version = "0.1.3"
  production = var.production
}

module "green" {
  source      = "terraform-in-action/aws/bluegreen//modules/autoscaling"
  app_version = "v1.0"
  label       = "green"
  base        = module.base
}

module "blue" {
  source      = "terraform-in-action/aws/bluegreen//modules/autoscaling"
  app_version = "v2.0"  
  label       = "blue"
  base        = module.base
}

output "lb_dns_name" {
  value = module.base.lb_dns_name
}
