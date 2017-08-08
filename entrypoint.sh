#!/bin/bash

# Run elog, for testing
#elogd -p 9090 -c /etc/elogd.cfg -D

# Run elog, for real
elogd -p 8080 -c /elog-nfs/elogd.cfg
