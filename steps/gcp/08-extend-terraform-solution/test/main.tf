terraform {
  required_providers {
    hello = {
      source = "sfeir/hello"
    }
  }
}

provider "hello" {
  nickname = "jnu"
}

resource "hello_file" "foo" {
  path = "/tmp/foo"
  name = "world"
}
