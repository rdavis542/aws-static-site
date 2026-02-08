# aws-static-site

Terraform infrastructure for hosting a static website on AWS with HTTPS and custom domain support.

## Architecture

- **S3** - Private bucket for static content storage
- **CloudFront** - CDN distribution with Origin Access Control (OAC)
- **ACM** - TLS certificate with DNS validation
- **Route 53** - Hosted zone with A/AAAA alias records to CloudFront

## Prerequisites

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- AWS CLI configured with appropriate credentials
- A registered domain (e.g., `rdconsult.ing`)

## Usage

```bash
cd terraform
terraform init
terraform plan -var="domain_name=rdconsult.ing" -var="site_name=rdconsult-ing"
terraform apply -var="domain_name=rdconsult.ing" -var="site_name=rdconsult-ing"
```

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| `region` | AWS region | `string` | `us-east-1` |
| `site_name` | Name for the static site (used in resource naming) | `string` | `my-static-site` |
| `default_root_object` | Default root object for the site | `string` | `index.html` |
| `domain_name` | Custom domain name for the site | `string` | *required* |

## Outputs

| Name | Description |
|------|-------------|
| `cloudfront_url` | CloudFront distribution URL |
| `cloudfront_distribution_id` | CloudFront distribution ID (for cache invalidation) |
| `s3_bucket_name` | S3 bucket name for uploading content |
| `site_url` | Site URL with custom domain |
| `nameservers` | Nameservers to configure at your domain registrar |

## Deploying Content

After `terraform apply`, upload your static files to the S3 bucket:

```bash
aws s3 sync ./dist s3://$(terraform output -raw s3_bucket_name)
```

Invalidate the CloudFront cache after updates:

```bash
aws cloudfront create-invalidation \
  --distribution-id $(terraform output -raw cloudfront_distribution_id) \
  --paths "/*"
```

## DNS Configuration

After deploying, update your domain registrar's nameservers to the values from:

```bash
terraform output nameservers
```

## CI/CD

GitHub Actions workflows are provided:

- **tf-create.yml** - Plans on push/PR, applies on manual dispatch
- **tf-destroy.yml** - Manual destroy with confirmation
- **tfsec.yml** - Security scanning with tfsec
