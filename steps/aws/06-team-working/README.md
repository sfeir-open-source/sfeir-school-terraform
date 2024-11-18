# Sfeir Institute Terraform

## Module 6 - Team Working

### Objective

In this lab, you will have to build your first terraform module to deploy an entire environment for your app MySchoolApp. The application will use a configurable number (*instance_count*) of AWS EC2 instances, of class *ec2_instance_class*, that will need to access an AWS RDS database, with engine *rds_instance_engine* and version *rds_instance_version*. 

The module must be configurable through the following settings :
| Property | Default Value | Configured Value |
| - | - | - |
| my_app_env | - | development | 
| ec2_instance_count | 1 | 2 | 
| ec2_instance_class | t2.micro | t2.micro  | 
| ec2_instance_ami_id | ami-046b5b8111c19b3ac | ami-046b5b8111c19b3ac  | 
| rds_instance_engine | mysql | mysql | 
| rds_instance_version | 8.0.28 | mysql | 
| rds_instance_size | 50G | 20G |
| rds_instance_class | db.t3.micro | db.t3.micro |
| rds_instance_id | - | <your name>_mysqldb |
| rds_instance_user | - | <your name> (sensitive) |
| rds_instance_password | - | <your password> (sensitive) |
| rds_instance_port | 3306 | 3306 |

To simplify the module, the deployment will only use the default VPC of your AWS account and all resources will be in the default subnet (see datasources.tf). Other resources in your module may be needed to deploy main components (AMI, Security Group...). Note that the DB instance port will have to be opened in the instance security group.


