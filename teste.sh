#!/bin/bash

echo "######### \${parameter:-word} ######"

vazio=
setado="teste"

echo "vazio: ${vazio:-unset}"
echo "setado: ${setado:-unset}"
echo "Não setado: ${nao_setado-unset}"

echo "vazio | setado | não setado"
echo "$vazio | $setado | $nao_setado"

echo "######### \${parameter:=word} ######"

vazio=
setado="teste"

echo "vazio: ${vazio:=DEFAULT}"
echo "setado: ${setado:=DEFAULT}"
#echo "Não setado:${nao_setado:=DEFAULT}"

echo "vazio | setado | não setado"
echo "$vazio | $setado | $nao_setado"

echo "######### \${parameter:?word} ######"

vazio=
setado="teste"

#echo "vazio: ${vazio:?mensagem}"
echo "setado: ${setado:?mensagem}"
#echo "Não setado:${nao_setado:?mensagem}"

echo "vazio | setado | não setado"
echo "$vazio | $setado | $nao_setado"

echo "######### \${parameter:+word} ######"

vazio=
setado="teste"

echo "vazio: ${vazio:+mensagem}"
echo "setado: ${setado:+mensagem}"
echo "Não setado:${nao_setado:+mensagem}"

echo "vazio | setado | não setado"
echo "$vazio | $setado | $nao_setado"

echo
echo
echo "######### \${parameter:+word} ######"
echo
echo

string=01234567890abcdefghi

echo '$string'
echo "$string"

echo '${string:7}' 
echo "${string:7}" 

echo '${string:7:0}'
echo ${string:7:0}

echo '${string:7:2}'
echo ${string:7:2}

echo '${string:7:-2}'
echo ${string:7:-2}

echo '${string:-7}'
echo ${string:-7}

echo '${string:-7:0}'
echo ${string:-7:0}

echo '${string:-7:2}'
echo ${string:-7:2}

echo '${string:-7:-2}'
echo ${string:-7:-2}

echo '${#string}'
echo ${#string}

echo '${string@}'
echo ${!string[@]}
