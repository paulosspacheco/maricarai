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
        - Criar unit **@name**; ✅

      - **2023-11-08
        - Criar método get_Contudo usado componente mi.rtl.TreeNode;
        - Criar classe TTreeNode.TreeToStringListHtml;override


}

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, mi.rtl.objects.methods.pageproducer
  , mi.rtl.miStringlist
  , u_conts
  , fpjson
  , mi.rtl.Objectss
  , mi.rtl.TreeNode;

const
  {: A constante **@name** é usada para informar o título do grupo tada vez que
     a pasta do link troca e visualmente o botão de ocultar links filho fica inativo
  }
  TemplateOpenTitle_childrenDefault: string =
  '<li><span class="rootTree"><b>~pasta_title</b></span><ul> <div class="childrenDefault">';

  {: A constante **@name** é usada para informar o título do grupo tada vez que
     a pasta do link troca e visualmente o botão de ocultar links filho fica ativo.}
  TemplateOpenTitle_children: string =
  '<li><span class="rootTree">~pasta_title</span> <ul> <div class="children">';


  {: A constante **@name** é usada no rodapé do menu e deve ser adicionado toda
     vez que a pasta do link troca.
  }
  TemplateCloseTitle: string = '</div> </ul> </li>';


  {: A constante **@name** é usado para criar o link dentro do título.
  }
  template_link: string =  '<li> <a href="˜url" target="">~title  ➚ </a></li>';// + TObjectss.New_line ;

  {: O template **@name** é usado para criar o arquivo menu.html.

     - Como usar o arquivo gerado pelo método Create_menu:
       - No arquivo mapa_do_site.html dentro de <head></head>

        ```pascal

            <!-- CSS do menu-->
            <link type="text/css" href="/css/topnav.css" rel="stylesheet" />
            <link type="text/css" href="/css/defaulttheme.css" rel="stylesheet" />

            <script type="application/x-javascript" src="/js/generic.js"></script>
            <script type="application/x-javascript" src="/js/tgeneric.js"></script>
            <script>document.addEventListener("DOMContentLoaded", function() {includeHTML();}                );</script>
            <script>document.addEventListener("DOMContentLoaded", function() {FixHeader(window, "myHeader");});</script>
            <script>document.addEventListener("DOMContentLoaded", function() {toggleTree();}                 );</script>

        ```

       - No template onde deve ficar o menu adicionar o seguinte código:

         ```pascal

             <!--#menu#-->

         ```

  }
  template_menu : string =  '<!-- Menu de opções -->'+
                            //'<div class="topnav" id="myTopnav">'+
                            '  <div class="dropdown">'+
                            '    <button class="dropbtn">☰<i class="fa fa-caret-down"></i> </button>'+
                            '    <div class="dropdown-content">'+
                            '      <ul>'+
                            '        ~menu'+
                            '      </ul>'+
                            '    </div>'+
                            '  </div>'+
                            '  <a href="/index.html">Home</a>'+
                            '  <a href="/tipue_results.html" target=""><b> 🔎 </b></a>';
                            //'<a href="/tipue_results.html">  <img src="./img/search.png" alt="Pesquisa"></a> Desativei pq a figura é grande'
                           // '</div>';


var
  Param_title: string = '';

type
  {TPathMS}
  TPathMS = class(mi.rtl.TreeNode.TPath)
  public
    title: string;
  public
    constructor Create(aData: string; aIsSheet: boolean; aTitle: string); overload;

  end;

