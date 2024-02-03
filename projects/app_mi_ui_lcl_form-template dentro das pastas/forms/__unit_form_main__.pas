unit __unit_form_main__;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, __unit_dm_connections__;

type

  { T__form_main__ }

  T__form_main__ = class(TForm)
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
 __DM_Connections__.Connection  := true;
 if not __DM_Connections__.Connection
 then halt;

end;

end.

