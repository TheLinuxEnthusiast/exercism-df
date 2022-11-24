#!/usr/bin/gawk -f

function find_vowels(input_string){

    for(i=1; i<=length(input_string); i++){
        sub_str=substr(input_string, i, 1)
        if(sub_str == "a" || sub_str == "e" || sub_str == "i" || sub_str == "o" || sub_str == "u"){
            result[i]=1
        }
        else{
            result[i]=0
        }
    }
}

function first_vowel_position(result_array){
    for(v in result_array){
        if(result_array[v] == 1){
            return v
        }
    }
}

function print_array(array){
    for(k in array){
        print array[k]
    }
}

{
    split($0, words)

    # For each input word
    for(w in words){
        current_word=words[w]
        find_vowels(current_word) # Returns array with index location of vowels
        
        if(result[1] != 0 || substr(current_word, 1, 2) == "xr" || substr(current_word, 1, 2) == "yt"){ # If first letter is a vowel xr or yt
            final_result[w]=current_word "ay"
        }
        else if(result[1] == 0){ # If first letter is a consonant
            n=first_vowel_position(result)
            y_pos=index(current_word, "y")
            qu_pos=match(current_word, "qu")

            if(qu_pos > 0){
                if(qu_pos>1){ # not words beginning with qu
                    first_const_string=substr(current_word, 1, 3)
                    remaining_string=substr(current_word, 4, (length(current_word)-4+1))
                }
                else{
                    first_const_string=substr(current_word, qu_pos, 2)
                    remaining_string=substr(current_word, (qu_pos+2), (length(current_word)-qu_pos+1))
                }

            }
            else if(y_pos > 0){ # If the word contains a y
                #After a consonant cluster
                if(y_pos==1){
                    first_const_string=substr(current_word,1, 1)
                    remaining_string=substr(current_word, (y_pos+1), length(current_word))
                }
                else if(y_pos<n || n==0){
                    first_const_string=substr(current_word,1, (y_pos-1))
                    remaining_string=substr(current_word, y_pos, (length(current_word)-y_pos+1))
                }
                else{
                    first_const_string=substr(current_word,1, (n-1))
                    remaining_string=substr(current_word, n, (length(current_word)-n+1))
                }
            }
            else{
                first_const_string=substr(current_word,1, (n-1))
                remaining_string=substr(current_word, n, (length(current_word)-n+1))
            }
            final_result[w]=remaining_string first_const_string "ay"
            
        }
    }
}

END{
    for(res in final_result){
        if(res == length(final_result)){
            print final_result[res]
        }
        else{
            printf "%s ", final_result[res]
        }
    }

}
