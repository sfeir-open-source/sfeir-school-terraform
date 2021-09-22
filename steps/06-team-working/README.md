# Sfeir Institute Terraform

## Module 6 : Team working

### Manage vault credentials using Terraform

In `secret-manager` folder, create a new [google_secret_manager_secret](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret) and set a new [google_secret_manager_secret_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) using [random provider](https://www.terraform.io/docs/providers/random/r/password.html)

Verify the secret content in the GCP console in Security/Secret manager.

### Terraform Modules

A module is a collection of resources defined by inputs (variable) and results (output).

#### Create a new module to deploy a [Cloud SQL](https://cloud.google.com/sql) instance using Terraform

* Go to the `sql-database` folder
* Deploy a Second-generation database using [google_sql_database_instance](https://www.terraform.io/docs/providers/google/r/sql_database_instance.html) resource
* Create an SQL user using [google_sql_user](https://www.terraform.io/docs/providers/google/r/sql_user.html)
* Create a `random_password` and save it in secret manager

Your cloud sql database module is now ready to be used in the parent resource ! Let's do this now :

* Back to git root folder
* Update `main.tf` as bellow :

  ```text
  module "my-sql-instance" {
    source        = "./sql-database"
    instance_name = "demo-instance"
    gcp_project   = var.gcp_project
  }
  ```

* Update `variables.tf` as bellow :

  ```text
  variable "gcp_project" {
    default = "CHANGEME"
  }
  ```

* Use `terraform init` to get module content and to download terraform providers
* Run `terraform plan` (Do not do an `apply` because the creation of cloud sql resource is too long)

#### On gitlab

Local modules can't be shared or re-used between teams

* Create a new repository on [gitlab](https://gitlab.com) and push your `sql-database` on it.
* Update the root `main.tf` to use the remote module.

  ```text
    source = "git::https://example.com/sql-database.git"
  # or
    source = "git::ssh://username@example.com/sql-database.git"
  
  # See more examples here : https://www.terraform.io/docs/modules/sources.html
  ```

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by terraform !
