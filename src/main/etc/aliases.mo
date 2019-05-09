process_mail: "| /usr/bin/spamc --max-size {{ MAIL_MAX_SIZE }} | curl -X POST -H 'Content-Type: application/octet-stream' --data-binary @- {{ API_URL }}"
