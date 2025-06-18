# Deployment Guide for Medusa Course Bot

This guide explains how to deploy the Medusa Course Bot on Render.com with Docker and background worker support.

## Prerequisites

1. A Render.com account
2. A Telegram Bot Token (from @BotFather)
3. Telegram API credentials (API_ID and API_HASH from my.telegram.org)

## Deployment Steps

### 1. Fork/Clone the Repository

Fork this repository to your GitHub account or clone it to your local machine.

### 2. Update render.yaml

Edit the `render.yaml` file and update the following:

```yaml
repo: https://github.com/your-username/medusaCourse  # Update with your actual repo URL
```

### 3. Set Environment Variables

In your Render.com dashboard, set the following required environment variables:

#### Required Variables:
- `BOT_TOKEN`: Your Telegram bot token from @BotFather
- `API_ID`: Your Telegram API ID from my.telegram.org
- `API_HASH`: Your Telegram API hash from my.telegram.org

#### Optional Variables:
- `OWNER`: Your Telegram user ID (numeric)
- `AUTH_USERS`: Comma-separated list of authorized user IDs
- `CREDIT`: Bot credit text (default: "𝙎𝘼𝙄𝙉𝙄 𝘽𝙊𝙏𝙎")

### 4. Deploy on Render.com

1. Connect your GitHub repository to Render.com
2. Create a new service using the `render.yaml` file
3. Render will automatically create both web and worker services
4. Set the required environment variables in the Render dashboard

## Service Architecture

The deployment creates a single background worker service:

### Worker Service (`medusa-course-bot`)
- Runs the Telegram bot as a background worker
- Handles all bot functionality and user interactions
- Processes downloads and file operations
- No web interface or ports needed
- Pure background service optimized for Render.com

## File Structure Changes

The following files have been renamed/updated for better deployment:

- `saini.py` → `workers.py` (worker functions)
- `sainibots.txt` → `requirements.txt` (Python dependencies)
- Updated `vars.py` to use environment variables
- Enhanced `Dockerfile` for Render.com optimization
- Comprehensive `render.yaml` configuration

## Environment Variables Reference

| Variable | Description | Required | Default |
|----------|-------------|----------|---------|
| `BOT_TOKEN` | Telegram bot token | Yes | - |
| `API_ID` | Telegram API ID | Yes | - |
| `API_HASH` | Telegram API hash | Yes | - |
| `OWNER` | Bot owner user ID | No | 0 |
| `AUTH_USERS` | Authorized user IDs | No | OWNER value |
| `CREDIT` | Bot credit text | No | "𝙎𝘼𝙄𝙉𝙄 𝘽𝙊𝙏𝙎" |
| `PORT` | Web service port | No | 8000 |
| `WEBHOOK` | Enable webhook mode | No | false |

## Monitoring and Logs

- Worker service logs are available in Render dashboard
- Bot includes comprehensive error handling and logging
- No web interface needed - pure background worker

## Troubleshooting

### Common Issues:

1. **Bot not starting**: Check that all required environment variables are set
2. **Import errors**: Ensure all dependencies are in `requirements.txt`
3. **Permission errors**: Verify bot token and API credentials are correct

### Checking Logs:

1. Go to your Render.com dashboard
2. Select the worker service
3. View logs to see bot startup messages and any errors

## Token Management

The bot includes dynamic token management for frequently expiring tokens:

### Available Commands (Owner Only):

**Token Management:**
- `/load_token_cp <new_token>` - Update the CP token when it expires
- `/load_adda_token <new_token>` - Update the ADDA token when it expires
- `/show_tokens` - Display current token status

**User Management:**
- `/add_user <id> [name]` - Add authorized user (name optional)
- `/remove_user <id>` - Remove authorized user
- `/users` - List all authorized users

### Usage Example:
```
/load_token_cp eyJjb3Vyc2VJZCI6IjQ1NjY4NyIsInR1dG9ySWQiOm51bGwsIm9yZ0lkIjo0ODA2MTksImNhdGVnb3J5SWQiOm51bGx9r
```

### Features:
- **Persistent Storage**: Tokens are saved to `dynamic_tokens.json` and persist across restarts
- **Owner Only**: Only the bot owner can update tokens
- **Validation**: Basic token format validation
- **Logging**: All token updates are logged with timestamps
- **Preview**: Shows token previews for verification

## Support

For issues related to:
- Bot functionality: Check the original repository documentation
- Deployment: Review this guide and Render.com documentation
- Environment setup: Verify all required variables are set correctly
- Token management: Use the `/show_tokens` command to check current status
