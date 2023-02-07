#!/bin/bash

# day_07.sh

#-----------------------------------Test input--------------------------------#

test -z "$1" && echo "Erro!"  && exit 1 

#-----------------------------------Variable----------------------------------#

declare -A folder
declare current_folder
declare -a line
declare -a list_folder
candidate_folder=
candidate_folder_needed=
candidate_folder_space=70000000

#-----------------------------------Functions---------------------------------#

change_folder() {
    command=( ${1} )
    if [[ "$1" == ".." ]]
    then
        current_folder=$(sed 's/\/[a-z A-Z]*$//' <<< "$current_folder" )
        [[ -z $current_folder ]] && current_folder="/"
    else
        if [[ -z "$current_folder" ]]
        then
            current_folder=$1
        elif [[ "$current_folder" == "/" ]]
        then
            current_folder="$current_folder$1"
        else
            current_folder="$current_folder/$1"
        fi
    folder["$current_folder"]= 
    fi
}


calc_folder_size() {
    local temp_folder=$current_folder
    while : 
    do
        let folder["$temp_folder"]+="${1}"
        [[ "$temp_folder" == "/" ]] && break
        temp_folder=$(sed 's/\/[a-z A-Z]*$//' <<< "$temp_folder" )
        [[ -z "$temp_folder" ]] && temp_folder='/'
    done

}

#------------------------------------Codes------------------------------------#

while read -a line
do
    if [[ "${line[0]}" == "\$" ]]
    then
        if [[ "${line[1]}" == "cd" ]]
        then
            change_folder "${line[2]}" 
        else
            :
        fi
    elif [[ "${line[0]}" == [0-9]* ]]
    then
        calc_folder_size "${line[0]}"
    fi
done < "$1"


let space_needed=${folder['/']}-40000000
#---------------------------------First Star----------------------------------#

for i in "${!folder[@]}"
do
    [[ "${folder[$i]}" -le "100000" ]] && let sum_folder+=${folder[$i]}
    if [[ "${folder[$i]}" -ge "$space_needed" ]]
    then
        if [[ "${folder[$i]}" -lt "$candidate_folder_space" ]]
        then
            candidate_folder=$i
            candidate_folder_space=${folder[$i]}
        fi
    fi
    
done

#---------------------------------Second Star---------------------------------#
#-------------------------------------END-------------------------------------#
#-----------------------------------Results-----------------------------------#
echo "First Star -> $sum_folder"
echo "Seconde Star -> $candidate_folder_space"
#--------------------------------------|--------------------------------------#
