# .envrc should be loaded by direnv before make is run

# Define variables for paths using the environment variable
ifndef MCP_GMAIL_ROOT
	$(error MCP_GMAIL_ROOT environment variable is not set. Ensure .envrc is present and allowed by direnv.)
endif
REPO_PATH := $(MCP_GMAIL_ROOT) # Use the variable set by direnv

# Derive other paths from REPO_PATH
CREDS_PATH = $(REPO_PATH)/gcp-oauth.keys.json
TOKEN_PATH = $(REPO_PATH)/app_tokens.json


#run
run:
	@echo "Running server from: $(REPO_PATH)"
	uv run $(REPO_PATH)/src/gmail/server.py --creds-file-path $(CREDS_PATH) --token-path $(TOKEN_PATH)
 
# Target to run the server
run-debug-server:
	@echo "Running debug server from: $(REPO_PATH)"
	npx @modelcontextprotocol/inspector uv run $(REPO_PATH)/src/gmail/server.py --creds-file-path $(CREDS_PATH) --token-path $(TOKEN_PATH)

# Add a command to print the path for debugging
print-repo-path:
	@echo $(REPO_PATH)

