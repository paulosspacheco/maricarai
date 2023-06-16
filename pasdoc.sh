#!/bin/bash
# Gera documento .html das extenções *.pp, *.pas, *.lpr, *.inc  para a pasta ./doc

find ./ -iname '*.pp' > pasdoc.txt
find ./ -iname '*.pas' >> pasdoc.txt
find ./ -iname '*.lpr' >> pasdoc.txt
find ./ -iname '*.inc' >> pasdoc.txt
#pasdoc --format=latex2rtf --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./doc  -S./pasdoc.txt
#pasdoc --use-tipue-search --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./doc  -S./pasdoc.txt

/home/paulosspacheco/v/FPC_3.3.1/fpc/bin/x86_64-linux/pasdoc --use-tipue-search --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./docs  -S./pasdoc.txt




