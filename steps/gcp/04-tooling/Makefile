all: init test docs

apply: ## Apply Terraform with default/no configuration

destroy: ## Destroy Terraform configuration with default/no configuration

test: ## Run tests (validate code, apply/destroy with "test" configuration files)

init: ## Initialize project

docs: ## Generate documentation


.DEFAULT_GOAL := help
.PHONY: test init help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
