#!/usr/bin/env -S bash

LOG_DIR=/var/log/opendkim
STDOUT="${LOG_DIR}/stdout.log"
STDERR="${LOG_DIR}/stderr.log"

mkdir -p "${LOG_DIR}"

DOMAINS=""
for dmn in /etc/postfix/dkim/*/; do
    DOMAINS="${DOMAINS},$(basename "$dmn")"
done
DOMAINS="${DOMAINS:1}"

/usr/sbin/opendkim -v -W -f -D \
    -x /etc/opendkim.conf \
    -u opendkim \
    -P /run/opendkim/opendkim.pid \
    -d "${DOMAINS}" > /var/log/opendkim.log 2> /var/log/opendkim.error.log
