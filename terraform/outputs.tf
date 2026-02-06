output "cloudfront_url" {
  description = "CloudFront distribution URL"
  value       = "https://${aws_cloudfront_distribution.site.domain_name}"
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID (for cache invalidation)"
  value       = aws_cloudfront_distribution.site.id
}

output "s3_bucket_name" {
  description = "S3 bucket name for uploading content"
  value       = aws_s3_bucket.site.id
}

output "site_url" {
  description = "Site URL with custom domain"
  value       = "https://${var.domain_name}"
}

output "nameservers" {
  description = "Nameservers for the hosted zone (update your domain registrar with these)"
  value       = aws_route53_zone.site.name_servers
}
