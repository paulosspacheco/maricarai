unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, fphttpclient
  ,mi.rtl.all;

procedure Teste_TdmClientRest;

type

  { TdmClientRest }

  TdmClientRest = class
  private
    FServerURL: string;
  public
    constructor Create(const ServerURL: string);
    function SendRequest(const Action: string; const Params,JSONObject:  TJSONObject; const Method: string = 'POST'): TJSONObject;
  end;


implementation



  constructor TdmClientRest.Create(const ServerURL: string);
  begin
    FServerURL := ServerURL;
  end;

  function URLEncode(const AStr: string): string;
    const
      HexMap: array[0..15] of Char = '0123456789ABCDEF';
  var
    i: Integer;
    S: string;
  begin
    Result := '';
    for i := 1 to Length(AStr) do
    begin
      case AStr[i] of
        'A'..'Z', 'a'..'z', '0'..'9', '-', '_', '.', '~':
          Result := Result + AStr[i];
        else
          S := '%' + HexMap[(Ord(AStr[i]) shr 4) and $0F] + HexMap[Ord(AStr[i]) and $0F];
          Result := Result + S;
      end;
    end;
  end;

  function JSONObjectToQueryString(const Params: TJSONObject): string;
  var
    i: Integer;
    Pair: TJSONEnum;
  begin
    Result := '';
    for Pair in Params do
    begin
      if Result <> '' then
        Result := Result + '&';
      Result := Result + URLEncode(Pair.Key) + '=' + URLEncode(Pair.Value.AsString);
    end;
  end;

  function TdmClientRest.SendRequest(const Action: string; const Params, JSONObject: TJSONObject; const Method: string): TJSONObject;
  var
    HTTPClient: TFPHTTPClient;
    ResponseStr: string;
    QueryString: string;
    s : string;
  begin
    Result := nil;
    HTTPClient := TFPHTTPClient.Create(nil);
    try
      try
        // Verifica se Params foi fornecido
        if Assigned(Params) then
          QueryString := JSONObjectToQueryString(Params)
        else
          QueryString := '';

        HTTPClient.AddHeader('Content-Type', 'application/json');

        if SameText(Method, 'POST') then
        begin
          if Assigned(JSONObject) then
            ResponseStr := HTTPClient.FormPost(FServerURL + Action, JSONObject.AsJSON)
          else
            raise Exception.Create('POST request requires a valid JSON object.');
        end
        else if SameText(Method, 'GET') then
        begin
          s := FServerURL + Action + '?' + QueryString;
          if QueryString <> '' then
            ResponseStr := HTTPClient.Get(FServerURL + Action + '?' + QueryString)
          else
            ResponseStr := HTTPClient.Get(FServerURL + Action);
        end
        else
        begin
          raise Exception.Create('Método HTTP não suportado.');
        end;

        // Tenta converter a resposta para JSON
        if ResponseStr <> '' then
          Result := TJSONObject(GetJSON(ResponseStr))
        else
          raise Exception.Create('Empty response from server.');
      except
        on E: Exception do
          raise Tmi_rtl.TException.Create('Erro na requisição HTTP: ' + E.Message);

      end;
    finally
      HTTPClient.Free;
    end;
  end;

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


//procedure Teste_TdmClientRest;
//var
//  ClientRest: TdmClientRest;
//  Params,
//  Response,Request: TJSONObject;
//  ServerURL: string;
//  Action: string;
//  s:string;
//begin
//  // URL do servidor
//  ServerURL := 'http://localhost:8080/Mi_rtl_WebModule/'; // Substitua com a URL do seu servidor
//
//  // Criar instância do cliente REST
//  ClientRest := TdmClientRest.Create(ServerURL);
//  try
//    // Configurar parâmetros para a requisição POST
//    try
//      Request := nil;
//      Params := TJSONObject.Create(['id',1]);
//
//      // Enviar requisição POST
//      Action := 'CmlocateRequest'; // Substitua com o endpoint da sua API
//      Response := ClientRest.SendRequest(Action, Params,Request, 'POST');
//
//      // Processar a resposta
//      WriteLn('Resposta POST: ', Response.AsJSON);
//      s:=Response.AsJSON;
//    finally
//      Params.Free;
//      Response.Free;
//    end;
//
//    // Configurar parâmetros para a requisição GET
//    try
//      Params := TJSONObject.Create(['id',2]);
//
//      // Enviar requisição GET
//      Action := 'CmlocateRequest'; // Substitua com o endpoint da sua API
//      Response := ClientRest.SendRequest(Action, Params,Request, 'GET');
//
//      // Processar a resposta
//      WriteLn('Resposta GET: ', Response.AsJSON);
//      s:= Response.AsJSON
//    finally
//      Params.Free;
//      Response.Free;
//    end;
//
//  finally
//    ClientRest.Free;
//  end;
//end;



