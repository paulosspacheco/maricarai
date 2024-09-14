unit uUsuarioController;

{$mode Delphi}{$H+}

interface

uses
  Classes, SysUtils, fpjson, jsonparser, HTTPDefs, FGL, fpHTTP, fpWeb
  ,mi.rtl.all
  ;//,jsonreader;

type
  TUsuario = class
    ID: Integer;
    Login: string;
    Nome: string;
  end;

//  TUsuariosList = specialize TFPGObjectList<TUsuario>;   modo freepascal precisa specialize
  TUsuariosList = TFPGObjectList<TUsuario>;

  { TUsuarioController }

  TUsuarioController = class(TFPWebModule)
    procedure CreateUsuario(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    procedure DeleteUsuario(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    procedure GetUsuario(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
    procedure UpdateUsuario(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);

  private
    FUsuarios: TUsuariosList;
    function GetUsuarioById(const AID: Integer): TUsuario;
    function GenerateNewID: Integer;
  public
    constructor CreateNew(AOwner: TComponent; CreateMode: Integer); override;
    destructor Destroy; override;
  end;

implementation



{$R *.lfm}

constructor TUsuarioController.CreateNew(AOwner: TComponent; CreateMode: Integer);
begin
  inherited CreateNew(AOwner, CreateMode);
  FUsuarios := TUsuariosList.Create(True);
end;

destructor TUsuarioController.Destroy;
begin
  FUsuarios.Free;
  inherited Destroy;
end;

function TUsuarioController.GenerateNewID: Integer;
begin
  if FUsuarios.Count = 0 then
    Result := 1
  else
    Result := FUsuarios.Last.ID + 1;
end;

procedure TUsuarioController.CreateUsuario(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
//var
//  Usuario: TUsuario;
//  Json: TJSONObject;
//  strJson : TJSONStringType;
//begin
//  Json := GetJSON(ARequest.Content) as TJSONObject;
//  strJson := json.AsJSON;
//  Usuario := TUsuario.Create;
//  Usuario.ID    := GenerateNewID;
//  Usuario.Login := Json.Strings['login'];
//  Usuario.Nome  := Json.Strings['nome'];
//  FUsuarios.Add(Usuario);
//  AResponse.Content := '{"message":"Usuário criado com sucesso"}';
//  Handled := true;
//end;
  var
    Usuario: TUsuario;
    Json: TJSONObject;
begin
  if ARequest.Content = '' then
  begin
    AResponse.Content := '{"error":"Nenhum dado enviado"}';
    Handled := true;
    Exit;
  end;

  try
    Json := GetJSON(ARequest.Content) as TJSONObject;
  except
    on E: Exception do
    begin
      AResponse.Content := '{"error":"Erro ao processar JSON: ' + E.Message + '"}';
      Handled := true;
      Exit;
    end;
  end;

  Usuario := TUsuario.Create;
  Usuario.ID    := GenerateNewID;
  Usuario.Login := Json.Get('login', '');
  Usuario.Nome  := Json.Get('nome', '');
  FUsuarios.Add(Usuario);

  AResponse.Content := '{"message":"Usuário criado com sucesso"}';
  Handled := true;
end;

procedure TUsuarioController.GetUsuario(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  //Function GetKeys:String;
  //  var
  //    JSONData : TJSONData;
  //    JSONObject : TJSONObject;
  //    i          : Integer;
  //    aValue     : Variant ;
  //    s : String;
  //    List : TStringList;
  //begin
  //  result := '';
  ////Verifica se a chave primária está nos parâmetros da rota
  //  //for s in ARequest.RouteParams.Split(list) do
  //  //  Result := ARequest.RouteParams['id'];
  //
  //  result := TMi_rtl.getFieldsKeys(ARequest.QueryFields,aValue);
  //
  //  // Se não encontrar na query string, busca no corpo da requisição
  //  //if Result = '' then
  //  //begin
  //  //  JSONObject := GetJSON(ARequest.Content) as TJSONObject;
  //  //  try
  //  //    For i := 0 to JSONObject.Count-1 do
  //  //    begin
  //  //       Result := JSONObject.Items[i].AsString+';' ;
  //  //    end;
  //  //
  //  //  finally
  //  //    JSONObject.Free;
  //  //  end;
  //  //end;
  //end;

var
  ID: Integer;
  Usuario: TUsuario;
  Json: TJSONObject;
  s :String;
begin
  //s:= GetKeys;

  // Obtém o ID da query string
  ID := StrToIntDef(ARequest.QueryFields.Values['id'], -1);

  // Se o ID for válido, tenta localizar o usuário
  if ID <> -1 then
  begin
    Usuario := GetUsuarioById(ID);

    // Se o usuário for encontrado, retorna os dados em JSON
    if Assigned(Usuario) then
    begin
      Json := TJSONObject.Create;
      try
        Json.Add('id', Usuario.ID);
        Json.Add('login', Usuario.Login);
        Json.Add('nome', Usuario.Nome);
        AResponse.Content := Json.AsJSON;
      finally
        Json.Free;
      end;
    end
    else
      AResponse.Content := '{"error":"Usuário não encontrado"}';
  end
  else
    AResponse.Content := '{"error":"ID inválido"}';

  Handled := True;
end;

procedure TUsuarioController.UpdateUsuario(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
var
  ID: Integer;
  Usuario: TUsuario;
  Json: TJSONObject;
  strJson : TJSONStringType;
begin
  Json := GetJSON(ARequest.Content) as TJSONObject;
  try
    strJson := json.AsJSON;
    ID := Json.Get('id', 0); // Pega o ID com valor padrão 0 caso não exista

    if ID > 0 then
    begin
      Usuario := GetUsuarioById(ID);

      if Assigned(Usuario) then
      begin
        Usuario.Login := Json.Get('login', Usuario.Login); // Mantenha o valor existente se a chave não existir
        Usuario.Nome  := Json.Get('nome', Usuario.Nome);
        AResponse.Content := '{"message":"Usuário atualizado com sucesso"}';
      end
      else
        AResponse.Content := '{"error":"Usuário não encontrado"}';
    end
    else
      AResponse.Content := '{"error":"ID inválido"}';
  finally
    Json.Free;
  end;

  Handled := True;
end;

function TUsuarioController.GetUsuarioById(const AID: Integer): TUsuario;
var
  Usuario: TUsuario;
begin
  for Usuario in FUsuarios do
    if Usuario.ID = AID then
      Exit(Usuario);
  Result := nil;
end;

procedure TUsuarioController.DeleteUsuario(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
var
  ID: Integer;
  Usuario: TUsuario;
begin
  ID := StrToIntDef(ARequest.QueryFields.Values['id'], 0);
  Usuario := GetUsuarioById(ID);

  if Assigned(Usuario) then
  begin
    FUsuarios.Remove(Usuario);
    AResponse.Content := '{"message":"Usuário deletado com sucesso"}';
  end
  else
    AResponse.Content := '{"error":"Usuário não encontrado"}';
  Handled := true;
end;

initialization
  RegisterHTTPModule('TUsuarioController', TUsuarioController);
end.


