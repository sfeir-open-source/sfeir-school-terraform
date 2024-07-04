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

And download the latest version using (must be at least 1.6.0 for testing features):

```shell
curl https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip -o /tmp/terraform_${TF_VERSION}_linux_amd64.zip
unzip /tmp/terraform_${TF_VERSION}_linux_amd64.zip -d $HOME/bin
bash -l
```

### Configuration

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
```shell
git clone https://github.com/sfeir-open-source/sfeir-school-terraform.git
```

Go in `steps/02-installation-solution/`

Initialize a new terraform environment and deploy the infrastructure :

```shell
terraform init
terraform apply
```

Result should be

```text
null_resource.check-version: Creating...
null_resource.check-version: Creation complete after 0s [id=3277091548522954865]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

message = "Hello World"
```

Generate the dependency graph :

```shell
terraform graph -draw-cycles | dot -Tpng > graph.png
```

You can view the result with the "Editor" (Click on "Open Editor" of the Cloud Shell).
