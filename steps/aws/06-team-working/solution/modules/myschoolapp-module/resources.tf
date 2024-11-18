# Define the RDS instance resource
resource "aws_db_instance" "myschoolapp_db" {
  identifier                = var.rds_instance_id
  username                  = var.rds_instance_user
  password                  = var.rds_instance_password
  engine                    = var.rds_instance_engine
  engine_version            = var.rds_instance_version
  instance_class            = var.rds_instance_class
  allocated_storage         = var.rds_instance_size
  skip_final_snapshot      = true
  db_subnet_group_name      = aws_db_subnet_group.myschoolapp_db_subnet_group.name

  # Enable deletion protection to prevent accidental deletion
  deletion_protection = false

  # Configure tags for the RDS instance
  tags = {
    Name = "MySchoolApp RDS Instance for ${var.my_app_env} environment"
  }
}

# Define the DB Subnet Group resource
resource "aws_db_subnet_group" "myschoolapp_db_subnet_group" {
  name       = "${var.rds_instance_id}-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "MySchoolApp RDS Subnet Group for ${var.my_app_env} environment"
  }
}

# Define a security group that allows inbound traffic on the database port
resource "aws_security_group" "allow_db_traffic" {
  name = "allow_db_traffic"
  description = "Allow inbound traffic on the database port"
  vpc_id = data.aws_vpc.default.id

  ingress {
    from_port = var.rds_instance_port
    to_port = var.rds_instance_port
    protocol = "tcp"
    cidr_blocks = [data.aws_vpc.default.cidr_block]
  }

#   egress {
#     from_port = 0
#     to_port = 0
#     protocol = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

  tags = {
    Name = "MySchoolApp DB Traffic SG for ${var.my_app_env} environment"
  }
}

# Define the EC2 instance resource
resource "aws_instance" "myschoolapp_compute" {
  count = var.ec2_instance_count
  ami = var.ec2_instance_ami_id
  instance_type = var.ec2_instance_class
  subnet_id = element(data.aws_subnets.default.ids, 0) # Use the first subnet in the list
  vpc_security_group_ids = [aws_security_group.allow_db_traffic.id]

  tags = {
    Name = "MySchoolApp EC2 Instance for ${var.my_app_env} environment"
  }
}