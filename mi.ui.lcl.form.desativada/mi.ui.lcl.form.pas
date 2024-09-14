{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi.ui.lcl.form;

{$warn 5023 off : no warning about unused units}
interface

uses
  uMi_ui_scrollbox_lcl, umi_ui_dmxscroller_form_lcl_attributes, 
  umi_ui_bitbtn_lcl, umi_ui_button_lcl, umi_ui_checkbox_lcl, 
  umi_ui_radiogroup_lcl, uMi_ui_ComboBox_lcl, uMi_Ui_DBCheckBox_Lcl, 
  uMi_Ui_DbComboBox_lcl, uMI_ui_DbEdit_LCL, umi_ui_dblookupComboBox_lcl, 
  uMI_ui_DbRadioGroup_Lcl, uMi_ui_Label_lcl, uMi_ui_maskedit_lcl, 
  uMi_ui_Dmxscroller_form_lcl, umi_ui_dmxscroller_form_lcl_ds, 
  umi_ui_msgbox_lcl, uMi_ui_Application_lcl, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uMi_ui_scrollbox_lcl', @uMi_ui_scrollbox_lcl.Register);
  RegisterUnit('uMi_ui_Dmxscroller_form_lcl', 
    @uMi_ui_Dmxscroller_form_lcl.Register);
  RegisterUnit('umi_ui_dmxscroller_form_lcl_ds', 
    @umi_ui_dmxscroller_form_lcl_ds.Register);
end;

initialization
  RegisterPackage('mi.ui.lcl.form', @Register);
end.
