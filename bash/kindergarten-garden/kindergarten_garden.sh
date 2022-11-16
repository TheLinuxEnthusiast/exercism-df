#!/usr/bin/env bash

function print_plants(){
    declare -A plant_map
    plant_map["G"]="grass"
    plant_map["C"]="clover"
    plant_map["R"]="radishes"
    plant_map["V"]="violets"
    INPUT="$1"

    echo "${plant_map[${INPUT:0:1}]} ${plant_map[${INPUT:1:1}]} ${plant_map[${INPUT:2:1}]} ${plant_map[${INPUT:3:1}]}"
}



function main() {
    # Arg1 is the garden string
    # Arg2 is the childs name
    
    IFS="|" read -r -a garden <<< $(echo "$1" | tr '\n' '|') 
    CHILD="$2"

    RESULT=""
    for row in "${garden[@]}";
    do
        if [ "${CHILD}" = "Alice" ];
        then
            #echo ${row:0:2}
            RESULT="${RESULT}${row:0:2}"
        elif [ "${CHILD}" = "Bob" ]
        then
            RESULT="${RESULT}${row:2:2}"
        elif [ "${CHILD}" = "Charlie" ]
        then
            RESULT="${RESULT}${row:4:2}"
        elif [ "${CHILD}" = "David" ]
        then
            RESULT="${RESULT}${row:6:2}"
        elif [ "${CHILD}" = "Eve" ]
        then
            RESULT="${RESULT}${row:8:2}"
        elif [ "${CHILD}" = "Fred" ]
        then
            RESULT="${RESULT}${row:10:2}"
        elif [ "${CHILD}" = "Ginny" ]
        then
            RESULT="${RESULT}${row:12:2}"
        elif [ "${CHILD}" = "Harriet" ]
        then
            RESULT="${RESULT}${row:14:2}"
        elif [ "${CHILD}" = "Ileana" ]
        then
            RESULT="${RESULT}${row:16:2}"
        elif [ "${CHILD}" = "Joseph" ]
        then
            RESULT="${RESULT}${row:18:2}"
        elif [ "${CHILD}" = "Kincaid" ]
        then
            RESULT="${RESULT}${row:20:2}"
        elif [ "${CHILD}" = "Larry" ]
        then
            RESULT="${RESULT}${row:22:2}"
        else
            RESULT="${RESULT}"
        fi
    done
    #echo "${RESULT}"
    print_plants "${RESULT}"
}
main "$@"
#main $'VC\nRC' "Alice"