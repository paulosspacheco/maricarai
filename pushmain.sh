#!/bin/bash

# Texto com as mudanças que estão sendo realizada neste push.
TextoCommit="$1"

# teste se o parâmetro passado é nulo
if [-z $TextoCommit]; then
echo "Parâmetro deve ser texto diferente de nulo"
exit
fi

# Associa o repositório remoto ao repositório local.          
git remote add origin git@192.168.15.3:/home/git/test.git 

# Renomeie o branch  atual para main
# O comando branch -M não precisa ser feito a todo momento, porque o git sempre envia para
# o ultimo ramo selecionando.
git branch -M main  

# Atualiza o repositório local com os dados do repositório remoto
# git pull esse comando não pode ser automático porque a versão main da nuvem pode estar desatualizada.


# Este comando pode ser executado várias vezes antes de um commit.  
git add .

# Use o <msg> fornecido como a mensagem de confirmação. 
git commit -a -m "$TextoCommit"

# Envia as alterações locais para o repositório remoto.
git push -u origin main                  

# imprime o status atual do repositório
git status  
