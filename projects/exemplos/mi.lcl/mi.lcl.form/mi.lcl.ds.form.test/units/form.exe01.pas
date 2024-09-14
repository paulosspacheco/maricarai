unit form.Exe01;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, DBCtrls, DBGrids,
  ExtCtrls, ActnList, ComCtrls, Data.Module.Exemplo, form.exe01.frame,
  umi_lcl_scrollbox, mi.rtl.all, umi_lcl_ui_ds_form ;

type

  { Tform_Exe01 = Exemplo 01 }
  Tform_Exe01 = class(TForm)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    private Form_exe01_frame :TForm_exe01_frame;

  end;


Procedure form_Exe01_ShowModal;

implementation

procedure form_Exe01_ShowModal;
  var
    form_Exe01: Tform_Exe01;
begin
  Application.CreateForm(Tform_Exe01, form_Exe01);
  form_Exe01.ShowModal;
  FreeAndNil(form_Exe01);
end;


{$R *.lfm}

{ Tform_Exe01 }

procedure Tform_Exe01.FormCreate(Sender: TObject);
  var  tmp: TMi_lcl_ui_ds_Form;
begin
  Form_exe01_frame := TForm_exe01_frame.Create(nil);
  Form_exe01_frame.Align  := alClient;
  Form_exe01_frame.Parent := Panel2;
  AutoSize:=true;

  tmp := Form_exe01_frame.Mi_lcl_ui_ds_Form1;
  Form_exe01_frame.Mi_lcl_ui_ds_Form1.Active:=true;

  //A linha abaixo necessário pq o compilador seta para nil o compoente Mi_lcl_ui_ds_Form1 apos ativa-lo.
  //Obs: Quando o componente Mi_lcl_ui_ds_Form1 é criado em tempo de execução isso não ocorre.
  Form_exe01_frame.Mi_lcl_ui_ds_Form1 := tmp;

  with Form_exe01_frame.Mi_lcl_ui_ds_Form1.DmxScroller_Form do
  begin
    if Assigned(DataSource)
    Then DBGrid1.DataSource := DataSource;
    DBNavigator1.DataSource := DataSource;
  end;
end;

procedure Tform_Exe01.FormDestroy(Sender: TObject);
begin
  Freeandnil(Form_exe01_frame);
end;

{ Tform_Exe01 }

//constructor Tform_Exe01.Create(TheOwner: TComponent);
//  //var
//  //  tmp :TMi_lcl_ui_ds_Form;
//begin
//  inherited Create(TheOwner);
//  //tmp := Mi_lcl_ui_ds_Form1;
//  //if not Assigned(Mi_lcl_ui_ds_Form1)
//  //Then Mi_lcl_ui_ds_Form1 := tmp;
//
//end;
{:A classe Mi_lcl_ui_ds_Form1 foi criada em tempo de designer }

//procedure Tform_Exe01.FormCreate(Sender: TObject);
//  Var
//    tmp:TMi_lcl_ui_ds_Form;
//begin
//  tmp:=Mi_lcl_ui_ds_Form1;  Mi_lcl_ui_ds_Form1.Active:=true;  Mi_lcl_ui_ds_Form1 := tmp;
//  DBGrid1.DataSource :=  Mi_lcl_ui_ds_Form1.DmxScroller_Form.DataSource;
//  DBNavigator1.DataSource := DBGrid1.DataSource;
//end;

{:A classe Mi_lcl_ui_ds_Form1 foi criada em tempo de execução}
//procedure Tform_Exe01.FormCreate(Sender: TObject);
//begin
//  DataModule_Exemplo:= TDataModule_Exemplo.Create(self);
//
//  Mi_lcl_ui_ds_Form1 := TMi_lcl_ui_ds_Form.Create(self);
//  Mi_lcl_ui_ds_Form1.ParentLCL:= Mi_LCL_Scrollbox1;
//  Mi_lcl_ui_ds_Form1.Mi_ActionList := DataModule_Exemplo.ActionList1;
//  Mi_lcl_ui_ds_Form1.DmxScroller_Form := DataModule_Exemplo.DmxScroller_Form1;
//  Mi_lcl_ui_ds_Form1.Active:=true;
//  DBGrid1.DataSource :=  Mi_lcl_ui_ds_Form1.DmxScroller_Form.DataSource;
//  DBNavigator1.DataSource := DBGrid1.DataSource;
//end;



//destructor Tform_Exe01.Destroy;
//begin
//  //DBGrid1.DataSource :=  nil;
//  //DBNavigator1.DataSource := nil;
//  //Mi_lcl_ui_ds_Form1.Active :=false;
//  FreeAndNil(Mi_lcl_ui_ds_Form1);
//  inherited Destroy;
//end;


end.

