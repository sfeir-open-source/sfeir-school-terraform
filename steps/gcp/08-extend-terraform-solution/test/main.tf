provider "hello" {
  nickname = "jnu"
}

resource "hello_file" "foo" {
  path = "/tmp/foo"
  name = "world"
}
