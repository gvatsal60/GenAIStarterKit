# Default target
.DEFAULT_GOAL := help

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

SRC_DIR := src

.PHONY: all run test clean

all: sync run

sync:
	@uv sync --no-cache
run: sync
	@uv run --directory $(SRC_DIR) streamlit run app.py --browser.gatherUsageStats false
test: sync
	@echo "No tests available currently."
# 	@uv test
clean:
	@uv clean
