data "aws_acm_certificate" "star" {
  domain   = local.domain
  provider = aws.us-east-1
}