unit mi.web.fphttpserver;
{:< A unit **name** implemta a classe THTTPServerThread.}
{$mode Delphi}{$H+}

{$DEFINE STANDALONE}
{ $DEFINE FPFCGI}
{ $DEFINE FPCGI}


interface

uses
  classes,
  LResources,
  sysutils,
  mi.rtl.all,
  fpwebfile,
  fpmimetypes,
  sslbase,
  fpwebproxy,

  {$IFDEF STANDALONE}
    fphttpapp;
  {$ENDIF}

  {$IFDEF FPFCGI}
    fpfcgi;
  {$ENDIF}

  {$IFDEF FPCGI}
    fpcgi;
  {$ENDIF}

const
  Mimetypes_default = 'mimetypes';
  HostName_default  = 'http://localhost';
  Port_default      = 8080;

type
  { THTTPServerThread }
  {:A class **@name** Executa uma aplicação http dentro de um processo separado
    para que o processo corrente não trave.

    - O motivo que me levou a criar essa classe é que os exemplos fcl-web são todos
      modo console.
  }
  THTTPServerThread = class(TThread)

    {:O atributo **@name** tem como finalidade controlar o inicio e o fim da tarefa.}
    private FTerminated: Boolean;

    {:O método **@name** executa a tarefa.}
    protected procedure Execute; override;

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
    public constructor Create(aHostName:String;aPort:Integer;aAllowDefaultModule:Boolean);overload;

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
    public constructor Create(aAllowDefaultModule:Boolean);overload;

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
    public constructor Create(aPort:Integer;aAllowDefaultModule:Boolean);overload;

    {:O método **@name** para a execução da tarefa. }
    public procedure StopServer;
  end;


type

  { TMI_web_application }
  {:A classe **@name** foi criada com propósito de ser registrada na palleta de
    componentes para ser inserida em um Tform na criação de aplicações hibridas,
    ou seja LCL e web .

  }
  TMi_FpHttpServer = class(TComponent)
    {$REGION --> Propriedade HTTPServerThread}

       private _HTTPServerThread : THTTPServerThread;
       private function GetHTTPServerThread: THTTPServerThread;
       {: A propiedade **@name** criar uma aplicação web em uma tarefa a parte com
       propósto da mesma ser executada em conjunto com outro tipo de aplicação do
       freeepascal.}
       public property HTTPServerThread : THTTPServerThread Read GetHTTPServerThread;// write SetHTTPServerThread;
    {$ENDREGION --> Propriedade HTTPServerThread}

    {$REGION --> Propriedade MimeFile}
      private _MimeFile : String;
      published  Property MimeFile : String Read _MimeFile Write _MimeFile;
    {$ENDREGION --> Propriedade MimeFile}

    {$REGION --> Propriedade BaseDir}
      private _BaseDir: string;
      published Property BaseDir : string Read _BaseDir Write _BaseDir;
    {$ENDREGION --> Propriedade BaseDir}
    {:O método **@name** carrega o arquivo com os tipos mime}
    protected procedure LoadMimeTypes;

    {: A constructor **@name** inicia a classe **fphttpapp.Application** se a diretiva
       **DEFINE STANDALONE** estiver definida, ou inicia a classe **fpfcgi.Application**, se
       a diretiva **DEFINE FPFCGI** estiver definida, ou inicia a classe fpcgi.Application,
       se a diretiva **DEFINE FPCGI** estiver defiidida.

       - **NOTA**
         - As diretivas STANDALONE, FPFCGI e FPCGI são multuamente exclisivas, ou
           seja: ao definir uma as outras precisão estar indefiniddas.
    }
    public constructor Create(AOwner: TComponent); override;

    {$REGION --> Propriedade Port}
       private _Port: Word;
       private procedure SetPort(AValue: Word);
       {: A propiedade **@name** guarda a porta onde a aplicação irá executar.}
       published Property Port : Word Read _Port Write SetPort Default 8080;
    {$ENDREGION --> Propriedade Port}

    {$REGION --> Propriedade UseSSL}
       // Use SSL ?
       private _UseSSL : Boolean;
       private procedure SetUseSSL(AValue: Boolean);
       {: A propiedade **@name** unforma se a aplicação deve usar o protocolo SSL,
          ou seja https.

          - **NOTAS**
            - A porta padrão do https é 443, caso seja uma porta diferente a mesma
              precisa ser referenciada na url cliente no browser.
       }
       published Property UseSSL : Boolean Read _UseSSL Write SetUseSSL;
    {$ENDREGION --> Propriedade UseSSL}

    {$REGION --> Propriedade HostName}
       private _HostName: String;
       private procedure SetHostName(AValue: String);
       {: A propriedade **name** usada para definir a utl do servior ou número do
          ip.
       }
       published Property HostName : String Read _HostName Write SetHostName ;
    {$ENDREGION --> Propriedade HostName}

    //Property QueueSize : Word Read GetQueueSize Write SetQueueSize Default 5;

    {$REGION --> Propriedade AllowDefaultModule}
       private _AllowDefaultModule:Boolean;
       {: A propriedade **name** é usada no contexto de um servidor HTTP no FCL-Web
          para controlar se o módulo padrão do servidor deve ser utilizado quando
          nenhum módulo específico é identificado para processar uma requisição.

          - **PARÂMETROS**
            - true
              - Se o servidor não encontrar um módulo específico que corresponda
                à requisição, ele permitirá que o módulo padrão seja usado para
                processar essa requisição.
              - Isso é útil para garantir que mesmo requisições não correspondentes
                a módulos específicos sejam tratadas de forma genérica, evitando
                erros de "404 Not Found" ou outras falhas.

            - false
              - O servidor não usará o módulo padrão para processar requisições
                que não correspondem a nenhum módulo específico.
              - Nesse caso, se nenhuma correspondência for encontrada, a requisição
                pode falhar, resultando em uma resposta de erro para o cliente.
       }
       published Property AllowDefaultModule : Boolean read _AllowDefaultModule write _AllowDefaultModule;
    {$ENDREGION --> Propriedade AllowDefaultModule}

    {:O método **name** inicia o servidor em uma tarefa separada da atual.}
    public procedure Start;

    {:O método **name** para o servidor de uma tarefa separada da atual.}
    public procedure Stop;

    {$REGION --> Propriedade Active}
       private function GetActive: Boolean;Virtual;
       private procedure SetActive(aActive : Boolean);virtual;
       {:A propriedade **@name** executa o método start se a propriedade for true
         e executa o método stop se a propriedade for false.}
       public property Active : Boolean Read GetActive Write SetActive;
    {$ENDREGION --> Propriedade Active}
  end;

