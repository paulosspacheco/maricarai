unit u_mapa_site;
{:< O programa **@name** cria o arquivo **template_pssp_app_br.html** com todas
    as URLs  contidos em ./tipuesearch_content.js.

    - **VERSÃO**
      - Alpha - Alpha - 0.1.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/u_mapa_site.pas">u_mapa_site.pas</a>)

    - **OBJETIVO**
      - Este programa tem como missão criar o arquivo **mapa_do_site.html**

    - **NOTAS**
      - Este unit espera o arquivo que o arquivo './tipuesearch_content.js'
        para servir como conteúdo da tag ~conteudo

    - **HISTÓRICO**
      - Criado por: Paulo Pacheco paulosspacheco@@yahoo.com.br)

      - **2023-10-26
        - 14:00 as 09:16
          - Criar unit **@name**; ✅
}

{$mode ObjFPC}{$H+}

interface
uses
  Classes, SysUtils,mi.rtl.Objects.Methods.pageproducer,mi.rtl.miStringlist
  ,u_conts_mapa_site
  , fpjson, jsonparser, jsonscanner,fileutil;


 type
   { TMapa_site }
   {: A classe **@name** tem como objetivo criar o arquivo ./pssp_app_br.html
      com os links apontador pelo arquivo tipuesearch_content.js criado pela
      classe TIndex_Tipuesearch     .

      - Template usado:
        - Nome do arquivo de templates:
          - './templates/template_pssp_app_br.html'

          - Tags atualizadas no template:
            - ~title
              - Mapa do site
            - ~createDate
              - Data da criação da página
            - ~createDateUpdate
              - Data da última atualização da página
            - ~description
              - Mapa do site pssp.app.br
            - ~keywords
              - Memórias do Paulo Sérgio da silva pacheco
            - ~conteudo
              - Links da pasta corrente e subpastas cujo a extenção seja .html
   }
   TMapa_site= class(TPageProducer)
      public constructor create(aOwner:TComponent);override;
      public destructor destroy;override;

        {: O método **@name** cria o mapa do site baseado no arquivo
           **./tipuesearch_content.js** salvo em _SaveHTMLContentToFile_.
        }
        protected Function get_Contudo : String;

      {: O evento **@name** usa o arquivo './templates/template_pssp_app_br.html'
         para criar o documento **HTMLContent**.
      }
      protected procedure On_mapa_site_Undefined(Sender: TObject; const TagString: string; TagParams: TStrings; var ReplaceText: string);


      public function create_mapa_site: Integer;

      private
        var jsonText  : TStringList;
        var JsonStr   : TJSONStringType;
        var s1        : TJSONStringType;
        var JsonData  : TJSONData;

    end;

    Function create_mapa_site : integer;
implementation
  uses
    StrUtils;

function create_mapa_site: integer;
Var
  Mapa_site : TMapa_site;
begin
 try
   Mapa_site := TMapa_site.create(nil);
   Result    := Mapa_site.create_mapa_site ;

 finally
   Mapa_site.Free;
 end;

end;

constructor TMapa_site.create(aOwner: TComponent);
  var
    s : Ansistring;
    p :integer;
begin
  inherited create(aOwner);
  //Habilita evento OnHTMLTag_Undefined
  OnHTMLTag_Undefined := @On_mapa_site_Undefined;

  // Crie um objeto TStringList para armazenar o conteúdo do arquivo.
  jsonText := TStringList.Create;

  //Carrega json do arquivo
  jsonText.LoadFromFile(HTMLFileResult_json);

  //Deleta os caracteres New_Line de JSONStr
  JsonStr := DeleteChars(jsonText.Text,[cr,lf]);

  //Remove a expressão: 'var On_mapa_site ='
  if pos('var tipuesearch =',JSonStr)<> 0
  Then system.Delete(JsonStr,1,length('var tipuesearch ='));

  //Inicia o ponteiro JsonData
  JsonData := GetJSON(JsonStr);


  s := ExtractFileDir(ExpandFileName(ParamStr(0))) ;
  s := s+'/templates/template_pssp_app_br.html';
  HTMLFile := s;

  HTMLFileResult := HTMLFileResult_mapa_site;
end;

destructor TMapa_site.destroy;
begin
  jsonText.free;
  inherited destroy;
end;

function TMapa_site.get_Contudo : String;

 var
   PagesArray: TJSONArray;
   i         : integer;
   s         : String;

begin

  HTMLFileResult_mapa_site := IncludeTrailingPathDelimiter(ExtractFileDir(HTMLFileResult_json))+'mapa_do_site.html';
  try
    result := '';
    if FileExists(HTMLFileResult_json)  then
    begin
      try
      if JsonData is TJSONObject then
      begin
         try
          PagesArray := TJSONObject(JsonData).Arrays['pages'];

          for I := 0 to PagesArray.Count - 1 do
          begin
            result := result + 'Title: '+ PagesArray.Objects[I].Get('title', '');
            result := result + 'Text:  '+ PagesArray.Objects[I].Get('text', '');
            result := result + 'Tags:  '+ PagesArray.Objects[I].Get('tags', '');
            result := result + 'URL:   '+ PagesArray.Objects[I].Get('url', '')+new_line;
          end;

         finally
           PagesArray.Free;
         end;
      end;

      finally


      end;


    end;

  except
    on E: Exception do
      writeln('Erro: ', E.Message);
  end;

end;

procedure TMapa_site.On_mapa_site_Undefined(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
begin
//   Mapa_site.get_Contudo;
  case AnsiIndexStr(UpperCase(TagString),
       ['~TITLE','~CREATEDATE','~CREATEDATEUPDATE','~DESCRIPTION','~KEYWORDS','~CONTEUDO']) of
    0 : {'~TITLE' }      ReplaceText := Alias;
    1 : {'~CREATEDATE' } ReplaceText := '';
    2 : {'~CREATEDATEUPDATE' } ReplaceText := '';
    3 : {'~DESCRIPTION' } ReplaceText := 'Mapa do site pssp.app.br';
    4 : {'~KEYWORDS' } ReplaceText := '';
    5 : {'~CONTEUDO' } ReplaceText := get_Contudo;
    else ReplaceText := 'erro: Tag indefiida...';
  end;
end;

function TMapa_site.create_mapa_site: Integer;
  Var
    aPath:String;
begin
  aPath := ExtractFileDir(HTMLFile);
  if not DirectoryExists(aPath)
  then begin
         WriteLn('A pasta ./templates não existe.');
         Result := PathNaoEncontrado;
         exit;
       end;

  if not FileExists(HTMLFile)
  then begin
         WriteLn('O arquivo de modelo do mapa do site '+HTMLFile+' não existe.');
         Result := ArquivoNaoEncontrado2;
         exit;
       end;
  if OnHTMLTag_Undefined <> nil
  Then result := SaveHTMLContentToFile
  else result := -1;

end;

end.

