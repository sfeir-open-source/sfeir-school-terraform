# Get the default VPC ID
data "aws_vpc" "default" {
  default = true
}

# Get the default subnet IDs in the default VPC
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# Get EC2 instance connect prefix list
data "aws_ec2_managed_prefix_list" "ec2_instance_connect" {
  filter {
    name   = "owner-id"
    values = ["AWS"]
  }

  filter {
    name   = "prefix-list-name"
    values = ["com.amazonaws.eu-west-1.ec2-instance-connect"]
  }
}