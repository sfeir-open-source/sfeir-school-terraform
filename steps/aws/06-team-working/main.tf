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
    rds_instance_id = "<yourinstanceid>"
    rds_instance_user = "<yourdbuser>"
    rds_instance_password = "<yourdbsecretpassword>"
}
