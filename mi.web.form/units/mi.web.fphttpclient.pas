unit mi.web.fphttpclient;
{:<A unit **@name** implementa a classe TMi_FpHttpClient}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs
  , fphttpclient
  ,fpJson
  ,jsonparser
  ,mi.rtl.all;

type

  { TMI_FPHTTPClient }
  {:A classe **@name** implementa na classe FPHTTPClient o método SendRequest

    - **EXEMPLO**

       ```pascal

          procedure Teste_TdmClientRest;
          var
            ClientRest: TdmClientRest;
            Params, JSONObject, Response: TJSONObject;
            ServerURL, Action, Method,s: string;
          begin
            JSONObject := nil;
            // URL do servidor
            ServerURL := 'http://localhost:8080/Mi_rtl_WebModule/';

            // Criar instância do cliente REST
            ClientRest := TdmClientRest.Create(ServerURL);
            try
              // Configurar os parâmetros para a URL (GET)
              Params := TJSONObject.Create;
              Params.Add('id', 1);

              // Definir o método como GET
              Method := 'GET';
              Action := 'Cmlocate'; // Endpoint para GET
              Response := ClientRest.SendRequest(Action, Params, JSONObject, Method);
              try
                s:= Response.FormatJSON;
                // Processar a resposta
                WriteLn('Resposta GET: ', Response.FormatJSON);
              finally
                Response.Free;
              end;

              //// Configurar o JSON a ser enviado no corpo da requisição (POST)
              //JSONObject := TJSONObject.Create;
              //JSONObject.Add('id', '1');
              //JSONObject.Add('Nome', 'Paulo Sérgio da Silva Pacheco');
              //
              //// Definir o método como POST
              //Method := 'POST';
              //Action := 'CmUpdateRecord'; // Endpoint para POST
              //Response := ClientRest.SendRequest(Action, Params, JSONObject, Method);
              //try
              //  // Processar a resposta
              //  WriteLn('Resposta POST: ', Response.FormatJSON);
              //finally
              //  Response.Free;
              //end;



            finally
              Params.Free;
              JSONObject.Free;
              ClientRest.Free;
            end;
          end;

       ```

  }
  TMi_FpHttpClient = class(TFpHttpClient)
    {$REGION '--->Construção da propriedade ServerURL'}
      private _ServerURL: string;
      {:A propiedade **@name** contém a URL do servidor

        - **EXEMPLO**

          ```pascal
             ServerURL := 'http://localhost:8080';
          ```
      }
      published property ServerURL: string Read _ServerURL write _ServerURL;
    {$ENDREGION '--->Construção da propriedade ServerURL'}

    {$REGION '--->Construção da propriedade NameWebModule'}
      private _NameWebModule: string;
      {:A propiedade **@name** contém o nome do TWebModule do servidor

        - **EXEMPLO**

          ```pascal

             NameWebModule := 'Mi_rtl_WebModule';

          ```
      }
      published property NameWebModule: string Read _NameWebModule write _NameWebModule;
    {$ENDREGION '--->Construção da propriedade NameWebModule'}

    {:O método **@name** ação a ser executada no servidor

      - **PARÂMETROS**
        - aAction

          ```pascal
              Action := 'Cmlocate'; // Endpoint para GET
          ```
        - aParams

          ```pascal

             Params := TJSONObject.Create;
             Params.Add('id', 1);

          ```

        - aJSONObject

          ```pascal

             aJSONObject := := TJSONObject.Create;
             aJSONObject.('id'  , 1);
             aJSONObject.('nome', 'Paulo');

          ```

          - Obs:
            - Na ações de consulta e exclusão este parâmetro pode ser nil.

        - Methods
          - GET = HttpGET
            - O método get passa os parâmetros e o parâmetro aJSONObject deve
              se nil.

              - Exemplos de requisições que o servidor conhece:

                ```pascal

                   curl -X GET \
                   "http://LocalHost:8080/Tmi_rtl_web_module/Cmlocate?KeyFields=nome&KeyValues=S%25C3%25A9rgio&Options=loCaseInsensitive,loPartialKey"

                   curl -X GET \
                   "http://LocalHost:8080/Tmi_rtl_web_module/CmNewRecord"

                ```
          - POST = HttpPOST
            - O método post passa o corpo do registro (aJSONObject) e o parâmetro
              (aParams) deve ser nil.

              - Exemplos de requisições que o servidor conhece:

                ```pascal

                   curl -X POST "http://localhost:8080/Tmi_rtl_web_module/CmUpdateRecord" \
                   -H "Content-Type: application/json"\
                   -d '{"id":"0","nome": "Luisa Célia"}'

                ```
          - PUT = HttpPUT
            - O método Put passa as chaves de pesquisa do registro a ser alterado
              em aParams e o copor do registro passa em aJSONObject.

              - Exemplos de requisições que o servidor conhece:

                ```pascal

                   curl -X PUT \
                    "http://localhost:8080/Tmi_rtl_web_module/CmUpdateRecord?KeyFields=id&KeyValues=2&Options=loCaseInsensitive" \
                    -H "Content-Type: application/json" \
                    -d '{ "nome": "Silva Pacheco"}'

                ```
    }
    public function SendRequest(const aAction: string;           //:< Nome da ação
                                const aParams:  TJSONObject;     //:< Envio de parâmetros
                                const aJSONObject:  TJSONObject; //:< Envio de registros
                                const aMethod: TMi_rtl.TEnMethodHttp //Tipo de método
                               ): TJSONObject; overload;

    {:O método **@name** deve ser usado para método idepotentes e com parâmetros.

      - **EXEMPLOS**
        - Locate()
        - Report
        - etc...
    }
    public function SendRequest(const aAction: string;
                                const aParams:  TJSONObject;
                                const aMethod: TMi_rtl.TEnMethodHttp): TJSONObject; overload;

    {:O método **@name** deve ser usado para método idepotentes e sem parâmetros.

      - **EXEMPLOS**
        - DoOnNewRecord
    }
    public function SendRequest(const aAction: string;
                                const aMethod: TMi_rtl.TEnMethodHttp): TJSONObject; overload;


    public function GetURL:String;
  end;

