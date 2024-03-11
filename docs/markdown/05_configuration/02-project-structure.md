<!-- .slide: -->
# Configuration de l’environnement de développement

## Gestion des fichiers et bonnes pratiques
Il n’y a pas de normes imposées par l’outil mais un ensemble de bonnes pratiques :
* Tous les fichiers *.tf sont automatiquement analysés lors de l'exécution de terraform
* Il est possible de dissocier les variables et outputs du code
* Chaque “feature” peut faire l’objet d’un nouveau fichier .tf
* Les tests sont regroupés dans un dossier test
* Les modules peuvent être stockés localement
* Les valeurs par défaut pour les variables doivent être évitées

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
