# Gera documento .html da pasta ./units/*.pas para a pasta ./doc
#pasdoc --marker=: --markdown --output=./doc `find ./units/ -iname '*.pas'`
#pasdoc @pasdoc.cfg `find ./ -iname '*.pas'`
#pasdoc --language=br.utf8 --auto-link --verbosity=6 --marker=: --staronly --markdown --output=./doc  `find ./ -iname '*.pas'`

find ./ -iname '*.pp' > pasdoc.txt
find ./ -iname '*.pas' >> pasdoc.txt
find ./ -iname '*.lpr' >> pasdoc.txt
find ./ -iname '*.inc' >> pasdoc.txt
#pasdoc --language br.utf8 --spell-check  --format=latex2rtf --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./docs  -S./pasdoc.txt
pasdoc --use-tipue-search --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./docs  -S./pasdoc.txt
#pasdoc --language br.utf8 --spell-check --language en.utf8 --spell-check --use-tipue-search --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./docs  -S./pasdoc.txt





