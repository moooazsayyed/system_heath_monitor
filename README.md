# System Monitor Script

This Bash script is designed to monitor the CPU load of a system and send email notifications when the CPU load exceeds specified thresholds. It also logs the CPU load information to a log file for reference.

## Prerequisites
Before using this script, ensure the following prerequisites are met:
- The script should be executed on a Linux system with Bash shell.
- The `mail` command should be installed and configured to send emails.

## Usage
1. Save this script to a file, e.g., `sysmonitor.sh`.

2. Make the script executable:
   ```bash
   chmod +x sysmonitor.sh
   ```

3. Edit the script to set your desired thresholds and email addresses:
   - `criticalcase`: The CPU load threshold above which a critical email notification will be sent.
   - `warning`: The CPU load threshold above which a warning email notification will be sent.
   - `CRITICALMail`: The email address to which critical notifications will be sent.
   - `Mailwarning`: The email address to which warning notifications will be sent.

4. Run the script:
   ```bash
   ./sysmonitor.sh
   ```

## Functionality
- The script monitors the CPU load of the system using the `top` command.
- It calculates the CPU load percentage and compares it to the specified thresholds.
- If the CPU load exceeds the warning threshold but is below the critical threshold, a warning email notification is sent.
- If the CPU load exceeds the critical threshold, a critical email notification is sent, and the script exits with status 2.
- If the CPU load is within acceptable limits, an "OK" message is logged, and the script exits with status 0.

## Logging
- The script logs its activities to a log file located at `/var/log/sysmonitor/sysusage-<date>`.
- The log file is created if it doesn't exist.
- Log entries include timestamps, CPU load information, and status messages.

## Customization
You can customize this script further to monitor additional system parameters or adjust the monitoring thresholds according to your requirements.

Please ensure that the script is executed periodically, for example, using a cron job, to continuously monitor the system's CPU load and receive timely notifications.
