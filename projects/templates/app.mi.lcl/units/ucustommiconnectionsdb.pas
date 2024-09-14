unit uCustomMiConnectionsDb;

{$mode Delphi}

interface

uses
  Classes, SysUtils,uMiConnectionsDb;

type

  { TCustomMiConnectionsDb }

  TCustomMiConnectionsDb = class(TMiConnectionsDb)
    procedure DataModuleCreate(Sender: TObject);
  private

  public

  end;

var
  CustomMiConnectionsDb: TCustomMiConnectionsDb;

implementation

{$R *.lfm}

{ TCustomMiConnectionsDb }

procedure TCustomMiConnectionsDb.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

end.

