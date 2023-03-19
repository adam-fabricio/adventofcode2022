#!/usr/bin/env bash
#
#  day_18.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1678665296 -> 12/03/23 20:54:56
#    1678668914 -> 12/03/23 21:55:14
#    1679040063 -> 17/03/23 05:01:03
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_18_test"
    echo Use test data input
else
    data_input="data/day_18"
    echo "use source data input"
fi

#----------------------------------Variables----------------------------------#
declare -A cubes
declare -A outer_cubes
declare -A inner_cubes
declare -A visited_cubes
declare -a cubes_to_visit
declare -i inf=$((2**62-1))
declare -i x_max=-1
declare -i x_min=$inf
declare -i y_max=-1
declare -i y_min=$inf
declare -i z_max=-1
declare -i z_min=$inf

#----------------------------------Read data input----------------------------#

line_number=1
while read line
do
	read x y z <<< "${line//,/ }"	
	cubes["${line//,/ }"]=1

	[[ $x -gt $x_max ]] && x_max=$x
	[[ $y -gt $y_max ]] && y_max=$y
	[[ $z -gt $z_max ]] && z_max=$z

	[[ $x -lt $x_min ]] && x_min=$x
	[[ $y -lt $y_min ]] && y_min=$y
	[[ $z -lt $z_min ]] && z_min=$z

done < "$data_input"

# echo "($x_min,$y_min,$z_min)"
# echo "($x_max,$y_max,$z_min)"

#-----------------------------First star--------------------------------------#
ans=0
for cube in "${!cubes[@]}"; do
	read x y z <<< "$cube"
	[[ "${cubes[$((x-1)) $y $z]}" ]] || ((ans+=1))
	[[ "${cubes[$((x+1)) $y $z]}" ]] || ((ans+=1))

	[[ "${cubes[$x $((y-1)) $z]}" ]] || ((ans+=1))
	[[ "${cubes[$x $((y+1)) $z]}" ]] || ((ans+=1))
	
	[[ "${cubes[$x $y $((z+1))]}" ]] || ((ans+=1))
	[[ "${cubes[$x $y $((z-1))]}" ]] || ((ans+=1))
done

echo "First Star: $ans"

#--------------------------------------|--------------------------------------#
function check_internal () {
	local x
	local y
	local z
	unset visited_cubes
	declare -A visited_cubes
	[[ "${cubes[$1]}" ]] || [[ "${inner_cubes[$1]}" ]] && return 1
	[[ "${outer_cubes[$1]}" ]] && return 0
	
	cubes_to_visit=( "$1" )

	while [[ "${cubes_to_visit}" ]]; do
		read x y z <<< "${cubes_to_visit[0]}"
		cubes_to_visit=( "${cubes_to_visit[@]:1}" )

		[[ "${visited_cubes[$x $y $z]}" ]] && continue
		[[ "${cubes[$x $y $z]}" ]] && continue
		[[ "${inner_cubes[$x $y $z]}" ]] && break
		visited_cubes[$x $y $z]=1

		if [[ $x -lt $x_min ]] || [[ $y -lt $y_min ]] || [[ $z -lt $z_min ]] ||\
		   [[ $x -gt $x_max ]] || [[ $y -gt $y_max ]] || [[ $z -gt $z_max ]] ||\
		   [[ "${outer_cubes[$x $y $z]}" ]] ; then
			for visited_cube in "${!visited_cubes[@]}"; do
				outer_cubes[$visited_cube]=1
			done
			return 0
		fi

		cubes_to_visit+=( "$((x-1)) $y $z" "$((x+1)) $y $z" "$x $((y-1)) $z"\
						 "$x $((y+1)) $z" "$x $y $((z-1))" "$x $y $((z+1))")
	done
	for visited_cube in "${!visited_cubes[@]}"; do
		inner_cubes[$visited_cube]=1
	done
	return 1
}

ans=0
i=1
for cube in "${!cubes[@]}"; do
	echo -e -n "$(( (100*i)/(${#cubes[@]}+1) ))\r"
	read x y z <<< $cube
	check_internal "$((x-1)) $y $z" && ((ans+=1))
	check_internal "$((x+1)) $y $z" && ((ans+=1))
	check_internal "$x $((y-1)) $z" && ((ans+=1))
	check_internal "$x $((y+1)) $z" && ((ans+=1))
	check_internal "$x $y $((z-1))" && ((ans+=1))
	check_internal "$x $y $((z+1))" && ((ans+=1))
	let i++
done
echo

echo "Second Star: $ans"

