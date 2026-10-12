# Sfeir Institute Terraform

## Extend Terraform by writing new providers

### Golang

Terraform is written in [Golang](https://golang.org/) and provides a compiled binary.
Check more details about how terraform works on [https://www.terraform.io/docs/extend/how-terraform-works.html#discovery](https://www.terraform.io/docs/extend/how-terraform-works.html#discovery).

Golang is already installed on [Cloud Shell](https://cloud.google.com/shell).
Refer to [official documentation](https://golang.org/doc/install) if you want to install it locally.

### Use-case

Create a new terraform provider to create a file in `path` with the content `Hello ...` where name is a resource argument.

Usage :

```hcl
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

- Update the `providerConfigure` function in `provider.go` to add the `hostname` value in the provider informations.
- Update the `resourceHelloFile` function in `resource_file.go` to create the 2 arguments `name` and `path` in the schema configuration.
- Update the `resourceHelloFile` to add the code for each step functions.

### How to build

The provider uses the [Terraform Plugin SDK v2](https://developer.hashicorp.com/terraform/plugin/sdkv2).

- Verify you have Go 1.21 or upper (Go downloads the toolchain required by `go.mod` automatically) :

  ```shell
  go version
  ```

- If not install or update it from [https://go.dev/dl/](https://go.dev/dl/)
- Compile the provider :

  ```shell
  cd terraform-provider-hello/
  go build
  ```

### How to test

Terraform must use your local binary instead of downloading the provider from the registry. Use [`dev_overrides`](https://developer.hashicorp.com/terraform/cli/config/config-file#development-overrides-for-provider-developers) :

- Edit `test/dev.tfrc` and set the absolute path of the `terraform-provider-hello` directory (`pwd` in this directory).
- In the `test` directory, complete `main.tf` then run :

  ```shell
  export TF_CLI_CONFIG_FILE=$PWD/dev.tfrc
  terraform plan
  terraform apply
  cat /tmp/foo
  ```

`terraform init` is not required : with `dev_overrides`, Terraform uses the local binary directly (a warning reminds you of it).

Then :

- Change `name` and apply again : the file is updated in place.
- Change `path` : the resource is replaced (`ForceNew`).
- Delete `/tmp/foo` manually and run `terraform plan` : the `Read` function detects the drift.
