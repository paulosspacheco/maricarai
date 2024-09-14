unit u__form_xtable__;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, LCLProc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, DBGrids
  ,uFormDock
  ,u__dm_xtable__, umi_lcl_scrollbox, uMi_lcl_ui_Form
  ;


type

  { T__form_xtable__ }

  T__form_xtable__ = class(TFormDock)
      Button_Pesquisar: TButton;
      DBGrid1: TDBGrid;
      DBNavigator1: TDBNavigator;
      Edit_Pesquisar: TEdit;
      Label1: TLabel;

      Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
      Mi_lcl_ui_Form1: TMi_lcl_ui_Form;
      Panel2: TPanel;
      procedure Button_PesquisarClick(Sender: TObject);
      procedure Edit_PesquisarKeyDown(Sender: TObject; var Key: Word;
        Shift: TShiftState);
      procedure FormCreate(Sender: TObject);
      procedure FormDestroy(Sender: TObject);

    private
      { private declarations }

    private var __dm_xtable__ : T__dm_xtable__;

  end;

var
  __form_xtable__: T__form_xtable__;


implementation


{$R *.lfm}



{ T__form_xtable__ }

procedure T__form_xtable__.FormCreate(Sender: TObject);
begin
  inherited;
  __dm_xtable__ := T__dm_xtable__.Create(self);
  __dm_xtable__.active:=true;

  Mi_lcl_ui_Form1.DmxScroller_Form := __dm_xtable__.DmxScroller_Form1;
  Mi_lcl_ui_Form1.ParentLCL := Mi_LCL_Scrollbox1;
  Mi_lcl_ui_Form1.Active:=true;
  if __dm_xtable__.DmxScroller_Form1.Active
  then begin
         DBGrid1.DataSource := __dm_xtable__.Mi_SQLQuery1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;
        __dm_xtable__.Refresh;
       end;
  Label_title.Caption:= __dm_xtable__.DmxScroller_Form1.Alias;
  self.Caption := Label_title.Caption;
end;

procedure T__form_xtable__.Button_PesquisarClick(Sender: TObject);
begin
  __dm_xtable__.Locate(Edit_Pesquisar.Text);
end;

procedure T__form_xtable__.Edit_PesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Button_PesquisarClick(Sender);
end;



procedure T__form_xtable__.FormDestroy(Sender: TObject);
begin
  __dm_xtable__.active:=false;
end;




end.

