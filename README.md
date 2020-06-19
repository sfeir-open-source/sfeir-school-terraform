# Sfeir Institute Terraform

## Module 6 : Team working

### Prerequisites

For this lab, we will use a GKE Cluster to host a [vault application](https://www.hashicorp.com/products/vault/).

* In a `gke-cluster` folder, deploy a new GKE cluster using Terraform.
  * Go in `gke-cluster`.
  * In `variables.tf`, adapt cluster name `name` to add trigram.
  * Add GCP Project Id, in `gcp_project` variable also.
  * Then run `terraform apply`, to create GKE cluster

* Run `gcloud container clusters get-credentials ${name of your cluster you specified above} --zone=europe-west1` to configure kubectl (and helm) credentials

### Credentials using Vault

#### Vault installation on GKE

##### Vault and Consul installation using helm

[Helm](https://helm.sh) is a charts manager for Kubernetes.
Helm provides `consul` and `vault` charts to deploy vault in an existing k8s cluster.

*Disclamer Do not use this installation method in production.*

##### Installation

* Configure kubectl to use your GKE cluster and run the script `install_vault.sh`

Or do it yourself :

* Install helm in cloud shell using [this good medium article](https://medium.com/google-cloud/installing-helm-in-google-kubernetes-engine-7f07f43c536e)
* Deploy consul and vault using helm :

  ```shell
  helm repo add stable https://kubernetes-charts.storage.googleapis.com
  helm repo add incubator https://kubernetes-charts-incubator.storage.googleapis.com/
  helm repo update
  helm install consul-cluster stable/consul
  helm install vault-cluster incubator/vault  --set vault.dev=true --set vault.config.storage.consul.address="consul-cluster:8500",vault.config.storage.consul.path="vault" --set service.type="LoadBalancer" --set replicaCount=1
  ```

##### Vault configuration

Get vault credentials using :

```shell
VAULT_POD=$(kubectl get pods --namespace default -l "app=vault" -o jsonpath="{.items[0].metadata.name}") ; export VAULT_TOKEN=$(kubectl logs $VAULT_POD | grep 'Root Token' | cut -d' ' -f3)
```

Get vault address using :

```shell
export VAULT_ADDR=http://$(kubectl get services -l "app=vault" -o jsonpath="{.items[0].status.loadBalancer['ingress'][0]['ip']}"):8200
```

##### Play wth vault client

Installation :

```shell
export VAULT_VERSION=1.2.3
wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
sudo unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /usr/bin/
```

Usage :

```shell
echo $VAULT_TOKEN | vault login -
vault kv put secret/demo-secret user=demo password=password
```

##### Manage vault credentials using Terraform

In `vault-secret` folder, create a new [vault generic secret](https://www.terraform.io/docs/providers/vault/r/generic_secret.html) using [random provider](https://www.terraform.io/docs/providers/random/r/password.html)

Verify the secret content using the following command (update demo-secret-tf with the key used during generic secret creation) :

```shell
vault kv get secret/demo-secret-tf
```

### Terraform Modules

A module is a collection of resources defined by inputs (variable) and results (output).

#### Create a new module to deploy a [Cloud SQL](https://cloud.google.com/sql) instance using Terraform

* Go to the `sql-database` folder
* Deploy a Second-generation database using [google_sql_database_instance](https://www.terraform.io/docs/providers/google/r/sql_database_instance.html) resource
* Create a SQL user using [google_sql_user](https://www.terraform.io/docs/providers/google/r/sql_user.html)
* Create a `random_password` and save it on vault

Use this module to deploy your customized cloud sql database.

* Back to git root folder
* Update `main.tf` as bellow :

  ```text
  module "my-sql-instance" {
    source        = "./sql-database"
    instance_name = "demo-instance"
    gcp_project   = var.gcp_project
  }
  ```

* Update `variables.tf` as bellow :

  ```text
  variable "gcp_project" {
    default = "CHANGEME"
  }
  ```

* Use `terraform init` to get module content and to download terraform providers
* Run `terraform plan`

#### On gitlab

Local modules can't be shared or re-used between teams

* Create a new repository on [gitlab](https://gitlab.com) and push your `sql-database` on it.
* Update the root `main.tf` to use the remote module.

  ```text
    source = "git::https://example.com/sql-database.git"
  # or
    source = "git::ssh://username@example.com/sql-database.git"
  ```
