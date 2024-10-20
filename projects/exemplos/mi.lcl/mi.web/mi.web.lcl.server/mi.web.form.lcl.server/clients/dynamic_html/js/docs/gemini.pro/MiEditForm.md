## MiEditForm.js

Esta classe é responsável por gerenciar a interação com um formulário HTML e um servidor para operações CRUD, incluindo gerenciamento de estado, interação com o servidor e manipulação de dados.

**Funcionalidades Principais:**

### Inicialização

- **Construtor(formId, keyFields):** 
    - Inicializa uma nova instância da classe `MiEditForm`.
    - `formId`: O ID do formulário HTML a ser gerenciado.
    - `keyFields`: Uma string delimitada por ponto-e-vírgula contendo os nomes dos campos chave do formulário.
    - Configura o formulário, normaliza os IDs e nomes dos campos, aplica máscaras de entrada e inicializa ouvintes de eventos para interações do usuário.
- **init():**
    - Inicializa as propriedades da classe, como estado, dados de trabalho, sinalizadores de controle e estados de ação.
    - Verifica a disponibilidade da API usando `checkApiAvailability()`.
    - Define o formulário como somente leitura inicialmente.

### Gerenciamento de Estado

- **setState(AState, enable):**
    - Define o estado do formulário.
    - `AState`: O estado a ser definido (por exemplo, MiConsts.Mb_St_Insert, MiConsts.Mb_St_Edit).
    - `enable`: Um booleano que indica se o estado deve ser ativado ou desativado.
- **getState(AState):** 
    - Retorna o estado atual do formulário.

### Interação com o Servidor

- **sendRequest(action, queryParams, jsonData, method):** 
    - Envia uma requisição assíncrona ao servidor.
    - `action`: A ação a ser executada no servidor.
    - `queryParams`: Uma string contendo os parâmetros de consulta.
    - `jsonData`: Um objeto contendo os dados a serem enviados no corpo da requisição.
    - `method`: O método HTTP a ser usado (por exemplo, 'GET', 'POST', 'PUT', 'DELETE').
- **checkApiAvailability():**
    - Verifica a disponibilidade do servidor enviando uma requisição 'CmHealthCheck'.

### Manipulação de Dados

- **getFormData():** 
    - Obtém os dados do formulário, incluindo tratamento especial para diferentes tipos de entrada.
- **setFieldValue(fieldName, value):** 
    - Define o valor de um campo específico no formulário.
- **updateForm(data):**
    - Atualiza o formulário com os dados fornecidos.
- **buildQueryParams(keyFields):**
    - Constrói uma string de consulta com base nos campos chave e seus valores no formulário.
- **updateWorkingDataFromServer(serverData):** 
    - Atualiza os dados de trabalho internos com a resposta do servidor.
- **saveWorkingData(), restoreWorkingData(), destroyWorkingData():**
    - Gerenciam as cópias dos dados do formulário para funcionalidade de desfazer/refazer.

### Ações CRUD

- **newRecord():** 
    - Cria um novo registro.
- **addRecord():** 
    - Adiciona um novo registro ao servidor.
- **locateRecord():**
    - Localiza um registro existente com base nos campos chave.
- **PutRecord():**
    - Atualiza um registro existente no servidor.
- **deleteRecord():**
    - Exclui um registro do servidor.

### Navegação de Registros

- **goBof():** 
    - Vai para o primeiro registro.
- **nextRecord():**
    - Vai para o próximo registro.
- **prevRecord():** 
    - Vai para o registro anterior.
- **goEof():** 
    - Vai para o último registro.

### Utilidades

- **showMessage(type, aMsg):**
    - Exibe uma mensagem para o usuário.
- **messageBox(message, title, dialogType, buttons):** 
    - Exibe uma caixa de mensagem com opções configuráveis.
- **alert(message):**
    - Exibe uma mensagem de alerta para o usuário.
- **deepClone(obj):** 
    - Cria uma cópia profunda de um objeto.

### Outros métodos e propriedades

- **normalizeFormIdsAndNames():**
    - Normaliza os IDs e nomes dos campos do formulário para