<!-- .slide: class="transition"-->

# Premiers pas avec Terraform

##==##
<!-- .slide:  -->
# Installation

<br/>

* Un mode d'installation (disponible pour tous les OS)  
via le package disponible sur le [site officiel]("https://www.terraform.io/downloads.html")  

* Un autre mode d'installation nécessitant compilation du binaire.

* Un mode d'installation disponible uniquement pour MacOS :  
`brew install terraform`

* Un dernier mode d'installation est disponible et permet d'utiliser plusieurs versions différentes de Terraform sur une même machine : **tfenv**  
Le guide d'installation et d'utilisation se trouve ici : https://github.com/tfutils/tfenv

Notes:
Il est également possible de l'utiliser sur les Cloud Shells de chaque provider Cloud.
Il est déjà installé sur celui de Google Cloud.

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
Le **Terraform HCL** introduit les concepts suivants : 

| Concept | Explication |
| ------- | ----------- |
| Provider | Regroupe toute les informations relative au provider |
| Resource | Décrit la ressource à déployer à l'aide de mots clés optionels ou non|
| Datasource | Afin de récupérer diverses informations depuis la platforme cloud cible |
| Output | Représente les valeurs de retour d'un module |
| Backend | Permet de sauvegarder le fichier d'état autre part que localement | 
| Modules | Appels d'une resource ou d'un groupe de ressource réutilisable |
| Locales | Désigne un nom ou une expression destinée à être utilisée plusieurs fois |
| Inputs | Il s'agit des variables servant de paramètres aux modules Terraform |

Notes:
- Un provider est en fait un driver développé par la communauté et en lien avec l'API d'un Cloud Provider.
Potentiellement, tout Cloud Provider proposant une API peut être utilisé comme Provider terraform.
- N'importe quel attribut d'une resource déployée peut être intérrogé et sorti en tant qu'output.
Ainsi il est possible d'interpoler une addresse IP d'une instance dans une autre ressource.
- Les modules permettent de donner au code terraform un look plus organisé. Ces modules peuvent provenir de votre propre repository github, du terraform registry ou être stocké localement.
Les modules peuvent échanger des données en interpolant des données provenant d'un module déclaré au préalable. 

##==##
<!-- .slide: -->

# Les provider
Un provider correspond a un ensemble de ressources, chacune de ces ressources est défini par un ou plusieurs arguments et attributs.  
Chaque provider fait appel à l'API correspondant à un service *cloud* ou *on-premise*.  
Chaque bloc **Provider** défini dans une configuration **Terraform** nécessite une configuration particulière tels que : 
* Endpoints URLs
* Région
* Paramètres d'authentification
* ID de projet
* Version du driver
* Alias

Certains providers ne sont pas officiellement supportés par **Hashicorp** mais sont tout de même utilisable avec **Terraformm**.

Notes:
Les arguments du bloc provider diffèrent d'un provider à l'autre, certains sont similaire (AWS et AliCloud - par exemple).
Parmis les provider non supportés officiellement par hashicorp, on peut retrouver kubectl et Artifactory 

##==##
<!-- .slide: -->

# Les Resources
Les ressources sont l'élément de base de **Terraform** car elles décriver un ou plusieurs objets de l'infrastructure tels que des réseau virtuels, des instances ou d'autres composants de haut niveau tels que des enregistrements DNS.  
Dans le cas de **Kubernetes**, il s'agit surtout de **Deployment**, **Services**, **Pods**, **DaemonSets**, etc...
Les *resources* dépendent du provider sur lequel nous souhaitons travailler.

La déclaration d'un objet *resource* peut inclure des options très avancées mais seul un ensemble d'option est obligatoire pour usage basique, par exemple : 
```hcl-terraform
resource "aws_instance" "web"{
  ami           = "ama1b2c3d4"
  instance_type = "t2.micro"
}
```

**Attention** : Certaines ressources ont des relations particulières et nécessite le déploiement d'une ou plusieurs ressources. Dans ce cas, nous avons recours au *meta-argument* **depends_on**