end.



//  constructor TdmClientRest.Create(const ServerURL: string);
//  begin
//    FServerURL := ServerURL;
//  end;
//
//  function TdmClientRest.VariantToJSONString(const Params: Variant): string;
//    var
//      JSONData: TJSONData;
//  begin
//    // Converta o Variant para TJSONData
//    JSONData := TJSONData.Create();
//    try
//      // Converter Variant para TJSONData
//      JSONData := TJSONData(VariantToJSON(Params));
//      // Converter TJSONData para string JSON
//      Result := JSONData.AsJSON;
//    finally
//      JSONData.Free;
//    end;
//  end;
//
//  function TdmClientRest.SendRequest(const Action: string; const Params: Variant; const Method: string = 'POST'): TJSONObject;
//  var
//    HTTPClient: TFPHTTPClient;
//    ResponseStr: string;
//    JSONParams: string;
//  begin
//    Result := nil;
//    HTTPClient := TFPHTTPClient.Create(nil);
//    try
//      JSONParams := VariantToJSONString(Params);
//      HTTPClient.AddHeader('Content-Type', 'application/json');
//
//      if SameText(Method, 'POST') then
//      begin
//        ResponseStr := HTTPClient.FormPost(FServerURL + Action, JSONParams);
//      end
//      else if SameText(Method, 'GET') then
//      begin
//        // Para GET, os parâmetros devem ser adicionados à URL
//        ResponseStr := HTTPClient.Get(FServerURL + Action + '?' + JSONParams);
//      end
//      else
//      begin
//        raise Exception.Create('Método HTTP não suportado.');
//      end;
//
//      Result := TJSONObject(GetJSON(ResponseStr));
//    finally
//      HTTPClient.Free;
//    end;
//  end;
//
//
//
//
//procedure Teste_TdmClientRest;
//var
//  ClientRest: TdmClientRest;
//  Params: Variant;
//  Response: TJSONObject;
//  ServerURL: string;
//  Action: string;
//  s:string;
//begin
//  // URL do servidor
//  ServerURL := 'http://localhost:8080/'; // Substitua com a URL do seu servidor
//
//  // Criar instância do cliente REST
//  ClientRest := TdmClientRest.Create(ServerURL);
//  try
//    // Configurar parâmetros para a requisição POST
//    Params := VarArrayOf([
//      VarArrayOf(['id', 1])
////      VarArrayOf(['param2', 'valor2'])
//    ]);
//
//    // Enviar requisição POST
//    Action := 'CmlocateRequest'; // Substitua com o endpoint da sua API
//    Response := ClientRest.SendRequest(Action, Params, 'POST');
//    try
//      // Processar a resposta
//      WriteLn('Resposta POST: ', Response.AsJSON);
//      s:=Response.AsJSON;
//    finally
//      Response.Free;
//    end;
//
//    // Configurar parâmetros para a requisição GET
//    Params := VarArrayOf([
//      VarArrayOf(['id', 2])
//      //VarArrayOf(['param2', 'valor2'])
//    ]);
//
//    // Enviar requisição GET
//    Action := 'CmlocateRequest'; // Substitua com o endpoint da sua API
//    Response := ClientRest.SendRequest(Action, Params, 'GET');
//    try
//      // Processar a resposta
//      WriteLn('Resposta GET: ', Response.AsJSON);
//      s:= Response.AsJSON
//    finally
//      Response.Free;
//    end;
//
//  finally
//    ClientRest.Free;
//  end;
//end;


