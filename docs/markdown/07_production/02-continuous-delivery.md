<!-- .slide:-->

# Déploiement continu

## Terraform workspace

L’état d’un déploiement est sauvegardé dans un fichier terraform.tfstate qu’il est possible d’exporter sur un stockage distant ou local (appelé backend).<br>
Si l’utilisateur souhaite instancier plusieurs déploiements depuis un même backend, il peut utiliser la fonctionnalité de workspace.<br>

Cas d’utilisations :

- Dev/QA/Production
- Plusieurs régions

##==##

# Déploiement continu

## Terraform workspace

- $ terraform workspace new name
  <br><span style="color:green"># Créer un workspace</span>

- $ terraform workspace list
  <br><span style="color:green"># Affiche la liste des workspaces</span>

- $ terraform workspace show
  <br><span style="color:green"># Affiche le workspace courant</span>

- $ terraform workspace select name
  <br><span style="color:green"># Se positionne dans un workspace</span>

- $ terraform workspace delete name
  <br><span style="color:green"># Supprime un workspace</span>

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

##==##

# Déploiement continu

![](./assets/images/deploiement_continu.png)