type


  { TTreeNodeMS }
  TTreeNodeMS = class(mi.rtl.TreeNode.TMi_rtl_treenode)
    public function Create_Object(aFileName, aPart: string): TObject; override;

    {: O método **@name** código html com um arvore de resumida fechada podendo
       ser aberta, igual ao menu de opções}
    public procedure TreeToStringListHtml_Complexa(TreeNode: TMi_rtl_treenode; var S: TStringList);

   {: O método **@name** código html com um página html Identada}
    public procedure TreeToStringListHtml_Simples(TreeNode:TMi_rtl_treenode;var S:TStringList);
  end;


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

    {: O método **@name** retorna o nome da pasta corrente sem os caractes _ (Underline) e . (ponto) , os mesmos são substituido por espaço em branco. }
    function getTitle:String;

    {: O evento **@name** usa o arquivo './templates/template_pssp_app_br.html'
       para criar o documento **HTMLContent**.
    }
    procedure PageProducer1HTMLTag_Undefined(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);

    protected procedure Create_Arvore();

    {: O Método **@name** retorna o conteúdo de aList em forma de string}
    Function List_to_str(var aList : TStringList):string;

    {: O Método **@name** retorna o menu de opções do modelo usando o conteúdo
       criado no método get_conteudo:

       - **COMO:**
         - Ao executar o método **get_contéudo** ele cria uma página de links baseado
           no arquivo **tipuesearch_content.js**, este arquivo é usado como arquivo
           a ser incluido no página mapa do site e no arquivo **js/menu/index.js**.
    }
    protected function Get_Menu: string;

    {: O método **@name** cria o mapa do site baseado no arquivo
       **./tipuesearch_content.js** salvo em _SaveHTMLContentToFile_.

       - **NOTAS**
         - Usar a classe TTreenode para criar a arvore de diretório;
         s
    }
    protected function get_Contudo: string;

    private var jsonText_tipuesearch: TStringList;

    private var JsonStr: TJSONStringType;
    private var JsonData: TJSONData;
    private var PagesArray: TJSONArray;
    private var Root: TTreeNodeMS;
    private var List: TStringList;
    private var   t : TPathMS;
    public function create_mapa_site: integer;
  end;

function create_mapa_site: integer;

var
  DM_Mapa_site: TDM_Mapa_site;

implementation

{$R *.lfm}

uses
  StrUtils;

function create_mapa_site: integer;
begin
  try
    DM_Mapa_site := TDM_Mapa_site.Create(nil);
    Result := DM_Mapa_site.create_mapa_site;

  finally
    FreeAndNil(DM_Mapa_site)
  end;

end;

{ TPathMS }

constructor TPathMS.Create(aData: string; aIsSheet: boolean; aTitle: string);
begin
  inherited Create(aData, aIsSheet);
  title := aTitle;
  if Title = ''
  then title := aData;
end;

{ TTreeNode }

function TTreeNodeMS.Create_Object(aFileName, aPart: string): TObject;
begin
  //  Result:=inherited Create_Object(aName);
  if  LowerCase(ExtractFileName(aFileName)) = LowerCase(aPart) Then
  //if Pos('.', aPart) <> 0 then
  Result := TPathMS.Create(aFileName, True, Param_title)
  else
    Result := TPathMS.Create(aPart, False, aPart);
end;

procedure TTreeNodeMS.TreeToStringListHtml_Complexa(TreeNode: TMi_rtl_treenode; var S: TStringList);
var
  i: integer;
  str: string;
  TreeNodeItem:  TMi_rtl_treenode;
begin
  if Assigned(TreeNode) then
  begin

    if ((TreeNode.Data as TPathMS).title<>'')
    then begin
            //Título do grupo é adicionado toda vez que a pasta do link troca.
            if (TreeNode.Data as TPathMS).Data = 'Root'
            then str := TemplateOpenTitle_childrenDefault
            else str := TemplateOpenTitle_children;

            str := StringReplace(str, '~pasta_title', UpCase( (TreeNode.Data as TPathMS).title),   [rfReplaceAll]);
            s.Add(str);
         end;

    for i := 0 to TreeNode.Children.Count - 1 do
    begin
      TreeNodeItem := TreeNode.Children.Items[i] as  TMi_rtl_treenode;
      if (TreeNodeItem.Data as TPath).IsSheet then
      begin
        str := template_link;
        str := StringReplace(str, '˜url', PathDelim+(TreeNodeItem.Data as TPathMS).Data,[rfReplaceAll]);
        str := StringReplace(str, '~title', (TreeNodeItem.Data as TPathMS).title,[rfReplaceAll]);
        s.Add(str);
      end
      else TreeToStringListHtml_Complexa(TreeNodeItem, s);
    end;

    if ((TreeNode.Data as TPathMS).title<>'')
    then s.add(TemplateCloseTitle);

  end;
end;


procedure TTreeNodeMS.TreeToStringListHtml_Simples(TreeNode: TMi_rtl_treenode;var S:TStringList);
  var
    i: Integer;
    str :string;
