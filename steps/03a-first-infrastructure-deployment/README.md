# Sfeir Institute Terraform

## Module-3a: First Infrastructure Deployment

### Provider configuration

Take a look on [https://www.terraform.io/docs/providers/google/guides/provider_reference.html](https://www.terraform.io/docs/providers/google/guides/provider_reference.html).

Google provider accepts multiple configuration to set credentials. Because you are in cloud shell, Google Application Default Credentials are already set. 
If you run on you local machine, it's recommended to do the same using : 

```shell
gcloud auth application-default login
```

### google_compute_instance

Create a new instance GCP instance in the default network using the following setting :

| Property | Value |
| - | - |
| zone | europe-west1-b |
| machine | n1-standard-1 |
| image | debian-cloud/debian-9 |
| serial port | true |
| network | default |
| external ip | false |

Instance name should be prompted to user using variable

*Note : add `allow_stopping_for_update` attribute if you plan to update machine type using Terraform*

To find all resource attributes, please refer to official provider documentation [https://www.terraform.io/docs/providers/google/r/compute_instance.html](https://www.terraform.io/docs/providers/google/r/compute_instance.html).

Using `terraform init`, terraform will automatically download the [terraform-provider-google](https://github.com/terraform-providers/terraform-provider-google) require to deploy the infrastructure on Google Cloud Platform.

Create a new workspace called `module-3a` using `terraform workspace new module-3a`.

Run a `terraform plan` to view changes.
If changes are correct, use `terraform apply` to deploy resources.

### google_compute_firewall

Create the new following firewall rule to use [Cloud Identity-Aware Proxy TCP forwarding](https://cloud.google.com/iap/docs/tcp-forwarding-overview)

| Property | Value |
| - | - |
| name | allow-iap-tcp-all |
| description | Allow connections from IAP |
| direction | INGRESS |
| protocol | tcp |
| source_ranges | 35.235.240.0/20 |

Update the deployment and verify SSH access can be done from cloud shell using

```shell
gcloud beta compute ssh <terraform-instance-name> --tunnel-through-iap
```

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by terraform
