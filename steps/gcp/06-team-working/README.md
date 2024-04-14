# Sfeir Institute Terraform

## Module 6 : Team working

### Prerequisites

If you are in a SFEIR training session, your trainer will give you information about an already provisioned Vault Cluster.

If you do the lab autonomously, feel free to create your own Vault cluster with [HashiCorp Cloud Platform](https://www.hashicorp.com/cloud). HashiCorp give free credit (50$) that allow you to create a Vault cluster without a credit card.

* Configure environment variables to use the cluser using vault CLI
```
export VAULT_ADDR=https://vault-cluster.vault.xxxx.aws.hashicorp.cloud:8200
export VAULT_NAMESPACE=admin
export VAULT_TOKEN=hvs.XXXXXXXXXXXXXXXXXXX
```

### Play with Vault CLI

Installation :

Follow [Vault installation methods](https://www.vaultproject.io/downloads) or using curl install :

```shell
export VAULT_VERSION=1.14.3
wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
sudo unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /usr/bin/
```

On MacOS, you can use : `brew install vault`

Usage example :

```shell
# Login to the vault server
export VAULT_TOKEN=hvs.XXXXXXXXXXXXXXXXXXX

# Create a key-value secret
vault kv put secret/<your_name> user=demo password=password

# Verify the written secret
vault kv get secret/<your_name>
```

##### Manage vault credentials using Terraform

In `vault-secret` directory, create a new [vault generic secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs) using [random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)

Verify the secret content using the following command (update <your_name> with the key used during secret creation) :

```shell
vault kv get secret/<your_name>
```

### Terraform Modules

A module is a collection of resources defined by inputs (variables) and results (outputs).

#### Create a new module to deploy a [Cloud SQL](https://cloud.google.com/sql) instance using Terraform

* Go to the `modules/sql-database` directory
* Deploy a MySQL 5.7 using [google_sql_database_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) resource
* Create an SQL user using [google_sql_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user)
* Create a `random_password`, assign it to the SQL user, and save it on Vault (to be used latter by an Application deployment terraform configuration)

Your Cloud SQL database module is now ready to be used in the parent resource ! Let's do this now :

* Back to lab root directory
* Update `main.tf` as bellow :

  ```hcl
  module "my-sql-instance" {
    source        = "./modules/sql-database"
    instance_name = "demo-instance"
  }
  ```

* Use `terraform init` to get module content and to download terraform providers
* Run `terraform plan` (Do not execute `apply` because the creation of Cloud SQL resource is too long)

#### On Gitlab.com

Local modules can't be shared or re-used between teams

* Create a new repository on [Gitlab.com](https://gitlab.com) and push your `sql-database` on it (if you are in a SFEIR training session, you can just use the repository provided by the trainer `git::https://gitlab.com/.../terraform-google-sql-instance.git` with `v2.0.0` tag).
* Update the root `main.tf` to use the remote module.

  ```hcl
  module "my-sql-instance" {
    source = "git::https://gitlab.com/.../terraform-google-sql-instance.git?ref=v2.0.0"
    ...
  # See more examples here : https://www.terraform.io/docs/modules/sources.html
  ```

* Use `terraform init` to get module content from it's new location
* Run `terraform plan` again to see that these is no difference with the plan using local module.

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by Terraform !
