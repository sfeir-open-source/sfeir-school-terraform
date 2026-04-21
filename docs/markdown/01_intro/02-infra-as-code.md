
# Introduction à Terraform

## Principaux avantages de l’Infra As Code

* Le déploiement de l’infrastructure est automatisé :
  * le temps de déploiement est réduit
  * le risque d’erreur est réduit
  * un seul référentiel pour déployer de nombreux environnements
* Configuration management de l’infrastructure
  * imposer une configuration identique quelque soit l’environnement
  * mettre à jour massivement

##==##

# Introduction à Terraform

## Principaux avantages de l’Infra As Code

* Adoption des bonnes pratiques liées au monde du développement
  * Versioning (réutilisation et partage du code, gestion des versions, traçabilité, suivi des incidents, revue de code et backup)
  * Documentation
  * Testing

Notes:
Source Code Management :

Re-usable : store on public hub, everyone can clone = easy to share !

Version control : See the diff !

Traceability : Who did this modification ?!

Backup : OMG I lost all of my changes...

Documentation : Le code est lisible et commenté

Testing : chaque ressource est testée et correspond au besoin fonctionnel; framework de tests (unitaire + intégration) intégré au langage HCL depuis la v1.6


##==##

# Introduction à Terraform

## Principaux avantages de l’Infra As Code

* “Do It Yourself”
  * l’utilisateur peut déployer des modèles déjà existants
  * les templates ont été validés et respectent bien l’urbanisation de l’entreprise

Notes:
  Fournir aux équipes de dev dans l'entreprise des modèles de déploiement de composants en "self-service"
##==##

# Introduction à Terraform

![](./assets/images/g418fd663c2_0_203.png)

Notes:
Le dévelopeur a, à sa disposition, un ensemble de modules développés par les équipes d’infrastructure pour déployer ses environnements/applications tout en respectant les règles de sécurité et d’urbanisation

##==##

# Terraform

## Produit Open-source

![float-left h-200](./assets/images/g418fd663c2_0_224.png)

* <https://github.com/hashicorp/terraform>

  * 48k+ stars
  * 2300+ contributeurs
  * Sous licence BSL (Business Source License) depuis août 2023
  * HashiCorp acquis par IBM (27 février 2025)

* Suite au changement de licence, un fork sous licence MPLv2 a vu le jour : [OpenTofu](https://opentofu.org)


Notes:
Produit développé en Go.
Sous licence BSL (Business Source License) depuis août 2023.
HashiCorp a été acquis par IBM le 27 février 2025 pour $6.4B — pas de reversion à open source prévue.
En désaccord avec HashiCorp, un fork opensource a été initié par la communauté : OpenTofu (MPLv2)
OpenTofu a divergé techniquement depuis avec des fonctionnalités propres :
- Chiffrement natif du state (v1.7, mi-2024)
- Support OCI registry (v1.10, sept 2025)
- S3 locking sans DynamoDB (v1.10) — aussi dispo côté Terraform 1.10 via `use_lockfile`
- Meta-argument `enabled` sur les ressources (v1.11)

Note : les *ephemeral values/resources* ne sont pas propres à OpenTofu, elles ont été introduites côté Terraform (v1.10, nov 2024) et sont aussi disponibles dans OpenTofu.

##==##

<!-- .slide: class="flex-row"-->

# Terraform

Workflow agnostic != Cloud agnostic

![](./assets/images/g418fd663c2_0_213.png)

Notes:
Attention, on entend beaucoup dire que Terraform est “Cloud agnostic”. C’est faux ! Le code nécessaire aux déploiements sera différent en fonction de la plateforme sur laquelle le développeur souhaite déployer son infra.

Le Workflow de déploiement quand à lui restera identique c’est pour cela qu’on parle de “Workflow agnostic”.

Terraform est multi provider, il peut créer des ressources autant sur des plateformes cloud (AWS, GCP, Azure, …) que sur des plateformes PAAS (Github, Heroku, …)

##==##
<!-- .slide: class="flex-row"-->

# La théorie des graphes

![h-700](./assets/images/theorie-des-graphes.png)

Notes:
Terraform analyse les ressources et dépendances puis construit un graphe puis provisionne les noeux des feuilles vers le sommet. Si l’arbre ne peut pas être construit, terraform retournera une erreur lors de l’analyse.
On peut le visualiser via la commande terraform graph / ou en augmentant le niveau de log de terraform (TF_LOG=debug)

##==##
<!-- .slide -->

# Gestion des versions dans Terraform

Terraform utilise le **semantic versioning** (`x.y.z`) :

- **x** : version majeure (changements incompatibles)
- **y** : version mineure (ajouts compatibles)
- **z** : correctif (bugfixes)

⚠️ De nombreuses incompatibilités existent entre les versions (langage et fonctionnement interne).

**Exemples :**
- Une infrastructure en **Terraform 0.11** doit être **progressivement rafraîchie** pour migrer vers **1.0.0**.
- Du code écrit pour **0.12** **n'est pas compatible** avec **0.11** (nouvelles fonctionnalités : types, boucles, etc.).

Notes:

Expliquer l'historique des versions


##==##
<!-- .slide -->

# Pourquoi une 1.0.0 ?

<br>

Ce qu'il faut retenir de la version 1.0 :
[Terraform 1.0 general availability](https://www.hashicorp.com/blog/announcing-hashicorp-terraform-1-0-general-availability)

* Utilisation massive (de 100,000,000 de téléchargement)
* Les cas d'utilisation sont compris (1,500 contributions, 11,000 pull requests)
* Une expérience utilisateur complète (documentation, formations, ...)
* Architecture stable

Notes:
Version actuelle 1.14.8 (Mars 2026), 1.15.0-beta disponible

Historique rapide des versions :
- **0.1** (juil 2014) : première release
- **0.7** (2016) : remote state, terraform import, state environments
- **0.9** (2017) : remote backends (S3, GCS, etc.)
- **0.11** (2017) : dernière version avant la réécriture du langage
- **0.12** (mai 2019) : réécriture majeure du HCL (HCL2) — types riches, boucles for, expressions conditionnelles. Code 0.11 incompatible.
- **0.13** (2020) : required_providers avec source, count/for_each sur les modules
- **0.14** (déc 2020) : sensitive variables, lockfile des providers (.terraform.lock.hcl)
- **0.15** (2021) : -replace (début de la deprecation de taint)
- **1.0** (juin 2021) : garantie de stabilité et compatibilité. Essentiellement 0.15 stabilisé.
- **1.1** (déc 2021) : moved blocks (refactoring sans destroy/recreate)
- **1.5** (juin 2023) : import block déclaratif, check blocks
- **1.6** (oct 2023) : terraform test (framework de tests natif)
- **1.7** (mars 2024) : removed blocks, mock providers dans les tests
- **1.8** (2024) : provider-defined functions
- **1.10** (nov 2024) : ephemeral values (gestion des secrets dans le state)
- **1.11+** (2025-2026) : stabilisation, améliorations incrémentales

La 1.0 marque le moment où HashiCorp considère le langage et le workflow comme stables. Avant, chaque version mineure pouvait casser la compatibilité.

