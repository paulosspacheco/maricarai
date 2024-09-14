program cliente_chatgpt;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, uFormMain, uform_UsuarioController, uForm_Mi_rtl_WebModule_Custom
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Scaled:=True;
  Application.MainFormOnTaskbar:=True;
  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
//  Application.CreateForm(TForm_Mi_rtl_WebModule_Custom,Form_Mi_rtl_WebModule_Custom);
  Application.Run;
end.

