unit webmodule2; 

{$mode objfpc}{$H+}

interface

uses
  //SysUtils, Classes, httpdefs, fpHTTP, fpWeb;
  Classes, SysUtils, FileUtil, HTTPDefs, fpHTTP, fpWeb

  ,mi.rtl.objectss;

type

  { TFPWebModule2 }

  TFPWebModule2 = class(TFPWebModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure func1callRequest(Sender: TObject; ARequest: TRequest;  AResponse: TResponse; var Handled: Boolean);
  private
    Params: tObjectss.TMiStringList;
    { private declarations }
    procedure func1callReplaceTag(Sender: TObject; const TagString:String;     TagParams: TStringList; Out ReplaceText: String);
  public
    { public declarations }
  end; 

var
  FPWebModule2: TFPWebModule2;

implementation

{$R *.lfm}

{ TFPWebModule2 }

procedure TFPWebModule2.DataModuleCreate(Sender: TObject);
begin
  Params := tObjectss.TMiStringList.Create;
end;

procedure TFPWebModule2.DataModuleDestroy(Sender: TObject);
begin
  Freeandnil(Params);
end;

procedure TFPWebModule2.func1callRequest(Sender: TObject; ARequest: TRequest;
  AResponse: TResponse; var Handled: Boolean);
begin
  //ModuleTemplate is a web module global property
  //To use the Template propery of the current web action (which is visible in
  //the object inspector for every Action), use
  //(Sender as TFPWebAction).Template.FileName := 'mytemplate1.html'; and so on.
  ModuleTemplate.FileName := './templates/mytemplate4.html';{template file with the template tag -> REPORTRESULT}

  ModuleTemplate.AllowTagParams := true;
  ModuleTemplate.StartDelimiter := '<!--#';
  ModuleTemplate.EndDelimiter := '#-->';
  ModuleTemplate.OnReplaceTag := @func1callReplaceTag;

  AResponse.Content := ModuleTemplate.GetContent;

  Handled := true;
end;


procedure TFPWebModule2.func1callReplaceTag(Sender: TObject; const TagString:  String; TagParams: TStringList; Out ReplaceText: String);


  function ListFilesURLs(const atemplate :String) : string;
    var
      ListFiles : TStringList;
      i : Integer;
  begin
    ListFiles := TStringList.Create;
    try
      with TObjectss do
      begin
        Result := '';
        FindFilesAll('','*.html',faArchive ,ListFiles );// Retorna todos os arquivos da pasta e subpastas
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

  {: O método **@name** retorna uma string com o nome de todos os arquivo com a extensão passada por a aMask
  }
  function ListFilesText(const atemplate,aPath,aMask :String) : string;
    var
      ListFiles : TStringList;
      i : Integer;
  begin
    ListFiles := TStringList.Create;
    try
      with TObjectss do
      begin
        Result := New_Line;
        FindFilesAll(aPath,aMask,faArchive ,ListFiles );// Retorna todos os arquivos da pasta e subpastas
        For i := 0 to ListFiles.Count-1 do
        begin
          Result := result + StringReplace(atemplate,'~FileName'  , ListFiles.Strings[i]  , [rfReplaceAll]);// +  New_Line;
        end;
      end;

    finally

      FreeAndNil(ListFiles);

    end;
  end;

  { <!--# tgTable [- REPORTRESULT=[ title="Teste de tabelas";
                                  Header="Column1","Column2";
                                  OneRow="Paulo Sérgio","Marcos Pacheco";
                                  Footer="soma Columm1","soma Columm2";
                                  NOTFOUND="Mensagem em caso de erro"
                                ]
                -]
  #-->
  }
  Function GetTableREPORTRESULT(Const atitle  : string; //="Teste de tabelas";
                    Const aHeader : string; //="Column1","Column2",...";
                    Const aOneRow : string; //="Value1","Value2",...;
                    Const aFooter : string; //="soma_value1","soma_value2",...;
                    Const aNotFound : string;//="Mensagem em caso de erro"
                    Const aTypeTable:String // miTable ou table
                   ): string;
    var
      ListHeader : TObjectss.TMiStringList;
      ListOneRow : TObjectss.TMiStringList;
      ListFooter : TObjectss.TMiStringList;
      AchouBarra  : Boolean = true;

    Function GetRow(aList:TObjectss.TMiStringList):String;
    var
      i : integer;
    Begin
      With TObjectss do
      begin
        Result := '';
        For i := 0 to aList.Count-1 do
        begin
          if (aList = ListHeader ) or (aList = ListFooter)
          Then begin
                  Result := Result + '<td>';
                  Result := Result + aList.Strings[i];
                  Result := Result + '</td>';
               end
          else begin
                 if AchouBarra and (aList.Strings[i] = '/')
                 Then begin
                       Result := Result + '</tr>'+New_Line;;
                       AchouBarra := false;
                      end;

                 if (not AchouBarra) and (aList.Strings[i] = '/')
                 Then begin
                        Result := Result + '</tr>'+New_Line;
                        Result := Result + '<tr>'+New_Line;;
                        AchouBarra := true;
                      end;
                 if (aList.Strings[i] <> '/')
                 then begin
                         Result := Result + '<td>';
                         Result := Result + aList.Strings[i];
                         Result := Result + '</td>';
                      end;
               end;
        end;
        if AchouBarra
        Then begin
               Result := Result + '</tr>'+New_Line;;
               AchouBarra := false;
              end;
      end;
    end;

  begin

    With TObjectss do
    try
      ListHeader := TMiStringList.Create;
      ListHeader.AddTagValue(aHeader);

      ListOneRow := TMiStringList.Create;

      ListFooter := TMiStringList.Create;
      ListFooter.AddTagValue(aFooter);
      Result :='';
      //Result := '<div style="overflow-x: auto; overflow-y: auto;">'+New_Line;
      Result := Result + '<Table id="'+aTypeTable+'">'+New_Line;

        Result := Result + '<thead>'+New_Line;
          if aTitle<>''
          then begin
                  Result := Result + '<tr>'+New_Line;
                  Result := Result + '<td colspan="'+IntToStr(ListHeader.Count)+'"><p  style="text-align: center">"'+aTitle+'"</p>  </td>';
                  Result := Result + '</tr>'+New_Line;
               end;
          Result := Result + GetRow(ListHeader)+New_Line;
        Result := Result + '</thead>'+New_Line;

        Result := Result + '<tbody>'+New_Line;
          ListOneRow.AddTagValue(aOneRow);
          Result := Result + GetRow(ListOneRow)+New_Line;
        Result := Result + '</tbody>'+New_Line;

        Result := Result + ' <tfoot>'+New_Line;
          Result := Result + '<tr>'+New_Line;
          Result := Result + GetRow(ListFooter)+New_Line;
          Result := Result + '</tr>'+New_Line;
        Result := Result + '</tfoot>'+New_Line;

      Result := Result + '</Table>'+New_Line;
      //Result := '</div>'+New_Line;
    Finally
      ListHeader.Free;
      ListOneRow.Free;
      ListFooter.Free;
    end;

  end;


  { <!--# tgTable [- Alunos=[ title="Teste de tabelas";
                              Header="Column1","Column2";
                              OneRow="Paulo Sérgio","Marcos Pacheco";
                              Footer="soma Columm1","soma Columm2";
                              NOTFOUND="Mensagem em caso de erro"
                              template="Modelo usado para a tabela"
                            ]
                  -]
    #-->
  }
  Function GetTableAlunos(atitle  : string; //="Teste de tabelas";
                          aHeaderCols : string; //="Column1","Column2",...";
                          aOneRowCols : string; //="Value1","Value2",...;
                          aFooterCols : string; //="soma_value1","soma_value2",...;
                          aNotFound : string;//="Mensagem em caso de erro"
                          aTypeTable:String; // miTable ou table
                          aTemplate :String //<table>......</table>
                   ): string;
    var
      ListHeaderCols : TObjectss.TMiStringList;
      ListOneRowCols : TObjectss.TMiStringList;
      ListFooterCols : TObjectss.TMiStringList;
      AchouBarra  : Boolean = true;



    Function GetRow(aList:TObjectss.TMiStringList):String;
    var
      i : integer;
    Begin
      With TObjectss do
      begin
        Result := '';
        For i := 0 to aList.Count-1 do
        begin
          if (aList = ListHeaderCols ) or (aList = ListFooterCols)
          Then begin
                  Result := Result + '<td>';
                  Result := Result + aList.Strings[i];
                  Result := Result + '</td>';
               end
          else begin
                 if AchouBarra and (aList.Strings[i] = '/')
                 Then begin
                       Result := Result + '</tr>'+New_Line;;
                       AchouBarra := false;
                      end;

                 if (not AchouBarra) and (aList.Strings[i] = '/')
                 Then begin
                        Result := Result + '</tr>'+New_Line;
                        Result := Result + '<tr>'+New_Line;;
                        AchouBarra := true;
                      end;
                 if (aList.Strings[i] <> '/')
                 then begin
                         Result := Result + '<td>';
                         Result := Result + aList.Strings[i];
                         Result := Result + '</td>';
                      end;
               end;
        end;
        if AchouBarra
        Then begin
               Result := Result + '</tr>'+New_Line;;
               AchouBarra := false;
              end;
      end;
    end;

    begin
      With TObjectss do
      try
        ListHeaderCols := TMiStringList.Create;
        ListHeaderCols.AddTagValue(aHeaderCols);

        ListOneRowCols := TMiStringList.Create;
        ListOneRowCols.AddTagValue(aOneRowCols);

        ListFooterCols := TMiStringList.Create;
        ListFooterCols.AddTagValue(aFooterCols);

        //if aTitle<>''
        //then begin
        //        Result := Result + '<td colspan="'+IntToStr(ListHeaderCols.Count)+'"><p  style="text-align: center">"'+aTitle+'"</p>  </td>';
        //     end;
         aHeaderCols := GetRow(ListHeaderCols);
         aOneRowCols := GetRow(ListOneRowCols);
         aFooterCols := GetRow(ListFooterCols);

         Result :=StringReplaceTgTable(atitle,
                                       aHeaderCols,
                                       aOneRowCols,
                                       aFooterCols,
                                       aNotFound,
                                       aTypeTable,
                                       aTemplate);

      Finally
        ListHeaderCols.Free;
        ListOneRowCols.Free;
        ListFooterCols.Free;
      end;

    end;

