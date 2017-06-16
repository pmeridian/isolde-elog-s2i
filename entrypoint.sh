#!/bin/bash

# Start postfix server
#systemctl start postfix

# Run elog, for testing
elogd -p 9090 -c /etc/elogd.cfg -D

# Run elog, for real
#elogd -p 9090 -c /elog-nfs/elogd.cfg
