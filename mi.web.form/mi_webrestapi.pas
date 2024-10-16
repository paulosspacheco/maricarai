unit Mi_WebRestApi;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs;

type
  TMi_WebRestApi = class(TFPWebModule)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mi_webrestapi_icon.lrs}
  RegisterComponents('Mi.Web',[TMi_WebRestApi]);
end;

end.
