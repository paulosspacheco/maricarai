program mi.ui.lcl.form.AddTemplates;
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
  dos, Unit1;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.





