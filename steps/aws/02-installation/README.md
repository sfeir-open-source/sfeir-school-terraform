# Sfeir Institute Terraform

## Module 2 Installation and Configuration

### Prerequisites

#### Set up an AWS account

Prior your training you should have [configured an AWS account](https://repost.aws/fr/knowledge-center/create-and-activate-aws-account)

This account is necessary to complete the labs steps with Free Tier usage. 

:warning: These labs should not incur supplementary fees if you delete all the resources at each end of every workshop with the *terraform destroy* command. 

### Installation

#### Install in Cloud Shell Console

Open the AWS Cloud Shell Console and wait a few seconds in order to have your environment set up. 

Cloud Shell provides an integrated terminal where you can execute commands and persist files in the *$HOME* directory that will be kept between sessions. You do not need to use Access Key / Secret Access Key as the CloudShell is running as your AWS Management Console user/role. 

We will use tenv, the terraform version manager to install the latest version of terraform in your home directory.

First, clone tfenv project and make a symlink to include the script bin in your *$PATH* :

```console
$  curl -L https://github.com/tofuutils/tenv/releases/download/v1.7.1/tenv_v1.7.1_386.rpm -o tenv_v1.7.1_386.rpm && sudo yum install tenv_v1.7.1_386.rpm -y && rm tenv_v1.7.1_386.rpm
```

Then, install terraform latest version using *tenv install* command (tenv can also be used to install opentofu, the forked version of terraform):

```console
$ tenv tf install
No version files found for Terraform, fallback to latest strategy
Fetching all releases information from https://releases.hashicorp.com/terraform/index.json
Found compatible version remotely : 1.8.0
Installing Terraform 1.8.0
Fetching release information from https://releases.hashicorp.com/terraform/1.8.0/index.json
Downloading https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_linux_386.zip
Downloading https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_SHA256SUMS
Downloading https://releases.hashicorp.com/terraform/1.8.0/terraform_1.8.0_SHA256SUMS.sig
Downloading https://www.hashicorp.com/.well-known/pgp-key.txt
Installation of Terraform 1.8.0 successful

$ terraform -version
Terraform v1.8.0
on linux_386
```

#### Install on your own laptop

If you prefer installing it manually on your own laptop, follow [the instructions from HashiCorp website](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli) depending on your OS

To deploy resources on AWS, you will need to authenticate to the cloud provider using an AWS access key and a secret key. To set up those, go in your security credentials one logged in on the AWS UI by clicking on your username in the top right hand corner > Security Credentials.

Then, scroll down to Access keys and create and access key for your laptop. 

Set up these credentials as environment variables so that you can authenticate with :

```console
$ export AWS_ACCESS_KEY_ID=YOURAWSACCESSKEYID
$ export AWS_SECRET_ACCESS_KEY=YOURAWSSECRETACCESSKEY
```
Or you can use the AWS cli to configure your credentials.
Prior to configure your credentials, you will have to install the [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
After the installation you can use
```console
aws configure
```

You will be prompted to fill out your Access Key ID and AWS Secret Access Key. You can also set the default AWS region.

### Configuration 

#### Setting the default region

For all the labs, the eu-west-1 region will be used. In AWS UI, choose  "EU (Ireland)" as your default region in the top right hand corner.

In the Cloud Console or on your laptop, set the proper environment variable to configure the default region for your AWS CLI session :

```console
$ export AWS_DEFAULT_REGION=eu-west-1
```
You can set the default region when you configure your credentials with `aws configure`

#### Cache Terraform providers

Create a `.terraformrc` in your home directory with the following content :

```text
plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
```

Don't forget to create the plugin-cache dir if necessary : `mkdir -p $HOME/.terraform.d/plugin-cache`

Terraform will cache providers in a global directory instead of in each workspace.
If Terraform can hit the plugin, it will link it instead of downloading it.

All configurations can be found on : [https://www.terraform.io/docs/commands/cli-config.html](https://www.terraform.io/docs/commands/cli-config.html)

### Verification

Clone this repository on the Cloud Shell.
```console
$ git clone https://github.com/sfeir-open-source/sfeir-school-terraform.git
```

Go in `steps/02-installation-solution/`

Initialize a new terraform environment and deploy the infrastructure :

```console
$ terraform init
$ terraform apply
```

Result should be

```console
null_resource.check-version: Creating...
null_resource.check-version: Creation complete after 0s [id=3277091548522954865]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

message = "Hello World"
```

