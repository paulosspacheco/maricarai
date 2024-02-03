unit Unit2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, dm_unit2,
  uMi_ui_scrollbox_lcl;

type

  { TForm2 }

  TForm2 = class(TForm)
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin
//  DataModule2.DmxScroller_Form1.Par
  DataModule2..DmxScroller_Form_Lcl_DS1.ParentLCL := self.Mi_ScrollBox_LCL1;
  DataModule2.DmxScroller_Form_Lcl_DS1.Active := true;
end;

end.

