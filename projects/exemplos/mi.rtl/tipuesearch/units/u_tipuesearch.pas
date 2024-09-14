unit u_TipueSearch;

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
  Classes, SysUtils,mi.rtl.Objects.Methods.pageproducer,mi.rtl.miStringlist
  ,u_conts_mapa_site;


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

      {: O evento **@name** usa o arquivo './templates/tipuesearch/tipuesearch_content.js'
         para criar o documento **HTMLContent**.
      }
      protected procedure On_tipuesearch_Undefined(Sender: TObject; const TagString: string; TagParams: TStrings; var ReplaceText: string);

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

uses internetAccess, LazFileUtils, simpleinternet
  ,bbutils
  ,xquery;


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

{ TStringListTagsKey }

type
   { TStringListTagsKey }
   {: A classe **@name** usada para criar o campo ~tags do template:
        file_path = [ title: "~title", text: "~text", tags: "~tags", url: "~url" ]
   }
   TStringListTagsKey = class(TMiStringList)


     {: O método **@name** receber um texto qualquer e adiciona na lista todas as
        palavras  cujo o tamanho seja maior que 3 e não exista na lista até o momento
     }
     public Procedure AddRecords( aStrings:AnsiString);

     function RecordsToString():AnsiString;

   end;

procedure TStringListTagsKey.AddRecords(aStrings: AnsiString);
  Var
    i,Nrec : integer;
    s : Ansistring;
begin
  if aStrings = ''
  then exit;

  with TPageProducer do
  begin
    aStrings := ChangeSubStr(CR  , ' ' ,aStrings);
    aStrings := ChangeSubStr(LF  , ' ' ,aStrings);
//    aStrings := ChangeSubStr(''  , ' ' ,aStrings);
    aStrings := ChangeSubStr('➚' , ' ' ,aStrings);
    aStrings := ChangeSubStr('🔝' , ' ' ,aStrings);
    aStrings := ChangeSubStr('🔙' , ' ' ,aStrings);
  end;
  s := '';
  Nrec := 0;
  for i  := 0 to length(aStrings) do
  begin
    case aStrings[i] of
      '"'  : begin s := s + '''' end;
      ' ' : begin //Adiciona s em list;
              if length(s)> 3
              Then begin
                     if not FindKey(s)
                     then begin
                            addkey(s,NRec);
                            inc(NRec);
                           end;
                   end ;
              s := '';
            end;
      ';',
      ',',
      '.',
      ':' : begin
              //ignora
            end

      else begin
             s := s + aStrings[i];
           end;
    end;
  end;
end;

function TStringListTagsKey.RecordsToString():AnsiString;
  var s:Ansistring;
begin
  Result := '';
  ClearKey;
  if BofKey then
  begin
   While not EofKey do
   begin
     if Index_Currente < Count
     then s := Get(Index_Currente)
     else s :='';
     Result := Result +s+' ';
     NextKey;
   end;

  end
  else Result := '';

end;

{ TIndex_Tipuesearch }

constructor TIndex_Tipuesearch.create(aOwner: TComponent);
  var
    s : Ansistring;
begin
  inherited create(aOwner);
  OnHTMLTag_Undefined := @On_tipuesearch_Undefined;
  ListFiles:= TStringList.Create;
  s:= ExtractFileDir(ExpandFileName(ParamStr(0))) ;
  s := s+'/templates/tipuesearch/tipuesearch_content.js';
  HTMLFile:= s;
  HTMLFileResult := HTMLFileResult_json;
end;

destructor TIndex_Tipuesearch.destroy;
begin
  Freeandnil(ListFiles);
  inherited destroy;
end;

procedure TIndex_Tipuesearch.On_tipuesearch_Undefined(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);

  var StringListTagsKey : TStringListTagsKey;

  function getTitle(Const aFileName:string):String;
   var
     v: IXQValue;
     p : integer;
     s:string;
  begin
    try
      s := ExtractFileDir(HTMLFileResult)+PathDelim+ aFileName;
      s := '"file:///'+s+'")';
      v := query(
//      'for $x in doc("file:///'+ExpandFileName(aFileName)+'")/html/head/title'+
      'for $x in doc('+s+'/html/head/title'+
      ' order by $x'+
      ' return $x'
      );
      result := v.toString;

      //Remove o link do título que abre a página em uma janela independente
      if pos('<a',result) <> 0
      Then begin
             p := pos('<a',result);
             result := system.copy(Result,1,p-1);
        end;

    except
      result := ExtractFileName(aFileName);
    end;

  end;

  function getTags(Const aFileName:string):String;
    var
      v: IXQValue;
      p : integer;
      S : string;
  begin
    try
      s := ExtractFileDir(HTMLFileResult)+PathDelim+ aFileName;
      s := '"file:///'+s+'")';
      v := query(
      'for $x in doc('+s+'/html/body'+
//      ' order by $x'+
      ' return <li>{data($x)}</li>'
      );
      result := v.toString;
      StringListTagsKey.Clear;
      StringListTagsKey.AddRecords(result);
      result := StringListTagsKey.RecordsToString();
    except
      result := ExtractFileName(aFileName);
    end;

  end;

  function getDescription(Const aFileName:string):String;
    var
      v: IXQValue;
      p : integer;
      s:string;
   begin
     try
       s := ExtractFileDir(HTMLFileResult)+PathDelim+ aFileName;
       s := '"file:///'+s+'")';

       //Expressão abaixo peguei do chatgpt.
       v := query(
          'let $description :=  doc('+s+'/html//meta[@name="description"] '+
          'return data($description/@content)'
         );
       result := v.toString;
     except
       result := ExtractFileName(aFileName);
     end;

   end;


////file_path = { title: "~title", text: "~text", tags: "~tags", url: "~url" },
//var tipuesearch = {
//  pages: [
//  <!--# file_path #-->
//  ],
//};
//
  var
    s,t,FileName:String;
    template : string = '{ title: "~title", text: "~text", tags: "~tags", url: "~url" }';
    i : integer = 0;
    si : integer = 0;

begin
  if AnsiCompareText(TagString, 'files_path') = 0 then
  begin
    // Retorna todos os arquivos da pasta e subpastas
    s := ExtractFileDir(HTMLFileResult);
    FindFilesAll(s,'*.html',faArchive,true,ListFiles );
    si := ListFiles.Count;
    write(si);
    try
      StringListTagsKey := TStringListTagsKey.Create(100,true);
      // Produz o resultado
      for FileName in ListFiles do
      begin
        if (Pos('node_modules',FileName) = 0) and
           (Pos('/rust',FileName) = 0) and
           (Pos('/r',FileName) = 0)
        then
        begin
          s := template;
          s := StringReplace(s, '~title'  , getTitle(FileName) , [rfReplaceAll]);
          s := StringReplace(s, '~text'   , getDescription(FileName)              , [rfReplaceAll]);
          s := StringReplace(s, '~tags'   , getTags(FileName)  , [rfReplaceAll]);
          s := StringReplace(s, '~url'    , FileName            , [rfReplaceAll]);

          inc(i);
          if i < ListFiles.Count
          then ReplaceText := ReplaceText + s +','+New_Line
          else ReplaceText := ReplaceText + s + New_Line;
        end;
      end;
    finally
      Freeandnil(StringListTagsKey);
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




