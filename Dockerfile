FROM ubuntu:18.04 AS main

ARG DEBIAN_FRONTEND='noninteractive'

RUN apt-get update \
    && apt-get install -y \
        postfix \
        spamassassin \
        curl \
        rsyslog \
    &&  rm -rf /var/lib/apt/lists/*

RUN curl -sSL https://git.io/get-mo -o /usr/local/bin/mo \
    && chmod +x /usr/local/bin/mo

COPY ./src/main /

ENV MAIL_PATTERN='/^.*$/'
ENV MYDOMAIN='localhost'
ENV MYHOSTNAME='mail.localhost'
ENV API_URL='http://localhost/mail'
ENV MAIL_MAX_SIZE=256000000
ENV MAIL_NAME='Mailr'
ENV SMTPD_BANNER='$myhostname ESMTP $mail_name'

EXPOSE 25

CMD /run.sh
