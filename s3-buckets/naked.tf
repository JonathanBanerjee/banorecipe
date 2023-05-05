resource "aws_s3_bucket" "naked" {
  bucket = local.domain
}

resource "aws_s3_bucket_website_configuration" "naked" {
  bucket = aws_s3_bucket.naked.id

  redirect_all_requests_to {
    host_name = "www.${local.domain}"
  }
}