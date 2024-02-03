program project1;

{$mode objfpc}

uses
  nodejsapp, JS, Classes, SysUtils, nodeJS
  ,mi.rtl.applicationabstract
  ,mi.rtl.class_of_char;

type
  TMyApplication = class(TNodeJSApplication)
    procedure DoRun; override;
  end;

procedure TMyApplication.DoRun;

begin
  // Your code here
  Terminate;
end;

var
  Application : TMyApplication;

begin
  Application:=TMyApplication.Create(nil);
  Application.Initialize;
  Application.Run;
end.
