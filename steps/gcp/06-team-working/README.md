# Sfeir Institute Terraform

## Module 6 : Team working

### Terraform Modules

A module is a collection of resources defined by inputs (variables) and results (outputs).

#### Create a new module to deploy a [Cloud SQL](https://cloud.google.com/sql) instance using Terraform

* Go to the `modules/sql-database` directory
* Deploy a MySQL 5.7 using [google_sql_database_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) resource
* Create an SQL user using [google_sql_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user)
* Create a `random_password`, assign it to the SQL user
* And save it in a secret using [google_secret_manager_secret_version](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/secret_manager_secret_version) (to be used later by an Application deployment terraform configuration)

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

#### On Gitlab.com or Github.com

Local modules can't be shared or re-used between teams

* Create a new repository on [Gitlab.com](https://gitlab.com) or your own [Github.com](https://github.com) and push your `sql-database` on it (if you are in a SFEIR training session, you can just use the Github repository `git::https://github.com/sfeir-open-source/sfeir-school-terraform//gcp/06-team-working/modules/sql-database/`).
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
