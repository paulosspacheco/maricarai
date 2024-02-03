unit unit_form_main;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  ActnList, Menus, unit_dm_connections;

type

  { Tform_main }

  Tform_main = class(TForm)
    header: TPanel;
    baseboard: TPanel;
    MainMenu1: TMainMenu;
    MenuItem_Arquivos_Sair: TMenuItem;
    MenuItem_Arquivos: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem_Arquivos_Abrir: TMenuItem;
    MenuItem_Arquivos_fechar: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  form_main: Tform_main;

implementation

{$R *.lfm}

{ Tform_main }

procedure Tform_main.FormCreate(Sender: TObject);
begin
 dm_connections.Connection  := true;
 if not dm_connections.Connection
 then halt;

end;

end.

