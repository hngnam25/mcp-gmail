# Define variables for paths
REPO_PATH = /Users/hngnam25/mcp-gmail
CREDS_PATH = /Users/hngnam25/mcp-gmail/gcp-oauth.keys.json
TOKEN_PATH = "/Users/hngnam25/mcp-gmail/app_tokens.json"


#run
run:
	uv run $(REPO_PATH)/src/gmail/server.py --creds-file-path $(CREDS_PATH) --token-path $(TOKEN_PATH)
 
# Target to run the server
run-debug-server:
	npx @modelcontextprotocol/inspector uv run $(REPO_PATH)/src/gmail/server.py --creds-file-path $(CREDS_PATH) --token-path $(TOKEN_PATH)

