#!/usr/bin/env bash
#
#  day_17.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1677011787 -> 21/02/23 17:36:27
#	 1678086362 -> 06/03/23 04:06:02
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
		if [[ x -lt 0 ]] || [[ x -gt 6 ]] || [[ "${solid_rocks[$x,$y]}" -eq 1 ]]
		then
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
#----------------------------------Function print_map-------------------------#
function print_map () {
	clear
	local piece
	piece=( $1 )
	for ((y=$highest_rock+4; y>0; y--)); do
		echo -n "|"
		for ((x=0; x<=6; x++)); do
			if [[ ${solid_rocks["$x,$y"]} -eq 1 ]]; then
				echo -n "#"
			elif [[ "${piece[@]}" == *"$x,$y"* ]]; then
				echo -n "@"
			else
				echo -n "."
			fi
		done
		echo "| -> $rock -> $i"
	done
	echo "+-------+"
	echo "$rock"
	sleep 0.1
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
rock=0
j=0
declare -a f_rock
declare -A rmd


while : ; do
#for ((rock=0; rock<51; rock++)); do
	rock_index=$(( rock % 5 ))
	rock_piece=$(start_rock "${rock_shapes[rock_index]}")
	#print_map "${rock_piece[@]}"
	while : ; do
		index=$(( i % ${#moves} ))
		rock_piece=$(move "$rock_piece" "${moves:index:1}")
		#print_map "${rock_piece[@]}"
		let i++
		if ! rock_piece=$(go_down "$rock_piece"); then 
			break
		fi
		#print_map "${rock_piece[@]}"
	done
	highest_rock_0="${highest_rock:-0}"
	for each_piece in ${rock_piece[@]}; do
		solid_rocks[$each_piece]=1
		y=${each_piece#*,}
		[[ ${highest_rock:-0} -lt $y ]] && highest_rock=y
	done
	delta_h=$(( ${highest_rock:-0} - ${highest_rock_0} ))
	ri_m_dh="$rock_index,$index,$delta_h"
	#echo -n "$rock->$ri_m_dh->$j "
	if [[ ${rmd[$ri_m_dh]} ]]; then
		#echo "$rock->$ri_m_dh->${rmd[$ri_m_dh]}"
		if ! [[ $period ]]; then
			period=$(( $rock - ${rmd[$ri_m_dh]} ))
			transient_height=$highest_rock_0
			transient_rock=$rock
		fi
		if [[ $j -lt $period ]]; then
			f_rock+=( $delta_h )
			(( j += 1 ))
		else
			break
		fi
	else
		unset period
		unset f_rock
		declare -a f_rock
		unset j
	fi
	rmd[$ri_m_dh]=$rock
	(( rock += 1 ))
done
#-------------------------------First Star------------------------------------#
#echo $highest_rock
#--------------------------------------|--------------------------------------#
echo
echo "altura transiente $transient_height"
echo "posição da pedra transient $transient_rock"
echo "Periodo ${#f_rock[@]}"
sum=0
for num in "${f_rock[@]}"; do
	(( sum += num ))
done
echo "valor total da soma do periodo $sum"
rocks=1000000000000
rock_0=$(( rocks - transient_rock ))
rock_1=$(( rock_0 / $period ))
rock_2=$(( rock_1 * sum ))
rock_3=$(( rock_2 + transient_height ))
rock_4=$(( rock_0 % $period ))
rock_5=0
for (( i=0; i<$rock_4 ; i++ )); do
	rock_5=$(( rock_5 + ${f_rock[i]} ))
done
rock_6=$(( rock_3 + rock_5 ))

echo "0 $rock_0"
echo "1 $rock_1"
echo "2 $rock_2"
echo "3 $rock_3"
echo "4 $rock_4"
echo "5 $rock_5"
echo "6 $rock_6"


#  1514285714288
#  1514285714288
#  1507109004776 -> Low'
