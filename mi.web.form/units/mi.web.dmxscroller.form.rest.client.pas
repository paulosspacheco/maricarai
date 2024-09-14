unit mi.web.dmxscroller.form.rest.client;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources,fpJson,db,Variants
  ,mi_rtl_ui_dmxscroller
  ,mi_rtl_ui_dmxscroller_form
  ,mi.web.fphttpclient;

Type
  TEnumNavigator = (EnGoBof,EnNextRecord,EnPrevRecord,EnGoEof);
type


  { TDmxScroller_Form_Rest_Client }

  TDmxScroller_Form_Rest_Client = class(TDmxScroller_Form)
    {:O flag **@name** é usado para evitar que chamada internat chame o servidor
      quando o mesmo está atualizando o buffer local.
    }
    Private _Lock : Boolean ;

    public constructor Create(aOwner:TComponent);Override;
    {$REGION '--->Construção da propriedade Mi_FpHttpClient'}
      private _Mi_FpHttpClient: TMi_FpHttpClient;
      {:A propiedade **@name** usanda para fazer requisições http ao servidor

        - **EXEMPLO**
          ```pascal
          ```
      }
      published property Mi_FpHttpClient: TMi_FpHttpClient Read _Mi_FpHttpClient write _Mi_FpHttpClient;
    {$ENDREGION '--->Construção da propriedade Mi_FpHttpClient'}

    {:O método **@name** é responsável por criar um novo registro através de uma
      requisição HTTP GET, utilizando o cliente `Mi_FpHttpClient`. Caso a requisição
      seja bem-sucedida, o novo registro é processado e atribuído ao formulário
      para edição.

      - **Fluxo de Execução**
        1. Envia uma requisição HTTP do tipo GET com o comando `CmNewRecord`.
        2. Se a resposta for recebida (`Response` for atribuído), chama o método
           herdado `DoOnNewRecord` e armazena a resposta em `JSONObject`.
        3. Libera a memória de `Response` no final, se alocado.

      - **Parâmetros Locais**
        - `Response: TJSONObject`:
          -Objeto JSON que contém a resposta da requisição HTTP.

        - **Exceções**
          - Caso o envio da requisição ou o processamento do JSON falhe, uma exceção
            pode ser levantada pelo método `SendRequest` ou pela manipulação de
            objetos.

        - **Ver Também**
          - `Mi_FpHttpClient.SendRequest`
          - `inherited DoOnNewRecord`


        - **Exemplo de uso**

          ```pascal

            var
              RestClient: TDmxScroller_Form_Rest_Client;
            begin
              // Inicializando o cliente REST
              RestClient := TDmxScroller_Form_Rest_Client.Create(nil);
              try
                // Chama o método para criar um novo registro
                RestClient.DoOnNewRecord;

                // Agora o JSON com o novo registro estará disponível para edição
                // Processar o JSONObject conforme necessário
                if Assigned(RestClient.JSONObject) then
                  ShowMessage('Novo registro criado com sucesso.');

              finally
                RestClient.Free;
              end;
            end;

          ```


    }
    public Procedure DoOnNewRecord;reintroduce;

    {:O método **@name** adiciona o buffer DataSource.dataSet no arquivo.

      - **Descrição**
        - O método `AddRec` tem a função de adicionar um novo registro à base de
          dados remota, utilizando a funcionalidade REST do cliente HTTP. Se um
          registro estiver selecionado e o estado for de adição (`Appending`),
          ele envia os dados do registro para o servidor via requisição HTTP POST.
          Após a confirmação da resposta, o método atualiza a chave primária do
          registro e realiza uma busca pelo novo registro, utilizando as chaves
          atualizadas.

      - **Parâmetros Locais**
        - **Params**: `TJSONObject`
          - Objeto JSON contendo os parâmetros da requisição.
        - **KeyFields**: `string`
          - Campos-chave do registro.
        - **KeyValues**: `Variant`
          - Valores dos campos-chave.
        - **Response**: `TJSONObject`
          - Objeto JSON contendo a resposta da requisição HTTP.

      - **Fluxo de Execução**
        1. Verifica se há um registro selecionado com `RecordSelected`.
        2. Caso o registro esteja sendo adicionado (`Appending`), realiza a adição
           chamando `Inherited AddRec`.
        3. Envia a requisição HTTP POST para o servidor com a ação `CmUpdateRecord`
           e os dados do registro.
        4. Se a resposta tiver um código diferente de `200` ou `201`, o método
           falha e chama `DoOnNewRecord`.
        5. Ao finalizar, verifica se houve uma resposta do servidor e processa os
           campos-chave atualizados, chamando `ParseServerResponse`.
        6. Caso o registro seja adicionado com sucesso, gera os parâmetros de busca
           e envia a requisição HTTP GET para localizar o registro recém-adicionado.
        7. O resultado da busca é armazenado em `JSONObject` e a atualização do
           registro é concluída com `Inherited PutRec`.

      - **Exceções**
        - **TException**: Lançada caso nenhum registro tenha sido selecionado.

      - **Ver Também**
        - `Mi_FpHttpClient.SendRequest`: Método utilizado para enviar requisições
           HTTP.
        - `ParseServerResponse`: Método responsável por processar a resposta do
           servidor e atualizar os campos-chave.
        - `Inherited AddRec`: Método herdado responsável por adicionar um registro
           localmente.
        - `Inherited UpdateRec`: Método herdado responsável por atualizar um
           registro localmente.
    }
    Public Function AddRec:Boolean;Override;

    {:O método **@name** Localiza o registro no servidor e adicone no BufDataSet
      local caso exista.

      - **Descrição**
        - O método `Locate` tenta localizar um registro com base nos parâmetros
          fornecidos. Ele envia uma requisição HTTP usando a função
          `Mi_FpHttpClient.SendRequest` e manipula a resposta JSON para localizar
          ou criar um novo registro.

      - **Parâmetros**
        - **KeyFields**: `string`
          Nome(s) do(s) campo(s) utilizado(s) para localizar o registro.

        - **KeyValues**: `Variant`
          - Valor(es) correspondente(s) ao(s) campo(s) especificado(s) em
            `KeyFields`.

        - **Options**: `TLocateOptions`
          - Conjunto de opções de localização (exemplo: `loCaseInsensitive`,
            `loPartialKey`).

      - **Retorno**
        - **boolean**:
           - `true`
             - Se o registro for localizado ou criado com sucesso.
           - `false`
             - Em caso de erro ou se o registro não for encontrado.

      - **Exceções**
        - O método trata exceções internamente e retorna `false` em caso de
          falha.

      - **Detalhes de Implementação**
        1. Converte os parâmetros `KeyFields`, `KeyValues` e `Options` para um
             JSON utilizando o método `LocateParamsToJson`.
        2. Envia uma requisição HTTP do tipo `GET` para localizar o registro
           correspondente, utilizando o endpoint `'Cmlocate'`.
        3. Se a resposta HTTP contém dados:
           - O método tenta localizar o registro chamando o método `inherited Locate`.
           - Se o registro for localizado, a resposta JSON é atribuída à
             propriedade `JSONObject`.
           - Caso o registro não seja localizado, o método chama `inherited
             DoOnNewRecord` e atribui o JSON da resposta ao `JSONObject`,
             permitindo a criação de um novo registro.
        4. Atualiza o registro chamando `inherited UpdateRec`.
        5. Libera os objetos `Params` e `Response` para evitar vazamento de
           memória.

      - **Exemplo de Uso**

        ```pascal
           procedure teste;
             var
               Found: boolean;
           begin
             Found := MyDmxScrollerFormRestClient.Locate('ID', 123, []);
             if Found
             then ShowMessage('Registro localizado com sucesso!')
             else ShowMessage('Registro não encontrado.');
           end;
        ```
    }
    public function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions) : boolean; override;overload;

    {:O método **@name** tem a função de atualizar um registro existente na base
      de dados remota usando uma requisição HTTP PUT. Caso o registro esteja
      selecionado, ele utiliza as chaves do registro para localizar e atualizar
      o registro no servidor. Se as chaves não estiverem disponíveis, o processo
      de atualização é interrompido e uma exceção é lançada.

      - **Parâmetros Locais**
        - **Response**: `TJSONObject`
          - Armazena a resposta da requisição HTTP.
        - **Params**: `TJSONObject`
          - Contém os parâmetros para localizar o registro no servidor.
        - **wJSONObject**: `TJSONObject`
          - Armazena uma cópia do objeto JSON atual.
        - **KeyFields**: `string`
          - Campos-chave utilizados para identificar o registro.
        - **KeyValues**: `Variant`
          - Valores dos campos-chave do registro.

      - **Fluxo de Execução**
        1. Verifica se um registro foi selecionado com `RecordSelected`.
        2. Se o registro estiver selecionado, chama `Inherited PutRec` para
           realizar a atualização local.
        3. Obtém os campos-chave do registro através do método `getFieldsKeys`.
        4. Se as chaves estiverem presentes, monta os parâmetros de localização
           com `LocateParamsToJson` e envia uma requisição HTTP PUT com a ação
           `CmUpdateRecord`.
        5. Verifica o código de status da resposta. Se não for `200`, restaura
           o valor original de `JSONObject` e interrompe a operação.
        6. Se não houver campos-chave, uma exceção é lançada informando que não
           é possível atualizar o registro no servidor sem chaves de pesquisa.
        7. Caso nenhum registro tenha sido selecionado, lança uma exceção
           informando que o registro não foi selecionado.

      - **Exceções**
        - **TException**:
          - Lançada nos seguintes cenários:
            - Se não houver registro selecionado.
            - Se não houver campos-chave disponíveis para realizar a atualização
              no servidor.

      - **Ver Também**
        - `Mi_FpHttpClient.SendRequest`: Método utilizado para enviar requisições
           HTTP.
        - `LocateParamsToJson`: Método responsável por criar os parâmetros de
          localização do registro.
        - `Inherited PutRec`: Método herdado responsável por atualizar o registro
          localmente.
    }
    Public Function PutRec:Boolean;Override;

    {:O método **@name** tem como objetivo excluir um registro da base de dados
      remota através de uma requisição HTTP. Ele identifica o registro a ser
      excluído com base em suas chaves primárias, monta os parâmetros da requisição
      e envia uma operação HTTP DELETE ao servidor. Se não houver um registro
      selecionado ou se as chaves não estiverem disponíveis, o método gera uma
      exceção.

      - **Parâmetros Locais**
        - **Response**: `TJSONObject`
          - Objeto que armazena a resposta da requisição HTTP.
        - **Params**: `TJSONObject`
          - Objeto JSON contendo os parâmetros para localizar o registro a ser
            excluído.
        - **KeyFields**: `string`
          - Campos-chave do registro.
        - **KeyValues**: `Variant`
          - Valores dos campos-chave do registro.

      - **Fluxo de Execução**
        1. Verifica se existe um registro selecionado usando `RecordSelected`.
        2. Obtém os campos-chave do registro com o método `getFieldsKeys`.
        3. Se as chaves forem encontradas, monta os parâmetros da requisição
           com `LocateParamsToJson` e envia uma solicitação HTTP PUT com a ação
           `CmDeleteRecord`.
        4. Verifica o código de resposta do servidor:
           - Sucesso se o código for `200` (OK) ou `204` (No Content).
           - Se o código for diferente, o método define `Result` como `False`.
        5. Se não houver campos-chave disponíveis, o método lança uma exceção,
           impedindo a exclusão do registro no servidor.
        6. Caso nenhum registro tenha sido selecionado, uma exceção é lançada
           informando que não há registro selecionado para exclusão.

      - **Exceções**
        - **TException**: Lançada nas seguintes situações:
          - Se nenhum registro estiver selecionado.
          - Se os campos-chave não estiverem disponíveis, impedindo a exclusão
            do registro no servidor.

      - **Ver Também**
        - `Mi_FpHttpClient.SendRequest`: Método responsável por enviar a requisição
           HTTP para excluir o registro.
        - `LocateParamsToJson`: Método que cria os parâmetros para localizar o
           registro no servidor.
        - `getFieldsKeys`: Método que obtém os campos-chave de um registro.
    }
    Public Function DeleteRec:Boolean;Override;
    private function Navigator(aComando:TEnumNavigator):Boolean;
    Public Function FirstRec: Boolean;overload;Override; //reintroduce;
    Public Function NextRec: Boolean;overload; Override; //reintroduce;
    Public Function PrevRec: Boolean;overload; Override; //reintroduce;
    Public Function LastRec: Boolean;overload; Override; //reintroduce;

    //protected Procedure DoOnEnter(aDmxScroller:TUiDmxScroller);overload;override;

  end;

