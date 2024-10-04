variable "availability_zone" {
  type        = string
  description = "AWS availability zone"
  default = "eu-west-1a"
}

variable "instance_name" {
  type        = string
  description = "AWS Instance name"
  default = "myinstance"
}