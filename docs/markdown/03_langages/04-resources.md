<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Resource
Les ressources sont les composantes de l’infrastructure.
Elles peuvent être une instance, un loadbalancer, une règle firewall, etc, …<br/>
Elles doivent respecter la syntaxe : resource "TYPE" "NAME”

```hcl-terraform
resource "google_compute_firewall" "default" {
 name    = "test-firewall"
 network = google_compute_network.default.name

 allow {
   protocol = "icmp"
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

## Resource - Meta-arguments

* **count** : Permet de créer plusieurs fois la ressource. count.index permet de récupérer l’index courant
* **for_each** : Pour créer plusieurs fois une ressource en utilisant une map ou une liste de strings (depuis 0.12 à privilégier par rapport à count)
* **lifecycle** : Permet de modifier le cycle de vie de la ressource
* **depends_on** : Forcer une dépendance
* **provider** : Permet de surcharger le provider de la ressource
* **timeouts** : Configurer les timeouts des opérations de création, modification et suppression
* **provisioner** : Permet d'exécuter des scripts en local ou à distance

Notes:
Example :

lifecycle : Permet de modifier le cycle de vie de la ressource (créer la nouvelle avant de supprimer l’ancienne, ignorer les changements d’un attributs, ...)

depends_on : Forcer une dépendance. Par défaut toute “variable interpolée” crée une dépendance implicite. Dans certains cas, il est necessaire d’expliciter la dépendance (exemple, créer une base de donnée avant le serveur d’application).

provider : Permet de surcharger le provider de la ressource par exemple lors de l’utilisation d’alias sur plusieurs providers.
