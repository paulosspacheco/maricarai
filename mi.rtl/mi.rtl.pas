{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi.rtl;

{$warn 5023 off : no warning about unused units}
interface

uses
  mi.rtl.libBinRes, mi.rtl.ApplicationAbstract, mi.rtl.Class_Of_Char, 
  mi.rtl.Types, mi.rtl.Consts, mi.rtl.files, mi.rtl.Consts.StrError, 
  mi.rtl.Consts.StringListBase, mi.rtl.Consts.StringList, 
  mi.rtl.objects.types, mi.rtl.Objects.Consts, mi.rtl.Objects.Consts.Logs, 
  mi.rtl.Objects.Consts.Mi_MsgBox, mi.rtl.Objects.Consts.ProgressDlg_If, 
  mi.rtl.Objects.Methods, mi.rtl.objects.Methods.dates, 
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
  mi.rtl.Objects.Methods.Db.Tb___Access, mi.rtl.Objectss, mi_rtl_ui_types, 
  mi_rtl_ui_consts, mi_rtl_ui_methods, mi_rtl_ui_DmxScroller_Buttons, 
  mi_rtl_ui_Dmxscroller, mi_rtl_ui_dmxscroller_form, 
  mi_rtl_ui_custom_application, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('mi.rtl.Objects.Consts.Mi_MsgBox', 
    @mi.rtl.Objects.Consts.Mi_MsgBox.Register);
  RegisterUnit('mi.rtl.Objects.Consts.ProgressDlg_If', 
    @mi.rtl.Objects.Consts.ProgressDlg_If.Register);
  RegisterUnit('mi_rtl_ui_dmxscroller_form', 
    @mi_rtl_ui_dmxscroller_form.Register);
end;

initialization
  RegisterPackage('mi.rtl', @Register);
end.
