#!/usr/bin/env bash
#
#  day_18.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1678665296 -> 12/03/23 20:54:56
#    1678668914 -> 12/03/23 21:55:14
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
declare -A cubes_to_visit
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
	read x y z <<< $1
	#  Veriicar se o cubo já foi visitado
	[[ "${cubes[$1]}" ]] && return

	
	#  verificar se o é externo.
	if  [[ $x -lt $x_min ]] || [[ $y -lt $y_min ]] ||[[ $z -lt $z_min ]] ||\
		[[ $x -gt $x_min ]] || [[ $y -gt $y_min ]] ||[[ $z -gt $z_min ]]; then
		
		#  All cubes visit is outer
		for cube in "${!visited_cubes}"; do
		outer_cubes["$cube"]=1
		done
		return 1
	fi

}

for cube in "${!cubes[@]}"; do
	[[ "${cubes[$((x-1)) $y $z]}" ]] || ((ans+=1))
	[[ "${cubes[$((x+1)) $y $z]}" ]] || ((ans+=1))

done

