#!/bin/bash

# Texto com as mudanças que estão sendo realizadas neste push.
TextoCommit="$1"

# Verifica se o texto do commit foi passado como argumento
if [ -z "$TextoCommit" ]; then
   echo "Parâmetro deve ser texto diferente de nulo"
   exit 1
fi

# Associa o repositório remoto ao repositório local, se ainda não existir.
if ! git remote | grep -q origin; then
    git remote add origin git@github.com:paulosspacheco/maricarai.git
fi

# Renomeia o branch atual para main (isso pode ser necessário apenas uma vez).
git branch -M main

# Adiciona todas as mudanças no repositório local.
git add .

# Cria um commit com a mensagem fornecida.
git commit -a -m "$TextoCommit"

# Envia as alterações locais para o repositório remoto.
git push -u origin main

# Imprime o status atual do repositório.
git status
