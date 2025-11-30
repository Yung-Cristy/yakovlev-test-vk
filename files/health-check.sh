#!/bin/bash

SERVICE_NAME="$HEALTH_CHECK_SERVICE_NAME"
LOG_FILE="$HEALTH_CHECK_LOG_FILE"
CHECK_URL="$HEALTH_CHECK_URL"
EXPECTED_TEXT="Hello World!"
TIMEOUT="$HEALTH_CHECK_TIMEOUT"

touch "$LOG_FILE"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOG_FILE"
}

log_message "INFO: Starting health check for $SERVICE_NAME"

if curl -s --max-time $TIMEOUT "$CHECK_URL" | grep -q "$EXPECTED_TEXT"; then
    log_message "INFO: Application is working correctly"
else
    log_message "WARNING: Application is not working, restarting..."
    
    if systemctl restart "$SERVICE_NAME.service"; then
        log_message "INFO: Application restarted successfully"
    else
        log_message "ERROR: Failed to restart application"
    fi
fi
