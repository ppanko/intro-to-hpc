#!/bin/bash
if [ $# -ne 1 ]; then
   exit 1;
fi
while true; do
    qstat
    sleep $1
done

