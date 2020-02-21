module "my-sql-instance" {
  source        = "./sql-database"
  instance_name = "demo-instance"
  gcp_project   = var.gcp_project
}

