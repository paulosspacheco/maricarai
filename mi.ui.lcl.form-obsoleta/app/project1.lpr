program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces // this includes the LCL widgetset
  //,Forms
  ,uMi_ui_Application_lcl
  ;

{$R *.res}

begin
  SetRequireDerivedFormResource(True);
  Application.Scaled:=True;
  Application.Initialize;
  Application.Run;
end.