begin
  if ((TreeNode.Data as TPathMS).data <> '') and
     ((TreeNode.Data as TPathMS).title <> '')
  then Begin
          //if not (TreeNode.Data as TPath).IsSheet
          s.Add('<ul>');


          if (TreeNode.Data as TPath).IsSheet then
          begin
            //Gera o link
            str  := template_link;
            str := StringReplace(str, '˜url'  ,(TreeNode.Data as TPathMS).Data , [rfReplaceAll]);
            str := StringReplace(str, '~title',(TreeNode.Data as TPathMS).title, [rfReplaceAll]);
            s.Add(str);
          end
          else begin
                 str := '<b>'+(TreeNode.Data as TPath).Data+'</b>';
                 s.Add(str);
               end;
       end;

  for i := 0 to TreeNode.Children.Count-1 do
  begin
     TreeToStringListHtml_Simples(TreeNode.Children.Items[i] as  TMi_rtl_treenode, s);
  end;

  if ((TreeNode.Data as TPathMS).data <> '') and
     ((TreeNode.Data as TPathMS).title <> '')
  then Begin
         s.Add('</ul>');

       end;
end;

//procedure TTreeNodeMS.TreeToStringListHtml_Simples(TreeNode:TTreeNode;var S:TStringList);
//  var
//    i: Integer;
//    str :string;
//begin
//  if ((TreeNode.Data as TPathMS).data <> '') and
//     ((TreeNode.Data as TPathMS).title <> '')
//  then Begin
//          //if not (TreeNode.Data as TPath).IsSheet
//          s.Add('<ul>');
//          s.Add('<li>');
//
//          if (TreeNode.Data as TPath).IsSheet then
//          begin
//            //Gera o link
//            str  := template_link;
//            str := StringReplace(str, '˜url'  ,(TreeNode.Data as TPathMS).Data , [rfReplaceAll]);
//            str := StringReplace(str, '~title',(TreeNode.Data as TPathMS).title, [rfReplaceAll]);
//            s.Add(str);
//          end
//          else begin
//                 str := '<b>'+(TreeNode.Data as TPath).Data+'</b>';
//                 s.Add(str);
//               end;
//       end;
//
//  for i := 0 to TreeNode.Children.Count-1 do
//  begin
//     TreeToStringListHtml_Simples(TreeNode.Children.Items[i] as TTreeNode, s);
//  end;
//
//  if ((TreeNode.Data as TPathMS).data <> '') and
//     ((TreeNode.Data as TPathMS).title <> '')
//  then Begin
//         s.Add('</ul>');
//         s.Add('</li>');
//       end;
//end;

{ TDM_Mapa_site }

procedure TDM_Mapa_site.DataModuleCreate(Sender: TObject);
var
  s: ansistring;
  p: integer;
begin
  with PageProducer1 do
  begin
    //Habilita evento OnHTMLTag_Undefined

    // Crie a classe jsonText_tipuesearch para armazenar o conteúdo do arquivo.
    jsonText_tipuesearch := TStringList.Create;
    t := TPathMS.Create('Root', False);
    t.title:='';
//    t.title:='☰';
    Root := TTreeNodeMS.Create(t);
    List := TStringList.Create;
    //Carrega json do arquivo
    jsonText_tipuesearch.LoadFromFile(HTMLFileResult_json);

    JsonStr := jsonText_tipuesearch.Text;

    //Remove a expressão: 'var On_mapa_site ='
    if pos('var tipuesearch =', JSonStr) <> 0 then
      system.Delete(JsonStr, 1, length('var tipuesearch ='));

    //Inicia o ponteiro JsonData
    JsonData := GetJSON(JsonStr, True);


    s := ExtractFileDir(ExpandFileName(ParamStr(0)));
    s := s + '/templates/template_pssp_app_br.html';
    HTMLFile := s;

    HTMLFileResult := HTMLFileResult_mapa_site;

    Create_Arvore();
  end;
end;

procedure TDM_Mapa_site.DataModuleDestroy(Sender: TObject);
begin
  jsonText_tipuesearch.Free;
  PagesArray.Free;
  t.free;
  Root.free;
  List.free;
end;

function TDM_Mapa_site.getTitle:String;
begin
  Result := ExtractFileName(GetCurrentDir);
  with TObjectss do
  begin
    result := ChangeSubStr('_',' ',result);
    result := ChangeSubStr('.',' ',result);
  end;

  //Transforma em maiuscula o primeiro cararactere

  result[1] := Upcase(result[1]);


end;

