#!/bin/bash

# Run stunnel for the email redirection
stunnel /etc/stunnel/stunnel.conf

# Run elog
elogd -p 9090 -c /elog-nfs/elogd.cfg
