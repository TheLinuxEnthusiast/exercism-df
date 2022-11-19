#!/usr/bin/gawk -f

# DD=Devastating Donkeys
# AA=Allegoric Alaskans
# BB=Blithering Badgers
# CC=Courageous Californians

BEGIN {
    WINS_DD=0
    LOSSES_DD=0
    DRAWS_DD=0
    MATCHES_PLAYED_DD=0
    POINTS_DD=0
    WINS_AA=0
    LOSSES_AA=0
    DRAWS_AA=0
    MATCHES_PLAYED_AA=0
    POINTS_AA=0
    WINS_BB=0
    LOSSES_BB=0
    DRAWS_BB=0
    MATCHES_PLAYED_BB=0
    POINTS_BB=0
    WINS_CC=0
    LOSSES_CC=0
    DRAWS_CC=0
    MATCHES_PLAYED_CC=0
    POINTS_CC=0

    TEAM_COUNT=1
}
{

    split($0, array, ";")
    TEAM_ARRAY[TEAM_COUNT]=array[1]
    TEAM_COUNT+=1
    TEAM_ARRAY[TEAM_COUNT]=array[2]
    TEAM_COUNT+=1

    if (array[3] == "win" && array[1] == "Allegoric Alaskans"){
        WINS_AA+=1
        MATCHES_PLAYED_AA+=1
        POINTS_AA+=3
        if(array[2]=="Blithering Badgers"){
            LOSSES_BB+=1
            MATCHES_PLAYED_BB+=1
        }
        else if(array[2]=="Devastating Donkeys"){
            LOSSES_DD+=1
            MATCHES_PLAYED_DD+=1
        }
         else if(array[2]=="Courageous Californians"){
            LOSSES_CC+=1
            MATCHES_PLAYED_CC+=1
        }
    }
    else if(array[3] == "win" && array[1] == "Blithering Badgers"){
        WINS_BB+=1
        MATCHES_PLAYED_BB+=1
        POINTS_BB+=3
        if(array[2]=="Allegoric Alaskans"){
            LOSSES_AA+=1
            MATCHES_PLAYED_AA+=1
        }
        else if(array[2]=="Devastating Donkeys"){
            LOSSES_DD+=1
            MATCHES_PLAYED_DD+=1
        }
         else if(array[2]=="Courageous Californians"){
            LOSSES_CC+=1
            MATCHES_PLAYED_CC+=1
        }
    }
    else if(array[3] == "win" && array[1] == "Devastating Donkeys"){
        WINS_DD+=1
        MATCHES_PLAYED_DD+=1
        POINTS_DD+=3
        if(array[2]=="Allegoric Alaskans"){
            LOSSES_AA+=1
            MATCHES_PLAYED_AA+=1
        }
        if(array[2]=="Blithering Badgers"){
            LOSSES_BB+=1
            MATCHES_PLAYED_BB+=1
        }
        else if(array[2]=="Courageous Californians"){
            LOSSES_CC+=1
            MATCHES_PLAYED_CC+=1
        }
    }
    else if(array[3] == "win" && array[1] == "Courageous Californians"){
        WINS_CC+=1
        MATCHES_PLAYED_CC+=1
        POINTS_CC+=3
        if(array[2]=="Allegoric Alaskans"){
            LOSSES_AA+=1
            MATCHES_PLAYED_AA+=1
        }
        if(array[2]=="Blithering Badgers"){
            LOSSES_BB+=1
            MATCHES_PLAYED_BB+=1
        }
        else if(array[2]=="Devastating Donkeys"){
            LOSSES_DD+=1
            MATCHES_PLAYED_DD+=1
        }
    }
    else {
        MATCHES_PLAYED_AA+=0
    }

    if(array[3] == "loss" && array[1] == "Allegoric Alaskans"){
        LOSSES_AA+=1
        MATCHES_PLAYED_AA+=1
        POINTS_AA+=0
        if(array[2]=="Blithering Badgers"){
            WINS_BB+=1
            MATCHES_PLAYED_BB+=1
            POINTS_BB+=3
        }
        else if(array[2]=="Devastating Donkeys"){
            WINS_DD+=1
            MATCHES_PLAYED_DD+=1
            POINTS_DD+=3
        }
         else if(array[2]=="Courageous Californians"){
            WINS_CC+=1
            MATCHES_PLAYED_CC+=1
            POINTS_CC+=3
        }
    }
    else if(array[3] == "loss" && array[1] == "Blithering Badgers"){
        LOSSES_BB+=1
        MATCHES_PLAYED_BB+=1
        POINTS_BB+=0
        if(array[2]=="Allegoric Alaskans"){
            WINS_AA+=1
            MATCHES_PLAYED_AA+=1
            POINTS_AA+=3
        }
        else if(array[2]=="Devastating Donkeys"){
            WINS_DD+=1
            MATCHES_PLAYED_DD+=1
            POINTS_DD+=3
        }
         else if(array[2]=="Courageous Californians"){
            WINS_CC+=1
            MATCHES_PLAYED_CC+=1
            POINTS_CC+=3
        }
    }
    else if(array[3] == "loss" && array[1] == "Devastating Donkeys"){
        LOSSES_DD+=1
        MATCHES_PLAYED_DD+=1
        POINTS_DD+=0
        if(array[2]=="Allegoric Alaskans"){
            WINS_AA+=1
            MATCHES_PLAYED_AA+=1
            POINTS_AA+=3
        }
        else if(array[2]=="Blithering Badgers"){
            WINS_BB+=1
            MATCHES_PLAYED_BB+=1
            POINTS_BB+=3
        }
         else if(array[2]=="Courageous Californians"){
            WINS_CC+=1
            MATCHES_PLAYED_CC+=1
            POINTS_CC+=3
        }
    }
    else if(array[3] == "loss" && array[1] == "Courageous Californians"){
        LOSSES_CC+=1
        MATCHES_PLAYED_CC+=1
        POINTS_CC+=0
        if(array[2]=="Allegoric Alaskans"){
            WINS_AA+=1
            MATCHES_PLAYED_AA+=1
            POINTS_AA+=3
        }
        else if(array[2]=="Blithering Badgers"){
            WINS_BB+=1
            MATCHES_PLAYED_BB+=1
            POINTS_BB+=3
        }
        else if(array[2]=="Devastating Donkeys"){
            WINS_DD+=1
            MATCHES_PLAYED_DD+=1
            POINTS_DD+=3
        }
    }
    else{
        MATCHES_PLAYED_AA+=0
    }

    if(array[3] == "draw" && array[1] == "Allegoric Alaskans"){
        DRAWS_AA+=1
        MATCHES_PLAYED_AA+=1
        POINTS_AA+=1
        if(array[2]=="Blithering Badgers"){
            DRAWS_BB+=1
            MATCHES_PLAYED_BB+=1
            POINTS_BB+=1
        }
        else if(array[2] == "Devastating Donkeys"){
            DRAWS_DD+=1
            MATCHES_PLAYED_DD+=1
            POINTS_DD+=1
        }
        else if(array[2] == "Courageous Californians"){
            DRAWS_CC+=1
            MATCHES_PLAYED_CC+=1
            POINTS_CC+=1
        }
    }
    else if(array[3] == "draw" && array[1] == "Blithering Badgers"){
        DRAWS_BB+=1
        MATCHES_PLAYED_BB+=1
        POINTS_BB+=1
        if(array[2]=="Allegoric Alaskans"){
            DRAWS_AA+=1
            MATCHES_PLAYED_AA+=1
            POINTS_AA+=1
        }
        else if(array[2] == "Devastating Donkeys"){
            DRAWS_DD+=1
            MATCHES_PLAYED_DD+=1
            POINTS_DD+=1
        }
        else if(array[2] == "Courageous Californians"){
            DRAWS_CC+=1
            MATCHES_PLAYED_CC+=1
            POINTS_CC+=1
        }
    }
    else if(array[3] == "draw" && array[1] == "Devastating Donkeys"){
        DRAWS_DD+=1
        MATCHES_PLAYED_DD+=1
        POINTS_DD+=1
        if(array[2]=="Allegoric Alaskans"){
            DRAWS_AA+=1
            MATCHES_PLAYED_AA+=1
            POINTS_AA+=1
        }
        else if(array[2]=="Blithering Badgers"){
            DRAWS_BB+=1
            MATCHES_PLAYED_BB+=1
            POINTS_BB+=1
        }
        else if(array[2] == "Courageous Californians"){
            DRAWS_CC+=1
            MATCHES_PLAYED_CC+=1
            POINTS_CC+=1
        }
    }
    else if(array[3] == "draw" && array[1] == "Courageous Californians"){
        DRAWS_CC+=1
        MATCHES_PLAYED_CC+=1
        POINTS_CC+=1
        if(array[2]=="Allegoric Alaskans"){
            DRAWS_AA+=1
            MATCHES_PLAYED_AA+=1
            POINTS_AA+=1
        }
        else if(array[2]=="Blithering Badgers"){
            DRAWS_BB+=1
            MATCHES_PLAYED_BB+=1
            POINTS_BB+=1
        }
        else if(array[2] == "Devastating Donkeys"){
            DRAWS_DD+=1
            MATCHES_PLAYED_DD+=1
            POINTS_DD+=1
        }
    }
    else{
        MATCHES_PLAYED_AA+=0
    }

}
END{

    for (i=1; i in TEAM_ARRAY; i++) {
        if ( !seen[TEAM_ARRAY[i]]++ ) {
            unique[++numUniq] = TEAM_ARRAY[i]
        }
    }

    #printf "Team                           | MP |  W |  D |  L |  P\n"
    for(k in unique){
        if(unique[k] == "Devastating Donkeys"){
            if(POINTS_DD>=10){
                printf "%s            |  %s |  %s |  %s |  %s | %s\n", unique[k], MATCHES_PLAYED_DD, WINS_DD, DRAWS_DD, LOSSES_DD, POINTS_DD
            }
            else{
                printf "%s            |  %s |  %s |  %s |  %s |  %s\n", unique[k], MATCHES_PLAYED_DD, WINS_DD, DRAWS_DD, LOSSES_DD, POINTS_DD
            }
            
        }
        else if(unique[k] == "Allegoric Alaskans"){
            if(POINTS_AA>=10){
                printf "%s             |  %s |  %s |  %s |  %s | %s\n", unique[k], MATCHES_PLAYED_AA, WINS_AA, DRAWS_AA, LOSSES_AA, POINTS_AA
            }
            else{
                printf "%s             |  %s |  %s |  %s |  %s |  %s\n", unique[k], MATCHES_PLAYED_AA, WINS_AA, DRAWS_AA, LOSSES_AA, POINTS_AA
            }
            
        }
        else if(unique[k] == "Blithering Badgers"){
            if(POINTS_BB>=10){
                printf "%s             |  %s |  %s |  %s |  %s | %s\n", unique[k], MATCHES_PLAYED_BB, WINS_BB, DRAWS_BB, LOSSES_BB, POINTS_BB
            }
            else{
                printf "%s             |  %s |  %s |  %s |  %s |  %s\n", unique[k], MATCHES_PLAYED_BB, WINS_BB, DRAWS_BB, LOSSES_BB, POINTS_BB
            }
            
        }
        else if(unique[k] == "Courageous Californians"){
            if(POINTS_CC>=10){
                printf "%s        |  %s |  %s |  %s |  %s | %s\n", unique[k], MATCHES_PLAYED_CC, WINS_CC, DRAWS_CC, LOSSES_CC, POINTS_CC
            }
            else{
                printf "%s        |  %s |  %s |  %s |  %s |  %s\n", unique[k], MATCHES_PLAYED_CC, WINS_CC, DRAWS_CC, LOSSES_CC, POINTS_CC
            }
        }
        
    }
}