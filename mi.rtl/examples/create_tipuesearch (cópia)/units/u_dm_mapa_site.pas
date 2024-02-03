unit u_dm_mapa_site;

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
  Classes, SysUtils, mi.rtl.objects.methods.pageproducer
  ,mi.rtl.miStringlist
  ,u_conts
  , fpjson
  //, jsonparser, jsonscanner,fileutil

  ;

type

  { TDM_Mapa_site }
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
  TDM_Mapa_site = class(TDataModule)
    PageProducer1: TPageProducer;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

    {: O evento **@name** usa o arquivo './templates/template_pssp_app_br.html'
       para criar o documento **HTMLContent**.
    }
    procedure PageProducer1HTMLTag_Undefined(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);

    {: O método **@name** cria o mapa do site baseado no arquivo
       **./tipuesearch_content.js** salvo em _SaveHTMLContentToFile_.
    }
    protected Function get_Contudo : String;


  private
    var jsonText  : TStringList;
    var JsonStr   : TJSONStringType;
    var JsonData  : TJSONData;

  public function create_mapa_site: Integer;
  end;

  Function create_mapa_site : integer;

var
  DM_Mapa_site: TDM_Mapa_site;

implementation
{$R *.lfm}
uses
  StrUtils;

function create_mapa_site: integer;
begin
 try
   DM_Mapa_site := TDM_Mapa_site.create(nil);
   Result       := DM_Mapa_site.create_mapa_site ;

 finally
   freeandnil(DM_Mapa_site)
 end;

end;

{ TDM_Mapa_site }


procedure TDM_Mapa_site.DataModuleCreate(Sender: TObject);
var
  s : Ansistring;
  p :integer;
begin
  with PageProducer1 do
  begin
    //Habilita evento OnHTMLTag_Undefined

    // Crie um objeto TStringList para armazenar o conteúdo do arquivo.
    jsonText := TStringList.Create;

    //Carrega json do arquivo
    jsonText.LoadFromFile(HTMLFileResult_json);

    JsonStr := jsonText.Text;

    //Remove a expressão: 'var On_mapa_site ='
    if pos('var tipuesearch =',JSonStr)<> 0
    Then system.Delete(JsonStr,1,length('var tipuesearch ='));

    //Inicia o ponteiro JsonData
    JsonData := GetJSON(JsonStr,true);


    s := ExtractFileDir(ExpandFileName(ParamStr(0))) ;
    s := s+'/templates/template_pssp_app_br.html';
    HTMLFile := s;

    HTMLFileResult := HTMLFileResult_mapa_site;

  end;
end;

procedure TDM_Mapa_site.DataModuleDestroy(Sender: TObject);
begin
  jsonText.free;
end;

