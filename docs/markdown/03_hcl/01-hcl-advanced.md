<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

<https://github.com/hashicorp/hcl>

Langage de configuration développé par HashiCorp. Depuis **HCL2** (Terraform 0.12+), il intègre nativement les expressions, fonctions et interpolations directement dans le langage.

Notes:
Historiquement, HCL était purement déclaratif et un second langage (HIL - HashiCorp Interpolation Language) gérait les calculs et interpolations. Depuis HCL 2.0, les deux ont été fusionnés en un seul langage. Plus besoin de distinguer HCL et HIL aujourd’hui.
Source : https://github.com/hashicorp/hcl — "Version 2.0 combines the features of HCL 1.0 with those of HIL to produce a single configuration language that supports arbitrary expressions."

##==##

# HashiCorp Configuration Language (HCL)

## Mots clefs pour Terraform

* **provider, variable, resource, module, output, data**
* Commentaires via # ou /\* … \*/ ou bien encore //
* Les valeurs sont assignées avec cette syntaxe : `key = value`
* Multi-line via <<EOF … EOF

##==##

<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Exemple

```hcl-terraform
provider "google" {
 region = "europe-west1"
}

resource "google_compute_instance" "instance" {
 name         = "demo"
 machine_type = "n1-standard-1"
 zone         = "europe-west1-a"
 tags         = ["web"]
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-12"
   }
 }
}
```
