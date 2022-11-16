#!/usr/bin/gawk -f
# Author: Darren Foley
# Date: 2022-11-16
# Description: Simple ETL program
# Example input 1:  "A", "E", "I", "O", "U"

BEGIN{
    COUNT=1
}
{
    gsub(/\s+/, "") # Remove whitespace
    gsub(/"/, "") # Split by :
    split($0, array , /:\s*?/)
    LETTER_VALUE=array[1]
    LETTERS=array[2]
    split(LETTERS, letter_array, /,/)

    for(i=1; i<=length(letter_array); i++){
        FINAL[COUNT]=sprintf(tolower(letter_array[i]) "," LETTER_VALUE)
        COUNT+=1
    }

}
END{
    asort(FINAL)
    for (k in FINAL){
        print FINAL[k]
    }
}