Var
  {: A varável publica **name** é iniciada com os parâmetros passados para a tarefa.}
  BaseURL : String;

procedure Register;

implementation

procedure Register;
begin
  {$I mi.web.fphttpserver.icon.lrs}
  RegisterComponents('Mi.Web',[TMi_FpHttpServer]);
end;

{ THTTPServerThread }

constructor THTTPServerThread.Create(aHostName: String; aPort: Integer;aAllowDefaultModule: Boolean);
begin
  inherited Create(True);  // Cria a thread mas não inicia
  FreeOnTerminate := True; // Libera a thread ao finalizar
  FTerminated     := true; // Essa tarefa é iniciada em .execute


  {$IFDEF STANDALONE}
    fphttpapp.Application.Port:=aPort;
    fphttpapp.Application.HostName:=aHostName;
    fphttpapp.Application.AllowDefaultModule:= aAllowDefaultModule;
//    fphttpapp.Application.threaded := true;
    BaseURL :=aHostName+':'+IntToStr(Application.Port);
  {$ENDIF STANDALONE}

  {$IFDEF FPFCGI}
    fpfcgi.Application.Port:=aPort;
    //fphttpapp.Application.threaded := true;
    //fpfcgi.Application.HostName:=aHostName;
    fpfcgi.Application.AllowDefaultModule:= aAllowDefaultModule;
    BaseURL :=aHostName+':'+IntToStr(Application.Port);
  {$ENDIF}

  //RegisterRoutes;
  {$IFDEF FPCGI}
    //fpcgi.Application.Port:=aPort;
    //fpcgi.Application.HostName:=aHostName;
    fpcgi.Application.AllowDefaultModule:= aAllowDefaultModule;
    BaseURL :='';//aHostName+':'+IntToStr(Application.Port);
  {$ENDIF FPCGI}

end;

constructor THTTPServerThread.Create(aAllowDefaultModule: Boolean);
begin
  Create('',-1,aAllowDefaultModule);
end;

constructor THTTPServerThread.Create(aPort: Integer;aAllowDefaultModule: Boolean);
begin
  Create('',aPort,aAllowDefaultModule);
end;

procedure THTTPServerThread.Execute;
begin
  if FTerminated
  Then begin
         FTerminated := False;
         {$IFDEF STANDALONE}
            fphttpapp.Application.Initialize;
            fphttpapp.Application.Threaded := True;
            fphttpapp.Application.Run;  // Inicia o loop de eventos do servidor HTTP
         {$ENDIF}

         {$IFDEF FPFCGI}
            fpfcgi.Application.Initialize;
            //fpfcgi.Application.Threaded := True;
            fpfcgi.Application.Run;  // Inicia o loop de eventos do servidor HTTP
         {$ENDIF}

         {$IFDEF FPCGI}
            fpCGI.Application.Initialize;
            //fpCGI.Application.Threaded := True;
            fpCGI.Application.Run;  // Inicia o loop de eventos do servidor HTTP
         {$ENDIF}
       end;
