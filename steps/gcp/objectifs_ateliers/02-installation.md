# 02 - Installation et configuration

Dossier : `02-installation/` (solution : `02-installation-solution/`, identique au starter)

## Attendu

- Cloud Shell sur le bon projet GCP, Terraform >= 1.7.0 dans `$HOME/bin`.
- `.terraformrc` avec `plugin_cache_dir`.
- `terraform init && terraform apply` OK, output `message = "Hello World"`.
- Graphe de dépendances généré avec `terraform graph | dot`.

Aucune ressource GCP créée : le lab valide l'environnement.

## À insister

- Le lab est un test de plomberie. S'il échoue, les labs suivants échoueront.
- `terraform_data` : ressource builtin, pas de provider ni de credentials. Remplace `null_resource`.
- Lire `terraform.tfstate` une première fois : version, lineage, serial, outputs, resources.
- Le cache de providers évite de retélécharger le provider google (~100 Mo) à chaque dossier.
- `required_version` : garde-fou du CLI, à distinguer de la version du provider.

## Pièges

- `bash -l` oublié après l'upgrade : `which terraform` pointe encore vers l'ancienne version.
- `dot` absent : vérifier Graphviz sur Cloud Shell avant la session.
- Mauvais projet GCP : sans effet ici, bloquant dès 03a (`gcloud config get project`).
- `$HOME` reste littéral dans `.terraformrc` (quotes simples dans le `echo` du README). Terraform le développe lui-même, mais ça inquiète.

## Détails d'animation

### Déroulé

```tree
Étapes
├── 1. Cloud Shell sur le bon projet GCP     -> terraform version
├── 2. Comparer à la dernière version        -> curl checkpoint-api | jq
├── 3. Upgrade dans $HOME/bin                -> unzip + bash -l
├── 4. Cache de providers                    -> ~/.terraformrc
├── 5. git clone + cd 02-installation
├── 6. terraform init && terraform apply
└── 7. terraform graph | dot -Tpng           -> Open Editor
```

### À montrer en live

- `cat terraform.tfstate` : `terraform_data` utilise le provider builtin `terraform.io/builtin/terraform`. Rien à télécharger, d'où un `init` quasi instantané.
- Le cache : un second `init` dans un autre dossier ne retélécharge rien.
- `terraform output message`, et `which terraform` qui doit pointer vers `$HOME/bin`.

### Code

Voir `02-installation/main.tf` et `versions.tf`.

Seul point à commenter : `triggers_replace` force le remplacement de la ressource quand la valeur change.
