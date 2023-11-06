#!/usr/bin/env bash
#
#  day_22.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698894485 -> 02/11/23 00:08:05
#
#----------------------------------Data input---------------------------------#
#---------------------------------spin function-------------------------------#
spin(){
	local lin=${direction[0]}
	local col=${direction[1]}
	case $instruction in
		"R")
			direction[0]=$(( col ))
			direction[1]=$(( -1 * lin ))
			;;
		"L")
			direction[0]=$(( -1 * col ))
			direction[1]=$(( lin ))
			;;
	esac
	change_direction=0
	#echo "spin ${direction[@]}"
}

#--------------------------------function move row----------------------------#
move_row(){
	# slice col
	path=""
	for (( i=0; i<=${#line[@]}; i++ )); do
		case "${line[$i]:${position[1]}:1}" in
			".") path+="." ;;
			"#") path+="#" ;;
			*)   path+=" " ;;
		esac
	done
	
	change_direction=1
	ref=0
}

#--------------------------------function move col----------------------------#
move_col(){
	path="${line[${position[0]}]}"
	change_direction=1
	ref=1
}
#--------------------------------function slice-------------------------------#
slice(){
	if [[ change_direction -eq 0 ]]; then
	   if [[ direction[0] -eq 0 ]]; then
		  move_col
	  else
		  move_row
	   fi
	fi
	#  remove caracter em branco depois da string	
	path="${path%"${path##*[![:space:]]}"}"
	#  def upper limit
	upper_limit=${#path}
	#  def inferior limit
	for ((i=0; i<$upper_limit; i++)); do
		[[ ! "${path:$i:1}" == " " ]] && inf_limit=$i && break
	done
}

#--------------------------------function upper_resolve-----------------------#
upper_resolve(){
	:
}
#--------------------------------function inf_resolve-------------------------#
inf_resolve(){
	:
}
#--------------------------------function walk--------------------------------#
walk(){
	slice

	for (( i = 0; i < instruction; i++ )); do
		#  verify next step
		new_location=$(( position[ref] + direction[ref] ))
		
		#  if end go to init
		if [[ new_location -eq upper_limit ]]; then
			upper_resolve
			new_location=$inf_limit
		
		#  if min go to end
		elif [[ new_location -eq $(( inf_limit - 1 )) ]]; then
			inf_resolve
			new_location=$(( upper_limit - 1 ))
		fi

		# if wall stop
		[[ "${path:$new_location:1}" == "#" ]] && break
		
		#  do step
		position[ref]=$new_location
	done

}

#--------------------------------------|--------------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_22_test"
    echo Use test data input
else
    data_input="data/day_22"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
line_number=1

mapfile -t line < "$data_input"

# for (( i = 0; i < "${#line[@]}"; i++ ))
# do
# 	printf "%02d -> %s\n" $line_number "${line[i]}"
#     let line_number++
# done < "$data_input"

#  starting position. ( row collumm )
for (( i = 0; i < ${#line[0]}; i++ )); do
	[[ ${line[0]:$i:1} == "." ]] && position=( 0 $i ) && break
done

#  start condition
#  starting direction ( vertical horizontal )
direction=( 0 1 )
#  part
part=2


# start instructions.
while read -r -a instruction; do
	[[ $instruction =~ ^[0-9]+$ ]] && walk || spin
	[[ position[1] -lt 0 || position[0] -lt 0 ]] && exit
done <<< $(echo ${line[-1]} | grep -oP '\d+|\D+')

declare -p position direction

#  Calc result.

case "${direction[@]}" in
	"0 1") val_dir=0 ;;
	"1 0") val_dir=1 ;;
	"0 -1") val_dir=2 ;;
	"-1 0") val_dir=3 ;;
esac

result=$(( 1000 * ( position[0] + 1 ) + 4 * ( position[1] + 1 ) + val_dir ))
echo "result=$result"
#--------------------------------------|--------------------------------------#
