# automationScripts

To add the script to crontab

1. crontab -e
2. add the below line
*/5 * * * * /path/to/script
the above would run the cron every 5 minutes

to run every minute
* * * * * /path/path/to/script

every 10 minutes 
*/10 * * * * /path/to/script

3. to check logs
tail -f /var/mail/root (if logged in via root)

4. also
tail -f /var/log/syslog


