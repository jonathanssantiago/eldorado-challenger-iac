provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "static_site_bucket" {
  bucket = "static-site-${var.bucket_name}"

  tags = {
    Name        = "Static Site Bucket"
    Environment = "Production"
  }
}

resource "aws_s3_bucket_public_access_block" "static_site_bucket" {
  bucket = aws_s3_bucket.static_site_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# Configuração de propriedade que permite ACLs
resource "aws_s3_bucket_ownership_controls" "static_site_bucket" {
  bucket = aws_s3_bucket.static_site_bucket.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

# ACL pública para leitura
resource "aws_s3_bucket_acl" "static_site_bucket" {
  depends_on = [
    aws_s3_bucket_public_access_block.static_site_bucket,
    aws_s3_bucket_ownership_controls.static_site_bucket,
  ]

  bucket = aws_s3_bucket.static_site_bucket.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "static_site_bucket" {
  bucket = aws_s3_bucket.static_site_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "index.html"
  }
}

# Política que permite GET a todos os objetos
resource "aws_s3_bucket_policy" "static_site_bucket" {
  bucket = aws_s3_bucket.static_site_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${aws_s3_bucket.static_site_bucket.arn}",
          "${aws_s3_bucket.static_site_bucket.arn}/*"
        ]
      }
    ]
  })

  # Garantir que isso seja aplicado após as outras configurações
  depends_on = [
    aws_s3_bucket_public_access_block.static_site_bucket
  ]
}

# Certificado ACM (opcional, se você for usar com CloudFront)
resource "aws_acm_certificate" "cert" {
  count             = var.domain_name != "" ? 1 : 0
  domain_name       = var.domain_name
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

# CloudFront Distribution (opcional)
resource "aws_cloudfront_distribution" "cdn" {
  count = var.use_cloudfront ? 1 : 0

  origin {
    domain_name = aws_s3_bucket_website_configuration.static_site_bucket.website_endpoint
    origin_id   = "S3Origin"

    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases = var.domain_name != "" ? [var.domain_name] : []

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "S3Origin"

    forwarded_values {
      query_string = false
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400
  }

  # Suporte a SPAs redirecionando erros para index.html
  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  viewer_certificate {
    acm_certificate_arn            = var.domain_name != "" ? aws_acm_certificate.cert[0].arn : null
    ssl_support_method             = var.domain_name != "" ? "sni-only" : null
    minimum_protocol_version       = "TLSv1.2_2021"
    cloudfront_default_certificate = var.domain_name == "" ? true : false
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}
