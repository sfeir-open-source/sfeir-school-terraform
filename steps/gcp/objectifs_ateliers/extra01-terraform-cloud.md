# Extra 01 - HCP Terraform

Dossier : `extra01-terraform-cloud/` (pas de solution)

## Attendu

- Compte et organisation HCP Terraform.
- Dépôt GitLab avec `main.tf` + README, connecté à un workspace piloté par VCS.
- Variable `bar = "Hello terraform"`, premier run lancé depuis l'interface.
- Extra : changer la version de Terraform du workspace, ajouter `TF_LOG`.

## À insister

- Ce que HCP Terraform apporte : state distant, verrouillage, runs centralisés, variables, politiques, registre privé.
- Le workflow VCS : un push déclenche un plan, l'apply se confirme dans l'interface.
- Variables d'environnement vs variables Terraform, et le marquage `sensitive`.
- Lien avec le module 07 : mêmes besoins (state partagé, pipeline), résolus par la plateforme.

## Pièges

- `provisioner "local-exec"` avec `when = destroy` sur `python --version` : dépend de la présence de Python dans le runner. À présenter comme exemple de provisioner, pas comme bonne pratique.
- Organisation à créer au préalable, sinon le wizard bloque.
- Dépôt GitLab : droits d'accès du compte HCP Terraform à autoriser dans le wizard.
