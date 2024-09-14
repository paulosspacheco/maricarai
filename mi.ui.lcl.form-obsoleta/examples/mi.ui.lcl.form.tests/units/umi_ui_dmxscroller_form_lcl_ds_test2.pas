unit uMi_ui_DmxScroller_Form_Lcl_ds_test2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, DBGrids
  ,uMi_ui_DmxScroller_Form_Lcl_ds_test2_dm
  ,uMi_ui_scrollbox_lcl, uMi_ui_DmxScroller_Form_Lcl;

type

  { TMi_ui_DmxScroller_Form_Lcl_ds_test2 }

  TMi_ui_DmxScroller_Form_Lcl_ds_test2 = class(TForm)
    DBGrid1: TDBGrid;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Mi_ui_DmxScroller_Form_Lcl_ds_test2: TMi_ui_DmxScroller_Form_Lcl_ds_test2;

implementation

{$R *.lfm}

{ TMi_ui_DmxScroller_Form_Lcl_ds_test2 }

procedure TMi_ui_DmxScroller_Form_Lcl_ds_test2.FormCreate(Sender: TObject);
begin
//  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm := TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.Create(self);
  DBGrid1.DataSource := Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DataSource1;
  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1.ParentLCL := self.Mi_ScrollBox_LCL1;
  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1.Active := true;
end;

end.

