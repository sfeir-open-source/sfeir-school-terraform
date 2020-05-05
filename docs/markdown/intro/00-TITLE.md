<!-- .slide: class="transition"-->  

# Introduction à Terraform

##==##
<!-- .slide: class="flex-row"-->

# Introduction à Terraform

![h-800](./assets/images/g418fd663c2_0_148.png)

Notes:
(vault)
Learn about secrets management and data protection.

(consul)
Learn how to run service discovery and a service mesh with Consul.

(terraform)
Learn about automated infrastructure provisioning.

(nomad)
Learn how to deploy and manage any containerized, legacy, or batch application.

(vagrant)
Learn to create development environments with Vagrant

(packer )
Learn to build automated machine images with Packer

##==##
<!-- .slide: -->

# Introduction à Terraform
<br/>

* Enjeux de l’infrastructure
* Automatisation de l’infrastructure
* Documentation à jour
* Multiples plateformes d’hébergements
* Augmenter l’agilité et l’autonomie (concept de “PizzaTeam”)
* Réduire les coûts

Notes:
Automatisation de l’infrastructure => Réduire les actions sans valeurs ajoutées

Documentation => Maintenir une documentation des infrastructures déployées

Multiples plateformes d’hébergements => Utiliser le meilleur de chaque cloud providers (prix, features, régions, …)

“PizzaTeam” (augmenter l’agilité et l’autonomie) => Avoir l’autonomie de déployer des templates validées par des outils de sécurités au lieu de passer par un ticket/change order

Réduire les coûts => Dé-allouer sans risques les ressources inutiles, créer des environnements éphémères (build CI), ...

##==##
<!-- .slide: -->

# Introduction à Terraform

![h-500 float-left](./assets/images/g418fd663c2_0_187.png)

<br/><br/><br/><br/>
Write, Plan, and Create Infrastructure as Code

Notes:
Infrastructure As Code : 

L'infrastructure est décrite en texte

Terraform va convertir le texte en nombreux appels APIs vers la plateforme d’hébergement pour créer les “ressources” (serveurs, loadbalancers, règles firewalls, …)

##==##
<!-- .slide: -->

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
<!-- .slide: -->

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

Testing : chaque ressource est testée et correspond au besoin fonctionnel

##==##
<!-- .slide: -->

# Introduction à Terraform

## Principaux avantages de l’Infra As Code

* “Do It Yourself”
  * l’utilisateur peut déployer des modèles déjà existants
  * les templates ont été validés et respectent bien l’urbanisation de l’entreprise

##==##
<!-- .slide:-->

# Introduction à Terraform


![](./assets/images/g418fd663c2_0_203.png)

Notes:
Le développer a à sa disposition un ensemble de modules développés par les équipes d’infrastructure pour déployer ses environnements/applications tout en respectant les règles de sécurité et d’urbanisation

##==##
<!-- .slide: -->

# Terraform

## Produit Open-source

![float-left h-300](./assets/images/g418fd663c2_0_224.png)

* https://github.com/hashicorp/terraform

  * 18k+ stars
  * 1300+ contributeurs

Notes:
Produit OpenSouce développé en Go

##==##
<!-- .slide: class="flex-row"-->

# Terraform
<br>
Workflow agnostique != Cloud agnostique


![](./assets/images/g418fd663c2_0_213.png)

Notes:
Attention, on entend beaucoup dire que Terraform est “Cloud agnostique”. C’est faux ! Le code nécessaire aux déploiements sera différent en fonction de la plateforme sur laquelle le développeur souhaite déployer son infra.

Le Workflow de déploiement quand à lui restera identique c’est pour cela qu’on parle de “Workflow agnostique”.

Terraform est multi provider, il peut créer des ressources autant sur des plateformes cloud (AWS, GCP, Azure, …) que sur des plateformes PAAS (Github, Heroku, …)

##==##
<!-- .slide: class="flex-row"-->

# La théorie des graphes

![h-700](./assets/images/g418fd663c2_0_305.png)
    
Notes:
Terraform analyse les ressources et dépendances puis construit un graphe puis provisionne les noeux des feuilles vers le sommet. Si l’arbre ne peut pas être construit, terraform retournera une erreur lors de l’analyse.
