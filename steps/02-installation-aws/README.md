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

We will use tfenv, the terraform version manager to install the latest version of terraform in your home directory.

First, clone tfenv project and make a symlink to include the script bin in your *$PATH* :

```console
$ git clone https://github.com/tfutils/tfenv.git ~/.tfenv
$ mkdir ~/bin && ln -s ~/.tfenv/bin/* ~/bin/
```

Then, install terraform latest version using *tfenv install* command :

```console
$ tfenv install
Installing Terraform v1.7.5
Downloading release tarball from https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip
############################################################################################################################################################################################ 100.0%
Downloading SHA hash file from https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_SHA256SUMS
Not instructed to use Local PGP (/home/cloudshell-user/.tfenv/use-{gpgv,gnupg}) & No keybase install found, skipping OpenPGP signature verification
terraform_1.7.5_linux_amd64.zip: OK
Archive:  /tmp/tfenv_download.999R9s/terraform_1.7.5_linux_amd64.zip
  inflating: /home/cloudshell-user/.tfenv/versions/1.7.5/terraform  
Installation of terraform v1.7.5 successful. To make this your default version, run 'tfenv use 1.7.5'

$ tfenv use 1.7.5
Switching default version to v1.7.5
Default version (when not overridden by .terraform-version or TFENV_TERRAFORM_VERSION) is now: 1.7.5

$ terraform -version
Terraform v1.7.5
on linux_amd64
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

### Configuration 

#### Setting the default region

For all the labs, the eu-west-1 region will be used. In AWS UI, choose  "EU (Ireland)" as your default region in the top right hand corner.

In the Cloud Console or on your laptop, set the proper environment variable to configure the default region for your AWS CLI session :

```console
$ export AWS_DEFAULT_REGION=eu-west-1
```

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
