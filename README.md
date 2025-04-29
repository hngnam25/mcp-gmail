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

### 5. OAuth 2.0 Credentials

1. Create a project in the [Google Cloud Console](https://console.cloud.google.com/)
2. Enable the Gmail API
3. Create OAuth 2.0 credentials and download the JSON file
4. Save the credentials file as `gcp-oauth.keys.json` in the project root

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

## OAuth Consent

On first run, the application will open a browser window for OAuth consent. After granting permission, your credentials will be saved to the specified token path for future use.

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
