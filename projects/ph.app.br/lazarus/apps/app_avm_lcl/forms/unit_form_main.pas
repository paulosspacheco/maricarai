unit unit_form_main;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, unit_dm_connections;

type

  { Tform_main }

  Tform_main = class(TForm)
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

