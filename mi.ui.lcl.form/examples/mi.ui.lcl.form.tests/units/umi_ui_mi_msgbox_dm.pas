{object MI_MsgBox1: TMI_MsgBox
    onMessageBox_03 = MI_MsgBox1MessageBox_03
    onMessageBox_04 = MI_MsgBox1MessageBox_04
    onMessageBox_04_PSItem = MI_MsgBox1MessageBox_04_PSItem
    onMessageBox_05 = MI_MsgBox1MessageBox_05
    onMessageBox = MI_MsgBox1MessageBox
    onInputValue = MI_MsgBox1InputValue
    onInputBox = MI_MsgBox1InputBox
    onInputPassword = MI_MsgBox1InputPassword
    Left = 32
    Top = 32
  end}
unit umi_ui_mi_msgbox_dm;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils
  ,Dialogs
  ,Graphics
  ,StdCtrls
  ,System.UITypes
  ,mi.rtl.objects.consts.mi_msgbox;

type

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

  { TMi_ui_mi_msgBox }

  TMi_ui_mi_msgBox = class(TDataModule) //,IDialogs
    
    function MI_MsgBox1InputBox(const aTitle,
                                       ALabel: AnsiString;
                                var Buff;
                                Template: AnsiString): TModalResult;
    function MI_MsgBox1InputPassword(const aTitle: AnsiString;
                                     var aPassword: AnsiString): TModalResult;

    function MI_MsgBox1InputValue(const aTitle, aLabel: AnsiString;
                                  var aValue: Variant): TModalResult;

    function MI_MsgBox1MessageBox(const aMsg: AnsiString): TModalResult;
    function MI_MsgBox1MessageBox_03(const aMsg: AnsiString;
      DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TModalResult;

    function MI_MsgBox1MessageBox_04(aMsg: AnsiString;
                                     DlgType: TMsgDlgType;
                                     Buttons: TMsgDlgButtons;
                                     ButtonDefault: TMsgDlgBtn): TModalResult;
    function MI_MsgBox1MessageBox_04_PSItem(aPSItem: TMI_MsgBoxTypes.PSItem;
      DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn
      ): TModalResult;


    function MI_MsgBox1MessageBox_05(ATitle: AnsiString;
                                     aMsg: AnsiString;
                                     DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn
                                    ): TModalResult;


    {: - A procedure **@name** executa um dialogo com botão **OK**
    }
    Public Procedure Alert(aTitle: AnsiString;aMsg:AnsiString);

    {: - A função **@name** executa um dialogo com os botões **OK** e **Cancel** fazendo uma pergunta.

       - **RETORNA:**
         - **True** : Se o botão **OK** foi pŕessionando;
         - **False** : Se o botão **Cancel** foi pŕessionando.
    }
    Public Function Confirm(aTitle: AnsiString;aPergunta:AnsiString):Boolean;

    {: - A função **@name** mostra um dialogo com dois botões **OK** e **Cancel** e um campo input solicitando
         que o usuário digite um valor.

       - **RETORNA:**
         - **True** : Se o botão **ok** foi pŕessionando;
         - **False** : Se o botão **cancel** foi pŕessionando.
         - **aResult** : Retorna a string digitada no formulário;
    }
    Public Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: Variant):Boolean;

    {: - A função **@name** mostra um dialogo solicitando o login do usuário e a senha e dois botões **OK**
         e **Cancel**

       - **RETORNA:**
         - **True** : Se o botão **ok** foi pŕessionando;
         - **False** : Se o botão **cancel** foi pŕessionando.
         - **aUsername** : Retorna a string com nome do usuário.
         - **apassword** : Retorna a string com a senha do usuário.
    }
    Public Function InputPassword(aTitle: AnsiString;out aUsername:AnsiString;out apassword:AnsiString):Boolean;Overload;

    Public Function InputPassword(aTitle: AnsiString;out apassword:AnsiString):Boolean;Overload;

//    public function isDialog : IDialogs;
    private

    public MI_MsgBox1: TMI_MsgBox;
    public constructor create(aOwner:TComponent);override;
  end;

  function get_MI_MsgBox: TMi_ui_mi_msgBox;

