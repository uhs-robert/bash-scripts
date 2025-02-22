#!/bin/bash

LOG_DIR="/home/roberth/.log"

for dir in "$LOG_DIR" "$LOG_DIR/cron"; do
  if [ -d "$dir" ]; then
    find "$dir" -maxdepth 1 -type f -name "*.log" |
      sed -E "s/_[0-9]{4}-[0-9]{2}-[0-9]{2}.*.log//" |
      sort | uniq |
      while read -r prefix; do
        ls -t "${prefix}"_*.log 2>/dev/null | tail -n +6 | xargs rm -f
      done
  fi
done
