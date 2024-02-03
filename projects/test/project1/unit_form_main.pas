unit unit_form_main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, unit_dm_connections;

type

  { Tform_main }

  Tform_main = class(TForm)
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
  private

  public

  end;

var
  form_main: Tform_main;

implementation

{$R *.lfm}

end.

