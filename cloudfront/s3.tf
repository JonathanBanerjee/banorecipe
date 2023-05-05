data "aws_s3_bucket" "www" {
  bucket = "www.${local.domain}"
}