procedure TDM_Mapa_site.PageProducer1HTMLTag_Undefined(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var i : integer;
    s : string;
begin
//   Mapa_site.get_Contudo;
  with PageProducer1 do
  begin
    i := AnsiIndexStr(UpperCase(TagString),
         ['TITLE','CREATEDATE','CREATEDATEUPDATE','DESCRIPTION','KEYWORDS','CONTEUDO']);
    case i of
      0 : {'TITLE' }      ReplaceText := Alias;
      1 : {'CREATEDATE' } ReplaceText := '';
      2 : {'CREATEDATEUPDATE' } ReplaceText := '';
      3 : {'DESCRIPTION' } ReplaceText := 'Mapa do site pssp.app.br';
      4 : {'KEYWORDS' } ReplaceText := '';
      5 : {'CONTEUDO' } ReplaceText := get_Contudo;
      else ReplaceText := 'erro: Tag indefiida...';
    end;
    s := ReplaceText;
  end;



end;

{: Esta função espera que a URL da variável JsonData esteja em ordem alfabética}
function TDM_Mapa_site.get_Contudo: String;

  function ult_pasta(apath : string):String;
    var
      i : integer;
  begin
    Result := aPath;
    if Result <> '' then
    begin
      for i := length(aPath) downto 0 do
      begin
        if aPath[i] = PathDelim
        then begin
               result := Copy(APath,i+1,length(aPath));
               exit;
             end;
      end;
    end
    else Result := PathDelim;

  end;

  Function NivelCurrente(apath : string):integer;
    // 0 /
    // 1 /p1
    // 2 /p1/p2
    // 3 /p1/p2/p3
    var i : Byte;
  begin

     Result := 0;

     if apath <> '' then
     begin
//       apath := PathDelim+apath ;
       for i := 0 to length(aPath) do
       begin
         if aPath[i] = PathDelim
         then result := result +1;
       end;
     end;
  end;

  Function get_pasta(apath : Ansistring;aNivel:Integer):AnsiString;
    // 0 /
    // 1 /p1
    // 2 /p1/p2
    // 3 /p1/p2/p3
    var i,wNivel : integer;
        ch : ansiChar;
  begin
     Result := '';

     wNivel := 0;
     if apath <> '' then
     begin
//       apath := PathDelim+apath ;
       for i := 0 to length(aPath) do
       begin
         ch := apath[i];
         if (ch = PathDelim) and (wNivel < aNivel)
         then begin
                inc(wNivel);
                if wNivel = aNivel
                Then begin
                       if wNivel = 1
                       then result := copy(apath,1,i)
                       else begin
                              result := copy(apath,1,i);
                              while pos('PathDelim',result)<>0 do
                              begin
                                result := copy(apath,1,pos('PathDelim',result));
                              end;
                            end;
                       exit;
                     end;
               end;
       end;

       if Result = ''
       then Result := aPath;
     end;
  end;




 var
   PagesArray: TJSONArray;
   i,j         : integer;
   s,s1,s1ant,t1,t1ant,title         : String;

   //Título do grupo é adicionado toda vez que a pasta do link troca.
   TemplateOpenTitle : string = '<li><span class="rootTree">~pasta_title</span><ol class="children">';

   //Rodapé do título deve ser adicionado toda vez que a pasta do link troca.
   TemplateCloseTitle : string = '</ol></li>';

   // Usado para criar o link dentro do título
   template_link : string = '<li>'+^M+
                            '<a href="˜url" target="_blank">~title</a>'+PageProducer1.New_line+

                            '</li>';
begin

  HTMLFileResult_mapa_site := IncludeTrailingPathDelimiter(ExtractFileDir(HTMLFileResult_json))+'mapa_do_site.html';
  try
    result := '';

    with PageProducer1 do
    if FileExists(HTMLFileResult_json)  then
    begin
      try
        if JsonData is TJSONObject then
        begin
           try
            PagesArray := TJSONObject(JsonData).Arrays['pages'];
            s1    := '';
            s1ant := '';

            for I := 0 to PagesArray.Count - 1 do
            begin
              title :=  PagesArray.Objects[I].Get('title', '');
              if title<> '' then
              begin
                s1 := PagesArray.Objects[I].Get('url', '');
                s1 := ExtractFileDir(s1)+PathDelim;

                if (s1 <> s1ant) and (s1ant<>'')
                then Result := Result +  TemplateCloseTitle;

                if (CompareStr(ult_pasta(s1),ult_pasta(s1Ant))<>0)
                    and (NivelCurrente(s1)<>NivelCurrente(S1Ant)) and (s1<>s1Ant)
                    and (i <> PagesArray.Count - 1)
                then begin
                       for j := 1 to  NivelCurrente(s1) do
                       begin
                         s  := TemplateOpenTitle;
                         s := StringReplace(s, '~pasta_title',get_pasta(s1,j) , [rfReplaceAll])+new_line;
                         Result := Result +  s;
                       end;
                    end;
                end;

               //Gera o link
               s  := template_link;
               s := StringReplace(s, '~title',title , [rfReplaceAll]);
               s := StringReplace(s, '˜url'  , PagesArray.Objects[I].Get('url', '')   , [rfReplaceAll])+new_line;
               Result := Result +  s;
               s1ant := s1;
               //result := result + 'Title: '+ PagesArray.Objects[I].Get('title', '');
               //result := result + 'Text:  '+ PagesArray.Objects[I].Get('text', '');
               //result := result + 'Tags:  '+ PagesArray.Objects[I].Get('tags', '');
               //result := result + 'URL:   '+ PagesArray.Objects[I].Get('url', '')+new_line;


           end;
           Result := Result +  TemplateCloseTitle;

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

{
function TDM_Mapa_site.get_Contudo: String;
 var
   PagesArray: TJSONArray;
   i,j         : integer;
   s,s1,s1ant,s2,s2ant,title         : String;

   //Título do grupo é adicionado toda vez que a pasta do link troca.
   TemplateOpenTitle : string = '<li><span class="rootTree">~pasta_title</span><ol class="children">';

   //Rodapé do título deve ser adicionado toda vez que a pasta do link troca.
   TemplateCloseTitle : string = '</ol></li>';

   // Usado para criar o link dentro do título
   template_link : string = '<li>'+^M+
                            '<a href="˜url" target="_blank">~title</a>'+PageProducer1.New_line+

                            '</li>';
begin

  HTMLFileResult_mapa_site := IncludeTrailingPathDelimiter(ExtractFileDir(HTMLFileResult_json))+'mapa_do_site.html';
  try
    result := '';

    with PageProducer1 do
    if FileExists(HTMLFileResult_json)  then
    begin
      try
        if JsonData is TJSONObject then
        begin
           try
            PagesArray := TJSONObject(JsonData).Arrays['pages'];
            s1    := '';
            s1ant := '';
            s2Ant := '';
            for I := 0 to PagesArray.Count - 1 do
            begin
              title :=  PagesArray.Objects[I].Get('title', '');
              if title<> '' then
              begin
                s1 := PagesArray.Objects[I].Get('url', '');
                s1 := ExtractFileDir(s1)+PathDelim;

                if (s1 <> s1ant) and (s1ant<>'')
                then Result := Result +  TemplateCloseTitle;

                //Calcula os titles
                if (s1<>s1Ant) or (i <> PagesArray.Count - 1) then
                  for j := 1 to length(s1) do
                  begin
                    case s1[j] of
                      PathDelim : begin
                                    s2 := s1;
                                    if s2 <> s2ant
                                    then begin
//                                           s2 := Copy(s1,j,length(s1));
                                           s  := TemplateOpenTitle;
                                           s := StringReplace(s, '~pasta_title',s2 , [rfReplaceAll])+new_line;
                                           Result := Result +  s;
                                         end;
                                    s2ant := s2;
                                   end;
                    end;
                  end;

               //Gera o link
               s  := template_link;
               s := StringReplace(s, '~title',title , [rfReplaceAll]);
               s := StringReplace(s, '˜url'  , PagesArray.Objects[I].Get('url', '')   , [rfReplaceAll])+new_line;
               Result := Result +  s;
               s1ant := s1;
               //result := result + 'Title: '+ PagesArray.Objects[I].Get('title', '');
               //result := result + 'Text:  '+ PagesArray.Objects[I].Get('text', '');
               //result := result + 'Tags:  '+ PagesArray.Objects[I].Get('tags', '');
               //result := result + 'URL:   '+ PagesArray.Objects[I].Get('url', '')+new_line;

              end;
           end;
           Result := Result +  TemplateCloseTitle;

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

}
function TDM_Mapa_site.create_mapa_site: Integer;
Var
  aPath:String;
begin
  with PageProducer1 do
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

end;

end.

