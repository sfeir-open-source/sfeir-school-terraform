all: init test docs

apply: ## Apply Terraform with default/no configuration
	terraform apply -auto-approve

destroy: ## Destroy Terraform configuration with default/no configuration
	terraform destroy -auto-approve

test: ## Run tests (validate code, apply/destroy with "test" configuration files)
	terraform validate
	terraform apply -auto-approve -var-file=test/fixtures/test_variables.tfvars
	terraform destroy -auto-approve -var-file=test/fixtures/test_variables.tfvars

init: ## Initialize project
	terraform init

docs: ## Generate documentation
	terraform-docs .


.DEFAULT_GOAL := help
.PHONY: test init help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
