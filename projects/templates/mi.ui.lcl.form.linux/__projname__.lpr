program __projname__;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, anchordockpkg
  ,umi_ui_msgbox_lcl //Habilita dialogos lcl
  ,mi.rtl.Objectss //Pacote com o básico da rtl maricarai.
  ,__unit1__ //__Form1__
  , __unit2__ //__DataModule1__

  ;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  TObjectss.ShowMessage('Modelo de aplicação maricarai configurado para plataforma linux');
  Application.CreateForm(T__DataModule1__, __DataModule1__);
  Application.CreateForm(T__Form1__, __Form1__);

  Application.Run;
end.

