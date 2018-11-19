#!/bin/bash
if [ $# -ne 4 ]; then
   exit 1;
fi

path=$2@quanah.hpcc.ttu.edu

if [ $1 = "-t" ]; then
    rsync -ave ssh $3 $path:$4
fi

if [ $1 = "-f" ]; then
    rsync -ave ssh $path:$3 $4  
fi
