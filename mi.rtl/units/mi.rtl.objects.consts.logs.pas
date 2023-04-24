unit mi.rtl.Objects.Consts.Logs;
{:< - A Unit **@name** implementa a classe **TFilesLogs** baseado na classe  **TEventLog** da **FCL**

  - **VERSÃO**
    - Alpha - 0.7.1.621

  - **REFERÊNCIA**
    - [TEventLog](https://www.freepascal.org/docs-html/current/fcl/eventlog/teventlog.html)

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.files.logs.pas">mi.rtl.files.logs.pas</a>)


  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **08/12/2021**
        - 13:55 a 18:30 : Análise do projeto **@name**;
        - 20:30 a 22:40 : Criar a unit **@name** e a classe **TFilesLogs**;
      - **09/12/2021**
        - 06:20 a 07:06 : Documentar a unit **@name**;
        - 09:02 a 12:15 : Documentar a classe **TFilesLogs**.
        - 14:45 a 15:15 : Criar os métodos  **TFilesLogs.Warning** e documentar.

      - **13/12/2021**
        - 20:40 a ?? -Criar os métodos  **TFilesLogs.info** e documentar.
}

{$IFDEF FPC}
  {$mode Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils,dos,
  mi.rtl.objects.consts,
  eventlog;

Type
  {: - A classe **@name** é usada para registrar no arquivo **ParamStr(0)**+'.log' as mensagens de
       **Erros**, **Atenções** e **avisos** do sistema.

     - **NOTA**
       - A classe TObjectss implementa a constante global **const TObjectss.Logs : TFilesLogs = nil;** que  é
         inicializado em **mi.rtl.objectss.Initialization** e destruído em **mi.rtl.objectss.finalization**
  }
  TFilesLogs =
  class(TObjectsConsts)
    {: - O tipo **@name** é usado pra direcionar o destino das mensagens de log.

       - TLogType
         - **ltSystem** : Envia as mensagens de log para **/var/syslog** no linux ou o arquivo de log do sistema operacional.
           - Obs: O windows não tem esse arquivo de log padrão, por isso não funciona na plataforma windows.

         - **ltFile** :  Envia as mensagens de log para **NomeDoArquivo.log** definido por **FileName**.

         - **ltStdOut** : Envia as mensagens de log para o monitor de vídeo.
         - **ltStdErr** : Envia as mensagens de log para o monitor de vídeo.
    }
    public type TLogType = eventlog.TLogType;

    private _fileLog : TEventLog;
    published property fileLog : TEventLog Read _fileLog;

    {: O constructor **@name** cria uma instância da classe  TFilesLogs e inicializa as propriedade **FileName := ParamStr(0)+'.log'**,
       **LogType := ltFile**, *RaiseExceptionOnError := true*, **AppendContent := true** e **  active := true**.
    }
    public constructor Create(aowner:TComponent);Override;Overload;
    public destructor destroy;override;

    private Procedure CheckInactive;
    private procedure SetFileName(aFileName:String);
    private function GetFileName():String;

    {: A propriedade **@name** armazena o nome do arquivo de log necessário quando a propriedade  **LogType=ltFile**
    }
    public property FileName : string read GetFileName write SetFileName;

    {: - A procedure **@name** é usada registrar mensagens do tipo **etWarning**.

       - **PARÂMETROS**
         - **Fmt** : String que será formatada com a função [**Format**](https://www.freepascal.org/docs-html/rtl/sysutils/format.html)
         - **Args** : Valores a serem usadas no função format(FMT,Args)

       - **REFERÊNCIA**
         - [TEventLog.warning](https://www.freepascal.org/docs-html/fcl/eventlog/teventlog.warning.html)

       - **EXEMPLO**:

         ```pascal

           procedure TMi_Rtl_Tests.Action_test_Logs_WarningExecute(Sender: TObject);
           begin
             with Tobjectss do
               if Logs.Active then
               with Logs do
               begin
                 Warning('Pouco espaço em disco. Tamanho livre = %s.', ['1GB']);
               end;
           end;

         ```

         - Arquivo de logs: **rtl.log**:
           -  [2021-12-09 14:58:00.588 Warning] Pouco espaço em disco. Tamanho livre = 1GB.
    }
    public procedure Warning( const Fmt: string;Args: array of Const);overload;

    {: - A procedure **@name** é usada registrar mensagens do tipo **etWarning**.

       - **PARÂMETROS**
         - **Msg** : String com a mensagem de atenção.

       - **REFERÊNCIA**
         - [TEventLog.warning](https://www.freepascal.org/docs-html/fcl/eventlog/teventlog.warning.html)

       - **EXEMPLO**:

         ```pascal

           procedure TMi_Rtl_Tests.Button2Click(Sender: TObject);
           begin
             with Tobjectss do
               if Logs.Active then
               with Logs do
               begin
                 Warning('Senha inválida!');
               end;
           end;

         ```

         - Arquivo de logs: **rtl.log**:
           -  [2021-12-09 14:58:00.588 Warning] Senha inválida
    }
    public procedure Warning( const Msg: string );overload;

    {: - A procedure **@name** é usada registrar mensagens do tipo **etError**.

       - **PARÂMETROS**
         - **Fmt** : String que será formatada com a função [**Format**](https://www.freepascal.org/docs-html/rtl/sysutils/format.html)
         - **Args** : Valores a serem usadas no função format(FMT,Args)

       - **REFERÊNCIA**
         - [TEventLog.error](https://www.freepascal.org/docs-html/fcl/eventlog/teventlog.error.html)

       - **EXEMPLO**:

         ```pascal

           procedure TMi_Rtl_Tests.Action_test_Logs_ErrorExecute(Sender: TObject);
           begin
             with Tobjectss do
               if Logs.Active then
               with Logs do
               begin
                 Error('Exemplo de mensagem de erro. Número do erro = %d.', [5]);
               end;
           end;

         ```

         - Arquivo de logs: **rtl.log**:
           - [2021-12-09 10:25:41.425 Error] Exemplo de mensagem de erro. Número do erro = 5.
    }
    public procedure Error(const Fmt: String; Args: array of const);overload;

    {: - A procedure **@name** é usada registrar mensagens do tipo **etError**.

       - **PARÂMETROS**
         - **Msg** : String com o nome do erro.

       - **REFERÊNCIA**
         - [TEventLog.error](https://www.freepascal.org/docs-html/fcl/eventlog/teventlog.error.html)

       - **EXEMPLO**:

         ```pascal

           procedure TMi_Rtl_Tests.Button2Click(Sender: TObject);
           begin
             with TObjectss do
               if Logs.Active then
               with Logs do
               begin
                 Error('Acesso ao arquivo negado.' );
               end;
           end;

         ```

         - Arquivo de logs: **rtl.log**:
           - [2021-12-09 10:25:41.425 Error] Acesso ao arquivo negado.
    }
    public procedure Error(const Msg: String);overload;

    {: - A procedure **@name** é usada registrar mensagens do tipo **etInfo**.

       - **PARÂMETROS**
         - **Fmt** : String que será formatada com a função [**Format**](https://www.freepascal.org/docs-html/rtl/sysutils/format.html)
         - **Args** : Valores a serem usadas no função format(FMT,Args)

       - **REFERÊNCIA**
         - [TEventLog.Info](https://www.freepascal.org/docs-html/current/fcl/eventlog/teventlog.info.html)

       - **EXEMPLO**:

         ```pascal

           procedure TMi_Rtl_Tests.Action_test_Logs_InfoExecute(Sender: TObject);
           begin
             with Tobjectss do
               if Logs.Active then
               with Logs do
               begin
                 Info('A versão %s será lançada em breve.', ['Beta 3.5']);
               end;
           end;

         ```

         - Arquivo de logs: **rtl.log**:
           -  [2021-12-13 20:46:32.745 Info] A versão Beta 3.5 será lançada em breve.
    }
    public procedure Info(const Fmt: String; Args: array of const);overload;

    {: - A procedure **@name** é usada registrar mensagens do tipo **etInfo**.

       - **PARÂMETROS**
         - **Msg** : String com mensagem informativa.

       - **REFERÊNCIA**
         - [TEventLog.Info](https://www.freepascal.org/docs-html/current/fcl/eventlog/teventlog.info.html)

       - **EXEMPLO**:

         ```pascal

           procedure TMi_Rtl_Tests.Action_Test_Logs_InfoExecute(Sender: TObject);
           begin
             with Tobjectss do
               if Logs.Active then
               with Logs do
               begin
                 info('Sistema abortou de forma inesperada.' );
               end;
           end;

         ```

         - Arquivo de logs: **rtl.log**:
           -  [2021-12-13 20:46:32.745 Info] Sistema abortou de forma inesperada.
    }
    public procedure Info(const Msg: String);overload;

    private function GetActive:Boolean;
    private procedure SetActive(aActive:Boolean);

    {: A propriedade **@name** ativa e desativa a gravação de mensagens no arquivo de log.
    }
    public Property Active : Boolean Read GetActive write SetActive;

    private function GetLogType: TLogType;
    private procedure SetLogType(const Value: TLogType);

    {: - A propriedade **@name** redireciona o destino das mensagens de log.

       - Veja o tipo **TLogType** para mais informações.
    }
    public  Property LogType : TLogType Read GetLogtype Write SetlogType;

    private function GetAppendContent: Boolean;
    private procedure SetAppendContent(const Value: Boolean);

    {: - A propriedade **@name** é usada para indicar ao sistema que o arquivo de log deve ser único ou acumulativo
      
       - **PARÂMETROS**
         - **True**  : A abertura do arquivo de log  é aberto com o comando **append**
         - **False** : A abertura do arquivo de log  é aberto com o comando **rewrite**

         - **Código usado na abertura do arquivo**

            ```pascal

                if AppendContent and FileExists(FileName) then
                   FileFlags := fmOpenWrite
                else
                   FileFlags := fmCreate;

            ```
    }
    public Property AppendContent : Boolean Read GetAppendContent Write SetAppendContent;

    private function GetRaiseExceptionOnError: Boolean;
    private procedure SetRaiseExceptionOnError(const Value: Boolean);

    {: - A propriedade **@name** informa ao sistema se deve gerar exceções quando houver erro ao gravar o log.

       - **Exemplo de uso de @name**

         ```pascal

            procedure TEventLog.WriteFileLog(EventType : TEventType; const Msg : String);
              Var
                S : String;
            begin
              S:=FormatLogMessage(EventType, Msg)+LineEnding;
              try
                FStream.WriteBuffer(S[1],Length(S));
                S:='';
              except
                On E : Exception do
                   S:=E.Message;
                end;

              If (S<>'') and RaiseExceptionOnError 
              then  Raise ELogError.CreateFmt(SErrLogFailedMsg,[S]);

            end;
         ```
    }
    public Property RaiseExceptionOnError : Boolean Read GetRaiseExceptionOnError Write SetRaiseExceptionOnError;

    private _WriteBuffer :AnsiString; //Salva as informações passadas por _Write;
    public Function _Write(Const S : AnsiString;Ln:Boolean):SmallInt;
    public Function Flush_WiteBuffer:Boolean;
    public Function WriteFErr_Ln_On_Off(Const S : AnsiString;aLn_On_Off:Boolean):SmallInt;
    public Function WriteFErr(Const S : AnsiString):SmallInt;
    public Function WriteLnFErr(Const S : AnsiString):SmallInt;

    public const EnableWriteIdentificao : Boolean = true;
    public Procedure WriteIdentificao;
    public PROCEDURE LogError (const Fmt: String; Args: array of const);overload;
    public PROCEDURE LogError (CONST Msg:AnsiString );overload;

  end;

implementation

  Resourcestring
    SErrOperationNotAllowed = 'Operation not allowed when eventlog is active.';

{ TFilesLogs }

constructor TFilesLogs.Create(aowner: TComponent);
begin
  inherited Create(aowner);
  _FileLog := TEventLog.Create(Self);

  //Calcula o nome do arquivo de log.
  //O nome do arquivo será o nome do programa.log
  FileName := ParamStr(0)+'.log';

  LogType := ltFile;  //Salva no arquivo da variável: FileName
//  LogType := ltSystem; //No linux, salva no arquivoo /var/log/sysLog.log
//  LogType := ltStdOut;
//  LogType := ltStdErr;

  _WriteBuffer := '';
  RaiseExceptionOnError := true;
  Self.AppendContent:= true;
  active := true;
end;

destructor TFilesLogs.destroy;
begin

  if _FileLog<>nil
  then begin
         active := false;
         _FileLog.Destroy;
       end;

  inherited destroy;
end;

procedure TFilesLogs.CheckInactive;
begin
  If (_FileLog<>nil) and _FileLog.Active
  then Raise ELogError.Create(SErrOperationNotAllowed);     //Operação não permitida quando o log de eventos está ativo.
end;

procedure TFilesLogs.SetFileName(aFileName: String);
begin
  CheckInactive;
  _FileLog.FileName := aFileName;
end;

function TFilesLogs.GetFileName: String;
begin
  if _FileLog<>nil
  then result := _FileLog.FileName
  else result := '';
end;

function TFilesLogs.GetActive: Boolean;
begin
  If (_FileLog<>nil) and _FileLog.Active
  then result := _FileLog.Active
  else Result := false;
end;

procedure TFilesLogs.SetActive(aActive: Boolean);
begin
  If (_FileLog<>nil)
  then _FileLog.Active := aActive
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.Warning(const Fmt: string; Args: array of const);
begin
  If (_FileLog<>nil) and _FileLog.Active
  then _FileLog.Warning(Fmt,Args)
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.Warning(const Msg: string);
begin
  If (_FileLog<>nil) and _FileLog.Active
  then _FileLog.Warning(msg)
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;


procedure TFilesLogs.Error(const Fmt: String; Args: array of const);
begin
  If (_FileLog<>nil) and _FileLog.Active
  then _FileLog.Error(Fmt,Args)
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;


procedure TFilesLogs.Error(const Msg: String);
begin
  If (_FileLog<>nil) and _FileLog.Active
  then _FileLog.Error(msg)
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.Info(const Fmt: String; Args: array of const);
begin
  If (_FileLog<>nil) and _FileLog.Active
  then _FileLog.Info(Fmt,Args)
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.Info(const Msg: String);
begin
  If (_FileLog<>nil) and _FileLog.Active
  then _FileLog.info(msg)
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;



function TFilesLogs.GetLogType: TLogType;
begin
  If (_FileLog<>nil)
  then result := _FileLog.LogType
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.SetLogType(const Value: TLogType);
begin
  If (_FileLog<>nil)
  then _FileLog.LogType := Value
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

function TFilesLogs.GetAppendContent: Boolean;
begin
  If (_FileLog<>nil)
  then result := _FileLog.AppendContent
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.SetAppendContent(const Value: Boolean);
begin
  If (_FileLog<>nil)
  then _FileLog.AppendContent := Value
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

function TFilesLogs.GetRaiseExceptionOnError: Boolean;
begin
  If (_FileLog<>nil)
  then result := _FileLog.RaiseExceptionOnError
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

procedure TFilesLogs.SetRaiseExceptionOnError(const Value: Boolean);
begin
  If (_FileLog<>nil)
  then _FileLog.RaiseExceptionOnError := Value
  else Raise ELogError.Create(TStrError.ErrorMessage(Objeto_Nao_Inicializado));
end;

//type EMyLittleException = Class(Exception);
function TFilesLogs._Write(const S: AnsiString; Ln: Boolean): SmallInt;

Begin
  If (_FileLog<>nil)
  then  If _FileLog.Active
        Then Begin
               Result := 0;
               If Ln Then
                 _WriteBuffer := _WriteBuffer +S+LF
               Else _WriteBuffer := _WriteBuffer +S;
             End
       else Result := -1;

end;

function TFilesLogs.Flush_WiteBuffer: Boolean;
begin
  If (_FileLog<>nil) and  _FileLog.Active
  then begin
         Error(_WriteBuffer);
         _WriteBuffer := '';
         Result := true;
       end
  else result := false;

end;

function TFilesLogs.WriteFErr_Ln_On_Off(const S: AnsiString;
  aLn_On_Off: Boolean): SmallInt;
  Var
    WOkOpen : Boolean;

Begin
  If (_FileLog<>nil)
  then Try

          IF Not _FileLog.active
          THEN Begin
                 _FileLog.active := true;
                 if _FileLog.active
                 Then Result := 0
                 else Result := Erro_Excecao_inesperada;

                 If Result = 0
                 Then WOkOpen := true
                 Else WOkOpen := false;
               end
          Else Begin
                 WOkOpen := false;
                 Result  := 0;
               End;

          If Result = 0
          Then Result := _Write(S,aLn_On_Off);

       Finally
          If WOkOpen
          Then _FileLog.active := false;
       End;
end;

function TFilesLogs.WriteFErr(const S: AnsiString): SmallInt;
Begin
  Result := WriteFErr_Ln_On_Off(S,false);
end;

function TFilesLogs.WriteLnFErr(const S: AnsiString): SmallInt;
Begin
  Result := WriteFErr_Ln_On_Off(S,True);
end;

Procedure TFilesLogs.WriteIdentificao;
begin
  if EnableWriteIdentificao
  then begin
         WRITELNFerr(LF+
                     'USUÁRIO LOGADO');
         WRITELNFerr('  Filial........: '+Format('%d',[Identification.Id_branch]));
         WRITELNFerr('  Matrícula.....: '+Format('%d',[Identification.Id_user]));
         WRITELNFerr('  Login.........: '+Identification.Username);
         WRITELNFerr('  Nome Completo.: '+Identification.FullUserName);
         WriteLnFErr(' ');
         WRITELNFerr('PASTA DO LOG....: '+ExpandFileName('.'));
         WRITELNFerr('ARQUIVO DE LOG..: '+ExtractFileName(FileName));
       end;
end;

procedure TFilesLogs.LogError(const Fmt: String; Args: array of const);
begin
  WRITELNFerr(LF+
              'Aplicação.......: '+ExtractFileName(ParamStr(0)));
  WRITELNFerr('Error...........: '+Format(Fmt,Args));
  WriteIdentificao;
  Flush_WiteBuffer;

end;

procedure TFilesLogs.LogError(const Msg: AnsiString);
begin
  LogError(Msg,[]);
end;

end.

