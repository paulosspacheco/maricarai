program httpproject1;

{$mode objfpc}{$H+}

uses
  fpwebfile,
  fphttpapp, unit1;

begin
  TSimpleFileModule.BaseDir:='';
  TSimpleFileModule.RegisterDefaultRoute;
  Application.Title:='httpproject1';
  Application.Port:=8080;
  Application.Initialize;
  Application.Run;
end.

