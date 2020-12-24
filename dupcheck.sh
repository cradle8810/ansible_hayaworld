#!/bin/sh

if [ "$#" -eq 0 ]; then
  echo "Usage $0 <files>"
  exit 2
fi

cat "$@" | \
sort | uniq -c | sort | \
grep -E -v '^(\s)+1 ' > /tmp/result

duplines=$(wc -l /tmp/result | awk '{print $1}')

if [ "$duplines" -eq 0 ]; then
  echo "[ OK ] No Duplicate lines."
  exit 0
else
  echo "[ NG ] Duplicate Line(s) found."
  cat /tmp/result
  exit 1
fi
