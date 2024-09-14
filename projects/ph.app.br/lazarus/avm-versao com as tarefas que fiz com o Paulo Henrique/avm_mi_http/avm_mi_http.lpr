program avm_mi_http;

{$mode objfpc}{$H+}

uses
//  Interfaces, //Note: this, includes the LCL widgetset
  fpwebfile,
  fphttpapp
  ,uoperadores
  , unit1;

begin
  TSimpleFileModule.BaseDir:='/home/paulosspacheco/LazarusProjects/maricarai_fixe-3.0/projects/ph.app.br/lazarus/avm/avm_mi_http';
  TSimpleFileModule.RegisterDefaultRoute;
  Application.Title:='httpproject1';
  Application.Port:=8080;
  Application.Threaded:=True;
  Application.Initialize;
  Application.CreateForm(Toperadores,operadores);

  Application.Run;
end.

