# SSH connection command to connect to the instance
output "ssh_connection_command" {
  value = "ssh -i ${local_file.private_key_pem.filename} ubuntu@${aws_instance.my_instance.public_ip}"
}