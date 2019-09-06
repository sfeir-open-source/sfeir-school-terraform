variable "gcp_project" {
  default = "foo"
}

module "my-sql-instance" {
  source        = "./sql-database"
  instance_name = "demo-instance"
  gcp_project   = var.gcp_project
}
