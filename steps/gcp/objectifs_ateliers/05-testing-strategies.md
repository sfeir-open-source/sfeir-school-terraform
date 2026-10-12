# 05 - Stratégies de test

Dossiers : `05-testing-strategies/` et `-solution/` (Terraform >= 1.7.0)

## Attendu

- Bucket GCS nommé `<prefix>-<name>`, avec validations :
  - `prefix` : lettres seules, 3 à 8 caractères
  - `name` : lettres seules, 3 caractères minimum
- `bucket.tftest.hcl` : 5 `run` en `command = plan` (1 cas valide, 4 avec `expect_failures`).
- Bonus : `bucket_apply.tftest.hcl` en `command = apply` avec `mock_provider "google"`, sans credentials.
- `terraform test` : 6 pass.

## À insister

- Un test se fait sur le comportement attendu, y compris l'échec : `expect_failures` cible la variable (`var.prefix`).
- `plan` vs `apply` dans un test : le plan suffit pour valider des règles de validation.
- `mock_provider` : le test d'intégration sans cloud, utile en CI sans compte de service.
- Plusieurs `validation` distinctes valent mieux qu'une regex unique : messages d'erreur précis.
- `terraform test` n'est qu'une couche. Citer les alternatives (Terratest, Kitchen) et renvoyer à l'extra 03.

## Pièges

| Piège | Cause / réponse |
|---|---|
| Le starter est un squelette (`...`) | Nom du bucket, validations et tests sont à écrire. |
| 2 blocs `validation` pour 3 règles sur `prefix` | Les étudiants combinent en `^[a-z]{3,8}$` : ça marche, mais le message ne dit plus quelle règle est violée. Bon sujet de discussion. |
| Mauvaise cible dans `expect_failures` | `var.name` au lieu de `var.prefix`. |
| Majuscules | La solution les refuse (`^[a-z]+$`), le README dit seulement "letters". |
| `expect_failures = ["var.prefix"]` | Guillemets interdits : c'est une référence, pas une string. |
| `assert` dans un run d'échec | Inutile : le plan s'arrête à la validation. |
| `mock_provider` : `Unsupported block type` | Terraform < 1.7. |
| Mock sans `defaults` | Les attributs computed prennent des valeurs aléatoires. |
| Test `apply` sans mock | Crée un vrai bucket `sfeir-mocked`, identique pour tous : collisions. |

## Détails d'animation

### Déroulé

```tree
Étapes
├── 1. main.tf             -> name = format("%s-%s", var.prefix, var.name), location
├── 2. variables.tf        -> validations name (lettres, >= 3) et prefix (lettres, 3..8)
├── 3. terraform plan -var prefix=sfeir42 -var name=test   -> voir l'error_message à la main
├── 4. bucket.tftest.hcl   -> variables globales + run nominal avec assert
├── 5. Cas d'échec         -> expect_failures = [var.prefix] / [var.name]
├── 6. terraform test      -> 5 passed
├── 7. Casser une validation exprès -> le test correspondant devient rouge
└── 8. Bonus mock          -> command = apply sans GCP, 6 passed
```

L'étape 7 est essentielle : un test qui n'a jamais été vu rouge ne prouve rien.

### À montrer en live

- L'étape 3 avant tout test : le test ne fait qu'automatiser ce constat.
- `terraform test -verbose` (plan de chaque `run`) et `-filter=bucket_apply.tftest.hcl`.
- Couper les credentials et relancer, voir ci-dessous.

### Point important : `plan` a besoin de credentials

Vérifié sur la solution (6/6 avec ADC) :

```text
GOOGLE_APPLICATION_CREDENTIALS=/nonexistent terraform test

Error: Attempted to load application default credentials since neither
`credentials` nor `access_token` was set in the provider block.
Failure! 1 passed, 1 failed, 4 skipped.
```

`command = plan` ne crée rien, mais configure le provider, donc il lui faut des ADC. Transparent en Cloud Shell, bloquant en CI. Le test mocké, lui, passe sans credentials : meilleure démonstration de l'intérêt du mock. Correctif possible : `mock_provider "google" {}` en tête de `bucket.tftest.hcl`.

### Fonctionnement à connaître

- `terraform test` découvre les `*.tftest.hcl` à la racine du module et dans `tests/`.
- Le bloc `variables {}` en tête de fichier donne les valeurs par défaut de tous les `run`, chaque `run` peut surcharger.
- Les `run` d'un même fichier partagent un state, dans l'ordre : un `run` peut s'appuyer sur le précédent.
- Nettoyage automatique en fin de fichier : ce qui manquait au `make test` du 04.

### Code

Voir `05-testing-strategies-solution/variables.tf`, `bucket.tftest.hcl` et `bucket_apply.tftest.hcl`.

Trois points à commenter : `can(regex(...))` qui renvoie `false` au lieu de lever une erreur, `expect_failures` qui fait passer le test quand la validation échoue, et `defaults` qui fixe les attributs computed du mock.
