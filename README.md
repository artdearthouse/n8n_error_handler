# Universal n8n Error Handler Deployment Guide

This repository contains a robust error handling system for n8n, featuring database logging, Telegram notifications with Webhook fallback, and a self-healing bootstrap mechanism.

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
3.  **Edit**:
    *   `Fetch Capture WF` node: Update the URL to your Raw Git file for `workflows/error_capture.json`.
    *   *(Optional)* You can extend it to also fetch/update `error_processor.json`.
4.  Execute the workflow manually.

**What happens:**
*   It downloads the `Error Capture` workflow.
*   It creates/updates it in your n8n instance.
*   It scans **ALL** other workflows.
*   It updates their `Settings -> Error Workflow` to point to the new `Error Capture` workflow.

### 4. Deploy Processor
1.  Import `workflows/error_processor.json`.
2.  Update credential references if needed.
3.  Activate the workflow.

## maintenance
*   To update the Error Handler logic across all servers, simple push changes to Git, and run `Bootstrap Manager` on each server.
