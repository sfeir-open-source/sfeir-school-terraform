# Sfeir Institute Terraform

## Module-3a: First Infrastructure Deployment

### Provider configuration

Documentation for the official Terraform AWS provider can be found on [the terraform's registry website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

Depending on where you are running terraform, the provider needs AWS credentials to access the AWS Cloud (see Step "Installation" README).

### Your first AWS EC2 instance

Create a new AWS instance in a new subnet located in a new VPC (CIDR=10.0.0.0/16) using the following settings :

| Property | Value |
| - | - |
| Name | First Instance |
| Zone | eu-west-1a |
| Machine | t2.micro |
| Image | Last ubuntu server 22.04 LTS amd64 |
| Subnet | 10.0.1.0/24 |

Tip : To configure the Amazon Machine Image on the instance, you will have to use a datasource object to get the AMI's id. You can search in the AWS console's AMI catalog to get the AMI name to configure the datasource.

Instance name should be prompted to user using variable (see variables.tf). Please use your name as instance name to avoid name clash with other participants.

To find all resource attributes, you can search in the aws provider's documentation by following the link provided above.

Using `terraform init`, terraform will automatically download the [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) require to deploy the infrastructure on Google Cloud Platform.

Run a `terraform plan` to view changes.
If changes are correct, use `terraform apply` to deploy resources.


### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by Terraform
