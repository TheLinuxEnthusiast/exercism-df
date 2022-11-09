#!/usr/bin/env bash
#set -x

function pad_lines() {
    local -n ary=$1
    local -i i

    for ((i = ${#ary[@]} - 2; i >= 0; i--)); do
        # Pad the right end of the string with spaces
        printf -v 'ary[i]' "%-*s" ${#ary[i + 1]} "${ary[i]}"
    done
}


function main() {
    
    [[ -t 0 ]] && exit

    local -a input output
    local -i i j

    readarray -t input
    pad_lines input

    for ((i = 0; i < ${#input[@]}; i++)); do
        for ((j = 0; j < ${#input[i]}; j++)); do
            output[j]+=${input[i]:j:1}
            #echo ${output[j]}
        done
    done
    printf "%s\n" "${output[@]}"
}
main "$@"