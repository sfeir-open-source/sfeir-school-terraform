
terraform {
  required_version = ">= 0.12"
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
} 

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["193.39.2.69/32"] # Be cautious with this setting - set only your public IP
  }
}

resource "aws_instance" "my_instance" {
  ami               = data.aws_ami.ubuntu.id
  instance_type     = "t2.micro"
  availability_zone = var.availability_zone

  associate_public_ip_address = true

  key_name      = aws_key_pair.my_key_pair.key_name

  security_groups = [ aws_security_group.allow_ssh.name ]

  tags = {
    Name = var.instance_name
  }
}

# Generate a new SSH key pair locally or use an existing key
resource "tls_private_key" "my_private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "my_key_pair" {
  key_name   = "my_key"
  public_key = tls_private_key.my_private_key.public_key_openssh
}

resource "local_file" "private_key_pem" {
  filename = "${path.module}/private_key.pem"
  content  = tls_private_key.my_private_key.private_key_pem
  file_permission = "0600"
}