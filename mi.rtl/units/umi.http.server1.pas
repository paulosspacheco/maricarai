unit umi.http.server;
{:< A unit **name** implemta a classe TTMi_HTTPServer.}
{$mode Delphi}{$H+}
{DEFINE STANDALONE}
interface

uses
  classes,
  sysutils,
  {$IFDEF STANDALONE}
    fphttpapp;
  {$ENDIF}

  {$IFDEF FPFCGI}
    fpfcgi;
  {$ENDIF}

  {$IFDEF FPCGI}
    fpcgi;
  {$ENDIF}


type
  {:A class **@name** Executa uma aplicação http dentro de um processo separado
    para que o processo corrente não trave

    - O motivo que me levou a criar essa classe é que os exemplos fcl-web são todos
      modo console.
  }

  { TTMi_HTTPServer }

  TTMi_HTTPServer = class(TThread)
  private
    {:O atributo **@name** tem como finalidade controlar o inicio e o fim da tarefa.}
    FTerminated: Boolean;
  protected
    {:O método **@name** executa a tarefa.}
    procedure Execute; override;
  public
    {:O constructor **@name** inicializa os atributos e propriedades da aplicação
      standealone.

      - **PARÂMETROS**
        - aHostName
          - endereço ip do servidor ou URL:
            - Exemplo:
              - http://localhost

        - aPort
          - Porta de scuta do servidor:
            - Exemplo:
              - 8080

        - aAllowDefaultModule
          - Quando AllowDefaultModule está definido como True:
            - O framework fphttpapp permite que o módulo padrão, que foi registrado
              na aplicação (geralmente o primeiro módulo criado), seja usado para
              processar requisições que não têm um módulo específico associado. Isso é
              útil em cenários simples, onde você pode ter apenas um módulo e deseja
              que ele lide com todas as requisições sem a necessidade de configurar
              rotas detalhadas.

    }
    constructor Create(aHostName:String;aPort:Integer;aAllowDefaultModule:Boolean);overload;

    {:O constructor **@name** inicializa os atributos e propriedades da aplicação
      CGI.

      - **PARÂMETROS**
        - aAllowDefaultModule
          - Quando AllowDefaultModule está definido como True:
            - O framework fphttpapp permite que o módulo padrão, que foi registrado
              na aplicação (geralmente o primeiro módulo criado), seja usado para
              processar requisições que não têm um módulo específico associado. Isso é
              útil em cenários simples, onde você pode ter apenas um módulo e deseja
              que ele lide com todas as requisições sem a necessidade de configurar
              rotas detalhadas.
    }
    constructor Create(aAllowDefaultModule:Boolean);overload;

    {:O constructor **@name** inicializa os atributos e propriedades da aplicação
      fastcgi.

      - **PARÂMETROS**
        - aPort
          - Porta de scuta do servidor:
            - Exemplo:
              - 8080

        - aAllowDefaultModule
          - Quando AllowDefaultModule está definido como True:
            - O framework fphttpapp permite que o módulo padrão, que foi registrado
              na aplicação (geralmente o primeiro módulo criado), seja usado para
              processar requisições que não têm um módulo específico associado. Isso é
              útil em cenários simples, onde você pode ter apenas um módulo e deseja
              que ele lide com todas as requisições sem a necessidade de configurar
              rotas detalhadas.
    }
    constructor Create(aPort:Integer;aAllowDefaultModule:Boolean);overload;

    {:O método **@name** para a execução da tarefa. }
    procedure StopServer;
  end;

Var
  {: A varável publica **name** é iniciada com os parâmetros passados para a tarefa.}
  BaseURL : String;

implementation

{ TTMi_HTTPServer }

constructor TTMi_HTTPServer.Create(aHostName: String; aPort: Integer;aAllowDefaultModule: Boolean);
begin
  inherited Create(True);  // Cria a thread mas não inicia
  FreeOnTerminate := True; // Libera a thread ao finalizar
  FTerminated := False;

  //RegisterRoutes;
  {$IFDEF FPCGI}
    //fpcgi.Application.Port:=aPort;
    //fpcgi.Application.HostName:=aHostName;
    fpcgi.Application.AllowDefaultModule:= aAllowDefaultModule;
    BaseURL :='';//aHostName+':'+IntToStr(Application.Port);
  {$ENDIF FPCGI}

  {$IFDEF FPFCGI}
    fpfcgi.Application.Port:=aPort;
    //fpfcgi.Application.HostName:=aHostName;
    fpfcgi.Application.AllowDefaultModule:= aAllowDefaultModule;
    BaseURL :=aHostName+':'+IntToStr(Application.Port);
  {$ENDIF}

  {$IFDEF STANDALONE}
    fphttpapp.Application.Port:=aPort;
    fphttpapp.Application.HostName:=aHostName;
    fphttpapp.Application.AllowDefaultModule:= aAllowDefaultModule;
    BaseURL :=aHostName+':'+IntToStr(Application.Port);
  {$ENDIF STANDALONE}
end;

constructor TTMi_HTTPServer.Create(aAllowDefaultModule: Boolean);
begin
  Create('',-1,aAllowDefaultModule);
end;

constructor TTMi_HTTPServer.Create(aPort: Integer;aAllowDefaultModule: Boolean);
begin
  Create('',aPort,aAllowDefaultModule);
end;

procedure TTMi_HTTPServer.Execute;
begin
  {$IFDEF FPCGI}
    fpCGI.Application.Initialize;
    //fpCGI.Application.Threaded := True;
    fpCGI.Application.Run;  // Inicia o loop de eventos do servidor HTTP
  {$ENDIF}

  {$IFDEF FPFCGI}
    fpfcgi.Application.Initialize;
//    fpfcgi.Application.Threaded := True;
    fpfcgi.Application.Run;  // Inicia o loop de eventos do servidor HTTP
  {$ENDIF}

  {$IFDEF STANDALONE}
    fphttpapp.Application.Initialize;
    fphttpapp.Application.Threaded := True;
    fphttpapp.Application.Run;  // Inicia o loop de eventos do servidor HTTP
  {$ENDIF}
end;

procedure TTMi_HTTPServer.StopServer;
begin
  {$IFDEF FPCGI}
    fpcgi.Application.Terminate;
  {$ENDIF}

  {$IFDEF FPFCGI}
    fpfcgi.Application.Terminate;
  {$ENDIF}

  {$IFDEF STANDALONE}
    fphttpapp.Application.Terminate; // Para o servidor HTTP
  {$ENDIF}
end;

end.


