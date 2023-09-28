variable "bucket_name" {
  type        = string
  description = "Name of the GCS bucket"
}

variable "files" {
  type        = map(string)
  description = "Map of files to create where key is filename and value is content"

  default = {
    ## should be added after a first "apply"
    # "config-pp"   = "env = pp"
    "config-prod" = "env = prod"
    "config-dev"  = "env = dev"
  }
}

