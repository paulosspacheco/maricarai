unit u_criate_index_stork;
{:< O programa **@name** cria o arquivo .

    - **VERSÃO**
      - Alpha - Alpha - 0.1.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/u_criate_index_stork.pas">u_criate_index_stork.pas</a>)

    - **OBJETIVO**
      - Esta unit tem como missão criar o arquivo **index_stork.torm** para
        ser usado como parâmetro do programa **rust stork** executado na raiz
        do site a ser criado o arquivo **list_stork.st**.
      - O programa de linha de comando **stork**, receberá o arquivo de configuração
        **.index_stork.toml** e criará o arquivo de índice **list_stork.st** para
        ser uado como índice do programa **stornk.js**. O arquivo é blob serializado
        e compactado que a biblioteca Stork Javascript utiliza.
        Geralmente tem a extensão de arquivo de nome **.st** e tem aproximadamente
        o tamanho de um **JPEG**.

      - Para criar um índice de pesquisa, o projeto Stork requer que se crie
        um arquivo de configuração que declare quais documentos devem ser
        indexados. Este arquivo de configuração deve ter o formato de arquivo
        **TOML**.
        - **EXEMPLO**:

          ```pascal

            [input]
               base_directory = ""
               url_prefix = ""
               files = [
              ]

          ```
    - **NOTAS**
      - Este unit espera o arquivo que o arquivo './templates/stork/index_stork.toml'
        existe e tenha a tag **files_path**

    - **HISTÓRICO**
      - Criado por: Paulo Pacheco paulosspacheco@@yahoo.com.br)

      - **2023-09-12
        - 14:00 as 17:00
          - Criar unit **@name**; ✅
          - Craar classe TIndex_stork;
          - Criar function CrateIndexStork:Integer;

      - **2023-09-14
        - 08:32 as 11:50
          - Criar métodos
            - Create;
            - Destroy;
            - toml_Undefined;
            - CrateIndexStork
            -
          - Documentar unit **@name**;
          -

}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,mi.rtl.Objects.Methods.pageproducer;



type

   { TIndex_stork }
   {: A classe **@name** tem como objetivo criar o arquivo de configuração
      **index_stork.toml** que programa rust **stork** usa para crie o meta-dados
      **index_stork.st** para o programa javascript **stork.js**.

      - Template usado:
        - Nome do arquivo de templates:
          - './templates/stork/index_stork.toml'


        ```pascal

          [input]
          base_directory = ""
          url_prefix = ""
          files = [

            <!--# file_path #-->

          ]


        ```

   }
   TIndex_stork= class(TPageProducer)
      public constructor create(aOwner:TComponent);override;
      public destructor destroy;override;

      {: O método **@name** usa o arquivo './templates/stork/index_stork.toml'
         para criar o documento **HTMLContent**.
      }
      protected procedure toml_Undefined(Sender: TObject; const TagString: string; TagParams: TStrings; var ReplaceText: string);

      {: O método **@name** salva a propriedade **HTMLContent** no arquivo
         **'./index_stork.torm'**

         - Objetivo:
           - O arquivo **'./index_stork.torm'** é usado pelo rograma rust  **stork** para
             criar o arquivo **list_stork.st**  usado pelo programa **stork.js** do site.

         - Após execução deste método, executar o comando abaixo no prompt do
           sistema operacional.

           ```pascal

             # Cria índice para stork.js
             stork build --input index_stork.toml --output list_stork.st

           ```
      }
      Public function CrateIndexStork:Integer;

      private var ListFiles: TStringList;
   end;

   Function CrateIndexStork:Integer;

implementation


Function CrateIndexStork:Integer;
  Var
    Index_stork : TIndex_stork;
begin
   try
     Index_stork := TIndex_stork.create(nil);
     Result      := Index_stork.CrateIndexStork;
   finally
     Index_stork.Free;
   end;

end;


{ TIndex_stork }

constructor TIndex_stork.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  ListFiles:= TStringList.Create;
  OnHTMLTag_Undefined := @toml_Undefined;

  HTMLFile:=ExpandFileName('./templates/stork/index_stork.toml');
  HTMLFileResult := ExpandFileName('./index_stork.toml');
end;

destructor TIndex_stork.destroy;
begin
  Freeandnil(ListFiles);
  inherited destroy;
end;

procedure TIndex_stork.toml_Undefined(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);

//[input]
//base_directory = ""
//url_prefix = ""
//files = [
// {path = "~path",  url = "~url", title = "~title"},
// {path = "./historico.html",  url = "./historico.html", title = "Histórico das ocorrência do Blog"},
//]

  var
    s,FileName:String;
    template : string = '{  path = "~path",  url = "~url", title = "~title"},';
    i : integer = 0;
begin

  if AnsiCompareText(TagString, 'files_path') = 0 then
  begin
    // Retorna todos os arquivos da pasta e subpastas
//    FindFilesAll('','*.html *.pas *.md',faArchive,true,ListFiles );
    FindFilesAll('','*.html',faArchive,true,ListFiles );
    // Produz o resultado
    for FileName in ListFiles do
    begin
      inc(i);
      s := template;
      s := StringReplace(s, '~path'   , FileName   , [rfReplaceAll]);
      s := StringReplace(s, '~url'    , FileName, [rfReplaceAll]);
      s := StringReplace(s, '~title'  , ExtractFileName(FileName) , [rfReplaceAll]);
      ReplaceText := ReplaceText + s + New_Line;
    end;
  end
  else ReplaceText:='A tag <'+TagString+'>não conhecida';
end;

function TIndex_stork.CrateIndexStork: Integer;
  Var
    aPath:String;
begin
  aPath := ExtractFileDir(HTMLFile);
  if not DirectoryExists(aPath)
  then begin
         WriteLn('A pasta ./templates/stork/ não existe.');
         Result := PathNaoEncontrado;
         exit;
       end;

  if not FileExists(HTMLFile)
  then begin
         WriteLn('O arquivo de modelo '+HTMLFile+' não existe.');
         Result := ArquivoNaoEncontrado2;
         exit;
       end;

  result := SaveHTMLContentToFile;
end;

end.

