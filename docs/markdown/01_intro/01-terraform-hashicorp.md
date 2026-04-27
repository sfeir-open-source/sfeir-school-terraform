<!-- .slide: class="flex-row"-->

# Introduction à Terraform

## La suite HashiCorp (IBM)

| Produit | Domaine | Statut |
|---------|---------|--------|
| **Terraform** | Infrastructure as Code | Actif |
| **Vault** | Gestion des secrets et chiffrement | Actif |
| **Consul** | Service mesh et service discovery | Actif |
| **Nomad** | Orchestration de workloads | Actif |
| **Packer** | Construction d'images machine | Actif (maintenance) |
| **Boundary** | Accès distant zero-trust | Actif |
| **Vagrant** | Environnements de dev locaux | Maintenance limitee |
| **Waypoint** | Deploiement applicatif | Arrete (open source) |

Notes:
IBM a finalise l'acquisition de HashiCorp en fevrier 2025 pour $6.4B. HashiCorp opere comme division IBM Software.

**Terraform** -- Provisionnement automatise d'infrastructure multi-cloud. Produit phare, integration avec Ansible (IBM) en cours.

**Vault** -- Gestion des secrets, chiffrement, identites machines (SPIFFE). Centralise les credentials, certificats et cles de chiffrement.

**Consul** -- Service discovery et service mesh. Gere la communication entre microservices (proxies, gateways, intentions).

**Nomad** -- Orchestrateur de workloads (containers, VMs, Java, batch). Alternative a Kubernetes, plus simple. S'integre avec Vault et Consul.

**Packer** -- Creation d'images machine (AMI, GCE images, Docker). Toujours maintenu mais moins mis en avant.

**Boundary** -- Acces distant securise base sur l'identite (remplace les VPN/bastions). Passwordless, session recording.

**Vagrant** -- Environnements de developpement locaux via VMs. En maintenance limitee, peu de nouveautes.

**Waypoint** -- Etait un outil de deploiement applicatif. Version open source arretee (aout 2023), remplacee par HCP Waypoint (SaaS).

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

Multiples plateformes d’hébergements => Utiliser le meilleur de chaque cloud providers (prix, features, régions, …); cloud-agnostic, plus de 6300 providers

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
