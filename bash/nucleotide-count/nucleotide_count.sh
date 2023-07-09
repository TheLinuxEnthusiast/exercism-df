#!/usr/bin/env bash

function print_count() {
    printf "A: %s\nC: %s\nG: %s\nT: %s" "$1" "$2" "$3" "$4"
}

function main() {
    [ -z "$1" ] && ( print_count 0 0 0 0 ) && exit 0
    LEN="${#1}"
    A=0
    C=0
    G=0
    T=0

    for((i=0; i<LEN; i++))
    do
        if [ "${1:$i:1}" = "A" ]
        then
            ((A++))
        elif [ "${1:$i:1}" = "C" ]
        then
            ((C++))
        elif [ "${1:$i:1}" = "G" ] 
        then
            ((G++))
        elif [ "${1:$i:1}" = "T" ]
        then
            ((T++))
        else
            echo "Invalid nucleotide in strand"
            exit 1
        fi
    done

    print_count "$A" "$C" "$G" "$T"
}
main "$@"