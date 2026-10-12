<!-- .slide:-->

# Force re-create

## Option -replace

- terraform plan -var-file=file -replace=aws_volume.data_ebs
  <br> <span style="color:green"># Une ressource</span>
- terraform plan -var-file=file -replace=aws_volume.data_ebs[1]
  <br> <span style="color:green"># Une ressource dans une boucle</span>
- terraform plan -var-file=file -replace=module.module1.module.module2.aws_volume.data_ebs[1]
  <br> <span style="color:green"># Une ressource dans une boucle dans un module</span>
- terraform apply -var-file=file -replace=aws_volume.data_ebs
  <br> <span style="color:green"># Recréation lors d'un apply</span>

Notes:
Remplace terraform taint (deprecated depuis v0.15.2)
-replace montre la recréation directement dans le plan output, plus explicite

##==##

<!-- .slide: class="with-code-bg-dark"-->

# Force re-create

## Terraform import

- Permet à l’utilisateur d’importer une ressource existante dans le fichier d’état

Commande CLI (méthode classique) :
- terraform import google_compute_project_metadata_item.default ssh-keys

Bloc déclaratif (depuis v1.5, recommandé) :

```hcl-terraform
import {
  id = "ssh-keys"
  to = google_compute_project_metadata_item.default
}

resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "user:ssh-ed25519 AAAA... user"
}
```

Notes:
Le bloc import {} est recommandé depuis v1.5 — plus maintenable, versionnable dans le code
Le bloc import seul ne suffit pas : la ressource cible (to) doit exister dans le code, sinon erreur au plan
terraform plan -generate-config-out=generated.tf génère le bloc resource à partir de l'existant (à relire)
Depuis v1.7 : support de for_each pour importer plusieurs ressources d’un coup
Import vs data :
- import : Terraform prend la gestion de la ressource. Elle entre dans le state, il peut la modifier et la détruire (terraform destroy la supprime)
- data : lecture seule. Terraform lit la ressource à chaque plan pour utiliser ses attributs, sans jamais la modifier ni la détruire
- Règle : import si la ressource doit être gérée par ce code, data si elle appartient à une autre équipe ou un autre state
Voir : https://developer.hashicorp.com/terraform/language/import


##==##

<!-- .slide: class="with-code-bg-dark"-->

# terraform_data et provisioners

## terraform_data (depuis v1.4)

Ressource native (sans provider) qui stocke une valeur dans le state, déclenche le remplacement d'autres ressources et porte des provisioners.

Remplace `null_resource` (soft-deprecated).

```hcl-terraform
resource "terraform_data" "upper" {
  triggers_replace = var.name == "" ? local.default_name : upper(var.name)
}

resource "terraform_data" "app_version" {
  input = var.app_version
}

resource "google_compute_instance" "app" {
  # ...
  lifecycle {
    replace_triggered_by = [terraform_data.app_version]
  }
}
```

Notes:
- Remplace null_resource depuis v1.4, sans provider. triggers devient triggers_replace
- Exemple upper : c'est la fonction upper() qui transforme la valeur, terraform_data la stocke dans le state. Si la valeur change, la ressource est remplacée
- input : valeur stockée dans le state, relue via l'attribut output
- Exemple app_version : replace_triggered_by n'accepte que des références à des ressources, pas une variable. terraform_data sert d'intermédiaire : changer var.app_version modifie terraform_data.app_version, ce qui force le remplacement de l'instance
Voir : https://developer.hashicorp.com/terraform/language/resources/terraform-data



##==##

# terraform_data et provisioners

## provisioners

Les provisioners exécutent des scripts pendant les phases de création ou de destruction d'une ressource.

Trois provisioners built-in :

- `local-exec` — commande sur la machine qui lance Terraform
- `remote-exec` — commande sur la ressource cible (SSH / WinRM)
- `file` — copie un fichier vers la ressource cible

Les provisioners vendor (`chef`, `puppet`, `salt-masterless`, `habitat`) ont été **retirés depuis Terraform 0.13**.

Notes:
Documentation officielle : https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
Chef/Puppet/Salt-masterless/Habitat retirés depuis Terraform 0.13 (août 2020)
Le provisioner Ansible communautaire (radekg/terraform-provisioner-ansible) n'est plus maintenu activement

##==##

<!-- .slide: class="with-code-bg-dark"-->

# terraform_data et provisioners

## provisioners

```hcl-terraform
resource "terraform_data" "register" {
 depends_on       = [google_compute_instance.inst]

 provisioner "local-exec" {
   command = "register.sh ${google_compute_instance.inst.self_link}"
 }
}
```

##==##

# terraform_data et provisioners

## Les provisioners : dernier recours

HashiCorp recommande officiellement d'**éviter les provisioners** quand c'est possible.

Problèmes :

- Exécutés uniquement à la création (sauf replacement)
- Un échec taint la ressource
- Non idempotents — Terraform ne sait pas ce qu'ils font
- Couplage fort entre provisioning et configuration

Alternatives à privilégier :

| Besoin                           | Alternative                                        |
| -------------------------------- | -------------------------------------------------- |
| Bootstrap VM                     | `user_data`, `metadata_startup_script`, cloud-init |
| Image pré-configurée             | Packer (golden image)                              |
| Configuration management         | Ansible hors Terraform                             |
| Action déclenchée sur changement | `terraform_data` + `triggers_replace`              |

Notes:
"Provisioners are a Last Resort" — documentation officielle HashiCorp
https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax#provisioners-are-a-last-resort
Terraform est un outil de provisioning d'infra, pas de configuration management
Pattern moderne : Packer pour l'image + Terraform pour l'infra + Ansible (si besoin) lancé depuis le CI

##==##

# Debugging

<br>

Terraform propose un ensemble de variables d'environnements pour configurer le comportement des logs générés :

- `TF_LOG` : permet de définir la verbosité _TRACE, DEBUG, INFO, WARN, ERROR_
- `TF_LOG_PATH` : permet de définir le fichier de sortie
- `TF_LOG_CORE` et `TF_LOG_PROVIDER` sont des alternatives à `TF_LOG` pour différencier les logs Terraform et les logs des providers
