unit uform_operadores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, DB, LCLProc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DBCtrls, DBGrids
  ,uFormDock
  ,uoperadores, umi_lcl_scrollbox, uMi_lcl_ui_Form
  ;


type

  { Tform_operadores }

  Tform_operadores = class(TFormDock)
      Button_Pesquisar: TButton;
      DBGrid1: TDBGrid;
      DBNavigator1: TDBNavigator;
      Edit_Pesquisar: TEdit;
      Label1: TLabel;
      Label_title: TLabel;
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

    private var operadores : Toperadores;

  end;

var
  form_operadores: Tform_operadores;


implementation


{$R *.lfm}



{ Tform_operadores }

procedure Tform_operadores.FormCreate(Sender: TObject);
begin
  inherited;
  operadores := Toperadores.Create(self);
  operadores.active:=true;

  Mi_lcl_ui_Form1.DmxScroller_Form := operadores.DmxScroller_Form1;
  Mi_lcl_ui_Form1.ParentLCL := Mi_LCL_Scrollbox1;
  Mi_lcl_ui_Form1.Active:=true;
  if operadores.DmxScroller_Form1.Active
  then begin
         DBGrid1.DataSource := operadores.Mi_SQLQuery1.DataSource;
         DBNavigator1.DataSource := DBGrid1.DataSource;
        operadores.Refresh;
       end;
  Label_title.Caption:= operadores.DmxScroller_Form1.Alias;
  self.Caption := Label_title.Caption;
end;

procedure Tform_operadores.Button_PesquisarClick(Sender: TObject);
begin
  operadores.Locate(Edit_Pesquisar.Text);
end;

procedure Tform_operadores.Edit_PesquisarKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Button_PesquisarClick(Sender);
end;



procedure Tform_operadores.FormDestroy(Sender: TObject);
begin
  operadores.active:=false;
end;




end.

