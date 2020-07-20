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

Notes:
- Le choix de l'IDE est primordial avant même de se lancer dans l'utilisation de Terraform car il offre un confort d'utilisation supérieur par rapport à un éditeur de texte classique.
- Les fonctionnalités proposées vont de la coloration syntaxique à la complétion automatique.
- Intellij (en version payante) propose le plus haut niveau de fonctionnalité, cependant il est aussi possible d'utiliser VIM.

##==##
<!-- .slide: -->

# Les variables
<br/>

Plusieurs types de variables : 
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

# Les variables
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

# Le HCL
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

Notes:
- Un provider est en fait un driver développé par la communauté et en lien avec l'API d'un Cloud Provider.
Potentiellement, tout Cloud Provider proposant une API peut être utilisé comme Provider terraform.
- N'importe quel attribut d'une resource déployée peut être intérrogé et sorti en tant qu'output.
Ainsi il est possible d'interpoler une addresse IP d'une instance dans une autre ressource.
- Les modules permettent de donner au code terraform un look plus organisé. Ces modules peuvent provenir de votre propre repository github, du terraform registry ou être stocké localement.
Les modules peuvent échanger des données en interpolant des données provenant d'un module déclaré au préalable. 

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
<!-- .slide: class="exercice" -->

# Installation et configuration
 
## Atelier

