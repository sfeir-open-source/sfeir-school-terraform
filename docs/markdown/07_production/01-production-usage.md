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
```

Notes:
Le bloc import {} est recommandé depuis v1.5 — plus maintenable, versionnable dans le code
Depuis v1.7 : support de for_each pour importer plusieurs ressources d’un coup
Voir : https://developer.hashicorp.com/terraform/language/import

##==##

<!-- .slide: class="with-code-bg-dark"-->

# terraform_data et provisioners

## terraform_data (depuis v1.4)

Ressource native (sans provider) qui permet de manipuler des attributs, convertir des formats, lancer des scripts via les provisioners.

Remplace `null_resource` (soft-deprecated).

```hcl-terraform
resource "terraform_data" "upper" {
  triggers_replace = var.name == "" ? local.default_name : upper(var.name)
}
```

Notes:
terraform_data remplace null_resource depuis v1.4 — pas besoin du provider null
triggers devient triggers_replace
terraform_data dispose aussi d'attributs input/output pour passer des données



##==##

# terraform_data et provisioners

## provisioners

Les provisioners permettent d’executer des scripts durant les phases de création et suppression. Il existe plusieurs type de provisioners comme :

- local-exec et remote-exec pour un script local ou via SSH/RDP
- Puppet / Chef / Habitat
- Salt-masterless
- file pour déposer un fichier
- https://www.terraform.io/docs/provisioners/index.html
- Un provisionner non officiel Ansible existe mais n'est pas référencé sur le site officiel (https://github.com/radekg/terraform-provisioner-ansible)

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

# Debugging

<br>

Terraform propose un ensemble de variables d'environnements pour configurer le comportement des logs générés :

- `TF_LOG` : permet de définir la verbosité _TRACE, DEBUG, INFO, WARN, ERROR_
- `TF_LOG_PATH` : permet de définir le fichier de sortie
- `TF_LOG_CORE` et `TF_LOG_PROVIDER` sont des alternatives à `TF_LOG` pour différencier les logs Terraform et les logs des providers
