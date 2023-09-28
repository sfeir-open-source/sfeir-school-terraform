# Sfeir Institute Terraform

## Module-3a: First Infrastructure Deployment

### Provider configuration

Take a look on [https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference).

Google provider accepts multiple configuration to set credentials. Because you are in Cloud Shell, Google Application Default Credentials are already set. 
⚠️ If you run on you local machine, it's recommended to do the same using : 

```shell
gcloud auth application-default login
```

### google_compute_instance

Create a new GCP instance in the default network using the following setting :

| Property | Value |
| - | - |
| Zone | europe-west1-b |
| Machine | n1-standard-1 |
| Image | debian-cloud/debian-12 |
| Network | default |
| Serial port (bonus) | true |
| Public IP | ensure that the instance is not accessible from the Internet |

Instance name should be prompted to user using variable (see variables.tf). Please use your name as instance name to avoid name clash with other participants.

*Note : add `allow_stopping_for_update` attribute if you plan to update machine type using Terraform*

To find all resource attributes, please refer to official provider documentation [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance).

Using `terraform init`, terraform will automatically download the [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) require to deploy the infrastructure on Google Cloud Platform.

Run a `terraform plan` to view changes.
If changes are correct, use `terraform apply` to deploy resources.

### google_compute_firewall

Please refer to the documentation [https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_firewall).

Create the new following firewall rule to use [Cloud Identity-Aware Proxy TCP forwarding](https://cloud.google.com/iap/docs/tcp-forwarding-overview)

| Property | Value |
| - | - |
| name | allow-iap-tcp-all-* |
| description | Allow connections from IAP |
| direction | INGRESS |
| protocol | tcp |
| source_ranges | 35.235.240.0/20 |

\* Add your name to avoid name clash with other participants.

Update the deployment and verify SSH access can be done from cloud shell using

```shell
gcloud compute ssh <terraform-instance-name> --tunnel-through-iap --zone=europe-west1-b
```

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by terraform
