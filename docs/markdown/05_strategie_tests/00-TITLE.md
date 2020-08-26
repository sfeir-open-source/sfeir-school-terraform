<!-- .slide: class="transition"-->

# Stratégie de tests

##==##
<!-- .slide:-->

# Overview des différents outils de test

![h-850](./assets/images/g418fd663c2_0_825.png)

##==##
<!-- .slide: class="full-center" -->

# Overview des différents outils de tests

![](./assets/images/tests.png)

##==##
<!-- .slide: class="with-code-bg-dark"-->

# Overview des différents outils de tests

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

# Overview des différents outils de tests

## Tests intégration

<img style="position:fixed;top:10px;right:30px" src="./assets/images/g418fd663c2_0_891.png">

* Consiste à déployer l’infrastructure dans une sandbox
* Utilisation 
  * https://kitchen.ci
  * https://github.com/newcontext-oss/kitchen-terraform
  * https://github.com/gruntwork-io/terratest 
    <span style="color:green">pour automatiser la création et suppression</span>

```bash
$ kitchen test
-----> Starting Kitchen (v2.2.5)
-----> Cleaning up any prior instances of <default-terraform>
-----> Creating <default-terraform>...
-----> Converging <default-terraform>...
-----> Setting up <default-terraform>...
-----> Verifying <default-terraform>...
-----> Destroying <default-terraform>...
-----> Kitchen is finished. (0m10.13s)
```

##==##
<!-- .slide: class="two-column-layout"-->

# Overview des différents outils de tests

## Tests fonctionnels

##--##
<!-- .slide: -->

<br/><br/>

* Eyeballing game VS Automated tests
* L’objectif est de valider que le déploiement effectué correspond bien au besoin exprimé
* Utilisation d’https://github.com/inspec/inspec-gcp  pour lire les ressources déployées

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

# L’exemple de inspec, inspec-iggy et kitchen-terraform

![float-center](./assets/images/inspec-exemple.png)


##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Dans quels cas un “terraform plan” fonctionne mais pas un “terraform apply” ?

<br/>

1. Mauvais credentials
2. Un erreur de syntaxe
3. Une variable n’a pas de valeur
4. La ressource existe déjà

##==##
<!-- .slide:-->

# QUIZZ

<br/>

*Question* : Dans quels cas un “terraform plan” fonctionne mais pas un “terraform apply” ?

<br/>

1. **Mauvais credentials**
2. Un erreur de syntaxe
3. Une variable n’a pas de valeur
4. **La ressource existe déjà**

##==##
<!-- .slide: class="exercice" -->

# Intégration continue avec Terraform
 
## Atelier
