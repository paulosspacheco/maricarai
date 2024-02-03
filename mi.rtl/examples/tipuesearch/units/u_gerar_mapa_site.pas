unit u_gerar_mapa_site;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

Const
  Param_HTML_mapa_site:string = 'mapa_do_site.html';

Function gerar_mapa_site(aFileName:String) : integer;

implementation

procedure GerarMapaSite(diretorio: string; var output: TextFile);
var
  arquivo: TSearchRec;
  resultado: integer;
  listaDiretorios: TStringList;
  i: integer;
begin
  listaDiretorios := TStringList.Create;
  try
    resultado := FindFirst(IncludeTrailingPathDelimiter(diretorio) + '*', faAnyFile, arquivo);
    try
      while resultado = 0 do
      begin
        if (arquivo.Name <> '.') and (arquivo.Name <> '..') then
        begin
          if (arquivo.Attr and faDirectory) = faDirectory then
            listaDiretorios.Add(arquivo.Name)
          else
            WriteLn(output, '<li><a href="' + diretorio + arquivo.Name + '">' + arquivo.Name + '</a></li>');
        end;
        resultado := FindNext(arquivo);
      end;
    finally
      FindClose(arquivo);
    end;

    if listaDiretorios.Count > 0 then
    begin
      WriteLn(output, '<ul>');
      for i := 0 to listaDiretorios.Count - 1 do
      begin
        WriteLn(output, '<li><a href="' + diretorio + listaDiretorios[i] + '/index.html">' + listaDiretorios[i] + '</a>');
        WriteLn(output, '<ul>');
        GerarMapaSite(IncludeTrailingPathDelimiter(diretorio) + listaDiretorios[i], output);
        WriteLn(output, '</ul></li>');
      end;
      WriteLn(output, '</ul>');
    end;
  finally
    listaDiretorios.Free;
  end;
end;

Function gerar_mapa_site(aFileName:String) : integer;
var
  outputFile: TextFile;

begin
  try
  AssignFile(outputFile, aFileName);
  Rewrite(outputFile);


  WriteLn(outputFile, '<html>');
  WriteLn(outputFile, '<head>');
  WriteLn(outputFile, '<title>Mapa do Site</title>');
  WriteLn(outputFile, '</head>');
  WriteLn(outputFile, '<body>');
  WriteLn(outputFile, '<h1>Mapa do Site</h1>');
  WriteLn(outputFile, '<ul>'); // Comece com uma lista não ordenada
  GerarMapaSite(GetCurrentDir, outputFile); // Comece com o diretório atual
  WriteLn(outputFile, '</ul>');
  WriteLn(outputFile, '</body>');
  WriteLn(outputFile, '</html>');

  CloseFile(outputFile);

  Except
      result := IOResult;
  end;
end;


end.

