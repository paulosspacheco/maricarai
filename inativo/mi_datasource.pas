unit mi_DataSource;

{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, db
  ,SQLDB;

type

  { Tmi_DataSource }

  Tmi_DataSource = class(TDataSource)

    private

    protected

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;


  published
  {$REGION Property DmxFieldRec }
    private _SQLQuery : TSQLQuery;
    private Procedure SetSQLQuery(aSQLQuery:TSQLQuery);

    {: A propriedade **@name** contém o campo comboBox se ser editado }
    published property SQLQuery : TSQLQuery read _SQLQuery Write SeTSQLQuery;

  {$ENDREGION Property SQLQuery }

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mi_datasource_icon.lrs}
  RegisterComponents('Mi.Rtl',[Tmi_DataSource]);
end;

{ Tmi_DataSource }

{
PacketRecords = -1
IndexName = 'DEFAULT_ORDER'
MaxIndexesCount = 4
FieldDefs = <>
Database = dm_connections.SQLConnector1
Transaction = dm_connections.SQLTransaction1
SQL.Strings = (
  'select * from __dm_xtable__'
)
Options = [sqoKeepOpenOnCommit, sqoAutoApplyUpdates, sqoAutoCommit, sqoCancelUpdatesOnRefresh]
Params = <>
Macros = <>
}
constructor Tmi_DataSource.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SQLQuery := TSQLQuery.Create(self);
  SQLQuery.Name:= 'TSQLQuery';
  with SQLQuery do
  begin
    PacketRecords := -1;
//    IndexName := 'DEFAULT_ORDER';
    MaxIndexesCount := 4;
//    FieldDefs := <>;
//    Database := dm_connections.SQLConnector1;
//    Transaction := dm_connections.SQLTransaction1;
    SQL.text :=  'select * from __dm_xtable__';
    Options := [sqoKeepOpenOnCommit, sqoAutoApplyUpdates, sqoAutoCommit, sqoCancelUpdatesOnRefresh];
//    Params := <> ;
//    Macros := <> ;
  end;


  DataSet  := SQLQuery;
end;

destructor Tmi_DataSource.Destroy;
begin
  if Assigned(_SQLQuery) and (_SQLQuery.Owner=self)
  then FreeAndNil(_SQLQuery);
  inherited Destroy;
end;

procedure Tmi_DataSource.SetSQLQuery(aSQLQuery: TSQLQuery);
begin
  if Assigned(_SQLQuery) and (_SQLQuery.Owner=self)
  then FreeAndNil(_SQLQuery);
  _SQLQuery := aSQLQuery;
end;

end.
