unit mi.rtl.web.module.form;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBGrids,
  StdCtrls, umi_lcl_ui_ds_form, umi_lcl_scrollbox, Data.Module.Client.Rest;

type

  { Tmi_rtl_web_module_form }

  Tmi_rtl_web_module_form = class(TForm)
    DBGrid1: TDBGrid;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
  private

  public
    //Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
    data_module_client_rest: Tdata_module_client_rest;
  end;

//var
//  mi_rtl_web_module_form: Tmi_rtl_web_module_form;

implementation

{$R *.lfm}

{ Tmi_rtl_web_module_form }

procedure Tmi_rtl_web_module_form.FormCreate(Sender: TObject);
begin
  //Mi_lcl_ui_ds_Form1 := TMi_lcl_ui_ds_Form.Create(self);

  data_module_client_rest := Tdata_module_client_rest.Create(self);
  with TMi_lcl_ui_ds_Form.Create(self) do
  begin
    DmxScroller_Form := data_module_client_rest.DmxScroller_Form_Rest_Client1;
    ParentLCL := Mi_LCL_Scrollbox1;
    Active :=true;
    DBGrid1.DataSource        :=  DmxScroller_Form.DataSource;
    //DBNavigator1.DataSource   := DBGrid1.DataSource;
  end;

end;


end.

