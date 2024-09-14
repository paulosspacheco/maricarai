unit RegisterCustomTemplate;


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Dialogs;

procedure AddCustomTemplate;

implementation

procedure AddCustomTemplate;
const
  TemplatePath = 'C:\Users\<seu_usuário>\AppData\Local\lazarus\templates\CustomTemplate.pas'; // Atualize o caminho conforme necessário
  TemplateContent = 'unit Unit1;' + sLineBreak +
                     '' + sLineBreak +
                     'interface' + sLineBreak +
                     '' + sLineBreak +
                     'implementation' + sLineBreak +
                     '' + sLineBreak +
                     'end.';
var
  FileStream: TFileStream;
  StringStream: TStringStream;
begin
  if not FileExists(TemplatePath) then
  begin
    StringStream := TStringStream.Create(TemplateContent);
    try
      FileStream := TFileStream.Create(TemplatePath, fmCreate);
      try
        FileStream.CopyFrom(StringStream, 0);
      finally
        FileStream.Free;
      end;
    finally
      StringStream.Free;
    end;
  end
  else
  begin
    ShowMessage('Template já existe.');
  end;
end;

end.

