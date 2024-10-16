unit uMiConnectionsDb;
{:< A unit **@name** implementa o datamoule **@name** configurado para
    conectar-se e descontectar-se aos bancos de dados.}

{$mode Delphi}

interface

uses
  Classes, SysUtils, SQLDB
  ,inifiles
  ,mi.rtl.all
  ,mi_rtl_ui_Dmxscroller;

type

  { TMiConnectionsDb }
  {: O Data Module **@name** é usado para conectar-se ao banco de dados através
     de parâmetros salvos no arquivo config.ini

     - **PARÂMETROS**

       ```PASCAL

         object dm_connections: Tdm_connections
           O[]nCreate = DataModuleCreate
           OnDestroy = DataModuleDestroy
           OldCreateOrder = False
           Height = 160
           HorizontalOffset = 616
           VerticalOffset = 328
           Width = 414
           object SQLTransaction1: TSQLTransaction
             Active = False
             Action = caCommit
             Database = SQLConnector1
             Left = 336
             Top = 32
           end
           object SQLConnector1: TSQLConnector
             Connected = True
             LoginPrompt = True
             DatabaseName = 'assistente_virtual'
             KeepConnection = True
             Password = 'masterkey'
             Transaction = SQLTransaction1
             UserName = 'postgres'
             HostName = '45.160.125.12'
             Options = [scoApplyUpdatesChecksRowsAffected]
             ConnectorType = 'PostgreSQL'
             Left = 208
             Top = 32
           end
         end

       ```
     - **EXEMPLO**
       - O evento **OnCreate** do forme principal deve executar o seguinte código:

         ```pascal

            if Assigned(dm_connections)
            then begin
                   dm_connections.Connection  := true;
                   if not dm_connections.Connection
                   then halt // Termina a aplicação
                   else dm_connections.Connection  := false; //Fecha a conexão com o banco de dados
                 end;

         ```
  }
  TMiConnectionsDb = class(TDataModule)
    {: O atributo **@name** permite contectar ao banco de dados.}
    SQLConnector1: TSQLConnector;

    {: O atributo **@name** permite o usu de transações para acessar o BD. }
    SQLTransaction1: TSQLTransaction;

    {: O método **@name** torna o datamodule privado.}
    procedure DataModuleCreate(Sender: TObject);
    {: O evento **@name** é usado para checar no banco de dados se o usuário
       tem permisão para conectar-se.
    }
    procedure SQLConnector1Login(Sender: TObject; Username, Password: string);


  type
    {: O registro **@name** é usado para transferir os parâmetros entre os métodos
       do DataModule dm_connections.

    }
    TParam = record
               //CONEXÂO
               {: O campo **@name** informa ao atributo **SQLConnector1** o tipo de
                  banco de dados que será usado.

                  - Nota
                    - Fiz testes com o banco de dados **PostgresSQL**
               }
               ConnectorType,
               {: O campo **@name** informa o endereço **IP** do banco de dados.}
               HostName,

               {: O campo **@name** informa o nome do usuário administrador do banco de dados.}
               UserName,

               {: O campo **@name** informa a senha do usuário administrador do banco de dados.}
               Password:string;
             end;


  private _FileNameInit : string;
  private _Inifile : TInifile ;
  private _Param : TParam;

  protected  procedure DmxScroller_Form1CloseQuery(aDmxScroller: TUiDmxScroller; var CanClose: boolean);
  {: O método **@name** é um método abstrato e permite ler dados de login na plataforma no qual o
     o projeto maricarai for implementado.
  }
  private function GetForm_Connections(out ConnectorType,HostName,UserName,Password : string):integer;


  {: O método **name** ler os parâmetros de conexão com o banco de dados postgress

     - **NOTAS**
       - Caso o arquivo **config.ini** não exista, o método **@name** solicita do
         usuário através do método GetForm_Connections;
  }
  protected function GetParametros_Conexao(aFileName:String;var aParam:TParam):Boolean;

  {: O método **name** grava no arquivo **config.ini** os parâmetros de conexão
     com o banco de dados postgres.
  }
  protected procedure SetParametros_Conexao(aFileName:String;var aParam:TParam);

  {$Region '--->Cosntrução da propriedade Connection<---'}

    var _Connection:Boolean ;

    Private Procedure SetConnection(a_Connection:Boolean);
    Private function GetConnection():Boolean;

    {: A propriedade **@name** conecta-se ou desconecta-se do banco de dados.

       - **NOTAS**:
         - A método **@name** checa se o arquivo **config.ini** existe,
           se existir então ler os parãmetros de conexão do arquivo **config.ini**;
           se o arquivo **config.ini** não existir então pede para a pessoa
           que executou o programa informar os parâmetros para conexão,
           em seguida salva os parâmetros no arquivo  **config.ini**.

         - **PARÂMETROS DE CONEXÃO**
           - SESSÃO CONEXÃO;
             - ConnectorType;
             - UserName;
             - Password;
             - HostName;

         - **REFERÊNCIAS**
           - [Using INI Files](https://wiki.freepascal.org/Using_INI_Files)
    }
    Public Property Connection :Boolean Read GetConnection Write SetConnection;
  {$EndRegion '--->Cosntrução da propriedade Connection<---'}


  public

  published

  end;

//procedure Register;

implementation

{$R *.lfm}

//procedure Register;
//begin
//  {$I miconnectionsdb_icon.lrs}
//  RegisterComponents('Mi.Rtl',[TMiConnectionsDb]);
//end;

{ TMiConnectionsDb }

procedure TMiConnectionsDb.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(self);
end;

procedure TMiConnectionsDb.SQLConnector1Login(Sender: TObject; Username,Password: string);
begin
  //  writeLn(Sender.Classname,' Username: '+Username, ' Password: '+Password);
  TMi_Rtl.LogError(Sender.Classname+' Username: '+Username+ ' Password: '+Password);
  //if not GetFormLogin(Username,Password)
  //then TMi_rtl.TException.Create('Usuário ou senha inválido!');

end;

procedure TMiConnectionsDb.DmxScroller_Form1CloseQuery(aDmxScroller: TUiDmxScroller; var CanClose: boolean);
begin
  if  aDmxScroller.FieldByName('password').AsString <> 'masterkey'
  then with aDmxScroller,MI_MsgBox do
       begin
         aDmxScroller.MI_MsgBox.MessageBox('ATENÇÃO', 'Usuário ou senha do usuário inválidos!  ',mtWarning, [mbOK],mbOk);
         CanClose := false;
       end
  else CanClose := true;
end;

function TMiConnectionsDb.GetForm_Connections(out ConnectorType, HostName,UserName, Password: string): integer;
  var
    in_JSONObject,
    out_JSONObject : TMi_rtl.TJSONObject ;
    Mi_rtl : TMi_rtl;
begin
  try
    Mi_rtl := TMi_rtl.Create(nil);
    with Mi_rtl do
    begin
      in_JSONObject := TJSONObject.Create(['connectortype'    ,'PostgreSQL',
                                           'hostname'         ,'45.160.125.12',
                                           'username'         ,'postgres',
                                           'password'         ,'masterkey'
                                        ]);
      result := InputBox(
                   'Informe os parâmetros para conexão',
                   '~ConnectorType:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'connectortype'+^M+
                   '~     HostName:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'hostname'+^M+
                   '~     UserName:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'username'+^M+
                   '~     Password:~\ssssssssssssssssssss`sssssssssssssssssssss'+CharShowPassword+ChFN+'password'+^M
                   ,DmxScroller_Form1CloseQuery
                   ,in_JSONObject
                   ,out_JSONObject
                  );

      if result = TMI_UI_InputBox.MrOk
      then begin
            ConnectorType := out_JSONObject.Strings['connectortype'];
            HostName      := out_JSONObject.Strings['hostname'];
            UserName      := out_JSONObject.Strings['username'];
            Password      := out_JSONObject.Strings['password'];
  //            printaJsonObject(out_JSONObject);
            FreeAndNil(out_JSONObject);
           end;

      FreeAndNil(in_JSONObject);
    end;

  finally
    FreeAndNil(Mi_rtl);
  end;
end;

function TMiConnectionsDb.GetParametros_Conexao(aFileName: String;var aParam: TParam): Boolean;
begin
  aFileName := ExpandFileName(aFileName);
  if TMi_rtl.FileExists(aFileName)
  then With aParam do
       try
        _Inifile := TINIFile.Create(aFileName);
        ConnectorType := _Inifile.ReadString('CONEXAO','ConnectorType','');
        HostName      := _Inifile.ReadString('CONEXAO','HostName','');
        UserName      := _Inifile.ReadString('CONEXAO','UserName','');
        Password      := _Inifile.ReadString('CONEXAO','Password','');

         result := true;
       finally
          freeandnil(_Inifile);
       end
  else Result := false
end;

procedure TMiConnectionsDb.SetParametros_Conexao(aFileName: String;var aParam: TParam);
begin

  With aParam do
  try
    _Inifile := TINIFile.Create(aFileName);
    _Inifile.WriteString('CONEXAO','ConnectorType',ConnectorType );
    _Inifile.WriteString('CONEXAO','HostName',HostName);
    _Inifile.WriteString('CONEXAO','UserName',UserName);
    _Inifile.WriteString('CONEXAO','Password',Password);
  finally
    freeandnil(_Inifile);
  end;

end;

procedure TMiConnectionsDb.SetConnection(a_Connection: Boolean);
  procedure disconnect;
  begin
    SQLConnector1.Connected := False;
    _Connection := false;
  end;

  var
    Result_GetForm_Connections:integer;

begin
  if a_Connection
  Then begin
         //Desconecta
         if _Connection
         then disconnect;

          _FileNameInit := ChangeFileExt(ParamStr(0),'.ini');
          if not _Connection
          then repeat
                  if not GetParametros_Conexao(_FileNameInit,_Param)
                  then  begin
                          Result_GetForm_Connections := GetForm_Connections( _Param.ConnectorType,_Param.HostName,_Param.UserName,_Param.Password);
                        end
                  else Result_GetForm_Connections := TMi_rtl.MI_MsgBox.mrOK;

                  if Result_GetForm_Connections = TMi_rtl.MI_MsgBox.mrOK
                  then begin
                         try
                           SQLConnector1.ConnectorType := _Param.ConnectorType;
                           SQLConnector1.UserName      := _Param.UserName;
                           SQLConnector1.Password      := _Param.Password;
                           SQLConnector1.HostName      := _Param.HostName;

                           //TMi_rtl.MessageBox('Pressione ok para conectar-se ao banco de dados...');
                           SQLConnector1.Connected     := true;
                           _Connection                 := SQLConnector1.Connected;

                           SetParametros_Conexao(_FileNameInit,_Param);

                         Except
                           on E : Exception do
                           begin
                             TMi_rtl.LogError(E.Message);
                             TMi_rtl.MessageBox(E.Message);
                             _Connection := false;
                             TMi_rtl.DeleteFile(_FileNameInit);
                           end;
                         end;
                       end;

               until _Connection or (Result_GetForm_Connections <> TMi_rtl.MI_MsgBox.mrOK);
       end
    else disconnect;
end;

function TMiConnectionsDb.GetConnection(): Boolean;
begin
  if Not Assigned(SQLConnector1)
  Then raise Tmi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},'Conector com o banco não foi criado!');
  result :=  _Connection and SQLConnector1.Connected;
end;



end.
