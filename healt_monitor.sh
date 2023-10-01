#!/bin/bash

hostname=$(hostname)
criticalcase=98
warning=90
CRITICALMail="sayyedmooaz@gmail.com"
Mailwarning="mooazsayyedbiz@gmail.com"
mkdir -p /var/log/sysmonitor
LOGFILE="/var/log/sysmonitor/sysusage-$(date +%Y%m%d)"

touch "$LOGFILE"

# Function to send email notification
send_notification() {
    local subject="$1"
    local message="$2"
    local recipient="$3"
    echo "$message" | mail -s "$subject" "$recipient"
}

# Function to log and exit with status
log_and_exit() {
    local message="$1"
    local status="$2"
    echo "$(date "+%F %H:%M:%S") $message" >> "$LOGFILE"
    exit "$status"
}

# Monitor CPU Load
CPULOAD=$(top -b -n 2 -d 1 | grep "Cpu(s)" | tail -n 1 | awk '{print $2}' | awk -F. '{print $1}')
if [ -n "$CPULOAD" ]; then
    if [ "$CPULOAD" -ge "$warning" ] && [ "$CPULOAD" -lt "$criticalcase" ]; then
        send_notification "CPU Load Warning" "Warning CPU Load: $CPULOAD Host: $hostname" "$Mailwarning"
        log_and_exit "Warning - CPU Load: $CPULOAD on HOST $hostname" 1
    elif [ "$CPULOAD" -ge "$criticalcase" ]; then
        send_notification "CPU Load Critical" "CRITICAL CPU Load: $CPULOAD Host: $hostname" "$CRITICALMail"
        log_and_exit "CRITICAL - CPU Load: $CPULOAD on Host $hostname" 2
    else
        log_and_exit "OK - CPU Load: $CPULOAD on $hostname" 0
    fi
else
