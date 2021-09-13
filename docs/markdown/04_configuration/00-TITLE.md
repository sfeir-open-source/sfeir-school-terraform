<!-- .slide: class="transition"-->

# Configuration de l’environnement de développement

##==##
<!-- .slide: -->

# Configuration de l’environnement de développement

## Aides au développement

<img style="position:fixed;top:15px;right:3px;height:700px" src="./assets/images/ide.png">


* Mise en forme
* Auto-completion
* Validation de syntaxe

<br/><br/><br/>
Liens : 
* [VScode : hashicorp.terraform](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform)
* [Hashivim](https://github.com/hashivim/vim-terraform) 
* [Intellij : Terraform](https://plugins.jetbrains.com/plugin/7808-hashicorp-terraform--hcl-language-support)

##==##
<!--.slide: class="two-column-layout"-->

# Configuration de l’environnement de développement

##--##
<!-- .slide: class="with-code-bg-dark" -->

<br/>

https://github.com/terraform-docs/terraform-docs

<br/> 

```bash
terraform-docs md . > README.md
```
<!-- .element: class="big-code" -->


##--##
<!-- .slide: class="center" -->

![float-center w-700](./assets/images/g418fd663c2_0_746.png)

##==##
<!-- .slide: -->
# Configuration de l’environnement de développement

## Gestion des fichiers et bonnes pratiques
Il n’y a pas de normes imposées par l’outil mais un ensemble de bonnes pratiques : 
* Tous les fichiers *.tf sont automatiquement analysés lors de l'exécution de terraform
* Il est possible de dissocier les variables et outputs du code
* Chaque “feature” peut faire l’objet d’un nouveau fichier .tf
* Les tests sont regroupés dans un dossier test
* Les modules peuvent être stockés localement

```
.
├── main.tf
├── Makefile
├── project.tf
├── README.md
├── outputs.tf
├── test
│   ├── fixtures
│   │   └── unit_tests_variables.tfvars
└── variables.tf
```

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Configuration de l’environnement de développement

## Gestion des fichiers et bonnes pratiques

* La communauté utilise le snake_case
* Il est important d’utiliser l’attribut description des variables
* L’utilisation du HCL permet de créer des scripts/programmes permettant de générer automatiquement la déclaration des variables 

```bash
alias terraform-genvar='(for i in $(egrep -oh '\''var\.\w+'\'' *.tf | sed -nr '\''s/var\.//p'\''); do echo "variable \"$i\" {}"; done;)'
```
<!-- .element: class="big-code" -->

* L’utilisation d’un .editorconfig permet aux développeurs d’utiliser un même format

##==##
<!-- .slide:-->

# Configuration de l’environnement de développement

## Configuration locale (CLI Configuration File)

Il est possible de configurer certains comportements de Terraform de manière globale à l'aide d'un fichier *.terraformrc* ou *terraform.rc*.

[*=> Documentation pour trouver la localisation du fichier par OS*](https://www.terraform.io/docs/cli/config/config-file.html) ou via la variable d'environnement *TF_CLI_CONFIG_FILE*

Cela permet par exemple de : 
- Mettre en cache les providers pour ne pas les télécharger dans chaque workspaces
- Configurer ses identifiants pour les registre de modules privés
- Surcharger des providers avec une version locale

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Est-il possible d’utiliser 2 ressources de même type et nom dans 2 fichiers différents ? 

<br/>

1. Oui
2. Non

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Est-il possible d’utiliser 2 ressources de même type et nom dans 2 fichiers différents ? 

<br/>

1. Oui
2. **Non**


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment déployer, mettre à jour ou supprimer une ressource parmis plusieurs sans impacter les autres ?

<br/>

1. Utilisation du paramètre -target
2. En commentant les autres
3. En créant un nouveau dossier contenant la déclaration de la ressource
4. Ce n’est pas possible

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Comment déployer, mettre à jour ou supprimer une ressource parmis plusieurs sans impacter les autres ?

<br/>

1. **Utilisation du paramètre -target**
2. En commentant les autres
3. En créant un nouveau dossier contenant la déclaration de la ressource
4. Ce n’est pas possible

##==##
<!-- .slide: class="exercice" -->

# Configuration de l’environnement de développement
 
## Atelier
