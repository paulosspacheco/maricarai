unit mi.rtl.objects.methods.pageproducer.test;
{<: A unit **@name** demonstra como usar os componentes **TPageProducer** e os componentes da unit **THTMLBrowserHelpViewer**

    - **Unit HelpIntfs**
      - Documento do componente **THTMLHelpDatabase**:
        - [THTMLHelpDatabase](https://lazarus-ccr.sourceforge.io/docs/lcl/lazhelphtml/thtmlhelpdatabase.html)
          - Propriedades que devem ser inicializadas: 
            - AutoRegister
              - True

            - BaseURL 
              - file://html/

            - KeyWordPrefix
              - HTML/   

      - Documento do componente **THTMLBrowserHelpViewer**:
        - [thtmlbrowserhelpviewer.html](https://lazarus-ccr.sourceforge.io/docs/lcl/lazhelphtml/thtmlbrowserhelpviewer.html)
          - Propriedades que devem ser inicializadas: 
            - AutoRegister
              - true

          - Notas
            - Usado para informar os parâmetros de execução do browser específico, caso não informe o browser, então usará o browser defaust do sistema.

          - Exemplo de uso:

      ```pascal

        implementation


        procedure TForm1.HelpButtonClick(Sender: TObject);
        begin
          // This demonstrates how to show a help item manually:
          ShowHelpOrErrorForKeyword('','HTML/index.html');
        end;

        procedure TForm1.FormCreate(Sender: TObject);
          const      
            HelpShortcut = 'F1';       
        begin
          HTMLHelpDatabase1.BaseURL:='file://html';
          Edit1.Text:='Edit1 - Press '+HelpShortcut+' for help';
          Edit2.Text:='Edit2 - Press '+HelpShortcut+' for help';
        end;
                    

      ```

    - **Unit mi.rtl.objects.methods.pageproducer** : Componente usado para
      produzir páginas html baseado em modelos.


}


{$mode Delphi}
interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ComCtrls, ExtCtrls, StdCtrls,
  LazHelpHTML, Dialogs,StrUtils,
  mi.rtl.objects.methods.pageproducer,mi.rtl.objectss,
  HelpIntfs;

type

  { TForm_pageproducer_test }

  TForm_pageproducer_test = class(TForm)
    Button1: TButton;
    Button_Open: TButton;
    HTMLBrowserHelpViewer1: THTMLBrowserHelpViewer;
    HTMLHelpDatabase1: THTMLHelpDatabase;
    OpenDialog1: TOpenDialog;

    PageControl1: TPageControl;
    PageProducer1: TPageProducer;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    ScrollBox2: TScrollBox;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    procedure Button1Click(Sender: TObject);
    procedure Button_OpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PageProducer1HTMLTag_tgCustom(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PageProducer1HTMLTag_tgImage(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PageProducer1HTMLTag_tgImageMap(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PageProducer1HTMLTag_tgLink(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PageProducer1HTMLTag_tgObject(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PageProducer1HTMLTag_tgTable(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
//    procedure PageProducer1HTMLTag_tgTable(Sender: TObject;      const TagString: string; TagParams: TStrings; var ReplaceText: string);
    procedure PageProducer1HTMLTag_Undefined(Sender: TObject;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);

  private


  public

  end;

var
  Form_pageproducer_test: TForm_pageproducer_test;

implementation

{$R *.lfm}

{ TForm_pageproducer_test }

procedure TForm_pageproducer_test.FormCreate(Sender: TObject);
begin
  PageProducer1.HTMLFile:='./templates/mytemplate1.html';

  HTMLHelpDatabase1.AutoRegister:=true;
  // a pasta html deve existir onde for informado em BaseURL
  HTMLHelpDatabase1.BaseURL := 'file://html';

  //Profixo do documento do tópico
  HTMLHelpDatabase1.KeyWordPrefix := 'HTML/';

  //Usa o browser defaust
  HTMLBrowserHelpViewer1.AutoRegister:=true;
end;

procedure TForm_pageproducer_test.FormDestroy(Sender: TObject);
begin



end;

procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgCustom(
          Sender: TObject; const TagString: string; TagParams: TStrings;  var ReplaceText: string);
var
  tgCustom : string;
begin
  tgCustom := TagParams.Values['ListFilesText'];
  if tgCustom <> ''
  Then begin //Retorna a lista de links.
         ReplaceText:=TPageProducer.ListFilesText('ListFilesText',tgCustom,'','*.html');
       end;
end;


procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgImage(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  tgImage : string;
begin
  tgImage := TagParams.Values['NomeDaFigura'];
  if tgImage <> ''
  Then begin //Retorna a tag com a figura
         ReplaceText:= TPageProducer.StringReplaceTgImage(tgImage,'./img/brasao.png',
                       'Pachecos','Hint da imagem','Brasão da Família Pacheco');
       end;
end;

procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgImageMap(
  Sender: TObject; const TagString: string; TagParams: TStrings;
  var ReplaceText: string);

  var tgImageMap : string;
begin
  tgImageMap := TagParams.Values['img_map'];
  if tgImageMap <> ''
  Then begin //Retorna a tag com a figura
         ReplaceText:= PageProducer1.GetHtmlImageMap(tgImageMap,'img_map');
       end;
end;

procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgLink(Sender: TObject;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);

  function ListFilesURLs(const atemplate :String) : string;
    var
      ListFiles : TStringList;
      i : Integer;
  begin
    ListFiles := TStringList.Create;
    try
      with TPageProducer do
      begin
        Result := '';

        // Retorna todos os arquivos da pasta e subpastas
        FindFilesAll('','*.html',faArchive,false ,ListFiles );

        For i := 0 to ListFiles.Count-1 do
        begin
          Result := result + StringReplaceTgLink('FindFilesAll',
                                                 atemplate,
                                                 ListFiles.Strings[i],
                                                 '_blank',
                                                 ExtractFileName(ListFiles.Strings[i]),
                                                  ListFiles.Strings[i]
                                                 )   +
                                                 '<br>'+
                                                 New_Line;
        end;
      end;

    finally
      FreeAndNil(ListFiles);
    end;
  end;


  var tgLink : string;
begin
  tgLink := TagParams.Values['BlogPsspAppBr'];
  ReplaceText := TPageProducer.StringReplaceTgLink('BlogPsspAppBr',
                                                tgLink,
                                                'http://www.pssp.app.br',
                                                '', // Mantém o destino definido no ptemplate
                                                'Blog do Paulo Sérgio da Silva Pacheco',
                                                'http://www.pssp.app.br  ➚');

  tgLink := TagParams.Values['PsspAppBr'];
  if tgLink <> ''
  then ReplaceText := TPageProducer.StringReplaceTgLink('PsspAppBr',
                                                    tgLink,
                                                    'http://www.pssp.app.br',
                                                    '_self', //Abre o documento na mesma aba
                                                    'Blog do Paulo Pacheco',
                                                    'http://www.pssp.app.br');

  tgLink := TagParams.Values['FindFilesAll'];
  if tgLink <> ''
  then begin
         //Retorna a lista de links.
         ReplaceText:=ListFilesURLs(tgLink);
       end;
end;

procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgObject(
  Sender: TObject; const TagString: string; TagParams: TStrings;
  var ReplaceText: string);
begin

end;

procedure TForm_pageproducer_test.PageProducer1HTMLTag_tgTable(Sender: TObject;
          const TagString: string; TagParams: TStrings; var ReplaceText: string);

  Var
    tgTable : string='';

begin
  tgTable := TagParams.Values['Alunos'];
  if tgTable <> '' Then
  begin
    ReplaceText:= PageProducer1.GetHtmlTable(tgTable,'Alunos','table');
    exit;
  end;//Alunos

  tgTable := TagParams.Values['Alunos2'];
  if tgTable <> '' Then
  begin
    ReplaceText:= PageProducer1.GetHtmlTable(tgTable,'Alunos2','miTable1');
      exit;
    end;//Alunos2

  tgTable := TagParams.Values['Professores'];
  if tgTable <> '' Then
  begin
    ReplaceText:= PageProducer1.GetHtmlTable(tgTable,'Professores','table');
      exit;
    end;//Professores


end;

procedure TForm_pageproducer_test.PageProducer1HTMLTag_Undefined(
  Sender: TObject; const TagString: string; TagParams: TStrings;
  var ReplaceText: string);
begin
  if AnsiCompareText(TagString, 'DATETIME') = 0 then
  begin
    ReplaceText := FormatDateTime(TagParams.Values['FORMAT'], Now);
  end
  else ReplaceText:='A tag <'+TagString+'>Não conhecida';
end;

procedure TForm_pageproducer_test.Button_OpenClick(Sender: TObject);
  const
    {$IFDEF Darwin}
    HelpShortcut = #$e2#$8c#$98'?';
    {$ELSE}
    HelpShortcut = 'F1';
    {$ENDIF}

 Var
   apath,S:String;
   F: Text;
   status:integer;
begin

  // Seleciona um modelo
  if Assigned(PageProducer1) then
    OpenDialog1.InitialDir := ExtractFilePath(PageProducer1.HTMLFile);

  OpenDialog1.Filter := 'HTML Files (*.htm,*.html)|*.htm;*.html' +
    '|Text Files (*.txt)|*.txt' + '|All Files (*.*)|*.*';
  //OpenDialog1.Filter := 'Modelo (*.template|*.template'+
  //                      '|HTML Files (*.htm,*.html)'+
  //                      '|*.htm;*.html' +
  //                      '|Text Files (*.txt)|*.txt'+
  //                      '|All Files (*.*)|*.*';

  OpenDialog1.FilterIndex := 1;
  if OpenDialog1.Execute then
  begin
    Update;
    //PageProducer1.LoadFromFile(OpenDialog.Filename);
    PageProducer1.HTMLFile:=OpenDialog1.Filename;

    PageProducer1.HTMLFileResult := './'+HTMLHelpDatabase1.KeyWordPrefix+ExtractFileName(PageProducer1.HTMLFile);
    PageProducer1.HTMLFileResult := ChangeFileExt(PageProducer1.HTMLFileResult,'.html');

    aPath := ExtractFileDir(PageProducer1.HTMLFileResult);
    if not PageProducer1.DirectoryExists(aPath)
    then begin
           PageProducer1.CreateDir(aPath);
         end;
    PageProducer1.SaveHTMLContentToFile;
    //AssignFile(f,PageProducer1.HTMLFileResult);
    //{$i-}
    //  system.Rewrite(f);
    //  status := IoResult;
    //{$i+}
    //if Status=0
    //then begin
    //
    //       s:= PageProducer1.HTMLContent;
    //       if s<>''
    //       Then system.writeLn(f,s);
    //
    //       system.close(f);
    //    //como mostrar um item de ajuda manualmente:
    //    //ShowHelpOrErrorForKeyword('',PageProducer1.HTMLFileResult);
    //
    //end;
  end;
end;

procedure TForm_pageproducer_test.Button1Click(Sender: TObject);
begin
  PageProducer1.HTMLDoc:='<html dir="ltr" lang="pt-br"></html>';
  writeLn(PageProducer1.HTMLContent);
end;


end.


