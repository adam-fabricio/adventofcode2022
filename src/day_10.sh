#!/bin/bash

# day_10.sh


#-----------------------------------Test input--------------------------------#
test -z "$1" && echo "Erro!"  && exit 1 
#-----------------------------------Variable----------------------------------#
declare -i cicle=0
declare -i reg_x=1
declare -ia sprite=( $[$reg_x-1] $reg_x $[$reg_x+1] )
declare -i signal_strength=0

#-----------------------------------Functions---------------------------------#
function pixel_draw () {
    pixel='.'
    let crt=$1%40
    shift
    for sprite_pixel in $@
    do
        [ "$sprite_pixel" = "$crt" ] && pixel='#' && break
    done
    echo -n "$pixel"
}

#------------------------------------Codes------------------------------------#
echo
while read -a instruction
do
    case "${instruction[0]}" in 
        noop)
            ;;

        addx)
            #  When increment the cicle, it draw a pixel.
            pixel_draw "$cicle" "${sprite[@]}"
            #echo " -> cicle $cicle sprite ( ${sprite[@]} ) reg_x $reg_x" 
            [[ "$cicle%40" -eq "39" ]] && echo
            
            
            let cicle++ 
            [[ "$cicle%40" -eq "20" ]] && signal_strength+=$cicle*$reg_x 
            ;;
    esac
    #  When increment the cicle, it draw a pixel.
    pixel_draw "$cicle" "${sprite[@]}" 
    #echo " -> cicle $cicle sprite ( ${sprite[@]} ) reg_x $reg_x" 
    [[ "$cicle%40" -eq "39" ]] && echo
   
    
    let cicle++
    
    [[ "$cicle%40" -eq "20" ]] && signal_strength+=$cicle*$reg_x
    
    #  When updating the register, it updates the sprite's position
    reg_x+="${instruction[1]}"
    sprite=( $[$reg_x-1] $reg_x $[$reg_x+1] )

done < "$1"
#---------------------------------First Star----------------------------------#
echo
echo
echo "$signal_strength"
#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
echo
#-----------------------------------Results-----------------------------------#
#--------------------------------------|--------------------------------------#
