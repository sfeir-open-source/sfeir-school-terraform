# Sfeir Institute Terraform

## Module 2 First steps

### Installation

Download the latest version using :

```shell
curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/terraform_${TF_VERSION}_linux_amd64.zip
```

Then unzip & install :

```shell
sudo unzip /tmp/terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin/
```

### Commands discovery
Clone this repository on the Cloud Shell.

### Init
```
terraform init
```


### Console

Launch the console and test some instructions

```shell
terraform console
element(var.image, 3)
format("image %s", element(var.image, 3))
```

Result should be

```text
null_resource.check-version: Creation complete after 0s (ID: 2069855020914050742)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

message = Hello World

archlinux

reverse(var.image)
[
  "macos",
  "archlinux",
  "windows",
  "debian",
  "ubuntu",
]

image archlinux
```


