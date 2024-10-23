# Resumo do Código JavaScript `MiEditForm.js`

## Introdução
Este código define uma classe `MiEditForm` que gerencia a interação de um formulário com um servidor, permitindo operações CRUD (Criar, Ler, Atualizar, Deletar) e a manipulação de campos de entrada.

## Estruturas Principais

### Classes
- **Action**: Representa uma ação com um nome e um estado (habilitado/desabilitado).
- **TField**: Captura as propriedades de um elemento ativo do DOM, como `tagName`, `id`, `name`, `value`, etc.
- **MiEditForm**: Classe principal que estende `MiConsts` e gerencia a lógica do formulário.

## Principais Métodos
- **Construtor**: Inicializa o formulário e normaliza os IDs e nomes dos campos.
- **init()**: Configura estados iniciais e verifica a disponibilidade da API.
- **clearForm()**: Limpa todos os campos do formulário.
- **redraw()**: Atualiza o estado dos botões e controles do formulário.
- **checkApiAvailability()**: Verifica se a API do servidor está disponível.
- **setStateAction(command, enable)**: Habilita ou desabilita ações baseadas em comandos.
- **setInputFieldsDisabled(adisabled)**: Habilita ou desabilita todos os campos de entrada.
- **getFormData()**: Coleta e retorna os dados do formulário em um objeto.
- **sendRequest(action, queryParams, jsonData, method)**: Envia uma requisição para o servidor.
- **updateWorkingDataFromServer(serverData)**: Atualiza os dados do formulário com a resposta do servidor.
- **handleAction(action)**: Manipula ações específicas baseadas em eventos de clique.

## Operações CRUD
- **newRecord()**: Cria um novo registro.
- **addRecord()**: Adiciona um registro ao servidor.
- **PutRecord()**: Atualiza um registro existente.
- **deleteRecord()**: Deleta um registro do servidor.
- **locateRecord()**: Localiza um registro específico.

## Navegação
- **goBof()**: Vai para o primeiro registro.
- **nextRecord()**: Navega para o próximo registro.
- **prevRecord()**: Navega para o registro anterior.
- **goEof()**: Vai para o último registro.

## Manipulação de Eventos
- **initInputListeners()**: Adiciona ouvintes de eventos a campos de entrada.
- **initEventListeners()**: Configura ouvintes de eventos para botões de ação.

## Mensagens e Diálogos
- **showMessage(type, aMsg)**: Exibe uma mensagem ao usuário.
- **alert(message)**: Exibe um alerta ao usuário.

## Considerações Finais
A classe `MiEditForm` oferece uma interface robusta para interação com formulários HTML, permitindo a manipulação de dados e a comunicação com um servidor backend de forma eficiente. A estrutura modular e o uso de métodos claros facilitam a manutenção e a extensão da funcionalidade.