procedure Register;

implementation

  procedure Register;
  begin
    {$I dmxscroller_form_rest_client_icon.lrs}
    RegisterComponents('Mi.Web',[TDmxScroller_Form_Rest_Client]);
  end;

constructor TDmxScroller_Form_Rest_Client.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  _Lock := false;
end;

{ TDmxScroller_Form_Rest_Client }
  procedure TDmxScroller_Form_Rest_Client.DoOnNewRecord;
    var
      Response :TJSONObject=nil;
  begin
    if not _lock Then
    try
      _lock := true;
      Response := Mi_FpHttpClient.SendRequest('CmNewRecord',TEnMethodHttp.HttpGET);
      if Assigned(Response)
      Then begin
              inherited DoOnNewRecord;
              JSONObject := Response;
           end;
    finally
      If Assigned(Response)
      Then FreeAndNil(Response);
      _lock := false;
    end;
  end;


  function TDmxScroller_Form_Rest_Client.AddRec: Boolean;
    Var
      Params: TJSONObject=nil;
      KeyFields: string='';
      KeyValues: Variant;
    var
      Response :TJSONObject=nil;
  begin
    if not _lock Then
    Try
      _lock := true;
      try

        If RecordSelected
        Then Begin
                if Appending
                Then begin
                       Result :=  Inherited AddRec;
                       If Result
                       Then begin
                              Response := Mi_FpHttpClient.SendRequest('CmAddRecord',nil,JSONObject,TEnMethodHttp.HttpPOST);
                              if not (Mi_FpHttpClient.ResponseStatusCode in [200,201])
                              Then begin
                                     Result := False;
                                     DoOnNewRecord;
                                   end
                             end;
                     end;
             end
        else raise TException.Create(self,{$I %CURRENTROUTINE%},'Registro não selecionado!');

      finally
        If Assigned(Response)
        Then begin
               //Ler o registro gravado com as chaves atualizadas
               ParseServerResponse(Response.AsJSON,KeyFields,KeyValues);
               Freeandnil(Response);
             end;
      end;

      //Atualisa a chave primária
      If Result
      Then begin
             try
               Params := LocateParamsToJson(KeyFields,KeyValues,[loCaseInsensitive]);
               Response := Mi_FpHttpClient.SendRequest('Cmlocate',Params,TEnMethodHttp.HttpGET);

               if (Mi_FpHttpClient.ResponseStatusCode in [200])
               then begin
                      JSONObject := Response;
                      try
                        if CommandsEnabled(['CmUpdateRecord'])
                        Then Result :=  Inherited PutRec
                        else Result :=  false;
                      except
                        Result := false;
                      end;
                    end
               else TException.Create(self,{$I %CURRENTROUTINE%},'Tem algo errado, '+
                     'acabei de adicionar um registro no servidor e o mesmo não existe!!!!');

             finally
               if Assigned(Params)
               Then Freeandnil(Params);

               if Assigned(Params)
               Then Freeandnil(Response);
             end;
           end;
    finally
      _lock := false;
    end;
  end;

  function TDmxScroller_Form_Rest_Client.Locate(const KeyFields: string;
                                                const KeyValues: Variant;
                                                Options: TLocateOptions): boolean;
    var
      Response :TJSONObject=nil;
      Params: TJSONObject=nil;
      //s:string;
  begin
    if not _lock Then
    try
      _lock := true;
      try
        Params := LocateParamsToJson(KeyFields,KeyValues,Options);
        //s:= KeyValues;
        Response := Mi_FpHttpClient.SendRequest('Cmlocate',Params,TEnMethodHttp.HttpGET);
        if Assigned(Response)
        Then begin
               if Mi_FpHttpClient.ResponseStatusCode = 404
               Then begin
                       ShowMessage(Response.AsJSON);
                       result := false;
                       exit;
                    end;
               result := inherited Locate(KeyFields,KeyValues,Options);
               if result
               Then begin
                      JSONObject := Response;
                      if CommandsEnabled(['CmUpdateRecord'])
                      Then Result :=  Inherited PutRec
                      else Result :=  false;
                    end
               else begin
                      inherited DoOnNewRecord;
                      JSONObject := Response;
                      result := inherited AddRec;
                    end;
               if result
               Then RefreshInternal;
             end
        else Result := false;
      Except
        Result := false;
      end;

    finally
      if Assigned(Params)
      Then FreeAndNil(Params);

      if Assigned(Response)
      Then FreeAndNil(Response);
      _lock := False;
    end;
  end;

  function TDmxScroller_Form_Rest_Client.PutRec: Boolean;
    var
      Response :TJSONObject=nil;
      Params: TJSONObject=nil;
      wJSONObject : TJSONObject=nil;
      KeyFields: string='';
      KeyValues: Variant;
  begin
    if not _lock Then
    try
      _lock := true;
      If RecordSelected
      Then Begin
             //wJSONObject:=JSONObject;
             if CommandsEnabled(['CmUpdateRecord'])
             Then Result :=  Inherited PutRec
             else Result :=  false;
             If Result
             Then begin
                    KeyFields := getFieldsKeys(KeyValues);
                    If KeyFields<>''
                    Then begin
                           Params    := LocateParamsToJson(KeyFields,KeyValues,[loCaseInsensitive]);
                           Response  := Mi_FpHttpClient.SendRequest('CmPutRecord',Params,JSONObject,TEnMethodHttp.HttpPUT);
                           if Mi_FpHttpClient.ResponseStatusCode <> 200
                           Then begin
                                  Result := False;
                                  JSONObject:=wJSONObject;
                                end;
                         end
                    else  TException.Create(self,{$I %CURRENTROUTINE%},'Não existe uma chave de pesquisa por isso não posso alterar no servidor.!');
                  end;
           end
      else raise TException.Create(self,{$I %CURRENTROUTINE%},'Registro não selecionado!');

    finally
      if Assigned(wJSONObject)
      Then FreeAndNil(wJSONObject);

      if Assigned(Params)
      Then FreeAndNil(Params);

      If Assigned(Response)
      Then FreeAndNil(Response);

      _lock := false;
    end;

  end;

  function TDmxScroller_Form_Rest_Client.DeleteRec: Boolean;
  var
    Response :TJSONObject=nil;
    Params: TJSONObject=nil;
    KeyFields: string='';
    KeyValues: Variant;
  begin
    if not _lock Then
    try
      _lock := true;
      If RecordSelected
      Then Begin
             KeyFields := getFieldsKeys(KeyValues);
             If KeyFields<>''
             Then begin
                    Params    := LocateParamsToJson(KeyFields,KeyValues,[loCaseInsensitive]);
                    Response  := Mi_FpHttpClient.SendRequest('CmDeleteRecord',Params,TEnMethodHttp.HttpDELETE);
                    if not (Mi_FpHttpClient.ResponseStatusCode in [200,204])
                    Then begin
                           Result := False;
                         end
                    else begin
                           result := Inherited DeleteRec;
                         end;
                 end
             else raise TException.Create(self,{$I %CURRENTROUTINE%},'Não existe uma chave de pesquisa por isso não posso excluir o registro no servidor.!');
           end
      else raise TException.Create(self,{$I %CURRENTROUTINE%},'Registro não selecionado!');

    finally
      if Assigned(Params)
      Then FreeAndNil(Params);

      If Assigned(Response)
      Then FreeAndNil(Response);
      _lock := false;
    end;

  end;

  function TDmxScroller_Form_Rest_Client.Navigator(aComando: TEnumNavigator): Boolean;
    var
      Response :TJSONObject=nil;

      function UpDataCache:Boolean;
        var
          KeyFields: string;
          KeyValues: Variant;
          VrId :Longint;
      begin
        DoOnEnter();
        JSONObject := Response;
        KeyFields := getFieldsKeys(KeyValues);
        VrId := KeyValues[0];
        CancelBuffers;
        DoOnExit();

        If (Not IsEmpty) and inherited Locate(KeyFields,KeyValues,[loCaseInsensitive])
        Then begin
               DoOnEnter();
               JSONObject := Response;
               if CommandsEnabled(['CmUpdateRecord'])
               Then Result :=  Inherited PutRec
               else Result :=  false;

               DoOnExit();
             end
        else begin
               DoOnEnter();
               inherited DoOnNewRecord;
               JSONObject := Response;
               result := inherited AddRec;
               DoOnExit();
             end;
      end;


     var
       KeyFields: string;
       KeyValues: Variant;
       Params: TJSONObject=nil;
  begin
    if not _lock Then
    try
      _lock := true;
      result := true;
      DoOnExit();

      try
        case aComando of
          EnGoBof      : Response := Mi_FpHttpClient.SendRequest('CmGoBof',TEnMethodHttp.HttpGET);

          EnNextRecord : begin
                           KeyFields := getFieldsKeys(KeyValues);
                           Params := LocateParamsToJson(KeyFields,KeyValues,[loCaseInsensitive]);
                           Response := Mi_FpHttpClient.SendRequest('CmNextRecord',Params,TEnMethodHttp.HttpGET);

                         end;
          EnPrevRecord : begin
                           KeyFields := getFieldsKeys(KeyValues);
                           Params := LocateParamsToJson(KeyFields,KeyValues,[loCaseInsensitive]);
                           Response := Mi_FpHttpClient.SendRequest('CmPrevRecord',Params,TEnMethodHttp.HttpGET);
                         end;

          EnGoEof      : Response := Mi_FpHttpClient.SendRequest('CmGoEof',TEnMethodHttp.HttpGET);
        end;

        if Assigned(Response)
        Then begin
               if Mi_FpHttpClient.ResponseStatusCode = 404
               Then begin
                       ShowMessage(Response.AsJSON);
                       result := false;
                       exit;
                    end;

               result := UpDataCache;

               if result
               Then RefreshInternal;
             end
        else Result := false;
      Except
        Result := false;
      end;

    finally
      if Assigned(Response)
      Then FreeAndNil(Response);
      DoOnEnter();
      _lock := false;
    end;
  end;

  function TDmxScroller_Form_Rest_Client.FirstRec: Boolean;
  begin
    Result:= Navigator(EnGoBof);
  end;

  function TDmxScroller_Form_Rest_Client.NextRec: Boolean;
  begin
    Result := Navigator(EnNextRecord);
  end;

  function TDmxScroller_Form_Rest_Client.PrevRec: Boolean;
  begin
    Result := Navigator(EnPrevRecord);
  end;

  function TDmxScroller_Form_Rest_Client.LastRec: Boolean;
  begin
    Result:= Navigator(EnGoEof);
  end;


  //Var
  //  reintrance_DoOnEnter : Boolean = false;
  //procedure TDmxScroller_Form_Rest_Client.DoOnEnter(aDmxScroller: TUiDmxScroller);
  //begin
  //  if IsEmpty and (Not reintrance_DoOnEnter)
  //  Then begin
  //         reintrance_DoOnEnter := true;
  //         Navigator(EnGoBof);
  //         reintrance_DoOnEnter := false;
  //         exit;
  //       end;
  //  Inherited DoOnEnter(aDmxScroller);
  //end;




end.
