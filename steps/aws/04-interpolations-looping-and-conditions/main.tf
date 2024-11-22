terraform {
  required_version = ">= 0.12.0"
}

resource "aws_s3_bucket" "config_bucket" {
  bucket     = var.bucket_name
}

## Since 0.12
resource "aws_s3_object" "for_each_bucket" {
  // Put all files contained in var.files in AWS S3 using for_each (add -for suffix in the file name)
  for_each = var.files
}

## Before 0.12
resource "aws_s3_object" "count_bucket" {
  // Put all files contained in var.files in AWS S3 using count (add -count suffix in the file name)
  count   = length(keys(var.files))
}
