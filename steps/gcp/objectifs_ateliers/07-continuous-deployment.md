# 07 - Déploiement continu

Dossiers : `07-continuous-deployment/` et `-solution/`

## Attendu

- Backend GCS (`remote.tf`) : bucket partagé, `prefix` = prénom.
- Instance GCE nommée `<application_name>-<prénom>-<workspace>`, variables `application_name` et `machine_type`.
- Workspaces `staging` et `production` en plus de `default`.
- Manipulation du state : `state show`, `state rm`, plan (que se passe-t-il ?), `import`.
- Pipeline GitLab CI : `validate` -> `plan` (artefact `.tfplan`) -> `apply` manuel sur `production`.
- Destroy de chaque workspace en fin de lab.

## À insister

- Le state est la source de vérité : le `state rm` puis `plan` montre une ressource "à créer" alors qu'elle existe. L'`import` résout le problème.
- Workspaces : mêmes fichiers, states séparés. `terraform.workspace` dans le nom évite les collisions.
- Plan sauvegardé (`-out`) puis `apply` du fichier : on applique exactement ce qui a été relu.
- `when: manual` : garde-fou humain avant la production.
- Credentials CI via `GOOGLE_CREDENTIALS` : jamais dans le dépôt, droits minimaux sur le compte de service.
- Locking du backend GCS : deux apply simultanés, le second attend ou échoue.
- Le bloc déclaratif `import {}` (1.5+) est l'alternative moderne à la commande CLI.

## Pièges

| Piège | Cause / réponse |
|---|---|
| `import` en échec | Format d'ID attendu : `{project}/{zone}/{instance_name}`. |
| Workspace non sélectionné avant le `destroy` | D'où `TF_WORKSPACE=...`. |
| Préfixe de backend identique entre participants | States écrasés. Imposer le prénom. |
| Pipeline : `init` manquant ou artefact expiré | Le job d'apply ne retrouve pas le plan. |
| `Error acquiring the state lock` | Autre apply en cours, ou lock orphelin. `terraform force-unlock <id>`, avec prudence. |

## Écarts connus

Le `.gitlab-ci.yml` de la solution est une adaptation du README (image non épinglée, pas de `fmt -check`, `dependencies` au lieu de `needs`). Il fonctionne : `validate` et `fmt` passent, `dependencies` transmet bien l'artefact du plan.

Fragilités à mentionner :

- Image `hashicorp/terraform` sans tag + apply manuel : si l'image change entre le plan et l'apply, Terraform refuse le plan sauvegardé.
- `.terraform.lock.hcl` est ignoré par le `.gitignore` du repo : chaque job résout le provider à nouveau. Argument pour commiter le lock file dans un vrai projet.
- `terraform workspace select production` échoue si le workspace n'existe pas. `-or-create` évite le problème.
- `remote.tf` de la solution contient le bucket et le prefix du formateur.

## Détails d'animation

### Déroulé

```tree
Étapes
├── 1. remote.tf + terraform init          -> state dans gs://<bucket>/<prenom>/
├── 2. Instance nommée <app>-<prenom>-${terraform.workspace}
├── 3. workspace new staging / production
├── 4. default : apply, puis state show / state rm / plan / import
├── 5. staging : apply                     -> deuxième instance, state séparé
├── 6. Pipeline GitLab sur production      -> plan artefact, apply manuel
└── 7. Destroy des 3 workspaces            -> TF_WORKSPACE=...
```

Moment clé : après `state rm`, le plan veut recréer une instance qui existe encore. `import` resynchronise le state.

### Variables CI/CD GitLab : deux subtilités

**Type "Variable" ou "File"** — "Variable" contient le JSON de la clé, "File" écrit le contenu dans un fichier temporaire et expose son chemin. Le provider google et le backend gcs acceptent les deux. "File" est obligatoire pour `GOOGLE_APPLICATION_CREDENTIALS` ou `gcloud`, qui attendent un chemin. Un JSON multi-ligne ne pouvant pas être masqué dans les logs, "File" est préférable.

**"Protect variable", coché par défaut** — une variable protégée n'est injectée que sur les branches et tags protégés. Les participants poussent sur leur branche `<prénom>`, non protégée : `GOOGLE_CREDENTIALS` est vide et le job échoue dès `terraform init`. Pour le lab : décocher, ou protéger les branches des participants.

### Code

Voir `07-continuous-deployment-solution/remote.tf`, `main.tf` et `.gitlab-ci.yml`.

Points à commenter : le `prefix` du backend qui isole un state par participant, `terraform.workspace` dans le nom de l'instance, et le couple `-out=production.tfplan` / `when: manual` qui sépare la relecture de l'application.
