#!/bin/bash

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


val=$(cat << INPUT
 _  _
|_ | |
|_||_|
   
INPUT
)

val2=$(cat << INPUT
    _  _ 
  | _| _|
  ||_  _|
         
    _  _ 
|_||_ |_ 
  | _||_|
         
 _  _  _ 
  ||_||_|
  ||_| _|
         
INPUT
)

val3=$(cat << INPUT
    _  _     _  _  _  _  _  _ 
  | _| _||_||_ |_   ||_||_|| |
  ||_  _|  | _||_|  ||_| _||_|
                              
INPUT
)

val4=$(cat << INPUT
 _ 
|_|
 _|
   
INPUT
)

val5=" _ \n| |\n|_|\n   "

val6=$(cat << INPUT
 _ 
| |
|_|
   
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

function split_num_array() {

  IFS=';' read -r -a line_array <<< "$(echo "$1" | tr '\n' ';')"
  number_array_tmp=()
  COUNT=0

  for l in "${line_array[@]}";
  do
      len_tmp="${#l}"
      #echo "Line Length is: ${len_tmp}"
      for i in $(seq 0 3 $((len_tmp-3)));
      do
          #echo "Segment is ${COUNT}: ${l:$i:3}"
          number_array_tmp["${COUNT}"]+="${l:$i:3}\n"
          COUNT=$((COUNT+1))
      done
      COUNT=0
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
    for j in "${number_array_tmp[@]}";
    do
      #echo -ne "${j}"
      #echo "${j}"
      RESULT_TMP=$(convert_to_number "$(echo -ne "${j}")")
      FINAL_RESULT+="${RESULT_TMP}"
    done
  done
  echo "${FINAL_RESULT}"
}

number_array_tmp=()
split_row_array "$val2"
