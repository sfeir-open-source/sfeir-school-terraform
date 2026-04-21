<!-- .slide:-->

# Modules

* Les modules favorisent la réutilisation du code en fournissant aux développeurs une bibliothèque de déploiements pré-développés.
* Un module est composé :
  * de variables en entrée
  * d’outputs en sortie
* Il ne sera pas possible pour un utilisateur d’un module d’accéder au contenu du module s’il n’a pas été exposé via un output.



##==##

# Modules

## Module Registry

Il existe par défaut plusieurs plateformes permettant de publier des modules tel que github, gitlab, bitbucket, etc…
https://www.terraform.io/docs/modules/sources.html

Lorsque ceux-ci seront déclarés dans un fichier de configuration, Terraform les téléchargera à l’aide de la commande : **terraform init** ou **terraform get** et seront stockés localement dans le dossier **.terraform**.

L’utilisation de **terraform init --upgrade** permet la mise à jours des modules existants.

Hashicorp met à disposition un ensemble de modules officiels sur sa propre registry : https://registry.terraform.io/

Notes: 
Plus de 18000 modules actuellement disponibles sur la registry publique
##==##
<!-- .slide: class="with-code-bg-dark" -->

# Modules

=> *cat gke.tf*

```hcl-terraform
module "gke" {
 source  = "terraform-google-modules/kubernetes-engine/google"
 version = "44.0.0"

 project_id        = var.project_id
 name              = var.cluster_name
 region            = var.region
 zones             = var.zones
 network           = var.network
 subnetwork        = var.subnetwork
 ip_range_pods     = var.ip_range_pods
 ip_range_services = var.ip_range_services
}
```

Notes:
Module officiel Google Cloud (53M+ downloads, activement maintenu)
Voir : https://registry.terraform.io/modules/terraform-google-modules/kubernetes-engine/google

##==##

# Modules

## TIPS

* La version d’un module peut être défini par un tag sur le repository
* Bien que la version soit facultative, son utilisation permet de fiabiliser l’utilisation d’un module dans les déploiements (sans version, le dernier commit est utilisé).
* Il est possible d’inclure des sous-modules.
* Il est important d’utiliser les outputs pour obtenir des informations sur les ressources créées.
* Les modules héritent des providers par défaut mais il est possible de les surcharger.
* N'hésitez pas à passer les resources de vos providers


##==##

# Modules

## TIPS

Les modules peuvent être gérés comme des packages.

- [semantic-release](https://semantic-release.gitbook.io/semantic-release/) : automatiser la gestion des versions (CHANGELOG, incréments, ...) et la publication des packages
- [Dependabot](https://docs.github.com/en/code-security/dependabot) ou [renovatebot](https://github.com/renovatebot/renovate): gestion de l'obsolescence
- terraform-docs (module-4) : générer la documentation
- CODEOWNERS : identifier, notifier et autoriser uniquement les changements via les code owners
