#!/bin/bash

function renderConfigTemplates(){
    mo '/etc/aliases.mo' > '/etc/aliases'
    mo '/etc/postfix/recipient_domains.mo' > '/etc/postfix/recipient_domains'
    mo '/etc/postfix/redirect.mo' > '/etc/postfix/redirect'
}

function copyFilesRequiredRunningInChrootJail(){
    cp /etc/services /var/spool/postfix/etc/
    cp /etc/resolv.conf /var/spool/postfix/etc/
}

function configureMailServer() {
    postconf -e mydomain="${MYDOMAIN}"
    postconf -e myhostname="${MYHOSTNAME}"
    postconf -e virtual_alias_maps="regexp:/etc/postfix/redirect"
    postconf -e local_recipient_maps=""
    postconf -e mail_name="${MAIL_NAME}"
    postconf -e smtpd_banner="${SMTPD_BANNER}"
    postconf -e smtpd_banner="${SMTPD_BANNER}"
    postconf -e smtpd_recipient_restrictions="check_recipient_access hash:/etc/postfix/recipient_domains, reject"
    postconf -e mydestination="${MYDOMAIN}, ${MYHOSTNAME}, localhost.localdomain, , localhost"

    postmap '/etc/postfix/redirect'
    postmap '/etc/postfix/recipient_domains'
    newaliases
}

function runServices(){
    rsyslogd
    spamd -d
    postfix start
    tail -f /dev/null
}

function main(){
    renderConfigTemplates
    copyFilesRequiredRunningInChrootJail
    configureMailServer
    runServices
}
