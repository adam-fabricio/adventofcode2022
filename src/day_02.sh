#!/bin/bash

#----------------------Verificação de entrada---------------------------------#
if test -z "$1"
then
	echo 'erro'
	exit 1
fi
#----------------------Constantes---------------------------------------------#
pontuacao=0
#----------------------Constantes---------------------------------------------#
declare -A resultado=( 
	["A X"]="4" 
	["A Y"]="8" 
	["A Z"]="3" 
	["B X"]="1" 
	["B Y"]="5" 
	["B Z"]="9" 
	["C X"]="7" 
	["C Y"]="2" 
	["C Z"]="6")

declare -A result_part2=( 
	["A X"]="3" 
	["A Y"]="4" 
	["A Z"]="8" 
	["B X"]="1" 
	["B Y"]="5" 
	["B Z"]="9" 
	["C X"]="2" 
	["C Y"]="6" 
	["C Z"]="7")

#----------------------Codigo-------------------------------------------------#
while read linha 
do
	if test -n "$linha"
	then
		pontuacao=$(( $pontuacao + ${resultado["$linha"]} ))
		second_score=$(( $second_score + ${result_part2["$linha"]} ))
	fi

done < "$1"

echo "first star $pontuacao"
echo "second star $second_score"

#-----------------------------------------------------------------------------#

