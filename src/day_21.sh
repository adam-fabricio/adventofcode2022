#!/usr/bin/env bash
#
#  day_21.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1698676479 -> 30/10/23 11:34:39
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_21_test"
    echo Use test data input
else
    data_input="data/day_21"
    echo "use source data input"
fi
#----------------------------------Read data input----------------------------#
declare -A results equations

mapfile -t lines < <(sort -t: -k2 $data_input)

for line in "${lines[@]}"
do
	read -a array_line <<< "$line"
	[[ ${array_line[0]} == "root:" ]] \
		&& var1=${array_line[1]} && var2=${array_line[3]}
	if [[ ${array_line[1]} =~ ^[0-9]+$ ]]; then
		results[${array_line[0]%:}]=${array_line[1]}
	else
		#declare -p array_line
		element1=${results[${array_line[1]}]-${array_line[1]}}
		operator=${array_line[2]}
		element2=${results[${array_line[3]}]-${array_line[3]}}
		if [[ $element1 =~ ^[0-9]+$ && $element2 =~ ^[0-9]+$ ]]; then
			results[${array_line[0]%:}]=$(( $element1 $operator $element2 ))
		else
			equations[${array_line[0]%:}]="$element1 $operator $element2"
		fi
	fi
done

while (( ${#equations[@]} )); do
	for equation in "${!equations[@]}"; do
		read -a vars <<<"${equations[$equation]}"

		element1=${results[${vars[0]}]-${vars[0]}}
		operator=${vars[1]}
		element2=${results[${vars[2]}]-${vars[2]}}
		
		if [[ $element1 =~ ^[0-9]+$ && $element2 =~ ^[0-9]+$ ]]; then
			results[$equation]=$(( $element1 $operator $element2 ))
			unset equations[$equation]
		fi
	done
done


echo "${#equations[@]} + ${#results[@]}"

echo "part1 root= ${results[root]}"

echo "***"

yell_number=10000000000000
inf=1
yell_number=3379022190353

while [[ "${results[$var1]}" != "${results[$var2]}" ]]; do
	unset results
	unset equations
	declare -A results equations

	for line in "${lines[@]}"; do
		read -a array_line <<< "$line"
		[[ "${array_line[0]}" == "humn:" ]] && array_line[1]=$yell_number
		if [[ ${array_line[1]} =~ ^-?[0-9]+$ ]]; then
			results[${array_line[0]%:}]=${array_line[1]}
		else
			element1=${results[${array_line[1]}]-${array_line[1]}}
			operator=${array_line[2]}
			element2=${results[${array_line[3]}]-${array_line[3]}}
			if [[ $element1 =~ ^-?[0-9]+$ && $element2 =~ ^-?[0-9]+$ ]]; then
				results[${array_line[0]%:}]=$(( $element1 $operator $element2 ))
			else
				equations[${array_line[0]%:}]="$element1 $operator $element2"
			fi
		fi
	done

	while (( ${#equations[@]} )); do
		for equation in "${!equations[@]}"; do
			read -a vars <<<"${equations[$equation]}"

			element1=${results[${vars[0]}]-${vars[0]}}
			operator="${vars[1]}"
			element2=${results[${vars[2]}]-${vars[2]}}
			
			if [[ $element1 =~ ^-?[0-9]+$ && $element2 =~ ^-?[0-9]+$ ]]; then
				results[$equation]=$(( $element1 $operator $element2 ))
				unset equations[$equation]
			fi
		done
	done
	echo "yell=$yell_number var1=${results[$var1]} var2=${results[$var2]}"
	echo "diff=$((${results[$var1]} - ${results[$var2]} ))"
	
	diff="$((${results[$var1]} - ${results[$var2]} ))"

	if [[ diff -lt 0 ]]; then
		sup=$yell_number
	else
		inf=$yell_number
	fi
	yell_number=$(( (sup + inf) / 2 ))

done

echo "part2 = $yell_number"
#--------------------------------------|-------------------------------------o #
