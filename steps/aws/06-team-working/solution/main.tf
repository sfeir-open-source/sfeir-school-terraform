module my-app-instance {
    source = "./modules/myschoolapp-module"
    my_app_env = "development"
    ec2_instance_count = 2
    rds_instance_size = 20
    rds_instance_id = "cdarcymysqldb"
    rds_instance_user = "cdarcy"
    rds_instance_password = "cdarcy_mysqldb_61672"
}