# 04 - Outillage

Dossiers : `04-tooling/` et `-solution/`

## Attendu

- Règle firewall DNS (tcp:53 et udp:53) via un bloc `dynamic "allow"` alimenté par `var.allowed_config`.
- `test/fixtures/test_variables.tfvars` créé.
- `Makefile` avec `init`, `test` (validate + apply/destroy avec fixtures), puis bonus `apply`, `destroy`, `docs`.
- Documentation générée avec terraform-docs (`.terraform-docs.yaml`, mode inject).
- Plugin éditeur (vim-terraform / extension VSCode) avec `fmt` à la sauvegarde.

## À insister

- `dynamic` : à utiliser quand le nombre de blocs imbriqués dépend d'une donnée. Pas pour tout.
- Variable typée `list(object({...}))` : le type documente et valide l'entrée.
- Convention `test/fixtures` + `make test` : la base d'un pipeline CI.
- terraform-docs : `inject` entre `BEGIN_TF_DOCS` / `END_TF_DOCS` pour garder du texte manuel.
- `make help` auto-documenté par les `##`.

## Pièges

| Piège | Cause / réponse |
|---|---|
| Makefile : espaces au lieu de tabulations | Tabulation obligatoire. |
| Starter sans `name` ni `network` sur le firewall | Erreur du provider volontairement instructive. |
| `make test` fait un vrai apply | Crée une règle firewall dans le projet partagé. |
| `terraform-docs` absent de Cloud Shell | Préparer la commande d'installation. |
| Fixture figée sur `gcp_project = "sfeir-school-terraform"` | À adapter au projet de la session. |
| Nom de firewall fixe (`allow-dns-solution`) | En session, suffixer par le prénom. |
| Vundle documenté mais daté | Pour Neovim, `terraform-ls` via LSP est l'option moderne. |

## Points de la solution

- `gcp_project` est déclarée avec `default = null` : le fixture a un sens, et sans valeur le provider retombe sur le projet de Cloud Shell.
- README de la solution régénéré par `make docs`.

## Détails d'animation

### Déroulé

```tree
Étapes
├── 1. Éditeur              -> plugin + fmt à la sauvegarde (vim-terraform, VSCode HashiCorp, terraform-ls)
├── 2. Firewall dynamic     -> tcp:53 + udp:53 depuis var.allowed_config
├── 3. plan                 -> 2 blocs allow générés
├── 4. test/fixtures        -> test_variables.tfvars
├── 5. Makefile v1          -> init + test (validate seul), make help
├── 6. Makefile v2          -> test = validate + apply + destroy avec -var-file
├── 7. terraform-docs       -> md > README, puis inject, puis .terraform-docs.yaml
└── 8. Bonus                -> apply, destroy, docs
```

### Le bloc `dynamic`

`for_each` au niveau ressource multiplie la ressource. `dynamic` multiplie un bloc imbriqué. Il est résolu avant l'appel au provider, qui reçoit simplement N blocs.

Trois usages :

1. **N blocs depuis une donnée** (le lab) : `for_each = var.allowed_config`.
2. **Bloc optionnel** : `for_each = var.enable_logging ? [1] : []` donne 0 ou 1 bloc.
3. **Imbrication** : `iterator = group` sur le `dynamic` externe garde l'accès aux deux niveaux.

Contrairement au `for_each` de ressource (map ou set de strings), `dynamic` accepte n'importe quelle collection, y compris une liste d'objets. Pas de `lifecycle` ni de `provisioner` générés.

| Écrit | Erreur | Correct |
|---|---|---|
| `each.value.ports` | `each` n'existe pas ici | `allow.value.ports` |
| arguments hors `content {}` | argument inattendu | tout passe dans `content {}` |
| `iterator = rule` puis `allow.value` | référence inconnue | `rule.value` |

Démo console : `[for r in var.allowed_config : "${r.protocol}:${join(",", r.ports)}"]` donne `["TCP:53", "UDP:53"]`.

Doc : <https://developer.hashicorp.com/terraform/language/expressions/dynamic-blocks>

### La partie test (Makefile + fixtures)

```tree
make test
├── validate  -> syntaxe + types + références (aucun appel API)
├── apply     -> crée vraiment la règle avec les valeurs de test
└── destroy   -> la supprime
```

- C'est un smoke test d'intégration : il prouve que le code s'applique, il ne vérifie aucun comportement.
- Les fixtures ne sont pas chargées automatiquement : seuls `terraform.tfvars` et `*.auto.tfvars` le sont. D'où `-var-file`, et c'est voulu.

Deux défauts à faire remarquer :

1. **State partagé** : `make apply` et `make test` utilisent le même `terraform.tfstate`.
2. **Destroy non garanti** : make s'arrête à la première erreur, un apply en échec laisse des orphelins.

Bonus niveau 2 : un `test` qui bascule sur un workspace dédié et détruit toujours, en capturant le code retour de l'apply avant d'`exit`.

Transition vers le 05 :

| | `make test` (04) | `terraform test` (05) |
|---|---|---|
| State | partagé (ou workspace) | éphémère, en mémoire |
| Nettoyage | manuel, fragile | automatique |
| Assertions | aucune | `assert`, `expect_failures` |
| Ressources réelles | toujours | optionnel (`plan`, `mock_provider`) |

### La cible `help`

Trois lignes portent le message, le reste est une recette awk à ne pas décortiquer en session :

- **`.DEFAULT_GOAL := help`** : `make` nu affiche l'aide. Sans ça, il lance la première cible (`all: init test docs`), donc un vrai apply/destroy.
- **`.PHONY`** : le 04 contient un dossier `test/`. Sans `.PHONY`, `make test` répond `'test' is up to date` et ne fait rien (vérifié).
- **`help`** : le Makefile se lit lui-même et n'affiche que les cibles commentées par `##`. Une seule source de vérité, la description vit à côté de la cible.

### La documentation (terraform-docs)

Analyse statique, sans `init` ni appel API :

```tree
Code                           -> Section générée
├── terraform { required_* }   -> Requirements
├── .terraform.lock.hcl        -> Providers (version exacte, sinon "n/a")
├── module "..."               -> Modules
├── resource / data            -> Resources (lien vers le registry)
├── variable                   -> Inputs (description, type, default, required)
└── output                     -> Outputs
```

La doc vaut ce que valent les `description`. Démo : générer, constater les "n/a", ajouter les descriptions, régénérer.

Trois niveaux : redirection `> README.md` (tout écrasé), `--output-mode inject` (seul le bloc balisé change), puis `.terraform-docs.yaml` qui réduit la commande à `terraform-docs .`. Le nom par défaut est `.terraform-docs.yml`, mais `.yaml` est bien détecté (vérifié).

Options utiles : `sort.by: required`, `recursive.enabled` (un README par `modules/*`, utile au 06), `sections.hide`.

En CI : `terraform-docs --output-check .` échoue si le README n'est pas à jour. À placer dans le stage `validate` du 07 ou en hook pre-commit (`terraform_docs` de `antonbabenko/pre-commit-terraform`).

### Code

Voir `04-tooling-solution/main.tf`, `variables.tf` et le `Makefile`.
