# MCP Gmail

A Gmail integration for the Model Context Protocol (MCP) that enables AI assistants to read, compose, and manage emails through the Gmail API.

## Features

- **Email Management**: Read, send, trash, and mark emails as read
- **Draft Emails**: Create and edit email drafts with AI assistance
- **Unread Notifications**: Access unread emails from your inbox
- **Browser Integration**: Open emails directly in your browser

## Prerequisites

- Python 3.12+
- Google Cloud Platform account with Gmail API enabled
- OAuth 2.0 credentials for Gmail API
- `direnv` for environment management (recommended)

## Setup

### 1. Clone the Repository

```bash
git clone https://github.com/yourusername/mcp-gmail.git
cd mcp-gmail
```

### 2. Create a Virtual Environment

```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

### 3. Install Dependencies

```bash
pip install -r requirements.txt
# Or using uv
uv pip install -r requirements.txt
```

### 4. Set Up Environment Variables

Create a `.envrc` file in the project root (or update the provided one):

```bash
export MCP_GMAIL_ROOT="/path/to/your/mcp-gmail"
```

If using `direnv`, run:

```bash
direnv allow
```


### 5. Gmail API Setup

1. [Create a new Google Cloud project](https://console.cloud.google.com/projectcreate)
2. [Enable the Gmail API](https://console.cloud.google.com/workspace-api/products)
3. [Configure an OAuth consent screen](https://console.cloud.google.com/apis/credentials/consent) 
    - Select "external". However, we will not publish the app.
    - Add your personal email address as a "Test user".
4. Add OAuth scope `https://www.googleapis.com/auth/gmail/modify`
5. [Create an OAuth Client ID](https://console.cloud.google.com/apis/credentials/oauthclient) for application type "Desktop App"
6. Download the JSON file of your client's OAuth keys
7. Rename the key file and save it to your local machine in a secure location. Take note of the location.
    - The absolute path to this file will be passed as parameter `--creds-file-path` when the server is started. 

### 6. OAuth Consent

On first run, the application will open a browser window for OAuth consent. After granting permission, your credentials will be saved to the specified token path for future use.

Token credentials will be subsequently saved (and later retrieved) in the absolute file path passed to parameter `--token-path`.

For example, you may use a dot directory in your home folder, replacing `[your-home-folder]`.:

| Parameter       | Example                                          |
|-----------------|--------------------------------------------------|
| `--creds-file-path` | `/[your-home-folder]/.google/gcp-oauth.keys.json` |
| `--token-path`      | `/[your-home-folder]/.google/app_tokens.json`    |


### Usage with Desktop App

Using [uv](https://docs.astral.sh/uv/) is recommended.

To integrate this server with Claude Desktop as the MCP Client, add the following to your app's server configuration. By default, this is stored as `~/Library/Application\ Support/Claude/claude_desktop_config.json`. 

```json
{
  "mcpServers": {
    "gdrive": {
      "command": "uv",
      "args": [
        "--directory",
        "[absolute-path-to-git-repo]",
        "run",
        "gmail",
        "--creds-file-path",
        "[absolute-path-to-credentials-file]",
        "--token-path",
        "[absolute-path-to-access-tokens-file]"
      ]
    }
  }
}
```
I would like to think that I have configured everything in my program, but just to be safe 

The following parameters must be set
| Parameter       | Example                                          |
|-----------------|--------------------------------------------------|
| `--directory`   | Absolute path to `gmail` directory containing server |
| `--creds-file-path` | Absolute path to credentials file created in Gmail API Setup. |
| `--token-path`      | Absolute path to store and retrieve access and refresh tokens for application.  |

Sometimes uv would not load properly, make sure to inspect your own terminal and type 

```bash
which uv
```
to replace the uv command


## Usage

### Running the Server

```bash
make run
```

Or in debug mode:

```bash
make run-debug-server
```

### Using Custom Credential Paths

```bash
python src/gmail/server.py --creds-file-path "/path/to/credentials.json" --token-path "/path/to/token.json"
```

## Available Prompts

| Prompt | Description |
|--------|-------------|
| `manage-email` | General email management assistant |
| `draft-email` | Create a new email draft with subject and content |
| `edit-draft` | Modify an existing email draft |

## Available Tools

| Tool | Description |
|------|-------------|
| `send-email` | Send an email to a recipient |
| `get-unread-emails` | Retrieve unread emails from inbox |
| `read-email` | Read the content of a specific email |
| `trash-email` | Move an email to trash |
| `mark-email-as-read` | Mark an email as read |
| `open-email` | Open an email in the browser |


## Project Structure

```
mcp-gmail/
│
├── src/
│   └── gmail/
│       ├── __init__.py    # Package initialization
│       └── server.py      # MCP server implementation
│
├── .envrc                 # Environment variables for direnv
├── makefile               # Build and run commands
├── pyproject.toml         # Project metadata
├── requirements.txt       # Python dependencies
└── README.md              # This file
```

## Development

### Adding New Gmail Features

1. Add the relevant API call to the `GmailService` class
2. Register a new tool in the `handle_list_tools` function
3. Implement the tool handler in `handle_call_tool`

## License

[Your License Here]

## Acknowledgements

- [Model Context Protocol](https://github.com/anthropics/model-context-protocol)
- [Gmail API Python Client](https://developers.google.com/gmail/api/quickstart/python)
