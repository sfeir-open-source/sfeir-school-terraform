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
Orchestrateur de jobs un peu similaire à Kube (master/workers), permet d'orchestrer des applications java, gcp nvidia, qemu...
Intègre consul et vault
(vagrant)
Learn to create development environments with Vagrant

(packer)
Learn to build automated machine images with Packer

##==##

# Introduction à Terraform

<br>

* Enjeux de l’infrastructure
* Automatisation de l’infrastructure
* Documentation à jour
* Multiples plateformes d’hébergements
* Augmenter l’agilité et l’autonomie (concept de “PizzaTeam”)
* Réduire les coûts

Notes:
/Principaux concepts

Automatisation de l’infrastructure => Réduire les actions sans valeurs ajoutées

Documentation => Maintenir une documentation des infrastructures déployées

Multiples plateformes d’hébergements => Utiliser le meilleur de chaque cloud providers (prix, features, régions, …); cloud-agnostic, plus de 4701 providers

“PizzaTeam” (augmenter l’agilité et l’autonomie) => Avoir l’autonomie de déployer des templates validées par des outils de sécurités au lieu de passer par un ticket/change order

Réduire les coûts => Dé-allouer sans risques les ressources inutiles, créer des environnements éphémères (build CI), ...

##==##

# Introduction à Terraform

![h-500 float-left](./assets/images/g418fd663c2_0_187.png)

<br><br><br><br>
Write, Plan, and Create Infrastructure as Code

Notes:
Infrastructure As Code :

L'infrastructure est décrite en texte

Terraform va convertir le texte en nombreux appels APIs vers la plateforme d’hébergement pour créer les “ressources” (serveurs, loadbalancers, règles firewalls, …)
