unit ;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  unit_FormDock;

type

  { T }

  T = class(TFormDock)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  : T;

implementation

{$R *.lfm}

{ T }

procedure T.Button1Click(Sender: TObject);
begin
  close;
end;

end.

