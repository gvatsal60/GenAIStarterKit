# Default target
.DEFAULT_GOAL := help

SRC_DIR := src

.PHONY: all run test clean help

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

all: sync run ## Install dependencies and run the application

sync: ## Install/update dependencies
	@uv sync --no-cache
run: sync ## Run the Streamlit application
	@uv run --directory $(SRC_DIR) streamlit run app.py --browser.gatherUsageStats false
test: sync ## Run tests
	@echo "No tests available currently."
# 	@uv test
clean: ## Clean up dependencies and artifacts
	@uv clean
