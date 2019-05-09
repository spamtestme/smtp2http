#!/bin/bash

curl "smtp://$MYDOMAIN" --mail-from "$MAIL_FROM" --mail-rcpt "$MAIL_TO" --upload-file mail.txt