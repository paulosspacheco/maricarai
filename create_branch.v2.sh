#!/bin/bash

# Nome da tag que será usada como base para criar a branch
TAG_NAME="$1"


# Verifica se o nome da tag foi fornecido
if [ -z "$TAG_NAME" ]; then
    echo "Erro: O nome da tag deve ser fornecido como argumento."
    exit 1
fi

# Verifica se a branch já existe localmente
if git show-ref --verify --quiet "refs/heads/$TAG_NAME"; then
    echo "A branch '$TAG_NAME' já existe localmente."
    exit 1
fi

# Verifica se a tag existe
if ! git show-ref --verify --quiet "refs/tags/$TAG_NAME"; then
    echo "Erro: A tag '$TAG_NAME' não existe no repositório."
    exit 1
fi

# Cria a nova branch com o nome da tag, usando a tag explicitamente
git checkout -b "$TAG_NAME" "refs/tags/$TAG_NAME"

# Verifica se a branch foi criada com sucesso
if [ $? -ne 0 ]; then
    echo "Erro ao criar a branch com base na tag $TAG_NAME."
    exit 1
fi

# Faz o push da nova branch para o repositório remoto e configura o rastreamento
git push -u origin "$TAG_NAME"

# Mensagem de sucesso
echo "Branch $TAG_NAME criada e enviada com sucesso para o repositório remoto."
