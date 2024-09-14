unit unit_test1;

{$mode Delphi}

interface

uses
  Classes, SysUtils, SQLDB, DB, Forms, Controls, Graphics, Dialogs, DBCtrls,
  udm_connections, Mi_SQLQuery;

type

  { TForm1 }

  TForm1 = class(TForm)
    DataSource1: TDataSource;
    SQLQuery1: TSQLQuery;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin


end;

end.

