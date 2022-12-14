#!/bin/bash

# day_03.sh

#--------------------------Teste de recebimento de parâmetro------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-------------------------------Variaveis-------------------------------------#
line_number=1
sum_priorities=0
sum_budge=0
#---------------------------Char to ASCI---I----------------------------------#
char_to_asc() {
	asc=$(printf '%d' \'"$1")
	[ "$asc" -gt 95 ] && let val=$asc-96 || let val=asc-38
	echo $val
}
#-----------------------------------------------------------------------------#
while read line
do
#----------------------------First Star---------------------------------------#
	let half_line=${#line}/2
	for (( position=0; position<$half_line; position++ ))
	do
		if [[ "${line:$half_line}" == *"${line:$position:1}"* ]] 
		then
			priority=$(char_to_asc "${line:$position:1}")
			let sum_priorities+=$priority
			break
		fi
	done
#----------------------------Second Star--------------------------------------#
	line_buffer[$line_number]=$line
	let line_number++
	if [ "$line_number" -eq 4 ]
	then
		line_ref="${line_buffer[1]}"
		for (( i=0; i<${#line_ref}; i++ ))	
		do
			if [[ "${line_buffer[2]}" == *"${line_ref:$i:1}"* ]]
			then
				if [[ "${line_buffer[3]}" == *"${line_ref:i:1}"* ]]
				then
					badge=$(char_to_asc ${line_ref:$i:1})
					let sum_budges+=$badge
					break
				fi
			fi
		done
		line_number=1
	fi
#------------------------------End--------------------------------------------#
done < "$1"
#---------------------------Result--------------------------------------------#
echo "First star  -> $sum_priorities"
echo "Second star -> $sum_budges"
#-----------------------------------------------------------------------------#
