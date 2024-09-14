{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi_lcl_form;

{$warn 5023 off : no warning about unused units}
interface

uses
  ubitbtn_mi_lcl, uButton_mi_lcl, uCheckbox_mi_lcl, uRadiogroup_mi_lcl, 
  uCombobox_mi_lcl, uDbcheckbox_mi_lcl, uDbcombobox_mi_lcl, uDbedit_mi_lcl, 
  uDblookupcombobox_mi_lcl, uDbradiogroup_mi_lcl, uLabel_mi_lcl, 
  uMaskedit_mi_lcl, uMi_lcl_ui_Form, uMi_lcl_ui_Form_attributes, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('uMi_lcl_ui_Form', @uMi_lcl_ui_Form.Register);
end;

initialization
  RegisterPackage('mi_lcl_form', @Register);
end.
