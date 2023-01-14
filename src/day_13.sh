#!/usr/bin/env bash
#
#  day_13.sh
#
#----------------------------------Time Cap-----------------------------------#
#  start      -> 1673098337 -> 07/01/23 10:32:17
#  parser     -> 1673113343 -> 07/01/23 14:42:23
#  first try  -> 1673121350 -> 07/01/23 16:55:50 -> 6178 too low
#  Second try -> 1673151367 -> 08/01/23 01:16:07 -> 6555 too high
#  third try  -> 1673152518 -> 08/01/23 01:35:18 -> 6401 too low
#  first Star -> 1673639159 -> 13/01/23 16:01:59
#--------------------------------------|--------------------------------------#
#    If both values are integers, the lower integer should come first. If the 
#left integer is lower than the right integer, the inputs are in the right 
#order. If the left integer is higher than the right integer, the inputs are 
#not in the right order. Otherwise, the inputs are the same integer; 
#continue checking the next part of the input.
#    If both values are lists, compare the first value of each list, then the 
#second value, and so on. If the left list runs out of items first, the 
#inputs are in the right order. If the right list runs out of items first, 
#the inputs are not in the right order. If the lists are the same length and 
#no comparison makes a decision about the order, continue checking the next 
#part of the input.
#    If exactly one value is an integer, convert the integer to a list which 
#contains that integer as its only value, then retry the comparison. For 
#example, if comparing [0,0,0] and 2, convert the right value to [2] (
#a list containing 2); the result is then found by instead comparing 
#[0,0,0] and [2].
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == "teste" ]]
then
    data_input="data/day_13_test"
    echo -e "Use test data input\n\n"
else
    data_input="data/day_13"
    echo -e "use source data input\n\n"
fi
#---------------------------------Compare function----------------------------#
function extract_list () {
	# vars
	local brackets 
	local i
	local itens
	local list
   	local raw_list

	#  extract list
	raw_list=${1:1:${#1}-2}
	
	#  Iterate by itens in list
	while :
	do
		itens=( ${raw_list/,/" "} ) 
		if [[ ${itens[0]} =~ \[ ]] 
		then
			local i=0
			local brackets=0
			while :
			do
				if [[ ${raw_list:i:1} == [ ]] 
				then
					let brackets++ i++
				elif [[ ${raw_list:i:1} == ] ]] 
				then
					let brackets-- i++
					if [[ brackets -eq 0 ]] 
					then
						itens=( ${raw_list:0:i} ${raw_list:i+1} )
						break
					fi
				else
					let i++
				fi
			done
		fi
		list+=( ${itens[0]} )
		raw_list=${itens[1]}
		[[ -z ${itens[0]} ]] && break
	done
    
	echo "${list[@]}"
}

function compare () {
	#  Vars
	local i
	local right
	local left
	local value

    #--------Extract Value and convert to array--------#
    left=( $(extract_list $1) )
    right=( $(extract_list $2) )
    #--------Iterate by list left----------------------#
    for ((i=0; i<${#left[@]}; i++))
    do
		#  If left is integer
        if [[ ${left[i]} =~ ^[-+]?[0-9]+$ ]] 
		then
            #  If right is integer
            if [[ ${right[i]} =~ ^[-+]?[0-9]+$ ]] 
            then
                [[ ${left[i]} -eq ${right[i]} ]] && continue
                [[ ${left[i]} -lt ${right[i]} ]] && echo 1 || echo 0
                return
            #  If right is list
            elif [[ ${right[i]} =~ ^\[.*\]$ ]] 
            then
				value=$( compare [${left[i]}] ${right[i]} )
				test -z $value && continue
			   	echo $value	
				return
			#  if right is None
			else
				echo "0"
				return
			fi
        #  If left is list
        elif [[ ${left[i]} =~ ^\[.*\]$ ]] 
        then
            #  If right is list
            if [[ ${right[i]} =~ ^\[.*\]$ ]] 
            then
				value=$( compare ${left[i]} ${right[i]} )
				test -z $value && continue
			   	echo $value	
				return
            #  if right is integer
            elif [[ ${right[i]} =~ ^[-+]?[0-9] ]]
            then
				value=$( compare ${left[i]} [${right[i]}] )
				test -z $value && continue 
				echo $value
				return
			#  if right is None
			else
				echo "0"
				return
			fi
		fi
	done
	#  left is None
	#  if right is integer
	if [[ ${right[i]} =~ ^[-+]?[0-9] ]]
	then
		echo "1"
	#  If right is list
	elif [[ ${right[i]} =~ ^\[.*\]$ ]] 
	then
		echo "1"
	fi
}

#----------------------------------Read data input----------------------------#
i=1
declare -i sum_indice
packtes=$(tr "\n" " " < "$data_input" | sed 's/  /\n/g')
while read -a package 
do
    compare_result=$(compare ${package[@]})
   
    echo "left  ${package[0]}"
    echo "right ${package[1]}"
    compare ${package[@]}
	echo -ne "$i-> ${compare_result}\n"  
    echo 
    let sum_indice+=$i*$compare_result
    let i++
done <<< "$packtes" 
echo $sum_indice
#--------------------------------------|--------------------------------------#
