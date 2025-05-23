# Sfeir Institute Terraform

## Continuous Deployment with Terraform

### Configure backend to Google Cloud Storage

To store the terraform state in a shared storage accessible from your PC, Cloud Shell and from Gitlab CI runner you need a remote backend.

If you are in a training session with a SFEIR trainer, you can use the bucket `sfeir-school-terraform-backends`

Else, if you do the lab autonomously, create a Google Cloud Storage bucket (directly on the Google Cloud console).

More information about GCS Backend configuration in [official documentation](https://www.terraform.io/docs/backends/types/gcs.html).

### Service Account

To allow you Gitlab-ci job to connect to Google Cloud, you must have a variable GOOGLE_CREDENTIALS set that contain a JSON formatted key of a Service Account with roles `storage.admin`, `compute.admin`, `iam.serviceAccountUser`

If you are in a training session with a SFEIR trainer, a key for the Service Account `gitlab-ci@sfeir-school-terraform.iam.gserviceaccount.com` is already configured in the Gitlab.com project (via the GOOGLE_CREDENTIALS variable).

Else, if you do the lab autonomously :
- Generate a GCP service account and add the `storage.admin`, `compute.admin`, `iam.serviceAccountUser` roles.
- Generate a json key
- Store it in a GOOGLE_CREDENTIALS variable in your Gitlab CI/CD settings.

### Writing the configuration

You can now configure a deployment to use the bucket.

- Edit the `main.tf` file and add a GCE instance (let the user define the name and the machine type of the instance. Tips : Suffix the instance name with `-<your_name>-${terraform.workspace}`)
- Edit the `remote.tf` file and add the backend configuration :

```hcl
terraform {
  backend "gcs" {
    bucket  = "<bucket_name>"
    prefix = "<your_name>/"
  }
}
```

Initialize the backend using `terraform init` command.

#### Workspace configuration

Workspaces help users to deploy multiple environments using the same backend configuration.

Create 2 environments `staging` and `production` using `terraform workspace new <name>`.

You have now 3 environements : *default*, *staging* and *production*.

#### Usage

Deploy the instance in the default workspace : `terraform workspace select default` and run `terraform apply`.

- Verify the deployment using `terraform state show <resource_key>` (use the resource_key `google_compute_instance.default`)
- Remove the instance from the state file using `terraform state rm <resource_key>`
- Do a terraform plan again. What's happened  ?
- Import the existing instance in the state file use `terraform import <resource_key> <resource_id>` where `resource_id` is like `{project}/{zone}/{instance_name}`

Deploy the same code in the `staging` workspace (instance name suffix will avoid conflicts since you work on the same google cloud project).

### Pipeline using gitlab-ci

Let Gitlab-CI deploy the production.

If you are in a training session with a SFEIR trainer :
- Use the Gitlab.com repository provided by the SFEIR trainer.
- Clone the repository `git clone git@gitlab.com:.../continuous-deployment`
- Create your own branch `git checkout -b <your-name>`

Else, if you do the lab autonomously, create a new Gitlab.com repository.
 - In Settings -> CI/CD, configure these variables :
  - `TF_VAR_application_name` with the desired application name (used to build the instance name, ex: `sfeir-mega-app`).
  - `TF_VAR_machine_type` with the desired machine type (ex: `f1-micro`).
  - `GOOGLE_CREDENTIALS` with the service account key content.
  - `GOOGLE_CLOUD_PROJECT` with the name of your Google Cloud project.

- Create a `.gitlab-ci.yml` file with the following content:

```yaml
image:
  name: "hashicorp/terraform"
  entrypoint:
  - '/usr/bin/env'
  - 'PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'

stages:
- validate
- plan
- deploy

cache:
  paths:
    - .terraform/providers

before_script:
  - terraform --version
  - terraform init

validate:
  stage: validate
  script:
    - terraform validate

plan:
  stage: plan
  artifacts:
    paths:
      - production.tfplan
    expire_in: 1 week
  script:
    - terraform workspace select production
    - terraform plan -input=false -out=production.tfplan
  dependencies:
    - validate

apply:
  stage: deploy
  when: manual
  script:
    - terraform workspace select production
    - terraform apply -auto-approve -input=false production.tfplan
  dependencies:
    - plan
```

Push all `*.tf` files and `.gitlab-ci.yml` on your own branch (or your own repository).

```shell
git add *.tf .gitlab-ci.yml
git commit -m "First try"
git push --set-upstream origin <your_name>
```

Observe the pipeline.

On your Cloud Shell, switch to `production` workspace (`terraform workspace select production`) and run `terraform state list`.

### Cleanup

On your Cloud Shell, run a "destroy" for each workspaces:

```shell
TF_WORKSPACE=default terraform destroy -var=application_name=sfeir-mega-app -var=machine_type=f1-micro
TF_WORKSPACE=staging terraform destroy -var=application_name=sfeir-mega-app -var=machine_type=f1-micro
TF_WORKSPACE=production terraform destroy -var=application_name=sfeir-mega-app -var=machine_type=f1-micro
```

If you are not in a SFEIR training session: emove the service account and the cloud storage bucket.
