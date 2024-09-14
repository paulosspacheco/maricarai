unit Action2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ActnList;

type
  TAction1 = class(TAction)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I action2_icon.lrs}
  RegisterComponents('',[TAction1]);
end;

end.
