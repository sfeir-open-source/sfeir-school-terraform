variable "instance_name" {
  description = "The name of the instance."
}

variable "username" {
  description = "The name of the user."
  default     = "demo-user"
}

variable "region" {
  description = "The region the instance will sit in."
  default     = "europe-west1"
}

variable "database_version" {
  description = "The MySQL or PostgreSQL version to use."
  default     = "MYSQL_5_7"
}
