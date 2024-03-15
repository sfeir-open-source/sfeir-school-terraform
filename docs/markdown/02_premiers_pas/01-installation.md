<!-- .slide:  -->
# Installation

* Via le package disponible sur le [site officiel]("https://www.terraform.io/downloads.html") (disponible pour tous les OS)

* Via Brew (MacOS) : `brew install terraform`

*  [tfenv](https://github.com/tfutils/tfenv) est un outil communautaire qui permets d'installer une version précise de terraform de façon assez pratique (MacOs et Linux)

* Déjà pré-installé dans le Google Cloud Shell

* Ou avec docker `alias tf="docker run --rm -it --env-file <(env | grep TF_) -w /source -v "$(pwd):/source" -v ${HOME}:/root/ hashicorp/terraform:1.0.5"`

![w-1000 center](./assets/images/g418fd663c2_0_272.png)

Notes:
Le logiciel est sous la forme d’un binaire (pré-compilé pour différents OS).

##==##
<!-- .slide: -->

# Le choix de l'IDE

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
