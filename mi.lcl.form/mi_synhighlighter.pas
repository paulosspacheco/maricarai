unit Mi_SynHighlighter;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs;

type
  TSynCustomHighlighter = class(TSynCustomHighlighter)
  private

  protected

  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I mi_synhighlighter_icon.lrs}
  RegisterComponents('Mi.Lcl',[TSynCustomHighlighter]);
end;

end.
