#!/bin/bash

# day_03.sh

#--------------------------Teste de recebimento de parâmetro------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-------------------------------Variaveis-------------------------------------#
line_number=1
sum_priorities=0
#---------------------------Commun Character----------------------------------#
commun_character() {
	echo $# $*
	[ "$#" -ne "2" ] && echo "Apenas dois parãmetros" && exit 1
	for (( position=0; position<${#1}; position++ ))
	do
		echo $position
	done
}

commun_character "adam" "fabricio"
#-----------------------------------------------------------------------------#
while read line
do
#----------------------------First Star---------------------------------------#
	let half_line=${#line}/2
	for (( position=0; position<$half_line; position++ ))
	do
		if [[ "${line:$half_line}" == *"${line:$position:1}"* ]] 
		then
			ascii_char=$(printf '%d' \'"${line:$position:1}")
			if [ "$ascii_char" -gt 95 ]
			then
				let priority=$ascii_char-96
			else
				let priority=$ascii_char-64+26
			fi
			let sum_priorities+=$priority
			break
		fi
	done
#----------------------------Second Star--------------------------------------#
	line_buffer[$line_number]=$line
	let line_number++
	[ "$line_number" -eq 3 ] && for (( position ))


	echo ${line_number[1]}


#------------------------------End--------------------------------------------#
done < "$1"
#-----------------------------------------------------------------------------#

echo "First star -> $sum_priorities"

#-----------------------------------------------------------------------------#
