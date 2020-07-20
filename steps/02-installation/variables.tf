provider "null" {}

variable "image" {
  type = list
  default = [
    "ubuntu",
    "debian",
    "windows",
    "archlinux",
    "macos"
  ]
}
