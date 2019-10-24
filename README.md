# Sfeir Institute Terraform

## Module-3b: Interpolations, looping and conditions

### Objective

Create a new workspace using `terraform workspace new module-3b`

As a user, I would like to push 2 configurations files in cloud storage in order to create VMs using *startup-script-url*.

Do it using :

* the old way (using count terraform 0.11)
* Using new terraform 0.12 for\_each way.

*Hints* : Refer to `google_storage_bucket` and `google_storage_bucket_object` to create bucket and to put objects.

| Property | Value |
| - | - |
| gcp\_project | `user_defined` |
| bucket\_name | `user_defined` |

Once the 4 objects are created (2 with `count`, 2 with `for_each`), add a new config file `"config-pp"   = "env = pp"`.

What's happened when you run again `terraform plan` ?

### Cleanup

Once lab is completed, use `terraform destroy` to remove resources managed by terraform
