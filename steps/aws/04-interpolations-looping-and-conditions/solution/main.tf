terraform {
  required_version = ">= 0.12"
}

resource "aws_s3_bucket" "config_bucket" {
  bucket     = var.bucket_name
}

resource "aws_s3_bucket_versioning" "example" {
  bucket = aws_s3_bucket.config_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

## Since 0.12
resource "aws_s3_object" "for_each_bucket" {
  // Put all files contained in var.files in AWS S3 using for_each (add -for suffix in the file name)
  for_each = var.files
  key     = format("%s-for", lower(each.key))
  content  = each.value
  bucket   = aws_s3_bucket.config_bucket.id
}

## Before 0.12
resource "aws_s3_object" "count_bucket" {
  // Put all files contained in var.files in cloud storage using count (add -count suffix in the file name)
  count   = length(keys(var.files))
  key     = format("%s-count", element(keys(var.files), count.index))
  content  = var.files[element(keys(var.files), count.index)]
  bucket   = aws_s3_bucket.config_bucket.id
}

