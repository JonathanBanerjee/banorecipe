terraform {
  backend "s3" {
    bucket                  = "terraform-state-042499953055"
    key                     = "banorecipe/certificates"
    region                  = "eu-west-1"
    dynamodb_table          = "terraform-state"
    shared_credentials_file = "~/.aws/credentials"
    profile                 = "XXXXXXXX"
  }
}

provider "aws" {
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "XXXXXXXX"
  region                   = "eu-west-2"
}

provider "aws" {
  alias = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "XXXXXXXX"
  region                   = "us-east-1"
}