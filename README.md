# Sfeir Institute Terraform

## Module-5 : Testing strategies

### Install tools using Bundler

[Bundler](https://bundler.io/) provides a virtual environement for a project to install application dependancies without conflicts with operating system libs.

Bundler use `Gemfile` to list all `gems` required by the application.

[Kitchen](https://kitchen.ci/) and [inspec](https://www.inspec.io/) provides `gems` as installation mode.

Create a new `Gemfile` with the content :

```ruby
source "https://rubygems.org/" do
  gem 'inspec-bin', '=4.16.0'
  gem 'inspec', '=4.16.0'
  gem 'kitchen-google'
  gem 'kitchen-terraform'
  gem 'kitchen-ssh'
  gem 'kitchen-inspec'
  gem 'test-kitchen'
end
```

*Note* : inspec version is forced due to issue [inspec/issues/4562](https://github.com/inspec/inspec/issues/4562) when using inspec-gcp archive.

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
* Create a new private DNS zone in [Cloud DNS](https://www.terraform.io/docs/providers/google/r/dns_managed_zone.html) using terraform.
* Verify kitchen is able to deploy your terraform configuration using `bundle exec kitchen test`.
* Deploy your zone using `terraform apply`.

### Inspec

[inspec-gcp](https://github.com/inspec/inspec-gcp) is a inspec plugin to verify gcp configurations using inspec.

In your workspace, create a `test/integration` folder.
In this folder, run the command `bundle exec inspec init profile local-test` to create a new configuration for inspec.
The command will create a `local-test/inspec.yml` file.

* Test the sample using `bundle exec inspec exec local-test`
* Observe the code in `local-test/controls/example.rb`

#### inspec-gcp

You can generate a new inspec profile named `default` for inspec-gcp tests using `bundle exec inspec init profile --platform gcp default`.

* Update the `default/attributes.yml` to configure the gcp project id
* Run tests using `bundle exec inspec exec default -t gcp:// --input-file default/attributes.yml --show-progress --color`

Add a new control to check your DNS zone.

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
          project_id: project_id
```

The `project_id` output from terraform will be mapped to inspec input.

Clean the previous deployment using `terraform destroy` and run a `bundle exec kitchen test`.

### Extra : Inspec-iggy

* Clone inspec-gcp repository to use latest resources definitions
* Deploy the DNS zone
* Install `inspec-iggy` using `bundle exec inspec plugin install inspec-iggy`
* Run it `bundle exec inspec terraform generate --tfstate terraform.tfstate --name iggy-profile --platform gcp --resourcepath ~/path-to/inspec-gcp`
* Enjoy the control file automatically generated using terraform state file
