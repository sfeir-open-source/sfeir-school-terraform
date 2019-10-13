# Sfeir Institute Terraform
## Continuous Deployment with Terraform
### Configure backend to Google Cloud Storage
[GCS Backend](https://www.terraform.io/docs/backends/types/gcs.html) stores the state in a Google Cloud Storage bucket.

#### Backend configuration
- Create a GCS bucket (manually)
- Generate a GCP service account and add the `storage.admin` role on the bucket.
- Generate a json key (will be used by gitlab)

You can now configure a deployment to use the bucket.

- Create a GCP instance using Terraform.
- Create a `remote.tf` file add the backend configuration :
```
terraform {
  backend "gcs" {
    bucket  = "<bucket_name>"
  }
}
```

Initialize the backend using `terraform init` command. 

#### Workspace configuration
Workspaces help users to deploy multiple environments using the same backend configuration.

- Create 2 environments "staging" and "production" using `terraform workspace new <name>`.

You have now 3 environements : *default*,*staging* and *production*.

#### Usage
Create a GCE instance and let user define the name and the machine type of the instance.
Deploy the instance in the default workspace : `terraform workspace select default` and run `terraform apply`.

- Verify the deployment using `terraform state show`.
- Remove the instance from the state file using `terraform state rm <resource_key>`
- Do a terraform plan again. What's happened  ?
- Import the existing instance in the state file use ` terraform import <resource_key> <resource_id>` where `resource_id` is like `{project}/{zone}/{instance_name}`


Deploy the same code in the staging workspace (update the instance name to avoid conflicts if you work on the same project).

### Pipeline using gitlab-ci
Let `gitlab-ci` deploy the production.

- Create a new gitlab repository
- In Settings -> CI/CD, configure 3 environment variables :
	- `TF_VAR_instance_name` with the desired instance name.
	- `TF_VAR_machine_type` with the desired machine type.
	- `GOOGLE_CREDENTIALS` with the service account key content (without new lines)

*Hint* You can use `tr -d '\n'` to remove new lines.

- Create a `.gitlab-ci.yml` file with the content
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
    - .terraform

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
      - prod.tfplan
    expire_in: 1 week
  script: 
    - terraform workspace select production
    - terraform plan -input=false -out=prod.tfplan
  dependencies:
    - validate

apply:
  stage: deploy
  when: manual
  script:
    - terraform workspace select production
    - terraform apply -auto-approve -input=false prod.tfplan
  dependencies:
    - plan
```

Push all `*.tf` files and `.gitlab-ci.yml` on your gitlab repository.

Observe the pipeline.

Switch to production workspace and run `terraform state list`.

### Cleanup

Run a `terraform destroy` for each workspaces.
Remove the service account and the cloud storage bucket
