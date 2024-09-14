unit unit_form4;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  unit_formdock;

type

  { TForm4 }

  TForm4 = class(Tformdock)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form4: TForm4;

implementation

{$R *.lfm}

{ TForm4 }

procedure TForm4.Button1Click(Sender: TObject);
begin
  close;
end;

end.

