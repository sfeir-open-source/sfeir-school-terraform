<!-- .slide: class="transition"-->

# Stratégie de tests

##==##
<!-- .slide:-->

# Aperçu des différents outils de tests

![h-850](./assets/images/g418fd663c2_0_825.png)

##==##
<!-- .slide: class="full-center" -->

# Aperçu des différents outils de tests

![](./assets/images/tests.png)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Aperçu des différents outils de tests

## Tests unitaires

* Utilisation de la commande “terraform validate”
* Permet de valider la syntaxe, la déclaration des modules, providers, variables, …

```plaintext
terraform validate

Error: data.null_data_source.foo: 2 error(s) occurred:

* data.null_data_source.foo[0]: At column 11, line 1: conditional operator cannot be used with list values in:

${element("haha"=="haha" ? list("") : list(""), 0)}
* data.null_data_source.foo[1]: At column 11, line 1: conditional operator cannot be used with list values in:
```
<!-- .element class="big-code" -->

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Aperçu des différents outils de tests

## Tests intégration

<img style="position:fixed;top:10px;right:30px" src="./assets/images/g418fd663c2_0_891.png">

* Consiste à déployer l’infrastructure dans une sandbox
* Outils existants :
  * [kitchen-ci](https://kitchen.ci) associé à [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform)
  * [terratest](https://github.com/gruntwork-io/terratest)
    <span style="color:green">pour automatiser la création et suppression</span>
  * [Terraform Testing Framework](https://developer.hashicorp.com/terraform/language/tests)

* Outil déprécié :
  * Module Testing Experiment (experimental features)

##==##
<!-- .slide: class="two-column-layout"-->

# Aperçu des différents outils de tests

## Tests fonctionnels

##--##
<!-- .slide: -->

<br/><br/>

* Eyeballing game VS Automated tests
* L’objectif est de valider que le déploiement effectué correspond bien au besoin exprimé
* Utilisation d’[inspec-gcp](https://github.com/inspec/inspec-gcp) pour lire les ressources déployées

<br/><br/>

![float-center](./assets/images/g418fd663c2_0_890.png)

##--##
<!-- .slide: class="with-code-bg-dark"-->

```ruby
control "projects" do
  project = google_project(project: gcp_project_id)
  describe project do
    it { should exist }
    its('lifecycle_state') { should eq "ACTIVE" }
    if defined?(project.labels)
      its('labels.count') { should be 1 }
      its('labels') { should include('owner') }
    else
      it 'labels are defined' do
        raise Inspec::Exceptions::ResourceFailed, "no labels found"
      end
    end
  end
end
```

![float-center](./assets/images/g418fd663c2_0_934.png)

##==##
<!-- .slide:-->

# L’exemple de KitchenCI + inspec


<img style="position:fixed;top:5em;left:30px;height:50%" src="./assets/images/kitchen-sample.png">

<img style="position:fixed;top:20em;left:30px:height:40%" src="./assets/images/inspec-sample.png">

<img style="position:fixed;top:8em;left:15em" src="./assets/images/g418fd663c2_0_891.png">

<img style="position:fixed;top:21em;left:20em" src="./assets/images/g418fd663c2_0_890.png">

##==##
<!-- .slide:-->

# L’exemple de Terratest

![h-650 float-left](./assets/images/terratest_sample.png)

![float-left](./assets/images/terratest_logo.png)

##==##
<!-- .slide:-->

# L’exemple du Terraform Testing Framework

Exemple de code Terraform :
```(hcl-terraform)
provider "aws" {
    region = "eu-central-1"
}

variable "bucket_prefix" {
  type = string
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
```

Exemple de code de test:
```(hcl-terraform)
variables {
  bucket_prefix = "test"
}

run "valid_string_concat" {
  command = plan

  assert {
    condition     = aws_s3_bucket.bucket.bucket == "test-bucket"
    error_message = "S3 bucket name did not match expected"
  }
}
```

Disponible depuis la v1.6.0 de Terraform.

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Dans quel cas un `terraform plan` fonctionne mais pas un `terraform apply` ?

<br/>

1. Mauvais credentials
2. Un erreur de syntaxe
3. Une variable n’a pas de valeur
4. La ressource existe déjà

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Dans quel cas un `terraform plan` fonctionne mais pas un `terraform apply` ?

<br/>

1. **Mauvais credentials**
2. Un erreur de syntaxe
3. Une variable n’a pas de valeur
4. **La ressource existe déjà**

##==##
<!-- .slide: class="exercice" -->

# Intégration continue avec Terraform

## Atelier
