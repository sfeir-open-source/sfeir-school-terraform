<!-- .slide:-->

# Force re-create

## Terraform taint

* terraform taint aws_volume.data_ebs
<br/> <span style="color:green"># Une ressource</span>
* terraform taint aws_volume.data_ebs.1
<br/> <span style="color:green"># Une ressource dans une boucle</span>
* terraform taint -module=module1.module2.aws_volume.data_ebs.1<br/>
<span style="color:green"># Une ressource dans une boucle dans un module</span>


Raccourcis disponible pour taint lors du plan/apply avec l'option `-replace`

* terraform plan -var-file=file -replace=aws_volume.data_ebs
<br/> <span style="color:green"># Recréation lors d'un plan</span>
* terraform apply -var-file=file -replace=aws_volume.data_ebs
<br/> <span style="color:green"># Recréation lors d'un apply</span>

##==##
<!-- .slide:-->

# Force re-create

## Terraform import

* Permet à l’utilisateur d’importer une ressource existante dans le fichier d’état
* terraform import google_compute_project_metadata_item.default ssh-keys

##==##
<!-- .slide: class="with-code-bg-dark"-->

# null_resource et provisioners

## null_resource

Littéralement une ressource qui ne fait rien mais elle permet de manipuler des attributs, convertir des formats, lancer des scripts via les provisioners, ....

```hcl-terraform
resource "null_resource" "upper" {
 triggers {
   name = var.name == "" ? local.default_name : upper(var.name)
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# null_resource et provisioners

## provisioners

Les provisioners permettent d’executer des scripts durant les phases de création et suppression. Il existe plusieurs type de provisioners comme :

* local-exec et remote-exec pour un script local ou via SSH/RDP
* Puppet / Chef / Habitat
* Salt-masterless
* file pour déposer un fichier
* https://www.terraform.io/docs/provisioners/index.html
* Un provisionner non officiel Ansible existe mais n'est pas référencé sur le site officiel (https://github.com/radekg/terraform-provisioner-ansible)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# null_resource et provisioners

## provisioners

```hcl-terraform
resource "null_resource" "register" {
 depends_on       = [google_compute_instance.inst]

 provisioner "local-exec" {
   command = "register.sh ${google_compute_instance.inst.self_link}"
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->
# Debugging

<br/>

Terraform propose un ensemble de variables d'environnements pour configurer le comportement des logs générés :

- `TF_LOG` : permet de définir la verbosité *TRACE, DEBUG, INFO, WARN, ERROR*
- `TF_LOG_PATH` : permet de définir le fichier de sortie
- `TF_LOG_CORE` et `TF_LOG_PROVIDER` sont des alternatives à `TF_LOG` pour différencier les logs Terraform et les logs des providers
