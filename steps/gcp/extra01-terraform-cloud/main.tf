variable "bar" {
  type = string
}

resource "terraform_data" "foo" {
  triggers_replace = var.bar

  provisioner "local-exec" {
    command = "python --version && python3 --version"
    when    = destroy
  }
}

output "bar" {
  value = terraform_data.foo.triggers_replace
}
