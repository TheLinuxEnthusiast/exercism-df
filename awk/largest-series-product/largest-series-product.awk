#!/usr/bin/gawk -f
# Author: Darren Foley
# Date: 2022-11-14
# Example input looks like this -> 576802143,2


BEGIN {
    FS=","
}
{
    INPUT=$1
    SPAN=$2
    INPUT_LEN=length(INPUT)
    test=match(INPUT, /^[0-9]*$/)

    if(SPAN==0 && INPUT_LEN==0){
        print "1"
        exit 0
    }
    else if(SPAN==0){
        print "1"
        exit 0
    }
    else if(SPAN > INPUT_LEN){
        print "span must be smaller than string length"
        exit 1
    }
    else if(test != 1){
        print "input must only contain digits"
        exit 1
    }
    
    else if(SPAN<0){
        print "span must not be negative"
        exit 1
    }
    else {
        for(i=1; i<INPUT_LEN; i++){
            TMP=substr(INPUT, i, SPAN)
            RESULT=1
            for(j=1; j<=SPAN; j++){
                n=substr(TMP, j, 1)
                RESULT*=n
            }
            TOTAL[i]=RESULT
        }
    }
}
END {
    asort(TOTAL, FINAL_RESULT)
    print FINAL_RESULT[length(FINAL_RESULT)]
}