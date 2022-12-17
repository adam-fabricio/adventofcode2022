#!/bin/bash

# day_xx.sh

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
stack_index=0
declare -a stack
#-----------------------------------Functions---------------------------------#
show_stacks() {
    for stack in ${stack_index[@]}
    do
        echo $(declare -p stack_$stack)
    done
}

push() {
	echo "parametros: $1 $2"
}

pop () {
	stack="stack_$1[-1]"
	echo ${!stack}
	unset stack_$1[-1]
}

giant_cargo_crane() {
    echo "Move ${1} from ${2} to ${3}."
    #show_stacks

    for (( move=0 ; move<$1 ; move++ ))
    do
	    push $3 $(pop $2)
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

#  Get commands
while read line
do
    line=( $line )
    giant_cargo_crane ${line[1]} ${line[3]} ${line[5]}
done <<< $(sed 1,"$i"d $1) 

#---------------------------------First Star----------------------------------#
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
