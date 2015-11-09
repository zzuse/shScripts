#!/bin/bash
set -x
evenodd()
{
    LAST_DIGIT=`echo $1 | sed 's/\(.*\)\(.\)\(.\)/\3/'`
    case $LAST_DIGIT in
    0|2|4|6|8 )
        return 1
    ;;
    *)
        return 0
    ;;
    esac
}
set +x
#evenodd $1
