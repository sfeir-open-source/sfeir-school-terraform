# Sfeir Institute Terraform

This repository help customers to use [HashiCorp Terraform](https://www.terraform.io/) over multiple modules.

## Modules

Each module can be run independently

* Module 1 : Introduction of Terraform (no lab)
* Module 2 : First step with Terraform
  * (lab) Installation and Configuration
* Module 3 : Langages and Interpolations
  * (lab) My First infrastructure deployment
  * (lab) Advanced development and Interpolation
* Module 4 : Integrated Development Environment
  * (lab) Improve productivity using IDE
* Module 5 : Testing strategies
  * (lab) Continuous Integration with Terraform
* Module 6 : Team Working
  * (lab) Create you own module registry using [Gitlab](https://about.gitlab.com/)

## Technical stack requirements

### Terraform

All code used are compatible with the [0.12 major version of Terraform](https://releases.hashicorp.com/terraform/).

### GCP

The initial set of labs use [Google Cloud Platform](https://cloud.google.com/) resources.
An active GCP project is required, and specifics roles like `roles/compute.admin`, `roles/container.admin` may be necessary regarding resources used.

**Disclaimer : This institute will not cover GCP services usage.**
Please follow [Google Cloud Platform Sfeir Institute](https://www.sfeir.com/formation/institute/) if you want to learn more about GCP services

### AWS 

A set of labs have been developed in order to be deployed with an [Amazon Web Services Free tier](https://aws.amazon.com/free/?all-free-tier.sort-by=item.additionalFields.SortRank&all-free-tier.sort-order=asc&awsf.Free%20Tier%20Types=*all&awsf.Free%20Tier%20Categories=*all) account. See the lab [aws/02-installation](https://github.com/sfeir-open-source/sfeir-school-terraform/tree/main/steps/aws/02-installation) to configure your environment.
### Gitlab

Module 6 and 7 use [Gitlab](https://about.gitlab.com/) to manage CI and CD pipelines.
An active account is required on Gitlab.

### Others

All other components will be part as Open-Source projects and will be deployed on [Kubernetes](https://kubernetes.io/) using [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/)

## Slides

Slides are available here : https://sfeir-open-source.github.io/sfeir-school-terraform

> Press 's' for shortcuts help
> Press 'c' and use the type "gcp prez" to see the GCP slides version
> or Press 'c' and use the type "aws" to see the AWS slides version

## How to use

Source code and tutorials are saved in directory `steps`, with one directory labs, and another one suffixed with `-solution` with solutions...

*Notes : if you made changes, don't forget to commit locally using `git commit -m "<msg>"`*

## How to contribute

Please report issues using Github issue.
If you would like to contribute on this repository, please submit a pull request.
