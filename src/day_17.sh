#!/usr/bin/env bash
#
#  day_17.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1677011787 -> 21/02/23 17:36:27
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_17_test"
    echo Use test data input
else
    data_input="data/day_17"
    echo "use source data input"
fi
#-----------------------------------Variables---------------------------------#
declare -a rock_shapes
declare -A solid_rocks
declare -i highest_rock
#-------------------------------Function Move---------------------------------#
function move () {
	local piece
	local direction
	piece=( $1 )
	[[ $2 == ">" ]] && direction=1 || direction=-1
	for each_piece in "${piece[@]}"; do
		x=${each_piece%,*}
		y=${each_piece#*,}
		x=$((x + $direction))
		if [[ x -lt 0 ]] || [[ x -gt 6 ]]; then
			echo "${piece[@]}"
			return
		fi
		new_piece+=( "$x,$y" )
	done
	echo "${new_piece[@]}"
}
#---------------------------------Function start rock-------------------------#
function start_rock () {
	local piece
	piece=( $1 )
	for each_piece in "${piece[@]}"; do
		x=${each_piece%,*}
		y=${each_piece#*,}
		x=$((x + 2 ))
		y=$((y + $highest_rock + 4))
		new_piece+=( "$x,$y" )
	done
	echo "${new_piece[@]}"
}
#----------------------------------Function go down---------------------------#
function go_down () {
	local piece
	piece=( $1 )
	for each_piece in "${piece[@]}"; do
		x=${each_piece%,*}
		y=${each_piece#*,}
		y=$(( y - 1 ))
		if [[ y -le 0 ]] || [[ "${solid_rocks[$x,$y]}" -eq 1 ]]; then
			echo "${piece[@]}"
			return 1
		fi
		new_piece+=( "$x,$y" )
	done
	echo "${new_piece[@]}"
}
#----------------------------------Read data input----------------------------#
read moves < "$data_input"
#----------------------------------Rock Shapes--------------------------------#
rock_shapes+=( "0,0 1,0 2,0 3,0" )
rock_shapes+=( "1,0 0,1 1,1 2,1 1,2" )
rock_shapes+=( "0,0 1,0 2,0 2,1 2,2" )
rock_shapes+=( "0,0 0,1 0,2 0,3" )
rock_shapes+=( "0,0 1,0 0,1 1,1" )
#---------------------------------Main Loop-----------------------------------#
#set -x
i=0
for ((rock=0; rock<2022; rock++)); do
	rock_index=$(( rock % 5 ))
	rock_piece=$(start_rock "${rock_shapes[rock_index]}")
	while : ; do
		index=$(( i % ${#moves} ))
		rock_piece=$(move "$rock_piece" "${moves:index:1}")
		let i++
		if ! rock_piece=$(go_down "$rock_piece"); then 
			break
		fi
	done
	for each_piece in ${rock_piece[@]}; do
		solid_rocks[$each_piece]=1
		y=${each_piece#*,}
		[[ ${highest_rock:-0} -lt $y ]] && highest_rock=y
	done
done
#-------------------------------First Star------------------------------------#
declare -p solid_rocks
echo $highest_rock
#--------------------------------------|--------------------------------------#
#print
for ((y=20; y>0; y--)); do
	echo -n "|"
	for ((x=0; x<=6; x++)); do
		[[ ${solid_rocks["$x,$y"]} -eq 1 ]] && echo -n "#" || echo -n "."
	done
	echo "|"
done
echo "+-------+"




