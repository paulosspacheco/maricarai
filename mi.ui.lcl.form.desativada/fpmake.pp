{
   File generated automatically by Lazarus Package Manager

   fpmake.pp for mi.ui.lcl.form 0.5.0.687

   This file was generated on 03/08/2023
}

{$ifndef ALLPACKAGES} 
{$mode objfpc}{$H+}
program fpmake;

uses fpmkunit;
{$endif ALLPACKAGES}

procedure add_mi.ui.lcl.form(const ADirectory: string);

var
  P : TPackage;
  T : TTarget;
  D : TDependency;

begin
  with Installer do
    begin
    P:=AddPackage('mi.ui.lcl.form');
    P.Version:='0.5.0-687';

    P.Directory:=ADirectory;

    P.Author:='Paulo Sérgio da Silva Pacheco';
    P.Description:='O pacote Mi.ui.lcl.form implementa a versão LCL do projeto /\/ar/\caraí.';

    P.Flags.Add('LazarusDsgnPkg');

    D := P.Dependencies.Add('lcl');
    D := P.Dependencies.Add('mi.rtl');
    P.Options.Add('-MObjFPC');
    P.Options.Add('-Scghi');
    P.Options.Add('-O1');
    P.Options.Add('-g');
    P.Options.Add('-gl');
    P.Options.Add('-l');
    P.Options.Add('-vewnhibq');
    P.Options.Add('-dLCL');
    P.Options.Add('-dLCL$(LCLWidgetType)');
    P.IncludePath.Add('units');
    P.UnitPath.Add('units');
    P.UnitPath.Add('.');
    T:=P.Targets.AddUnit('mi.ui.lcl.form.pas');
    t.Dependencies.AddUnit('mi.ui.lcl.form');
    t.Dependencies.AddUnit('umi_ui_scrollbox_lcl');
    t.Dependencies.AddUnit('umi_ui_dmxscroller_form_lcl_attributes');
    t.Dependencies.AddUnit('umi_ui_bitbtn_lcl');
    t.Dependencies.AddUnit('umi_ui_button_lcl');
    t.Dependencies.AddUnit('umi_ui_checkbox_lcl');
    t.Dependencies.AddUnit('umi_ui_radiogroup_lcl');
    t.Dependencies.AddUnit('umi_ui_combobox_lcl');
    t.Dependencies.AddUnit('umi_ui_dbcheckbox_lcl');
    t.Dependencies.AddUnit('umi_ui_dbcombobox_lcl');
    t.Dependencies.AddUnit('umi_ui_dbedit_lcl');
    t.Dependencies.AddUnit('umi_ui_dblookupcombobox_lcl');
    t.Dependencies.AddUnit('umi_ui_dbradiogroup_lcl');
    t.Dependencies.AddUnit('umi_ui_label_lcl');
    t.Dependencies.AddUnit('umi_ui_maskedit_lcl');
    t.Dependencies.AddUnit('umi_ui_dmxscroller_form_lcl');
    t.Dependencies.AddUnit('umi_ui_dmxscroller_form_lcl_ds');
    t.Dependencies.AddUnit('umi_ui_inputbox_lcl');

    T:=P.Targets.AddUnit('mi.ui.lcl.form.pas');
    T:=P.Targets.AddUnit('units/umi_ui_scrollbox_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dmxscroller_form_lcl_attributes.pas');
    T:=P.Targets.AddUnit('units/umi_ui_bitbtn_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_button_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_checkbox_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_radiogroup_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_combobox_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dbcheckbox_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dbcombobox_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dbedit_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dblookupcombobox_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dbradiogroup_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_label_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_maskedit_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dmxscroller_form_lcl.pas');
    T:=P.Targets.AddUnit('units/umi_ui_dmxscroller_form_lcl_ds.pas');
    T:=P.Targets.AddUnit('units/umi_ui_inputbox_lcl.pas');

    // copy the compiled file, so the IDE knows how the package was compiled
    P.Sources.AddSrc('mi.ui.lcl.form.compiled');
    P.InstallFiles.Add('mi.ui.lcl.form.compiled',AllOSes,'$(unitinstalldir)');

    end;
end;

{$ifndef ALLPACKAGES}
begin
  add_mi.ui.lcl.form('');
  Installer.Run;
end.
{$endif ALLPACKAGES}
