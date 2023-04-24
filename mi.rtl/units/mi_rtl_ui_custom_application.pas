Unit mi_rtl_ui_custom_application;
{:< A unit **@name** implementa a classe TMI_ui_Custom_Application.

  - **VERSÃO**
    - Alpha - 0.7.1.621

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi_ui_custom_application.pas">mi_ui_Custom_Application.pas</a>)

  - **PENDÊNCIAS**


  - **REFERÊNCIA**
    - [PostgresSql MULTIBYTE-CHARSET-SUPPORTED](https://www.postgresql.org/docs/current/multibyte.html#MULTIBYTE-CHARSET-SUPPORTED)
    - [Documento oficial do componente **sqldb**](https://www.freepascal.org/docs-html/fcl/sqldb/index.html)
    - [Exemplos de uso do **SqlDb**](https://www.freepascal.org/docs-html/fcl/sqldb/usingsqldb.html)
    - [SqlDBHowto](https://wiki.freepascal.org/SqlDBHowto)
    - [tsqlquery.insertsql](https://www.freepascal.org/docs-html/fcl/sqldb/tsqlquery.insertsql.html)

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
      - **2022-03-29 16:06**
        - Criar a unit **@name** e analisar o que preciso fazer para integrar com a unit **mi_ui_Dmxscroller_sql**  ✅

      - **2022-04-06 15:40**
        - Implementar o evento Get_ParametersCloseQuery e salvar o formulário quando ele for executado.  ✅

        - No evento Get_ParametersCloseQuery Checar se o usuário é válido.  ✅

        - Criar método DoOnValidUser  ✅

        - Criar método **Get_ParametersCloseQuery** para executar o evento DoOnValidUser.  ✅

      - **2022-04-07 08:43**
        - Cada banco de dados SQL tem alguns parâmetros básicos para sua conexão:
          - Criar as propriedades de TMI_ui_Custom_Application para que o usuário
            informe esses parâmetros:
            - Banco de dados PostgresSQL
              - CharSet = 'UTF8';             ✅
              - ConnectorType:='PostgreSQL';  ✅
              - HostName := '127.0.0.1';      ✅
              - UserName := 'postgres';       ✅
              - Password := 'masterkey';      ✅
              - DatabaseName:= 'maricarai';   ✅
              - DirDatabaseName:= './';       ✅
            - connected :Boolean              ✅
            - Options : TSQLConnectorOptions ✅
          - Documentar as propriedade criadas hoje  ✅.

      - **2022-04-08**
        - **09:00**
          - Escrever a descrição da classe TMI_ui_Custom_Application.  ✅

        - **11:18**
          - Alterar o nome da propriedade **Options** para **SQLConnectorOptions**.  ✅
          - Criar a propriedade **SQLTransactionOptions**  ✅

        - **14:22**
          - Documentar as propriedades da classe TMi_ui_Custom_Application.  ✅

        - **21:40**
          - Em TMI_ui_Custom_Application.Get_ParametersCloseQuery antes de checar se os parãmetros são válidos,
            transferir os campos do formulários para as propriedades equivalentes.

      - **2022-04-14 14:58**
        - Criar a constante **OkCreateDataBase** e o método **CreateDataBase**.  ✅

      - **2022-04-15 10:00**
        - Criar método **NameDataBase** que retorna o nome do database porque o nome do dataBase é diferente
          em cada banco de dados. O postres usa um nome simples e o ip para acessar o banco,
          o SqLite3 usa o nome da pasta + nome do database + ext.  ✅



}

{$MODE Delphi} {$H+}

Interface

Uses
  Classes, SysUtils,SqlDb, DB,BufDataset , PQConnection  ,CustApp//, dialogs
  ,mi.rtl.Types
  ,mi_rtl_ui_Dmxscroller
  ,mi.rtl.Objects.Methods.Paramexecucao.Application

  ;

  type

    {: O tipo **@name** é usado no evento OnValidUser}
    TOnValidUser = function (aDmxScroller:TUiDmxScroller;aUserName:AnsiString;aPassword:AnsiString):boolean of Object;

    { TMI_ui_Custom_Application }
    {: A classe **@name** concentra as propriedades e formulários gerais necessários em qualquer aplicação.

       - Recursos globais:
         - Propriedade **Get_Parameters** cria um formulário de entrada de dados de configuração
           de acesso ao banco de dados e outros parâmetros;
         - Propriedade **SQLConnector** e **SQLTransaction** e as propriedades relacionadas;
         - O evento **OnValidUser** é usado para validar o nome do usuário e senha.
    }
//    TMI_ui_Custom_Application = Class(TCustomApplication)
     TMI_ui_Custom_Application = Class(TApplication)

      {: O atributo **@name** é usado para salvar em disco local no arquivo **FileName_Parameters** os parâmetros informados 
         pelo formulário **Get_Parameters**}   
      BufDataSet1 : TBufDataSet;

      {: O atributo **@name** permite integrar os dados da classe **TMiDmxScroller** com os componentes da LCL com DbGrid, DbEdit etc...}
      DataSource1 : TDataSource;

      {: A constante **@name** se **true** executa o método **CreateDataBase** se ExisteCreateDataBase = false }
      const
         OkCreateDataBase : boolean = false;

      {: O Método **@name** retorna **true** se o banco de dados existe e **false** se não existir.}
      function ExistDataBase:Boolean;

      {: O método **@name** cria o banco de dados se a constante OkCreateDataBase = true}
      function CreateDataBase:boolean;

      {: O método **@name** é usado pela classe **Get_Parameters**.
         - Esse evento cria o arquivo de parâmetros usando os dados das propriedades de
           **TMI_ui_Custom_Application** definidas no tempo de projeto.
      }
      procedure Get_ParametersEnter(aDmxScroller: TUiDmxScroller);

      procedure Get_ParametersExit(aDmxScroller: TUiDmxScroller);

      {: O método **@name** é usado para confirmar o fechamento do formulário Get_Parameters com botão **MrOK** caso os campos de **Get_Parameters**
         sejam válidos.

         - **NOTA**
           - Método **@name** executa o evento **DoOnValidUser**, se o mesmo for assinalado na aplicação com objetivo
             de não permitir fechar o formulário modal com botão MrOK caso ** DoOnValidUser** retornar false.

           - Pode ser usado para checar se usuário e senha são válidos bem como se os parâmetros estão compatíveis com os bancos de dados instalados.
      }
      Procedure Get_ParametersCloseQuery(aDmxScroller:TUiDmxScroller; var CanClose:boolean);

      {: O método **@name** retorna um Template usado para criar o formulário de entrada de dados para a conexão. }
      Function Login_GetTemplate ( aNext : PSItem ) : PSItem;

//   ('MYSQL40','MYSQL41','MYSQL50','MYSQL51','MYSQL55','MYSQL56','MYSQL57','MYSQL80','POSTGRESQL','INTERBASE','ODBC','ORACLE','SQLITE3','MSSQL','SYBASE');

      {: A constante **@name** contém a lista de nomes dos tipo de bancos de dados testados pelo componente
        **TMI_ui_Custom_Application**}
      Const Const_ConnectorType : Array[TUiDmxScroller.TConnectorType] of AnsiString =('PostgreSQL','SqLite3');

      {: A constante **@name** contém o nome do arquivo de parâmetros
         - A constante **@name** é inicializado em **TMI_ui_Custom_Application.create** onde:
           -  FileName_Parameters := ParamStr(0)+'_Parameters.bds';
      }
      Const FileName_Parameters : AnsiString = '';

      {$REGION '--> Property SQLConnectorOptions'}
        private _SQLConnectorOptions : TSQLConnectionOptions;
        private Procedure SetSQLConnectorOptions(aSQLConnectorOptions:TSQLConnectionOptions);

        {: A propriedade **@name** é usada para controlar o comportamento do SqlDb para esta conexão.

           - As seguintes opções podem ser definidas:
             - Type TSQLConnectionOption = (scoExplicitConnect, scoApplyUpdatesChecksRowsAffected);

             - **ONDE**:
               - **scoExplicitConnect** :
                 - Quando definido, a conexão deve ser feita explicitamente.
                 - O comportamento padrão é para **TSQLQuery** abrir implicitamente a conexão conforme necessário.

               - **scoApplyUpdatesChecksRowsAffected** :
                 - Quando definido, sempre que uma instrução SQL de atualização é executada durante **ApplyOptions**
                   de um conjunto de dados, **RowsAffected** é verificado e deve ser igual a 1.

           - **REFERÊNCIAS**
             - [tsqltransaction.options](https://www.freepascal.org/docs-html/fcl/sqldb/tsqltransaction.options.html)
        }
        published Property SQLConnectorOptions : TSQLConnectionOptions Read _SQLConnectorOptions write SetSQLConnectorOptions default [];

      {$ENDREGION '<-- Property SQLConnectorOptions'}

      {$REGION '--> Property SQLTransactionOptions'}
        private _SQLTransactionOptions : TSQLTransactionOptions;

        private Procedure SetSQLTransactionOptions(aSQLTransactionOptions:TSQLTransactionOptions);

        {: A propriedade **@name** é usada para  controlar o comportamento do SqlDb para esta transação.

           - As seguintes opções podem ser definidas:
             - Type TSQLTransactionOption = (stoUseImplicit, stoExplicitStart);

             - **ONDE**:
               - **stoUseImplicit** :
                 - Use o suporte a transações implícitas do mecanismo de banco de dados.
                   Isso significa que nenhum comando explícito de início e parada de transação será
                   enviado ao servidor quando os métodos **Commit** ou **Rollback** forem chamados
                   (tornando-os efetivamente sem operação no nível do banco de dados).

               - **stoExplicitStart**
                 - Quando definido, sempre que uma instrução SQL é executada, a transação deve ter sido iniciada
                   explicitamente. O comportamento padrão é que **TSQLStatement** ou **TSQLQuery** iniciem a transação
                   conforme necessário.

           - **REFERÊNCIAS**
             - [tsqltransaction.options](https://www.freepascal.org/docs-html/fcl/sqldb/tsqltransaction.options.html)
        }
        published Property SQLTransactionOptions : TSQLTransactionOptions Read _SQLTransactionOptions write SetSQLTransactionOptions default [];

      {$ENDREGION '<-- Property SQLTransactionOptions'}

      {$REGION '--> Property connected'}

        private Procedure SetConnected(aConnected:Boolean);
        private function GetConnected:Boolean;

        {: A propriedade **@name** conecta ao banco de dados selecionado.

           - True = Conecta ao banco;
           - False = Desconecta do banco;
        }
        published Property Connected : Boolean Read GetConnected write SetConnected;

      {$ENDREGION '<-- Property connected'}

      {$REGION '--> Property ConnectorType'}
        private _ConnectorType : TUiDmxScroller.TConnectorType;

        {: O evento **@name** seleciona o tipo de banco de dados a ser conectado}
        published Property ConnectorType : TUiDmxScroller.TConnectorType Read _ConnectorType write _ConnectorType;
      {$ENDREGION '<-- Property ConnectorType'}

      {$REGION '--> Property HostName'}

        private Procedure SetHostName(aHostName:AnsiString);
        private function GetHostName:AnsiString;
        {: A propriedade **@name** informa ao **SQLConnector** o **IP** ou domínimo onde o banco de dados foi hospedado.
        }
        published Property HostName : AnsiString Read GetHostName write SetHostName;

      {$ENDREGION '<-- Property HostName'}

      {$REGION '--> Property DirDataBaseName'}

        private Procedure SetDirDataBaseName(aDirDataBaseName:AnsiString);
        private function GetDirDataBaseName:AnsiString;

        {: A propriedade **@name** contém a pasta do HD do servidor onde o banco de  banco foi hospedado.

           - **Não foi implementado ainda**
             - Preciso de mais informações de como alterar a pasta dos bancos de dados PostgreSQL e SQLite3.
        }
        published Property DirDataBaseName : AnsiString Read GetDirDataBaseName write SetDirDataBaseName;

      {$ENDREGION '<-- Property DirDataBaseName'}

      {$REGION '--> Property DatabaseName'}

        private Procedure SetDatabaseName(aDatabaseName:AnsiString);
        private function GetDatabaseName:AnsiString;

        {: A propriedade **@name** contém o nome do Banco de Dados dentro do PostegresSQL ou do SQLite3.

        }
        published Property DatabaseName : AnsiString Read GetDatabaseName write SetDatabaseName;

      {$ENDREGION '<-- Property DatabaseName'}

      {: O método **@name** retorna o nome do banco de dados de acordo com o tipo de banco de dados.
      }
      Function NameDataBase:AnsiString;

      {$REGION '--> Property UserName'}

        private Procedure SetUserName(aUserName:AnsiString);
        private function GetUserName:AnsiString;

        {: A propriedade **@name** contém o nome do usuário conectado ao banco de dados.        }
        published Property UserName : AnsiString Read GetUserName write SetUserName;

      {$ENDREGION '<-- Property UserName'}

      {$REGION '--> Property Password'}
        private Procedure SetPassword(aPassword:AnsiString);
        private function GetPassword:AnsiString;

        {: A propriedade **@name** contém a senha do usuário conectado ao banco de dados.
        }
        published Property Password : AnsiString Read GetPassword write SetPassword;

      {$ENDREGION '<-- Property Password'}

      {$REGION '--> Property CharSet'}

          private Procedure SetCharSet(aCharSet:AnsiString);
          private function GetCharSet:AnsiString;

          {: A propriedade **@name** é usada para definir o tipo de caractere do banco de dados.

             - **NOTA**
               - Deve ser informado em tempo de designe do projeto.

             - **REFERÊNCIAS**
               - [CHARSET-TABLE](https://www.postgresql.org/docs/current/multibyte.html#CHARSET-TABLE)
          }
          published Property CharSet : AnsiString Read GetCharSet write SetCharSet;

      {$ENDREGION '<-- Property CharSet'}

      {$REGION '--> Property onValidUser'}
        private _OnValidUser : TOnValidUser;

        {: O evento **@name** é disparado toda vez que o TUiDmxScroller ativado.}
        published Property onValidUser : TOnValidUser Read _OnValidUser write _onValidUser;
        
        {: O método **@name** executa o evento **onValidUser** se o mesmo for assinalado na aplicação ou retorna true se **onValidUser = nil** }
        public function DoOnValidUser(aDmxScroller:TUiDmxScroller;aUserName:AnsiString;aPassword:AnsiString):boolean;virtual;

      {$ENDREGION '<-- Property onValidUser'}

      {$REGION '--> Property SQLConnector'}

        private _SQLConnector   : TSQLConnector;

        {: A propriedade **@name** é um componente conector de banco de dados versátil
           para uso com qualquer banco de dados suportado.

           - A incluir uma aplicação **TMi_UI_Application** na aplicação corrente automáticamente
             é disponibilizado um conector de acesso o banco de dados.

           - **REFERÊNCIAS**
             - [TSQLConnector](https://wiki.freepascal.org/TSQLConnector)
             - [sqldb/tsqlconnector](https://www.freepascal.org/docs-html/fcl/sqldb/tsqlconnector.html)
        }
        published property SQLConnector : TSQLConnector read _SQLConnector;
      {$ENDREGION '--> Property SQLConnector'}

      {$REGION '--> Property SQLTransaction'}
        private _SQLTransaction : TSQLTransaction;

        {: A propriedade **@name** representa uma transação no banco de dados na qual um TSQLQuery é tratado.

           - Na prática, pelo menos uma transação precisa estar ativa para um banco de dados,
             mesmo que você a utilize apenas para leitura de dados.

           - **NOTAS**
             - Ao usar uma única transação, defina a propriedade TConnection. Transaction para a transação
               para definir a transação padrão para o banco de dados; a propriedade TSQLTransaction.Database
               correspondente deve apontar automaticamente para a conexão.

             - Ao ativar uma TSQLTransaction o método **StartTransaction** inicia uma transação;
               chamar o método **Commit** ou o método **RollBack** confirma (salva) ou reverte (esquece/aborta) a transação.
               - Você deve cercar suas transações de banco de dados com eles, a menos que use as propriedades **Autocommit**
                 ou **CommitRetaining**.

           - **REFERÊNCIAS**
             - [tsqltransaction](https://www.freepascal.org/docs-html/fcl/sqldb/tsqltransaction.html)
        }
        published property SQLTransaction : TSQLTransaction read _SQLTransaction;
      {$ENDREGION '--> Property SQLTransaction'}

      {$REGION '--> Property Get_Parameters'}

        {: Este atributo é usado pelas classes filhas para implementar classes herdadas  de **TUiDmxScroller**.
        
           - No momento (08/04/22 a classe que herdade é: **TUiDmxScroller_form**)       
        }
        protected _Get_Parameters : TUiDmxScroller;

        {: A propriedade **@name** contém o formulário para ler os parâmetros de conexão com o banco de dados.}
        published property  Get_Parameters : TUiDmxScroller read _Get_Parameters;
      {$ENDREGION '--> Property Get_Parameters'}

      {: O método **@name** deve ser implementado para criar classe TUiDmxScroller_form_lcl
         ou TUiDmxScroller_form_HTML_Angular4.
      }
      protected procedure Create_Get_Parameters;virtual;Abstract;

      {: O constructor **@name** cria os componentes **SQLConnector**, **SQLTransaction**, **BufDataSet1**, **DataSource1**, Inicia a constante 
         **FileName_Parameters**, executa o método Create_Get_Parameters, inicializa **charSet** e liga os componentes SQLConnector com SQLTransaction
           e os componentes **DataSource1.DataSet := BufDataset1**.          
      }
      public constructor Create(AOwner: TComponent); override;

      {: O destructor **@name** destrói as classes criadas pelo constructor da classe  
      }
      public destructor Destroy; override;

    End;


  {: A função **@name** retorna a ultima instância de **TMI_ui_Custom_Application** criada no sistema}
  function Mi_ui_Custom_Application : TMI_ui_Custom_Application;

  {: A função **@name** seta a ultima instância de **TMI_ui_Custom_Application** criada no sistema e
     retorna aplicação selecionada anteriormente.
  }
  Function Set_Mi_ui_Custom_Application(aMi_ui_Custom_Application : TMI_ui_Custom_Application): TMI_ui_Custom_Application;

Implementation

var
  _Mi_ui_Custom_Application : TMI_ui_Custom_Application;

function Mi_ui_Custom_Application : TMI_ui_Custom_Application;
begin
  result := _Mi_ui_Custom_Application;
end;

Function Set_Mi_ui_Custom_Application(aMi_ui_Custom_Application : TMI_ui_Custom_Application): TMI_ui_Custom_Application;
begin
  result := _Mi_ui_Custom_Application;
  _Mi_ui_Custom_Application := aMi_ui_Custom_Application;
end;



{ TApplication_LCL }

constructor TMI_ui_Custom_Application.Create(AOwner: TComponent);
Begin
  Inherited Create ( AOwner ) ;
  FileName_Parameters := ParamStr(0)+'_Parameters.bds';
//  FileName_Parameters := ParamStr(0)+'.xml'; não funciona

  //Cria o conector
  _SQLConnector   := TSQLConnector.Create(Self);
  _SQLConnector.Name:= 'MI_ui_Custom_Application_SQLConnector';

  //Cria as transações
  _SQLtransaction := TSQLTransaction.Create(Self);
  _SQLtransaction.Name := 'MI_ui_Custom_Application_SQLtransaction';

  SQLConnector.Transaction := SQLTransaction;
//  SQLConnector.Transaction.Options := [];

  {: Os campos do atributo **@name** é obtido no Template **Login_GetTemplate** ao ativar o método **Get_Parameters** }
  BufDataSet1 := TBufDataset.Create(Self);

  {: O atributo **@name** é usado pelo método TUiDmxScroller_sql.SetDataBase com objetivo de integrar com os controles visuais LCL  }
  DataSource1 := TDataSource.Create(Self);
  DataSource1.Name:= 'MI_ui_Custom_Application_DataSource1';
  DataSource1.DataSet := BufDataset1;

  Create_Get_Parameters;

  if _Get_Parameters=nil
  then raise TUiDmxScroller.TException.create('Método Create_Get_Parameters precisa se definido.');

  if charSet = ''
  then charSet := 'UTF8';

//  SQLConnector.Transaction.Active:= true;

End;

destructor TMI_ui_Custom_Application.Destroy;
Begin
  freeandnil(_Get_Parameters);
  freeandnil(_SQLConnector);
  freeandnil(_SQLTransaction);

  Inherited Destroy;
End;

{: O Método **@name** retorna **true** se o banco de dados existe e **false** se não existir.}
function TMI_ui_Custom_Application.ExistDataBase: Boolean;
  var
    s : String;
begin
  result := true;
  case ConnectorType of
    PostgresSQL : with Get_Parameters do
                  begin
                    s := CreateDB_or_DropDB(ConnectorType,
                                            Hostname,
                                            UserName,
                                            Password,
                                            NameDataBase,
                                            true); //false : exclui; true : cria
                    if S <>''
                    then Result := true  // se S <> '' é porque ouve um erro.
                    else begin {Se S = '' é porque criou o banco e por isso devo apagar e retorna false}
                           result := false;
                           CreateDB_or_DropDB(ConnectorType,
                                                   Hostname,
                                                   UserName,
                                                   Password,
                                                   nameDataBase,
                                                   false); //false : exclui; true : cria

                         end;
                  end;

    SqLite3  : begin
                 result := FileExists(nameDataBase);
               end;
  end;


end;

function TMI_ui_Custom_Application.CreateDataBase:boolean;
   var
     s : string;
begin
  result := true;
  with Get_Parameters do
  begin
    s := CreateDB_or_DropDB(ConnectorType,
                            Hostname,
                            UserName,
                            Password,
                            NameDataBase,
                            true); //false : exclui; true : cria
    if S = ''
    then MessageBox(Format('Banco de dados %s criado com sucesso!',[Const_ConnectorType[ConnectorType]]))
    else begin
          if pos('already exists',s)=0
          then begin
                 MessageBox(s);
                 result := false
               End;
         End;
  end;
end;

procedure TMI_ui_Custom_Application.Get_ParametersEnter(
  aDmxScroller: TUiDmxScroller);
  var
    fld : TField;

  Procedure  SetField(aFielName,s:AnsiString);
  begin
    fld := BufDataSet1.FieldByName(aFielName);
    if fld <> nil
    Then Begin
           Fld.AsString :=  s;
         End;
  end;

  //SQLConnector.CharSet:='UTF8';

  //SQLConnector.ConnectorType:='PostgreSQL';
  //SQLConnector.HostName := '127.0.0.1';
  //SQLConnector.UserName := 'postgres';
  //SQLConnector.Password := 'masterkey';
  //SQLConnector.DatabaseName:= 'maricarai';


begin

  with Get_Parameters do
  if Assigned(BufDataSet1) //and getState(Mb_St_Edit)
  then begin
         if not FileExists(FileName_Parameters)
         then begin
                BufDataSet1.Insert;

                SetField('CharSet',CharSet);
                SetField('HostName',HostName);
                SetField('ConnectorType',IntToStr(ord(ConnectorType))); //PostgreSQL
                SetField('DataBaseName',DataBaseName);
                SetField('UserName',UserName);
                SetField('Password',Password);

                BufDataSet1.post;
                BufDataSet1.SaveToFile(FileName_Parameters,dfBinary);
                BufDataSet1.First;
                BufDataSet1.Edit;
              End
         else begin
                BufDataSet1.close;
                BufDataSet1.LoadFromFile(FileName_Parameters,dfBinary);
                BufDataSet1.open;
                BufDataSet1.First;
                BufDataSet1.Edit;
              End;
       end;
end;

procedure TMI_ui_Custom_Application.Get_ParametersExit(
  aDmxScroller: TUiDmxScroller);
Begin

End;

procedure TMI_ui_Custom_Application.Get_ParametersCloseQuery(
  aDmxScroller: TUiDmxScroller; var CanClose: boolean);
  //Var
  //  aUserName,aPassword : AnsiString;
Begin
  if Assigned(Get_Parameters) and Assigned(BufDataSet1)
    then with Get_Parameters do
         if  BufDataSet1.State in [dsEdit]
         then begin
                CharSet       := FieldByName('CharSet').AsString;
                HostName      := FieldByName('HostName').AsString;
                ConnectorType := TConnectorType(StrToInt(FieldByName('ConnectorType').AsString));
                DataBaseName  := FieldByName('DataBaseName').AsString;
                UserName      := FieldByName('UserName').AsString;
                Password      := FieldByName('Password').AsString;

                if DoOnValidUser(Get_Parameters,UserName,Password)
                then begin
                       if OkCreateDataBase and (not ExistDataBase) then
                       begin
                         if not CreateDataBase
                         then MessageBox(Format('Error ao crar banco de dados %s',[NameDataBase]));
                       end;

                       BufDataSet1.post;
                       BufDataSet1.SaveToFile(FileName_Parameters,dfBinary);
                       CanClose := true;
                     End
                else CanClose := false;
              End;
End;

function TMI_ui_Custom_Application.Login_GetTemplate(aNext: PSItem): PSItem;
Begin
  with Get_Parameters do
  begin
    AlignmentLabels:= taRightJustify;// taCenter;//taLeftJustify;
    result :=
     NewSItem('~ CharSet:         ~\ssssssssssssssssssss'+CharFieldName+'CharSet',
     NewSItem('~ Host name:       ~\ssssssssssssssssssss`ssssssssssssssssssssssssssssss'+CharFieldName+'HostName',
     NewSItem('~ ConnectorType:   ~\'+ CreateEnumField(TRUE, accNormal, 0,
                                                                      NewSItem('PostgreSQL',
                                                                      NewSItem('SQLite3',
                                                                      nil)))+CharFieldName+'ConnectorType',
     NewSItem('~ Banco de dados:  ~\ssssssssssssssssssss`ssssssssss'+CharFieldName+'DataBaseName',
     NewSItem('~ Nome do usuário: ~\ssssssssssssssssssss`ssssssssss'+CharFieldName+'UserName',
     NewSItem('~ Senha:           ~\ssssssssssssssssssss`ssssssssss'+CharShowPassword+CharFieldName+'Password',
            nil))))));

  End;
End;

procedure TMI_ui_Custom_Application.SetSQLConnectorOptions(aSQLConnectorOptions: TSQLConnectionOptions);
Begin
  if SQLConnector.Connected
  then SQLConnector.Connected := false;


  _SQLConnectorOptions := aSQLConnectorOptions;
  SQLConnector.Options := _SQLConnectorOptions;
End;

procedure TMI_ui_Custom_Application.SetSQLTransactionOptions(aSQLTransactionOptions: TSQLTransactionOptions);
Begin
  if SQLTransaction.Active
  then SQLTransaction.Active := false;

  _SQLTransactionOptions := aSQLTransactionOptions;
  SQLTransaction.Options := _SQLTransactionOptions;
End;

procedure TMI_ui_Custom_Application.SetConnected(aConnected: Boolean);
Begin
  SQLConnector.CharSet        := CharSet;
  SQLConnector.ConnectorType  := Const_ConnectorType[ConnectorType];
  SQLConnector.HostName       := HostName;
  SQLConnector.UserName       := UserName;
  SQLConnector.Password       := Password;
  SQLConnector.DatabaseName   := NameDatabase;
  SQLConnector.Options        := SQLConnectorOptions;
  SQLTransaction.Options      := SQLTransactionOptions;

  try
    SQLConnector.Connected := aConnected;
  Except
    on E:Exception do begin // generic handler
//      ShowMessage(Format('Exceção na classe %s. Mensagem: %s.',[E.ClassName,E.Message]));
      SQLConnector.Connected := false;
    End;
  End;

End;

function TMI_ui_Custom_Application.GetConnected: Boolean;
Begin
  result := SQLConnector.Connected;
End;


procedure TMI_ui_Custom_Application.SetHostName(aHostName: AnsiString);
Begin
  if  ParamExecucao <> nil
  Then ParamExecucao.hostName := AHostName;
End;

function TMI_ui_Custom_Application.GetHostName: AnsiString;
Begin
  if  ParamExecucao <> nil
  Then Result := ParamExecucao.hostName;
End;

procedure TMI_ui_Custom_Application.SetDirDataBaseName(aDirDataBaseName: AnsiString);
Begin
  if  ParamExecucao <> nil
  Then ParamExecucao.NomeDeArquivosGenericos.DirDatabaseName := ADirDatabaseName;
End;

function TMI_ui_Custom_Application.GetDirDataBaseName: AnsiString;
Begin
  if  ParamExecucao <> nil
  Then Result := ParamExecucao.NomeDeArquivosGenericos.DirDatabaseName;
End;

procedure TMI_ui_Custom_Application.SetDatabaseName(aDatabaseName: AnsiString);
Begin
  if  ParamExecucao <> nil
  Then ParamExecucao.NomeDeArquivosGenericos.DatabaseName := ADatabaseName;
End;

function TMI_ui_Custom_Application.GetDatabaseName: AnsiString;
Begin
  if  ParamExecucao <> nil
  Then Result := ParamExecucao.NomeDeArquivosGenericos.DatabaseName;
End;

function TMI_ui_Custom_Application.NameDataBase: AnsiString;
begin
  with Get_Parameters do
    case ConnectorType of
      PostgresSQL : result := DatabaseName;
      SqLite3     : begin
                      if DirDataBaseName[length(DirDataBaseName)] = DirectorySeparator then
                      begin
                        result := ExpandFileName(DirDataBaseName+DatabaseName+'.sqlite3');
                      end;
                    end;
    end;

end;

procedure TMI_ui_Custom_Application.SetUserName(aUserName: AnsiString);
Begin
  if  ParamExecucao <> nil
  Then ParamExecucao.Identificacao.UserName := aUserName;

End;

function TMI_ui_Custom_Application.GetUserName: AnsiString;
Begin
  if  ParamExecucao <> nil
  Then Result := ParamExecucao.Identificacao.UserName;
End;

procedure TMI_ui_Custom_Application.SetPassword(aPassword: AnsiString);
Begin
  if  ParamExecucao <> nil
  Then ParamExecucao.Identificacao.Password := aPassword;
End;

function TMI_ui_Custom_Application.GetPassword: AnsiString;
Begin
  if  ParamExecucao <> nil
  Then Result := ParamExecucao.Identificacao.Password;
End;

procedure TMI_ui_Custom_Application.SetCharSet(aCharSet: AnsiString);
Begin
  if  ParamExecucao <> nil
  Then ParamExecucao.DatabaseNameCharSet := aCharSet;
End;

function TMI_ui_Custom_Application.GetCharSet: AnsiString;
Begin
  if  ParamExecucao <> nil
  Then Result := ParamExecucao.DatabaseNameCharSet;
End;

function TMI_ui_Custom_Application.DoOnValidUser(aDmxScroller: TUiDmxScroller;
  aUserName: AnsiString; aPassword: AnsiString): boolean;
Begin
  if Assigned(OnValidUser)
  then result := OnValidUser(aDmxScroller,aUserName,aPassword)
  else Result := true;
End;

End.

Bomns exemplos de acesso a banco de dados
  SqlShell.pas
  createsql.pas


function TForm1.ConnectionTest(ChosenConfig: TDBConnectionConfig): boolean;
// Callback function that uses the info in dbconfiggui to test a connection
// and return the result of the test to dbconfiggui
var
  // Generic database connector...
  Conn: TSQLConnector;
begin
  result:=false;
  Conn:=TSQLConnector.Create(nil);
  Screen.BeginWaitCursor;
  try
    // ...actual connector type is determined by this property.
    // Make sure the ChosenConfig.DBType string matches
    // the connectortype (e.g. see the string in the
    // T*ConnectionDef.TypeName for that connector .
    Conn.ConnectorType:=ChosenConfig.DBType;
    Conn.HostName:=ChosenConfig.DBHost;
    Conn.DatabaseName:=ChosenConfig.DBPath;
    Conn.UserName:=ChosenConfig.DBUser;
    Conn.Password:=ChosenConfig.DBPassword;
    try
      Conn.Open;
      result:=Conn.Connected;
    except
      // Result is already false
    end;
    Conn.Close;
  finally
    Screen.EndWaitCursor;
    Conn.Free;
  end;
end;
