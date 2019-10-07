# Sfeir Institute Terraform
## Module-4 : Tooling
### IDE plugins
#### VIM plugin using Vundle installation
Install [Vundle](https://github.com/VundleVim/Vundle.vim)

Install [vim-terraform plugin using Vundle](https://vimawesome.com/plugin/vim-terraform-state-of-grace) :

Configure `~/.vimrc` with the following content

```
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
Add Terraform extension for VScode

### Generate Documentation
You can use [terraform-docs](https://github.com/segmentio/terraform-docs) to parse your code and generate the documentation. 
For the moment, *terraform-docs* do not support HCL2 [segmentio/terraform-docs/issues/62](https://github.com/segmentio/terraform-docs/issues/62). 
An experimental evolution can be found on [segmentio/terraform-docs/pull/113](https://github.com/segmentio/terraform-docs/pull/113)

*extra* Compile the pull request above and use `terraform-docs md . > docs.md` to generate documentation.

## Example 
Create a new `google_compute_firewall` to allow tcp:53 and udp:53 in ingress

### Best practice
#### Folder convention
Create a `test/fixtures` folder and add a file `test_variables.tfvars` with the content `key = "value"` for each variables required by this module.

#### Makefile 
Create a `Makefile` with :
* a `test` directive to run `terraform validate`
* a `init` directive to run `terraform init` the project

Note : We will use this Makefile for next labs.

Run `make test` and check the `terraform validate` result.

Update the `test` directive to add `terraform apply` and `terraform destroy` using the `test_variables.tfvars` file.
