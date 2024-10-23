# Resumo da Classe `MiEditForm`

A classe `MiEditForm` é responsável por gerenciar a interação de um formulário com um servidor, permitindo operações de CRUD (Criar, Ler, Atualizar, Excluir) e manipulação de dados de entrada. Ela herda de `MiConsts` e utiliza várias classes auxiliares para facilitar a operação.

## Principais Funcionalidades
### 1. **Inicialização**
- **Construtor**: Recebe o ID do formulário e campos-chave, inicializando o formulário e normalizando IDs e nomes dos campos.
- **Máscaras de Formulário**: Aplica máscaras de entrada aos campos do formulário.

### 2. **Gerenciamento de Ações**
- **Classe `Action`**: Representa ações que podem ser habilitadas ou desabilitadas.
- **Lista de Ações**: Define ações como `CmNewRecord`, `CmAddRecord`, `CmPutRecord`, etc., e controla seu estado.

### 3. **Manipulação de Dados**
- **Métodos de CRUD**: Implementa métodos para criar (`newRecord`), adicionar (`addRecord`), atualizar (`PutRecord`), localizar (`locateRecord`) e excluir (`deleteRecord`) registros.
- **Atualização de Dados**: Métodos para atualizar o formulário com dados do servidor (`updateWorkingDataFromServer`).

### 4. **Interação com o Servidor**
- **Requisições Assíncronas**: Utiliza `fetch` para enviar e receber dados do servidor, com tratamento de erros e verificação de status HTTP.
- **Construção de Parâmetros de Consulta**: Gera parâmetros de consulta para requisições baseadas nos campos-chave do formulário.

### 5. **Gerenciamento de Estado**
- **Estados do Formulário**: Controla estados como `Mb_St_Insert`, `Mb_St_Edit`, e `Mb_St_Active` para gerenciar a interação do usuário com o formulário.
- **Habilitação/Desabilitação de Campos**: Métodos para habilitar ou desabilitar campos de entrada e botões com base no estado atual.

### 6. **Eventos e Listeners**
- **Listeners de Entrada**: Adiciona ouvintes de eventos para campos de entrada, permitindo a detecção de alterações e foco.
- **Eventos de Ação**: Gerencia eventos de clique em botões para executar ações correspondentes.

### 7. **Manipulação de Campos**
- **Classe `TField`**: Captura propriedades de elementos de entrada ativos.
- **Métodos para Obter e Definir Valores**: Métodos para obter dados do formulário (`getFormData`) e definir valores em campos específicos (`setFieldValue`).

### 8. **Mensagens e Diálogos**
- **Exibição de Mensagens**: Métodos para mostrar mensagens de erro ou informação ao usuário.
- **Diálogo de Alteração de Tema**: Permite ao usuário alterar o tema da interface.

### 9. **Controle de Navegação**
- **Métodos de Navegação**: Implementa métodos para navegar entre registros (`goBof`, `nextRecord`, `prevRecord`, `goEof`).

## Conclusão
A classe `MiEditForm` é uma implementação robusta para gerenciar formulários em uma aplicação web, facilitando a interação com o servidor e a manipulação de dados de entrada. Ela é projetada para ser extensível e modular, permitindo fácil manutenção e adição de novas funcionalidades.