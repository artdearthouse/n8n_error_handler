# Universal n8n Error Handler Deployment Guide

# Universal n8n Error Handler (Unified)

A robust, "indestructible" error handling system for n8n. It captures errors from any workflow, logs them to a PostgreSQL database, and sends formatted notifications to Telegram with a Webhook fallback.

---

## ⚡️ Key Features
- **Unified Workflow**: One file handles both error capture and periodic processing.
- **Robust Notifications**: Automatic Telegram MarkdownV2 escaping and log truncation (no more 400 Bad Request errors).
- **Double Safety**: If Telegram fails, it automatically attempts a Webhook fallback.
- **Persistence**: Errors are stored in DB first, ensuring no data loss if Telegram is down.

---

## 🚀 Manual Deployment (Recommended)

### 1. Database Setup
Run the initialization script on your PostgreSQL instance:
```bash
# Connect to your postgres and run:
psql -h your-host -U your-user -d your-db -f sql/init.sql
```

### 2. Workflow Import
1.  Download [workflows/n8n_error_handler.json](https://raw.githubusercontent.com/artdearthouse/n8n_error_handler/main/workflows/n8n_error_handler.json).
2.  In n8n, go to **Workflows > Add Workflow > Import from File**.
3.  Open the **Config** node and fill in your details:
    - `TELEGRAM_CHAT_ID`: Your Chat ID.
    - `TELEGRAM_THREAD_ID`: Thread ID (if using Topics).
    - `WEBHOOK_URL`: Your fallback webhook.

### 3. Connect Credentials
Ensure you have the following credentials configured in n8n and selected in the respective nodes:
- **Postgres**: For `Log to DB`, `Fetch Pending`, and `Mark Sent` nodes.
- **Telegram**: For the `Telegram` node.

---

## 🛠 Usage
To protect any workflow:
1.  Open the workflow settings (Gear icon).
2.  Set **Error Workflow** to `n8n_error_handler`.
3.  Save. 

Now, any unhandled error will be automatically caught, logged, and sent to your Telegram.
