program create_config_stork;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  ,mi.rtl.objectss


  { you can add units after this };

type

  { TAppStork }

  TAppStork = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TAppStork }

procedure TAppStork.DoRun;
var
  ErrorMsg: String;
begin
  // quick check parameters
  ErrorMsg:=CheckOptions('h', 'help');
  if ErrorMsg<>'' then begin
    ShowException(Exception.Create(ErrorMsg));
    Terminate;
    Exit;
  end;

  // parse parameters
  if HasOption('h', 'help') then begin
    WriteHelp;
    Terminate;
    Exit;
  end;

  { add your program here }

  writeLn('Inicio do projeto');

  // stop program loop
  Terminate;
end;

constructor TAppStork.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TAppStork.Destroy;
begin
  inherited Destroy;
end;

procedure TAppStork.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');

end;

var
  Application: TAppStork;
begin
  Application:=TAppStork.Create(nil);
  Application.Title:='Create config do projeto Stork';
  Application.Run;
  Application.Free;
end.

