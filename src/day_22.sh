#!/usr/bin/env bash
#
#  day_22.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698894485 -> 02/11/23 00:08:05
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_22_test"
    echo Use test data input
else
    data_input="data/day_22"
    echo "use source data input"
fi
#  part
part=2
#---------------------------------spin function-------------------------------#
spin(){
	local local_instruction=${1:-$instruction}
	local lin=${direction[0]}
	local col=${direction[1]}
	case $local_instruction in
		"R")
			direction[0]=$(( col ))
			direction[1]=$(( -1 * lin ))
			;;
		"L")
			direction[0]=$(( -1 * col ))
			direction[1]=$(( lin ))
			;;
	esac
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
	
	ref=0
}

#--------------------------------function move col----------------------------#
move_col(){
	path="${line[${position[0]}]}"
	ref=1
}
#--------------------------------function slice-------------------------------#
slice(){
	if [[ direction[0] -eq 0 ]]; then
		move_col
	else
		move_row
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
	if [[ part -eq 1 ]]; then
		new_location=$inf_limit
	else
		(( ref == 1 )) && translate_upper_col || translate_upper_row
	fi
}
#------------------------function translate_upper_col-------------------------#

translate_upper_col(){
	echo "upper col"
	declare -p position direction path
	if (( position[0] >= 0 && position[0] <= 49 )); then
		spin "L"
		spin "L"
		position[0]=$(( 149 - position[0] ))
		position[1]=99
		new_location=99
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[0] >= 50 && position[0] <= 99 )); then
		spin "L"
		position[1]=$(( position[0] - 50 + 100 ))
		position[0]=49
		new_location=49
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[0] >= 100 && position[0] <= 149 )); then
		spin "L"
		spin "L"
		position[0]=$(( 49 - ( position[0] - 100 ) ))
		position[1]=149
		new_location=149
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[0] >= 150 && position[0] <= 199 )); then
		spin "L"
		position[1]=$(( position[0] - 150 + 50 ))
		position[0]=149
		new_location=149
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	else
		echo "Erro Out of Range"
		exit
	fi
}
#------------------------function translate_upper_row-------------------------#
translate_upper_row(){
	echo "upper row"
	declare -p position direction
	if (( position[1] >= 0 && position[1] <= 49 )); then
		position[1]=$(( position[1] + 100 ))
		position[0]=0
		new_location=0
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[1] >= 50 && position[1] <= 99 )); then
		spin "R"
		position[0]=$(( position[1] - 50 + 150 ))
		position[1]=49
		new_location=49
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[1] >= 100 && position[1] <= 149 )); then
		spin "R"
		position[0]=$(( position[1] - 100 + 50 ))
		position[1]=99
		new_location=99
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[1] >= 150 && position[1] <= 199 )); then
		exit
	else
		echo "Erro Out of Range"
		exit
	fi
}

#--------------------------------function inf_resolve-------------------------#
inf_resolve(){
	if [[ part -eq 1 ]]; then
		new_location=$(( upper_limit - 1 ))
	else
		(( ref == 1 )) && translate_inf_col || translate_inf_row
	fi
}
#-------------------------function translate_inf_col--------------------------#
translate_inf_col(){
	echo "inf col"
	declare -p position direction
	if (( position[0] >= 0 && position[0] <= 49 )); then
		spin "L"
		spin "L"
		position[0]=$(( 149 - position[0] ))
		position[1]=0
		new_location=0
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[0] >= 50 && position[0] <= 99 )); then
		spin "L"
		position[1]=$(( position[0] - 50 ))
		position[0]=100
		new_location=100
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[0] >= 100 && position[0] <= 149 )); then
		spin "L"
		spin "L"
		position[0]=$(( 49 - ( position[0] - 100 ) ))
		position[1]=50
		new_location=50
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[0] >= 150 && position[0] <= 199 )); then
		spin "L"
		position[1]=$(( position[0] - 150 + 50 ))
		position[0]=0
		new_location=0
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	else
		echo "Erro Out of Range"
		exit
	fi
}
#-------------------------function translate_inf_row--------------------------#
translate_inf_row(){
	echo "inf row"

	declare -p position direction
	if (( position[1] >= 0 && position[1] <= 49 )); then
		spin "R"
		position[0]=$(( position[1] + 50 ))
		position[1]=50
		new_location=50
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[1] >= 50 && position[1] <= 99 )); then
		spin "R"
		position[0]=$(( position[1] - 50 + 150 ))
		position[1]=0
		new_location=0
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[1] >= 100 && position[1] <= 149 )); then
		position[1]=$(( position[1] - 100 ))
		position[0]=199
		new_location=199
		slice
		declare -p position direction path
		echo "${path:$new_location:1} == #"
	elif (( position[1] >= 150 && position[1] <= 199 )); then
		exit
	else
		echo "Erro Out of Range"
		exit
	fi
}
#--------------------------------function walk--------------------------------#
walk(){
	slice
	for (( j = 0; j < instruction; j++ )); do
		tmp_pos=( ${position[@]} )
		tmp_dir=( ${direction[@]} )
		#  verify next step
		new_location=$(( position[ref] + direction[ref] ))
		#  if end go to init
		if [[ new_location -eq upper_limit ]]; then
			upper_resolve
		#  if min go to end
		elif [[ new_location -eq $(( inf_limit - 1 )) ]]; then
			inf_resolve
		fi
		# if wall stop
		if [[ "${path:$new_location:1}" == "#" ]];then
			position=( ${tmp_pos[@]} )
			direction=( ${tmp_dir[@]} )
			break
		fi
		#  do step
		position[ref]=$new_location
	done
}
#----------------------------------Read data input----------------------------#
line_number=1

mapfile -t line < "$data_input"

#  starting position. ( row collumm )
for (( i = 0; i < ${#line[0]}; i++ )); do
	[[ ${line[0]:$i:1} == "." ]] && position=( 0 $i ) && break
done

#  start condition
#  starting direction ( vertical horizontal )
direction=( 0 1 )


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
#
#
#
#
#           ##########
#			#    #   #-> A
#			#    #   #
#			#    #   #
#			##########
#			#    #  v
#			#    #  B
#			#    #<-B
#	    ##########
# 	    #   #    #
#	    #   #    #
#	    #   #    # <- A
#	    ##########
#       #   #
#       #   #
#       #   #
#       #####
#
#
#
#
#
#
#--------------------------------------|--------------------------------------#
