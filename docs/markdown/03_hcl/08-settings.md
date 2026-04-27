<!-- .slide:  class="with-code-bg-dark" -->

# Terraform settings

Il existe un bloc hors de toute ressource pour définir le comportement du déploiement :

* Forcer les versions à utiliser
* Configurer le backend
* Activer des fonctionnalitées expérimentales

```hcl-terraform
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      version = ">= 6.0"
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

Notes:
reparler de l’exemple de la data source pour le state dans le bucket
Attention : AWS provider v6.0 (juin 2025) introduit des breaking changes — consulter le guide de migration avant de passer d’une v5 à une v6 sur un projet existant.
