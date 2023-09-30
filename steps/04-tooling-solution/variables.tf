variable "allowed_config" {
  type = list(map)
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

