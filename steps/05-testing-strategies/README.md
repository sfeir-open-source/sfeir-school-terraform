# Sfeir Institute Terraform

## Module-5 : Testing strategies

### Install tools using Bundler

[Bundler](https://bundler.io/) provides a virtual environement for a project to install application dependencies without conflicts with operating system libs.

Bundler use `Gemfile` to list all `gems` required by the application.

[Kitchen](https://kitchen.ci/) and [inspec](https://www.inspec.io/) provides `gems` as installation mode.

Create a new `Gemfile` with the content :

```ruby
source "https://rubygems.org/" do
  gem 'inspec-bin'
  gem 'inspec'
  gem 'kitchen-google'
  gem 'kitchen-terraform'
  gem 'kitchen-ssh'
  gem 'kitchen-inspec'
  gem 'test-kitchen'
end
```

Then run `bundle install` to install packages.

### KitchenCI

Check that `inspec`, `kitchen` is correctly installed using `bundle exec inspec` or `bundle exec kitchen`.

Kitchen require a configuration file named `.kitchen.yml` to describe how to configure the `drivers`, the `provisioners` and the `verifiers`.

For testing purpose, we will use the following configuration file :

```yaml
---
driver:
  name: terraform
  variable_files:
  - test/fixtures/unit_tests_variables.tfvars

platforms:
- name: terraform

verifier:
  name: terraform

provisioner:
  name: terraform

suites:
- name: default
```

* Create a `.kitchen.yml` file with the content above.
* Create a `test/fixtures/unit_tests_variables.tfvars` file with `gcp_project = "sfeir-school-terraform"` as content.
* **Using Terraform**, create a new private DNS zone in [Cloud DNS](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone).
* Verify kitchen is able to deploy your terraform configuration using `bundle exec kitchen test`.
* Deploy your zone using `terraform apply`.

### Inspec

[inspec-gcp](https://github.com/inspec/inspec-gcp) is a inspec plugin to verify gcp configurations using inspec.

In your workspace, create a `test/integration` folder.

**In this folder**(`test/integration`), run the command `bundle exec inspec init profile local-test` to create a new generated configuration for inspec.
This command will create a `local-test/inspec.yml` file.

* Observe the code in `test/integration/local-test/controls/example.rb`
* Still in `test/integration` directory, test the sample using `bundle exec inspec exec local-test`

#### inspec-gcp

You can generate a new inspec profile named `default` for **inspec-gcp** tests using `bundle exec inspec init profile --platform gcp default`.

* Update the `default/inputs.yml` to configure the gcp project id
* Run tests using `bundle exec inspec exec default -t gcp:// --input-file default/inputs.yml --show-progress --color`


Now we will verify our zone configuration. Take a look on [inspec-gcp resources](https://github.com/inspec/inspec-gcp/tree/main/docs/resources) and replace the default control with a new control to check your DNS zone.

### Kitchen and Inspec

Update kitchen configuration to use inspec as verifier :

```yaml
suites:
- name: default
  verifier:
    systems:
      - name: local
        backend: gcp
        attrs_outputs:
          gcp_project_id: gcp_project
```

The `gcp_project` output from terraform will be mapped to inspec input.

Clean the previous deployment using `terraform destroy` and run a `bundle exec kitchen test`.

### Extra : Inspec-iggy

> Inspec-iggy is a plugin to generate inspec test directly from terraform state file. 

* In workspace directory
* Clone inspec-gcp repository to use latest resources definitions
  * `git clone git@github.com:inspec/inspec-gcp.git`
* Deploy the DNS zone with Terraform
  * `terraform apply`
* Install `inspec-iggy` using `bundle exec inspec plugin install inspec-iggy`
* Run it `bundle exec inspec terraform generate --tfstate terraform.tfstate --name test/integration/iggy-profile --platform gcp --overwrite --resourcepath ./inspec-gcp`
* Enjoy the control file automatically generated using terraform state file in `./test/integration/iggy-profile/controls/`
