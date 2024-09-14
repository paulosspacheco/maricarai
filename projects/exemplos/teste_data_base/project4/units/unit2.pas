unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, PQConnection;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DataSource1: TDataSource;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;

  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }



end.

