<!-- .slide: -->

# Le HashiCorp Configuration Language

<br>

**HCL** est le langage utilisé pour écrire les fichiers `.tf`.

* Langage **déclaratif** : on décrit l'état désiré, pas les étapes pour y arriver
* Conçu pour être **lisible** par les humains et parsable par les machines
* Utilisé par plusieurs produits HashiCorp : Terraform, Vault, Nomad, Packer
* Alternative au JSON (Terraform accepte aussi le `.tf.json`)

Notes:

HCL = HashiCorp Configuration Language, développé en Go.
C'est un DSL (Domain Specific Language) : contrairement à un langage impératif (Python, Bash) où on écrit des étapes ("crée ceci, puis cela"), en HCL on décrit le résultat attendu et Terraform se charge de déterminer les actions nécessaires.
Exemple : on déclare "je veux 3 instances" et Terraform calcule s'il faut en créer, modifier ou supprimer.
HCL est volontairement plus lisible que JSON/YAML pour faciliter la revue de code et la collaboration.

##==##

<!-- .slide: class="with-code-bg-dark" -->

# Les Resources

<br>

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

- **Attention** : Certaines ressources ont des relations particulières et nécessite le déploiement d'une ou plusieurs ressources. Dans ce cas, nous avons recours au *meta-argument* **depends_on**
- Les dépendances entre ressources peuvent être établies de deux manières différentes : implicites ou explicites.

##==##

# Les providers

<br>

Un provider correspond à un ensemble de ressources, chacune de ces ressources est définie par un ou plusieurs arguments et attributs.
Chaque provider fait appel à l'API correspondant à un service *cloud* ou *on-premise*.

<https://registry.terraform.io/>

Notes:

- Certains providers ne sont pas officiellement supportés par **Hashicorp** mais sont tout de même utilisable avec **Terraformm**.
- Les arguments du bloc provider diffèrent d'un provider à l'autre, certains sont similaire (AWS et AliCloud - par exemple).
- Parmis les provider non supportés officiellement par hashicorp, on peut retrouver kubectl et Artifactory
- Il est possible de développer son propre provider en suivant le schéma de définition des providers terraform

##==##

# Utilisation

## Workflow

![w-1000 center](./assets/images/workflow.png)

Notes:
* terraform init : initialise le projet, télécharge providers et modules.
* Lecture des fichiers .tf et .tfvars pour définir la source d'infrastructure.
* terraform plan : prépare les changements ; terraform apply : applique les changements ; terraform destroy : supprime les ressources.
* Workflow simple et linéaire : init ➔ plan ➔ apply ➔ destroy.
