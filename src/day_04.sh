#!/bin/bash

# day_04.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
sum_fully_contains=0
#-----------------------------------Functions---------------------------------#
range_to_section() {
	IFS="-" read -a range <<< "$1"
	echo $(seq ${range[@]})
}

fully_contains() {
	section1=$(range_to_section "$1")
	section2=$(range_to_section "$2")
	if [ "${#section1}" -le "${#section2}" ] 
	then
		[[ " "$section2" " == *" "$section1" "* ]] && echo "1" || echo "0"
	else
		[[ " "$section1" " == *""$section2" "* ]] && echo "1" || echo "0"
	fi
}
#------------------------------------Codes------------------------------------#
while read line
do
#---------------------------------First Star----------------------------------#
	IFS="," read -a assignment <<< $line
	[ "$(fully_contains ${assignment[@]})" -eq 1 ] && echo $line
	let sum_fully_contains+="$(fully_contains ${assignment[@]})"

#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
done < "$1"
#-----------------------------------Results-----------------------------------#
echo "First star  -> $sum_fully_contains"
echo "Second star -> $sum_budges"
#--------------------------------------|--------------------------------------#
