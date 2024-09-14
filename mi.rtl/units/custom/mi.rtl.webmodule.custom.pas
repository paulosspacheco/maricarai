unit Mi.rtl.WebModule.Custom;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, fphttp, Forms, Controls, Graphics, Dialogs, u_fpwebmodule1,
  Mi.rtl.WebModule;

type
  TMi_rtl_WebModule_Custom = class(TMi_rtl_WebModule)
  private

  public

  end;

var
  Mi_rtl_WebModule_Custom: TMi_rtl_WebModule_Custom;

implementation

{$R *.lfm}

initialization
  RegisterHTTPModule('TMi_rtl_WebModule_Custom', TMi_rtl_WebModule_Custom);
end.

