unit uform_UsuarioController;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, StdCtrls, Dialogs, Buttons, ExtCtrls,
   fphttpclient, fpjson, jsonparser;

type

  { TForm_UsuarioController }

  TForm_UsuarioController = class(TForm)
    ButtonGet: TButton;
    ButtonDelete: TButton;
    ButtonUpdate: TButton;
    ButtonCreate: TButton;
    Edit_nome: TEdit;
    Edit_login: TEdit;
    Edit_id: TEdit;
    LabelStatus: TLabel;
    Label_nome: TLabel;
    label_login: TLabel;
    Label_id: TLabel;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    procedure ButtonCreateClick(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
    procedure ButtonGetClick(Sender: TObject);
    procedure ButtonUpdateClick(Sender: TObject);

  private
    procedure ShowStatus(const Msg: string);
    function GetJSONFromForm: TJSONObject;

    procedure SendRequest(const AMethod, AAction: string; const AData: TJSONObject = nil);
  public

  end;

var
  Form_UsuarioController: TForm_UsuarioController;

implementation

{$R *.lfm}

uses
  uFormMain;

{ TForm_UsuarioController }

procedure TForm_UsuarioController.ButtonCreateClick(Sender: TObject);
begin
  SendRequest('POST', 'CreateUsuario', GetJSONFromForm);
end;

procedure TForm_UsuarioController.ButtonUpdateClick(Sender: TObject);
begin
  if Edit_ID.Text = '' then
  begin
    ShowStatus('Erro: ID do usuário não pode estar vazio.');
    Exit;
  end;

  // Enviar a requisição de atualização
  SendRequest('PUT', 'UpdateUsuario', GetJSONFromForm);
end;

procedure TForm_UsuarioController.ButtonDeleteClick(Sender: TObject);
begin
  if Edit_ID.Text = '' then
  begin
    ShowStatus('Erro: ID do usuário não pode estar vazio.');
    Exit;
  end;

  SendRequest('DELETE', 'DeleteUsuario?id=' + Edit_ID.Text);
end;


//procedure TForm_UsuarioController.ButtonGetClick(Sender: TObject);
//var
//  HTTPClient: TFPHTTPClient;
//  Response: TStringStream;
//  URL: string;
//  JSONData: TJSONData;
//  JSONObject: TJSONObject;
//  i : Integer;
//begin
//  HTTPClient := TFPHTTPClient.Create(nil);
//  Response := TStringStream.Create('');
//  try
//    URL := 'http://localhost:8080/TUsuarioController/GetUsuario?id=' + Edit_ID.Text;
//    try
//      HTTPClient.Get(URL, Response);
//      JSONData := GetJSON(Response.DataString);
//       está abaixoif JSONData.JSONType = jtObject then
//      begin
//        JSONObject := TJSONObject(JSONData);
//        Edit_id.Text    := JSONObject.Get('id'   ,'');
//        Edit_Login.Text := JSONObject.Get('login', '');
//        Edit_Nome.Text   := JSONObject.Get('nome', '');
//
//        ShowStatus('Usuário obtido com sucesso.');
//      end;
//    except
//      on E: Exception do
//        ShowStatus('Erro: ' + E.Message);
//    end;
//  finally
//    HTTPClient.Free;
//    Response.Free;
//  end;
//end;

//procedure TForm_UsuarioController.ButtonGetClick(Sender: TObject);
//var
//  HTTPClient: TFPHTTPClient;
//  Response: TStringStream;
//  URL: string;
//  JSONData: TJSONData;
//  JSONObject: TJSONObject;
//begin
//  HTTPClient := TFPHTTPClient.Create(nil);
//  Response := TStringStream.Create('');
//  try
//    URL := 'http://localhost:8080/TUsuarioController/GetUsuario?id=' + Edit_ID.Text;
//    try
//      HTTPClient.Get(URL, Response);
//      ShowMessage(Response.DataString);  // Exibe o JSON retornado
//      JSONData := GetJSON(Response.DataString);
//      if JSONData.JSONType = jtObject then
//      begin
//        JSONObject := TJSONObject(JSONData);
//        Edit_id.Text := JSONObject.Get('id', '');
//        Edit_Login.Text := JSONObject.Get('login', '');
//        Edit_Nome.Text := JSONObject.Get('nome', '');
//
//        ShowStatus('Usuário obtido com sucesso.');
//      end;
//    except
//      on E: Exception do
//        ShowStatus('Erro: ' + E.Message);
//    end;
//  finally
//    HTTPClient.Free;
//    Response.Free;
//  end;
//end;

procedure TForm_UsuarioController.ButtonGetClick(Sender: TObject);
var
  HTTPClient: TFPHTTPClient;
  Response: TStringStream;
  URL: string;
  JSONData: TJSONData;
  JSONObject: TJSONObject;
  IDValue: string;
begin
  HTTPClient := TFPHTTPClient.Create(nil);
  Response := TStringStream.Create('');
  try
    //URL := 'http://localhost:8080/TUsuarioController/GetUsuario?id=' + Edit_ID.Text;
    // Construindo a URL com os parâmetros ID e Nome
    URL := 'http://localhost:8080/TUsuarioController/GetUsuario?'+'id='+Edit_ID.Text;

//                        'id='+Edit_ID.Text +
//                        '&nome=' + Edit_Nome.Text;
////                        '&Option=loPartialKey'; //(loCaseInsensitive,loPartialKey);
        //URL := 'http://localhost:8080/TMi_rtl_WebModule_Custom/locate'+
        //                    '?id='+Edit_ID.Text +
        //                    '&nome=' + Edit_Nome.Text;


    try
      HTTPClient.Get(URL, Response);
      JSONData := GetJSON(Response.DataString);
      if JSONData.JSONType = jtObject then
      begin
        JSONObject := TJSONObject(JSONData);

        // Capturando o valor do ID antes de atribuir
        //IDValue := JSONObject.Get('id', '');
        IDValue := IntToStr(JSONObject.Get('id', 0)); // 0 é o valor padrão caso o id não esteja presente

        ShowMessage('ID recebido: ' + IDValue); // Debug: Verifique se o ID é capturado corretamente

        // Atribuindo o valor ao campo Edit_id
        Edit_id.Text := IDValue;
        Edit_Login.Text := JSONObject.Get('login', '');
        Edit_Nome.Text := JSONObject.Get('nome', '');

        ShowStatus('Usuário obtido com sucesso.');
      end;
    except
      on E: Exception do
        ShowStatus('Erro: ' + E.Message);
    end;
  finally
    HTTPClient.Free;
    Response.Free;
  end;
end;


procedure TForm_UsuarioController.ShowStatus(const Msg: string);
begin
  LabelStatus.Caption := Msg;
end;

function TForm_UsuarioController.GetJSONFromForm: TJSONObject;
var
  id: Longint;
begin
  Result := TJSONObject.Create;

  if not TryStrToInt(Edit_ID.Text, id) then
  begin
    ShowStatus('Erro: ID inválido.');
    Exit;
  end;

  Result.Add('id', id); // Incluindo o ID no JSON
  Result.Add('login', Edit_Login.Text);
  Result.Add('nome', Edit_Nome.Text);
end;


procedure TForm_UsuarioController.SendRequest(const AMethod, AAction: string;
  const AData: TJSONObject);
var
  HTTPClient: TFPHTTPClient;
  Response, RequestBody: TStringStream;
  URL: string;
begin
  HTTPClient := TFPHTTPClient.Create(nil);
  Response := TStringStream.Create('');
  try
    URL := 'http://localhost:8080/TUsuarioController/' + AAction;
    try
      if AMethod = 'POST' then
      begin
        RequestBody := TStringStream.Create(AData.AsJSON);
        try
          HTTPClient.RequestBody := RequestBody;
          HTTPClient.AddHeader('Content-Type', 'application/json');
          HTTPClient.Post(URL, Response);
        finally
          RequestBody.Free;
        end;
      end
      else if AMethod = 'PUT' then
      begin
        RequestBody := TStringStream.Create(AData.AsJSON);
        try
          HTTPClient.RequestBody := RequestBody;
          HTTPClient.AddHeader('Content-Type', 'application/json');
          HTTPClient.Put(URL, Response);
        finally
          RequestBody.Free;
        end;
      end
      else if AMethod = 'DELETE' then
      begin
        HTTPClient.Delete(URL, Response);
      end;

      ShowStatus('Operação realizada com sucesso: ' + Response.DataString);
    except
      on E: Exception do
        ShowStatus('Erro: ' + E.Message);
    end;
  finally
    HTTPClient.Free;
    Response.Free;
    if Assigned(AData) then
      AData.Free;
  end;
end;

end.


