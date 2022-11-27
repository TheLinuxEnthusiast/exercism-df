#!/usr/bin/env bash
#set -x


function main() {

    local -a rolls=("$@")
    local -a frame_totals=()
    local -i frame_start=0
    local -i last_used_throw=0
    
    for throw in "${rolls[@]}"
    do
        (( throw < 0 )) && echo "Negative roll is invalid" && exit 1
        (( throw > 10 )) && echo "Pin count exceeds pins on the lane" && exit 1
    done

    for frame in $(seq 1 10)
    do
        # If Strike
        if (( rolls[frame_start] == 10 )); 
        then
            (( frame_start+2 >= ${#rolls[@]} )) && echo "Score cannot be taken until the end of the game" && exit 1
            (( rolls[frame_start+1] != 10 )) && ((rolls[frame_start + 1] + rolls[frame_start + 2] > 10)) && echo "Pin count exceeds pins on the lane" && exit 1

            frame_totals[$frame]=$((10 + rolls[frame_start + 1] + rolls[frame_start + 2]))
            last_used_throw=$((frame_start + 2))
            frame_start+=1
			continue
        fi

        if ((frame_start + 1 >= ${#rolls[@]})); then
			echo "Score cannot be taken until the end of the game"
			exit 1
		fi
		if ((rolls[frame_start] + rolls[frame_start + 1] > 10)); then
			echo "Pin count exceeds pins on the lane"
			exit 1
		fi

        # If Spare
		if ((rolls[frame_start] + rolls[frame_start + 1] == 10)); then
			# Validate that two rolls of frame plus a bonus throw
			if ((frame_start + 2 >= ${#rolls[@]})); then
				echo "Score cannot be taken until the end of the game"
				return 1
			fi
			frame_totals[$frame]=$((10 + rolls[frame_start + 2]))
			last_used_throw=$((frame_start + 2))
			frame_start+=2
			continue
		fi

        # If Open Frame
		frame_totals[$frame]=$(("${rolls[$frame_start]}" + "${rolls[frame_start + 1]}"))
		last_used_throw=$((frame_start + 1))
		frame_start+=2
    done

    # Check for illegal unscored throws
	(( ${#rolls[@]} > last_used_throw + 1)) && echo "Cannot roll after game is over" && exit 1

    local -i score=0
	for total in "${frame_totals[@]}"; do
		((score += total))
	done

	echo "$score"
    exit 0
}
main "$@"