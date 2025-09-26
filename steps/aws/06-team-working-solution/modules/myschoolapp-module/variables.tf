# Global variables
variable "my_app_env" {
  type        = string
  description = "The current environment name for My App"
  nullable    = false
}

# Define variables for the RDS instance
variable "rds_instance_id" {
  type        = string
  description = "The unique identifier for the RDS instance"
  nullable    = false
}

variable "rds_instance_user" {
  type        = string
  description = "The master username for the RDS instance"
  sensitive   = true
  nullable    = false
}

variable "rds_instance_password" {
  type        = string
  description = "The master password for the RDS instance"
  sensitive   = true
  nullable    = false
}

variable "rds_instance_engine" {
  type        = string
  description = "The database engine to use"
  default     = "mysql"
}

variable "rds_instance_version" {
  type        = string
  description = "The version of the database engine to use"
  default     = "8.0.39"
}

variable "rds_instance_class" {
  type        = string
  description = "The instance class to use for the RDS instance"
  default     = "db.t3.micro"
}

variable "rds_instance_size" {
  type        = number
  description = "The amount of storage (in gigabytes) to allocate for the RDS instance"
  default     = 50
}

variable "rds_instance_port" {
  type        = number
  description = "Port number to access the RDS Database"
  default     = 3306
}

# Define variables for the EC2 instance
variable "ec2_instance_count" {
  type        = number
  description = "The number of EC2 instances to be deployed"
  default     = 1
}

variable "ec2_instance_class" {
  type        = string
  description = "The instance type to use for the EC2 instance"
  default     = "t2.micro"
}

variable "ec2_instance_ami_id" {
  type        = string
  description = "The ID of the AMI to use for the EC2 instance"
  default     = "ami-0fcc0bef51bad3cb2"
}
