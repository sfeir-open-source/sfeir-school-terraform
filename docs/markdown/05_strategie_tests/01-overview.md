<!-- .slide:-->

# Aperçu des différents outils de tests

![h-850 center](./assets/images/g418fd663c2_0_825.png)

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
* data.null_data_source.foo[0]: At column 11, line 1: conditional operator 
          cannot be used with list values in:
${element("haha"=="haha" ? list("") : list(""), 0)}
* data.null_data_source.foo[1]: At column 11, line 1: conditional operator 
          cannot be used with list values in:
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
<!-- .slide: class="two-column"-->

# Aperçu des différents outils de tests

## Tests fonctionnels

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