#!/bin/bash
example="Uso incorreto. Exemplo de uso: ./make.sh pdf-to-image pdf-to-image-server [on3-proxy]"
[[ $# -lt 2 ]] && echo "$example" && exit 1

repository=$1
ms=$2
profile=$3

if [[ $(whoami) != "ON3" ]]; then
    echo 'EXECUTE ESSE SCRIPT COM O USUÁRIO ON3'
    exit
fi

cd ~ || exit
echo "Baixando o repositório que será excluído ao final desse processo"
rm -rf "$repository"
git clone git@github.com:ON3-Solutions/"$repository".git

echo
echo "Rodando a pré instalação"
echo "Você já rodou o pre-install.sh?"
echo 'Pressione ENTER quando estiver pronto...'
read -r

echo
echo "Rodando o instalador"
if [[ -z "$profile" ]]; then
    "$repository"/"$ms"/scripts/install.sh
else
    "$repository"/"$ms"/scripts/install--"$profile".sh
fi


echo "Excluindo o repositório"
rm -rf "$repository"
