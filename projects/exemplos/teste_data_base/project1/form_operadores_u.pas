unit form_operadores_u;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLProc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls, DBGrids, DBCtrls
  ,unit_formdock
  ,operadores_u, uMi_ui_scrollbox_lcl
  ;

type

  { Tform_operadores }

  Tform_operadores = class(Tformdock)
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;

    procedure FormCreate(Sender: TObject);
  private
    { private declarations }

  public
    { public declarations }
    operadores : Toperadores;
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
  if operadores.SQLQuery1.Active
  then begin
         DBGrid1.DataSource := operadores.DataSource1;
         DBNavigator1.DataSource := operadores.DataSource1;

         Mi_ScrollBox_LCL1.UiDmxScroller := operadores.DmxScroller_Form1;
         operadores.DmxScroller_Form1.Active:=true;
       end;
end;

//procedure Tform_operadores.Button1Click(Sender: TObject);
//begin
//  operadores.Action_novoExecute(self);
//end;
//
end.

