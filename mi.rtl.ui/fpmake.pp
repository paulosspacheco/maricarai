{
   File generated automatically by Lazarus Package Manager

   fpmake.pp for mi.rtl.ui 0.5.0.687

   This file was generated on 31/03/2023
}

{$ifndef ALLPACKAGES} 
{$mode objfpc}{$H+}
program fpmake;

uses fpmkunit;
{$endif ALLPACKAGES}

procedure add_mi.rtl.ui(const ADirectory: string);

var
  P : TPackage;
  T : TTarget;
  D : TDependency;

begin
  with Installer do
    begin
    P:=AddPackage('mi.rtl.ui');
    P.Version:='0.5.0-687';

    P.Directory:=ADirectory;

    P.Author:='Paulo Sérgio da Silva Pacheco';
    P.Description:='Pacote Mi.rtl.ui contém o interpretador de Templates de uma linha inspirado no projeto TvDmx de Randy Back.';

    D := P.Dependencies.Add('lcl');
    D := P.Dependencies.Add('mi.rtl');
    P.Options.Add('-MDelphi');
    P.Options.Add('-Scghi');
    P.Options.Add('-CirtR');
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
    T:=P.Targets.AddUnit('mi.rtl.ui.pas');
    t.Dependencies.AddUnit('mi.rtl.ui');
    t.Dependencies.AddUnit('mi_rtl_ui_interfaces');
    t.Dependencies.AddUnit('mi_rtl_ui_custom_application');
    t.Dependencies.AddUnit('mi_rtl_ui_types');
    t.Dependencies.AddUnit('mi_rtl_ui_consts');
    t.Dependencies.AddUnit('mi_rtl_ui_methods');
    t.Dependencies.AddUnit('mi_rtl_ui_dmxscroller');
    t.Dependencies.AddUnit('mi_rtl_ui_dmxscroller_buttons');
    t.Dependencies.AddUnit('mi_rtl_ui_dmxscroller_form');

    T:=P.Targets.AddUnit('mi.rtl.ui.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_interfaces.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_custom_application.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_types.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_consts.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_methods.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_dmxscroller.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_dmxscroller_buttons.pas');
    T:=P.Targets.AddUnit('units/mi_rtl_ui_dmxscroller_form.pas');

    // copy the compiled file, so the IDE knows how the package was compiled
    P.Sources.AddSrc('mi.rtl.ui.compiled');
    P.InstallFiles.Add('mi.rtl.ui.compiled',AllOSes,'$(unitinstalldir)');

    end;
end;

{$ifndef ALLPACKAGES}
begin
  add_mi.rtl.ui('');
  Installer.Run;
end.
{$endif ALLPACKAGES}
