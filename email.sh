#!/bin/sh

FROM="klaskyethan@gmail.com"
TO="ethanklasky@gmail.com"

cat <<EOF | /usr/sbin/sendmail -i -t
From: ${FROM}
To: ${TO}
Subject: Homework Update test
Date: $(date -R)
Message-ID: <$(date +%s).$$@klaskyethan.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

Hi Ethan,

I finially can send emails from the terminal.

Best,
Ethan
EOF
