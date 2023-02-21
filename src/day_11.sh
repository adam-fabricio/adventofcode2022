#!/bin/bash

# day_11.sh

# Não consegui descobrir sozinho a lógica da segunda parte tive que buscar ajuda
# na internet!

#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
declare -a monkeys
declare -i worry_level
declare -i rounds_1=20
declare -i rounds_2=10000


#-----------------------------------Functions---------------------------------#
function prime_reduce () {
    prime_factors=( $(factor "$1" | tr ' ' '\n' | uniq | tr '\n' ' '   ) )
    local result=1
    for (( i=1 ; i<${#prime_factors[@]} ; i++ ))
    do
        [[ ${prime_factors[$i]} -gt "50" ]] && prime_factors[$i]=1
        
        result=$(( $result * ${prime_factors[$i]} ))
    done

    echo $result 
}
#------------------------------------Codes------------------------------------#
#------------------------------------Parse------------------------------------#
while read -a note
do
    case ${note[0]} in 
        Monkey)
            monkey="monkey_${note[1]%:}"
            monkeys+=("$monkey")
            declare -A "$monkey"


            ;;

        Starting)
            declare -A "$monkey[${note[1]%:}]=${note[*]:2}"

            ;;

        Operation:)
            declare -A "$monkey[${note[0]%:}]=${note[*]:1}"
            ;;

        Test:)
            declare -A "$monkey[${note[0]%:}]=${note[3]}"
            ;;

        If)
            declare -A "$monkey[${note[1]%:}]=monkey_${note[${#note[@]}-1]}"
    esac

done < "$1"

#------------------------------------Trow-------------------------------------#


for ((i=0 ; i<$rounds_1 ; i++))
do

    for monkey in ${monkeys[@]}
    do
        #  Get item

        item_ref="$monkey[items]"
        itens=( ${!item_ref} )
        for item in ${itens[@]}
        do
            declare -i worry=0
           
            #  Worry Level calculate
            
            operation_ref="$monkey[Operation]"
            operation="${!operation_ref}"
            signal="${operation:10:1}"
            value="${operation:12}"
            [[ $value -eq "old" ]] && value=${item%,}
            worry=$(( (${item%,} $signal $value) / 3 ))
            
            #  Test
            
            test_worry_ref="$monkey[Test]"
            test_worry_value=${!test_worry_ref}
            [[ "$(( $worry % $test_worry_value ))" -eq "0" ]] && destiny_ref="$monkey[true]" || destiny_ref="$monkey[false]"
            monkey_destiny="${!destiny_ref}"

            #  Trow

            monkey_destiny_items_ref="$monkey_destiny[items]"
            monkey_destiny_items="${!monkey_destiny_items_ref}"
            declare -A $monkey_destiny[items]="$monkey_destiny_items $worry"
            
            #  Inspection
            monkey_inspection_ref="$monkey[inspect]"
            monkey_inspection="${!monkey_inspection_ref}"
            declare -A $monkey[inspect]=$(( $monkey_inspection +1))
        
        done
        
        declare -A $monkey[items]=""
    done
done
#---------------------------------First Star----------------------------------#
echo; echo ; echo '--------------------------' ; echo ; echo ;

declare -ia top_inspect=( 0 0 )

for monkey in ${monkeys[@]}
do
    monkey_ref="$monkey[inspect]"
    inspection=${!monkey_ref}

    if [ "$inspection" -gt "${top_inspect[0]}" ]
    then
        if [ "$inspection" -gt "${top_inspect[1]}" ]
        then
            top_inspect[0]=${top_inspect[1]}
            top_inspect[1]=$inspection
        else
            top_inspect[0]=$inspection
        fi
    fi
    
done

echo "First Star: $(( ${top_inspect[0]} * ${top_inspect[1]} )) "

echo; echo ; echo '--------------------------' ; echo ; echo ;
#---------------------------------Second Star---------------------------------#
#------------------------------------Parse------------------------------------#
unset ${monkeys[@]} monkeys

while read -a note
do
    case ${note[0]} in 
        Monkey)
            monkey="monkey_${note[1]%:}"
            monkeys+=("$monkey")
            declare -A "$monkey"


            ;;

        Starting)
            declare -A "$monkey[${note[1]%:}]=${note[*]:2}"

            ;;

        Operation:)
            declare -A "$monkey[${note[0]%:}]=${note[*]:1}"
            ;;

        Test:)
            declare -A "$monkey[${note[0]%:}]=${note[3]}"
            ;;

        If)
            declare -A "$monkey[${note[1]%:}]=monkey_${note[${#note[@]}-1]}"
    esac

done < "$1"

#---------------------------------Calc worry reduction------------------------#

declare -i worry_reduction=1

for monkey in ${monkeys[@]}
do
    monkey_ref="$monkey[Test]"
    worry_factor=${!monkey_ref}
    worry_reduction=$(( worry_reduction * worry_factor ))
done


#-----------------------------------Calc Rounds-------------------------------#
for ((i=0 ; i<$rounds_2 ; i++))
do

    for monkey in ${monkeys[@]}
    do
        #  Get item

        item_ref="$monkey[items]"
        itens=( ${!item_ref} )
        for item in ${itens[@]}
        do
            declare -i worry=0
           
            #  Worry Level calculate
            
            operation_ref="$monkey[Operation]"
            operation="${!operation_ref}"
            signal="${operation:10:1}"
            value="${operation:12}"
            [[ $value -eq "old" ]] && value=${item%,}
            worry=$(( (${item%,} $signal $value) % $worry_reduction ))


            #  Test
            
            test_worry_ref="$monkey[Test]"
            test_worry_value=${!test_worry_ref}
            [[ "$(( $worry % $test_worry_value ))" -eq "0" ]] && destiny_ref="$monkey[true]" || destiny_ref="$monkey[false]"
            monkey_destiny="${!destiny_ref}"

            #  Trow

            monkey_destiny_items_ref="$monkey_destiny[items]"
            monkey_destiny_items="${!monkey_destiny_items_ref}"
            declare -A $monkey_destiny[items]="$monkey_destiny_items $worry"
            
            #  Inspection
            monkey_inspection_ref="$monkey[inspect]"
            monkey_inspection="${!monkey_inspection_ref}"
            declare -A $monkey[inspect]=$(( $monkey_inspection + 1 ))
        
        done
        
        declare -A $monkey[items]=""
    done

    #echo "Round - $i"
    #declare -p ${monkeys[@]} monkeys
done

#-------------------------------Product top two inspect-----------------------#

declare -ia top_inspect=( 0 0 )

for monkey in ${monkeys[@]}
do
    monkey_ref="$monkey[inspect]"
    inspection=${!monkey_ref}

    if [ "$inspection" -gt "${top_inspect[0]}" ]
    then
        if [ "$inspection" -gt "${top_inspect[1]}" ]
        then
            top_inspect[0]=${top_inspect[1]}
            top_inspect[1]=$inspection
        else
            top_inspect[0]=$inspection
        fi
    fi
    
done

echo "Second Star: $(( ${top_inspect[0]} * ${top_inspect[1]} )) "

echo; echo ; echo '--------------------------' ; echo ; echo ;
#-------------------------------------END-------------------------------------#

#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
