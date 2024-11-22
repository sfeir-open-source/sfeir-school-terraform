<!-- .slide: class="with-code-bg-dark" -->

# HashiCorp Configuration Language (HCL)

## Output

Les outputs sont affichés en surbrillance à la fin du déploiement Terraform.

Ils permettent aux utilisateurs d’afficher des attributs calculés ou retournés par le provider.
<br>
<br>

```hcl-terraform
output "addresses" {
 value = [aws_instance.web.*.public_dns]
}
```
