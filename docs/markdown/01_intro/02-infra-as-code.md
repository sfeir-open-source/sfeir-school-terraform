
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

  * 45k+ stars
  * 1800+ contributeurs
  * Open source jusqu'en janvier 2024 puis sous licence BSL depuis

* Suite à ce changement de licence, un fork sous licence MPLv2 vu le jour : [OpenTofu](https://opentofu.org)


Notes:
Produit développé en Go.
Open source jusqu'au 1er Janvier 2024 puis sous license BSL (Business Source License) depuis.
En désaccord avec hashicorp, un fork opensource a été initié par la communauté : OpenTofu
Même fonctionnalités / syntaxe que la version originale 
Principales différences : évaluation anticipée des variables et chiffrement natif du tfstate

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

![h-700](./assets/images/g418fd663c2_0_305.png)

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
1.0 sortie en Juin 2021
Version actuelle 1.10.1 (4 Decembre 2024)
=======
- Expliquer rapidement l’historique des versions.
- Mentionner la stabilité introduite à partir de **Terraform 1.0**.