var
  s1,s2,s3:String;

begin//Manipulação de tags de modelo HTML para um arquivo de modelo html

  if AnsiCompareText(TagString, 'tgCustom') = 0 then
  begin
    s1 := TagParams.Values['ListFilesText'];
    if s1 <> ''
    Then begin //Retorna a lista de links.
           ReplaceText:=ListFilesText(s1,'','*');
         end;
  end else
  if AnsiCompareText(TagString, 'tgLink') = 0 then
  begin
    s1 := TagParams.Values['BlogPsspAppBr'];
    ReplaceText := TObjectss.StringReplaceTgLink('BlogPsspAppBr',
                                                  s1,
                                                  'http://www.pssp.app.br',
                                                  '', // Mantém o destino definido no ptemplate
                                                  'Blog do Paulo Sérgio da Silva Pacheco',
                                                  'http://www.pssp.app.br  ➚');

    s1 := TagParams.Values['PsspAppBr'];
    if s1 <> ''
    then ReplaceText := TObjectss.StringReplaceTgLink('PsspAppBr',
                                                      s1,
                                                      'http://www.pssp.app.br',
                                                      '_self', //Abre o documento na mesma aba
                                                      'Blog do Paulo Pacheco',
                                                      'http://www.pssp.app.br')
    else begin
           s1 := TagParams.Values['FindFilesAll'];
           if s1 <> ''
           Then begin //Retorna a lista de links.
                  s1 := ListFilesURLs(s1);
                  ReplaceText:=ListFilesURLs(s1);
                end;
         end;

  end
  else
  if AnsiCompareText(TagString, 'DATETIME') = 0 then
  begin
    ReplaceText := FormatDateTime(TagParams.Values['FORMAT'], Now);
  end else 

  //Replace the REPORTRESULT html tag using it's tag parameters
  if AnsiCompareText(TagString, 'tgtable') = 0 then
  begin
    s1 := TagParams.Values['REPORTRESULT'];
    if s1 <> '' Then
    begin
      Params.AddTag(s1);
      ReplaceText := GetTableREPORTRESULT(Params.Values['title'],
                              Params.Values['Header'],
                              Params.Values['OneRow'],
                              Params.Values['Footer'],
                              Params.Values['NotFound'],
                              'mitable'//'table'
                              );
      s1 := ReplaceText;
      exit;
    end //REPORTRESULT
    else
    begin
      //Replace Alunos html tag using it's tag parameters
      s1 := TagParams.Values['Alunos'];
      if s1 <> '' Then
      begin
        Params.AddTag(s1);
        ReplaceText := GetTableAlunos(Params.Values['title'],
                                      Params.Values['Header'],
                                      Params.Values['OneRow'],
                                      Params.Values['Footer'],
                                      Params.Values['NotFound'],
                                      'table',//'mitable',
                                      Params.Values['template']
                                                    );
        s1 := ReplaceText;
        exit;

      end;//Alunos

    end;
  end //tgtable
  else begin

//Not found value for tag -> TagString
    ReplaceText := 'Template tag <!--#' + TagString + '#--> is not implemented yet.';
  end;

end;

initialization
  RegisterHTTPModule('TFPWebModule2', TFPWebModule2);
end.
