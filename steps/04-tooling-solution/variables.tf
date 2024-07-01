variable "allowed_config" {
  type = list(object({
    ports    = list(string)
    protocol = string
  }))

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
