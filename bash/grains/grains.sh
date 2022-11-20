#!/usr/bin/env bash
#set -x

function get_grain_amount(){
    echo "2^(${1}-1)" | bc
}

function main(){

    if [ "$1" = "total" ];
    then
        local TOTAL=() 
        for (( i=0; i<64; i++ ))
        do
            SQUARE=$((i+1))
            GRAIN_AMOUNT=$(get_grain_amount "$SQUARE")
            TOTAL[$i]="${GRAIN_AMOUNT}"
        done
        echo "${TOTAL[@]}" | tr ' ' '+' | bc
    elif [ ! -n "$1" ] || [ "$1" -le "0" ] || [ "$1" -gt 64 ];
    then
        echo "Error: invalid input"
        exit 1
    else
        get_grain_amount "$1"
    fi
}
main "$@"