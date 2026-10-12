# 03b - Interpolations, boucles et conditions

Dossiers : `03b-interpolations-looping-and-conditions/` et `-solution/`

## Attendu

- Un bucket GCS (`bucket_name` saisi par l'utilisateur).
- Les fichiers de `var.files` poussés en objets, de deux façons :
  - `count` (suffixe `-count`)
  - `for_each` (suffixe `-for_each`)
- 4 objets après le premier apply (2 par méthode).
- Ajout de `"config-pp" = "env = pp"` dans la map, puis `terraform plan`.

## À insister

C'est le coeur du lab : comparer les deux plans après l'ajout de `config-pp`.

- `count` : les clés de la map sont triées (`config-dev`, `config-pp`, `config-prod`). `config-pp` s'insère au milieu, `config-prod` change d'index : destruction/recréation d'un objet existant.
- `for_each` : une seule création, rien d'autre ne bouge, car l'adresse est la clé (`["config-pp"]`).
- Règle à faire dire aux étudiants : `for_each` sur une collection avec identité stable, `count` pour un nombre ou un booléen (`count = var.enabled ? 1 : 0`).
- `terraform_plan_with_new_config.txt` dans la solution : le plan de référence (daté de 2023, la logique reste valide).
- `sensitive = true` sur les outputs : pourquoi `content` est masqué.
- `format()`, `lower()`, `keys()`, `element()`.

## Pièges

| Piège | Cause / réponse |
|---|---|
| Le starter ne passe pas `validate` | `outputs.tf` référence `files_count`, dont le bloc est commenté. |
| Collision de nom de bucket | Namespace GCS global : imposer un préfixe. |
| Nom d'objet identique entre les deux méthodes | D'où les suffixes `-count` / `-for_each`. |
| Le README parle de Terraform 0.11 / 0.12 | Dire "ancienne méthode / nouvelle méthode". |
| `count.index` dans un bloc `for_each` (ou l'inverse) | `count.index` n'existe qu'avec `count`, `each.*` qu'avec `for_each`. |
| `for_each = keys(var.files)` | Une liste n'est pas acceptée : set (`toset()`) ou map. `var.files` suffit. |
| Création du bucket refusée | Possible org policy `uniform_bucket_level_access`. À vérifier avant la session. |

## Détails d'animation

### Ce qui est créé

```tree
gs://<bucket_name>/
├── config-dev-count        # contenu : "env = dev"
├── config-prod-count       # contenu : "env = prod"
├── config-dev-for_each     # contenu : "env = dev"
└── config-prod-for_each    # contenu : "env = prod"
```

La clé donne le nom, la valeur le contenu (attribut `content`, pas de fichier local). Les objets ne servent à rien d'autre : ils sont rapides à créer, gratuits et visibles (`gcloud storage ls`).

### Déroulé

```tree
Étapes
├── 1. terraform validate sur le starter  -> échec voulu : outputs.tf référence files_count
├── 2. Décommenter et compléter count     -> suffixe -count
├── 3. Compléter for_each                 -> suffixe -for_each
├── 4. plan + apply                       -> 1 bucket + 4 objets
├── 5. terraform state list               -> files_count[0], [1] vs files_for_each["config-dev"], ["config-prod"]
├── 6. Ajouter "config-pp" dans var.files
├── 7. terraform plan                     -> 3 to add, 1 to destroy (comparer avec le .txt)
├── 8. Faire expliquer le plan par les étudiants
└── 9. terraform destroy
```

### L'explication de l'étape 7

```tree
Clés de la map, triées par ordre lexical (keys() trie)
├── Avant : [0] config-dev    [1] config-prod
└── Après : [0] config-dev    [1] config-pp    [2] config-prod
                                   │                 │
            files_count[1] : config-prod -> config-pp => REMPLACÉ
            files_count[2] : nouveau (config-prod)    => CRÉÉ
            files_for_each["config-pp"]               => CRÉÉ, rien d'autre ne bouge
```

Ne pas désamorcer la surprise : laisser les étudiants constater le remplacement avant d'expliquer.

### À montrer en live

- `terraform state list` avant et après l'ajout de `config-pp`.
- `terraform console` : `keys(var.files)`, `element(keys(var.files), 1)`, `var.files["config-dev"]`.
- Retirer `sensitive = true` d'un output : erreur "Output refers to sensitive values", `content` étant sensible dans le schéma du provider.

### Pistes

- Le titre annonce des "conditions" mais aucun exercice ne les couvre. Bonus : `count = var.legacy_mode ? length(var.files) : 0`.
- Migration `count` -> `for_each` avec `moved`. Piège pédagogique : `moved` change l'adresse dans le state, mais si les attributs diffèrent (les suffixes), le plan remplace quand même.

### Code

Voir `03b-interpolations-looping-and-conditions-solution/main.tf`.

Le contraste tient en deux lignes : `files_count[0]` (adresse liée à la position) vs `files_for_each["config-dev"]` (adresse liée à la clé).
