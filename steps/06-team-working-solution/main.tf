module "my-sql-instance" {
  # source        = "./modules/sql-database"
  source        = "git::https://gitlab.com/alex.dath/terraform-google-sql-instance?ref=v2.0.0"
  instance_name = "demo-instance"
}

