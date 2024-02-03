unit unit_dm_connections;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList;

type

  { Tdm_connections }

  Tdm_connections = class(TDataModule)
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
  private

  public

  end;

var
  dm_connections: Tdm_connections;

implementation

{$R *.lfm}

end.

