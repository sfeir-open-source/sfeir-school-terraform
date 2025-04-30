module "my_sql_instance" {
  source        = "./modules/sql-database"
  #source        = "git::https://github.com/Ameausoone/terraform-google-sql-instance-lab?ref=v1.0.0"
  instance_name = "demo-instance-ame"
}
