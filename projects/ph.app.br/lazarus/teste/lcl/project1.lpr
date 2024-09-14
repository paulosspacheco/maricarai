program project1;
{:< O projeto **@name** é usado como modelo para projetos que usam os pacotes
    **mi.rtl**, **FCL**,**SQLDBLaz**, configurado para 3 alvos, sendo **linux**,
    **i386-win32** e  **x86_64-win64**.

- **Notas**:
  - Este projeto depende dos seguintes pacotes:
    - FCL;
    - SQLDBLaz
    - mi.rtl


- **Versão atual - @name**

  - Data em que esta versão foi criada: 27/02/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.1

- **Descrição das tarefas a fazer em @name**

- **27/02/2024**  a  **27/02/2024**
  - [x] Criar projeto @name**
  - [ ] Criar unit .pas
  - [ ] Documentar projeto
}


{$mode Delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, uclientes, uform_clientes2, CustApp
  , 
  ;

type

  { TMyApplication }

  TMyApplication = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TMyApplication }

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
  // A Unit abaixo pe auto criada na unit 
  // := T.Create(self);
  clientes := Tclientes.Create(self);

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
  Application.Title:='My Application';

  Application.Run;
  Application.Free;
end.


