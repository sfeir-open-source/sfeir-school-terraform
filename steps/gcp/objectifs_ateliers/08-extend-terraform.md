# 08 - Étendre Terraform (provider custom en Go)

Dossiers : `extra02-extend-terraform/` (starter) et `08-extend-terraform-solution/`

## Attendu

- Provider `hello` (Terraform Plugin SDK v2) : argument `nickname`, `hostname` récupéré via `os.Hostname()`.
- Ressource `hello_file` (`name`, `path`) : crée un fichier `Hello <name>, i'm <nickname>@<hostname>`.
- Fonctions CRUD complètes, `Read` gère le fichier supprimé hors Terraform.
- `go build`, puis test dans `test/` avec `dev_overrides` (`TF_CLI_CONFIG_FILE=$PWD/dev.tfrc`), `terraform init` facultatif.

Testé (Terraform 1.15, Go 1.25, SDK v2.40.1) : création, update en place, recréation après suppression manuelle, destroy.

## À insister

- Un provider = un binaire Go qui expose un schéma et des fonctions CRUD. Terraform lui parle en gRPC.
- `ForceNew: true` sur `path` : modifier `path` remplace la ressource, modifier `name` met à jour en place.
- `d.SetId("")` : dans `Delete`, retire la ressource du state. Dans `Read`, signale le drift et provoque la recréation.
- Le state contient ce que `Read` renvoie : supprimer `/tmp/foo` à la main puis `terraform plan`.
- `required_providers` + `source` obligatoires depuis Terraform 0.13, d'où `sfeir/hello`.
- Pour aller plus loin : le Plugin Framework est recommandé par HashiCorp pour les nouveaux providers. Le SDK v2 reste maintenu.

## Pièges

- Le warning "Provider development overrides are in effect" est normal, ce n'est pas une erreur.
- Chemin de `dev.tfrc` relatif ou faux : Terraform cherche le provider dans le registry et échoue.
- Go trop ancien : il faut >= 1.21 pour que Go télécharge automatiquement la toolchain demandée par `go.mod` (1.25). Premier build long (téléchargement des modules).
- Oublier de recompiler après une modification du code Go.
