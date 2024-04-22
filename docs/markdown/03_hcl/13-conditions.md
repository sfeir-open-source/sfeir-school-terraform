<!-- .slide: class="with-code-bg-dark"-->

# HCL extended (also known as HIL)

## Conditions

Les conditions permettent de définir des valeurs différentes en fonction des variables ou d’autres attributs.

```hcl-terraform
resource "google_compute_instance" "web" {
   machine_type = var.env == "production" ? var.prod_size : var.dev_size
}
```