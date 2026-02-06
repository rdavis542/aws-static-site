data "aws_caller_identity" "current" {}

locals {
  bucket_name = "${var.site_name}-${data.aws_caller_identity.current.account_id}"
}
