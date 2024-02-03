unit __unit1__;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, googlecoordinate, Forms, Controls, Graphics, Dialogs,
  Menus, Buttons, ComCtrls, StdCtrls, AnchorDockPanel, __unit2__;

type

  { T__Form1__ }

  T__Form1__ = class(TForm)
    AnchorDockPanel1: TAnchorDockPanel;
    CoolBar1: TCoolBar;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  __Form1__: T__Form1__;

implementation

{$R *.lfm}

{ T__Form1__ }

procedure T__Form1__.FormCreate(Sender: TObject);
begin
  __DataModule1__.Connection  := true;
  if not __DataModule1__.Connection
  then halt;
end;

end.

