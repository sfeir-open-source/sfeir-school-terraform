<!-- .slide: class="transition"-->

# Premiers pas avec Terraform

##==##
<!-- .slide:  -->
# Installation

* Via le package disponible sur le [site officiel]("https://www.terraform.io/downloads.html") (disponible pour tous les OS)

* Via Brew (MacOS) : `brew install terraform`

*  [tfenv](https://github.com/tfutils/tfenv) est un outil communautaire qui permets d'installer une version précise de terraform de façon assez pratique (MacOs et Linux)

* Déjà pré-installé dans le Google Cloud Shell

![w-1000 center](./assets/images/g418fd663c2_0_272.png)

Notes:
Le logiciel est sous la forme d’un binaire (pré-compilé pour différents OS).

##==##
<!-- .slide: -->

# Le choix de l'IDE
<br/>

Plusieurs IDE disponibles :  
* Intellij
* Atom
* Visual Studio Code
* Sublime Text
* VIM

Notes:
- Le choix de l'IDE est primordial avant même de se lancer dans l'utilisation de Terraform car il offre un confort d'utilisation supérieur par rapport à un éditeur de texte classique.
- Les fonctionnalités proposées vont de la coloration syntaxique à la complétion automatique.
- Intellij (en version payante) propose des fonctionnalités très avancées.

##==##
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

Les ressources sont l'élément de base de **Terraform** car elles décrivent un ou plusieurs ressources cloud comme par exemple des réseau virtuels, des instances ou d'autres composants de haut niveau tels que des enregistrements DNS.

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

# Les provider

<br/>

Un provider correspond à un ensemble de ressources, chacune de ces ressources est défini par un ou plusieurs arguments et attributs.  
Chaque provider fait appel à l'API correspondant à un service *cloud* ou *on-premise*.  

Notes:
* Certains providers ne sont pas officiellement supportés par **Hashicorp** mais sont tout de même utilisable avec **Terraformm**.
* Les arguments du bloc provider diffèrent d'un provider à l'autre, certains sont similaire (AWS et AliCloud - par exemple).
* Parmis les provider non supportés officiellement par hashicorp, on peut retrouver kubectl et Artifactory 

##==##

# Utilisation

## Workflow

![w-1000 center](./assets/images/workflow.png)

##==##
<!-- .slide:-->

# Utilisation

## Terraform init

Cette commande permet d’initialiser le répertoire de travail courant.

* Lit le fichier configuration personnel ~/.terraformrc si existant 
* Télécharge les providers et provisioners nécessaires (officiels) sur https://releases.hashicorp.com/
* Instancie le fichier d’état (local ou distant)
* Effectue un “terraform get“ si nécessaire.

Notes:
Cette commande est nécessaire d’être joué dans chaque nouveau dossier mais également lors de l’ajout d’une ressource provenant d’un nouveau provider.

Elle permet également la migration d’un fichier d’état d’un support vers un autre (cf module gestion du fichier d’état).

##==##
<!-- .slide:-->

# Utilisation

## Terraform get

<br/>
Cette commande est utilisée pour télécharger les modules hébergés hors du répertoire courant.

<br/>

Les modules ainsi téléchargés seront stocké dans le dossier “.terraform” du répertoire courant (appelé root module).

##==##
<!-- .slide:-->

# Utilisation

## Terraform plan

Terraform plan va scanner l’ensemble des fichiers *.tf du répertoire courant et comparer le résultat au contenu du fichier d’état (“terraform.tfstate”).

<br/>

Il s’agit d’un dry-run.  Aucune modification/lecture ne sera effectuée sur le provider lors du 1er “plan”. Une relecture est fait par la suite pour comparer les états.

<br/>

Le résultat peut être exporté en utilisant l’argument “-out” pour une application déportée ou désynchronisée.

<br/>

Terraform ne modifie/crée que les ressources qui nécessitent une modification.

##==##
<!-- .slide:-->

# Utilisation

## Terraform apply

Lors de l'exécution de cette commande, terraform effectue les appels APIs sur le provider pour créer/modifier/supprimer les ressources.

##==##
<!-- .slide:-->

# Utilisation

## Terraform destroy

Terraform destroy décommissionne les ressources présentes (et uniquement) dans le fichier d’état. Il ne modifie pas les ressources dont il n’a pas connaissance.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le langage de programmation utilisé dans Terraform ?

<br/>

1. C++
2. Java
3. Golang
4. PHP

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quel est le langage de programmation utilisé dans Terraform ?

<br/>

1. C++
2. Java
3. **Golang**
4. PHP

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. Peut contenir de nombreux types différents

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Quelle est la particularité d'une variable de type *object* ?

<br/>

1. Le résultat est toujours ordonné
2. Ce n'est pas la plus utilisée
3. **Peut contenir de nombreux types différents**

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Comment observer le déploiement d'une infrastructure sans l'exécuter ?

<br/>

1. Impossible
2. terraform fmt
3. terraform init
4. terraform plan
5. terraform show

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Comment observer le déploiement d'une infrastructure sans l'exécuter ?

<br/>

1. Impossible
2. terraform fmt
3. terraform init
4. **terraform plan**
5. terraform show

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Qu'est-ce que n'est pas terraform ?

<br/>

1. Un outil de provisionning d'infrastructure
2. Un outils de gestion de configuration 

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Qu'est-ce que n'est pas terraform ?

<br/>

1. Un outil de provisionning d'infrastructure
2. **Un outils de gestion de configuration** 

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : (Par défaut)Où est stocké le fichier d'état de Terraform ?

<br/>

1. Localement, en mémoire
2. Localement, dans le dossier courant
3. Sur un espace de stockage distant

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Où est stocké le fichier d'état de Terraform ?

<br/>

1. Localement, en mémoire
2. **Localement, dans le dossier courant**
3. Sur un espace de stockage distant

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : A quel endroit exécute-t-on la commande terraform apply ?

<br/>

1. N'importe où ?
2. Au niveau du module racine
3. Dans chaque module

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : A quel endroit exécute-t-on la commande terraform apply ?

<br/>

1. N'importe où ?
2. **Au niveau du module racine**
3. Dans chaque module

##==##
<!-- .slide: class="exercice" -->

# Installation et configuration
 
## Atelier

