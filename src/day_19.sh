#!/usr/bin/env bash
#
#  day_19.sh
#
#---------------------------------Start Date----------------------------------#
#
#    1697465275 -> 16/10/23 11:07:55
#
#----------------------------------Data input---------------------------------#
if [[ "$1" == test ]]
then
    data_input="data/day_19_test"
    echo Use test data input
else
    data_input="data/day_19"
    echo "use source data input"
fi
#------------------------------Função: imprime_lista--------------------------#

imprime_lista() {
	local -n lista="$1"
	echo "imprimindo lista:"
	for chave in "${!lista[@]}"; do
		echo "$chave -> ${lista[$chave]}"
	done
}

#------------------------------Função: maior_valor----------------------------#

maior_valor() {
	#Função para encontrar o maior valor em uma lista
	if [[ $# -lt 1 ]]; then
		echo "Erro: Nenhuma lista de valores."
		return 1
	fi
		
	#  transforma a lista em um item por linha e envia a saida para ->
	#  sort que ordena de forma numerica e decrescente ->
	#  imprime a primeira linha
	printf "%s\n" "$@" | sort --numeric-sort --reverse | head --line 1
}

#------------------------------Função calcula_qualidade-----------------------#
calcula_qualidade() {
	local -n planta_local="$1"
	local -i tempo_limite="$2"
	local -i tempo=1

	#  Cria carteira
	local -A carteira
	carteira["ore"]=0
	carteira["clay"]=0
	carteira["obsidian"]=0
	carteira["geode"]=0

	#  Cria robos
	local -A robos
	robos["ore"]=1
	robos["clay"]=0
	robos["obsidian"]=0
	robos["geode"]=0

	nome_robos=( "ore" "clay" "obsidian" "geode" )

	for ((tempo = 1; $tempo <= $tempo_limite; tempo++)); do
		#  coleta de recurso
		for robo in "${nome_robos[@]}"; do
			carteira["$robo"]=$((carteira["$robo"] + robos["$robo"]))
		done
	done

	echo "${carteira[@]}"
}


#----------------------------------Variaveis----------------------------------#
declare -A planta
declare -a nivel_qualidade
declare -i tempo

#------------------------------------Main-------------------------------------#

while read -a line; do
	#  Da entrada gera as variaveis
	
	planta["id"]="${line[1]//:/}"
	planta["ore_robot"]="${line[6]}"
	planta["clay_robot"]="${line[12]}"
	planta["obsidian_robot"]="${line[18]} ${line[21]}"
	planta["geode_robot"]="${line[27]} ${line[30]}"

	#  Máximo de cada robo.
	planta["max_ore_robot"]=$(maior_valor "${planta["ore_robot"]}"\
	   "${planta["clay_robot"]}" "${planta["obsidian_robot"]%% *}"\
	   "${planta["geode_robot"]%% *}")
	planta["max_clay_robot"]="${planta["obsidian_robot"]#* }"
	planta["max_obsidian_robot"]="${planta["geode_robot"]#* }"

	tempo=24
	
	imprime_lista "planta"

	# nivel_qualidade["$id"]=$( calcula_qualidade "planta" "$tempo" )
	calcula_qualidade "planta" "tempo" 

	echo "Nivel de Qualidade: ${nivel_qualidade["$id"]} "

done < "$data_input"

#--------------------------------------|--------------------------------------#