end;

procedure THTTPServerThread.StopServer;
begin
  if Not FTerminated
  then begin
         {$IFDEF STANDALONE}
           fphttpapp.Application.Terminate; // Para o servidor HTTP
         {$ENDIF}

         {$IFDEF FPFCGI}
           fpfcgi.Application.Terminate;
         {$ENDIF}

         {$IFDEF FPCGI}
           fpcgi.Application.Terminate;
         {$ENDIF}
         FTerminated := true;
       end;
end;

{ TMi_FpHttpServer }

procedure TMi_FpHttpServer.SetHostName(AValue: String);
begin
  _HostName := aValue;
  {$IFDEF STANDALONE}
    if Assigned(HTTPServerThread)
    Then fphttpapp.Application.HostName := _HostName;
  {$ENDIF STANDALONE}

  {$IFDEF FPFCGI}
  {$ENDIF}

  {$IFDEF FPCGI}
  {$ENDIF FPCGI}
end;

procedure TMi_FpHttpServer.SetPort(AValue: Word);
begin
  _Port := aValue ;
  {$IFDEF STANDALONE}
    fphttpapp.Application.Port:= _Port;
  {$ENDIF STANDALONE}

  {$IFDEF FPFCGI}
    fpfcgi.Application.Port:=aValue;
  {$ENDIF}

  {$IFDEF FPCGI}
    //fpcgi.Application.Port:=aPort;
  {$ENDIF FPCGI}
end;

procedure TMi_FpHttpServer.SetUseSSL(AValue: Boolean);
begin
  if _UseSSL = aValue
  Then exit;
  _UseSSL := aValue ;

  {$IFDEF STANDALONE}
    if Assigned(fphttpapp.Application)
    Then fphttpapp.Application.UseSSL:= _UseSSL;
  {$ENDIF STANDALONE}

  {$IFDEF FPFCGI}
    //if Assigned(fpfcgi.Application)
    //Then fpfcgi.Application.UseSSL:= _UseSSL;
  {$ENDIF}

  {$IFDEF FPCGI}
    //if Assigned(fpcgi.Application)
    //Then fpcgi.Application.UseSSL:= _UseSSL;
  {$ENDIF FPCGI}
end;

function TMi_FpHttpServer.GetHTTPServerThread: THTTPServerThread;
begin
  result := _HTTPServerThread;
end;

procedure TMi_FpHttpServer.LoadMimeTypes;
begin
  MimeTypes.LoadKnownTypes;
  if MimeFile<>''
  then begin
         MimeTypesFile:=MimeFile;
         if (MimeTypesFile<>'') and not FileExists(MimeTypesFile)
         then begin
                tMi_rtl.LogError('mimetypes file not found: '+MimeTypesFile);
                MimeTypesFile:='';
              end;
       end;
  If MimeTypesFile<>''
  then MimeTypes.LoadFromFile(MimeTypesFile);
end;

constructor TMi_FpHttpServer.Create(AOwner: TComponent);
  //var
  //  s:string;
begin
  inherited Create(AOwner);
  HostName           := HostName_default;
  Port               := Port_default;
  AllowDefaultModule := true;
  //s := Application.Location  +  'mime.type' ;
  MimeFile := ExtractFileDir(ParamStr(0))+PathDelim+'mime.type';
  if TMi_rtl.FileExists(MimeFile)
  Then LoadMimeTypes;
end;

procedure TMi_FpHttpServer.Start;
begin
  _HTTPServerThread := THTTPServerThread.Create(HostName,Port,AllowDefaultModule);
  HTTPServerThread.Start;
end;

procedure TMi_FpHttpServer.Stop;
begin
  if Assigned(HTTPServerThread) then
  begin
    HTTPServerThread.StopServer;
    //Desativei as duas linhas abaixo pq gera exceção
      //HTTPServerThread.WaitFor; // Aguarda a thread terminar
      // HTTPServerThread := nil;
  end;
end;

function TMi_FpHttpServer.GetActive: Boolean;
begin
  result := Assigned(HTTPServerThread) and
            (not(HTTPServerThread.FTerminated))
end;

procedure TMi_FpHttpServer.SetActive(aActive: Boolean);
begin
  if aActive
  Then Start
  else Stop;
end;

end.
