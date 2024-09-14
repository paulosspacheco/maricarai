program create_tipuesearch;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  ,u_conts in 'units\u_conts.pas'
  ,u_dm_tipuesearch in 'units\u_dm_tipuesearch.pas'
  ,u_dm_mapa_site in 'units\u_dm_mapa_site.pas';


type

  { TMyApplication }

  TMyApplication = class(TCustomApplication)
  protected
    Procedure MyDoRun;
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TMyApplication }


Procedure TMyApplication.MyDoRun;
var err : integer;
begin
  if ParamStr(1) <> ''
  then HTMLFileResult_json:= ParamStr(1)
  else HTMLFileResult_json:= ExpandFileName(GetCurrentDir)+'/tipuesearch_content.js';

  if ParamStr(2) <> ''
  then HTMLFileResult_mapa_site:= ParamStr(1)
  else HTMLFileResult_mapa_site:= ExpandFileName(GetCurrentDir)+'/mapa_do_site.html';

  //CRIA O ARQUIVO JSON  tipuesearch_content.js
    //writeLn('Criando arquivo: "'+HTMLFileResult_json+'/tipuesearch_content.js"...');
    //Err:=CrateIndexTipuesearch;
    //if Err <>0
    //Then WriteLn('Error: ',Inttostr(Err))
    //else begin
    //       writeLn('Criado arquivo: "'+HTMLFileResult_json+'/tipuesearch_content.js".');
    //     end;

  //CRIA O ARQUIVO HTML mapa_do_site.html
    writeLn('Criando arquivo: "'+HTMLFileResult_mapa_site+'"...');
    Err:=create_mapa_site;
    if Err <>0
    Then WriteLn('Error: ',Inttostr(Err))
    else begin
           writeLn('Criado arquivo: "'+HTMLFileResult_mapa_site+'".');
         end;
end;

procedure TMyApplication.DoRun;
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
  MyDoRun;

  // stop program loop
  Terminate;
end;

constructor TMyApplication.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TMyApplication.Destroy;
begin
  inherited Destroy;
end;

procedure TMyApplication.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TMyApplication;
begin
  Application:=TMyApplication.Create(nil);
  Application.Title:='create tipuesearch';
  Application.Run;
  Application.Free;
end.


//uses
//  {$IFDEF UNIX}
//  cthreads,
//  {$ENDIF}
//  Classes, SysUtils, CustApp
//  ,u_conts in 'units\u_conts.pas'
//  ,u_dm_tipuesearch in 'units\u_dm_tipuesearch.pas'
//  ,u_dm_mapa_site in 'units\u_dm_mapa_site.pas'
//  ;
