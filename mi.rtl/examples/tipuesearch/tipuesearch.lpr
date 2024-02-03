program tipuesearch;

{$mode objfpc}{$H+}

uses
  SysUtils,
  fpwebfile,
  fphttpapp, u_TipueSearch, u_mapa_site, u_conts_mapa_site;

  var err:integer;
begin

  Application.Title:='tipuesearch';
  Application.Port:=8080;
  Application.Initialize;

  if ParamStr(1) <> ''
  then HTMLFileResult_json:= ParamStr(1)
  else HTMLFileResult_json:= ExpandFileName(GetCurrentDir)+'/tipuesearch_content.js';

  if ParamStr(2) <> ''
  then HTMLFileResult_mapa_site:= ParamStr(1)
  else HTMLFileResult_mapa_site:= ExpandFileName(GetCurrentDir)+'/mapa_do_site.html';

  //CRIA O ARQUIVO JSON  tipuesearch_content.js
    //writeLn('Criando arquivo: "'+HTMLFileResult_json+'/tipuesearch_content.js"...');
    //Err:=CrateIndexTipuesearch;
    //if Err <>0
    //Then WriteLn('Error: ',Inttostr(Err))
    //else begin
    //       writeLn('Criado arquivo: "'+HTMLFileResult_json+'/tipuesearch_content.js".');
    //     end;

  //CRIA O ARQUIVO HTML mapa_do_site.html
    writeLn('Criando arquivo: "'+HTMLFileResult_mapa_site+'"...');
    Err:=create_mapa_site;
    if Err <>0
    Then WriteLn('Error: ',Inttostr(Err))
    else begin
           writeLn('Criado arquivo: "'+HTMLFileResult_mapa_site+'".');
         end;
//  Application.Run;
end.

