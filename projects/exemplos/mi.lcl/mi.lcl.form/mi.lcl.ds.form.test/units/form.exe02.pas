unit form.Exe02;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, DBCtrls,
  DBGrids, umi_lcl_ui_ds_form, umi_lcl_scrollbox, Data.Module.Exemplo;

type

  { Tform_Exe02 }
  TForm_Exe02 = class(TForm)
      DBGrid1: TDBGrid;
      DBNavigator1: TDBNavigator;
      Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);

    private DataModule_Exemplo:TDataModule_Exemplo;
    private Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
  end;

implementation

{$R *.lfm}

{ Tform_Exe02 }

procedure Tform_Exe02.FormCreate(Sender: TObject);
begin
  DataModule_Exemplo                  := TDataModule_Exemplo.Create(self);
  Mi_lcl_ui_ds_Form1                  := TMi_lcl_ui_ds_Form.Create(DataModule_Exemplo);
  Mi_lcl_ui_ds_Form1.DmxScroller_Form := DataModule_Exemplo.DmxScroller_Form1;
  Mi_lcl_ui_ds_Form1.ParentLCL        := Mi_LCL_Scrollbox1;
  Mi_lcl_ui_ds_Form1.Active           := true;
  with Mi_lcl_ui_ds_Form1.DmxScroller_Form do
  begin
    if Assigned(DataSource)
    Then DBGrid1.DataSource := DataSource;
    DBNavigator1.DataSource := DataSource;
  end;
end;


end.

