unit u_dm_tipuesearch;

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
  Classes, SysUtils
  , mi.rtl.objects.methods.pageproducer
  , mi.rtl.miStringlist
  ,u_conts;


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


type

  { TDM_tipuesearch }
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
  TDM_tipuesearch = class(TDataModule)
    PageProducer1: TPageProducer;

    {: O evento **@name** inicializa o nome dos arquivos destino (HTMLFileResult)
       e o template (HTMLFile) bem como o atributo ListFiles.
    }
    procedure DataModuleCreate(Sender: TObject);

    {: O evento **@name** livra da memória as classes criada em .
    }
    procedure DataModuleDestroy(Sender: TObject);

    {: O evento **@name** usa o arquivo './templates/tipuesearch/tipuesearch_content.js'
       para criar o documento **HTMLContent**.
    }
    procedure PageProducer1HTMLTag_Undefined(Sender: TObject;const TagString: string; TagParams: TStrings; var ReplaceText: string);

    {: O método **@name** salva a propriedade **HTMLContent** no arquivo
       **'./tipuesearch_content.js'**

       - Objetivo:
         - O arquivo **'./tipuesearch_content.js'** é usado pelo programa **tpuesearch.js** do site.
         ```
    }
    Public function CrateIndexTipuesearch:Integer;

    private var ListFiles: TStringList;
  private

  public

  end;


  { TStringListTagsKey }



Function CrateIndexTipuesearch:Integer;

var
  DM_tipuesearch: TDM_tipuesearch;

implementation
{$R *.lfm}
uses internetAccess, LazFileUtils, simpleinternet
  ,bbutils
  ,xquery

  ,LConvEncoding, lclproc, LazUTF8
  ;


Function CrateIndexTipuesearch:Integer;
begin
   try
     DM_tipuesearch := TDM_tipuesearch.create(nil);;
     Result      := DM_tipuesearch.CrateIndexTipuesearch;
   finally
     freeandnil(DM_tipuesearch);

   end;

end;

{TStringListTagsKey--------------------------------------------}
  procedure TStringListTagsKey.AddRecords(aStrings: AnsiString);
    Var
      i : integer;
      Nrec   : PtrInt;
      s : Ansistring;
  begin
    if aStrings = ''
    then exit;

    with TPageProducer do
    begin
      aStrings := ChangeSubStr('#$00', ' ' ,aStrings);
      aStrings := ChangeSubStr(CR  , ' ' ,aStrings);
      aStrings := ChangeSubStr(LF  , ' ' ,aStrings);
      aStrings := ChangeSubStr('➚' , ' ' ,aStrings);
      aStrings := ChangeSubStr('🔝' , ' ' ,aStrings);
      aStrings := ChangeSubStr('🔙' , ' ' ,aStrings);
      aStrings := ChangeSubStr(')', ' ' ,aStrings);
      aStrings := ChangeSubStr('(', ' ' ,aStrings);

      aStrings := ChangeSubStr('[',' ' ,aStrings);
      aStrings := ChangeSubStr(']',' ' ,aStrings);

      aStrings := ChangeSubStr('{', ' ' ,aStrings);
      aStrings := ChangeSubStr('}',' ' ,aStrings);
      aStrings := ChangeSubStr('<', ' ' ,aStrings);
      aStrings := ChangeSubStr('>', ' ' ,aStrings);

      aStrings := ChangeSubStr('?', ' ' ,aStrings);
      aStrings := ChangeSubStr('!', ' ' ,aStrings);
      aStrings := ChangeSubStr(#0,  ' ' ,aStrings);
      aStrings := ChangeSubStr('\', ' ' ,aStrings);
      aStrings := ChangeSubStr('''', ' ' ,aStrings);
      aStrings := ChangeSubStr('~', ' ' ,aStrings);
      aStrings := ChangeSubStr('-',' ' ,aStrings);
      aStrings := ChangeSubStr('/',' ' ,aStrings);
      aStrings := ChangeSubStr(';',' ' ,aStrings);
      aStrings := ChangeSubStr(',',' ' ,aStrings);
      aStrings := ChangeSubStr('.',' ' ,aStrings);
      aStrings := ChangeSubStr(':',' ' ,aStrings);
      aStrings := ChangeSubStr('"',' ' ,aStrings);
      aStrings := ChangeSubStr('=',' ' ,aStrings);
      aStrings := ChangeSubStr('^',' ' ,aStrings);
      aStrings := ChangeSubStr('*',' ' ,aStrings);
      aStrings := ChangeSubStr('‘',' ' ,aStrings);
      aStrings := ChangeSubStr('’',' ' ,aStrings);
      aStrings := ChangeSubStr('+',' ' ,aStrings);



    end;
    s := '';
    Nrec := 0;
    for i  := 1 to length(aStrings) do
    begin
      case Upcase(aStrings[i]) of
        '"'  : begin s := s + '''' end;
        ' ' : begin //Adiciona s em list;
                if (length(s)> 3) and (length(s)<15)
                Then begin
                       if not FindKey(s)
                       then begin
                              addkey(s,TObject(NRec));
                              inc(NRec);
                             end;
                     end ;
                s := '';
              end;

        else begin
               s := s + aStrings[i];
             end;
      end;
    end;
  end;

  function TStringListTagsKey.RecordsToString():AnsiString;
    var
      s : string;
  begin
    Result := '';
    ClearKey;
    if BofKey then
    begin
     While not EofKey do
     begin
       if Index_Currente < Count
       then with TPageProducer do
            begin
              //Essa linha é usada pq no site pssp.app.br aparece chars com valores negativos.
              s := DeleteChars(Get(Index_Currente),[^M,^J]);
              //O padrão minimo para pesquisa no porjeto javascript tipuesearch é 3;
              if UTF8Length(s) > 3
              Then s := LowerCase(s)
              else s := '';
            end
       else s :='';
       if s <> ''
       then Result := Result +s+' ';

       NextKey;
     end;

    end
    else Result := '';

  end;


{ TDM_tipuesearch }

procedure TDM_tipuesearch.DataModuleCreate(Sender: TObject);
  var
    s : Ansistring;
begin
  with PageProducer1 do
  begin
    ListFiles:= TStringList.Create;

    s:= ExtractFileDir(ExpandFileName(ParamStr(0))) ;
    s := s+'/templates/tipuesearch/tipuesearch_content.js';
    HTMLFile:= s;
    s := HTMLFileResult_json;
    HTMLFileResult := HTMLFileResult_json;
  end;
end;

procedure TDM_tipuesearch.DataModuleDestroy(Sender: TObject);
begin
  ListFiles.free;
end;

procedure TDM_tipuesearch.PageProducer1HTMLTag_Undefined(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);



  var StringListTagsKey : TStringListTagsKey;

  function getTitle(Const aFileName:string):String;
   var
     v: IXQValue;
     p : integer;
     s:string;
  begin
    with PageProducer1 do
    try
      s := HTMLFileResult;
      s := ExtractFileDir(HTMLFileResult)+PathDelim+ aFileName;
      if FileSize(s)=0
      then begin
             result := '';
             exit;
           end;
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
    with PageProducer1 do
    try
      s := ExtractFileDir(HTMLFileResult)+PathDelim+ aFileName;
      if FileSize(s)=0
      then begin
             result := '';
             exit;
           end;

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
     with PageProducer1 do
     try
       s := ExtractFileDir(HTMLFileResult)+PathDelim+ aFileName;
       if FileSize(s)=0
       then begin
              result := '';
              exit;
            end;
       s := '"file:///'+s+'")';

       //Expressão abaixo peguei do chatgpt.
       v := query(
//          'let $description :=  doc('+s+'bin/html//meta[@name="description"] '+
          'let $description :=  doc('+s+'/html/meta[@name="description"] '+
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
//const  template : string = '{ title: "~title", text: "~text", tags: "~tags", url: "~url" }';
  const  template : string = '{url: "~url", title: "~title", text: "~text", tags: "~tags" }';

  var
    s,t,FileName,title:String;
    i : integer = 0;
    si : integer = 0;
  var
    Primeiro : Boolean = true;

//    Tamanho:Longint;
begin
  with PageProducer1 do
  if AnsiCompareText(TagString, 'files_path') = 0 then
  begin
    // Retorna todos os arquivos da pasta e subpastas
    s := ExtractFileDir(HTMLFileResult);
    FindFilesAll(s,'*.html',faArchive,true,ListFiles,true );
    si := ListFiles.Count;
    write(si);
    try
      StringListTagsKey := TStringListTagsKey.Create(100,true);
      // Produz o resultado
      for i := 0 to ListFiles.Count-1 do
      begin
        FileName := ListFiles.Strings[i];
        title := getTitle(FileName);
        if (title<>'') and
           (Pos('node_modules',FileName) = 0) and
           (Pos('/r',FileName) = 0)   //não seu porque mais os arquivos começando com r dá problema.
        then
        begin
          //if (Pos('/r',FileName) <> 0)
          //Then Begin
          // writeLn(FileName);
          //end;


          if not Primeiro
          then s := ','+New_Line+template
          else begin
                 s := template;
                 Primeiro := false;
               end;

          s := StringReplace(s, '~url'    , FileName , [rfReplaceAll]);
          s := StringReplace(s, '~title'  , title    , [rfReplaceAll]);
          s := StringReplace(s, '~text'   , getDescription(FileName)       , [rfReplaceAll]);
          s := StringReplace(s, '~tags'   , getTags(FileName) , [rfReplaceAll]);

          ReplaceText := ReplaceText + s;
        end;

      end;
    finally
      Freeandnil(StringListTagsKey);
    end;

  end
  else ReplaceText:='A tag <'+TagString+'>não conhecida';
end;

function TDM_tipuesearch.CrateIndexTipuesearch: Integer;
  Var
    aPath:String;
begin
  with PageProducer1 do
  begin
    aPath := ExtractFileDir(HTMLFile);
    if not DirectoryExists(aPath)
    then begin
           WriteLn('A pasta bin/templates/tipuesearch/ não existe.');
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
end;


end.

