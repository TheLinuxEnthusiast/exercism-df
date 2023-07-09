#!/usr/bin/env bash

usage() { echo "Usage: $0 [-n] [-l] [-i] [-v] [-x]" 1>&2; exit 1; }

NUMBER_PREFIX=1
NAMES_OF_FILES=1
CASE_INSENSITIVE=1
INVERT_MATCH=1
MATCH_ENTIRE_LINE=1

while getopts ":nlivx" o; do
    case "${o}" in
        n)
            NUMBER_PREFIX=0
            ;;
        l)
            NAMES_OF_FILES=0
            ;;
        i)
            CASE_INSENSITIVE=0
            ;;
        v)
            INVERT_MATCH=0
            ;;
        x)
            MATCH_ENTIRE_LINE=0
            ;;
        *)
            usage
            ;;
    esac
done
shift "$((OPTIND-1))"


# Flags   pattern   files
function main() {
    local NUM_ARGS="$#"
    local ARGS="$@"
    local PATTERN="$1"
    local -a FILES=()
    for((i=2; i<=NUM_ARGS; i++))
    do 
        eval ARG='$'$i
        FILES+=($ARG)
    done
    local NUM_FILES="${#FILES[@]}"
    #echo "${NUM_ARGS}"
    #echo "${ARGS}"
    #echo "${PATTERN}"
    #echo "${FILES[@]}"
    local -a RESULT_LINES=()

    
    for file in "${FILES[@]}"
    do
        LINE_NUMBER=0
        FILE_NAME="$file"
        while IFS= read -r line; 
        do
            ((LINE_NUMBER++))
            _line="$line"
            if [ "${CASE_INSENSITIVE}" = "0" ]
            then
                PATTERN="${PATTERN,,}"
                _line="${line,,}"
            fi

            # Invert match is true
            if [ "${INVERT_MATCH}" = "0" ]
            then
                if ! [[ "${_line}" =~ "${PATTERN}" ]] && [[ "$MATCH_ENTIRE_LINE" == "1" ]];
                then
                    if [ "${NAMES_OF_FILES}" = "0" ]
                    then
                        if ! [[ " ${RESULT_LINES[*]} " =~ " ${file} " ]]; 
                        then
                            RESULT_LINES+=("${file}")
                        fi
                    else
                        if [ "${NUMBER_PREFIX}" = "0" ];
                        then
                            if [ "${NUM_FILES}" = "1" ];
                            then
                                tmp="${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                            
                        else
                            if [ "${NUM_FILES}" = "1" ]
                            then
                                tmp="${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        fi
                    fi
                elif ! [[ "${_line}" == "${PATTERN}" ]] && [[ "$MATCH_ENTIRE_LINE" == "0" ]]; # Entire line
                then
                    if [ "${NAMES_OF_FILES}" = "0" ]
                    then
                        if ! [[ " ${RESULT_LINES[*]} " =~ " ${file} " ]]; 
                        then
                            RESULT_LINES+=("${file}")
                        fi
                    else
                        if [ "${NUMBER_PREFIX}" = "0" ];
                        then
                            if [ "${NUM_FILES}" = "1" ];
                            then
                                tmp="${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        else
                            if [ "${NUM_FILES}" = "1" ]
                            then
                                tmp="${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        fi
                    fi
                fi
            else # regular Match is found
                if [[ "${_line}" =~ "${PATTERN}" ]] && [[ "$MATCH_ENTIRE_LINE" == "1" ]];
                then
                    if [ "${NAMES_OF_FILES}" = "0" ]
                    then
                        if ! [[ " ${RESULT_LINES[*]} " =~ " ${file} " ]]; 
                        then
                            RESULT_LINES+=("${file}")
                        fi
                    else
                        if [ "${NUMBER_PREFIX}" = "0" ];
                        then
                            if [ "${NUM_FILES}" = "1" ];
                            then
                                tmp="${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        else
                            if [ "${NUM_FILES}" = "1" ]
                            then
                                tmp="${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        fi
                    fi
                elif [[ "${_line}" == "${PATTERN}" ]] && [[ "$MATCH_ENTIRE_LINE" == "0" ]]; # Entire line
                then
                    if [ "${NAMES_OF_FILES}" = "0" ]
                    then
                        if ! [[ " ${RESULT_LINES[*]} " =~ " ${file} " ]]; 
                        then
                            RESULT_LINES+=("${file}")
                        fi
                    else
                        if [ "${NUMBER_PREFIX}" = "0" ];
                        then
                            if [ "${NUM_FILES}" = "1" ];
                            then
                                tmp="${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${LINE_NUMBER}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        else
                            if [ "${NUM_FILES}" = "1" ]
                            then
                                tmp="${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            else
                                tmp="${file}:${line}"
                                if ! [[ " ${RESULT_LINES[*]} " =~ " ${tmp} " ]]; 
                                then
                                    RESULT_LINES+=("${tmp}")
                                fi
                            fi
                        fi
                    fi
                fi
            fi

        done < "${file}"
    done

    for i in "${RESULT_LINES[@]}"
    do
        echo "${i}"
    done
}
main "$@"


