

function is_number(num) {
    var=match(num, "[0-9]+")
    if(var != 0){
        return 0
    }
    else {
        return 1
    }
}


{

    gsub(/What is/, "", $0)
    gsub(/?/, "", $0)
    gsub(/plus/, "+", $0)
    gsub(/divided by/, "/", $0)
    gsub(/multiplied by/, "*", $0)
    gsub(/minus/, "-", $0)

    # If the length of input is zero then fail
    if(length($0) == 0) {
        print "syntax error"
        exit 1
    }

    split($0, a, " ")

    tmp=0
    is_add=0
    is_subtract=0
    is_mult=0       
    is_divide=0

    for(i=1; i<=length(a); i++){

        if((a[i] == "+" || a[i] == "-" || a[i] == "*" || a[i] == "/") && i=1) {
            print "syntax error"
            exit 1
        }

        if(is_number(a[i] == 1) && i=1){
            print "syntax error"
            exit 1
        }

        if(is_number(a[i]) == 0 && i=1){
            tmp=a[i]
            continue
        }
        else if(a[i]=="+"){
            is_add=is_add+1
            continue
        }
        else if(a[i]=="-"){
            is_substract=is_subtract+1
            continue
        }
        else if(a[i]=="/"){
            is_divide=is_divide+1
            continue
        }
        else if(a[i]=="*"){
            is_mult=is_mult+1
            continue
        }
        else {
            if(is_number(a[i])==0){
                if(is_add==1){
                    tmp= tmp + a[i]
                    is_add=is_add-1
                }
                else if(is_substract==1){
                    tmp= tmp - a[i]
                    is_substract=is_substract-1
                }
                else if(is_mult==1){
                    tmp = tmp * a[i]
                    is_mult=is_mult-1
                }
                else if(is_divide==1){
                    tmp = tmp / a[i]
                    is_divide=is_divide-1
                }
                else if(is_divide == 0 && is_mult ==0 && is_add == 0 && is_substract == 0){
                    
                }
            }
        }
    }

}

END{
    print tmp
}