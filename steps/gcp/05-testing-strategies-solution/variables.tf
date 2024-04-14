variable "name" {
  type        = string
  description = "Name of the GCS bucket"

  validation {
    condition = can(regex("^[a-z]+$", var.name))
    error_message = "Bucket name is invalid: must contain only letters"
  }

  validation {
    condition =length(var.name) >= 3
    error_message = "Bucket name is too short."
  }
}

variable "prefix" {
  type        = string
  description = "Prefix of the GCS bucket name"

  validation {
    condition = can(regex("^[a-z]+$", var.prefix))
    error_message = "Bucket prefix is invalid: must contain only letters"
  }

  validation {
    condition = length(var.prefix) >= 3
    error_message = "Bucket prefix is too short."
  }

  validation {
    condition =  length(var.prefix) <= 8
    error_message = "Bucket prefix is too long."
  }
}