Notes:
* Les dépendances entre ressources peuvent être établies de deux manières différentes : implicites ou explicites.
* Il n'y a pas de recommandation particulière pour chacune des méthodes, chaque provider propose ses propres best practices.

##==##
<!-- .slide: -->

# Les Datasources
Les *datasources* sont des données que **Terraform** va récupérer sur la plateforme du provider afin de les injecter dans la configuration afin d'éviter de coder en dur les informations qui pourraient : 
- être confidentielles (dans le cas de mot de passe ou certificats)  
- être dynamiques (dans le cas d'adresses IP ou de noms provenant d'un serveur DNS)

Chaque provider propose ses propres *datasources* liées aux *resources* qui'il permet de déployer.
```hcl-terraform
data "aws_ami" "web" {
  provider = "aws.west"
  owners = []
}
```

Notes:
Les datasources sont des données qui ne figurent pas dans le fichier d'état sur le backend mais dans les métadonnées du provider.

##==##
<!-- .slide: -->

# Les Outputs

Les Outputs sont des valeurs de retour d'argument d'un module ou d'une ressource définie dans la configuration et ont plusieurs usages : 
* Un module enfants peut utiliser un output pour exposer un ou plusieurs attributs d'une resource d'un module parent  
* Un module racine peut utiliser des outputs pour afficher certaines valeurs via la commande `terraform apply`  
* En utilisant la commande `terraform state`, d'autres configurations peuvent accéder a des outputs d'un autre module racine à l'aide de `terraform_remote_state` (voir ci-dessous) :  
```hcl-terraform
data "terraform_remote_state" "network" {
    backend = "s3"
    config {
      bucket  = "tf_state/networking"
      key     = "networking.tfstate"
    }
}
```

Notes:
Sans outputs, un module enfant ne pourra pas utiliser de données provenant d'un module parent.

##==##
<!-- .slide: -->

# Les Locales  

Une *locale* assigne un nom à une expression, ce qui permet de l'utiliser à de nombreuses reprises dans un module sans avoir à la répéter.  
Par analogie avec un langage de programmation dit *traditionnel*, une *locale* est comparable avec les fonctions.

```hcl-terraform
locals {
  instance_ids = concat(aws_instance.blue.*.id, aws_instance.green.*.id)
}
locals {
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}
```

##==##
<!-- .slide: -->

# Les Modules

Un module est un *conteneur* de ressources (une ou plusieurs) pouvant être utilisé ensemble.  
Chaque configuration **terraform** contient au moins un module, le module racine et contient au moins les trois fichiers suivants :  

| Nom | Explications |  
| --- | ------------ |  
| main.tf | Contient la ou les ressource(s) du module |  
| variables.tf | Contient les variables qui serviront à paramétrer le module lorsqu'il sera appelé dans le module racine |  
| outputs.tf | Contient les valeurs de retour qui serviront à exposer les attributs du module | 

Lors de l'appel d'un module dans le module racine, l'argument **source** est obligatoire pour définir l'origine du module.  
Deux autres arguments sont disponibles (mais non obligatoire) :  
* **version** : dans le cas ou le module en question aurait plusieurs version utilisable  
* **provider** : dans le cas ou plusieurs comptes sur la plateform cloud seraient utilisable

##==##
<!-- .slide: -->

# Les Inputs
<br/>

Plusieurs types d'inputs : 
* String
* Number
* Bool
* List(type)
* Set(type)
* Map(type)
* Object({\<ATTRIBUTE\>=\<TYPE\>})
* Tuple(\[\<TYPE\>,...\])

Notes:
- String, Number et Bool sont des types simple
- List, Map, Set, Object et Tuples sont des complexes
- Depuis la sortie de la version 0.12 et du HCL 2.0, les variables ont été retravaillées.
- Vous disposez de plus de contrôle sur les variables et pouvez iterrer dessus à l'aide de for et for_each (qui n'étaient pas disponible dans les versions précédentes).
- Vous n'avez pas besoin de préciser le type de variable, mais c'est tout de même recommandé.

