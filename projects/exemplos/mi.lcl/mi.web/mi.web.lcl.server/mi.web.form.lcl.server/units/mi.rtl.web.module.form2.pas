unit mi.rtl.web.module.form2;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  DBCtrls, Menus, StdCtrls, ActnList, umi_lcl_scrollbox,
  umi_lcl_ui_ds_form,mi_rtl_ui_dmxscroller_form,
  mi.rtl.web.module,Mi.Web.Create.MiEditForm.html;

type
  { Tmi_rtl_web_module_form2 }
  Tmi_rtl_web_module_form2 = class(TForm)
      Button1: TButton;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
    Mi_web_js_Form1: TMi_web_js_Form;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);

    procedure FormCreate(Sender: TObject);

    //private Mi_lcl_ui_ds_Form1 :TMi_lcl_ui_ds_Form;
    public mi_rtl_web_module: Tmi_rtl_web_module;

    {O método **@name** é usuado para criar formulários baseados em templates
     da aplicação destino.
    }
    private procedure BuildCustomerFormFromTemplate();
  end;


implementation

{$R *.lfm}

procedure Tmi_rtl_web_module_form2.BuildCustomerFormFromTemplate();
begin
  Mi_web_js_Form1.DataModule := mi_rtl_web_module;
  Mi_web_js_Form1.CreateForm();
 end;


procedure Tmi_rtl_web_module_form2.Button1Click(Sender: TObject);
begin
  BuildCustomerFormFromTemplate();
end;


{ Tmi_rtl_web_modulMi_lcl_ui_ds_Form1e_form }
{:A classe Mi_lcl_ui_ds_Form1 foi criada em tempo de designer }
procedure Tmi_rtl_web_module_form2.FormCreate(Sender: TObject);
  Var
    tmp:TMi_lcl_ui_ds_Form; //gastei muito tempo e não achei porque o formulário se torna nil após Mi_lcl_ui_ds_Form1.Active:=true
begin
  mi_rtl_web_module := Tmi_rtl_web_module.Create(self);
  Mi_lcl_ui_ds_Form1.Mi_ActionList := mi_rtl_web_module.ActionList1;
  Mi_lcl_ui_ds_Form1.DmxScroller_Form := Mi_rtl_web_module.DmxScroller_Form1;

  //A linha abaixo só é necessária quando controle é inserido em tempo de designer.
  //Se não tiver o tmp o componente Mi_lcl_ui_ds_Form1 fica nil após ativalo.
  tmp:=Mi_lcl_ui_ds_Form1;
  Mi_lcl_ui_ds_Form1.Active:=true;

  if not Assigned(Mi_lcl_ui_ds_Form1)
  Then Mi_lcl_ui_ds_Form1 := tmp;

  DBGrid1.DataSource :=  Mi_lcl_ui_ds_Form1.DmxScroller_Form.DataSource;
  DBNavigator1.DataSource := DBGrid1.DataSource;
end;

{:A classe Mi_lcl_ui_ds_Form1 foi criada em tempo de execução}
//procedure Tmi_rtl_web_module_form2.FormCreate(Sender: TObject);
//begin
//  mi_rtl_web_module := Tmi_rtl_web_module.Create(self);
//  Mi_lcl_ui_ds_Form1 := TMi_lcl_ui_ds_Form.Create(self);
//  with Mi_lcl_ui_ds_Form1 do
//  begin
//    DmxScroller_Form := mi_rtl_web_module.DmxScroller_Form1;
//    ParentLCL        := Mi_LCL_Scrollbox1;
//    Active           := true;
//
//    DBGrid1.DataSource      := DmxScroller_Form.DataSource;
//    DBNavigator1.DataSource := DBGrid1.DataSource;
//    //with DmxScroller_Form do
//    //DmxScroller_Form.RewriteFileClients(TEnClientsApplication.en_app_javascript);
//  end;
////  BuildCustomerFormFromTemplate();
//end;




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

