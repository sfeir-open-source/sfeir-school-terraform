## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.myschoolapp_db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_ec2_instance_connect_endpoint.myeice](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_connect_endpoint) | resource |
| [aws_instance.myschoolapp_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_security_group.db_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ec2_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ec2_managed_prefix_list.ec2_instance_connect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ec2_managed_prefix_list) | data source |
| [aws_subnets.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnets) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ec2_instance_ami_id"></a> [ec2\_instance\_ami\_id](#input\_ec2\_instance\_ami\_id) | The ID of the AMI to use for the EC2 instance | `string` | `"ami-0fcc0bef51bad3cb2"` | no |
| <a name="input_ec2_instance_class"></a> [ec2\_instance\_class](#input\_ec2\_instance\_class) | The instance type to use for the EC2 instance | `string` | `"t2.micro"` | no |
| <a name="input_ec2_instance_count"></a> [ec2\_instance\_count](#input\_ec2\_instance\_count) | The number of EC2 instances to be deployed | `number` | `1` | no |
| <a name="input_my_app_env"></a> [my\_app\_env](#input\_my\_app\_env) | The current environment name for My App | `string` | n/a | yes |
| <a name="input_rds_instance_class"></a> [rds\_instance\_class](#input\_rds\_instance\_class) | The instance class to use for the RDS instance | `string` | `"db.t3.micro"` | no |
| <a name="input_rds_instance_engine"></a> [rds\_instance\_engine](#input\_rds\_instance\_engine) | The database engine to use | `string` | `"mysql"` | no |
| <a name="input_rds_instance_id"></a> [rds\_instance\_id](#input\_rds\_instance\_id) | The unique identifier for the RDS instance | `string` | n/a | yes |
| <a name="input_rds_instance_password"></a> [rds\_instance\_password](#input\_rds\_instance\_password) | The master password for the RDS instance | `string` | n/a | yes |
| <a name="input_rds_instance_port"></a> [rds\_instance\_port](#input\_rds\_instance\_port) | Port number to access the RDS Database | `number` | `3306` | no |
| <a name="input_rds_instance_size"></a> [rds\_instance\_size](#input\_rds\_instance\_size) | The amount of storage (in gigabytes) to allocate for the RDS instance | `number` | `50` | no |
| <a name="input_rds_instance_user"></a> [rds\_instance\_user](#input\_rds\_instance\_user) | The master username for the RDS instance | `string` | n/a | yes |
| <a name="input_rds_instance_version"></a> [rds\_instance\_version](#input\_rds\_instance\_version) | The version of the database engine to use | `string` | `"8.0.39"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_myschoolapp_instance_dbendpoint"></a> [myschoolapp\_instance\_dbendpoint](#output\_myschoolapp\_instance\_dbendpoint) | n/a |
