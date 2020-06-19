output "instance_ip" {
  description = "Instance IP allocated by Google"
  value       = google_compute_instance.tf_instance.network_interface[0].network_ip
}

