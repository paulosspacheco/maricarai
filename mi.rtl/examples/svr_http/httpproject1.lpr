{: O programa **@name** é usado para demsotrar o uso do
componente fphttpapp

   - **Referências**
      - [fphttpserver](https://wiki.freepascal.org/fphttpserver)


   - **Exemplo**

     ```pascal

       Usage
         The following demonstrates the use of the TFPHTTPApplication class:

       program webserver;

       {$mode objfpc}{$H+}

       uses
         {$ifdef UNIX}
         cthreads, cmem,
         {$endif}
         fphttpapp, httpdefs, httproute;

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
         Application.Port := 1999;
         Application.Threaded := true;
         Application.Initialize;
         Application.Run;
       end.

     ```
}
program httpproject1;

{$mode objfpc}{$H+}

uses
  fpwebfile,
  fphttpapp
  ,webModule1
  ,mi.rtl.Objectss
  ;

begin
  //RegisterFileLocation('',
  //'/home/paulosspacheco/v/paulosspacheco/LazarusProjects/maricarai-v0.9.0-Lazarus-2.2.6/mi.rtl/examples/svr_http');

  Application.Title:='httpproject1';

  TSimpleFileModule.RegisterDefaultRoute;

  Application.Port:=8080;
  Application.Initialize;
  Application.Run;
end.

