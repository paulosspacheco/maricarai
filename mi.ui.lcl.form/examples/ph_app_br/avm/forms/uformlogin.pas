unit uFormLogin;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, udm_connections,
  umi_ui_dmxscroller_form_lcl_ds, uMi_ui_scrollbox_lcl;

type

  { TFormLogin }

  TFormLogin = class(TForm)
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  FormLogin: TFormLogin;

implementation

{$R *.lfm}

{ TFormLogin }

procedure TFormLogin.FormCreate(Sender: TObject);
begin
  //DM_Connections.DmxScroller_Form1..parent Mi_ScrollBox_LCL1.parent
  //DM_Connections.DmxScroller_Form1.Active:= true;

end;

end.

