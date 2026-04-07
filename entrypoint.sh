#!/bin/bash

set +e
set -x  

echo "=== ENTRYPOINT STARTED ==="

echo "1: starting jottad"
jottad &

echo "2: sleep"
sleep 2

echo "3: status"
jotta-cli status

echo "4: grep check"
jotta-cli status | grep "Sync is not enabled"

echo "5: sync start"
jotta-cli sync start

echo "6: before tail"

LOG_FILE="/root/.jottad/jottabackup.log"

echo "7: wait for log"
while [ ! -f "$LOG_FILE" ]; do
  sleep 1
done

echo "8: tail logfile"

tail -n 0 -F "$LOG_FILE"