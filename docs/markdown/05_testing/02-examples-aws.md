<!-- .slide:-->

# L’exemple de KitchenCI + inspec

![float-left w-500](./assets/images/kitchen-sample.png)

![float-right mt-200](./assets/images/g418fd663c2_0_890.png)

![float-left mt-200](./assets/images/g418fd663c2_0_891.png)

![float-right mt-200](./assets/images/inspec-sample.png)
##==##

# L’exemple de Terratest

![h-650 float-left](./assets/images/terratest_sample.png)

![float-left](./assets/images/terratest_logo.png)

##==##

# L’exemple du Terraform Testing Framework

##

Exemple de code Terraform (`main.tf`) :

```hcl-terraform
provider "aws" {
    region = "eu-central-1"
}

variable "bucket_prefix" {
  type = string
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_prefix}-bucket"
}

output "bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
```

Exemple de code de test (`main.tftest.hcl`) :

```hcl-terraform
variables {
  bucket_prefix = "test"
}

run "valid_string_concat" {
  command = plan

  assert {
    condition     = aws_s3_bucket.bucket.bucket == "test-bucket"
    error_message = "S3 bucket name did not match expected"
  }
}
```

Disponible depuis la v1.6.0 de Terraform.
