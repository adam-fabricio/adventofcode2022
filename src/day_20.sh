#!/usr/bin/env bash
#
#  day_20.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698098317 -> 23/10/23 18:58:37
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_20_test"
    echo Use test data input
else
    data_input="data/day_20"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
declare -a list
declare -i line_number=1
part=2
idx=0
key=811589153
[[ part -eq 1 ]] && mix_times=1 || mix_times=10

while read line
do
	#  cria lista
	[[ part -eq 2 ]] && line=$(( line * key ))
	list+=("$line|$idx")
	let idx++
done < "$data_input"


lenght=${#list[@]}
#-----------------------------------functions---------------------------------#
move_item(){
	position=$j
	new_position=$(( ( value + position ) % ( lenght - 1 )  ))
	[[ new_position -lt 0 ]] && new_position=$(( new_position + lenght - 1 ))
	#  move o valor
	#  remove item of list
	list=(${list[@]::$position} ${list[@]:$((position+1))})
	#  add item to list
	list=(${list[@]::$new_position} "$value|$idx" ${list[@]:$new_position})
}
#-----------------------------------main--------------------------------------#
#  tamanho da lista
#  iterar sobre os itens da lista
for (( mix = 0; mix < mix_times; mix++ )); do
	for (( i = 0; i < lenght; i++ )); do
		#  find next value to mix
		for (( j = 0; j < lenght; j++)); do
			IFS="|" read _ idx <<< ${list[$j]}
			[[ i -eq idx ]] && break
		done
		IFS="|" read value _ <<< ${list[$j]}
		#declare -p list
		#echo $value $j
		# if number is 0 do not move
		[[ value -eq 0 ]] && continue
		move_item
	done
done

for (( i = 0; i < lenght; i++ )); do
	IFS="|" read value flag <<< ${list[$i]}
	[[ value -eq 0 ]] && id0=$i && break
done


echo "id0=$id0"
results=( ${list[$(((id0+1000)%lenght))]%|*} \
	${list[$(((id0+2000)%lenght))]%|*} \
	${list[$(((id0+3000)%lenght))]%|*} )

echo ${results[@]}

sum_result=0
for result in ${results[@]}; do
	sum_result=$((sum_result + result ))
done
echo "result= $sum_result"


#for (( i = 0; i < lenght; i++ )); do
#	IFS="|" read value flag <<< ${list[$i]}
#	echo "$value"
#done
