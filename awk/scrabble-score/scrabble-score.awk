#!/usr/bin/gawk -f

BEGIN{
    TOTAL=0
}
{
    split(toupper($0), a, "")

    for(i=0; i<length(a); i++){
        letter=a[i]

        if( letter == "A" || \
            letter == "E" || \
            letter =="I" || \
            letter =="O" || \
            letter =="U" || \
            letter =="L" || \
            letter =="N" || \
            letter =="R" || \
            letter =="S" || \
            letter =="T"){
                TOTAL+=1
             }
        else if(letter == "D" || letter == "G"){
                TOTAL+=2
        }
        else if(letter == "B" || letter == "C" || \
                letter == "M" || letter == "P"){
                TOTAL+=3
        }
        else if(letter == "F" || letter == "H" || \
                letter == "V" || letter == "W" || letter == "Y"){
                TOTAL+=4
        }
        else if(letter == "K"){
                TOTAL+=5
        }
        else if(letter == "J" || letter == "X"){
                TOTAL+=8
        }
        else if(letter == "Q" || letter == "Z"){
                TOTAL+=10
        }
        else{
            TOTAL+=0
        }
       
    }
}

END {
    print toupper($0) "," TOTAL
}
