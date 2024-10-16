#!/bin/bash

# Texto com as mudanças que estão sendo realizadas neste push.
TextoCommit="$1"

# Verifica se o texto do commit foi passado como argumento
if [ -z "$TextoCommit" ]; then
   echo "Parâmetro deve ser texto diferente de nulo"
   exit 1
fi

# Tipo de versão (pode ser alterado para "beta", "release", etc.)
VERSION_TYPE="Alpha"

# Nome do repositório GitHub (formato: usuario/repositorio)
REPO_NAME="paulosspacheco/maricarai"

# Verifica se o repositório remoto já está associado
if ! git remote | grep -q origin; then
    git remote add origin git@github.com:$REPO_NAME.git
fi


# Atualiza o repositório local com os dados do repositório remoto
git pull

# Verifica se há mudanças a serem commitadas
if git diff-index --quiet HEAD --; then
    echo "Nenhuma alteração a ser commitada"
    exit 0
fi

# Define a versão inicial
INITIAL_VERSION="v1.9.0-$VERSION_TYPE"

# Incrementa a versão com base na tag anterior
# Aqui garantimos que só peguemos as tags que seguem o padrão esperado.
LAST_TAG=$(git tag --sort=-v:refname | grep -E "^v[0-9]+\.[0-9]+\.[0-9]+-$VERSION_TYPE$" | head -n 1)

if [ -z "$LAST_TAG" ]; then
    NEW_TAG="$INITIAL_VERSION"
else
    # Extrai os componentes da versão
    IFS='.' read -ra PARTS <<< "${LAST_TAG//v/}"
    MAJOR=${PARTS[0]}
    MINOR=${PARTS[1]}
    PATCH=${PARTS[2]%-*}  # Remove qualquer sufixo da tag (como -Alpha)

    # Incrementa o patch
    PATCH=$((PATCH + 1))

    # Nova tag
    NEW_TAG="v${MAJOR}.${MINOR}.${PATCH}-$VERSION_TYPE"
fi

# Exibe as informações sobre o que será feito
echo "Criando a versão: $NEW_TAG"
echo "Mensagem do commit: $TextoCommit"

# Adiciona todas as mudanças ao commit
git add .

# Cria o commit com a mensagem passada
git commit -m "$TextoCommit"

# Cria a nova tag
git tag "$NEW_TAG"

# Envia as alterações e a nova tag para o repositório remoto
git push origin main
git push origin "$NEW_TAG"

# Imprime o status atual do repositório
git status

# Mensagem de sucesso
echo "Versão $NEW_TAG publicada com sucesso no repositório $REPO_NAME."
