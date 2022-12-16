#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
stack_index=0
declare -a stack
#-----------------------------------Functions---------------------------------#
#------------------------------------Codes-------------------------------------#

#----------------------------------Stacks-------------------------------------#
for (( i=1; i>0; i++ ))
do
    if ! [[ $(sed $i\!d "$1") ]] 
    then
        let marker=$i-2
        break
    fi
    stack_index=( $(sed $i\!d "$1") )
done

for index in ${stack_index[@]}
do
    declare -a stack_$index
done


for (( line=$marker ; line>0 ; line-- )) 
do
    floor=$(sed $line\!d $1 )
    for stack in ${stack_index[@]}
    do
        let index=-3+4*stack
        eval pointer="\${#stack_$stack[@]}"
        if [ "${floor:$index:1}" != " " ] 
        then
            declare stack_$stack[$pointer]=${floor:index:1}
        fi
        echo $(declare -p stack_$stack)
    done
done




#---------------------------------First Star----------------------------------#
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
