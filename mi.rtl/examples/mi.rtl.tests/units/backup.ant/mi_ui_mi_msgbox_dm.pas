{
  object MI_MsgBox1: TMI_MsgBox
    onMessageBox_03 = MI_MsgBox1MessageBox_03
    onMessageBox_04 = MI_MsgBox1MessageBox_04
    onMessageBox_05 = MI_MsgBox1MessageBox_05
    onMessageBox = MI_MsgBox1MessageBox
    onMessageBox_ListBoxRec_PSItem = MI_MsgBox1MessageBox_ListBoxRec_PSItem
    onInputValue = MI_MsgBox1InputValue
    onInputBox = MI_MsgBox1InputBox
    onInputPassword = MI_MsgBox1InputPassword
    Left = 56
    Top = 24
  end

}

unit mi_ui_mi_msgbox_dm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils
  ,Dialogs
  ,Graphics
  ,StdCtrls
  ,System.UITypes
  ,mi.rtl.Objects.Methods
  ,mi.rtl.objects.consts.mi_msgbox;

type
  { TMi_ui_mi_msgBox }
  {: TMi_ui_mi_msgBox

     - EXEMPLO

       ```pascal

           Var
             S : String[10] = '';
           begin
              if MI_MsgBox.InputBox('InputBox Test','Gual a sua indade? ',s,'ssssssssss') = Mrok
              then ShowMessage('Sua idade é: 's);

       ```

  }
  TMi_ui_mi_msgBox = class(TDataModule)


    function MI_MsgBox1InputBox(const aTitle,
                                       ALabel: AnsiString;
                                var Buff;
                                Template: AnsiString): TModalResult;
    function MI_MsgBox1InputPassword(const aTitle: AnsiString;
                                     var aPassword: AnsiString): TModalResult;

    function MI_MsgBox1InputValue(const aTitle, aLabel: AnsiString;
                                  var aValue: Variant): TModalResult;

    function MI_MsgBox1MessageBox(const aMsg: AnsiString): TModalResult;

    protected function MI_MsgBox1MessageBox_03(const aMsg: AnsiString;DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TModalResult;

    function MI_MsgBox1MessageBox_04(aMsg: AnsiString;
                                     DlgType: TMsgDlgType;
                                     Buttons: TMsgDlgButtons;
                                     ButtonDefault: TMsgDlgBtn): TModalResult;

    function MI_MsgBox1MessageBox_04_PSItem(aPSItem: TMI_MsgBoxTypes.PSItem;
                                            DlgType: TMsgDlgType;
                                            Buttons: TMsgDlgButtons;
                                            ButtonDefault: TMsgDlgBtn
                                            ): TModalResult;

    function MI_MsgBox1MessageBox_05(ATitle: AnsiString;
                                     aMsg: AnsiString;
                                     DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn
                                    ): TModalResult;

    function MI_MsgBox1MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString;
                                                    APSItem: TMI_MsgBoxTypes.PSItem;
                                                    itemSelection: longint;
                                                    DlgType: TMsgDlgType;
                                                    Buttons: TMsgDlgButtons;
                                                    ButtonDefault: TMsgDlgBtn
                                                    ): TModalResult;

    private

    public
      MI_MsgBox1: TMI_MsgBox;
      constructor create(aOwner:TComponent);Override;
  end;

var
  Mi_ui_mi_msgBox: TMi_ui_mi_msgBox;

implementation

{$R *.lfm}

{ TMi_ui_mi_msgBox }

function TMi_ui_mi_msgBox.MI_MsgBox1InputBox(const aTitle,
                                                    ALabel: AnsiString;
                                                var Buff;
                                                    Template: AnsiString): TModalResult;
  var
    v,aResult : AnsiString;
begin
  aResult := '';
  v := InputBox(aTitle, aLabel, aResult);

  with TMI_MsgBoxConsts do
  if aResult <> v
  then Begin
        result := Mrok;
        aResult := v;
      end
  else result := MrCancel;

end;

function TMi_ui_mi_msgBox.MI_MsgBox1InputPassword(const aTitle: AnsiString;
                                                     var aPassword: AnsiString): TModalResult;
  var
    v : AnsiString;
begin
  v := apassword;
  InputQuery(aTitle, 'Senha:',true, apassword);
  if apassword <> v
  then result := MrOk
  else result := MrCancel;
end;

function TMi_ui_mi_msgBox.MI_MsgBox1InputValue(const aTitle, aLabel: AnsiString;
                                               var aValue: Variant): TModalResult;
  var
    v,aResult : Variant;
begin
  aResult := aValue;
  v := dialogs.InputBox(aTitle, aLabel, aResult);
  with TMI_MsgBoxConsts do
  if aResult <> v
  then Begin
        result := Mrok;
        aValue := v;
      end
  else result := MrCancel;

end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox(const aMsg: AnsiString
                                              ): TModalResult;
begin
  result := MessageDlg('', aMsg, mtWarning, [mbOk],0);
end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_03(const aMsg: AnsiString;
                                                  DlgType: TMsgDlgType;
                                                  Buttons: TMsgDlgButtons): TModalResult;
begin
  result := dialogs.MessageDlg(aMsg, DlgType,Buttons, 0);
end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_04(aMsg: AnsiString;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn
  ): TModalResult;
begin
   result := dialogs.MessageDlg(aMsg, DlgType,Buttons, 0);
end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_04_PSItem(aPSItem: TMI_MsgBoxTypes.PSItem;
                                                         DlgType: TMsgDlgType;
                                                         Buttons: TMsgDlgButtons;
                                                         ButtonDefault: TMsgDlgBtn): TModalResult;
begin

end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_05(ATitle: AnsiString;
                                                 aMsg: AnsiString;
                                                 DlgType: TMsgDlgType;
                                                 Buttons: TMsgDlgButtons;
                                                 ButtonDefault: TMsgDlgBtn): TModalResult;
begin
  result := dialogs.MessageDlg(ATitle,aMsg, DlgType,Buttons, 0);
end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString;
                                                                 APSItem: TMI_MsgBoxTypes.PSItem;
                                                                 itemSelection: longint;
                                                                 DlgType: TMsgDlgType;
                                                                 Buttons: TMsgDlgButtons;
                                                                 ButtonDefault: TMsgDlgBtn
                                                                 ): TModalResult;
  Var
    aMsg : AnsiString;
begin
  with MI_MsgBox1 do
  if APSItem <> nil
  Then begin
         aMsg :=  String_ListaDeMsgErro;
        result := dialogs.MessageDlg(Atitulo,aMsg, DlgType,Buttons, 0);
       end
  else Result := MrCancel;

end;

constructor TMi_ui_mi_msgBox.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  MI_MsgBox1 := TMI_MsgBox.Create(aOwner);
  with MI_MsgBox1 do
  begin
    onMessageBox_03 := @MI_MsgBox1MessageBox_03;
    onMessageBox_04 := @MI_MsgBox1MessageBox_04;
    onMessageBox_05 := @MI_MsgBox1MessageBox_05;
    onMessageBox    := @MI_MsgBox1MessageBox;
    onMessageBox_ListBoxRec_PSItem := @MI_MsgBox1MessageBox_ListBoxRec_PSItem;
    onInputValue    := @MI_MsgBox1InputValue;
    onInputBox      := @MI_MsgBox1InputBox;
    onInputPassword := @MI_MsgBox1InputPassword;

  end;
end;









end.

