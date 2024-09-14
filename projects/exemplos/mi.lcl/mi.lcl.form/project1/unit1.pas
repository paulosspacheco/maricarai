unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList,
  mi_rtl_ui_dmxscroller_form, umi_lcl_ui_ds_form, umi_lcl_scrollbox;

type

  { TForm1 }

  TForm1 = class(TForm)
    ActionList1: TActionList;
    Action_TestJson: TAction;
    CmCancel: TAction;
    CmDeleteRecord: TAction;
    CmGoBof: TAction;
    CmGoEof: TAction;
    CmLocate: TAction;
    CmNewRecord: TAction;
    CmNextRecord: TAction;
    CmPrevRecord: TAction;
    CmRefresh: TAction;
    CmUpdateRecord: TAction;
    Cm_Pesquisa_em_outra_tabela: TAction;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    DmxScroller_Form1: TDmxScroller_Form;
    Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
    procedure CmCancelExecute(Sender: TObject);
    procedure CmDeleteRecordExecute(Sender: TObject);
    procedure CmGoBofExecute(Sender: TObject);
    procedure CmGoEofExecute(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmNextRecordExecute(Sender: TObject);
    procedure CmPrevRecordExecute(Sender: TObject);
    procedure CmRefreshExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure Cm_Pesquisa_em_outra_tabelaExecute(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.CmNewRecordExecute(Sender: TObject);
begin

end;

procedure TForm1.CmNextRecordExecute(Sender: TObject);
begin

end;

procedure TForm1.CmPrevRecordExecute(Sender: TObject);
begin

end;

procedure TForm1.CmRefreshExecute(Sender: TObject);
begin

end;

procedure TForm1.CmUpdateRecordExecute(Sender: TObject);
begin

end;

procedure TForm1.Cm_Pesquisa_em_outra_tabelaExecute(Sender: TObject);
begin

end;

procedure TForm1.CmLocateExecute(Sender: TObject);
begin

end;

procedure TForm1.CmDeleteRecordExecute(Sender: TObject);
begin

end;

procedure TForm1.CmCancelExecute(Sender: TObject);
begin

end;

procedure TForm1.CmGoBofExecute(Sender: TObject);
begin

end;

procedure TForm1.CmGoEofExecute(Sender: TObject);
begin

end;

end.

