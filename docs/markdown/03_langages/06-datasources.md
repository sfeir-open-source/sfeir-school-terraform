<!-- .slide: class="with-code-bg-dark"-->

# HashiCorp Configuration Language (HCL)

## Data source

Le data source permet de récupérer des attributs non gérés par Terraform, et donc en lecture seule.

```hcl-terraform
data "google_compute_image" "my_image" {
 family  = "debian-12"
 project = "debian-cloud"
}

[...]
image = data.google_compute_image.my_image.self_link
```
<!-- .element: class="big-code" -->
