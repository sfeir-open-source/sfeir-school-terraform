# 03a - Premier déploiement

Dossiers : `03a-first-infrastructure-deployment/` et `-solution/`

## Attendu

- Provider google configuré (ADC de Cloud Shell, aucun credential dans le code).
- `google_compute_instance` : europe-west1-c, n1-standard-1, debian-12, réseau default, serial port activé, pas d'IP publique.
- Variable `instance_name` sans default (saisie par l'utilisateur, prénom pour éviter les collisions).
- `google_compute_firewall` IAP (`35.235.240.0/20`, tcp, INGRESS), à décommenter une fois l'instance déployée.
- SSH via `gcloud compute ssh --tunnel-through-iap`.
- `terraform destroy` en fin de lab.

## À insister

- Cycle `init` -> `plan` -> `apply` : lire le plan avant d'appliquer.
- Pas de bloc `access_config` = pas d'IP publique. C'est un choix de sécurité, pas un oubli.
- Pourquoi IAP plutôt qu'une règle SSH ouverte à 0.0.0.0/0.
- Le nom du firewall inclut `var.instance_name` : le projet GCP de formation est partagé.
- `allow_stopping_for_update` : changer `machine_type` impose un arrêt de la VM.
- `create_before_destroy` sur le firewall : montrer l'effet sur un remplacement.
- Output `instance_ip` : référence d'attribut entre ressources.

## Pièges

| Piège | Cause / réponse |
|---|---|
| Collision de noms entre participants | Instance et firewall : imposer le prénom. |
| Firewall non décommenté, ou mauvais réseau | SSH IAP timeout. |
| `project` manquant hors Cloud Shell | `gcloud auth application-default login` + `project`. |
| Oubli du `terraform destroy` | Ressources orphelines dans le projet partagé. |
| `Error 400 ... Invalid value for field 'resource.name'` | Nom avec majuscules ou espaces. GCE exige `[a-z]([-a-z0-9]*[a-z0-9])?`. Occasion d'annoncer les `validation` du 05. |
| Le starter échoue au `validate` | Normal : ressource vide et `outputs.tf` la référence déjà. |
| Ajout d'un `access_config {}` "pour que ça marche" | Contraire à la spec. À rattraper au plan. |
| SSH IAP en `403` | Rôle `roles/iap.tunnelResourceAccessor` manquant. |
| `apt update` qui bloque dans la VM | Ni IP publique ni Cloud NAT, donc pas de sortie internet. Conséquence du choix. |
| `create_before_destroy` + nom fixe | Un changement ForceNew recrée une règle de même nom : "already exists". Impose des noms uniques. |

À vérifier avant la session : rôles IAP des participants, disponibilité de `n1-standard-1` dans `europe-west1-c` (`e2-small` suffirait et coûte moins cher).

## Détails d'animation

### Déroulé

```tree
Étapes
├── 1. Lire provider.tf             -> pourquoi pas de project ni credentials (ADC Cloud Shell)
├── 2. terraform init               -> téléchargement du provider google, lock file
├── 3. Instance depuis la doc       -> arguments requis : name, machine_type, zone, boot_disk, network_interface
├── 4. terraform plan               -> prompt instance_name, lecture du plan
├── 5. terraform apply              -> output instance_ip (IP interne)
├── 6. Décommenter le firewall      -> plan = 1 to add, instance inchangée
├── 7. gcloud compute ssh --tunnel-through-iap
├── 8. Bonus : changer machine_type -> update en place grâce à allow_stopping_for_update
└── 9. terraform destroy
```

### À montrer en live

- Un `plan` sur le starter, pour faire lire les erreurs "Missing required argument" : la meilleure introduction à la doc du registry.
- `network_interface` avec et sans `access_config` : c'est ce bloc qui crée l'IP publique.
- Changer `machine_type` sans `allow_stopping_for_update` : erreur. Avec : arrêt, update, redémarrage.
- `terraform state list` et `terraform state show google_compute_instance.tf_instance`.

### FAQ : `versions.tf` vs `provider.tf`

| | `versions.tf` | `provider.tf` |
|---|---|---|
| Bloc | `terraform { required_providers {} }` | `provider "google" {}` |
| Question | quel binaire, quelle version | comment se connecter |
| Utilisé par | `terraform init` | `plan` / `apply` |
| Dans un module enfant | oui | non |

Le nom des fichiers n'a aucune importance, Terraform fusionne tous les `.tf`. La vraie raison de la séparation, ce sont les modules : un module déclare ses `required_providers` mais ne configure jamais le provider. Un bloc `provider` dans un module interdit notamment `count` et `for_each` sur ce module.

### FAQ : plusieurs providers

- **Providers différents** : le préfixe du type suffit (`random_password` -> random).
- **Même provider, plusieurs configs** : `alias` sur le provider, puis `provider = google.us` sur la ressource (sans guillemets).
- **Vers un module** : `providers = { google = google.us }`. Un module qui en attend deux les déclare via `configuration_aliases`.
- **`google-beta`** : provider distinct, mais types `google_...` inchangés, donc `provider = google-beta` obligatoire sur la ressource.

Doc : <https://developer.hashicorp.com/terraform/language/providers/configuration>

### Code

Voir `03a-first-infrastructure-deployment-solution/main.tf`.

Points à commenter : l'absence d'`access_config`, le `source_ranges = ["35.235.240.0/20"]` (plage IAP Google), le nom de firewall suffixé par `var.instance_name`, et le `create_before_destroy`.
