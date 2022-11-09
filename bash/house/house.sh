#!/usr/bin/env bash

FULL_POEM=$(cat << EOF
This is the house that Jack built.

This is the malt
that lay in the house that Jack built.

This is the rat
that ate the malt
that lay in the house that Jack built.

This is the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the farmer sowing his corn
that kept the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.

This is the horse and the hound and the horn
that belonged to the farmer sowing his corn
that kept the rooster that crowed in the morn
that woke the priest all shaven and shorn
that married the man all tattered and torn
that kissed the maiden all forlorn
that milked the cow with the crumpled horn
that tossed the dog
that worried the cat
that killed the rat
that ate the malt
that lay in the house that Jack built.
EOF
)

function print_verse() {
    awk -v RS="" -v VERSE="${1}" -v ORS='\n\n' 'NR==VERSE' <<< $(echo "${FULL_POEM}") | sed '$ d'
}

function main() {
    START_VERSE="$1"
    END_VERSE="$2"

    [ "${START_VERSE}" -le "0" ] && echo "invalid" && exit 1
    [ "${END_VERSE}" -le "0" ] && echo "invalid" && exit 1
    [ "${START_VERSE}" -gt "12" ] && echo "invalid" && exit 1
    [ "${END_VERSE}" -gt "12" ] && echo "invalid" && exit 1


    if [ "${START_VERSE}" -gt "${END_VERSE}" ]; 
    then
        exit
    elif [ "${START_VERSE}" = "${END_VERSE}" ];
    then
        print_verse "${START_VERSE}"
    elif [  "${START_VERSE}" -lt "${END_VERSE}" ]
    then
        result=""
        newline=$'\n'
        for i in $(seq "${START_VERSE}" "${END_VERSE}")
        do
            tmp=$(print_verse "$i")
            if [ "$i" = "${END_VERSE}" ];
            then
                result="${result}${tmp}${newline}"
            else
                result="${result}${tmp}${newline}${newline}"
            fi
        done
        echo -E "${result}" | sed '$ d'
    else  
        echo "invalid"
    fi
}
main "$@"
