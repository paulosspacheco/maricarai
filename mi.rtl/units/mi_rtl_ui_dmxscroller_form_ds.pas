unit mi_rtl_ui_dmxscroller_form_ds;

{$mode Delphi}

interface

uses
  Classes, SysUtils
  //, LResources
  //, Forms
  //, Controls
  //, Graphics
  //, Dialogs
  ,mi_rtl_ui_dmxscroller_form;

type

  { TDmxScroller_Form_DS }

  TDmxScroller_Form_DS = class(TDmxScroller_Form)
  private

  protected procedure SetActiveTarget(aActive: Boolean);
  public

  published

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mi.Rtl',[TDmxScroller_Form_DS]);
end;

{ TDmxScroller_Form_DS }

procedure TDmxScroller_Form_DS.SetActiveTarget(aActive: Boolean);

begin
  if active
  then active := false;

  if aActive
     and (Assigned(onGetTemplate) or
          Assigned(onAddTemplate) or
         ((Strings <>nil) and (Strings.Count>0))
         )
  then begin
         SetState(Mb_St_Creating,true);
         CreateStruct;

         _Active := aActive;
         SetState(Mb_St_Active,true);
         SetState(Mb_St_Creating,False);
         if Assigned(onEnter)
         then begin
                 onEnter(Self);
                 Refresh;
              end;
       end;
end;

end.


