unit u_Create_Tipue_Search;
{:< O programa **@name** cria o arquivo **tipuesearch_content.js**.

    - **VERSÃO**
      - Alpha - Alpha - 0.1.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/u_create_tipue_search.pas">u_Create_Tipue_Search.pas</a>)

    - **OBJETIVO**
      - Este programa tem como missão criar o arquivo **tipuesearch_content.js**
        a ser usado como índex de pesquisa de um site qualquer.

      - Para criar um índice de pesquisa, o projeto Tipuesearch requer que se crie
        um arquivo **Json** de configuração que declare quais documentos devem ser
        indexados. Este arquivo de configuração deve ter o formato de arquivo
        **JSON**.
        - **EXEMPLO**:

          ```pascal

            //file_path = { title: "~title", text: "~text", tags: "~tags", url: "~url" },
            var tipuesearch = {
              pages: [
              <!--# file_path #-->
              ],
            };


          ```
    - **NOTAS**
      - Este unit espera o arquivo que o arquivo './templates/tipuesearch/tipuesearch_content.js'
        existe e tenha a tag: **files_path**

    - **HISTÓRICO**
      - Criado por: Paulo Pacheco paulosspacheco@@yahoo.com.br)

      - **2023-09-25
        - 14:00 as 09:16
          - Criar unit **@name**; ✅

}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils,mi.rtl.Objects.Methods.pageproducer;



type

   { TIndex_Tipuesearch }
   {: A classe **@name** tem como objetivo criar o arquivo de configuração json
      **tipuesearch_content.js** o programa javascript **tipuesearch.js**.

      - Template usado:
        - Nome do arquivo de templates:
          - './templates/tipuesearch/tipuesearch_content.js'


        ```pascal

          //file_path = { title: "~title", text: "~text", tags: "~tags", url: "~url" },
          var tipuesearch = {
            pages: [
            <!--# file_path #-->
            ],
          };


        ```

   }
   TIndex_Tipuesearch= class(TPageProducer)
      public constructor create(aOwner:TComponent);override;
      public destructor destroy;override;

      {: O método **@name** usa o arquivo './templates/tipuesearch/tipuesearch_content.js'
         para criar o documento **HTMLContent**.
      }
      protected procedure tipuesearch_Undefined(Sender: TObject; const TagString: string; TagParams: TStrings; var ReplaceText: string);

      {: O método **@name** salva a propriedade **HTMLContent** no arquivo
         **'./tipuesearch_content.js'**

         - Objetivo:
           - O arquivo **'./tipuesearch_content.js'** é usado pelo programa **tpuesearch.js** do site.
           ```
      }
      Public function CrateIndexTipuesearch:Integer;

      private var ListFiles: TStringList;
   end;

   Function CrateIndexTipuesearch:Integer;

implementation


Function CrateIndexTipuesearch:Integer;
  Var
    Index_Tipuesearch : TIndex_Tipuesearch;
begin
   try
     Index_Tipuesearch := TIndex_Tipuesearch.create(nil);
     Result      := Index_Tipuesearch.CrateIndexTipuesearch;
   finally
     Index_Tipuesearch.Free;
   end;

end;


{ TIndex_Tipuesearch }

constructor TIndex_Tipuesearch.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  ListFiles:= TStringList.Create;
  OnHTMLTag_Undefined := @tipuesearch_Undefined;

  HTMLFile:=ExpandFileName('./templates/tipuesearch/tipuesearch_content.js');
  HTMLFileResult := ExpandFileName('./tipuesearch_content.js');
end;

destructor TIndex_Tipuesearch.destroy;
begin
  Freeandnil(ListFiles);
  inherited destroy;
end;

procedure TIndex_Tipuesearch.tipuesearch_Undefined(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);

////file_path = { title: "~title", text: "~text", tags: "~tags", url: "~url" },
//var tipuesearch = {
//  pages: [
//  <!--# file_path #-->
//  ],
//};
//
  var
    s,FileName:String;
    template : string = '{ title: "~title", text: "~text", tags: "~tags", url: "~url" },';
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
      s := StringReplace(s, '~title'  , ExtractFileName(FileName) , [rfReplaceAll]);
      s := StringReplace(s, '~text'   , ''  , [rfReplaceAll]);
      s := StringReplace(s, '~tags'   , ''  , [rfReplaceAll]);
      s := StringReplace(s, '~url'    , FileName  , [rfReplaceAll]);

      ReplaceText := ReplaceText + s + New_Line;
    end;
  end
  else ReplaceText:='A tag <'+TagString+'>não conhecida';
end;

function TIndex_Tipuesearch.CrateIndexTipuesearch: Integer;
  Var
    aPath:String;
begin
  aPath := ExtractFileDir(HTMLFile);
  if not DirectoryExists(aPath)
  then begin
         WriteLn('A pasta ./templates/tipuesearch/ não existe.');
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



