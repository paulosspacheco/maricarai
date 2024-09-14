unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, Forms, Controls, Graphics, Dialogs, StdCtrls, DBGrids,
  MaskEdit, ExtCtrls, SpinEx, Unit2, uMi_lcl_ui_Form, umi_lcl_scrollbox,
  mi_rtl_ui_dmxscroller_form;

type

  { TForm1 }

  TForm1 = class(TForm)
    Label1: TLabel;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_Form1: TMi_lcl_ui_Form;
    Panel1: TPanel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

   public DataModule1 : TDataModule1;

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
  //var
  //  wMi_lcl_ui_Form1 : tMi_lcl_ui_Form; //Preciso disso porque o compilador tem um bug.
begin
  //wMi_lcl_ui_Form1 := Mi_lcl_ui_Form1;
  //wMi_lcl_ui_Form1.DmxScroller_Form := Unit2.DataModule1.DmxScroller_Form1;
  //Mi_lcl_ui_Form1 := wMi_lcl_ui_Form1;
  //
  //if not Assigned(Mi_lcl_ui_Form1.Mi_ActionList)
  //then Mi_lcl_ui_Form1.Mi_ActionList := Unit2.DataModule1.ActionList1;
  //

  Mi_lcl_ui_Form1.Active:=true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage('Ok Pressionado');
end;

end.

