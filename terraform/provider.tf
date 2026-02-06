terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = "development"
      Project     = "aws-static-site"
      ManagedBy   = "Terraform"
      Repository  = "aws-static-site"
      Owner       = "ryan_davis542@outlook.com"
      CostCenter  = "Personal"
    }
  }
}
