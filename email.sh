#!/bin/sh

FROM="eklasky@klaskyethan@gmail.com"
TO="klaskyethan@gmail.com"

cat <<EOF | /usr/sbin/sendmail -i -t -v
From: ${FROM}
To: ${TO}
Subject: Test Email
Date: $(date -R)
Message-ID: <$(date +%s).$$@klaskyethan.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Hi Ethan,

This is a test email sent from the terminal using sendmail.

Best,
Ethan
EOF
