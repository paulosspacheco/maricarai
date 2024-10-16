# Função javascript  `showMessage`

- Exibe uma mensagem de alerta personalizada ao usuário e aguarda uma ação de confirmação (por exemplo, o clique no botão "OK"). A função utiliza uma promessa para aguardar a interação do usuário antes de continuar a execução.

## Parâmetros

- **type** (opcional, `string`, valor padrão: `'mtInformation'`):  
  - Tipo do alerta a ser exibido. Exemplos de valores incluem `'mtInformation'`, `'mtWarning'`, `'mtError'`, etc.
  
- **aMsg** (`string`):  
  - A mensagem que será exibida no alerta.

## Fluxo de Execução

1. Uma nova instância da classe `Alert` é criada com o tipo especificado pelo parâmetro `type`.
2. A mensagem `aMsg` é exibida utilizando o método `showMessage` da instância `alert`.
3. A função retorna uma `Promise` que aguarda a interação do usuário com o alerta.
   - Se o botão "OK" do alerta for encontrado, um `eventListener` é adicionado para capturar o clique.
   - Se o botão não for encontrado, a promessa é resolvida com a mensagem `'Botão não encontrado'`.
4. Após o clique no botão "OK", o alerta é fechado.

## Retorno

- A função retorna uma `Promise` que é resolvida quando o botão "OK" é clicado, ou com a mensagem `'Botão não encontrado'` em caso de erro.

## Exemplo de Uso

```javascript

    showMessage('mtWarning', 'Este é um alerta de teste.')
        .then((result) => {
            console.log(result); // Exibe a resolução da promessa
        })
        .catch((error) => {
            console.error('Erro ao exibir a mensagem:', error);
        });

```
