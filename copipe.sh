#!/bin/bash
thevar="one two three four five six"
pipe=/tmp/dapipe
exec 3<> main
exec 4<> sub
if [ -r $pipe ] 
then
    rm $pipe
fi

mkfifo $pipe


#set -x

subfunc()
{
    all=$*
    for i in $all                                                                    
    do                                                                               
        #set -m                                                                       
        echo $i > $pipe &                                                            
        #pstree -p -a $! >&4    
        echo before wait $$ $!                                                    
        wait     
        echo after wait $$ $!
        #pstree -p -a $! >&4                                                                    
        #set +m                                                                       
    done                                                                             
}

subfuncs()
{
    all=$*
    for i in $all
    do
        set -m
        echo $i > $pipe &
        pstree -p -a $!
        wait
        set +m
    done
}
 
subfunc $thevar &

echo pid is $$ $!

for i in 1 2 3 4 5 6
do
    echo main process
    pstree -p -a $$ >&3
    read readvar < $pipe
    echo ++the read var is $readvar
    sleep 1s
done
