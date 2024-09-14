unit umi_ui_dmxscroller_form_lcl_ds_test_webmodules;

{$mode Delphi}

interface

uses
  SysUtils, Classes, uMi_ui_DmxScroller_Form_Lcl_ds_test2_dm,
  umi_ui_dmxscroller_form_lcl_ds, httpdefs, fpHTTP, fpWeb;

type

  { TFPWebModule1 }

  TFPWebModule1 = class(TFPWebModule)
    procedure DataModuleCreate(Sender: TObject);
  private
     _Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm :TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm;
  public

  end;

var
  FPWebModule1: TFPWebModule1;

implementation

{$R *.lfm}

{ TFPWebModule1 }

procedure TFPWebModule1.DataModuleCreate(Sender: TObject);
begin
  _Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm := TMi_ui_DmxScroller_Form_Lcl_ds_test2_dm.Create(self);
  Mi_ui_DmxScroller_Form_Lcl_ds_test2_dm.DmxScroller_Form_Lcl_DS1.Active := true;
end;

initialization
  RegisterHTTPModule('TFPWebModule1', TFPWebModule1);
end.

