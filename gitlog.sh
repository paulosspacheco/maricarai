#!/bin/bash

# Lista o texto usados no commits

# Explicação do Comando:
# git log: Este comando exibe o histórico de commits.
# --pretty=format:"...": Permite formatar a saída do log de acordo com suas necessidades. O que está dentro das aspas define o formato da saída.
# %h: Abreviação do hash do commit (os primeiros caracteres).
# %an: Nome do autor do commit.
# %ar: Data do commit em formato "relativo" (ex: "2 weeks ago").
# %s: Mensagem do commit.

git log --pretty=format:"%h - %an, %ar : %s"