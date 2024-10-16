unit u_datamodule1;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, httpdefs, httproute,mi.web.fphttpserver;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);

  private

  public
    //Procedure DumpRoutes(L : TStrings; AURL : String);
    class Procedure RequestToResponse(ATitle : String; ARequest : TRequest; AResponse : TResponse; RouteParams : Array of String);overload;

    {: chamdo por :
       SimpleCallBack e TMyHandler.HandleRequest
    }
    Procedure RequestToResponse(ATitle : String; ARequest : TRequest; AResponse : TResponse);overload;

    Procedure SimpleCallBack(ARequest : TRequest; AResponse : TResponse);

    { Usado em: HTTPRouter.RegisterRoute('onepath/*path/new',rmall,@ParamPathMiddle);
    }
    Procedure ParamPathMiddle(ARequest : TRequest; AResponse : TResponse);

    {Usado em HTTPRouter.RegisterRoute('onepath/:param',rmall,@ParamPath);
    }
    Procedure ParamPath(ARequest : TRequest; AResponse : TResponse);

    { Usado em: HTTPRouter.RegisterRoute('twopaths/:param1/:param2',rmall,@ParamPaths2);}
    Procedure ParamPaths2(ARequest : TRequest; AResponse : TResponse);

    {: Usado em: HTTPRouter.RegisterRoute('*path',rmall,@DefaultCallBack,True);}
    Procedure DefaultCallBack(ARequest : TRequest; AResponse : TResponse);

    {:O método **@name** cria a rotas a serem executado pelo browser. }
    Procedure RegisterRoutes;
  end;

Type
  { TMyIntf }
  TMyIntf = Class(TObject,IRouteInterface)
  public
    procedure HandleRequest(ARequest: TRequest; AResponse: TResponse);
  end;

implementation

{$R *.lfm}


{ TDataModule1 }

Var
  C1,C2 : TComponent;
  MyIntf : TMyIntf;

//Rotas a serem executadas pelo Browser.

procedure TDataModule1.SimpleCallBack(ARequest: TRequest; AResponse: TResponse);
begin
  RequestToResponse('Simple callback',ARequest,AResponse);
end;

class procedure TDataModule1.RequestToResponse(ATitle: String;
  ARequest: TRequest; AResponse: TResponse; RouteParams: array of String);

    {: A procedure @name criar uma lista de links html
    }
    procedure DumpRoutes(L: TStrings; AURL: String);

      Function DefaultReps(S : String) : string;

      begin
        Result:=StringReplace(S,'*path','somepath',[]);
        Result:=StringReplace(Result,':param1','theparam1',[]);
        Result:=StringReplace(Result,':param2','theparam2',[]);
        Result:=StringReplace(Result,':param','theparam',[]);
        If (Result<>'') and (Result[1]='/') then
          Delete(Result,1,1);
      end;

    Var
      I : Integer;
      P : String;

    begin
      THTTPRouter.SanitizeRoute(AURL);
      L.Add('<A NAME="routes"/>');
      L.Add('<H1>Try these routes:</H1>');
      For I:=0 to HTTPRouter.RouteCount-1 do
        begin
          P:=DefaultReps(HTTPRouter[i].URLPattern);
          L.Add('<A HREF="'+BaseURL+'/'+P+'">'+P+'</a><br>');
        end;
    end;

Var
  L : TStrings;
  S : String;
begin
  L:=TStringList.Create;
  try
    L.Add('<HTML>');
    L.Add('<HEAD>');
    L.Add('<TITLE>'+ATitle+'</TITLE>');
    L.Add('</HEAD>');
    L.Add('<BODY>');
    L.Add('<H1>'+ATitle+'</H1>');
    L.Add('<A HREF="#routes">Jump to routes overview</A>');
    if (Length(RouteParams)>0) then
      begin
      L.Add('<H2>Routing parameters:</H2>');
      L.Add('<table>');
      L.Add('<tr><th>Param</th><th>Value</th></tr>');
      for S in RouteParams do
        L.Add('<tr><td>'+S+'</th><th>'+ARequest.RouteParams[S]+'</th></tr>');
      L.Add('</table>');
      end;
