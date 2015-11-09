#!/bin/bash

cmd_file=/u/bp.cmd

E_BADARGS=65

if [ -z "$1" ]
then
  echo "Usage: `basename $0` process_name"
  exit $E_BADARGS
fi

PNAME=$1

echo "The process to gdb: $PNAME"

while [ 1 ]
do

p_id=`pgrep $PNAME`

if [ "$p_id" != "" ]
then
   printf "\nPID of $PNAME is: $p_id\n"
   break;
fi

sleep 1s;

printf "."

done

exec gdb -x $cmd_file -p $p_id

