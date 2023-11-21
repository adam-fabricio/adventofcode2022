#!/usr/bin/env bash
#
#  day_23.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1700256028 -> 17/11/23 18:20:28
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_23_test"
    echo Use test data input
else
    data_input="data/day_23"
    echo "use source data input"
fi
#----------------------------function solve_part_1----------------------------#
solve_part_1(){
	local -n positions="elves"
	x_min=$(printf "%s\n" "${positions[@]}" | sort -k1n | head -1 | cut -d" " -f1)
	x_max=$(printf "%s\n" "${positions[@]}" | sort -k1n | tail -1 | cut -d" " -f1)
	y_min=$(printf "%s\n" "${positions[@]}" | sort -k2n | head -1 | cut -d" " -f2)
	y_max=$(printf "%s\n" "${positions[@]}" | sort -k2n | tail -1 | cut -d" " -f2)

	total_square=$(( (x_max - x_min + 1 ) * (y_max - y_min + 1) ))
	total_elves=${#elves[@]}

	echo "Part 1 -> $(( total_square - total_elves ))"
}
#----------------------------function print_map-------------------------------#
print_map(){
	local -n positions=$1
	x_min=$(printf "%s\n" "${positions[@]}" | sort -k1n | head -1 | cut -d" " -f1)
	x_max=$(printf "%s\n" "${positions[@]}" | sort -k1n | tail -1 | cut -d" " -f1)
	y_min=$(printf "%s\n" "${positions[@]}" | sort -k2n | head -1 | cut -d" " -f2)
	y_max=$(printf "%s\n" "${positions[@]}" | sort -k2n | tail -1 | cut -d" " -f2)
	for (( yp=$y_min; yp<=$y_max; yp++ )); do
		for (( xp=$x_min; xp<=$x_max; xp++ )); do
			char="."
			for pos in "${positions[@]}"; do
				[[ "$xp $yp" == "$pos" ]] && char="#" && break
			done
			echo -n "$char"
		done
		echo
	done
	echo
	echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
	echo

}
#----------------------------------Read data input----------------------------#

declare -a elves moves intention_move
declare -A occupied future_occupation
mapfile -t line < "$data_input"

#  Parsing. take  position of the elves.
for (( y=0; y<${#line[@]}; y++ )); do
	for (( x=0; x<${#line[y]}; x++ )); do
		[[ ${line[y]:$x:1} == "#" ]] && elves+=("$x $y") && occupied["$x $y"]=1
	done
done

echo "elf ${#elves[@]} occupied ${#occupied[@]}"

#  Creat a list of moves

north=( "-1 -1" "1 -1" "0 -1" )	#  north
south=( "-1 1"  "1 1"  "0 1"  )	#  south
west=(  "-1 -1" "-1 1" "-1 0" )	#  west
east=(  "1 -1"  "1 1"  "1 0"  )	#  east

moves=( "north" "south" "west" "east" )

part=2
count=0

(( part == 1 )) && p=10 || p=3000

#  rounds 10, i is rounds
for (( i=0; i<$p; i++ )); do
	# print_map "elves"
	#  intention to move for each elf=j
	(( $count == ${#elves[@]} )) && break
	echo "$i -> count=$count elves=2396"
	count=0
	for (( j=0; j<${#elves[@]}; j++ )); do
		elf=( ${elves[j]} )
		
		#  verify if have neighbor elf.
		

		[[ -z ${occupied[$(( elf[0] - 1 )) $(( elf[1] - 1 ))]}  && \
		   -z ${occupied[$(( elf[0]  )) $(( elf[1] - 1 ))]}  && \
		   -z ${occupied[$(( elf[0] + 1 )) $(( elf[1] - 1 ))]}  && \
		   -z ${occupied[$(( elf[0] - 1 )) $(( elf[1] ))]}  && \
		   -z ${occupied[$(( elf[0] + 1 )) $(( elf[1] ))]}  && \
		   -z ${occupied[$(( elf[0] - 1 )) $(( elf[1] + 1 ))]}  && \
		   -z ${occupied[$(( elf[0]  )) $(( elf[1] + 1 ))]}  && \
		   -z ${occupied[$(( elf[0] + 1 )) $(( elf[1] + 1 ))]} ]] && \
		   (( count+=1 )) && \
		   continue

		
		#  verify if can jump, moves=k

		for (( k=0; k<4; k++ )); do
			declare -n move=${moves[$(( ( i + k ) % 4 ))]}
			#  check if have elf can the move
			for (( m=0; m<3; m++ )); do
				read -a pos <<< "${move[$m]}"
				x=$(( elf[0] + pos[0] ))
				y=$(( elf[1] + pos[1] ))
				
				[[ -z ${occupied[$x $y]} ]] && continue || continue 2
			done

			#  intention move [elf] = position x,y
			
			intention_move[$j]="$x $y"
			(( future_occupation["$x $y"]+=1 ))
			break
		done
	done

	#  Move elves
	for n in ${!intention_move[@]}; do
		(( ${future_occupation[${intention_move[$n]}]} == 1 )) && elves[$n]=${intention_move[$n]}
	done
	
	#  create new occupied
	occupied=( )
	for elf in "${elves[@]}"; do
		occupied["$elf"]=1
	done

	#  clear fitire_occupation
	future_occupation=( )
	intention_move=( )

done

#print_map "elves"

if (( part == 1 )); then
	solve_part_1
else
	echo "part 2 $i"
fi

