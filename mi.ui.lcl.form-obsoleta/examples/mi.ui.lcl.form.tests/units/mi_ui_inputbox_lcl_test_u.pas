unit MI_UI_InputBox_lcl_test_u;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls
  , fpjson
  , mi.rtl.all
  ,MI_UI_InputBox_lcl_u

  ,uMi_ui_Dmxscroller_form_lcl
  , mi_rtl_ui_Dmxscroller;

type

  { TMI_UI_InputBox_lcl_test }

  TMI_UI_InputBox_lcl_test = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DmxScroller_Form_Lcl1CloseQuery(aDmxScroller: TUiDmxScroller;  var CanClose: boolean);
    procedure DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
    procedure DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1ExitField(aField: pDmxFieldRec);
  private

  public

  end;

var
  MI_UI_InputBox_lcl_test: TMI_UI_InputBox_lcl_test;

implementation

{$R *.lfm}

{ TMI_UI_InputBox_lcl_test }

procedure TMI_UI_InputBox_lcl_test.Button1Click(Sender: TObject);
var
  J: TJSONObject  ;
  template:AnsiString;
begin
  //with TMi_rtl,MI_UI_InputBox do
  //begin
  //  template := ' ~Nome:    ~\ssssssssssssssss '+^M+
  //              ' ~Endereço:~\ssssssssssssssss'+^M+
  //              ' ~Cep:     ~\##.###-###'+^M+
  //              ' ~Nome:    ~\ssssssssssssssssssssssssssss'+^M+
  //              ' ~Endereço:~\sssssssssssssssssssssssssssssssssssss'+^M+
  //              ' ~Cep:     ~\##.###-###'+^M
  //              ;
  //
  //  if InputBox('Teste input box',template
  //              ,  DmxScroller_Form_Lcl1CloseQuery
  //              ,''
  //              ,DmxScroller_Form_Lcl1Enter
  //              ,DmxScroller_Form_Lcl1Exit
  //              ,DmxScroller_Form_Lcl1EnterField
  //              ,DmxScroller_Form_Lcl1ExitField,[],J) = mrok
  //  then begin
  //
  //         J.free;
  //       end;
  //end;
end;

procedure TMI_UI_InputBox_lcl_test.Button2Click(Sender: TObject);
begin
  TMI_UI_InputBox_lcl.testInputBox4;
end;

procedure TMI_UI_InputBox_lcl_test.DmxScroller_Form_Lcl1CloseQuery(  aDmxScroller: TUiDmxScroller; var CanClose: boolean);
begin
  if Assigned(aDmxScroller.CurrentField)
  Then TMi_rtl.ShowMessage('DmxScroller_Form_Lcl1CloseQuery: '+aDmxScroller.CurrentField.FieldName);
end;

procedure TMI_UI_InputBox_lcl_test.DmxScroller_Form_Lcl1Enter(  aDmxScroller: TUiDmxScroller);
begin
  if Assigned(aDmxScroller.CurrentField)
  Then TMi_rtl.ShowMessage('DmxScroller_Form_Lcl1Enter: '+aDmxScroller.CurrentField.FieldName);
end;

procedure TMI_UI_InputBox_lcl_test.DmxScroller_Form_Lcl1EnterField(  aField: pDmxFieldRec);
begin
  TMi_rtl.ShowMessage('DmxScroller_Form_Lcl1EnterField: '+aField.FieldName);
end;

procedure TMI_UI_InputBox_lcl_test.DmxScroller_Form_Lcl1Exit(  aDmxScroller: TUiDmxScroller);
begin
  if Assigned(aDmxScroller.CurrentField)
  Then TMi_rtl.ShowMessage('DmxScroller_Form_Lcl1Exit: '+aDmxScroller.CurrentField.FieldName);
end;

procedure TMI_UI_InputBox_lcl_test.DmxScroller_Form_Lcl1ExitField( aField: pDmxFieldRec);
begin
  TMi_rtl.ShowMessage('DmxScroller_Form_Lcl1ExitField: '+aField.FieldName);
end;

end.