##==##
<!-- .slide: -->

# Les Inputs
<br/>

**List**, **Set**, **Object**, **Tuple** et **Map** :
* List et Set : [0,19,1,5,45,4,90,3]  
* Map : {"key" = "value"}
* Tuple : [0, string, false, {"key" = "value"}]
* Object : {"key1" = string, "key2" = number, "key3" = bool, "key4" = Tuple}

Notes:
- Une variable de type list est toujours ordonnée et renverra toujours le résultat dans le même ordre.
- Une variable de type set se comporte plus ou moins de la même manière que la list, mais ne conserve pas l'ordre des données
- Une variable de type Object resemble plus ou moins à une variable de type Map mais peut contenir des éléments de type différents
- Une variable de type Tuple ressemble plus ou moins à une variable de type List, mais peut contenir des éléments de type différents.
- Les types de variables que l'on peut rencontrer le plus souvent sont string, number, bool, list et map.

##==##
<!-- .slide: -->

# Aperçu des commandes - 1ère partie
<br/>

| Commandes | Description |
| --------- | ----------- |
| init | initie le backend (local ou distant) |
|      | lit le fichier de configuration .terraformrc |
|      | télécharge les drivers provider et effectue un terraform get (si nécessaire) |
| plan | affiche la configuration ainsi que ses éventuelles modifications sans l'exécuter|
| apply | applique la configuration |
| destroy | détruit tout ce qui a été déployé en s'appuyant sur un fichier d'état|
| fmt | réécrit les fichiers de configuration "au propre" |
| get | Télécharge et met les modules à jour |
| graph | Crée une représentation visuelle de la configuration du plan d'exécution |
| import | importe la resource identifiée dans le fichier d'état |

##==##
<!-- .slide: -->

# Aperçu des commandes - 2nde partie
<br/>

| Commandes | Description |
| --------- | ----------- |
| output | Affiche l'output de certaines ressources |
| push | S'utilise conjointement avec Atlas, l'outils de Terraform Enterprise |
| refresh | Permet d'identifier les différences entre des fichiers d'état locaux et distant |
| remote | Configuration de backend distant |
| show | Affiche, en format "humainement lisible" un fichier d'état ou un plan |
| workspace | Gestion d'espaces virtuels permettant de stocker des fichiers de variables |
| providers | Affiche les informations relative au provider utilisé |
| console | Affiche une console dans le but d'évaluer des expressions |
| force-unlock | Déblocage manuel du fichier d'état |

##==##
<!-- .slide: -->

# Aperçu des commandes - 3eme partie
<br/>

| Commandes | Description |
| --------- | ----------- |
| state | Gestion avancée de fichiers d'état, exemple renommage de ressource |
| taint | "marque" une ressource afin qu'elle soit supprimée et recréée au prochain apply |
| untaint | Supprime le marquage de la ressource |
| validate | valide la syntaxe |
| login | A utiliser pour obtenir un token API pour terraform Cloud ou Terraform Enterprise |
| logout | A utiliser pour supprimer le token API - suite à un terraform login |

##==##
<!-- .slide: -->

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
2. **Ce n'est pas la plus utilisée**
3. **Peut contenir de nombreux types différents**

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Avec quel type d'instruction est-il possible d'iterrer ?

<br/>

1. Aucun
2. count
3. lenght
4. for
5. for_each

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : Avec quel type d'instruction est-il possible d'iterrer ?

<br/>

1. Aucun
2. count
3. **lenght**
4. **for**
5. **for_each**

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

*Question* : Où est stocké le fichier d'état de Terraform ?

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
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : A quoi sert la commande *taint* ?

<br/>

1. A gérer le fichier d'état
2. A configurer un backend
3. A marquer une ressource

##==##
<!-- .slide: -->

# QUIZZ

<br/>

*Question* : A quoi sert la commande *taint* ?

<br/>

1. A gérer le fichier d'état
2. A configurer un backend
3. **A marquer une ressource**

##==##
<!-- .slide: class="exercice" -->

# Installation et configuration
 
## Atelier

