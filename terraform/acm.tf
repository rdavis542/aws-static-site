# ACM certificate for the custom domain
# Note: ACM certs for CloudFront must be in us-east-1.
# The provider already defaults to us-east-1, so no alias provider is needed.
resource "aws_acm_certificate" "site" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  tags = {
    Name = var.site_name
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Wait for DNS validation to complete
resource "aws_acm_certificate_validation" "site" {
  certificate_arn         = aws_acm_certificate.site.arn
  validation_record_fqdns = [for r in aws_route53_record.cert_validation : r.fqdn]
}
