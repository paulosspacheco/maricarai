program app_mi_rtl_console;
{:< O projeto **@name** é usado como modelo para projetos que usam o **pacote maricarai**
    com acesso a banco de dados SQL, onde o mesmo, está configurado para 3 alvos,
    sendo linux, i386-win32, x86_64-win64 e dois modelos de **datamodule** para
    acessar duas tabelas do banco de dados e os **templates maricaria** definido
    em cada datamodule.

- Notas:
  - A diferença do **DataModule1** e **datamodule2** é que no 1 é definido a conexão
    com o banco de dados e o datamodule2 é usado para acessar uma tabela do banco
    de dados conectado pelo datamodule1.
  - Este projeto depende dos seguintes pacotes:
    - **FCL**;
    - **SQLDBLaz**
    - **mi.rtl**

- **Versão atual - main**

  - Data em que esta versão foi criada: 11/01/2024
  - Versão atual: 0.0.1
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.0

- **Descrição das tarefas a fazer - db_console**

- **11/01/2024**  a  **11/01/2024**
  - [x] Criar projeto main
  - [x] Criar unit dm_unit1.pas
  - [x] Documentar projeto
}

{$mode delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
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

