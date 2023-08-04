#!/bin/bash

# Replace these variables with your Slack webhook URL and channel name
SLACK_WEBHOOK_URL=$WEBHOOK_URL
SLACK_CHANNEL=$SLACK_CHANEEL

# Path to the file you want to check
FILE_PATH="/tmp/newfile.txt"

# Function to send a Slack message with the error
send_slack_alert() {
    message="Hello from Bash!!"
    payload="payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"AlertBot\", \"text\": \"${message}\", \"color\": \"danger\"}"
    curl -X POST --data-urlencode "${payload}" "${SLACK_WEBHOOK_URL}"
}

while true; do
    # Read the last 200 lines of the file and check for the keyword "replication"
    error_lines=$(tail -n 1 "${FILE_PATH}" | grep "bat")

    # If there are any error lines, send a Slack alert
    if [ -n "$error_lines" ]; then
        error_message="Error: Found 'replication' keyword in the last 200 lines of the file:\n$error_lines"
        send_slack_alert "$error_message"
    fi

    # Adjust the delay interval as needed (e.g., 5 seconds in this example)
    sleep 5
done