resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "access-blog"
  description                       = "Access the blog"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "blog" {
  origin {
    domain_name              = data.aws_s3_bucket.www.bucket_regional_domain_name
    origin_id                = data.aws_s3_bucket.www.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_root_object = "index.html"
  aliases             = ["www.${local.domain}", local.domain]
  price_class         = "PriceClass_100"

  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = data.aws_s3_bucket.www.bucket_regional_domain_name
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.star.arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }
}