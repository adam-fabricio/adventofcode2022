#!/usr/bin/env bash
#
#  day_13.sh
#
#----------------------------------Time Cap-----------------------------------#
#  start      -> 1673098337 -> 07/01/23 10:32:17
#  parser     -> 1673113343 -> 07/01/23 14:42:23
#  first try  -> 1673121350 -> 07/01/23 16:55:50 -> 6178 too low
#  Second try -> 1673151367 -> 08/01/23 01:16:07 -> 6555 too high
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
function compare () {
    left=$(tr -d "[]" <<< $1)
    right=$(tr -d "[]" <<< $2)
    IFS=',' read -a left <<< "$left"
    IFS=',' read -a right <<< "$right"
    if test -z $right && test -z $left
    then
        [[ ${#1} -gt ${#2} ]] && echo 0 || echo 1
        return
    else
        for ((i=0 ; i<${#left[@]} ; i++))
        do
            [[ ${left[i]} -eq ${right[i]} ]] && continue
            [[ ${left[i]} -lt ${right[i]} ]] && echo 1 || echo 0
            return
        done
    fi
    echo 1
}

function compare_2 () {
    left_list=$(sed 's/\[// ; s/]$//' <<< $1)
    right_list=$(sed 's/\[// ; s/]$//' <<< $2)
} 


#----------------------------------Read data input----------------------------#
i=1
declare -i sum_indice
packtes=$(tr "\n" " " < "$data_input" | sed 's/  /\n/g')
while read -a package 
do
    
    compare_result=$(compare ${package[@]})
    
    echo -ne "$i-> ${compare_result}\n"  
    echo "left  ${package[0]}"
    echo "right ${package[1]}"
    echo 
    let sum_indice+=$i*$compare_result
    let i++
    #exit
done <<< "$packtes" 
echo $sum_indice
#--------------------------------------|--------------------------------------#
