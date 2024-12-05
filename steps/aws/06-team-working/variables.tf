
variable "rds_dbuser" {
  # configure eternally through a secret or an environment variable, eg.
  # export TF_rds_dbuser="youruser"
  sensitive = true
}

variable "rds_dbpassword" {
  # configure eternally through a secret or an environment variable, eg.
  # export TF_rds_dbpassword="yourpassword" 
  sensitive = true
}