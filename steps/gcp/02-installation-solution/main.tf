resource "terraform_data" "check-version" {
  triggers_replace = "Hello World"
}

output "message" {
  description = "A message to display"
  value       = terraform_data.check-version.triggers_replace
}
