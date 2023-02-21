#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
marker=
#-----------------------------------Functions---------------------------------#

#------------------------------------Codes------------------------------------#
read packet < $1
#---------------------------------First Star----------------------------------#
for (( i=0 ; i<${#packet} ; i++ ))
do
	[[ "$i" -eq "0" ]] && marker+=${packet:$i:1} && continue
	if [[ "${marker}" == *"${packet:$i:1}"* ]]
	then
		for (( j=0; j<${#marker}; j++ ))
		do
			if [[ ${marker:j:1} == ${packet:$i:1} ]]
			then
				marker="${marker:j+1}"
				marker+=${packet:$i:1}
				break
			fi
		done
	else
		marker+=${packet:$i:1}
		if [[ ${#marker} -eq 5 ]] 
		then
			echo "first star ->  $i"
			break
		fi
	fi
done
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
for (( i=0 ; i<${#packet} ; i++ ))
do
	[[ "$i" -eq "0" ]] && marker+=${packet:$i:1} && continue
	if [[ "${marker}" == *"${packet:$i:1}"* ]]
	then
		for (( j=0; j<${#marker}; j++ ))
		do
			if [[ ${marker:j:1} == ${packet:$i:1} ]]
			then
				marker="${marker:j+1}"
				marker+=${packet:$i:1}
				break
			fi
		done
	else
		marker+=${packet:$i:1}
		if [[ ${#marker} -eq 15 ]] 
		then
			echo "second star ->  $i"
			break
		fi
	fi
done
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
