#!/usr/bin/env bash

# parameters:
# 1. x position
# 2. y position
# 3. facing: North South East West
# 4. Movement Instructions: 
#    A - Advance 
#    R - Right
#    L - Left

declare -a VALID_DIRECTIONS=("north" "east" "south" "west")
declare -a VALID_INSTRUCTIONS=("A" "L" "R")


function validate_direction() {
    local INPUT_DIRECTION="$1"
    if [[ " ${VALID_DIRECTIONS[*]} " =~ ${INPUT_DIRECTION} ]]; then
        echo "0" && return
    else
        echo "1" && return
    fi
}
#validate_direction "south"


function get_direction_index() {
    local INPUT_DIRECTION="$1"
    local RESULT=""
    for index in "${!VALID_DIRECTIONS[@]}"; do
        if [ "${INPUT_DIRECTION}" = "${VALID_DIRECTIONS[$index]}" ]; then
            RESULT="${index}"
        fi
    done
    echo "${RESULT}"
}

function validate_instructions() {
    local INPUT_INSTRUCTIONS="$1"
    IFS=' ' read -r -a INPUT_INSTRUCTIONS_LIST <<< "$(echo "${INPUT_INSTRUCTIONS}" | sed 's/./& /g' | awk '{$1=$1;print}')"
    #echo "$INPUT_INSTRUCTIONS_LIST"
    for intr in "${INPUT_INSTRUCTIONS_LIST[@]}"; do
        if [[ ! " ${VALID_INSTRUCTIONS[*]} " =~ ${intr} ]]; then
            echo "1" && return
        fi
    done
    echo "0" && return
}
#validate_instructions "R"

function main() {
    local X_POSITION="$1"
    local Y_POSITION="$2"
    local FACING_DIRECTION="$3"
    local INSTRUCTIONS="$4"


    #default parameters
    if [ -z "${X_POSITION}" ] && [ -z "${Y_POSITION}" ] && [ -z "${FACING_DIRECTION}" ]; then
        X_POSITION="0"
        Y_POSITION="0"
        FACING_DIRECTION="north"
    fi

    if [ "$(validate_direction "${FACING_DIRECTION}")" = "1" ]; then
        echo "invalid direction" && exit 1
    fi

    if [ "$(validate_instructions "${INSTRUCTIONS}")"  = "1" ]; then
        echo "invalid instruction" && exit 1
    fi


    # If null instructions return information back
    if [ -z "${INSTRUCTIONS}" ]; then
        echo "${X_POSITION} ${Y_POSITION} ${FACING_DIRECTION}" && exit 0
    fi

    # Read into array
    IFS=' ' read -r -a INPUT_INSTRUCTIONS_LIST <<< "$(echo "${INSTRUCTIONS}" | sed 's/./& /g' | awk '{$1=$1;print}')"


    # For each instruction move robot
    local CURRENT_FACING_DIRECTION="${FACING_DIRECTION}"
    local CURRENT_X_POSITION="${X_POSITION}"
    local CURRENT_Y_POSITION="${Y_POSITION}"
    for instruction in "${INPUT_INSTRUCTIONS_LIST[@]}"; do
        case "${instruction}" in
            "R")
                #echo "R"
                dir_index=$(get_direction_index "${CURRENT_FACING_DIRECTION}")
                #echo "$dir_index"
                if [ "$dir_index" = "3" ];then
                    CURRENT_FACING_DIRECTION="${VALID_DIRECTIONS[0]}"
                else
                    dir_index=$((dir_index+1))
                    CURRENT_FACING_DIRECTION="${VALID_DIRECTIONS[$dir_index]}"
                fi
            ;;
            "L")
                #echo "L"
                dir_index=$(get_direction_index "${CURRENT_FACING_DIRECTION}")
                if [ "$dir_index" = "0" ]; then
                    CURRENT_FACING_DIRECTION="${VALID_DIRECTIONS[3]}"
                else
                    dir_index=$((dir_index-1))
                    CURRENT_FACING_DIRECTION="${VALID_DIRECTIONS[$dir_index]}"
                fi
            ;;
            "A")
                #echo "A"
                if [ "${CURRENT_FACING_DIRECTION}" = "north" ]; then
                    CURRENT_Y_POSITION=$((CURRENT_Y_POSITION+1))
                elif [ "${CURRENT_FACING_DIRECTION}" = "east" ]; then
                    CURRENT_X_POSITION=$((CURRENT_X_POSITION+1))
                elif [ "${CURRENT_FACING_DIRECTION}" = "south" ]; then
                    CURRENT_Y_POSITION=$((CURRENT_Y_POSITION-1))
                else # west
                    CURRENT_X_POSITION=$((CURRENT_X_POSITION-1))
                fi
            ;;
        esac
    done

    echo "${CURRENT_X_POSITION} ${CURRENT_Y_POSITION} ${CURRENT_FACING_DIRECTION}"
}

main "$@"
