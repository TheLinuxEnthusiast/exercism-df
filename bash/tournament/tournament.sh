#!/usr/bin/env bash


function main() {

    INPUT=$(cat $1)
    if [ -z "${INPUT}" ]; 
    then
        printf "Team                           | MP |  W |  D |  L |  P\n"
    else
        printf "Team                           | MP |  W |  D |  L |  P\n"
        gawk -f ./process.awk <(echo "${INPUT}") | sort -t'|' -k6,6nr -k1,1 
    fi
}
main "$@"