resource "null_resource" "check-version" {
  triggers = {
    message = "Hello World"
  }
}

output "message" {
  description = "A message to display"
  value       = null_resource.check-version.triggers.message
}

