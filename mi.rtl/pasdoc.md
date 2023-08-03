# Comando para gera documento de todos os arquivo .pas da pasta ./units

- O documento deve ter a marca //: ou {: ou (*: para que o comentário entre no documento final.
- [Manual do pasdoc](https://pasdoc.github.io/CommandLine)
- [Linguagem de saída](https://pasdoc.github.io/OutputLanguage)
- [Exemplo de makefile usando pasdoc](https://raw.githubusercontent.com/pasdoc/pasdoc/master/source/autodoc/Makefile)
- [Corregedor ortográfico spell](https://pasdoc.github.io/SpellChecking)
- [Arquivo de configuração do pasdoc](https://pasdoc.github.io/ConfigFileOption)
- [gitHub pasdoc](https://github.com/pasdoc/pasdoc/blob/master/old_docs/pasdoc.tex)
- [Você pode adicionar facilmente uma caixa de pesquisa à sua documentação...](https://pasdoc.github.io/AdvancedFeatures)
- [Referência sobre o script abaixo](https://pasdoc.github.io/CommandlineExamples)

    ```sh
       pasdoc --use-tipue-search --verbosity=6 --auto-link --language=br.utf8 --marker=: --write-uses-list --staronly --markdown --output=./doc  `find ./ -iname '*.pas'`
       
    ```
