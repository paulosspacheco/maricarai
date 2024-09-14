{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi.lcl.form;

{$warn 5023 off : no warning about unused units}
interface

uses
  umi_lcl_scrollbox, uLabel_mi_lcl, ubitbtn_mi_lcl, uMaskedit_mi_lcl, 
  uButton_mi_lcl, uCheckbox_mi_lcl, uRadiogroup_mi_lcl, uCombobox_mi_lcl, 
  uDbcheckbox_mi_lcl, uDbcombobox_mi_lcl, uDbedit_mi_lcl, 
  uDblookupcombobox_mi_lcl, uDbradiogroup_mi_lcl, uMi_lcl_ui_Form_attributes, 
  umi_lcl_ui_form, umi_lcl_ui_ds_form, umi_lcl_msgbox, uMi_lcl_inputbox, 
  mi.lcl.application, Mi.Template.Highlighter, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('umi_lcl_scrollbox', @umi_lcl_scrollbox.Register);
  RegisterUnit('umi_lcl_ui_form', @umi_lcl_ui_form.Register);
  RegisterUnit('umi_lcl_ui_ds_form', @umi_lcl_ui_ds_form.Register);
  RegisterUnit('Mi.Template.Highlighter', @Mi.Template.Highlighter.Register);
end;

initialization
  RegisterPackage('mi.lcl.form', @Register);
end.
