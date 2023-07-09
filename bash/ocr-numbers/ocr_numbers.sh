#!/usr/bin/env bash
#set -x

INPUT=""
if [ ! -t 0 ]; then
    INPUT=$(cat /dev/stdin)
else
    echo "" && exit 0
fi

if [ "${INPUT}" = "" ];
then
    echo "" && exit 0
fi

declare -a number_array
number_array[0]=$(cat << INPUT
 _ 
| |
|_|
   
INPUT
)
number_array[1]=$(cat << INPUT
   
  |
  |
   
INPUT
)
number_array[2]=$(cat << INPUT
 _ 
 _|
|_ 
   
INPUT
)
number_array[3]=$(cat << INPUT
 _ 
 _|
 _|
   
INPUT
)
number_array[4]=$(cat << INPUT
   
|_|
  |
   
INPUT
)
number_array[5]=$(cat << INPUT
 _ 
|_ 
 _|
   
INPUT
)
number_array[6]=$(cat << INPUT
 _ 
|_ 
|_|
   
INPUT
)
number_array[7]=$(cat << INPUT
 _ 
  |
  |
   
INPUT
)
number_array[8]=$(cat << INPUT
 _ 
|_|
|_|
   
INPUT
)
number_array[9]=$(cat << INPUT
 _ 
|_|
 _|
   
INPUT
)


function convert_to_number() {
    
    RESULT="?"
    INPUT_STRING="$1"
    for i in "${!number_array[@]}";
    do
        #echo "value"
        #echo "${number_array[$i]}"
        #echo "input"
        #echo -E "${INPUT_STRING}"
        if [[ "${number_array[$i]}" = $(echo -e "${INPUT_STRING}") ]];
        then
            #echo "here"
            RESULT="${i}"
        fi
    done
    echo "${RESULT}"
}


function check_columns() {
    INPUT_STRING="$1"
    if [ $(("${#INPUT_STRING}"%3)) = "0" ];
    then
        echo "0"
    else
        echo "1"
    fi
}


function split_num_array() {

  IFS=';' read -r -a line_array <<< "$(echo "$1" | tr '\n' ';')"
  #ARRAY_LEN="${#line_array[@]}"
  unset 'line_array[${#line_array[@]}-1]'
  NUMBER_ARRAY_TMP=()
  COUNT=0

  for l in "${line_array[@]}";
  do
      len_tmp="${#l}"
      #echo "Line Length is: ${len_tmp}"
      for i in $(seq 0 3 $((len_tmp-3)));
      do    
            NUMBER_ARRAY_TMP["${COUNT}"]+="${l:$i:3}\n"
            COUNT=$((COUNT+1))
      done
      COUNT=0
  done

  for i in "${!NUMBER_ARRAY_TMP[@]}"
  do
        NUMBER_ARRAY_TMP["${i}"]+="   "
  done

}


function split_row_array() {
  INPUT_VALUE="$1"
  IFS=';' read -r -a row_array <<< "$(echo "${INPUT_VALUE}" | tr '\n' ';')"
  NUM_ROWS="${#row_array[@]}"
  FINAL_RESULT=""

  for i in $(seq 0 4 $((NUM_ROWS-4)));
  do
    n=$((i+1))
    m=$((n+3))
    result=$(cut -d';' -f$n-$m <<< $(echo "${INPUT_VALUE}" | tr '\n' ';'))
    #echo "${result}" | tr ';' '\n'
    split_num_array "$(echo "${result}" | tr ';' '\n')"
    for j in "${NUMBER_ARRAY_TMP[@]}";
    do
      #echo -ne "${j}"
      #echo "${j}"
      RESULT_TMP=$(convert_to_number "$(echo -ne "${j}")")
      FINAL_RESULT+="${RESULT_TMP}"
    done
  done
  echo "${FINAL_RESULT}"
}


main() {
    # Split lines by delimiter
    FINAL_RESULT=""
    NUMBER_ARRAY_TMP=()
    lines_split=$(echo "$1" | tr '\n' ';')
    IFS=';' read -r -a line_split_array <<< "$(echo "$lines_split" | tr '\n' ';')"
    num_lines=$(echo "$lines_split" | awk -F';' '{ print NF-1 }')

    #Check number of lines is divisible by 4
    if [ $(("${num_lines}"%4)) = "0" ];
    then

        CHECK_COL=$(check_columns "${line_split_array[0]}")
        if [ "${CHECK_COL}" = "1" ];
        then
            echo "Number of input columns is not a multiple of three" && exit 1
        fi

        # For each number convert to decimal
        # If single number single row
        #echo "${#line_split_array[0]}"
        if [ "${#line_split_array[0]}" = "3" ];
        then
            OUTPUT_TMP=$(convert_to_number "$1")
            FINAL_RESULT+="${OUTPUT_TMP}"
        # If multiple numbers single row
        elif [ "${#line_split_array[0]}" -gt "3" ];
        then

            #One row only
            if [ "${num_lines}" = "4" ];
            then
                #echo "multiple numbers"
                split_num_array "$1"
                for n in "${NUMBER_ARRAY_TMP[@]}"; 
                do
                    #echo -e "${n}"
                    #echo "-------------"
                    OUTPUT_TMP=$(convert_to_number "$n")
                    FINAL_RESULT+="${OUTPUT_TMP}"
                done
            else
                # Multiple rows
                OUTPUT_TMP=$(split_row_array "$1")
                echo "${OUTPUT_TMP:0:3},${OUTPUT_TMP:3:3},${OUTPUT_TMP:6:3}"
            fi
        else
            echo ""
        fi
    else
        echo "Number of input lines is not a multiple of four" && exit 1
    fi
    echo "${FINAL_RESULT}"

}
main "$INPUT"