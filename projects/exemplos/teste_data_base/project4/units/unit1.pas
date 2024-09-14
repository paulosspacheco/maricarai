unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  Unit2;

type

  { TForm1 }

  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    procedure FormCreate(Sender: TObject);
  private
     DataModule1 : TDataModule1;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  DataModule1 := TDataModule1.Create(self);
  DataModule1.SQLQuery1.Active:=true;;
end;

end.

