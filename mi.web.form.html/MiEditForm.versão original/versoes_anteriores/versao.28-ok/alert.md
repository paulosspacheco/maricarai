# Função `messageBox`

## Descrição

A função `messageBox` exibe uma caixa de diálogo customizável com uma mensagem e botões para interação do usuário. O título, o tipo do diálogo e os botões são configuráveis. A função aguarda a ação do usuário e retorna o botão pressionado como resultado.

## Parâmetros

- **message** (string): A mensagem que será exibida na caixa de diálogo.
- **title** (string, opcional): O título da caixa de diálogo. O valor padrão é `'Alerta'`.
- **dialogType** (string, opcional): O tipo de diálogo que define o estilo do alerta. O valor padrão é `'mtInformation'`.
- **buttons** (array, opcional): Um array de strings que define os botões a serem exibidos. O valor padrão é `['mbOK']`.

## Fluxo de Execução

1. A função cria uma instância da classe `Alert`, que controla o estilo e a interação do alerta. Os parâmetros `dialogType` e `buttons` são passados para a instância.

2. A mensagem e o título são configurados usando os elementos HTML correspondentes da instância `alert`.

3. Uma promessa é criada e pendente até que o usuário interaja com a caixa de diálogo pressionando um dos botões.

4. Para cada botão especificado, é adicionado um ouvinte de evento de clique que:
   - Armazena o botão pressionado na variável `result`.
   - Fecha a caixa de diálogo chamando `alert.close()`.
   - Resolve a promessa com o botão pressionado.
5. Após a resolução da promessa, a função garante o fechamento da caixa de diálogo removendo o overlay e retornando o botão pressionado.

## Retorno

- A função retorna uma promessa que é resolvida com o botão pressionado pelo usuário.

## Exemplo de Uso

```javascript

    const result = await messageBox('Deseja continuar?', 'Confirmação', 'mtWarning', ['mbYes','mbNo']);
    if (result === 'mbYes') {
        console.log('O usuário deseja continuar.');
    } else {
        console.log('O usuário cancelou a ação.');
    }
```
