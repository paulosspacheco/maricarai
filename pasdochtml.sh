#!/bin/bash
# Gera documento .html das extenções *.pp, *.pas, *.lpr, *.inc  para a pasta ./doc

# Pasta onde se encontra a pas ./doc
pathDoc="$1"
echo $pathDoc

if [$pathDoc -eq ""]; then
   echo "Parâmetro deve ser texto diferente de nulo"
   exit
fi

cd $pathDoc

find ./ -iname '*.pp' > pasdoc.txt
find ./ -iname '*.pas' >> pasdoc.txt
find ./ -iname '*.lpr' >> pasdoc.txt
find ./ -iname '*.inc' >> pasdoc.txt
#pasdoc --format=latex2rtf --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./doc  -S./pasdoc.txt
pasdoc --use-tipue-search --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./doc  -S./pasdoc.txt




