unit u_fpwebmodule1;

{$mode ObjFPC}{$H+}

interface

uses
  SysUtils, Classes, httpdefs, fpHTTP, fpWeb;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    {: A ação @Name retorna o código '<html><body>func1callRequest. Essa requisição deve funcionar em: cgi, fcgi, módulo apache e svrhttp !</body></html>';

       - URL de chamada pelo browser quando compilado com a unit **fphttpapp**:
         - http://localhost:8080/TFPWebModule1/func1call

       - URL de chamada pelo browser quando compilado com a unit **fpCGI** implantado no servidor apache2:
         - http://cgi-bin/helloworld.cgi/TFPWebModule1/func1call

       - URL de chamada pelo browser quando compilado com a unit ** fphttpapp** implantado
         no servidor apache2 no modo prox redirecionado para a porta 8080:
         - Http://cgi-bin-80-to-8080/TFPWebModule1/func1call

       - URL de chamada pelo browser quando compilado com a unit **fpFCGI** implantado no servidor apache2:
         - http://fcgi-bin/helloworld.fcgi/TFPWebModule1/func1call    ???

    }
    procedure func1callRequest(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);

    {: A ação @Name retorna o código '<html><body>func2callRequest. Essa requisição deve funcionar em: cgi, fcgi, módulo apache e svrhttp !</body></html>';

       - URL de chamada pelo browser quando compilado com a unit **fphttpapp**:
         - http://localhost:8080/TFPWebModule1/func2call

       - URL de chamada pelo browser quando compilado com a unit **fpCGI** implantado no servidor apache2:
         - http://cgi-bin/helloworld.cgi/TFPWebModule1/func2call

       - URL de chamada pelo browser quando compilado com a unit ** fphttpapp** implantado
         no servidor apache2 no modo prox redirecionado para a porta 8080:
         - Http://cgi-bin-80-to-8080/TFPWebModule1/func2call

       - URL de chamada pelo browser quando compilado com a unit **fpFCGI** implantado no servidor apache2:
         - http://fcgi-bin/helloworld.fcgi/TFPWebModule1/func2call    ???

    }
    procedure func2callRequest(Sender: TObject; ARequest: TRequest; AResponse: TResponse; var Handled: Boolean);
  private

  public
    function gethtml(aname: string): String;

  end;

//var
//  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.func1callRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
begin
  AResponse.Content := gethtml('func1callRequest');
  Handled := true;
end;

procedure TFPWebModule1.func2callRequest(Sender: TObject; ARequest: TRequest;AResponse: TResponse; var Handled: Boolean);
begin
  AResponse.Content := gethtml('func2callRequest');
  Handled := true;
end;

function TFPWebModule1.gethtml(aname: string): String;
begin
  result := ''+
  '<!DOCTYPE html>'+
  '<html dir="ltr" lang="pt-br"> '+
  '                              '+
  '  <head>                      '+
  '    <meta charset="utf-8">    '+
  '    <meta name="viewport" content="width=device-width, initial-scale=1.0" />'+
  '    <title>Home - Blog.pssp.app.br</title>'+
  '  </head>'+
  '  <body>'+
  '  <b> '+aname+'</b>: Essa requisição deve funcionar em: cgi, fcgi, módulo apache e svrhttp !'+
  '  </body>'+
  '</html>';

end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

