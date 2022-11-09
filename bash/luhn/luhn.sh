#!/usr/bin/env bash

# Luhn algorithm
: '
# Rules
Strings of length 1 or less not valid
Spaces are allowed but should be stripped before checking
Non-digit charaters are no allowed

# Procedure
1. double every second digit, start from right
2. If number > 9 then = result - 9
3. Sum all digits
4. If sum is divisble by 10 then number is valid, otherwise invalid
'

#Reverse given input string
function reverse() {
    INPUT="$1"
    strlen=${#INPUT}
    revstr=""
    for (( i=strlen-1; i>=0; i-- ));
    do
        revstr=$revstr${INPUT:$i:1}
    done
    echo "$revstr"
}

# Validates input and returns string list without spaces
function validate() {

    INPUT="${1// /}"
    if [ "${INPUT}" = "0" ];then
        return 1
    elif [ "${#INPUT}" -le "1" ];
    then
        return 1
    fi
    
    re='^[0-9]+$'
    if ! [[ $INPUT =~ $re ]] ; then
        return 1
    else 
        return 0
    fi
}

# Luhn algorithm; returns sum of digits
function luhn() {
    INPUT="$1"
    ARRAY=()
    IFS=" " read -r -a ARRAY <<< "$(reverse "${INPUT}" | sed 's/./ &/g')"

    OUT_ARRAY=()

    for i in "${!ARRAY[@]}";
    do
        M=$((i % 2))
        if [ "${M}" != "0" ];
        then
            TMP=$((ARRAY[i]*2))
            [ $TMP -gt 9 ] && OUT_ARRAY[$i]=$((TMP-9)) || OUT_ARRAY[$i]=$TMP
        else
            OUT_ARRAY[$i]=${ARRAY[$i]}
        fi
    done

    #SUM total of out_array
    SUM=$(echo "${OUT_ARRAY[@]}" | tr ' ' '+' | bc)

    echo "$SUM"
}


function main() {
    validate "$1"
    RC=$?

    if [ "$RC" = "1" ]; then
         echo "false"
    else
        TOTAL=$(luhn "${1// /}")
        MOD=$((TOTAL % 10))
        [ "${MOD}" = "0" ] && echo "true" || echo "false"
    fi
}
main "$@"