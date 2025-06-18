# Configuration file for the bot
# All values are loaded from environment variables for security and deployment flexibility
import os
from os import environ

# Required environment variables - these must be set in render.yaml or deployment environment
try:
    API_ID = int(environ.get("API_ID", "0"))
except (ValueError, TypeError):
    API_ID = 0

API_HASH = environ.get("API_HASH", "")
BOT_TOKEN = environ.get("BOT_TOKEN", "")

# Optional environment variables with defaults
OWNER = int(environ.get("OWNER", "0"))  # Default to 0 if not set
CREDIT = environ.get("CREDIT", "ミ★ medusaXD ★彡")

# Auth users configuration
AUTH_USER = os.environ.get('AUTH_USERS', str(OWNER)).split(',')
AUTH_USERS = [int(user_id.strip()) for user_id in AUTH_USER if user_id.strip().isdigit()]

# Ensure OWNER is in AUTH_USERS if OWNER is set
if OWNER and OWNER not in AUTH_USERS:
    AUTH_USERS.append(OWNER)

# Server configuration
#PORT = int(os.environ.get("PORT", 8000))  # Default to 8000 for Render.com

# Additional configuration for deployment
#WEBHOOK = os.environ.get("WEBHOOK", "False").lower() == "true"
