program Create_Tipue_Search;
{:< O programa **@name** cria o arquivo  **tipuesearch_content.js** para o
    projeto tipue_Search.

    - **Objetivo**
      - Este programa tem como missão criar o arquivo **tipuesearch_content.js**
        a ser usado como índex de pesquisa de um site qualquer.

    - **NOTAS**
        - Este programa espera que o arquivo
          **'./templates/tipue_search/tipuesearch_content.js'** exista e contenha
           a tag **files_path** em seu conteúdo.

          - Template esperado:

            ```pascal

              //file_path = { title: "~title", text: "~text", tags: "~tags", url: "~url" },
              var tipuesearch = {
                pages: [
                <!--# file_path #-->
                ],
              };


            ```
      -
    - **VERSÃO**
      - Alpha - Alpha - 0.1.0

    - **CÓDIGO FONTE**:
      - @html(<a href="./Create_Tipue_Search.lpr">Create_Tipue_Search.lpr</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Pacheco paulosspacheco@@yahoo.com.br)

      - **2023-09-22
        - 14:40 - Criar projeto **@name**; ✅
        - 14:50 - Criar a unit u_Create_Tipue_Search;

}
{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp, u_Create_Tipue_Search
  { you can add units after this };

type

  { TTipue_Search }

  Ttipue_Search = class(TCustomApplication)
  protected
    procedure DoRun; override;
  public
    constructor Create(TheOwner: TComponent); override;
    destructor Destroy; override;
    procedure WriteHelp; virtual;
  end;

{ TTipue_Search }

procedure TTipue_Search.DoRun;
  var
    ErrorMsg: String;
    err : integer;

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

    writeLn('Criando arquivo: "./tipuesearch_content.js"...');
    Err:=CrateIndexTipuesearch;
    if Err <>0
    Then WriteLn('Error: ',Inttostr(Err))
    else begin
           writeLn('Criado arquivo: "./tipuesearch_content.js".');
         end;

  // stop program loop
  Terminate;
end;

constructor TTipue_Search.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  StopOnException:=True;
end;

destructor TTipue_Search.Destroy;
begin
  inherited Destroy;
end;

procedure TTipue_Search.WriteHelp;
begin
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');
end;

var
  Application: TTipue_Search;
begin
  Application:=TTipue_Search.Create(nil);
  Application.Title:='Tipue search';
  Application.Run;
  Application.Free;
end.

