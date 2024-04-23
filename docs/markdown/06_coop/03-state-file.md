<!-- .slide:-->

# Gestion de la concurrence et de la persistance

## Le fichier d’état “terraform.tfstate”

<br>

- Garder un référentiel des ressources déployées
- Gérer les dépendances entre les ressources
- Format json
- Automatiquement généré

##==##

# Gestion de la concurrence et de la persistance

## Le fichier d’état “terraform.tfstate”

Ce fichier est critique, en cas de perte, Terraform “oubliera” l’ensemble des ressources qu’il a créé.<br>
Il est conseillé de ne pas le stocker localement mais sur :

- Un stockage de fichier type Google Cloud Storage, AWS S3, … et **d'activer les options de versioning**
- De restreindre les accès (principe du least privilege) car ce fichier peut contenir des informations sensibles (IP, clef SSH, password, ...)

##==##

# Gestion de la concurrence et de la persistance

## Le fichier d’état “terraform.tfstate”

Il existe plusieurs types de backends :

- local (par défaut)
- remote (nécessite Terraform Cloud)
- s3, gcs, azurerm, http, consul, etcd, ...

##==##

<!-- .slide: class="with-code-bg-dark"-->

# Gestion de la concurrence et de la persistance

## Le fichier d’état “terraform.tfstate”

La configuration et le choix du backend se fait en le déclarant dans un fichier \*.tf (exemple backend.tf).

<br>

```hcl-terraform
terraform {
 backend "gcs" {
   project  = "foo"
   bucket  = "foo"
   prefix  = "foo"
 }
}
```



##==##

# Gestion de la concurrence et de la persistance

## Le fichier d’état “terraform.tfstate”

Il est possible de verrouiller le fichier pour éviter les appels concurrents depuis plusieurs sources (non supporté par tous les backend).

<br>

Terraform propose la commande **terraform force-unlock** si mon déploiement reste verrouillé.

##==##

# Manipulation du fichier d’état

## “terraform.tfstate”

Dans certains cas, il sera nécessaire de le modifier. Pour cela on utilisera la commande : **terraform state _verb_ _resource-path_**

- terraform state list
- terraform state show
- terraform state rm google_compute_instance.inst
- terraform state mv -state-out=new.tfstate module.current-name module.new-name
- terraform state pull/push
- terraform import resource-path ID

Notes:
Les cas où on modifie le tfstate :

on ne veut plus manager une ressource via Terraform

on veut renommer une ressource sans devoir la re-créer (base de donnée par exemple)

on veut spliter un workspace devenu trop gros en plusieurs petits workspaces
