unit unit_form4;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  unit_FormDock;

type

  { Tform4 }

  Tform4 = class(TFormDock)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  form4: Tform4;

implementation

{$R *.lfm}

{ Tform4 }

procedure Tform4.Button1Click(Sender: TObject);
begin
  close;
end;

end.

