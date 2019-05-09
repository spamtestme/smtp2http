process_mail: "| /usr/bin/spamc -s {{ MAIL_MAX_SIZE }} | curl --data-binary @- {{ API_URL }}"
