#!/bin/bash

# Verifica se estamos em um diretório Git
if [ ! -d .git ]; then
    echo "Este diretório não é um repositório Git."
    exit 1
fi

# Nome da tag passado como argumento
TAG_NAME="$1"

# Verifica se o nome da tag foi passado como argumento
if [ -z "$TAG_NAME" ]; then
    echo "Parâmetro deve ser o nome da tag."
    exit 1
fi

# Nome do branch será a junção do nome da tag e a palavra "branch"
BRANCH_NAME="${TAG_NAME}-branch"

# Verifica se o branch atual é o mesmo que o branch que queremos deletar
CURRENT_BRANCH=$(git symbolic-ref --short HEAD)
if [ "$CURRENT_BRANCH" == "$BRANCH_NAME" ]; then
    # Muda para o branch main se o branch atual for o mesmo que queremos deletar
    git checkout main
fi

# Verifica se o branch local já existe e o deleta
if git show-ref --verify --quiet refs/heads/"$BRANCH_NAME"; then
    git branch -D "$BRANCH_NAME"
fi

# Cria e muda para o novo branch baseado na tag
git checkout -b "$BRANCH_NAME" "refs/tags/$TAG_NAME"

# Verifica se a criação do branch foi bem-sucedida
if [ $? -ne 0 ]; then
    echo "Erro ao criar a branch com base na tag $TAG_NAME."
    exit 1
fi

# Envia o novo branch para o repositório remoto
git push -u origin "$BRANCH_NAME"

# Verifica se o push foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "Branch $BRANCH_NAME criada e enviada com sucesso para o repositório remoto."
else
    echo "Erro ao enviar a branch $BRANCH_NAME para o repositório remoto."
fi
