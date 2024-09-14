unit unit_XOperadores;

{$mode Delphi}

interface

uses
  Classes, SysUtils, unit_dm_connections, SQLDB, DB;

type

  { TXOperadores }

  TXOperadores = class(TDataModule)
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  XOperadores: TXOperadores;

implementation

{$R *.lfm}

{ TXOperadores }

procedure TXOperadores.DataModuleCreate(Sender: TObject);
begin
  if not DM_Connections.Connection
  then DM_Connections.Connection := true;
  SQLQuery1.Active:=true;
end;

end.

