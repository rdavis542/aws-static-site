terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket  = "tf-state-replication-source-350726165848"
    key     = "terraform-aws-static-site.tfstate"
    region  = "us-east-2"
    encrypt = true
  }
}

provider "aws" {
  region = var.region

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
