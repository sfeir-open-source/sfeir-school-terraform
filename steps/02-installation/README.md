# Sfeir Institute Terraform

## Module 2 First steps

### Installation
Install Terraform by any means you want.
Download the latest version, unzip and install :

```shell
curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/terraform_${TF_VERSION}_linux_amd64.zip
sudo unzip /tmp/terraform_${TF_VERSION}_linux_amd64.zip -d /usr/local/bin/
```

Or install tfenv

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

### Root module

Create a root module with four different resources for the Cloud Provider of your choice (among AWS, Azure, GCP, DigitalOcean).