procedure Register;

implementation

procedure Register;
begin
  {$I Mi_FpHttpClient_icon.lrs}
  RegisterComponents('Mi.Web',[TMi_FpHttpClient]);
end;

{ TMi_FpHttpClient }

function TMi_FpHttpClient.SendRequest(const aAction: string;
                                      const aParams: TJSONObject;
                                      const aJSONObject: TJSONObject;
                                      const aMethod: TMi_rtl.TEnMethodHttp): TJSONObject;
var
  ResponseStr: string='';
  QueryString: string='';
  strerr     : string='';
  URL        : string='';
  ResponseStream: TStringStream =nil;
  //S:String;
begin
  Result := nil;
  ResponseStream := TStringStream.Create('', TEncoding.UTF8);
  With TMi_rtl do
  try
    // Construir a QueryString a partir de aParams
    if Assigned(aParams) then
      QueryString := '?' + Tmi_rtl.JSONObjectToQueryString(aParams);

    // Construir a URL completa
    URL := Tmi_rtl.ValidateAndNormalizeURL(GetURL,aAction,QueryString);

    try
      try
        // Configurar o corpo da requisição se necessário
        if Assigned(aJSONObject)
        then begin
               try
                 RequestBody := TStringStream.Create(aJSONObject.AsJSON, TEncoding.UTF8);
                 // Adicionar o cabeçalho Content-Type se estiver enviando JSON
                 AddHeader('Content-Type', 'application/json');

                 case aMethod of
                   //POST: Envia dados ao servidor para criar ou modificar um recurso. É utilizado principalmente para enviar formulários ou dados de uma aplicação para o servidor.
                   TEnMethodHttp.HttpPOST: begin
                     HTTPMethod('POST', URL, ResponseStream, [200,201]); //Created: A solicitação foi bem-sucedida e um novo recurso foi criado.
                   end;

                   //PUT: Atualiza ou cria um recurso em uma URL específica. É idempotente, o que significa que várias requisições PUT com os mesmos dados não devem alterar o estado do recurso além da primeira requisição.
                   TEnMethodHttp.HttpPUT: Begin
                     HTTPMethod('PUT', URL, ResponseStream, [200]);
                   end;

                   //PATCH: Aplica modificações parciais a um recurso. Diferente do PUT, que substitui o recurso completo, o PATCH altera apenas os campos fornecidos.
                   TEnMethodHttp.HttpPATCH: Begin
                     HTTPMethod('PATCH', URL, ResponseStream, [200,204]);
                   end

                   else raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},
                            Format('Erro: Método HTTP %s não esperado!', [aMethod]));
                 end;

               finally
                 // Garantir que RequestBody seja liberado se foi alocado.
                 if Assigned(RequestBody)
                 then begin
                        RequestBody.Free;
                        RequestBody := nil;
                      end;
               end;

             end
        else begin
               case aMethod of
                 //GET: Solicita a recuperação de um recurso. Não deve alterar o estado do servidor, sendo considerado um método seguro e idempotente.
                 TEnMethodHttp.HttpGET: Begin
                   HTTPMethod('GET', URL, ResponseStream, [200, //OK: A solicitação foi bem-sucedida.
                                                           202, // Accepted: A solicitação foi aceita para processamento, mas o processamento ainda não foi concluído.
                                                           404  // Not Found: O servidor não encontrou o recurso solicitado.
                                                          ]);
                 end;

                 //DELETE: Remove um recurso identificado pela URL. Como PUT, é idempotente.
                 TEnMethodHttp.HttpDELETE: Begin
                    HTTPMethod('DELETE', URL, ResponseStream , [200,
                                                                204 //No Content: A solicitação foi bem-sucedida, mas não há conteúdo para retornar.
                                                               ]);
                 end
                 else raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},
                             Format('Erro: Método HTTP %s não esperado!', [aMethod]));
                end;
        end;

      Except
        on E: Exception do
        begin
          Result := nil;
          strerr := E.Message;
          raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},
                                  Format('Erro: HTTP %s !', [strerr]));
        end;
      end;

      // Processar a resposta
      ResponseStr := ResponseStream.DataString;
      if Trim(ResponseStr) = ''
      then raise Exception.Create('Resposta vazia.');

      if Pos('{', ResponseStr) = 1
      then Result := TJSONObject(GetJSON(ResponseStr))
      else raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},
                                        'Resposta não é um JSON válido.');

    finally
      if Assigned(ResponseStream)
      Then FreeAndNil(ResponseStream);
    end;

  except
    on E: Exception do
    begin
      if Assigned(Result) then
      begin
        Result.Free;
        Result := nil;
      end;
      raise;
    end;
  end;

