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