implementation

{$R *.lfm}

var
  Mi_ui_mi_msgBox: TMi_ui_mi_msgBox;

  function get_MI_MsgBox: TMi_ui_mi_msgBox;
  begin
    result := Mi_ui_mi_msgBox;
  end;


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
  v := InputBox(aTitle, aLabel, aResult);
  with TMI_MsgBoxConsts do
  if aResult <> v
  then Begin
        result := Mrok;
        aValue := v;
      end
  else result := MrCancel;

end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox(const aMsg: AnsiString): TModalResult;
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
                                                  DlgType: TMsgDlgType;
                                                  Buttons: TMsgDlgButtons;
                                                  ButtonDefault: TMsgDlgBtn
                                                 ): TModalResult;
begin
   result := dialogs.MessageDlg(aMsg, DlgType,Buttons, 0);
end;

function TMi_ui_mi_msgBox.MI_MsgBox1MessageBox_04_PSItem(aPSItem: TMI_MsgBoxTypes.PSItem;
                                                         DlgType: TMsgDlgType;
                                                         Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn): TModalResult;
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

procedure TMi_ui_mi_msgBox.Alert(aTitle: AnsiString; aMsg: AnsiString);
begin
  if MI_MsgBox1 <> nil
  then with MI_MsgBox1 do
       begin
         MI_MsgBox1.MessageBox(aTitle,aMsg,mtWarning,[mbOk],mbOk);
       end;
end;

function TMi_ui_mi_msgBox.Confirm(aTitle: AnsiString; aPergunta: AnsiString): Boolean;
begin
  if MI_MsgBox1 <> nil
  then with MI_MsgBox1 do
       begin
         result := MI_MsgBox1.MessageBox(aTitle,aPergunta,mtConfirmation,mbYesNo,mbYes)=mrYes;
       end;
end;

function TMi_ui_mi_msgBox.Prompt(aTitle: AnsiString; aPergunta: AnsiString;  var aResult: Variant): Boolean;
begin
  if MI_MsgBox1 <> nil
  then with MI_MsgBox1 do
       begin
         result := MI_MsgBox1.InputValue(aTitle,aPergunta,aResult)=MrOk;
       end;
end;

function TMi_ui_mi_msgBox.InputPassword(aTitle: AnsiString; out aUsername: AnsiString; out apassword: AnsiString): Boolean;
begin
  if MI_MsgBox1 <> nil
  then with MI_MsgBox1 do
       begin
         result := MI_MsgBox1.InputPassword(aTitle,apassword)=MrOk;
       end;
end;

function TMi_ui_mi_msgBox.InputPassword(aTitle: AnsiString; out  apassword: AnsiString): Boolean;
begin
  if MI_MsgBox1 <> nil
  then with MI_MsgBox1 do
       begin
         result := MI_MsgBox1.InputPassword(aTitle,apassword)=MrOk;
       end;
end;

constructor TMi_ui_mi_msgBox.create(aOwner: TComponent);
begin
  inherited create(aOwner);
  MI_MsgBox1:= TMI_MsgBox.Create(aOwner);
  with MI_MsgBox1 do
  begin
    onMessageBox_03 := @MI_MsgBox1MessageBox_03;
    onMessageBox_04 := @MI_MsgBox1MessageBox_04;
    onMessageBox_04_PSItem := @MI_MsgBox1MessageBox_04_PSItem;
    onMessageBox_05 := @MI_MsgBox1MessageBox_05;
    onMessageBox := @MI_MsgBox1MessageBox;
    onInputValue := @MI_MsgBox1InputValue;
    onInputBox := @MI_MsgBox1InputBox;
    onInputPassword := @MI_MsgBox1InputPassword;
  end;

end;


//function TMi_ui_mi_msgBox.isDialog: IDialogs;
//begin
//  if Self is IDialogs
//  then result := Self
//  else result := nil;
//end;





Initialization

  Mi_ui_mi_msgBox := TMi_ui_mi_msgBox.Create(nil);

finalization

  freeandnil(Mi_ui_mi_msgBox );



end.

