unit Unit1;
{: Teste do banco de dados PostegreSql

  - [Linguagem SQL](https://www.sqlite.org/lang.html)

  - **COMANDOS BÁSICOS SQL**
    - **REFERÊNCIA**
        - [SQL Tutorial](https://www.w3schools.com/sql/)
        - [Reference for unit 'SQLDB'](https://www.freepascal.org/docs-html/fcl/sqldb/index.html)
        - [CRIAR BANCO DE DADOS](https://www.postgresql.org/docs/11/sql-createdatabase.html)

    - Sql para criar database **maricarai**:

      ```sql

         CREATE DATABASE maricarai;
           COMMIT;

      ```

    - Sql para criar tabela de usuários

      ```sql

         CREATE TABLE usuarios(id primaru key,
                               nome  varchar(50)
                               login varchar(50)
                               password varchar(20)
                              );
         COMMIT;

      ```


    - [Create Table](https://www.sqlite.org/lang_createtable.html)
      - Exemplo:
        - Código SQL

          ```sql
              CREATE TABLE Persons (
                       PersonID int,
                       LastName varchar(255),
                       FirstName varchar(255),
                       Address varchar(255),
                       City varchar(255));
          ```
}


{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, SQLite3Conn, IBConnection, PQConnection, Forms,
  Controls, Graphics, Dialogs, StdCtrls, DBGrids, DBCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ButtonUpdateTSQLQuary : TButton;
    Button1Create_table_usuarios : TButton;
    Button2sqlPQConection : TButton;
    DataSource1 : TDataSource;
    DataSource2 : TDataSource;
    DBGrid1 : TDBGrid;
    DBGrid2 : TDBGrid;
    DBNavigator1 : TDBNavigator;
    DBNavigator2 : TDBNavigator;
    SQLConnector2 : TSQLConnector;
    SQLQuery1 : TSQLQuery;
    SQLQuery2 : TSQLQuery;
    SQLTransaction1 : TSQLTransaction;
    SQLTransaction2 : TSQLTransaction;
    TestConexao : TButton;
    SQLConnector1: TSQLConnector;
    Procedure Button1Create_table_usuariosClick ( Sender : TObject ) ;
    Procedure Button2sqlPQConectionClick ( Sender : TObject ) ;
    Procedure ButtonUpdateTSQLQuaryClick ( Sender : TObject ) ;

  private

  public

  end;

var
  Form1: TForm1;

Type
  {: Tipos de banco de dados reconhecidos pela função CreateDB_or_DropDB}
  TTypeDataBase = (SqLite3,PostgresSQL);

{: A função **@name** é usada para criar ou apagar um banco de dados

    - **Banco de dados possíveis:**
      - PostreSQL;
      - SqlLite;

   - **Retorna**
     - True  : Conseguiu criar o  banco de dados;
     - False : Error na ação
       - Error possíveis:
         - Banco de dados já existe quando se quer criar;
         - Banco de dados não existe quando se quer apagar;

   - **EXEMPLO**

     ```pascal

         Procedure TForm1.Button2sqlPQConectionClick ( Sender : TObject ) ;
         begin
           if CreateDB_or_DropDB(PostgresSQL,'127.0.0.1',
                                             'postgres',
                                             'masterkey',
                                             'maricarai',
                                             true)
           then ShowMessage('Banco de dados maricarai foi criado')
           else ShowMessage('Banco de dados maricarai não foi criado');
         End;

     ```
}
function CreateDB_or_DropDB( aTypeDataBase : TTypeDataBase;
                             aHostname,
                             aUserName,
                             aPassword,
                             aDataBaseName : String;

                             okCreateDB:Boolean //True cria; False : apaga
                           ):Boolean;

implementation

{$R *.lfm}


{ TForm1 }

Procedure TForm1.Button1Create_table_usuariosClick ( Sender : TObject ) ;
  var
    s             : string;
    SQLConnector   : TSQLConnector;
    SQLTransaction : TSQLTransaction;

    SQLQuery      : TSQLQuery;

    Conectado   : Boolean = false;
    NDB : String;
begin
  try
     //Cria o conector
     SQLConnector   := TSQLConnector.Create(nil);

     //Cria a consulta
     SQLQuery       := TSQLQuery.Create(nil);

     //Cria as transações
     SQLtransaction := TSQLTransaction.Create(nil);

     SQLConnector.ConnectorType:='PostgreSQL';
     SQLConnector.HostName := '45.160.125.12';
     SQLConnector.UserName := 'postgres';
     SQLConnector.Password := 'masterkey';
     SQLConnector.DatabaseName:= 'maricarai';

     SQLConnector.Transaction := SQLTransaction;
     SQLConnector.Transaction.Options := [stoExplicitStart];


     SQLConnector.Transaction.Active:= true;

     SQLQuery.DataBase   := SQLConnector;

     try
       SQLConnector.Transaction.Commit;
       SQLConnector.Transaction.StartTransaction;

       with SQLQuery do
         begin
           SQL.Clear;
           SQL.Add('CREATE TABLE IF NOT EXISTS USUARIOS (id INT PRIMARY KEY,');
           SQL.Add(                                      'NOME varchar(50),');
           SQL.Add(                                      'LOGIN varchar(50),');
           SQL.Add(                                      'PASSWORD varchar(50));');
           SQL.Add(                                      'COMMIT;');

           ExecSql;
         end;

         SQLConnector.Transaction.Commit;

     Except;
       SQLConnector.Transaction.Rollback;
     End;

  finally;
    freeandnil(SQLConnector);
    freeandnil(SQLQuery);
    freeandnil(SQLTransaction);
  End;

end;



function CreateDB_or_DropDB(aTypeDataBase : TTypeDataBase;
                                 aHostname,
                                 aUserName,
                                 aPassword,
                                 aDataBaseName : String;

                                 okCreateDB:Boolean //True cria; False : apaga
                                 ):Boolean;

  Var
    conn  : TSQLConnection;
Begin
 Result := true;
  try
    case aTypeDataBase of
      SqLite3     : conn := TSQLite3Connection.Create(nil);
      PostgresSQL : conn := TPQConnection.Create(nil);
      else begin
             Result := false
           end ;
    End;

    conn.HostName := aHostName;
    conn.UserName := aUserName;
    conn.Password := aPassword;
    conn.DatabaseName:= aDatabaseName;

    if okCreateDB
    then begin
           try
           conn.CreateDB

           except
             Result := false
           End;

         End
    else begin
           try

            conn.DropDB;

           except
             Result := false
           End;
         End;

  Finally
    freeandnil(conn);
  End;

End;


Procedure TForm1.Button2sqlPQConectionClick ( Sender : TObject ) ;
begin
  if CreateDB_or_DropDB(PostgresSQL,//'127.0.0.1',
                                    '45.160.125.12',
                                    'postgres',
                                    'masterkey',
                                    'maricarai',
                                     true)
  then ShowMessage('Banco de dados maricarai foi criado')
  else ShowMessage('Banco de dados maricarai não foi criado');
End;

Procedure TForm1.ButtonUpdateTSQLQuaryClick ( Sender : TObject ) ;
Begin
  SQLQuery1.ApplyUpdates;
  SQLTransaction1.Commit;
  SQLQuery1.open;
end;



end.

