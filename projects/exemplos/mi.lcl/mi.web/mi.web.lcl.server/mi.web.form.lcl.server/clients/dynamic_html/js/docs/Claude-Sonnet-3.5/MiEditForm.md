# MiEditForm

`MiEditForm` é uma classe JavaScript projetada para gerenciar formulários de edição em aplicações web. Esta classe oferece uma ampla gama de funcionalidades para manipulação de dados, interação com o usuário e comunicação com o servidor.

## Características Principais

1. **Importações e Dependências**
   - Utiliza classes e funções auxiliares como `MiConsts`, `MiDialogs`, e `MiThemeDialog`.

2. **Construtor e Inicialização**
   - Inicializa o formulário e configura listeners de eventos.
   - Define uma lista de comandos e ações associadas.

3. **Gerenciamento de Estado**
   - Mantém o estado do formulário (ativo, editando, inserindo).
   - Controla flags como `recordAltered`, `appending`, `bof`, e `eof`.

4. **Manipulação de Dados**
   - Métodos para obter e definir valores de campos do formulário.
   - Implementa operações CRUD (Create, Read, Update, Delete).

5. **Comunicação com o Servidor**
   - Método `sendRequest` para chamadas AJAX.
   - Implementa operações como `locateRecord`, `newRecord`, `addRecord`, `putRecord`, `deleteRecord`.

6. **Navegação de Registros**
   - Métodos para navegar entre registros: `goBof`, `nextRecord`, `prevRecord`, `goEof`.

7. **UI e Interação do Usuário**
   - Atualiza a interface com base no estado atual.
   - Gerencia a habilitação/desabilitação de botões e campos.
   - Implementa diálogos e mensagens para o usuário.

8. **Eventos e Listeners**
   - Configura listeners para eventos de entrada de dados e foco.
   - Gerencia eventos de ações do usuário (CRUD e navegação).

9. **Temas**
   - Funcionalidade para mudar o tema da interface.

10. **Utilitários**
    - Métodos para clonar dados, construir parâmetros de consulta, e lidar com máscaras de entrada.

## Uso

A classe `MiEditForm` é ideal para criar formulários de edição interativos em aplicações web, oferecendo suporte a operações CRUD, navegação de registros e comunicação assíncrona com um servidor backend. Sua estrutura flexível permite a reutilização em diferentes contextos de aplicações web.
