program httpproject1;

{$mode objfpc}{$H+}
uses
 {$ifdef UNIX}
 cthreads, cmem,
 {$endif}
 mi.rtl.Objectss,
 fphttpapp, httpdefs, httproute,webModule1

 ;

procedure route1(aReq: TRequest; aResp: TResponse);
begin
 aResp.Content:='<html lang="pt-BR"><bodY><h1>Route 1 The Default</h1> </body></html>';
end;

procedure route2(aReq: TRequest; aResp: TResponse);
begin
 aResp.Content:='<html lang="pt-BR"><bodY><h1>Route 2</h1> </body></html>';
end;

begin
 HTTPRouter.RegisterRoute('/', @route1);
 HTTPRouter.RegisterRoute('/2', @route2);
 Application.Port := 8080;
 Application.Threaded := true;
 Application.Initialize;
 Application.Run;
end.


