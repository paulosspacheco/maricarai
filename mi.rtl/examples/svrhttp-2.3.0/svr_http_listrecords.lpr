program svr_http_listRecords;

{$mode objfpc}{$H+}

uses
  fpwebfile,
  fphttpapp
  ,webmodule2
  ;

begin
  TSimpleFileModule.BaseDir:='/home/paulosspacheco/LazarusProjects/maricarai/mi.rtl/examples/svrhttp';
  TSimpleFileModule.RegisterDefaultRoute;
  Application.Title:='svr_http_listRecords';
  Application.Port:=8080;
  Application.Initialize;
  WriteLn('Executanto servidor http na 8080.');
  Application.Run;
end.

