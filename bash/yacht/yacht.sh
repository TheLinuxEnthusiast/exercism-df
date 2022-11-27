#!/usr/bin/env bash
#set -x

function count_value() {
    n="$1"
    IFS=" " read -r -a array <<< "$2"
    count=0

    for i in "${array[@]}"
    do
        ((i == n)) && ((count++))
    done
    echo "${count}"
}

function main() {
    category="$1"
    shift
    local -a numbers=("$@")

    if [ "$category" = "ones" ];
    then
        result=$(count_value "1" "${numbers[*]}")
        echo $((result*1))
    elif [ "$category" = "twos" ]
    then
        result=$(count_value "2" "${numbers[*]}")
        echo $((result*2))
    elif [ "$category" = "threes" ]
    then
        result=$(count_value "3" "${numbers[*]}")
        echo $((result*3))
    elif [ "$category" = "fours" ]
    then
        result=$(count_value "4" "${numbers[*]}")
        echo $((result*4))
    elif [ "$category" = "fives" ]
    then
        result=$(count_value "5" "${numbers[*]}")
        echo $((result*5))
    elif [ "$category" = "sixes" ]
    then
        result=$(count_value "6" "${numbers[*]}")
        echo $((result*6))
    elif [ "$category" = "full house" ]
    then
        IFS=" " read -r -a uniq_array <<< "$(echo "${numbers[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"

        if ((${#uniq_array[@]}==2));
        then
            first_number="${uniq_array[0]}"
            second_number="${uniq_array[1]}"

            result_first=$(count_value "$first_number" "${numbers[*]}")
            result_second=$(count_value "$second_number" "${numbers[*]}")

            if ( ((result_first == 3)) && ((result_second == 2)) ) || ( ((result_first == 2)) && ((result_second == 3)) )
            then
                echo "${numbers[*]}" | tr ' ' '+' | bc
            else
                echo "0" && exit 0 
            fi
        else
            echo "0"
            exit 0
        fi
    elif [ "$category" = "four of a kind" ]
    then
        IFS=" " read -r -a uniq_array <<< "$(echo "${numbers[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"

        if ((${#uniq_array[@]}==2));
        then
            first_number="${uniq_array[0]}"
            second_number="${uniq_array[1]}"

            result_first=$(count_value "$first_number" "${numbers[*]}")
            result_second=$(count_value "$second_number" "${numbers[*]}")
 
            ((result_first == 4)) && echo $((first_number*4)) && exit 0
            ((result_second == 4)) && echo $((second_number*4)) && exit 0
            ( ((result_first != 4)) || ((result_second != 4)) ) && echo "0" && exit 0
        elif ((${#uniq_array[@]}==1))
        then
            echo "$((uniq_array[0]*4))"
        else
            echo "0"
            exit 0
        fi
    elif [ "$category" = "little straight" ]
    then
        IFS=" " read -r -a uniq_array <<< "$(echo "${numbers[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
        if ((${#uniq_array[@]}==5));
        then
            check_for_one=$(count_value "1" "${numbers[*]}")
            check_for_six=$(count_value "6" "${numbers[*]}")
            if [ "$check_for_one" = "1" ] && [ "$check_for_six" = "0" ];
            then
                echo "30"
            else
                echo "0"
                exit 0
            fi
        else
            echo "0"
            exit 0
        fi
    elif [ "$category" = "big straight" ]
    then
        IFS=" " read -r -a uniq_array <<< "$(echo "${numbers[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
        if ((${#uniq_array[@]}==5));
        then
            check_for_one=$(count_value "1" "${numbers[*]}")
            check_for_six=$(count_value "6" "${numbers[*]}")
            if [ "$check_for_one" = "0" ] && [ "$check_for_six" = "1" ];
            then
                echo "30"
            else
                echo "0"
                exit 0
            fi
        else
            echo "0"
            exit 0
        fi
    elif [ "$category" = "choice" ]
    then
        echo "${numbers[*]}" | tr ' ' '+' | bc
    elif [ "$category" = "yacht" ]
    then
        IFS=" " read -r -a uniq_array <<< "$(echo "${numbers[@]}" | tr ' ' '\n' | sort -u | tr '\n' ' ')"
        if ((${#uniq_array[@]}==1));
        then
            echo "50"
        else
            echo "0"
            exit 0
        fi
    else
        exit 0
    fi
}
main "$@"