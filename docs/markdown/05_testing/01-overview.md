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

- Utilisation de la commande “terraform validate”
- Permet de valider la syntaxe, la déclaration des modules, providers, variables, …

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

- Consiste à déployer l’infrastructure dans une sandbox
- Outils recommandés :

  - [Terraform Testing Framework](https://developer.hashicorp.com/terraform/language/tests)
    <span style="color:green">natif depuis v1.6, mocking depuis v1.7</span>
  - [terratest](https://github.com/gruntwork-io/terratest)
    <span style="color:green">tests end-to-end en Go (validations post-deploy)</span>

- Outils dépréciés :
  - [kitchen-terraform](https://github.com/newcontext-oss/kitchen-terraform) <span style="color:red">(archivé octobre 2024)</span>
  - Module Testing Experiment (experimental features)

##==##

<!-- .slide:-->

# Aperçu des différents outils de tests

## Tests fonctionnels

- Eyeballing game VS Automated tests
- L’objectif est de valider que le déploiement effectué correspond bien au besoin exprimé
- Le Terraform Testing Framework permet deux modes :
  - `command = plan` : validation sans déploiement (test unitaire)
  - `command = apply` : déploiement réel + assertions (test fonctionnel)

Notes:
Remplace les outils externes comme inspec-gcp (maintenance incertaine) ou kitchen-terraform (archivé oct 2024)
Avantage : même langage HCL, pas de dépendance externe (Ruby, Go, etc.)
Voir exemples détaillés dans les slides suivantes
