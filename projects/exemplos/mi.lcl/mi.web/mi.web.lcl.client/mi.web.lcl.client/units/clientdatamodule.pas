unit ClientDataModule;

{$mode ObjFPC}{$H+}

interface

uses
 Classes, SysUtils, db, fpjson, fpjsondataset, fphttpclient
 , httpdefs, fpjsonrtti,jsonparser
 ,mi.rtl.all;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    FPHTTPClient1: TFPHTTPClient;
    JSONDataSet1: TJSONDataSet;

  private

    FServerURL: string;
    function BuildKeyParams(const KeyValues: array of const): string;
    procedure LoadJSONDataSetFromJSON(const JSONString: string); // Nova função para carregar JSON no DataSet
  public
    constructor Create(AOwner: TComponent; const ServerURL: string); reintroduce;

    procedure LocateRecord(const KeyValues: array of const);
    procedure GoBof;
    procedure GoEof;
    procedure NewRecord;
    procedure UpdateRecord(const KeyValues: array of const);
    procedure DeleteRecord(const KeyValues: array of const);
    procedure CancelRequest;
    procedure RefreshRecord(const KeyValues: array of const);

    property ServerURL: string read FServerURL write FServerURL;
    procedure LoadJSONIntoDataSet(const JSONString: string);
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TClientDM }



constructor TDataModule1.Create(AOwner: TComponent; const ServerURL: string);
begin
  inherited Create(AOwner);
  FServerURL := ServerURL;
end;

function TDataModule1.BuildKeyParams(const KeyValues: array of const): string;
var
  i: Integer;
  KeyParams: string;
begin
  KeyParams := '';
  for i := Low(KeyValues) to High(KeyValues) do
  begin
    if i > Low(KeyValues) then
      KeyParams := KeyParams + '&';
    KeyParams := KeyParams + Format('key%d=%s', [i + 1,TMi_rtl.VarRecArrayToStr(KeyValues[i])]);
  end;
  Result := KeyParams;
end;

function RawByteStringToJSONArray(const RawData: RawByteString): TJSONArray;
var
  JSONString: string;
  JSONData: TJSONData;
  JSONParser: TJSONParser;
begin
  // Converta RawByteString para string UTF-8
  JSONString := UTF8ToString(RawData);

  // Crie um parser JSON
  JSONParser := TJSONParser.Create(JSONString);
  try
    // Analise o JSON e obtenha o array
    JSONData := JSONParser.Parse;
    try
      if JSONData is TJSONArray then
        Result := TJSONArray(JSONData)
      else
        raise Exception.Create('JSON data is not an array.');
    finally
      JSONData.Free;
    end;
  finally
    JSONParser.Free;
  end;
end;

procedure TDataModule1.LoadJSONDataSetFromJSON(const JSONString: string);
//var
//  JSONParser: TJSONParser;
//  JSONObject: TJSONObject;
//begin
//  JSONParser := TJSONParser.Create(JSONString);
//  try
//    JSONObject := JSONParser.Parse as TJSONObject;
//    try
//      JSONDataSet1.Rows := RawByteStringToJSONArray(JSONString);
//     // JSONDataSet1.LoadFromJSON(JSONObject);
//    finally
//      JSONObject.Free;
//    end;
//  finally
//    JSONParser.Free;
//  end;
//end;

procedure TDataModule1.LocateRecord(const KeyValues: array of const);
var
  Response: string;
  Params: string;
begin
  Params := BuildKeyParams(KeyValues);
  Response := fpHTTPClient1.Get(FServerURL + '/Mi_rtl_WebModule/locate?' + Params);
  JSONDataSet1.Rows.AsString:=Response;
end;

procedure TDataModule1.GoBof;
var
  Response: string;
begin
  Response := fpHTTPClient1.Get(FServerURL + '/Mi_rtl_WebModule/gobof');
  LoadJSONDataSetFromJSON(Response);
end;

procedure TDataModule1.GoEof;
var
  Response: string;
begin
  Response := fpHTTPClient1.Get(FServerURL + '/Mi_rtl_WebModule/goeof');
  LoadJSONDataSetFromJSON(Response);
end;

procedure TDataModule1.NewRecord;
var
  Response: string;
begin
  Response := fpHTTPClient1.Get(FServerURL + '/Mi_rtl_WebModule/newrecord');
  LoadJSONDataSetFromJSON(Response);
end;

procedure TDataModule1.UpdateRecord(const KeyValues: array of const);
var
  Response: string;
  Params: string;
  RequestData: TJSONObject;
begin
  Params := BuildKeyParams(KeyValues);

  fpHTTPClient1.AddHeader('Content-Type', 'application/json');
  Response := fpHTTPClient1.Post(FServerURL + '/Mi_rtl_WebModule/updaterecord?' + Params, JSONDataSet1.Rows.AsString;
  LoadJSONDataSetFromJSON(Response);
end;

procedure TDataModule1.DeleteRecord(const KeyValues: array of const);
var
  Response: string;
  Params: string;
begin
  Params := BuildKeyParams(KeyValues);
  Response := HTTPClient.Get(FServerURL + '/Mi_rtl_WebModule/deleterecord?' + Params);
  LoadJSONDataSetFromJSON(Response);
end;

procedure TDataModule1.CancelRequest;
var
  Response: string;
begin
  Response := HTTPClient.Get(FServerURL + '/Mi_rtl_WebModule/cancel');
  LoadJSONDataSetFromJSON(Response);
end;

procedure TDataModule1.RefreshRecord(const KeyValues: array of const);
var
  Response: string;
  Params: string;
begin
  Params := BuildKeyParams(KeyValues);
  Response := HTTPClient.Get(FServerURL + '/Mi_rtl_WebModule/refresh?' + Params);
  LoadJSONDataSetFromJSON(Response);
end;

end.


