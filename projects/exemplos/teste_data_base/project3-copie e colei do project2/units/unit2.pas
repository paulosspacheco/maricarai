unit Unit2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, odbcconn, DB;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    SQLConnector1: TSQLConnector;
    SQLTransaction1: TSQLTransaction;
    SQLQuery1: TSQLQuery;
    DataSource1: TDataSource;
    id: TLongintField;
    login: TStringField;
    nome: TStringField;
    password: TStringField;
    telefone: TStringField;
    procedure DataModuleCreate(Sender: TObject);

  private

  public

  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.lfm}

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin

end;

end.

