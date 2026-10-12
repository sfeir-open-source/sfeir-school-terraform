# 06 - Travail en équipe : modules

Dossiers : `06-team-working/` et `-solution/`

## Attendu

- Module local `modules/sql-database` : `random_password`, `google_sql_database_instance`, `google_sql_user`, secret + version dans Secret Manager.
- Module appelé depuis la racine avec `instance_name`.
- `terraform init` + `terraform plan` seulement : pas d'apply (Cloud SQL est trop long).
- Variante : même module en source Git (`git::...?ref=v1.0.0`), le plan doit être identique.

## À insister

- Un module = variables en entrée, ressources, outputs. L'interface compte plus que le contenu.
- Module local vs distant : le partage entre équipes impose un dépôt et un tag (`?ref=v1.0.0`).
- Épingler la version de la source Git : jamais de branche flottante.
- Le mot de passe n'est jamais saisi : `random_password` -> Secret Manager. Rappeler qu'il finit dans le state.
- `deletion_protection = false` : choix de lab, à ne pas reproduire en production.
- `authorized_networks 0.0.0.0/0` fourni dans le starter : "lab purpose only", à dire à voix haute.

## Pièges

| Piège | Cause / réponse |
|---|---|
| `Module not installed` | `terraform init` après chaque changement de `source`. |
| Nom d'instance Cloud SQL rejeté | Un nom supprimé reste réservé ~1 semaine : erreurs en cas de rejeu. |
| `db-f1-micro` refusé | MySQL 8.4 passe par défaut en Enterprise Plus, qui n'a pas de tier shared-core. D'où `edition = "ENTERPRISE"`. |
| `depends_on` ajouté sur `secret_version` | Inutile : la référence à `secret.id` crée déjà la dépendance. |
| Mot de passe "invisible" | En clair dans le state. Introduction au state distant du 07. |

## Écarts connus

- MySQL 8.4 par défaut (5.7 est en support étendu payant depuis le 1er février 2025).
- Le module distant `Ameausoone/terraform-google-sql-instance-lab?ref=v1.0.0` n'a pas été mis à jour : le plan "identique" annoncé par le README différera probablement (version MySQL, edition). Vérifier avant la session.

## Détails d'animation

### Déroulé

```tree
Étapes
├── 1. Module : random_password -> sql_database_instance -> sql_user -> secret -> secret_version
├── 2. Racine : module "my_sql_instance" { source = "./modules/sql-database" }
├── 3. terraform init           -> le module est installé (.terraform/modules)
├── 4. terraform plan           -> PAS d'apply (Cloud SQL trop long)
├── 5. Source Git ?ref=v1.0.0   -> init à nouveau, plan
└── 6. Comparer les deux plans
```

### Pas de bloc `provider` dans le module

C'est l'appelant qui choisit où le module déploie. Un bloc `provider` dans un module pose trois problèmes :

- **Pas de réutilisation** : projet et région figés, impossible de passer un alias.
- **`count` et `for_each` interdits** sur ce module.
- **Suppression bloquée** : retirer l'appel fait disparaître la configuration du provider, et Terraform ne peut plus détruire les ressources.

Le module hérite de la configuration par défaut de la racine. Pour une autre : `providers = { google = google.b }` à l'appel.

### Pas de bloc `provider` non plus à la racine

La racine du 06 n'a que `main.tf` et `versions.tf`. Terraform utilise une configuration google vide, complétée par l'environnement : ADC pour les credentials, variables d'environnement Cloud Shell pour le projet, et la région passée directement à la ressource.

Hors Cloud Shell : `gcloud auth application-default login` + `export GOOGLE_CLOUD_PROJECT=...`, ou un `provider.tf` à la racine. Jamais dans le module.

### Code

Voir `06-team-working-solution/main.tf` et `modules/sql-database/`.

Points à commenter : `random_password` jamais saisi puis stocké en Secret Manager via `jsonencode`, `deletion_protection = false` et `edition = "ENTERPRISE"` comme choix de lab.
