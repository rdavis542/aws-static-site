variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "site_name" {
  description = "Name for the static site (used in resource naming)"
  type        = string
  default     = "my-static-site"
}

variable "default_root_object" {
  description = "Default root object for the site"
  type        = string
  default     = "index.html"
}

variable "domain_name" {
  description = "Custom domain name for the site (e.g. example.com)"
  type        = string
}
