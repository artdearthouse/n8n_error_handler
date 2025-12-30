CREATE TABLE IF NOT EXISTS error_logs (
    id SERIAL PRIMARY KEY,
    workflow_name TEXT,
    execution_id TEXT,
    error_message TEXT,
    stack_trace TEXT,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    
    -- Status flags
    sent_to_tg BOOLEAN DEFAULT FALSE,
    processing_attempts INTEGER DEFAULT 0,
    last_attempt TIMESTAMP WITH TIME ZONE
);

CREATE INDEX IF NOT EXISTS idx_error_logs_sent_to_tg ON error_logs(sent_to_tg);
CREATE INDEX IF NOT EXISTS idx_error_logs_timestamp ON error_logs(timestamp);
