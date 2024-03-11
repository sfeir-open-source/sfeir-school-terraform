<!-- .slide:-->

# HashiCorp Configuration Language (HCL)

https://github.com/hashicorp/hcl

Langage de configuration développé par HashiCorp et ré-utilisé dans ses différents produits. Uniquement déclaratif, il est associé au HIL (HashiCorp Interpolation Language) lorsqu’il faut calculer des valeurs.


##==##
<!-- .slide: -->

# HashiCorp Configuration Language (HCL)

## Mots clefs pour Terraform :
* **provider, variable, resource, module, output, data**
* Commentaires via # ou /* … */
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
 tags = ["web"]
 boot_disk {
   initialize_params {
     image = "debian-cloud/debian-12"
   }
 }
}
```
<!-- .element: class="big-code" -->
