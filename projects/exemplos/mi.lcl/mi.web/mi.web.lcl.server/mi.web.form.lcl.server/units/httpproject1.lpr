program httpproject1;

{$mode objfpc}{$H+}

uses

    {$IFDEF UNIX}
    cthreads,
    {$ENDIF}
    {$IFDEF HASAMIGA}
    athreads,
    {$ENDIF}
    Interfaces, // this includes the LCL widgetset

  fpwebfile,
  fphttpapp,
  unit1,mi.rtl.web.module

    ;

begin
  TSimpleFileModule.BaseDir:='/home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-trunk/projects/exemplos/mi.lcl/mi.web/mi.web.lcl.server/serverhttp';
  TSimpleFileModule.RegisterDefaultRoute;
  Application.Title:='httpproject1';
  Application.Port:=8080;
  Application.Threaded:=True;
  Application.Initialize;
  mi_rtl_web_module := Tmi_rtl_web_module.Create(Application);
  Application.Run;
end.

