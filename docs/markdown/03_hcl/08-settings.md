<!-- .slide:  class="with-code-bg-dark" -->

# Terraform settings

Il existe un bloc hors de toute ressource pour définir le comportement du déploiement :

* Forcer les versions à utiliser
* Configurer le backend
* Activer des fonctionnalitées expérimentales

```hcl-terrafom
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      version = ">= 2.7.0"
      source = "hashicorp/aws"
    }
  }
  backend "remote" {
    organization = "example_corp"
    workspaces {
      name = "my-app-prod"
    }
  }
  experiments = [something]
}
```
