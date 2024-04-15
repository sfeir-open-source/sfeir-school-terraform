<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_vault"></a> [vault](#provider\_vault) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_sql_database_instance.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_database_instance) | resource |
| [google_sql_user.users](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/sql_user) | resource |
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [vault_generic_secret.example](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/generic_secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_version"></a> [database\_version](#input\_database\_version) | The MySQL or PostgreSQL version to use. | `string` | `"MYSQL_5_7"` | no |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | The name of the instance. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region the instance will sit in. | `string` | `"europe-west1"` | no |
| <a name="input_username"></a> [username](#input\_username) | The name of the user. | `string` | `"demo-user"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
