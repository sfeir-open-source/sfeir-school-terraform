variable "allowed_config" {
  type = list
  default = [
    {
      ports    = ["53"]
      protocol = "TCP"
    },
    {
      ports    = ["53"]
      protocol = "UDP"
    }
  ]
}
