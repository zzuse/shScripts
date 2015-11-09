#!/bin/bash

#set -x

if [ -z "$1" ]
then
    proc=1
else
    proc=$1
fi

print_tree()
{
    id=$1
    echo "$2$id" ${owner[$id]} ${command[$id]}
    if [ -z "${children[$id]}" ]
    then
        return
    else
        for child in ${children[$id]}
        do
            if [ "$child" = "`echo ${children[${ppid[$child]}]} | awk '{print $NF}'`" ]
            then
                echo "$2 \\"
                temp="$2 "
            else
                echo "$2|\\"
                temp="$2| "
            fi
            print_tree $child "$temp"
        done         
    fi
}

main()
{
    PSOUT=`ps -ef | grep -v "^UID" | sort -n -k2`
    while read line
    do
        declare -a process=( $line )
        pid=${process[1]}
        owner[$pid]=${process[0]}
        ppid[$pid]=${process[2]}
        command[$pid]=`echo $line | awk '{for(i=8;i<=NF;i++) {printf "%s ", $i}}'`
        children[${ppid[$pid]}]="${children[${ppid[$pid]}]} $pid"
    done <<EOF
    $PSOUT
EOF

print_tree $proc ""
}

main
