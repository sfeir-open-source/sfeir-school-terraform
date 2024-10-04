# Sfeir Institute Terraform

## Module-3a: First Infrastructure Deployment

### Provider configuration

Official Terraform AWS provider documentation can be found on [the terraform's registry website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs).

Depending on where you are running terraform, the provider needs AWS credentials to access the AWS Cloud (see Step "Installation" README).

### Your first AWS EC2 instance (aws_instance)

Create a simple AWS instance located in the default VPC, using the following settings :

| Property | Value |
| - | - |
| Name | First Instance |
| Zone | eu-west-1a |
| Machine | t2.micro |
| Image | Last ubuntu server 22.04 LTS amd64 |
| Public IP address | Yes |


Tip : To configure the Amazon Machine Image on the instance, you will have to use a datasource to get the AMI's id. You can search in the AWS console's AMI catalog to get the AMI name to configure the datasource.

To find all resource attributes, you can search in the aws provider's documentation by following the link provided above.


### Allow SSH access to your first instance (aws_security_group)

In order to connect to your instance remotely with SSH, create an *aws_security_group* resource that will allow inbound SSH access on port 22 to your instance. Associate the newly created security group to your *aws_instance*. 

To connect to your instance, you will have to use an *aws_key_pair* resource bound to your aws_instance. Save the private key file locally to use it to connect to your instance (see *local_file* resource type to do that)

### Deploy

Using `terraform init`, terraform will automatically download the [terraform-provider-aws](https://github.com/hashicorp/terraform-provider-aws) required to deploy the infrastructure on Amazon Web Services cloud.

Run a `terraform plan` to view changes.
If changes are correct, use `terraform apply` to deploy resources.

### Result

After executing your deployment, all your resources should be up and functional. Your AWS instance should be accessible through SSH from your public IP. 

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by Terraform