end;


//function TMi_FpHttpClient.SendRequest(const aAction: string;
//  const aParams: TJSONObject; const aJSONObject: TJSONObject;
//  const aMethod: TMi_rtl.TEnMethodHttp): TJSONObject;
//
//  var
//     ResponseStr: string;
//     QueryString: string;
//     URL        : string;
//     ResponseStream: TStringStream;
//
//     s: string;
// begin
//   Result := nil;
//   With TMi_rtl do
//   try
//     if Assigned(aParams)
//     then QueryString := Tmi_rtl.JSONObjectToQueryString(aParams)
//     else QueryString := '';
//
//     AddHeader('Content-Type', 'application/json');
//
//     Case aMethod of
//       TEnMethodHttp.HttpGET :
//         begin
//            //s := GetUrl+ aAction + '?' + QueryString;
//            s:=GetURL + aAction;
//            if QueryString <> ''
//            then ResponseStr := Get(GetURL + aAction + '?' + QueryString)
//            else ResponseStr := Get(GetURL + aAction);
//         end;
//
//        TEnMethodHttp.HttpPOST :
//          begin
//            if Assigned(aJSONObject)
//            then ResponseStr := FormPost(GetURL + aAction, aJSONObject.AsJSON)
//            else raise TMi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},'O método POST precisa de um oObjeto JSON válido.');
//          end;
//
//        TEnMethodHttp.HttpPUT:
//          begin
//
//            if Assigned(aJSONObject) then
//              ResponseStr := SendData(GetURL + aAction, aJSONObject.AsJSON, MethodToStr(aMethod))
//            else
//              raise Exception.Create('PUT/PATCH request requires a valid JSON object.');
//
//            //if Assigned(aJSONObject) then
//            //  ResponseStr := FormPut(GetURL + aAction, aJSONObject.AsJSON)
//            //else
//            //  raise Tmi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},'O método PUTT precisa de um oObjeto JSON válido.');
//          end;
//
//       else  raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},Format('Erro: Método HTTP %s , não esperado!. ', [aMethod]));
//     end;
//
//     Case ResponseStatusCode of
//         200 : begin
//                 try
//                   if Trim(ResponseStr) = '' then
//                     raise Exception.Create('Resposta vazia.');
//
//                   if Pos('{', ResponseStr) = 1 then
//                     Result := TJSONObject(GetJSON(ResponseStr))
//                   else
//                     raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},'Resposta não é um JSON válido.');
//                 except
//                   on E: Exception do
//                   begin
//                     raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%}, 'Erro ao analisar resposta JSON: ' + E.Message);
//                   end;
//                 end;
//               end
//        else   begin
//                 raise TMi_Rtl.TException.Create(self, {$I %CURRENTROUTINE%},
//                   Format('Erro HTTP %d: %s', [ResponseStatusCode, ResponseStr]));
//               end;
//     end;
//
//   except
//     if Assigned(Result)
//     then begin
//            Result.Free;
//            Result := nil;
//          end;
//   end;
// end;

function TMi_FpHttpClient.SendRequest(const aAction: string;
                              const aParams: TJSONObject; const aMethod: TMi_rtl.TEnMethodHttp
  ): TJSONObject;
begin
  result := SendRequest(aAction,aParams,nil,aMethod);
end;

function TMi_FpHttpClient.SendRequest(const aAction: string;const aMethod: TMi_rtl.TEnMethodHttp): TJSONObject;
begin
 result := SendRequest(aAction,nil,nil,aMethod);
end;

function TMi_FpHttpClient.GetURL: String;
begin
  Result := ServerURL+'/'+NameWebModule+'/';
end;


end.
