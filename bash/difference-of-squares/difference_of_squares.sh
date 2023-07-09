#!/usr/bin/env bash

# 1^2 + 2^2 + 3^2 + 4^2
function sum_of_squares() {
    local total=0
    local n="$1"
    for(( i=1; i<=n; i++ ))
    do
        tmp=$((i**2))
        total=$((total+tmp))
    done
    echo "${total}"
}

# ( 1 + 2 + 3 + 4 + 5 )^2
function square_of_sum() {
    local total=0
    local n="$1"
    for(( i=1; i<=n; i++ ))
    do
        total=$((total+i))
    done
    total=$((total**2))
    echo "${total}"
}

function difference() {
    local n="$1"
    square_of_sum_res=$(square_of_sum "$n")
    sum_of_squares_res=$(sum_of_squares "$n")
    diff=$((square_of_sum_res-sum_of_squares_res))
    echo "${diff}"
}

function main() {
    local command="$1"
    local n="$2"
    #echo "$command"
    #echo "$n"


    [ "$command" = "square_of_sum" ] && square_of_sum "$n" && exit 0
    
    [ "$command" = "sum_of_squares" ] && sum_of_squares "$n" && exit 0
    
    [ "$command" = "difference" ] && difference "$n" && exit 0
}
main "$@"
