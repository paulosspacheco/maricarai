unit SQLQuery1;

{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, sqldb;

type
  TSQLQuery1 = class(TSQLQuery)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I sqlquery1_icon.lrs}
  RegisterComponents('SQLdb',[TSQLQuery1]);
end;

end.
