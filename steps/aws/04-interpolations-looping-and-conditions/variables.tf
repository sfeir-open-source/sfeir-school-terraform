variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
  default = "mybucket"
}

variable "files" {
  type        = map(string)
  description = "Map of files to create where key is filename and value is file content"

  default = {
    # "filename" = "file_content"
    # "config-pp"   = "env = pp"  ## should be added after a first "apply"
    "config-prod" = "env = prod"
    "config-dev"  = "env = dev"
  }
}
