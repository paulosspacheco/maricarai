unit Mi_lcl_scrollbox;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs;

type
  TMI_lcl_scrollbox = class(TScrollBox)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mi_lcl_scrollbox_icon.lrs}
  RegisterComponents('Mi.Lcl',[TMI_lcl_scrollbox]);
end;

end.
