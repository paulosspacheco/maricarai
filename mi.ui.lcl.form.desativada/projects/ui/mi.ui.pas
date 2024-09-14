program mi.ui;
{:< O programa **@name** é usado para testar o pacote mi.db configurado para gerar código para: win32, win64 e linux.

  - **VERSÃO**:
    - lpha - 0.4.0.44

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.ui.tests.pas">mi.ui.tests.pas.pas</a>)
}

{$IFDEF FPC}
  {$MODE Delphi} {$H-}
{$ENDIF}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces,

  Forms, sdflaz, lazcontrols,
  drivers,
  LCLIntf,
  dialogs,
  dos, mi.ui.tests;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='mi.ui';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMi_ui_tests, Mi_ui_tests);
  Application.Run;
end.





