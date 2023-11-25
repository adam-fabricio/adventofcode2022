#!/usr/bin/env bash
#
#  day_24.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1700627617 -> 22/11/23 04:33:37
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_24_test"
    echo Use test data input
else
    data_input="data/day_24"
    echo "use source data input"
fi
#---------------------------Function evaluate_position------------------------#
evaluate_position(){
    ##  evaluate if in next step will have blizzards and create a array with value of blizzards.
    val_blizzards=()
    for x_b in ${blizzards_y[$y_p]}; do
        next_blizzard=$(( ( x_b - 1 + blizzards[$x_b $y_p] * ( t + 1 )  ) % ( length_x - 2 ) + 1 ))
        (( next_blizzard <= 0 )) && next_blizzard=$((length_x + next_blizzard - 2 ))
        [[ next_blizzard -eq $x_p ]] && return 1
        val_blizzards+=( "$next_blizzard" )
    done
    for y_b in ${blizzards_x[$x_p]}; do
        next_blizzard=$(( ( y_b - 1 + blizzards[$x_p $y_b] * ( t + 1 )  ) % ( length_y - 2 ) +  1 ))
        (( next_blizzard <= 0 )) && next_blizzard=$((length_y + next_blizzard - 2 ))
        [[ next_blizzard -eq $y_p ]] && return 1
        val_blizzards+=( "$next_blizzard" )
    done
    return 0
}

#----------------------------------Read data input----------------------------#
#  declare associative arrays


declare -A blizzards limit visited

mapfile -t line < "$data_input"

#  define limits of maps
length_x=${#line[0]}
length_y=${#line[@]}

echo "$length_x $length_y"

for y in ${!line[@]}; do
    for (( x=0; x<$length_x; x++ )); do
        case "${line[y]:$x:1}" in
            "#" ) limit["$x $y"]=1 ;;
            ">" )     
                     blizzards["$x $y"]="1"
                     blizzards_y[$y]+="$x "
                     ;;
            "<" ) 
                      blizzards["$x $y"]="-1"
                      blizzards_y[$y]+="$x "
                      ;;
            "v" )
                      blizzards["$x $y"]="1"
                      blizzards_x[$x]+="$y "
                      ;;
            "^" )
                      blizzards["$x $y"]="-1"
                      blizzards_x[$x]+="$y "
                      ;;
            "." ) : ;;
            * ) : ;;
        esac
    done
done

#  initial position
position=( 1 0 )

# end possition
end_x=${line[-1]%.*}
end_pos=(${#end_x} $(( ${#line[@]} -1 )) )

#  BFS for move
# initialize queue
queue=( "${position[*]} 0" )
#queue=( "${end_pos[*]} 301" )


part=2
(( part == 1 )) && laps=1 || laps=3


for (( lap=0; lap<$laps; lap++ ));  do

	while :
	do
		#  get position
		read -r x y t <<< "${queue[0]}"
		#echo "atual x:$x y:$y t:$t queue:${#queue[@]}"

		#  remove item for queue
		queue=( "${queue[@]:1}" )

		# add same position to check position
			possibilities=("$x $((y+1))" "$((x+1)) $y" "$x $y" "$((x-1)) $y" "$x $((y-1))" )

		#  for each possibility evaluabe position
		for possibility in "${possibilities[@]}"; do
			#  check if possibility is in blizzards
			read -r x_p y_p <<< "$possibility"
			#echo "$x_p $y_p"
			#[[ "$x_p $y_p" == "${end_pos[@]}" ]] && break 2
			[[ "$x_p $y_p" == "${end_pos[@]}" ]] && break 2
			## check wall, out of range, is alredy in queue or combination of blizzards repeaded"
			[[ -n ${limit["$x_p $y_p"]}  \
			|| $x_p -lt 0 || y_p -lt 0 \
			|| $y_p -gt $(( $length_y - 1 )) \
			|| -n ${visited["$x_p $y_p $((t+1))"]} \
			|| -n ${visited["$x_p $y_p ${val_blizzards[@]}"]} ]] && continue

			#  evalueate blizzards
			evaluate_position

			if [[ $? -eq 0 ]]; then
			  queue+=( "$x_p $y_p $((t+1))" ) 
			  visited["$x_p $y_p $((t+1))"]=1
			  visited["$x_p $y_p ${val_blizzards[@]}"]=1
			fi
		done
	done
	echo "**********"
	echo "lap($((lap+1))): $(( t + 1 ))"
	echo "**********"
	temp=( "${position[@]}" )
	position=( "${end_pos[@]}" )
	end_pos=( "${temp[@]}" )
	queue=( "${position[*]} $((t+1))" )
	visited=()
done


#--------------------------------------|--------------------------------------#
