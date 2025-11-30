#!/bin/bash

# Объявление переменных
SERVICE_NAME="$HEALTH_CHECK_SERVICE_NAME"
LOG_FILE="$HEALTH_CHECK_LOG_FILE"
CHECK_URL="$HEALTH_CHECK_URL"
EXPECTED_TEXT="Hello World!"
TIMEOUT="$HEALTH_CHECK_TIMEOUT"

# Проверка обязательных переменных
if [ -z "$SERVICE_NAME" ] || [ -z "$LOG_FILE" ] || [ -z "$CHECK_URL" ] || [ -z "$TIMEOUT" ]; then
    echo "ERROR: Missing required environment variables"
    echo "SERVICE_NAME: $SERVICE_NAME"
    echo "LOG_FILE: $LOG_FILE" 
    echo "CHECK_URL: $CHECK_URL"
    echo "TIMEOUT: $TIMEOUT"
    exit 1
fi

# Создание файла для логирования при отсутствии
touch "$LOG_FILE"

# Функция для описания логов с временной меткой
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOG_FILE"
}

log_message "INFO: Starting health check for $SERVICE_NAME"

# Проверка доступности сервиса
if curl -s --max-time $TIMEOUT "$CHECK_URL" | grep -q "$EXPECTED_TEXT"; then
    log_message "INFO: Application is working correctly"
else
    log_message "WARNING: Application is not working, restarting..."
    # Перезапуск сервиса
    if systemctl restart "$SERVICE_NAME.service"; then
        log_message "INFO: Application restarted successfully"
    else
        log_message "ERROR: Failed to restart application"
    fi
fi
