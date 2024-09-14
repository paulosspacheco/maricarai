unit form.main;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ActnList,
  form.Exe01, form.Exe02, umi_lcl_ui_ds_form;

type

  { Tform_main }

  Tform_main = class(TForm)
    Action_form_Exe02: TAction;
    Action_form_exe01: TAction;
    ActionList1: TActionList;
    Button1: TButton;
    Button2: TButton;
    procedure Action_form_exe01Execute(Sender: TObject);
    procedure Action_form_Exe02Execute(Sender: TObject);
  private

  public

  end;

var
  form_main: Tform_main;

implementation

{$R *.lfm}

{ Tform_main }

procedure Tform_main.Action_form_exe01Execute(Sender: TObject);
begin
  form_Exe01_ShowModal;
end;

procedure Tform_main.Action_form_Exe02Execute(Sender: TObject);
begin
 TMi_lcl_ui_ds_Form.ShowModal(Tform_Exe02);

end;

end.

