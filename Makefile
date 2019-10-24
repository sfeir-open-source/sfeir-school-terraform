COMMIT_REF := $(shell git rev-parse --short HEAD)
BRANCH_REF := $(shell git rev-parse --abbrev-ref HEAD)
UUID:= $(if $(CI_COMMIT_REF_SLUG),$(CI_COMMIT_REF_SLUG)-$(COMMIT_REF),$(BRANCH_REF)-$(COMMIT_REF))

all: init test

verify: ## Display revision ID
	@echo Current revision: $(UUID)

test: ## Run all tests

init: ## Initialize project


.DEFAULT_GOAL := help
.PHONY: test init help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
