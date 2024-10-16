unit mi.rtl.web.module.form;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  DBCtrls, Menus, StdCtrls, ActnList, umi_lcl_scrollbox,
  umi_lcl_ui_ds_form,mi_rtl_ui_dmxscroller_form,
  mi.rtl.web.module;

type


  { Tmi_rtl_web_module_form }

  Tmi_rtl_web_module_form = class(TForm)
      Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Panel1: TPanel;

    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

    public mi_rtl_web_module: Tmi_rtl_web_module;
  end;


implementation

{$R *.lfm}



{ Tmi_rtl_web_module_form }
{:A classe Mi_lcl_ui_ds_Form1 foi criada em tempo de designer }
//procedure Tmi_rtl_web_module_form.FormCreate(Sender: TObject);
//  Var
//    tmp:TMi_lcl_ui_ds_Form;
//begin
//  Mi_rtl_WebModule := TMi_rtl_WebModule.Create(self);
//  Mi_lcl_ui_ds_Form1.Mi_ActionList := Mi_rtl_WebModule.ActionList1;
//
//  //A linha abaixo só é necessária quando controle é inserido em tempo de designer.
//  //Se não tiver o tmp o componente Mi_lcl_ui_ds_Form1 fica nil após ativalo.
//  tmp:=Mi_lcl_ui_ds_Form1;
//  Mi_lcl_ui_ds_Form1.Active:=true;
//  Mi_lcl_ui_ds_Form1 := tmp;
//
//  DBGrid1.DataSource :=  Mi_lcl_ui_ds_Form1.DmxScroller_Form.DataSource;
//  DBNavigator1.DataSource := DBGrid1.DataSource;
//end;

{:A classe Mi_lcl_ui_ds_Form1 foi criada em tempo de execução}
procedure Tmi_rtl_web_module_form.FormCreate(Sender: TObject);
begin
  mi_rtl_web_module := Tmi_rtl_web_module.Create(self);
  with TMi_lcl_ui_ds_Form.Create(self) do
  begin
    DmxScroller_Form := mi_rtl_web_module.DmxScroller_Form1;
    ParentLCL        := Mi_LCL_Scrollbox1;
    Active           := true;

    DBGrid1.DataSource      := DmxScroller_Form.DataSource;
    DBNavigator1.DataSource := DBGrid1.DataSource;

  end;
end;

procedure Tmi_rtl_web_module_form.Button1Click(Sender: TObject);
begin

end;




//constructor TForm_mi_rtl_web_module.Create(TheOwner: TComponent);
//begin
//  Mi_lcl_ui_ds_Form1:= TMi_lcl_ui_ds_Form.Create(self);
//  inherited Create(TheOwner);
//
//end;


//initialization
//  mi_rtl_web_module := Tmi_rtl_web_module.Create(nil);

//finalization;
//  FreeAndNil(mi_rtl_web_module);
end.

