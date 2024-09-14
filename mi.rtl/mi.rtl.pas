{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi.rtl;

{$warn 5023 off : no warning about unused units}
interface

uses
  mi_rtl_tarefas_a_fazer, mi.rtl.treenode, Mi_SQLQuery, fpTemplate, 
  mi.rtl.miStringlist, mi.rtl.MiStringlistbase, mi.rtl.libBinRes, 
  mi.rtl.ApplicationAbstract, mi.rtl.Class_Of_Char, mi.rtl.Types, 
  mi.rtl.Consts, mi.rtl.Consts.transaction, mi.rtl.files, 
  mi.rtl.Consts.StrError, mi.rtl.objects.types, mi.rtl.Objects.Consts, 
  mi.rtl.Objects.Consts.Logs, mi.rtl.Objects.Consts.Mi_MsgBox, 
  mi.rtl.Objects.Consts.ProgressDlg_If, mi.rtl.Objects.Methods, 
  mi.rtl.objects.Methods.dates, mi.rtl.objects.methods.html.tags, 
  mi.rtl.Objects.Methods.Exception, mi.rtl.Objects.Methods.Paramexecucao, 
  mi.rtl.Objects.Methods.Paramexecucao.Application, 
  mi.rtl.Objects.Methods.StreamBase, mi.rtl.Objects.Methods.StreamBase.Stream, 
  mi.rtl.Objects.Methods.StreamBase.Stream.FileStream, 
  mi.rtl.Objects.Methods.StreamBase.Stream.MemoryStream, 
  mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory, 
  mi.rtl.Objects.Methods.Collection, 
  mi.rtl.Objects.Methods.Collection.FilesStreams, 
  mi.rtl.Objects.Methods.System, 
  mi.rtl.Objects.Methods.Collection.SortedCollection, 
  mi.rtl.Objects.Methods.Collection.SortedCollection.StringCollection, 
  mi.rtl.Objects.Methods.Collection.Sortedcollection.Stringcollection.
  Collectionstring, 
  mi.rtl.Objects.Methods.Collection.SortedCollection.StrCollection, 
  mi.rtl.Objects.Methods.Db.Tb_Access, mi.rtl.Objects.Methods.Db.Tb__Access, 
  mi.rtl.Objects.Methods.Db.Tb___Access, mi.rtl.objects.methods.pageproducer, 
  mi.rtl.Objectss, mi_rtl_ui_types, mi_rtl_ui_consts, mi_rtl_ui_methods, 
  mi_rtl_ui_Dmxscroller, mi_rtl_ui_dmxscroller_form, 
  mi_rtl_ui_DmxScroller_Buttons, mi.rtl.ui.dmxscroller.inputbox, 
  mi_rtl_ui_custom_application, mi.rtl.all, uMiConnectionsDb, uMiDataModule, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('mi.rtl.treenode', @mi.rtl.treenode.Register);
  RegisterUnit('Mi_SQLQuery', @Mi_SQLQuery.Register);
  RegisterUnit('mi.rtl.Objects.Consts.Mi_MsgBox', 
    @mi.rtl.Objects.Consts.Mi_MsgBox.Register);
  RegisterUnit('mi.rtl.objects.methods.pageproducer', 
    @mi.rtl.objects.methods.pageproducer.Register);
  RegisterUnit('mi_rtl_ui_dmxscroller_form', 
    @mi_rtl_ui_dmxscroller_form.Register);
  RegisterUnit('mi.rtl.ui.dmxscroller.inputbox', 
    @mi.rtl.ui.dmxscroller.inputbox.Register);
  RegisterUnit('mi.rtl.all', @mi.rtl.all.Register);
end;

initialization
  RegisterPackage('mi.rtl', @Register);
end.
