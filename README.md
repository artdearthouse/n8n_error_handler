# Universal n8n Error Handler Deployment Guide

This repository contains a robust error handling system for n8n, featuring database logging, Telegram notifications with Webhook fallback, and a self-healing bootstrap mechanism.

**Repo**: [artdearthouse/n8n_error_handler](https://github.com/artdearthouse/n8n_error_handler)

## Prerequisites

1.  **PostgreSQL Database**: Accessible by your n8n instances.
2.  **Telegram Bot**: Token and Chat ID.
3.  **n8n instance**: With standard nodes needed.

## Installation

### 1. Database Setup
Run the SQL script in your PostgreSQL database to create the required table:

```bash
psql -h <host> -U <user> -d <database> -f sql/init.sql
```

### 2. Configure Credentials in n8n
Ensure the following credentials exist in your n8n instance (names can be adjusted, but you might need to edit the JSON):
*   `Postgres Default` (Postgres)
*   `Telegram Default` (Telegram API)
*   `n8n API` (n8n Public API, for the bootstrapper)

### 3. Deploy via Bootstrap
1.  Create a new Workflow in n8n.
2.  Import `workflows/bootstrap_manager.json` manually (Copy-Paste JSON content).
3.  **Configure**:
    *   Open the `Configuration` node (first node).
    *   Fill in your values for:
        *   `POSTGRES_CREDENTIAL_ID`
        *   `TELEGRAM_CREDENTIAL_ID`
        *   `N8N_API_CREDENTIAL_ID`
        *   `TELEGRAM_CHAT_ID`
        *   `TELEGRAM_THREAD_ID`
        *   `WEBHOOK_URL`
4.  Execute the workflow manually.

**What happens:**
*   It downloads `n8n_error_handler`.
*   If `n8n_error_handler` exists, it **DELETES** it first.
*   It **injects your credentials** into the new one.
*   It creates the new `n8n_error_handler` in your n8n instance.
*   It configured ALL other workflows to use the NEW `n8n_error_handler` ID.
*   It updates itself to the latest version.

### 4. Maintenance
*   To update the Error Handler logic across all servers, simple push changes to Git, and run `Bootstrap Manager` on each server.

