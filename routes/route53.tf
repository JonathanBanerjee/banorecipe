resource "aws_route53_zone" "blog" {
  name = local.domain
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.blog.zone_id
  name    = "www.${local.domain}"
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.blog.domain_name
    zone_id                = data.aws_cloudfront_distribution.blog.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "naked" {
  zone_id = aws_route53_zone.blog.zone_id
  name    = local.domain
  type    = "A"

  alias {
    name                   = data.aws_s3_bucket.naked.website_domain
    zone_id                = data.aws_s3_bucket.naked.hosted_zone_id
    evaluate_target_health = false
  }
}