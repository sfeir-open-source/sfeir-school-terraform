<!-- .slide: class="transition"-->

# Utilisation en production

##==##
<!-- .slide:-->

# Force re-create

## Terraform taint

* terraform taint -var-file=file aws_volume.data_ebs
<br/> <span style="color:green"># Une ressource</span>
* terraform taint -var-file=file aws_volume.data_ebs.1
<br/> <span style="color:green"># Une ressource dans une boucle</span>
* terraform taint -var-file=file -module=module1.module2 aws_volume.data_ebs.1<br/>
<span style="color:green"># Une ressource dans une boucle dans un module</span>

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

```hcl
resource "null_resource" "upper" {
 triggers {
   name = "${var.name == "" ? local.default_name : var.name}"
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
* puppet / chef
* file pour déposer un fichier
* https://www.terraform.io/docs/provisioners/index.html 

##==##
<!-- .slide: class="with-code-bg-dark"-->

# null_resource et provisioners 

## provisioners

```hcl
resource "null_resource" "register" {
 depends_on       = ["google_compute_instance.inst"]
 provisioner "local-exec" {
   command = "register.sh ${google_compute_instance.inst.self_link}"   
 }
}
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# Déploiement continu

## Terraform workspace

L’état d’un déploiement est sauvegardé dans un fichier terraform.tfstate qu’il est possible d’exporter sur un stockage distant ou local (appelé backend).<br/>
Si l’utilisateur souhaite instancier plusieurs déploiements depuis un même backend, il peut utiliser la fonctionnalité de workspace.<br/>

Cas d’utilisations : 
* Dev/QA/Production
* Plusieurs régions

##==##
<!-- .slide:-->

# Déploiement continu 

##  Terraform workspace

* $ terraform workspace new  name
<br/><span style="color:green"># Créer un workspace</span> 

* $ terraform workspace list
<br/><span style="color:green"># Affiche la liste des workspaces</span>

* $ terraform workspace show
<br/><span style="color:green"># Affiche le workspace courant</span>

* $ terraform workspace select name
<br/><span style="color:green"># Se positionne dans un workspace</span>

* $ terraform workspace delete name
<br/><span style="color:green"># Supprime un workspace</span>

##==##
<!-- .slide: class="two-column-layout"-->

# Déploiement continu 

##--##
<!-- .slide: class="with-code-bg-dark" -->
```yaml
plan_production:
 stage: plan
 variables:
   TF_VAR_application_name: ${APP_NAME}
 artifacts:
   paths:
   - prod.tfplan
   expire_in: 1 week
 script:
   - terraform init
   - terraform workspace select prod
   - terraform plan -input=false -out=prod.tfplan
```
<!-- .element: class="big-code" -->

##--##
<!-- .slide: class="with-code-bg-dark" -->
```yaml
apply_production:
 stage: deploy
 when: manual
 variables:
   TF_VAR_application_name: ${APP_NAME}
 script:
   - terraform init
   - terraform workspace select prod
   - terraform apply -auto-approve -input=false prod.tfplan
```
<!-- .element: class="big-code" -->

##==##
<!-- .slide:-->

# Déploiement continu

![](./assets/images/deploiement_continu.png)

##==##
<!-- .slide: class="full-center"-->

# Présentation de l’offre pour les entreprises Terraform Cloud

![](./assets/images/g419a1b557d_2_230.png)

Notes:
liste des features sur : 
https://www.hashicorp.com/products/terraform/offerings

##==##
<!-- .slide:-->

# Présentation de l’offre pour les entreprises Terraform Cloud 

<iframe src="https://drive.google.com/file/d/1EJYtycVmeLKITPD1y2oGp2pQX2TItfVH/preview" width="90%" height="90%"></iframe>

Notes:
liste des features sur : 
https://www.hashicorp.com/products/terraform/offerings


##==##
<!-- .slide:-->

# Développement et utilisation de providers communautaires 

<br/>

Il est possible de développer ses propres providers en Golang
* Étendre le périmètre aux applications de l’entreprise
* Aider la communauté à supporter d’avantage de produit

##==##
<!-- .slide:-->

# Développement et utilisation de providers communautaires 

https://www.terraform.io/docs/extend/writing-custom-providers.html

<br/>

* provider.go : Implémente *func Provider() terraform.ResourceProvider*<br/>
    Définit les attributs du provider, initialise les connections si nécessaire, vérifie les identifiants.

* resource_name.go : Implément _func resourceName() *schema.Resource_<br/>
    Définit la structure et les appels APIs à effectuer pour créer l’objet sur le provider
    
* data_source_name.go : Un data source est une ressource qui n’implémente qu’une fonction READ

##==##
<!-- .slide:-->

# Développement et utilisation de providers communautaires 

# DeepDive du provider Google
Magic-modules de Google est un projet qui consiste à générer automatiquement les ressources Terraform, inspec et ansible depuis le contrat d’API des ressources Google Cloud

<br/>

=> https://github.com/GoogleCloudPlatform/magic-modules

<br/>

=> https://github.com/terraform-providers/terraform-provider-google

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Lors de l’utilisation de terraform taint, que se passe-t-il pour les ressources qui dépendent de la ressource à recréer ?

<br/>

1. Elles sont recréées
2. Elles sont modifiées
3. Cela dépend des attributs de la dépendance (recréées ou modifiées)
4. Rien


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Lors de l’utilisation de terraform taint, que se passe-t-il pour les ressources qui dépendent de la ressource à recréer ?

<br/>

1. Elles sont recréées
2. Elles sont modifiées
3. **Cela dépend des attributs de la dépendance (recréées ou modifiées)**
4. Rien

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle réponse est une alternative aux workspace ?

<br/>

1. Supprimer le terraform.tfstate local puis redéployer dans le bon environnement
2. Utiliser des buckets ou des préfixes différents 
3. Ne pas utiliser de remote backend
4. Utiliser Terraform Cloud


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Quelle réponse est une alternative aux workspace ?

<br/>

1. Supprimer le terraform.tfstate local puis redéployer dans le bon environnement
2. **Utiliser des buckets ou des préfixes différents**<br/>
<span style="color:green">Oui à condition d’effacer le dossier .terraform entre chaque run<span>
3. Ne pas utiliser de remote backend
4. **Utiliser Terraform Cloud**<br/>
<span style="color:green">Terraform Cloud connecte le VCS à son propre mécanisme de CD, il n’est plus nécessaire de créer un pipeline de CD.</span>


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Une nouvelle fonctionnalité est disponible chez mon Cloud Provider mais pas dans mon provider Terraform, quels sont mes solutions ?

<br/>

1. Modifier le provider officiel
2. Créer mon propre provider
3. Contribuer


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Une nouvelle fonctionnalité est disponible chez mon Cloud Provider mais pas dans mon provider Terraform, quels sont mes solutions ?

<br/>

1. Modifier le provider officiel
2. **Créer mon propre provider**
3. **Contribuer**

<span style="color:green">Il est important de ne pas diverger de l’upstream car les provider terraform évoluent quotidiennement</span>

##==##
<!-- .slide: class="exercice" -->

# Continuous Deployment via Terraform
 
## Atelier

##==##
<!-- .slide:-->

# Ressources

<br/>

* Site Officiel : https://www.terraform.io/
* Hashivim : https://github.com/hashivim
* Terraform-docs : https://github.com/segmentio/terraform-docs
* Inspec : https://www.inspec.io/
* Inspec-gcp : https://github.com/inspec/inspec-gcp
* Inspec-iggy : https://github.com/mattray/inspec-iggy
* Kitchen : https://kitchen.ci/





