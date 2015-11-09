#!/bin/sh

RESUL="result.pst"
rm -rf $RESUL

EXEC_NUM=0

while [ $EXEC_NUM -lt 1000 ]
do

#PID=`pgrep PDLSU1`
PID=$1

if [ "$PID" = "" ]
then
   echo "Please sepcify TA thread number."
   echo "For example: ./get_stack.sh 12345"
   exit 1
fi

`pstack $PID >> $RESUL` 

echo "************THE $EXEC_NUM TIME ***********" >>$RESUL

sleep 10

EXEC_NUM=$[EXEC_NUM+1]

echo "The script is collecting stack info. Please wait... EXEC_NUM is " $EXEC_NUM

done

