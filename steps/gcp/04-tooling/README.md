# Sfeir Institute Terraform

## Module-4 : Tooling

### IDE plugins

#### VIM plugin using Vundle installation

Install [Vundle](https://github.com/VundleVim/Vundle.vim)

Install [vim-terraform plugin using Vundle](https://vimawesome.com/plugin/vim-terraform-state-of-grace) :

Configure `~/.vimrc` with the following content

```text
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'hashivim/vim-terraform'
call vundle#end()            " required
filetype plugin indent on    " required

syntax on
filetype plugin indent on

" Terraform config
let g:terraform_fmt_on_save=1
let g:terraform_align=1
```

#### VScode

Add Terraform extension (from HashiCorp) for VScode

### Generate Documentation

You can use [terraform-docs](https://github.com/terraform-docs/terraform-docs) to parse your code and generate the documentation.

#### Quick and dirty documentation generation

With `terraform-docs md . > README.md`, you will create/update your documentation in a file named README.md. But if you manually modify README.md to add useful information to use your module, these modification will be overwritten with the next execution of the command.

#### A better way to generate a (manually editable) documentation

With `terraform-docs --output-mode inject md . --output-file README.md`, you will create/update your documentation in the README.md, but terraform-docs will only update the content between BEGIN_TF_DOCS/END_TF_DOCS tags. So you can freely edit the README.md before BEGIN_TF_DOCS or after END_TF_DOCS.

#### The ultimate way to generate documentation

Create a `.terraform-docs.yaml` configuration file in your project to make `--output-mode inject` `md` and `--output-file README.md` the default behaviour.

More informations : https://terraform-docs.io/user-guide/configuration/

## Example

Create a new `google_compute_firewall` to allow `tcp:53` and `udp:53` in ingress

### Best practice

#### Folder convention

Create a `test/fixtures` directory and add a file `test_variables.tfvars` with the content `key = "value"` for each variables required by this module.

### Makefile

Create a `Makefile` with :

* a `test` directive to run `terraform validate`
* a `init` directive to run `terraform init` the project

Run `make test` and check the `terraform validate` result.

Update the `test` directive to add `terraform apply` and `terraform destroy` using the `test_variables.tfvars` file and `-auto-approve` parameter.

#### Bonus

Create new Makefile directive:

* a `apply` directive to apply the default configuration
* a `destroy` directive to destroy the default configuration
* a `docs` directive to generate the documentation using a `terraform-docs` configuration file

#### Tips

Command in Makefile directive must begin with tabulation caracter (not 2 or 4 spaces).
