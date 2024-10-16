unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,fpjson, jsonparser, db, variants;


function LocateParamsToJson(KeyFields: string; KeyValues: Variant; Options: TLocateOptions): TJSONObject;
Procedure LocateParamsToJsonTest;

implementation



function LocateParamsToJson(KeyFields: string; KeyValues: Variant; Options: TLocateOptions): TJSONObject;
var
  JsonObject: TJSONObject;
  JsonOptions: TJSONArray;
  JsonKeyValues: TJSONArray;
  Option: TLocateOption;
  i: Integer;
begin
  JsonObject := TJSONObject.Create;

  // Adiciona KeyFields
  JsonObject.Add('KeyFields', KeyFields);

  // Adiciona KeyValues
  JsonKeyValues := TJSONArray.Create;
  if VarIsArray(KeyValues) then
  begin
    for i := VarArrayLowBound(KeyValues, 1) to VarArrayHighBound(KeyValues, 1) do
      JsonKeyValues.Add(VarToStr(KeyValues[i]));
  end
  else
    JsonKeyValues.Add(VarToStr(KeyValues));

  JsonObject.Add('KeyValues', JsonKeyValues);

  // Adiciona Options
  JsonOptions := TJSONArray.Create;
  for Option in Options do
  begin
    case Option of
      loCaseInsensitive: JsonOptions.Add('loCaseInsensitive');
      loPartialKey: JsonOptions.Add('loPartialKey');
    end;
  end;
  JsonObject.Add('Options', JsonOptions);

  Result := JsonObject;
end;

Procedure LocateParamsToJsonTest;
var
  JsonLocateParams: TJSONObject;
  s:string;
begin
  JsonLocateParams := LocateParamsToJson('id',VarArrayOf([1]), [loPartialKey]);
  try
    s := JsonLocateParams.AsJSON;
    writeln(JsonLocateParams.AsJSON);
  finally
    JsonLocateParams.Free;
  end;
end;
end.

