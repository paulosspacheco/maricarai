unit __unit_form4__;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  __Unit_FormDock__;

type

  { T__Form4__ }

  T__Form4__ = class(T__FormDock__)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  __Form4__: T__Form4__;

implementation

{$R *.lfm}

{ T__Form4__ }

procedure T__Form4__.Button1Click(Sender: TObject);
begin
  close;
end;

end.

