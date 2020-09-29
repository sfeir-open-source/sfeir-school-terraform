variable "bar" {
  type = string
}

resource "null_resource" "foo" {
  triggers = {
    foo = var.bar
  }
  provisioner "local-exec" {
    command = "python --version && python3 --version"
    when    = "destroy"
  }
}

output "bar" {
  value = null_resource.foo.triggers.foo
}

