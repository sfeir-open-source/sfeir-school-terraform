# Sfeir Institute Terraform

## Module 6 : Team working

### Prerequisites (using trainer cluster, the easy way)

For this lab, we will use an existing Vault cluster to save a random password (generated using terraform).
Ask your trainer the URL and the authentication token.

If you play this lab alone, feel free to create your own cluster (you can use [Vault cloud](https://www.vaultproject.io/) by example).

* Configure environment variables to use the cluser using vault CLI
```
export VAULT_ADDR=https://vault-cluster.vault.xxxx.aws.hashicorp.cloud:8200
export VAULT_NAMESPACE=admin
```

You can now jump to *Play with vault client* section.

### Prerequisites (using private cluster)

For this lab, we will use a GKE Cluster to host a [vault application](https://www.hashicorp.com/products/vault/).

* In a `gke-cluster` folder, deploy a new GKE cluster using Terraform.
  * Go in `gke-cluster`.
  * In `variables.tf`, adapt cluster name `name` to add your trigram.
  * Add GCP Project Id, in `gcp_project` variable as well.
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

### Play with vault client

Installation :

Follow [Vault installation methods](https://www.vaultproject.io/downloads) or using curl install :

```shell
export VAULT_VERSION=1.8.2
wget https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip
sudo unzip vault_${VAULT_VERSION}_linux_amd64.zip -d /usr/bin/
```

On MacOS, you can use : `brew install vault`

Usage example :

```shell
# Login to the vault server
echo $VAULT_TOKEN | vault login -

# Create a key-value secret
vault kv put secret/my-demo-secret user=demo password=password
```

##### Manage vault credentials using Terraform

In `vault-secret` folder, create a new [vault generic secret](https://registry.terraform.io/providers/hashicorp/vault/latest/docs) using [random provider](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)

Verify the secret content using the following command (update demo-secret-tf with the key used during generic secret creation) :

```shell
vault kv get secret/demo-secret-tf
```

### Terraform Modules

A module is a collection of resources defined by inputs (variable) and results (output).

#### Create a new module to deploy a [Cloud SQL](https://cloud.google.com/sql) instance using Terraform

* Go to the `sql-database` folder
* Deploy a Second-generation database (PostgreSQL 11) using [google_sql_database_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) resource
* Create an SQL user using [google_sql_user](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user)
* Create a `random_password` and save it on vault

Your cloud sql database module is now ready to be used in the parent resource ! Let's do this now :

* Back to git root folder
* Update `main.tf` as bellow :

  ```hcl
  module "my-sql-instance" {
    source        = "./sql-database"
    instance_name = "demo-instance"
    gcp_project   = var.gcp_project
  }
  ```

* Update `variables.tf` as bellow :

  ```hcl
  variable "gcp_project" {
    default = "CHANGEME"
  }
  ```

* Use `terraform init` to get module content and to download terraform providers
* Run `terraform plan` (Do not do an `apply` because the creation of cloud sql resource is too long)

#### On gitlab

Local modules can't be shared or re-used between teams

* Create a new repository on [gitlab](https://gitlab.com) and push your `sql-database` on it.
* Update the root `main.tf` to use the remote module.

  ```hcl
    source = "git::https://example.com/sql-database.git"
  # or
    source = "git::ssh://username@example.com/sql-database.git"
  
  # See more examples here : https://www.terraform.io/docs/modules/sources.html
  ```

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by terraform !
