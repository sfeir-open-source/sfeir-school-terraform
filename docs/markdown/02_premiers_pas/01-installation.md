<!-- .slide:  -->
# Installation

- Binaires disponibles sur le [site officiel]("https://developer.hashicorp.com/terraform/install") (disponible pour tous les OS)
- Gestionnaire de paquets disponibles sur le [site officiel]("https://developer.hashicorp.com/terraform/install") :
  - macOS : `brew`
  - Linux : `apt`, `yum`, `dnf`, `brew`
- Alternatif :
  - [tfenv](https://github.com/tfutils/tfenv), puis plus récement [tenv](https://github.com/tofuutils/tenv)
  - Docker `alias tf="docker run --rm -it --env-file <(env | grep TF_) -w /source -v "$(pwd):/source" -v ${HOME}:/root/ hashicorp/terraform:1.0.5"`
  - via [asdf](https://github.com/asdf-community/asdf-hashicorp)
- Déjà pré-installé dans le Google Cloud Shell

![w-1000 center](./assets/images/g418fd663c2_0_272.png)

Notes:
Le logiciel est sous la forme d’un binaire (pré-compilé pour différents OS).

La communauté a quitté **tfenv** pour **tenv** qui devient aussi gestionnaire OpenTofu et Terragrunt en plus de Terraform

##==##

# Le choix de l'IDE

Plusieurs IDE disponibles :

- Intellij
- Atom
- Visual Studio Code
- Sublime Text
- VIM

Notes:

- Le choix de l'IDE est primordial avant même de se lancer dans l'utilisation de Terraform car il offre un confort d'utilisation supérieur par rapport à un éditeur de texte classique.
- Les fonctionnalités proposées vont de la coloration syntaxique à la complétion automatique.
- Intellij (en version payante) propose des fonctionnalités très avancées.
