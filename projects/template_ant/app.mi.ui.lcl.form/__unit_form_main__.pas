unit __unit_form_main__;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  ActnList, Menus, __unit_dm_connections__;

type

  { T__form_main__ }

  T__form_main__ = class(TForm)
    header: TPanel;
    baseboard: TPanel;
    MainMenu1: TMainMenu;
    MenuItem_Ferramentas_item02: TMenuItem;
    MenuItem_Ferramentas_Item01: TMenuItem;
    MenuItem_Ferramentas: TMenuItem;
    MenuItem_Sair: TMenuItem;
    MenuItem_Arquivos: TMenuItem;
    MenuItem_Editar: TMenuItem;
    MenuItem_Exibir: TMenuItem;
    MenuItem_Arquivos_Abrir: TMenuItem;
    MenuItem_Arquivos_Fechar: TMenuItem;
    MenuItem_Editar_tabela01: TMenuItem;
    MenuItem_Edidar_Tabela02: TMenuItem;
    MenuItem_Exibir_Tabela01: TMenuItem;
    MenuItem_Exibir_Tabela02: TMenuItem;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  __form_main__: T__form_main__;

implementation

{$R *.lfm}

{ T__form_main__ }

procedure T__form_main__.FormCreate(Sender: TObject);
begin
 //__DM_Connections__.Connection  := true;
 //if not __DM_Connections__.Connection
 //then halt;

end;

end.

