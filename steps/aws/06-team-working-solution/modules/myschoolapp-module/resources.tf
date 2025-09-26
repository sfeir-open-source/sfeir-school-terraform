locals {
  myschoolapp_subnet = element(data.aws_subnets.default.ids, 0) # Use the first subnet in the list
}

# Define a security group that allows inbound traffic on the database port
resource "aws_security_group" "db_security_group" {

  name        = "db_security_group"
  description = "Allow inbound traffic on the database port"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port       = var.rds_instance_port
    to_port         = var.rds_instance_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_security_group.id]
  }

  tags = {
    Name = "MySchoolApp DB Traffic SG for ${var.my_app_env} environment"
  }
}

# Define a security group for EC2 instances
resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "Allow inbound traffic on the SSH port for EC2 instance connect"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    self      = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MySchoolApp EC2 Traffic SG for ${var.my_app_env} environment"
  }
}

# Define the RDS instance resource
resource "aws_db_instance" "myschoolapp_db" {
  identifier             = var.rds_instance_id
  username               = var.rds_instance_user
  password               = var.rds_instance_password
  engine                 = var.rds_instance_engine
  engine_version         = var.rds_instance_version
  instance_class         = var.rds_instance_class
  allocated_storage      = var.rds_instance_size
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.db_security_group.id]

  # Enable deletion protection to prevent accidental deletion
  deletion_protection = false

  # Configure tags for the RDS instance
  tags = {
    Name = "MySchoolApp RDS Instance for ${var.my_app_env} environment"
  }
}

# Define the EC2 instance resource
resource "aws_instance" "myschoolapp_instance" {
  count                  = var.ec2_instance_count
  ami                    = var.ec2_instance_ami_id
  instance_type          = var.ec2_instance_class
  subnet_id              = local.myschoolapp_subnet
  vpc_security_group_ids = [aws_security_group.ec2_security_group.id]

  tags = {
    Name = "MySchoolApp EC2 Instance for ${var.my_app_env} environment"
  }
}

resource "aws_ec2_instance_connect_endpoint" "myeice" {
  subnet_id          = local.myschoolapp_subnet
  security_group_ids = [aws_security_group.ec2_security_group.id]
}