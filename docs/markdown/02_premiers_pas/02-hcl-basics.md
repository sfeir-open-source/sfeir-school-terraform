<!-- .slide: -->

# Le Hashicorp Configuration Language
<br/>

Le HCL est un langage déclaratif décrivant un état désiré (DSL) plutôt que les étapes de cet objectif.

Notes:
- Langage de configuration développé par HashiCorp et ré-utilisé dans ses différents produits. Uniquement déclaratif, il est associé au HIL (HashiCorp Interpolation Language) lorsqu’il faut calculer des valeurs.

##==##
<!-- .slide: -->

# Les Resources

<br/>

Les ressources sont l'élément de base de **Terraform** car elles décrivent une ou plusieurs ressources cloud comme par exemple des réseaux virtuels, des instances ou d'autres composants de haut niveau tels que des enregistrements DNS.

Les *resources* dépendent du provider sur lequel nous souhaitons travailler.

Exemple:
```hcl-terraform
resource "aws_instance" "web"{
  ami           = "ama-1b2c3d4"
  instance_type = "t2.micro"
}
```

Notes:
* **Attention** : Certaines ressources ont des relations particulières et nécessite le déploiement d'une ou plusieurs ressources. Dans ce cas, nous avons recours au *meta-argument* **depends_on**
* Les dépendances entre ressources peuvent être établies de deux manières différentes : implicites ou explicites.

##==##
<!-- .slide: -->

# Les providers

<br/>

Un provider correspond à un ensemble de ressources, chacune de ces ressources est définie par un ou plusieurs arguments et attributs.
Chaque provider fait appel à l'API correspondant à un service *cloud* ou *on-premise*.

Notes:
* Certains providers ne sont pas officiellement supportés par **Hashicorp** mais sont tout de même utilisable avec **Terraformm**.
* Les arguments du bloc provider diffèrent d'un provider à l'autre, certains sont similaire (AWS et AliCloud - par exemple).
* Parmis les provider non supportés officiellement par hashicorp, on peut retrouver kubectl et Artifactory

##==##

# Utilisation

## Workflow

![w-1000 center](./assets/images/workflow.png)
