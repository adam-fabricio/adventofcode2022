#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
stack_index=0
#-----------------------------------Functions---------------------------------#
show_stacks() {
    for stack in ${stack_index[@]}
    do
        echo $(declare -p stack_$stack)
    done
}

push() {
	declare -n arr_name=stack_$1
	arr_name+=( "$2" )
}

pop () {
	stack_temp="stack_$1[-1]"
	item=${!stack_temp}
	unset stack_$1[-1]
}

giant_cargo_crane() {
    #show_stacks
    for (( move=0 ; move<$1 ; move++ ))
    do
		pop $2
		push $3 $item
    done

}

#------------------------------------Codes------------------------------------#

#----------------------------------Stacks-------------------------------------#

#  Find marker of stacks and commands
for (( i=1; i>0; i++ ))
do
    if ! [[ $(sed $i\!d "$1") ]] 
    then
        let marker=$i-2
        break
    fi
    stack_index=( $(sed $i\!d "$1") )
done


#  Transform stacks in arrays
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
    done
done

#  Export stacks
for stack in ${stack_index[@]}
do
	:
done	

#  Get commands

while read line
do
    line=( $line )
    giant_cargo_crane ${line[1]} ${line[3]} ${line[5]}
done <<< $(sed 1,"$i"d $1) 

#---------------------------------First Star----------------------------------#
for stack in ${stack_index[@]}
do
	stack_temp="stack_$stack[-1]"
	item=${!stack_temp}
	echo -n $item
done
echo

#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
