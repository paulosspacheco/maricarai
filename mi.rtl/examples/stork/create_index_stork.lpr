program create_index_stork;
{:< O programa **@name** cria o arquivo  **index_stork.toml** para o projeto stork.

    - **Objetivo**
      - Este programa tem como missão criar o arquivo **index_stork.torm** para
        ser usado como parâmetro do programa **rust stork** executado na raiz
        do site a ser criado o arquivo **list_stork.st**.
      - O programa de linha de comando **stork**, receberá o arquivo de configuração
        **.index_stork.toml** e criará o arquivo de índice **list_stork.st** para
        ser uado como índice do programa **stornk.js**. O arquivo é blob serializado
        e compactado que a biblioteca Stork Javascript utiliza.
        Geralmente tem a extensão de arquivo de nome **.st** e tem aproximadamente
        o tamanho de um **JPEG**.

    - **NOTAS**     
        - Este programa espera que o arquivo  **'./templates/stork/index_stork.toml'**
          exista e contenha a tag **files_path** em seu conteúdo.
          - Template esperado:

            ```pascal

              [input]
              base_directory = ""
              url_prefix = ""
              files = [

               <!--# file_path #-->

              ]


            ```  
      - 
    - **VERSÃO**
      - Alpha - Alpha - 0.9.0

    - **CÓDIGO FONTE**:
      - @html(<a href="./create_index_stork.lpr">create_index_stork.lpr</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Pacheco paulosspacheco@@yahoo.com.br)

      - **2023-09-12
        - 14:00 as 17:00
          - Criar projeto **@name**; ✅
          - Criar unit u_criate_index_stork.pas ✅
          - Criar documento do projeto;✅
          -

      - **2023-09-14
        - 11:21 as 11:50
          - Criar documento do projeto;
          -
}
{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, CustApp
  ,mi.rtl.objectss, u_criate_index_stork


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

  writeLn('Criando arquivo: "./index_stork.toml"...');
  Err:=CrateIndexStork;
  if Err <>0
  Then WriteLn('Error: ',Inttostr(Err))
  else begin
         writeLn('Criado arquivo: "./index_stork.toml".');
         //('stork build --input index_stork.toml --output list_stork.st');
       end;

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
  writeLn;
  { add your help code here }
  writeln('Usage: ', ExeName, ' -h');

  writeln('  - Objetivo:');
  writeln('    - Este programa tem como missão criar o arquivo **index_stork.torm** para');
  writeln('      ser usado como parâmetro do programa **rust stork** executado na raiz');
  writeln('      do site a ser criado o arquivo **list_stork.st**.');
  writeln('    - O programa de linha de comando **stork**, receberá o arquivo de configuração');
  writeln('      **.index_stork.toml** e criará o arquivo de índice **list_stork.st** para');
  writeln('      ser uado como índice do programa **stornk.js**. O arquivo é blob serializado');
  writeln('      e compactado que a biblioteca Stork Javascript utiliza.');
  writeln('      Geralmente tem a extensão de arquivo de nome **.st** e tem aproximadamente');
  writeln('      o tamanho de um **JPEG**.');  


end;

var
  Application: TAppStork;
begin
  Application:=TAppStork.Create(nil);
  Application.Title:='Create config do projeto Stork';
  Application.Run;
  Application.Free;
end.

