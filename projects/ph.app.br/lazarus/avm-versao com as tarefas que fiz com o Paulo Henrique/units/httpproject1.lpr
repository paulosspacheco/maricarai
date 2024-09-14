program httpproject1;

{$mode objfpc}{$H+}

uses
  fpwebfile,
  fphttpapp, unit1;

begin
  TSimpleFileModule.BaseDir:='/home/paulosspacheco/LazarusProjects/maricarai_fixe-3.0/projects/ph.app.br/lazarus/avm/avm_mi_http';
  TSimpleFileModule.RegisterDefaultRoute;
  Application.Title:='httpproject1';
  Application.Port:=8080;
  Application.Threaded:=True;
  Application.Initialize;
  Application.Run;
end.