procedure TDM_Mapa_site.PageProducer1HTMLTag_Undefined(Sender: TObject;
                const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  i: integer;
  s: string;
  DataSystem: longint;
begin
  //   Mapa_site.get_Contudo;
  with PageProducer1 do
  begin
    i := AnsiIndexStr(UpperCase(TagString),
      ['TITLE', 'CREATEDATE', 'CREATEDATEUPDATE', 'DESCRIPTION', 'KEYWORDS', 'CONTEUDO','MENU','AUTHOR']);
    case i of
      0: begin {'TITLE' }
           ReplaceText := getTitle+' - Index';

         end;
      1, 2: begin {'CREATEDATE','CREATEDATEUPDATE' }
              DataSystem := TObjectss.TDates.GetFTimeDos();
              ReplaceText := TObjectss.TDates.StringTimeD(DataSystem, '/');
            end;

      3: begin {'DESCRIPTION' }
           ReplaceText := 'Index raiz em : ' + HTMLFileResult_mapa_site;
         end;

      4: begin {'KEYWORDS' }
           ReplaceText := '';
         end;

      5: begin {'CONTEÚDO' }
           ReplaceText := get_Contudo;
         end;

      6: begin {'MENU' }
           ReplaceText := get_Menu;
         end;
      7: begin {AUTHOR}
           ReplaceText := 'Paulo Pacheco';
         end
      else
        ReplaceText := 'Erro: Tag indefiida...';
    end;
    s := ReplaceText;
  end;

end;

procedure TDM_Mapa_site.Create_Arvore();
var
  i: integer;
  s1: string;
begin
  HTMLFileResult_mapa_site :=   IncludeTrailingPathDelimiter(ExtractFileDir(HTMLFileResult_json)) + 'mapa_do_site.html';
  try
    with PageProducer1 do
    begin
      if FileExists(HTMLFileResult_json) then
      begin
        if JsonData is TJSONObject then
        begin
          PagesArray := TJSONObject(JsonData).Arrays['pages'];
          for I := 0 to PagesArray.Count - 1 do
          begin
            Param_title := PagesArray.Objects[I].Get('title', '');
            if Param_title <> '' then
            begin //Adiciona na arvore.
              s1 := PagesArray.Objects[I].Get('url', '');

              if (s1 <> '')
                 and ( LowerCase(
                          ExtractFileName(HTMLFileResult_mapa_site)
                       )
                       <>
                       LowerCase(ExtractFileName(s1))
                     )
              then
                with Root do
                begin
                  AddChildFileName(Root, s1);
                end;
            end;
          end;
        end;

      end;

    end;
  except
    on E: Exception do
      writeln('Erro: ', E.Message);
  end;
end;

function TDM_Mapa_site.List_to_str(var aList:TStringList):string;
var
  s: string;
begin
  Result := '';
  for s in aList do
  begin
    Result := Result + s;
  end;
 //Gera o link
  //result := result + 'Title: '+ PagesArray.Objects[I].Get('title', '');
  //result := result + 'Text:  '+ PagesArray.Objects[I].Get('text', '');
  //result := result + 'Tags:  '+ PagesArray.Objects[I].Get('tags', '');
  //result := result + 'URL:   '+ PagesArray.Objects[I].Get('url', '')+new_line;
end;


function TDM_Mapa_site.Get_Menu:string;
  Var Str:String;
  var F : TStringList;
begin
  Result := '<div class="header" id="myHeader">'+
            '  <div class="navbar" w3-include-html="/menu.inc"> </div>'+
            '</div>';

  //Salva o menu no arquivo
  Try
    F := TStringList.Create;
    str:= template_Menu;
    List.Clear;
    Root.TreeToStringListHTML_Complexa(Root, List);
    //List.SaveToFile('links.inc');
    str := StringReplace(str, '~menu'  ,List_to_str(List) , [rfReplaceAll]);
    F.AddStrings(str);
    f.SaveToFile('menu.inc');
  finally
    F.free;
  end;

end;

{: Esta função espera que a URL da variável JsonData esteja em ordem alfabética}
function TDM_Mapa_site.get_Contudo: string;
begin

  List.Clear;
  Root.TreeToStringListHtml_Simples(Root, List);
  //List.SaveToFile('links_01.inc');
  Result := List_to_str(List);
end;

function TDM_Mapa_site.create_mapa_site: integer;
var
  aPath: string;
begin
  with PageProducer1 do
  begin
    aPath := ExtractFileDir(HTMLFile);
    if not DirectoryExists(aPath) then
    begin
      WriteLn('A pasta ./templates não existe.');
      Result := PathNaoEncontrado;
      exit;
    end;

    if not FileExists(HTMLFile) then
    begin
      WriteLn('O arquivo de modelo do mapa do site ' + HTMLFile + ' não existe.');
      Result := ArquivoNaoEncontrado2;
      exit;
    end;
    if OnHTMLTag_Undefined <> nil then Result := SaveHTMLContentToFile
    else
      Result := -1;

  end;

end;

end.
