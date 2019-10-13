# Sfeir Institute Terraform
## Extend Terraform by writing new providers
### Golang
Terraform is written in [Golang](https://golang.org/) and provides a compiled binary.
Check more details about how terraform works on [https://www.terraform.io/docs/extend/how-terraform-works.html#discovery](https://www.terraform.io/docs/extend/how-terraform-works.html#discovery)

Golang is already installed on [Cloud SHell](https://cloud.google.com/shell). Refer to [official documentation](https://golang.org/doc/install) if you want to install it locally.


### Use-case
Create a new terraform provider to create a file in `path` with the content `Hello ...` where name is a resource argument.

Usage : 
```
provider "hello" {
  nickname = "jnu"
}

resource "hello_file" "foo" {
  path = "/tmp/foo"
  name = "world"
}
```

And the result produce a file in `path = /tmp/foo` with the content `Hello <name>, i'm <nickname>@<hostname>`

### Add provider content
- Update the `providerConfigure` function in `provider.go` to add the `hostname` value in the provider informations 
- Update the `resourceHelloFile` function in `resource_file.go` to create the 2 arguments `name` and `path` in the schema configuration.
- Update the `resourceHelloFile` to add the code for each step functions.

### How to build
Update `GOPATH` environment variable to add the skeleton folder for this provider : 
```
$ export GOPATH=$GOPATH:$(pwd)
```

Download dependencies and compile the provider.
```
$ cd src/terraform-provider-hello/      
$ go get -v .
$ go build .
```

Put the binary generated in the `test` folder and run `terraform init`.
