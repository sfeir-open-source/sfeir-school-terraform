# Sfeir Institute Terraform

## Module 2 Installation and Configuration

### Installation

#### Cloud Shell Integration

Open [Google Cloud Console](https://console.cloud.google.com), select the good Google project created for the lab and click to open a new [Google Cloud Shell](https://cloud.google.com/shell/).

![cloud shell wizard](https://cloud.google.com/shell/docs/images/shellstart-update.gif)

Wait few seconds during the provisioning of the instance.

In the Cloud Shell, check the Terraform version :

```shell
terraform version
```

#### Upgrade

Compare Cloud Shell version with the latest version available :

```shell
export TF_VERSION=$(curl -s https://checkpoint-api.hashicorp.com/v1/check/terraform | jq -r -M '.current_version')
echo $TF_VERSION
```

And download the latest version using :

```shell
curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/terraform_${TF_VERSION}_linux_amd64.zip
sudo unzip /tmp/terraform_${TF_VERSION}_linux_amd64.zip -d /usr/bin/
```

Notes : It's recommended to keep old Terraform version because the version is saved in state file you will see later.
You can keep multiples versions of terraform using different binaries with the suffix "version".

Exemple :

```shell
$ ls -all /usr/local/bin/terraform*
lrwxrwxrwx 1 root     root           17 mai   10 14:52 /usr/local/bin/terraform -> terraform_0.11.13
-rwxrwxr-x 1 jnahelou jnahelou 53293024 août  30  2017 /usr/local/bin/terraform_0.10.3
-rwxrwxr-x 1 jnahelou jnahelou 89397536 oct.  23  2018 /usr/local/bin/terraform_0.11.10
-rwxrwxr-x 1 jnahelou jnahelou 86015168 mars  12 19:37 /usr/local/bin/terraform_0.11.13
-rwxrwxr-x 1 jnahelou jnahelou 37858048 mai   16 22:43 /usr/local/bin/terraform_0.11.14
-rwxrwxr-x 1 jnahelou jnahelou 69233984 janv. 31  2018 /usr/local/bin/terraform_0.11.3
-rwxr-xr-x 1 jnahelou jnahelou 49191072 juin  24 22:10 /usr/local/bin/terraform_0.12.3
-rwxr-xr-x 1 jnahelou jnahelou 49007328 août  22 22:00 /usr/local/bin/terraform_0.12.7
```

### Configuration

#### Cache Terraform providers

Create a `.terraformrc` in your home directory with the following content :

```text
plugin_cache_dir   = "$HOME/.terraform.d/plugin-cache"
```

Don't forget to create the plugin-cache dir if necessary : `mkdir -p $HOME/.terraform.d/plugin-cache`

Terraform will cache providers in a central directory instead of in each workspace.
If Terraform can hit the plugin, it will copy it instead of download it.

All configurations can be found on : [https://www.terraform.io/docs/commands/cli-config.html](https://www.terraform.io/docs/commands/cli-config.html)

### Verification

Clone this repository on the Cloud Shell.
```shell
git clone https://github.com/sfeir-open-source/sfeir-school-terraform.git
``` 

Go in `steps/02-installation-solution/`

Initialize a new terraform workspace and deploy the infrastructure :

```shell
terraform init
terraform apply
```

Result should be

```text
null_resource.check-version: Creation complete after 0s (ID: 2069855020914050742)

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

message = Hello World
```

Generate the dependency graph :

```shell
terraform graph -draw-cycles | dot -Tpng > graph.png
```
