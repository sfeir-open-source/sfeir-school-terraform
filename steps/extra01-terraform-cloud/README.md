# Sfeir Institute Terraform

## Module 09 Terraform Cloud

### Configuration
#### Organization

Create a new account on [Terraform Cloud](https://app.terraform.io/app), then create a new organization. Organization will help you to centralize configurations and deployments (vcs, teams, modules, ...).

Follow the wizard to configure the gitlab environment you used previously.

#### Create a new gitlab repository

Use this directory, and push content to gitlab. 
First create a new gitlab repository, then push this content using : 

```
git init .
git remote add gitlab git@gitlab.com:<username>/<repositoryname>
git add main.tf README.md
git commit -m "feat(tfc): Add module 09 (Terraform Cloud)"
git push gitlab
```

Now you can see the terraform code in the repository.

### Create a new workspace and deploy resources

In Terraform cloud, create a new workspace driven by VCS and search for the previously created repository.

Configure variables to add `bar` with the value `Hello terraform`.

Queue a new run and enjoy Terraform Cloud.

*extra* Edit variables, change Terraform version, add `TF_LOG` environment variable, ...
