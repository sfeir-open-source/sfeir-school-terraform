terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.77.0"
    }
  }
}

module my-app-instance {
    source = "./modules/myschoolapp-module"
    my_app_env = "development"
    ec2_instance_count = 2
    rds_instance_size = 20
    rds_instance_id = "mysqldb"
    rds_instance_user = var.rds_dbuser
    rds_instance_password = var.rds_dbpassword
}