//    DumpRequest(ARequest,L,False);
    DumpRoutes(L,ARequest.URL);
    L.Add('</BODY>');
    L.Add('</HTML>');
    AResponse.Content:=L.Text;
    AResponse.SendResponse;
  finally
    L.Free;
  end;
end;

{: chamdo por :
   SimpleCallBack e TMyHandler.HandleRequest
}
procedure TDataModule1.RequestToResponse(ATitle: String; ARequest: TRequest;
  AResponse: TResponse);
begin
  RequestToResponse(ATitle,ARequest,AResponse,[]);
end;

{ Usado em: HTTPRouter.RegisterRoute('onepath/*path/new',rmall,@ParamPathMiddle);}
procedure TDataModule1.ParamPathMiddle(ARequest: TRequest; AResponse: TResponse
  );
begin
  RequestToResponse('Path in the middle (onepath/*path/new)',ARequest,AResponse,['path']);
end;

{Usado em HTTPRouter.RegisterRoute('onepath/:param',rmall,@ParamPath);}
procedure TDataModule1.ParamPath(ARequest: TRequest; AResponse: TResponse);
begin
  RequestToResponse('Parametrized path (onepath/:param)',ARequest,AResponse,['param']);
end;

{ Usado em: HTTPRouter.RegisterRoute('twopaths/:param1/:param2',rmall,@ParamPaths2);}
procedure TDataModule1.ParamPaths2(ARequest: TRequest; AResponse: TResponse);
begin
  RequestToResponse('Parametrized path (onepath/:param)',ARequest,AResponse,['param1','param2']);
end;


{: Usado em: HTTPRouter.RegisterRoute('*path',rmall,@DefaultCallBack,True);}
procedure TDataModule1.DefaultCallBack(ARequest: TRequest; AResponse: TResponse
  );
begin
  RequestToResponse('Default callback (*path)',ARequest,AResponse,['path']);
end;

{ TMyIntf }

{ Usado em: HTTPRouter.RegisterRoute('/component/1',C1,rmall,@ComponentPath);
}
procedure ComponentPath(AData: Pointer; ARequest: TRequest;AResponse: TResponse);
begin
  TDataModule1.RequestToResponse('Component path (component: '+TComponent(AData).Name+')',ARequest,AResponse,[]);
end;


procedure TMyIntf.HandleRequest(ARequest: TRequest; AResponse: TResponse);
begin
  TDataModule1.RequestToResponse('Interface object',ARequest,AResponse,[]);
end;


procedure TDataModule1.RegisterRoutes;
begin
  if (C1=Nil) then
  begin
    C1:=TComponent.Create(Nil);
    C1.Name:='ComponentRoute1';
    HTTPRouter.RegisterRoute('/component/1',C1,rmall,@ComponentPath);

    C2:=TComponent.Create(Nil);
    C2.Name:='ComponentRoute2';
    HTTPRouter.RegisterRoute('/component/2',C2,rmall,@ComponentPath);

    MyIntf := TMyIntf.Create;
  end;

  HTTPRouter.RegisterRoute('simple',rmall,@SimpleCallBack);
  HTTPRouter.RegisterRoute('onepath/:param',rmall,@ParamPath);
  HTTPRouter.RegisterRoute('twopaths/:param1/:param2',rmall,@ParamPaths2);
  HTTPRouter.RegisterRoute('onepath/*path/new',rmall,@ParamPathMiddle);
  HTTPRouter.RegisterRoute('/interfaced',rmall,MyIntf);

  {: A rota '*path' pegará todos os outros caminhos, ou seja: Se não
     informar uma rota o sistema não gera execeção.
     Exemplo:
       Ao digitar o endereço http://localhost:8080 seja executado
  }
  HTTPRouter.RegisterRoute('*path',rmall,@DefaultCallBack,True);

end;

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(self);
  RegisterRoutes;
end;




end.

