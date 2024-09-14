unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, SQLDB, DB, PQConnection, Forms, Controls, Graphics,
  Dialogs, DBCtrls, DBGrids;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    SQLConnector1: TSQLConnector;
    SQLQuery1: TSQLQuery;
    SQLTransaction1: TSQLTransaction;
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.

