<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

Avant la version 0.12, Terraform était composé de deux langages :

* le **HCL** (HashiCorp Configuration Language) pour la déclaration des resources, les inputs, les outputs, ...
* le **HIL** (HashiCorp Interpolation Language) pour permettre aux utilisateurs de manipuler la donnée (utilisation de variable, modification de la casse, création de liste, ..).

Depuis la version 0.12, HCL et HIL ont fusionné.

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

Il est possible de manipuler des variables, récupérer des attributs d’autres ressources ou utiliser des fonctions native directement dans notre code :

```hcl-terraform
locals {
  greeting_vars = {
    hello = "goodnight"
    world = "moon"
  }
}

resource "aws_instance" "web" {
  ami              = "ami-d05e75b8"
  instance_type    = "t2.micro"
  user_data_base64 = base64encode(templatefile("templates/greetings.tpl", local.greeting_vars))
}
```

##==##

# HCL Extended

## Lire les attributs

Il est possible de lire la valeur d’un attribut d’une ressource, d’une source de donnée, d’une variable, …

* resource : `resource_type.resource_name.attribut`
* variable : `var.variable_name`
* module : `module.module_name.output_name`
* data source : `data.data_type.data_name.attribut`

Cas d’une liste de resource : `resource_type.resource_name[<index>].attribut`

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

## Fonctions

Il existe de nombreuses fonctions pour manipuler les valeurs d'attributs [documentées en ligne](https://www.terraform.io/docs/language/functions/index.html).

Exemple d’utilisation :

```hcl-terraform
  count     = length(var.shortnames)
  upper-foo = upper(var.foo)
  encoded   = base64encode(var.sensitive_content)
```
Notes:
Certaines fonctions sont issues de providers basiques qui ont été intégrés en tant que fonction "builtin" (ex: templatefile)