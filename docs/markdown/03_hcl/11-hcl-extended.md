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

<!--.slide: class="two-column with-code-bg-dark"-->

# HCL Extended

## `templatefile()` : le fichier et son rendu

=> *cat templates/greetings.tpl*

```bash
#!/bin/bash
echo "${hello} ${world}"
```

##--##

<br><br><br>

=> ce que la ressource reçoit

```bash
#!/bin/bash
echo "goodnight moon"
```

Notes:
Le template est un vrai fichier bash : éditable, colorisé, testable seul. Terraform ne fait que remplacer les placeholders.
Attention : dans le template on écrit `${hello}`, pas `${local.greeting_vars.hello}`. Le template ne voit que la map passée en second argument.
Usage typique : sortir du HCL un artefact non-Terraform (script de démarrage, config nginx, cloud-init, policy JSON) tout en y injectant des valeurs calculées.

##==##
<!-- .slide: class="with-code-bg-dark"-->

# HCL Extended

## Directives de template

Le second argument accepte tous les types, pas seulement des chaînes :

```bash
upstream app {
%{ for ip in backend_ips ~}
  server ${ip}:8080;
%{ endfor ~}
}
```

```hcl-terraform
content = templatefile("${path.module}/backends.conf.tftpl", {
  backend_ips = google_compute_instance.app[*].network_interface[0].network_ip
})
```

Notes:
`%{ for }` / `%{ if }` sont des directives de template, à ne pas confondre avec l'interpolation `${ }`.
Le `~` supprime le retour à la ligne qui suit la directive, sinon le rendu est criblé de lignes vides.
C'est ce que l'ancien data source `template_file` ne savait pas faire : il n'acceptait que des variables de type string.

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

Il existe de nombreuses fonctions pour manipuler les valeurs d'attributs : [functions](https://www.terraform.io/docs/language/functions/index.html).

Exemple d’utilisation :

```hcl-terraform
  count     = length(var.shortnames)
  upper-foo = upper(var.foo)
  encoded   = base64encode(var.sensitive_content)
```
Notes:
Trois notions à ne pas confondre :
- **interpolation** : la syntaxe `${ ... }` qui insère une expression dans une chaîne (et `%{if}` / `%{for}` pour les directives)
- **fonction** : `upper()`, `templatefile()`, … intégrées au langage
- **template** : un fichier ou une chaîne à placeholders, rendu par une fonction

`templatefile()` n’est pas de l’interpolation : c’est la fonction qui l’applique à un fichier.

Historique : avant 0.12, pas de fonction de template (il fallait le data source `template_file`, provider aujourd’hui déprécié) et le `${}` était obligatoire partout. Depuis HCL2, les expressions sont natives et `${}` ne sert plus qu’à interpoler dans une chaîne.

Piège : `file()` n’interpole pas, elle retourne le contenu brut.
