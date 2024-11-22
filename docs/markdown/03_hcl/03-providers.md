
# HashiCorp Configuration Language (HCL)

## Provider

Le provider fournit un ensemble de primitives permettant de lire, créer, modifier ou supprimer des ressources sur la plateforme distante.

* Chaque provider possède ses propres attributs
* Il est possible d’utiliser plusieurs déclarations d’un même provider en utilisant l’attribut spécial “alias” (appelé meta-argument).
* Les variables utilisées pour configurer les providers doivent être calculables avant un plan
* Il est fortement conseillé d'utiliser des variables d'environnement pour configurer les providers

##==##
<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Provider

* Exemple :

Il est possible de configurer le provider Google Cloud en utilisant du HCL ou des variables d'environnement :

```hcl-terraform
provider "google" {
 credentials = file("account.json")
 project     = "my-project-id"
 region      = "us-central1"
}
```

équivaut à :

```
export GOOGLE_APPLICATION_CREDENTIALS="account.json"
export GOOGLE_PROJECT="my-project-id"
export GOOGLE_REGION="us-central1"
```
