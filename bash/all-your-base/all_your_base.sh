#!/usr/bin/env bash



# Converts input number to base10
function convert_to_base10() {
    local INPUT_BASE="$1"
    local INPUT_STRING="$2"
    local TOTAL="0"

    IFS=';' read -r -a number_array <<< "$(echo "${INPUT_STRING}" | tr ' ' ';')"

    # Number of zeros greater than 1
    local zero_count="0"
    for i in "${number_array[@]}"; do
        if [ "$i" == "0" ]; then
            zero_count=$(( zero_count+1 ))
        fi
    done

    #If the array contains only zeros
    if  [ "${zero_count}" == "${#number_array[@]}" ]; then
        echo "0" && return 0
    fi 

    # If first element is a zero remove it
    for i in ${!number_array[@]}; do 
        if [ "${number_array[$i]}" == "0" ] && [ "$i" == "0" ] ; then
            unset number_array[$i]
        fi 
    done

    #If input base is already 10
    if [ "${INPUT_BASE}" == "10" ]; then
        echo "${INPUT_STRING}" && return 0
    fi

    local number_array_len="${#number_array[@]}"

    local index="$((number_array_len-1))"
    for i in "${number_array[@]}"; do
        VAL="$(( (INPUT_BASE**index) * i ))"
        TOTAL=$((TOTAL + VAL))
        index=$((index - 1))
    done

    echo "${TOTAL}" | sed 's/./& /g'

}
#convert_to_base10 10 "5"
#convert_to_base10 3 "1 1 2 0"

# Converts from a base10 number to base 'N' 
function convert_from_base10() {
    local OUTPUT_BASE="$1"
    local INPUT_STRING_BASE10=$(echo "$2" | sed 's/ //g')

    local CURRENT="${INPUT_STRING_BASE10}"
    local QUOTENT="${INPUT_STRING_BASE10}"
    local OUTPUT_STRING=""

    while [ "${QUOTENT}" -gt "0" ]; do
        QUOTENT=$(( CURRENT / OUTPUT_BASE ))
        REMAINDER=$(( CURRENT % OUTPUT_BASE ))
        #echo ${QUOTENT}
        if [ "${QUOTENT}" = "0" ]; then 
            OUTPUT_STRING="${REMAINDER} ${OUTPUT_STRING}"
            break
        else
            OUTPUT_STRING="${REMAINDER} ${OUTPUT_STRING}"
        fi
        CURRENT="${QUOTENT}"
    done
    echo "$OUTPUT_STRING"
}
#convert_from_base10 2 "5"
# "2 10"

function main() {
    local INPUT_BASE="$1"
    local INPUT_STRING="$2"
    local OUTPUT_BASE="$3"

    IFS=';' read -r -a number_array_tmp <<< "$(echo "${INPUT_STRING}" | tr ' ' ';')"

    if (( "${INPUT_BASE}" <= "1" )); then
        echo "Error: Input base is less than or equal to 1" && exit 1
    fi

    if (( "${OUTPUT_BASE}" <= "1" )); then
        echo "Error: Output base is less than or equal to 1" && exit 1
    fi

    if [ -z "${INPUT_STRING}" ]; then
        echo "0" && exit 0
    fi

    # If there are invalid digits in number
    uniqs_arr=($(for nums in "${number_array_tmp[@]}"; do echo "${nums}"; done | sort -u))
    if [ "${#uniqs_arr[@]}" -gt "${INPUT_BASE}" ]; then
        echo "Invalid digits within input string" && exit 1
    fi

    base10_number=$( convert_to_base10 "${INPUT_BASE}" "${INPUT_STRING}" )

    if [ "$base10_number" == "0" ]; then
        echo "$base10_number" && exit 0
    fi 

    number_new_base=$( convert_from_base10 "${OUTPUT_BASE}" "${base10_number}" )
    echo "${number_new_base}" | awk '{$1=$1};1'

}
main "$@"