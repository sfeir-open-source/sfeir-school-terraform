variable "instance_name" {
  type        = string
  description = "The name of the instance."
}

variable "username" {
  type        = string
  description = "The name of the user."
  default     = "demo-user"
}

variable "region" {
  type        = string
  description = "The region the instance will sit in."
  default     = "europe-west1"
}

variable "database_version" {
  type        = string
  description = "The MySQL or PostgreSQL version to use."
  default     = "MYSQL_5_7"
}
