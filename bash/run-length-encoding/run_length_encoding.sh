#!/usr/bin/env bash

#!/usr/bin/env bash

main() {

  local mode="$1" phrase="$2" result=""

  ((${#phrase} == 0)) && exit 0

  case "$mode" in

    decode|encode) "$mode";;

    *) exit 0;;

  esac

  echo "$result"

}

decode() {

  local -i count=0

  local char=""

  while [[ "$phrase" =~ ^([[:digit:]]*)([^[:digit:]]) ]]; do
    count="${BASH_REMATCH[1]}"; char="${BASH_REMATCH[2]}"
    phrase=${phrase:${#BASH_REMATCH[0]}}
    result+=$(decode_sequence)

  done

}

decode_sequence() {

  local result=""

  ((count==0)) && count=1

  printf -v result "%*s" "$count" ""

  echo -n "${result// /$char}"

}


encode() {

  local char="${phrase:0:1}"

  local -i count=0

  for (( i = 0; i < ${#phrase}; i++ )); do

    if [[ "${phrase:i:1}" == "$char" ]]; then

      ((count++))

    else

      result+="$(encode_sequence)"

      char="${phrase:i:1}"; count=1

    fi

  done
  result+="$(encode_sequence)"

}

encode_sequence() {

  ((count > 1)) && echo -n "${count}"

  echo "${char}"

}

main "$@"

# vim:ts=2:sw=2:expandtab

