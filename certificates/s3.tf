data "aws_s3_bucket" "www" {
  bucket = "${local.domain}"
}