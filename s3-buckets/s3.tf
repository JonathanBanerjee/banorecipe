resource "aws_s3_bucket" "www" {
  bucket = "www.${local.domain}"
}

resource "aws_s3_bucket_versioning" "www" {
  bucket = aws_s3_bucket.www.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_website_configuration" "www" {
  bucket = aws_s3_bucket.www.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "www" {
  bucket = aws_s3_bucket.www.id

  rule {
    bucket_key_enabled = false

    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_acl" "www" {
  bucket = aws_s3_bucket.www.id

  acl = "public-read"
}

data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = ["${aws_s3_bucket.www.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }
}

resource "aws_s3_bucket_policy" "allow_access_from_other_accounts" {
  bucket = aws_s3_bucket.www.id

  policy = data.aws_iam_policy_document.bucket_policy.json
}