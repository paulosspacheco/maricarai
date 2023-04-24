{
   File generated automatically by Lazarus Package Manager

   fpmake.pp for mi.rtl 0.7.1.621

   This file was generated on 31/03/2023
}

{$ifndef ALLPACKAGES} 
{$mode objfpc}{$H+}
program fpmake;

uses fpmkunit;
{$endif ALLPACKAGES}

procedure add_mi.rtl(const ADirectory: string);

var
  P : TPackage;
  T : TTarget;
  D : TDependency;

begin
  with Installer do
    begin
    P:=AddPackage('mi.rtl');
    P.Version:='0.5.0-687';

    P.Directory:=ADirectory;

    P.Author:='Paulo Sérgio da Silva Pacheco';
    P.Description:='O  pacote mi.rtl encapsula as units do FreePascal e Lazarus.'#10'Implementa a classe TObjectss que por sua vez encapsula as classes bases do turbo vision versão Lazarus.';

    P.Flags.Add('LazarusDsgnPkg');

    D := P.Dependencies.Add('lazutils');
    P.Options.Add('-MDelphi');
    P.Options.Add('-Scaghi');
    P.Options.Add('-CirotR');
    P.Options.Add('-O1');
    P.Options.Add('-gw3');
    P.Options.Add('-gl');
    P.Options.Add('-l');
    P.Options.Add('-vewnhibq');
    P.IncludePath.Add('../../lib/x86_64-linux');
    P.IncludePath.Add('units/include/linux');
    P.IncludePath.Add('units/include/windows');
    P.IncludePath.Add('units');
    P.UnitPath.Add('units');
    P.UnitPath.Add('.');
    T:=P.Targets.AddUnit('mi.rtl.pas');
    t.Dependencies.AddUnit('mi.rtl');
    t.Dependencies.AddUnit('mi.rtl.class_of_char');
    t.Dependencies.AddUnit('mi.rtl.applicationabstract');
    t.Dependencies.AddUnit('mi.rtl.types');
    t.Dependencies.AddUnit('mi.rtl.consts');
    t.Dependencies.AddUnit('mi.rtl.files');
    t.Dependencies.AddUnit('mi.rtl.consts.strerror');
    t.Dependencies.AddUnit('mi.rtl.consts.stringlistbase');
    t.Dependencies.AddUnit('mi.rtl.consts.stringlist');
    t.Dependencies.AddUnit('mi.rtl.objects.types');
    t.Dependencies.AddUnit('mi.rtl.objects.consts');
    t.Dependencies.AddUnit('mi.rtl.objects.consts.logs');
    t.Dependencies.AddUnit('mi.rtl.objects.consts.mi_msgbox');
    t.Dependencies.AddUnit('mi.rtl.objects.consts.progressdlg_if');
    t.Dependencies.AddUnit('mi.rtl.objects.methods');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.dates');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.exception');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.paramexecucao');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.paramexecucao.application');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream.filestream');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream.memorystream');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.streambase.stream.memorystream.buffermemory');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.filesstreams');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.system');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection.stringcollection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection.stringcollection.collectionstring');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.collection.sortedcollection.strcollection');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.db.tb_access');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.db.tb__access');
    t.Dependencies.AddUnit('mi.rtl.objects.methods.db.tb___access');
    t.Dependencies.AddUnit('mi.rtl.objectss');

    T:=P.Targets.AddUnit('mi.rtl.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.class_of_char.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.applicationabstract.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.types.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.consts.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.files.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.consts.strerror.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.consts.stringlistbase.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.consts.stringlist.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.types.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.logs.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.mi_msgbox.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.consts.progressdlg_if.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.dates.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.exception.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.paramexecucao.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.paramexecucao.application.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.filestream.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.memorystream.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.streambase.stream.memorystream.buffermemory.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.filesstreams.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.system.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.stringcollection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.stringcollection.collectionstring.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.collection.sortedcollection.strcollection.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.db.tb_access.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.db.tb__access.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objects.methods.db.tb___access.pas');
    T:=P.Targets.AddUnit('units/mi.rtl.objectss.pas');

    // copy the compiled file, so the IDE knows how the package was compiled
    P.Sources.AddSrc('mi.rtl.compiled');
    P.InstallFiles.Add('mi.rtl.compiled',AllOSes,'$(unitinstalldir)');

    end;
end;

{$ifndef ALLPACKAGES}
begin
  add_mi.rtl('');
  Installer.Run;
end.
{$endif ALLPACKAGES}
