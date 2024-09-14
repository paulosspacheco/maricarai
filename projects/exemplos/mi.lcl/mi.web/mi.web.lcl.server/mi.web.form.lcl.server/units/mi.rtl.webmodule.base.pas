unit mi.rtl.webmodule.base;
{:< A unit **@name** implementa a classe TMi_rtl_WebModule_base.

  - **NOTAS**:
    - A classe  TMi_rtl_WebModule implementa a Interfaces  IMi_rtl_WebModule:

      ```pascal
        IMi_rtl_WebModule = Interface ['{88DB8A8D-5926-4F55-9740-FC66E19455C4}']
          Function Locate(const aKeyFields: string; const aKeyValues: Variant; Options: TLocateOptions):boolean;overload;
        end;

      ```
}
{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes, ActnList,httpdefs, fpHTTP, fpWeb, DB,fpJson,Variants
  ,mi.rtl.all
  ,uMiConnectionsDb
  ,Mi_SQLQuery

  ,mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;



type
  {: A classe **@name** foi criada para /??}
  TParamOnLocate = class(TPersistent)
//    published property KeyFields: string; KeyValues : Array:
  end;


type
  {:A interface **@name** publica o métodoTMi_rtl_WebModule_base publico que podem ser acessados via
    protocolo restapi
  }
  IMi_rtl_WebModule = Interface ['{88DB8A8D-5926-4F55-9740-FC66E19455C4}']

    {:O método **@name executa o método  CmNewRecordExecute(self);

      - **NOTAS**
        - URL Exemplo:

          ```html

             curl -X GET "http://LocalHost:8080/Tmi_rtl_web_module/CmNewRecord"

          ```
    }
    procedure CmNewRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    {:O método **@name localiza um registro com as chaves passada pelos
      parâmetros aRequest.

      - URL EXEMPLO

        ```html

           curl -X GET \
           "http://localhost:8080/tmi_rtl_web_module/Cmlocate?KeyFields=id&KeyValues=1&Options=loCaseInsensitive"

           curl -X GET \
           "http://LocalHost:8080/Tmi_rtl_web_module/Cmlocate?KeyFields=nome&KeyValues=Paulo&Options=loCaseInsensitive,loPartialKey"
        ```

      - **PASSO A PASSO**
        1. Extraia os parâmetros da query string

           ```pascal

              KeyFields    := ARequest.QueryFields.Values['KeyFields'];
              KeyValuesStr := ARequest.QueryFields.Values['KeyValues'];
              OptionsStr   := ARequest.QueryFields.Values['Options'];

           ```

        2. Executa o método self.Locate(KeyFields, KeyValues, Options);
          - Testa se o registro foi localizado:
            - Se sim:
              - Retorna para o cliente todos os campos do dataset:

                 ```pascal

                   aResponse.Content := DmxScroller_Form1.JSONObject.AsJson;

                 ```

            - Se não:
              - Retorna o json com o erro:
                ```pascal

                    ResponseJSON.Add('status', 'error');
                    ResponseJSON.Add('message', 'Record not found');
                    AResponse.Content := ResponseJSON.AsJSON;

                ```

    }
    procedure CmlocateRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** processar requisições HTTP do tipo `POST`, onde o conteúdo
      enviado é um JSON representando um novo registro a ser adicionado ao sistema.
      Ele trata a lógica de criar o registro, obtendo os campos e valores das chaves,
      e retorna uma resposta JSON indicando o sucesso ou falha da operação.

      - **Parâmetros Locais**
        - **Sender**: `TObject` - Objeto que dispara o evento.
        - **ARequest**: `TRequest` - Representa a requisição HTTP recebida pelo servidor.
        - **AResponse**: `TResponse` - Representa a resposta HTTP que será enviada ao cliente.
        - **Handled**: `Boolean` - Define se o processamento da requisição foi concluído com sucesso.

        - **KeyFields**: `string` - Campos-chave do registro.
        - **KeyValues**: `Variant` - Valores correspondentes aos campos-chave.
        - **s**: `String` - String temporária usada para armazenar o conteúdo da resposta JSON.
        - **_ok_Set_Server_Http**: `Boolean` - Flag para armazenar o estado do servidor HTTP.
        - **ValueArray**: `TJSONArray` - Array JSON que armazena os valores das chaves, caso `KeyValues` seja um array.

      - **Subrotina Local: Post**
        - Esta subrotina executa a lógica principal para adicionar um novo registro
          no sistema, manipulando o conteúdo JSON e retornando uma resposta ao cliente.
          - **i**: `integer` - Índice para iteração.
          - **LBound**: `integer` - Limite inferior do array `KeyValues`.
          - **UBound**: `integer` - Limite superior do array `KeyValues`.

      - **Fluxo de Execução**
        1. O método começa verificando e configurando o estado HTTP através da variável `_ok_Set_Server_Http`.
        2. Em seguida, verifica se o método HTTP utilizado é `POST` e se o `ContentType` da requisição é `application/json`.
        3. Se ambas as verificações forem bem-sucedidas, a subrotina `Post` é chamada para processar o registro.
           - Dentro de `Post`, o conteúdo da requisição é analisado e um novo registro é criado.
           - Os campos e valores das chaves são obtidos e retornados ao cliente no formato JSON.
        4. Se o conteúdo ou o método HTTP não forem adequados, a resposta é configurada para retornar um código de erro adequado (`400` ou `405`).
        5. Em caso de exceção durante o processamento, uma mensagem de erro é retornada ao cliente com o código `500` (Erro Interno do Servidor).
        6. Após o processamento, o estado do servidor HTTP é restaurado.

      - **Exceções**
        - **400 - Bad Request**: Retornado se o conteúdo enviado não for JSON.
        - **405 - Method Not Allowed**: Retornado se o método HTTP for diferente de `POST`.
        - **500 - Internal Server Error**: Retornado em caso de exceção durante o processamento da requisição.

      - **Ver Também**
        - `TRequest`
        - `TResponse`
        - `TJSONArray`
        - `DmxScroller_Form1.getFieldsKeys`
        - `DoOnNewRecord`
        - `VarArrayLowBound`
        - `VarArrayHighBound`

      - URL de chamada para o método post

        ```sh

          curl -X POST "http://localhost:8080/Tmi_rtl_web_module/CmAddRecord" \
          -H "Content-Type: application/json"\
          -d '{"id":"0","nome": "Paulo Pacheco"}'

        ```
    }
    procedure CmAddRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** processa uma requisição HTTP `PUT`, localiza um registro
      na base de dados usando os campos de consulta (query fields) e atualiza o
      registro com o conteúdo da requisição. Se o registro for localizado e
      atualizado com sucesso, uma resposta JSON com o status de sucesso é retornada.
      Caso contrário, são geradas mensagens de erro correspondentes.

      - **Parâmetros Locais**
        - `KeyFields`: Campos de chave para localizar o registro.
        - `KeyValues`: Valores das chaves usados para a localização.
        - `Options`: Opções de localização utilizadas no método `Locate`.
        - `_ok_Set_Server_Http`: Booleano para controlar o estado do servidor HTTP.
        - `Sender`: Objeto que dispara o evento.
        - `ARequest`: Objeto que contém os dados da requisição HTTP.
        - `AResponse`: Objeto que será usado para enviar a resposta ao cliente.
        - `Handled`: Booleano que indica se a requisição foi processada.

      - **Fluxo de Execução**
        1. **Validação da Requisição**: O método verifica se a requisição é do tipo `PUT` e se o conteúdo é do tipo `application/json`. Caso contrário, uma exceção é lançada e uma resposta de erro é enviada.

        2. **Localização do Registro**:
           - Se os campos de consulta estiverem presentes, o método chama `GetQueryFieldsLocate` para preencher `KeyFields` e `KeyValues`.
           - O método `Locate` é chamado para encontrar o registro.

        3. **Atualização do Registro**:
           - Se o registro for encontrado, o conteúdo JSON da requisição é processado e o método `UpdateRec` é chamado para atualizar o registro.
           - Em caso de sucesso, uma resposta com código `200` (OK) e uma mensagem de sucesso são retornadas.
           - Se a atualização falhar, uma exceção é lançada com código `400` (Bad Request).

        4. **Tratamento de Erros**:
           - Se o registro não for encontrado ou houver algum problema na atualização, o método gera uma exceção e retorna a mensagem de erro apropriada.
           - Em caso de exceção, uma resposta com código `500` (Internal Server Error) é enviada ao cliente.

     - **Exceções**
       - `Invalid Content-Type`: Lançada se o conteúdo da requisição não for do tipo
         `application/json`.
       - `Invalid HTTP method`: Lançada se a requisição não for `POST` ou `PUT`.
       - `Query fields are required to locate the record`: Lançada se não houver
          campos de consulta na requisição.
       - `Tentativa de atualizar um registro inexistente`: Lançada se o registro
          não for encontrado no banco de dados.
       - `Depois preciso captura o relatório de erro`: Lançada se houver um problema
          ao atualizar o registro.

      - **Ver Também**
        - `TRequest`
        - `TResponse`
        - `TJSONObject`
        - `Locate`
        - `UpdateRec`

      - **URL para o método PUT**

        ```sh

           curl -X PUT \
          "http://LocalHost:8080/Tmi_rtl_web_module/CmPutRecord?KeyFields=id&KeyValues=38&Options=loCaseInsensitive" \
          -H "Content-Type: application/json" \
          -d '{"id":"38", "nome": "Ana Cristina"}'

        ```
    }
    procedure CmPutRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** é responsável por processar requisições HTTP do tipo
      DELETE, localizando um registro e removendo-o do banco de dados, caso
      encontrado. Se a operação for bem-sucedida, a resposta retornará o status
      HTTP 200 (OK). Em caso de erro durante a exclusão, ou se o registro não
      for encontrado, o método retornará códigos de erro HTTP apropriados,
      como 500 (Erro Interno do Servidor) ou 404 (Registro não encontrado).

      - **Parâmetros Locais**
        - **`Sender: TObject`**: Objeto que dispara o evento.
        - **`ARequest: TRequest`**: Objeto que contém as informações da requisição
          HTTP.
        - **`AResponse: TResponse`**: Objeto utilizado para enviar a resposta HTTP.
        - **`Handled: Boolean`**: Variável que indica se a requisição foi
          processada (valor final `True`).

      - **Fluxo de Execução**
        1. **Inicialização**:
            - O método começa ativando o modo de servidor HTTP (`Set_ok_Set_Server_Http`).
            - Um objeto JSON é criado para preparar a resposta da operação.

        2. **Localizar Registro**:
            - A função `Locate(ARequest)` é chamada para verificar se o registro
              foi encontrado baseado nos dados fornecidos na requisição.

        3. **Excluir Registro**:
            - Se o registro for encontrado, o método tenta excluí-lo com
              `DmxScroller_Form1.DeleteRec`.
            - Caso a exclusão seja bem-sucedida:
              - Retorna o código HTTP 200 (OK) com uma resposta JSON apropriada.
            - Se ocorrer um erro na exclusão:
              - Retorna o código HTTP 500 (Erro Interno do Servidor) com uma
                mensagem de erro no formato JSON.

        4. **Registro Não Encontrado**:
            - Se o registro não for localizado:
              - Retorna o código HTTP 404 (Registro Não Encontrado) com uma
                mensagem JSON.

        5. **Finalização**:
            - O objeto JSON é liberado da memória.
            - O método encerra marcando `Handled` como `True` para indicar que a
              requisição foi tratada.
            - O estado de `Set_ok_Set_Server_Http` é restaurado para seu valor
              original.

        ## Exceções
        - **Erro 404**: Ocorre se o registro solicitado não for encontrado.
        - **Erro 500**: Ocorre em caso de falha na exclusão do registro.

        ## Ver Também
        - `Locate(ARequest)`: Método utilizado para localizar o registro baseado na requisição.
        - `DmxScroller_Form1.DeleteRec`: Método chamado para excluir o registro localizado.

    }
    procedure CmDeleteRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** trata uma requisição HTTP no formato `JSON` para
      posicionar um formulário no primeiro registro de uma base de dados. Caso o
      formulário esteja vazio, retorna uma mensagem de erro. A resposta será
      enviada no formato `JSON`, e o código de status HTTP será ajustado conforme
      o resultado da operação.

      - **Parâmetros:**
        - **Sender**: Objeto que invocou o evento.
        - **ARequest**: Objeto que contém os dados da requisição HTTP recebida.
        - **AResponse**: Objeto onde será montada a resposta HTTP.
        - **Handled**: Indica se a requisição foi processada pelo método.

      - **Fluxo de Execução:**
        1. O método inicializa uma variável `ResponseJSON` do tipo `TJSONObject`
           para criar o objeto que conterá a resposta em `JSON`.
        2. Define o tipo de conteúdo da resposta como `application/json`.
        3. Posiciona o formulário no primeiro registro:
           - Se for bem-sucedido, retorna o conteúdo do registro atual no formato
             `JSON` e define o código de resposta HTTP como `200 (OK)`.
           - Se não houver registros, retorna um objeto `JSON` com uma mensagem
             de erro e define o código de resposta HTTP como `404 (Not Found)`.
        4. Libera o objeto `ResponseJSON` ao final do processamento para evitar
           vazamentos de memória.
        5. Define a variável `Handled` como `True`, indicando que a requisição
           foi processada.
        6. Restaura o estado do servidor HTTP usando o método `Set_ok_Set_Server_Http`.

      - **Exemplo de Uso:**
        - A requisição `HTTP GET` para o servidor pode ser feita da seguinte forma:

          ```html

             curl -X GET "http://localhost:8080/tmi_rtl_web_module/CmGoBof"

          ```
    }
    procedure CmGoBofRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** é utilizado para processar uma requisição HTTP do tipo
      "NextRecord" em um `TWebModule`. Ele responde com o próximo registro
      disponível em formato JSON, ou uma mensagem de erro se não houver mais
      registros.

      - **Parâmetros Locais**
        - **Sender**: Objeto que acionou o evento.
        - **ARequest**: Instância de `TRequest`, contém os dados da requisição HTTP.
        - **AResponse**: Instância de `TResponse`, usada para enviar a resposta HTTP.
        - **Handled**: Booleano que indica se a requisição foi tratada. É definido como `True` ao final da execução.

      - **Fluxo de Execução**
        1. Define a variável `_ok_Set_Server_Http` para preservar o estado do
           servidor HTTP.
        2. Cria um objeto JSON (`ResponseJSON`) para construir a resposta HTTP.
        3. Define o tipo de conteúdo da resposta como `application/json`.
        4. Chama o método `NextRec` para avançar para o próximo registro:
           - Se houver um próximo registro, retorna o conteúdo do registro atual
             em formato JSON com código HTTP 200 (OK).
           - Caso contrário, retorna uma mensagem de erro com código HTTP 404
             (Not Found).
        5. Libera o objeto `ResponseJSON` da memória.
        6. Define `Handled` como `True` para indicar que a requisição foi
           processada.
        7. Restaura o estado do servidor HTTP usando `Set_ok_Set_Server_Http`.

      - **Exceções**
        - O método pode gerar exceções relacionadas à manipulação de JSON ou
          falha ao acessar registros, mas estas não são tratadas explicitamente
          no código.

      - **Ver Também**
        - `TWebModule`
        - `TRequest`
        - `TResponse`
        - `DmxScroller_Form1`

      - **Exemplo de Uso:**
        - A requisição `HTTP GET` para o servidor pode ser feita da seguinte forma:

          ```html

             curl -X GET "http://localhost:8080/tmi_rtl_web_module/CmNextRecord?KeyFields=id&KeyValues=8&Options=loCaseInsensitive"

          ```
    }
    procedure CmNextRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** é utilizado para tratar requisições HTTP que navegam para
      o registro anterior em um dataset. Ele retorna o registro atual em formato JSON,
      ou uma mensagem de erro caso o dataset esteja vazio.

      - **Parâmetros Locais**
        - **Sender**: Objeto que dispara o evento.
        - **ARequest**: Instância da requisição HTTP recebida.
        - **AResponse**: Instância da resposta HTTP que será enviada.
        - **Handled**: Booleano que indica se a requisição foi processada.

      - **Fluxo de Execução**
        1. O método inicia ativando o estado de comunicação com o servidor HTTP
           através do método `Set_ok_Set_Server_Http`.
        2. Um objeto JSON é criado para compor a resposta.
        3. O tipo de conteúdo da resposta é definido como `application/json`.
        4. Tenta-se navegar para o registro anterior do dataset utilizando o método
           `PrevRec` do componente `DmxScroller_Form1`.
           - Se houver um registro anterior:
             - O conteúdo do registro atual é retornado em formato JSON com o
               código HTTP `200 OK`.
           - Caso contrário:
             - Uma mensagem de erro com status `404 Not Found` é retornada,
               indicando que o arquivo está vazio.
        5. O objeto JSON é liberado e a variável `Handled` é marcada como `True`,
           indicando que a requisição foi tratada.
        6. O estado anterior de comunicação HTTP é restaurado.

      - **Exceções**
        - Nenhuma exceção explícita é tratada nesse método.

      - **Ver Também**
        - `TRequest`
        - `TResponse`
        - `DmxScroller_Form1.PrevRec`
        - `DmxScroller_Form1.JSONObject`

      - **Exemplo de Uso:**
        - A requisição `HTTP GET` para o servidor pode ser feita da seguinte forma:

          ```html

             curl -X GET "http://localhost:8080/tmi_rtl_web_module/CmPrevRecord?KeyFields=id&KeyValues=8&Options=loCaseInsensitive"

          ```
    }
    procedure CmPrevRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);

    {:O método **@name** processa uma requisição HTTP GET para buscar o último
      registro de um formulário, retornando os dados no formato JSON. Se o formulário
      não contiver registros, retorna uma mensagem de erro com código HTTP 404.

      - **Parâmetros Locais**
        - `ResponseJSON`: Objeto do tipo `TJSONObject` usado para construir a
           resposta JSON.
        - `_ok_Set_Server_Http`: Variável booleana que armazena o estado anterior
          do servidor HTTP.

      - **Parâmetros**
        - `Sender`: O objeto que disparou o evento.
        - `ARequest`: Objeto contendo a requisição HTTP.
        - `AResponse`: Objeto para enviar a resposta HTTP.
        - `Handled`: Booleano que indica se a requisição foi processada.

      - **Fluxo de Execução**
        1. O estado do servidor HTTP é alterado para `true` temporariamente através
           do método `Set_ok_Set_Server_Http`.
        2. Um objeto JSON (`ResponseJSON`) é inicializado para construir a resposta.
        3. O tipo de conteúdo da resposta é definido como `application/json`.
        4. Se o formulário (`DmxScroller_Form1`) contiver registros, o método:
           - Posiciona no último registro.
           - Retorna os dados no formato JSON do registro atual com código HTTP `200`.
        5. Caso contrário, uma mensagem de erro JSON é retornada, com o código
           HTTP `404`.
        6. O objeto `ResponseJSON` é liberado ao final da execução.
        7. O estado do servidor HTTP é restaurado para o valor anterior.
        8. A variável `Handled` é definida como `True`, indicando que a requisição
           foi processada.

      - **Exceções**
        - Não há tratamento explícito de exceções no método.

      - **Ver Também**
        - `DmxScroller_Form1.Set_ok_Set_Server_Http`
        - `DmxScroller_Form1.LastRec`
        - `TJSONObject`

      - **Exemplo de Uso:**
        - A requisição `HTTP GET` para o servidor pode ser feita da seguinte forma:

          ```html

             curl -X GET "http://localhost:8080/tmi_rtl_web_module/CmGoEof"

          ```
    }
    procedure CmGoEofRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
  end;


  { TMi_rtl_WebModule_base }
  {:A classe **@name** é usada para concentrar as regras de negócio e que as
    mesmas possam ser expostas na web.
     - **REFERÊNCIAS**
       - [fcl-web](https://wiki.freepascal.org/fcl-web)
  }
  TMi_rtl_WebModule_base = class(TFPWebModule,IMi_rtl_WebModule)

    {:A ação **@name** executa o método .Locate()

      - **NOTAS**
        - Abre uma caixa de diálogo com o campo focado para localizar
          o registro desejado.
      - **RETORNO**
        - True
          - Se o registo foi localisado;
        - False
          - Se o registro não foi localisado.

      - A FAZER:
        - Pensar como criar um caixa de dialogo em qualquer interface visual
          da aplicação atual.
          - O método Locate() executa:
            - DmxScroller_Form1.Locate();
              - Mi_rtl_ui_Form.Locate
                - TMi_rtl_ui_Form_abstract
                  - TMi_lcl_ui_Form_attributes
                    - TMi_rtl.Locate
                      - TMi_rtl.InputBox
                        - O formulário será criado por aplicação LCL
                  - TMi_Web_ui_Form_attributes
                    - TMi_rtl.InputBox
                      - O formulário será criado por aplicação cliente lcl
                      - O formulário será criado por aplicação cliente html
                  - Obs:
                    - O Locate está implementado em:
                      - TMi_rtl.Locate
                        - InputBox
                          - O formulário será criado por aplicação web
                            - A parte mais complexa é criar o cliente que se
                              comunique com o servidor via http.
    }
    published CmLocate: TAction;
    procedure CmAddRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    procedure CmPutRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    procedure DmxScroller_Form1ExitField(aField: pDmxFieldRec);
    procedure EnterFieldRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnAfterInsert(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnBeforeInsertRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnBeforeUpdateRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnCalcFieldRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnChangeFieldRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnEnterFieldRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
    procedure OnExitFieldRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);

    {:A ação **@name** executa o método   DmxScroller_Form1.DoOnNewRecord;
    }
    published CmNewRecord: TAction;

    published CmGoBof: TAction;
    published CmGoEof: TAction;

    published CmNextRecord: TAction;
    published CmPrevRecord: TAction;
    published CmRefresh: TAction;
    published CmUpdateRecord: TAction;
    published DmxScroller_Form1: TDmxScroller_Form;
    published Mi_SQLQuery1: TMi_SQLQuery;
    published ActionList1: TActionList;

    {:A ação **name** executa o método DmxScroller_Form1.Cancel; }
    published CmCancel: TAction;

    {:A ação **name** executa o método DmxScroller_Form1.DeleteRec);
    }
    published CmDeleteRecord: TAction;

    published CmBuildFormFromTemplate: TAction;

    published procedure CmBuildFormFromTemplateExecute(Sender: TObject);

    {: O método **@name** da ação CmNewRecord executa o método
       DmxScroller_Form1.DoOnNewRecord;
    }
    published procedure CmNewRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmLocate executa o método DmxScroller_Form1.Locate;

       - **Nota**:
         - Locate criar um formulário de pesquisa baseado no que está selecionado na edição.
    }
    published procedure CmLocateExecute(Sender: TObject);

    {: O método **@name** da ação CmUpdateRecord executa o método
       DmxScroller_Form1.UpdateRec;
    }
    published procedure CmUpdateRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmDeleteRecord executa o método
       DmxScroller_Form1.DeleteRec;
    }
    published procedure CmDeleteRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmGoBof executa o método
       DmxScroller_Form1.FirstRec;
    }
    published procedure CmGoBofExecute(Sender: TObject);

    {: O método **@name** da ação CmNextRecord executa o método
       DmxScroller_Form1.NextRec;
    }
    published procedure CmNextRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmPrevRecord executa o método
       DmxScroller_Form1.PrevRec;}
    published procedure CmPrevRecordExecute(Sender: TObject);

    {: O método **@name** da ação CmGoEof executa o método
       DmxScroller_Form1.LastRec;
    }
    published procedure CmGoEofExecute(Sender: TObject);

    {: O método **@name** da ação CmRefresh executa o método
    DmxScrol    public constructor Create(AOwner: TComponent); override;ler_Form1.Refresh;}
    published procedure CmRefreshExecute(Sender: TObject);

    {: O método **@name** da ação CmCancel executa o método
       DmxScroller_Form1.Cancel;
    }
    published procedure CmCancelExecute(Sender: TObject);

    {: O método **name** cria o módulo de dados dos componentes sqldb (SQLConnector1
       e SQLTransaction1 para que possa ser usado pelo componente Mi_SQLQuery1 e
       DmxScroller_Form1
    }
    published procedure DataModuleCreate(Sender: TObject);

    {: O método **name** faz com qua a propriedade seja active := false; antes de
       de destruir o modulo de dados.
    }
    published procedure DataModuleDestroy(Sender: TObject);

    //IMPLEMENTAÇÃO DOS EVENTOS QUE PODEM SER ACESSADOS PELO CLIENTE
    {$REGION '--> Métodos publicados na web'}
      published procedure CmNewRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
      published procedure CmlocateRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
//      published procedure CmUpdateRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
      published procedure CmDeleteRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
      published procedure CmGoBofRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
      published procedure CmNextRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
      published procedure CmPrevRecordRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
      published procedure CmGoEofRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    {$ENDREGION '--> Métodos publicados na web'}

    {$Region Propriedade active}
      //*** Daqui para baixo foram criado manualmente e não foram criado pela IDE.***

      {: O atributo **name** contéem uma instância do módulo de dados TMiConnectionsDb
         criada no método DataModuleCreate.
      }
      protected var MiConnectionsDb : TMiConnectionsDb;

      private Function GetActive : Boolean;
      private procedure SetActive(a_active : Boolean);

      {: A propriedade **@name** é usado para ativar e desativa o datamodule }
      public property active : Boolean  read GetActive write SetActive;

    {$EndRegion Propriedade state}

    {$Region Propriedade state}
      private function Get_State : TDataSetState ;
      {: A propriedade **@name** é usado para saber o estado da tabela}
      public property State : TDataSetState  read Get_State;
    {$EndRegion Propriedade state}

    {: O método **@name** executa uma caixa de diálogo de pesquisa com os dados
       do campo corrente.
    }
    public function Locate(): TModalResult;overload;

    {:O método **@name** localiza um registro baseado nos campos passados por
       aKeyFields e valores dos campos aKeyValues.

       - **PARÂMETROS**
          - aKeyFields
             - Contém a lista de campos que pertence a chave primária
               - **EXEMPLOS**:
                 - **Chave simples**:
                   - 'Matricula'.

                 - **Chave composta**:
                   - 'Estado,Cidade'.
          - aKeyValues
            - Contém um array de variantes do valor da chave.

              ```pascal

                  procedure LocateMyRecord;
                  var
                    aCityID, aCountryID: integer;
                  begin
                    if Locate('city_id;country_id', VarArrayOf([aCityID, aCountryID]), []) then
                    begin
                      DoSomething;
                    end;
                  end;
              ```
       - **REFERÊNCIAS**
         - [wiki.freepascal.org](https://wiki.freepascal.org/locate#:~:text=locate%20looks%20for%20a%20record,semicolon%2Dseparated%20list%20of%20fields.)
    }
    public Function Locate(const aKeyFields: string; const aKeyValues: Variant; aOptions: TLocateOptions):boolean;overload;

    {:O método **@name**  é utilizado para localizar um registro em um `DataSet`
      de acordo com os parâmetros fornecidos por uma requisição HTTP (`ARequest`).
      Ele utiliza os campos e valores chave da requisição para realizar a busca no
      `DataSet` associado ao formulário `DmxScroller_Form1`.


      - **PASSO A PASSO**
        1. Extraia os parâmetros da query string

           ```pascal

               KeyFields    := ARequest.QueryFields.Values['KeyFields'];
               KeyValuesStr := ARequest.QueryFields.Values['KeyValues'];
               OptionsStr   := ARequest.QueryFields.Values['Options'];

           ```

        2. Executa o método self.Locate(KeyFields, KeyValues, Options);
           - Testa se o registro foi localizado:
             - Se sim:
               - Retorna true
             - Se não:
               - Retorna false;

      - **Exemplo de uso**

        ```pascal
           var
             ARequest: TRequest;
             Found: Boolean;
           begin
             // Supondo que ARequest contenha a consulta necessária
             Found := WebModule.locate(ARequest);

             if Found then
               WriteLn('Registro encontrado.')
             else
               WriteLn('Registro não encontrado.');
           end;
        ```
    }
    protected function locate(ARequest: TRequest):Boolean;overload;

  end;




implementation

{$R *.lfm}

{ TMi_rtl_WebModule_base }

procedure TMi_rtl_WebModule_base.CmBuildFormFromTemplateExecute(Sender: TObject);
begin
  with DmxScroller_Form1 do
  begin
    //DoBuildFormFromTemplate(TEnClientsApplication.en_app_lcl);
    //DoBuildFormFromTemplate(TEnClientsApplication.en_app_javascript);
    //DoBuildFormFromTemplate(TEnClientsApplication.en_app_dynamic_html);
    //DoBuildFormFromTemplate(TEnClientsApplication.en_app_vuejs);
    //DoBuildFormFromTemplate(TEnClientsApplication.en_app_angularjs);
    //DoBuildFormFromTemplate(TEnClientsApplication.en_app_reactjs);
    ShowMessage('Formulários para as aplicações clientes foram criados.');
  end;

end;

procedure TMi_rtl_WebModule_base.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

function TMi_rtl_WebModule_base.Locate(): TModalResult;
begin
  result := DmxScroller_Form1.Locate();
end;

function TMi_rtl_WebModule_base.Locate(const aKeyFields: string;
                                  const aKeyValues: Variant;
                                  aOptions: TLocateOptions): boolean;
begin
  result := DmxScroller_Form1.Locate(aKeyFields,aKeyValues,aOptions);
end;

function TMi_rtl_WebModule_base.locate(ARequest: TRequest): Boolean;
  var
    KeyFields: string;
    KeyValues: Variant;
    Options   : TLocateOptions;
begin
  With DmxScroller_Form1 do
    GetQueryFieldsLocate(aRequest,KeyFields,KeyValues,Options );
  // Executa o Locate no DataSet
  result := DmxScroller_Form1.Locate(KeyFields, KeyValues, Options);
end;

function TMi_rtl_WebModule_base.GetActive: Boolean;
begin
  Result := Mi_SQLQuery1.Active and DmxScroller_Form1.Active;
end;

procedure TMi_rtl_WebModule_base.SetActive(a_active: Boolean);
begin
  if a_active
  Then begin
         if not MiConnectionsDb.Connection
         then MiConnectionsDb.Connection := true;

         if MiConnectionsDb.Connection
         Then begin
                Mi_SQLQuery1.SetConnection(MiConnectionsDb.SQLConnector1,DmxScroller_Form1);

                DmxScroller_Form1.DoOnNewRecord_FillChar:=true;
              end
         else raise DmxScroller_Form1.TException.Create(self,{$I %CURRENTROUTINE%},'Banco de dados não conectado!');
       end
  else begin
         if MiConnectionsDb.Connection
         Then Mi_SQLQuery1.SetConnection(nil,DmxScroller_Form1);
       end;
end;

function TMi_rtl_WebModule_base.Get_State: TDataSetState;
begin
  result := Mi_SQLQuery1.DataSource.DataSet.State;
end;

procedure TMi_rtl_WebModule_base.CmLocateExecute(Sender: TObject);
begin
  if Locate() = MrNo
  Then TMi_rtl.ShowMessage('Registro não localizado!');
end;

procedure TMi_rtl_WebModule_base.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.UpdateRec;
end;

procedure TMi_rtl_WebModule_base.CmDeleteRecordExecute(Sender: TObject);
begin
  with DmxScroller_Form1 do
   if MessageBox('Confirma a exclusão do registro?',TMi_MsgBox.mtConfirmation,TMi_MsgBox.mbYesNo,TMi_MsgBox.mbyes) = TMi_MsgBox.mrYes
   Then If not DmxScroller_Form1.DeleteRec
        Then ShowMessage('Erro ao excluir o registro!');
end;

procedure TMi_rtl_WebModule_base.CmGoBofExecute(Sender: TObject);
begin
  DmxScroller_Form1.FirstRec;
end;

procedure TMi_rtl_WebModule_base.CmNextRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.NextRec;
end;

procedure TMi_rtl_WebModule_base.CmPrevRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.PrevRec;
end;

procedure TMi_rtl_WebModule_base.CmGoEofExecute(Sender: TObject);
begin
   DmxScroller_Form1.LastRec;
end;

procedure TMi_rtl_WebModule_base.CmRefreshExecute(Sender: TObject);
begin
  DmxScroller_Form1.Refresh;
end;

procedure TMi_rtl_WebModule_base.CmCancelExecute(Sender: TObject);
begin
  DmxScroller_Form1.Cancel;
end;

procedure TMi_rtl_WebModule_base.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(Self);
  MiConnectionsDb := TMiConnectionsDb.Create(self);
  if not MiConnectionsDb.Connection
  then MiConnectionsDb.Connection := true;
  if MiConnectionsDb.Connection
  then begin
         active := false;
         if Not Assigned(DmxScroller_Form1.Mi_ActionList)
         Then DmxScroller_Form1.Mi_ActionList := ActionList1;
       end
  else raise DmxScroller_Form1.TException.Create(self,{$I %CURRENTROUTINE%},'Banco de dados não conectado!');
end;

procedure TMi_rtl_WebModule_base.DataModuleDestroy(Sender: TObject);
begin
  active := false;
end;

{$REGION '--> Métodos publicados na web'}

  procedure TMi_rtl_WebModule_base.CmNewRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    Var
      ResponseJSON: TJSONObject=nil;
      _ok_Set_Server_Http:Boolean=false;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    try
      // Inicialize o objeto JSON para a resposta
      ResponseJSON := TJSONObject.Create;

      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      try
        // Executa o Locate no DataSet
        CmNewRecordExecute(self);
        // Prepare a resposta JSON baseada no resultado do Locate
        AResponse.Content := DmxScroller_Form1.JSONObject.AsJson;
        AResponse.Code := 202;  //202 Accepted: A solicitação foi aceita para processamento, mas o processamento ainda não foi concluído.

      Except
        On E : Exception do
        begin
          ResponseJSON.Add('status', 'error');
          ResponseJSON.Add('message', {$I %CURRENTROUTINE%}+E.Message);
          AResponse.Content := ResponseJSON.AsJSON;
          AResponse.Code := 500 //Internal Server Error: O servidor encontrou uma condição inesperada que o impediu de atender à solicitação.
        end;
      end;

    finally
      if Assigned(ResponseJSON)
      Then FreeAndNil(ResponseJSON);
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.CmlocateRequest(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    var
      ResponseJSON: TJSONObject;
      _ok_Set_Server_Http:Boolean;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    // Inicialize o objeto JSON para a resposta
    ResponseJSON := TJSONObject.Create;
    try
      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      // Prepare a resposta JSON baseada no resultado do Locate
      if Locate(ARequest) then
      begin
        AResponse.Content := DmxScroller_Form1.JSONObject.AsJson;
        AResponse.Code := 200;  // HTTP OK
      end
      else
      begin
        ResponseJSON.Add('status', 'error');
        ResponseJSON.Add('message', 'Registro não localizado!');
        AResponse.Content := ResponseJSON.AsJSON;
        AResponse.Code := 404;  // HTTP Not Found
      end;

    finally
      ResponseJSON.Free;  // Libere o objeto JSON
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.CmAddRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    var
      KeyFields: string;
      KeyValues: Variant;
      //Options   : TLocateOptions;
      s:String;
      _ok_Set_Server_Http:Boolean;
      ValueArray: TJSONArray;

      procedure Post;
         var i,LBound,UBound : integer;
      begin
        With DmxScroller_Form1 do
        begin
          Try
//              DoOnEnter(DmxScroller_Form1);
            // Implementa a lógica para criar um novo registro
            DoOnNewRecord;
            s := ARequest.Content;
            JSONObject  := TJSONObject(GetJSON(ARequest.Content));
            If UpdateRec
            Then begin
              // Obtém os campos e valores das chaves
              KeyFields := DmxScroller_Form1.getFieldsKeys(KeyValues);

              // Verifica se KeyValues é um array
              if VarIsArray(KeyValues) then
              begin
                // Cria um array JSON para os valores das chaves
                ValueArray := TJSONArray.Create;
                try
                  // Pega os limites do array variante
                  LBound := VarArrayLowBound(KeyValues, 1);
                  UBound := VarArrayHighBound(KeyValues, 1);
                  // Itera sobre o array variante e adiciona ao array JSON
                  for i := LBound to UBound do
                    ValueArray.Add(VarToStr(KeyValues[i]));

                  s:= Format(
                            '{"status":"sucesso","mensagem":"Registro adicionado com sucesso.","keyFields":"%s","keyValues":%s}',
                            [KeyFields, ValueArray.AsJSON]  // Use AsJSON para gerar a string correta
                          );

                  AResponse.Content := s;
                finally
                  ValueArray.Free;
                end;
              end
              else
              begin
                // KeyValues é um valor único
                AResponse.Content := Format(
                  '{"status":"sucesso","mensagem":"Registro adicionado com sucesso.","keyFields":"%s","keyValues":"%s"}',
                  [KeyFields, VarToStr(KeyValues)]
                );
              end;

              AResponse.Code := 201;  // Created: A solicitação foi bem-sucedida e um novo recurso foi criado.
            end
            else begin
                   AResponse.Code := 400;  // Bad Request
                   raise Exception.Create('Depois preciso captura o relatório de erro.');
                 end;
          finally
//              DoOnExit(DmxScroller_Form1);
          end;
        end;
      end;

  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    try
      // Verifica se a requisição é POST ou PUT
      AResponse.ContentType := 'application/json';
      if SameText(ARequest.Method, 'POST') then
      begin
        // Verifica se o conteúdo é JSON
        if ARequest.ContentType = 'application/json' then
        begin
          Post;
        end
        else
        begin
          AResponse.Code := 400;  // Bad Request
          raise Exception.Create('Invalid Content-Type. Expected application/json.');
        end;
      end
      else
      begin
        AResponse.Code := 405;  // Method Not Allowed
        raise Exception.Create('Invalid HTTP method. Expected POST or PUT.');
      end;
      Handled := True;
    except
      on E: Exception do
      begin
        AResponse.ContentType := 'application/json';
        AResponse.Content := Format('{"status":"error","message":"%s"}', [E.Message]);
        AResponse.Code := 500;  // Internal Server Error
        Handled := True;
      end;
    end;

    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.CmPutRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    var
      KeyFields: string;
      KeyValues: Variant;
      Options   : TLocateOptions;
      //s:String;
      _ok_Set_Server_Http:Boolean;

      procedure Put;
        Var
          S:String;
      begin
        // Usa os query fields para localizar o registro
        if ARequest.QueryFields.Count > 0 then
        With DmxScroller_Form1 do
        begin
          GetQueryFieldsLocate(aRequest,KeyFields,KeyValues,Options );
          if Locate(KeyFields,KeyValues,Options )
          then begin
                 try
                   DmxScroller_Form1.DoOnEnter();
                   s:= GetJSON(ARequest.Content).AsJSON;
                   JSONObject  := TJSONObject(GetJSON(ARequest.Content));
                   If UpdateRec
                   Then begin
                          AResponse.Code := 200;  // OK (Registro atualizado com sucesso)
                          AResponse.Content := '{"status":"sucesso","mensagem":"Registro atualizado com sucesso."}';
                        end
                   else begin
                          AResponse.Code := 400;  // Bad Request
                          raise Exception.Create('Depois preciso captura o relatório de erro.');
                        end;
                 finally
                   DmxScroller_Form1.DoOnExit();
                 end;
               end
          else begin
                 AResponse.Code := 400;  // Bad Request
                 raise Exception.Create('Tentativa de atualizar um registro inexistente.');
               end;
        end
        else begin
               AResponse.Code := 400;  // Bad Request
               raise Exception.Create('Query fields are required to locate the record.');
             end;
      end;
   begin
     _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
     try
       // Verifica se a requisição é POST ou PUT
       AResponse.ContentType := 'application/json';
       if SameText(ARequest.Method, 'PUT') then
       begin
         // Verifica se o conteúdo é JSON
         if ARequest.ContentType = 'application/json' then
         begin
           PUT;
         end
         else
         begin
           AResponse.Code := 400;  // Bad Request
           raise Exception.Create('Invalid Content-Type. Expected application/json.');
         end;
       end
       else
       begin
         AResponse.Code := 405;  // Method Not Allowed
         raise Exception.Create('Invalid HTTP method. Expected POST or PUT.');
       end;

       Handled := True;
     except
       on E: Exception do
       begin
         AResponse.ContentType := 'application/json';
         AResponse.Content := Format('{"status":"error","message":"%s"}', [E.Message]);
         AResponse.Code := 500;  // Internal Server Error
         Handled := True;
       end;
     end;

     DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
   end;

  procedure TMi_rtl_WebModule_base.DmxScroller_Form1ExitField(aField: pDmxFieldRec
    );
  begin

  end;

  procedure TMi_rtl_WebModule_base.EnterFieldRequest(Sender: TObject;
    ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;

  procedure TMi_rtl_WebModule_base.OnAfterInsert(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;


  procedure TMi_rtl_WebModule_base.OnBeforeInsertRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;
  procedure TMi_rtl_WebModule_base.OnBeforeUpdateRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;


  procedure TMi_rtl_WebModule_base.OnCalcFieldRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;

  procedure TMi_rtl_WebModule_base.OnChangeFieldRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;

  procedure TMi_rtl_WebModule_base.CmDeleteRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    var
      ResponseJSON: TJSONObject=nil;
      _ok_Set_Server_Http:Boolean;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    // Inicialize o objeto JSON para a resposta
    ResponseJSON := TJSONObject.Create;
    try
      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      // Prepare a resposta JSON baseada no resultado do Locate
      if Locate(ARequest) then
      begin
        If DmxScroller_Form1.DeleteRec
        then begin
               AResponse.Content := ResponseJSON.AsJSON;
               AResponse.Code := 200;  // HTTP OK
             end
        else begin
               DmxScroller_Form1.MessageError;
               ResponseJSON.Add('status', 'error');
               ResponseJSON.Add('message', '??');
               AResponse.Content := ResponseJSON.AsJSON;
               AResponse.Code := 500; //Internal Server Error: O servidor encontrou uma condição inesperada que o impediu de atender à solicitação.
             end;
      end
      else
      begin
        ResponseJSON.Add('status', 'error');
        ResponseJSON.Add('message', 'Registro não localizado!');
        AResponse.Content := ResponseJSON.AsJSON;
        AResponse.Code := 404;  // HTTP Not Found
      end;

    finally
      ResponseJSON.Free;  // Libere o objeto JSON
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.CmGoBofRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    var
      ResponseJSON: TJSONObject=nil;
      _ok_Set_Server_Http:Boolean;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    // Inicialize o objeto JSON para a resposta
    ResponseJSON := TJSONObject.Create;
    try
      DmxScroller_Form1.DoOnEnter();

      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      // Posiciona no primeiro registro
      if DmxScroller_Form1.FirstRec then
      begin

        //retorna o registro atual
        AResponse.Content := DmxScroller_Form1.JSONObject.AsJson;
        AResponse.Code := 200;  // HTTP OK
      end
      else
      begin
        ResponseJSON.Add('status', 'error');
        ResponseJSON.Add('message', 'Não pode posicionar no inicio do arquivo.');
        AResponse.Content := ResponseJSON.AsJSON;
        AResponse.Code := 404;  // HTTP Not Found
      end;

    finally
      DmxScroller_Form1.DoOnExit();
      ResponseJSON.Free;  // Libere o objeto JSON
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);

  end;

  procedure TMi_rtl_WebModule_base.CmNextRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    var
      ResponseJSON: TJSONObject=nil;
      _ok_Set_Server_Http:Boolean;
      ok : Boolean;
      R,C:Integer;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    // Inicialize o objeto JSON para a resposta
    ResponseJSON := TJSONObject.Create;
    try
      DmxScroller_Form1.DoOnEnter();
      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      ok := Locate(ARequest);

      // Localisa e posiciona no próximo
      if  ok and
          DmxScroller_Form1.NextRec
      then begin
             //retorna o registro atual
             AResponse.Content := DmxScroller_Form1.JSONObject.AsJson;
             AResponse.Code := 200;  // HTTP OK
           end
      else begin
             ResponseJSON.Add('status', 'eof');
             ResponseJSON.Add('message', 'Fim do arquivo');
             AResponse.Content := ResponseJSON.AsJSON;
             AResponse.Code := 404;  // HTTP Not Found
           end;

    finally
      DmxScroller_Form1.DoOnExit();
      ResponseJSON.Free;  // Libere o objeto JSON
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.CmPrevRecordRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
    var
      ResponseJSON: TJSONObject=nil;
      _ok_Set_Server_Http:Boolean;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    // Inicialize o objeto JSON para a resposta
    ResponseJSON := TJSONObject.Create;
    try
      DmxScroller_Form1.DoOnEnter();
      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      // Localisa e posiciona no anterior
      if Locate(ARequest) and
         DmxScroller_Form1.PrevRec
      then begin
             //retorna o registro atual
             AResponse.Content := DmxScroller_Form1.JSONObject.AsJson;
             AResponse.Code := 200;  // HTTP OK
           end
      else begin
             ResponseJSON.Add('status', 'bof');
             ResponseJSON.Add('message', 'Inicio do arquivo');
             AResponse.Content := ResponseJSON.AsJSON;
             AResponse.Code := 404;  // HTTP Not Found
           end;

    finally
      DmxScroller_Form1.DoOnExit();
      ResponseJSON.Free;  // Libere o objeto JSON
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.CmGoEofRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    var
      ResponseJSON: TJSONObject=nil;
      _ok_Set_Server_Http:Boolean;
      s:string;
  begin
    _ok_Set_Server_Http := DmxScroller_Form1.Set_ok_Set_Server_Http(true);
    // Inicialize o objeto JSON para a resposta
    ResponseJSON := TJSONObject.Create;
    try
      DmxScroller_Form1.DoOnEnter();
      // Define o tipo de conteúdo como JSON
      AResponse.ContentType := 'application/json';

      // Posiciona no primeiro registro
      if DmxScroller_Form1.LastRec then
      begin
        //retorna o registro atual
        //s := DmxScroller_Form1.JSONObject.AsJson;
        AResponse.Content := DmxScroller_Form1.JSONObject.AsJson;
        AResponse.Code := 200;  // HTTP OK
      end
      else
      begin
        ResponseJSON.Add('status', 'error');
        ResponseJSON.Add('message', 'Não pode posicionar no fim do arquivo');
        AResponse.Content := ResponseJSON.AsJSON;
        AResponse.Code := 404;  // HTTP Not Found
      end;

    finally
      DmxScroller_Form1.DoOnExit();
      ResponseJSON.Free;  // Libere o objeto JSON
    end;

    Handled := True;  // Indica que a requisição foi processada
    DmxScroller_Form1.Set_ok_Set_Server_Http(_ok_Set_Server_Http);
  end;

  procedure TMi_rtl_WebModule_base.OnEnterFieldRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;

  procedure TMi_rtl_WebModule_base.OnExitFieldRequest(Sender: TObject;ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  begin

  end;


{$ENDREGION '--> Métodos publicados na web'}

// As duas linhas abaixo precisa ser implementada nas classes filhas de TMi_rtl_WebModule_base
//initialization
//  RegisterHTTPModule('TMi_rtl_WebModule_base', TMi_rtl_WebModule_base);

end.



//type
   //TOnLocateRequest         = function(const aKeyFields: string; const aKeyValues: Variant; aOptions: TLocateOptions):boolean of Object unimplemented;
   //TOnCmGoBofRequest        = procedure(Sender: TObject);
   //TOnCmEofRequest          = procedure(Sender: TObject);
   //TOnCmNewRecordRequest    = procedure(Sender: TObject);
   //TOnCmUpdateRecordRequest = procedure (Sender: TObject);
   //TOnCmDeleteRecordRequest = procedure (Sender: TObject);
   //TOnCmCancelRequest       = procedure (Sender: TObject);
   //TonCmRefreshRequest      = procedure (Sender: TObject);
//{$REGION '--> Property OnLocateRequest'}
//  protected _OnLocateRequest : TOnLocateRequest;
//  {: O evento **@name** é disparado pelo locateRequest passando os campos
//     aKeyFields e aKeyValues recebidos do cliente.
//
//     - **NOTAS**
//       - Este evento é usado caso se queira fazer um pesquisar diferente do
//         padrão, ou seja, o padrão é executar o método TDataSet.Locate passando
//         uma lista de campos pertecentes a chaves separados por (;) e uma matriz
//         variante com o valor dos campos.
//       - Os parâmetros passados em onLocate são obtidos em locateRequest.
//
//     - **PARÂMETROS**
//       - - aKeyFields
//          - Contém a lista de campos que pertence a chave primária.
//       - aKeyValues
//         - Contém um array de variantes do valor da chave.
//  }
//  published Property onLocateRequest : TOnLocateRequest
//                     Read _OnLocateRequest
//                     write _onLocateRequest;
//{$ENDREGION '<-- Property OnLocateRequest'}
//
//{$REGION '--> Property cmGoBofRequest'}
//  protected _OncmGoBofRequest : TOncmGoBofRequest;
//  {: O evento **@name** é disparado pelo cmGoBofRequestRequest.
//  }
//  published Property onCmGoBofRequest : TOncmGoBofRequest
//                     Read _OncmGoBofRequest
//                     write _oncmGoBofRequest;
//{$ENDREGION '<-- Property cmGoBofRequest'}
//
//{$REGION '--> Property OnCmGoEofRequest'}
//  protected _OnCmGoEofRequest : TOnCmGoEofRequest;
//  {: O evento **@name** é disparado pelo OnCmGoEofRequest.
//  }
//  published Property onCmGoEofRequest : TOnCmGoEofRequest
//                     Read _OnCmGoEofRequest
//                     write _onCmGoEofRequest;
//{$ENDREGION '<-- Property OnGoEofRequest'}
//
//{$REGION '--> Property CmNewRecord'}
//  protected _OnCmNewRecord : TOnCmNewRecord;
//  {: O evento **@name** é disparado pelo CmNewRecordRequest.
//  }
//  published Property onCmNewRecord : TOnCmNewRecord Read _OnCmNewRecord write _onCmNewRecord;
//{$ENDREGION '<-- Property CmNewRecord'}
//
//{$REGION '--> Property CmUpdateRecord'}
//  protected _OnCmUpdateRecord : TOnCmUpdateRecord;
//  {: O evento **@name** é disparado pelo CmUpdateRecordRequest.
//  }
//  published Property onCmUpdateRecord : TOnCmUpdateRecord Read _OnCmUpdateRecord write _onCmUpdateRecord;
//{$ENDREGION '<-- Property CmUpdateRecord'}
//
//{$REGION '--> Property CmDelete'}
//  protected _OnCmDelete : TOnCmDelete;
//  {: O evento **@name** é disparado pelo CmDeleteRequest.
//  }
//  published Property onCmDelete : TOnCmDelete Read _OnCmDelete write _onCmDelete;
//{$ENDREGION '<-- Property CmDelete'}
//
//{$REGION '--> Property CmCancel'}
//  protected _OnCmCancel : TOnCmCancel;
//  {: O evento **@name** é disparado pelo CmCancelRequest.
//  }
//  published Property onCmCancel : TOnCmCancel Read _OnCmCancel write _onCmCancel;
//{$ENDREGION '<-- Property CmCancel'}
//
//{$REGION '--> Property onCmRefresh'}
//  protected _OnonCmRefresh : TOnonCmRefresh;
//  {: O evento **@name** é disparado pelo onCmRefreshRequest.
//  }
//  published Property ononCmRefresh : TOnonCmRefresh Read _OnonCmRefresh write _ononCmRefresh;
//{$ENDREGION '<-- Property onCmRefresh'}
//

