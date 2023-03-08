{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi.ui.lcl.form;

{$warn 5023 off : no warning about unused units}
interface

uses
  umi_ui_dmxscroller_form_lcl_ds, uMi_ui_scrollbox_lcl, umi_ui_InputBox_lcl, 
  uMi_ui_Dmxscroller_form_lcl, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('umi_ui_dmxscroller_form_lcl_ds', 
    @umi_ui_dmxscroller_form_lcl_ds.Register);
  RegisterUnit('uMi_ui_scrollbox_lcl', @uMi_ui_scrollbox_lcl.Register);
  RegisterUnit('uMi_ui_Dmxscroller_form_lcl', 
    @uMi_ui_Dmxscroller_form_lcl.Register);
end;

initialization
  RegisterPackage('mi.ui.lcl.form', @Register);
end.
