generate_addresses_db: ## Generate the address database from data file (WIP)
	zcat data/2014_reserve_parlementaire.json.zip | jq -C ".[] | .Adresse" | grep -v "\"\"" | grep -v "\"Mairie\"" | grep -v "\"-\"" > data/2014_addresses.csv

install: ## Install related dependencies
	@composer install

test: ## Run the whole testsuite
	@vendor/bin/phpunit src/Parlementaires/ --color

spec: ## Run the whole testsuite to display a testdox agile spec
	@vendor/bin/phpunit src/Parlementaires/ --color --testdox

clear_event_store: ## Truncate the file based event store
	@rm -f data/eventstore/*.json

# Automatic documentation. See http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'