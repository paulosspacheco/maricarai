unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  SysUtils, Classes , HTTPDefs, websession, fpHTTP, htmlwriter, htmlelements, 
    fphtml;

type
  TFPHTMLModule1 = class(TFPHTMLModule)
  private

  public

  end;

var
  FPHTMLModule1: TFPHTMLModule1;

implementation

{$R *.lfm}

initialization
  RegisterHTTPModule('TFPHTMLModule1', TFPHTMLModule1);
end.

