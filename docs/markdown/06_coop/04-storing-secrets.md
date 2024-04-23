<!-- .slide:-->

# Gestion des credentials

Il est possible d’utiliser les variables d’environnement pour fournir aux provider des identifiants. Chaque provider définit ses variables d’environnement.

Exemple :
* GOOGLE_CREDENTIALS
* GOOGLE_APPLICATION_CREDENTIALS
* VAULT_TOKEN
* AWS_ACCESS_KEY_ID
* ...

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Gestion des credentials

## Utilisation de Vault

<img style="position:fixed;top:10px;right:30px" src="./assets/images/g419a1b557d_2_152.png">

```hcl-terraform
data "vault_generic_secret" "rundeck_auth" {
 path = "secret/rundeck_auth"
}

provider "rundeck" {
 url        = "http://rundeck.example.com/"
 auth_token = data.vault_generic_secret.rundeck_auth.data["auth_token"]
}
```


_Attention, les attributs retournés par un data source apparaissent dans le fichier d’état (terraform.tfstate)_
