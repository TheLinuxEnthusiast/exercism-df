# These variables are initialized on the command line (using '-v'):
# - ibase
# - obase


function convert_to_base_10(array, input_base){
    
    total=0
    len=length(array)

    for(i=1; i<=len; ++i){
        total += ( array[i] * (input_base ^ (len-i)))
    }
    return total
}

function convert_to_base_n(base10_number, output_base) {
    
    divisor=base10_number
    modulus=0
    count=1

    while(divisor > 0){
        modulus = ( divisor % output_base )
        divisor = int( divisor / output_base )
        output[count]=modulus
        count += 1
    }

    tmp = ""
    for(i=length(output); i>=1; --i){
        if(i ==1){
            tmp = tmp output[i]
        }
        else{
            tmp = tmp output[i] " "
        }
        
    }
    return tmp
}


function value_in_array(my_array, val){
    if(length(my_array) == 0){
        print "0"
    }
    else{
        for(i=1; i<=length(my_array); ++i){
            print i
            if(my_array[i] == val){
                print "1"
            }
        }
    }
}

function distinct_values(array){
    #delete values;
    for(i=1; i<=length(array); ++i){

        if(value_in_array(values, array[i]) == "1"){
            val_len=length(values)
            values[val_len+1] = array[i]
        }
    }
    return length(values)
}


{

    if(ibase <= 1 || obase <= 1){
        print "Input or output base cannot be less than or equal to 1"
        exit 1
    }

    split($0, a, " ")
    
    for(i=1;i<=NF;i++){
        str=(++arr[$i]==1?str $i:str)
    }

    if(length(a) > 0){
        if(a[1] == 0 && length(a) == 1) {
            print ""
        }
        else if(length(str) == 1 && a[1] == 0){
            print ""
        }
        else if(length(str) > ibase){
            print "Invalid digit"
            exit 1
        }
        else{
            base10 = convert_to_base_10(a, ibase)
            new_base = convert_to_base_n(base10, obase)
            print new_base
        }
    }
    else{
        print ""
    }
}
