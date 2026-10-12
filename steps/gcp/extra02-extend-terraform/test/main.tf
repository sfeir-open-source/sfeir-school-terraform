terraform {
  required_providers {
    hello = {
      source = "sfeir/hello"
    }
  }
}

provider "hello" {
  // Add provider attributes
}

resource "hello_file" "foo" {
  // Add resources attributes
}
