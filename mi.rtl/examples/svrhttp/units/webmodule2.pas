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
    procedure func1callRequest(Sender: TObject; ARequest: TRequest;
      AResponse: TResponse; var Handled: Boolean);
  private
    Params: tObjectss.TMiStringList;
    { private declarations }
    procedure func1callReplaceTag(Sender: TObject; const TagString:String; 
      TagParams: TStringList; Out ReplaceText: String);
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

  {: O método **@name** retorna uma string com o nome de todos os arquivo com a extenção passada por a aMask
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

  {
  <!--# tgTable [- REPORTRESULT=[ title="Teste de tabelas";
                                  Header="Column1","Column2";
                                  OneRow="Paulo Sérgio","Marcos Pacheco";
                                  Footer="soma Columm1","soma Columm2";
                                  NOTFOUND="Mensagem em caso de erro"
                                ]
                -]
  #-->
  }
  Function GetTable(Const atitle  : string; //="Teste de tabelas";
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

        Result := Result + 'tbody'+New_Line;
          ListOneRow.AddTagValue(aOneRow);
          Result := Result + GetRow(ListOneRow)+New_Line;
        Result := Result + '/tbody'+New_Line;

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

var
   header, footer, onerow, s1,s2,s3:String;
   NoRecordsToShow:Boolean;
   ColumnHeaders:array[1..2] of String;
   ColumnValues:array[1..3,1..2]of String;
   I:Integer;


begin//HTML template tag handling for an html template file

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
    if s1 <> ''
    Then begin
           Params.AddTag(s1);
           ReplaceText := GetTable(Params.Values['title'],
                                   Params.Values['Header'],
                                   Params.Values['OneRow'],
                                   Params.Values['Footer'],
                                   Params.Values['NotFound'],
                                   'mitable'//'table'
                                   );
           s1 := ReplaceText;
           exit;
         end;

    //fill up some arrays with data (could come from a SQL query)
    NoRecordsToShow := false;

    ColumnHeaders[1] := 'Amount';
    ColumnHeaders[2] := 'Percentage';

    ColumnValues[1,1] := '10.00';
    ColumnValues[1,2] := '5';

    ColumnValues[2,1] := '15.00';
    ColumnValues[2,2] := '4';

    ColumnValues[3,1] := '20.00';
    ColumnValues[3,2] := '3';

    //NoRecordsToShow could be something like SQL1.IsEmpty , etc.
    if NoRecordsToShow then
    begin  //if there's nothing to list, just replace the whole tag with the 
           //"Not Found" message that the template contains
      ReplaceText := TagParams.Values['NOTFOUND'];
      Exit;
    end;

    header := TagParams.Values['HEADER'];
    //insert header parameters
    header := StringReplace(header, '~Column1', ColumnHeaders[1], []);
    header := StringReplace(header, '~Column2', ColumnHeaders[2], []);

    ReplaceText := header;//done with the header (could have been looping 
			  //through table field names also)
    //insert the rows
    onerow := TagParams.Values['ONEROW'];//template for 1 row
    //loop through the rows, it could be someting like "while not SQL1.EOF do"
    for I := 1 to 3 do
    begin
      ReplaceText := ReplaceText +
                     StringReplace(StringReplace(onerow ,'~Column1Value', '$' + ColumnValues[I, 1], []),
                                                         '~Column2value', ColumnValues[I, 2] + '%', []) +
                     #13#10;
    end;

    //insert the footer
    footer := TagParams.Values['FOOTER'];
    //replace footer parameters if needed
    //...

    ReplaceText := ReplaceText + footer;
  end else begin

//Not found value for tag -> TagString
    ReplaceText := 'Template tag <!--#' + TagString + '#--> is not implemented yet.';
  end;

end;

initialization
  RegisterHTTPModule('TFPWebModule2', TFPWebModule2);
end.
