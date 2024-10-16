#!/bin/bash

# Texto com as mudanças que estão sendo realizadas neste push.
TextoCommit="$1"

# Verifica se o texto do commit foi passado como argumento
if [ -z "$TextoCommit" ]; then
   echo "Parâmetro deve ser texto diferente de nulo"
   exit 1
fi

# Nome do repositório GitHub (formato: usuario/repositorio)
REPO_NAME="paulosspacheco/maricarai"

# Verifica se o repositório remoto já está associado e configura a URL se necessário
if git remote get-url origin | grep -q "$REPO_NAME"; then
    echo "Repositório remoto já está configurado corretamente."
else
    git remote remove origin
    git remote add origin git@github.com:$REPO_NAME.git
fi

# Verifica se o branch atual é 'main' e renomeia se necessário
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    git branch -M main
fi

# Atualiza o repositório local com os dados do repositório remoto
git pull

# Verifica se há mudanças a serem commitadas
if git diff-index --quiet HEAD --; then
    echo "Nenhuma alteração a ser commitada"
    exit 0
fi

# Incrementa a versão com base na tag anterior
LAST_TAG=$(git describe --tags $(git rev-list --tags --max-count=1) 2>/dev/null)
if [ -z "$LAST_TAG" ]; then
    NEW_TAG="v0.1.0"
else
    # Extrai os componentes da versão
    IFS='.' read -ra PARTS <<< "${LAST_TAG//v/}"
    MAJOR=${PARTS[0]}
    MINOR=${PARTS[1]}
    PATCH=${PARTS[2]}

    # Incrementa o patch
    PATCH=$((PATCH + 1))

    # Nova tag
    NEW_TAG="v${MAJOR}.${MINOR}.${PATCH}"
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
