unit umi_ui_msgbox_lcl;
{:< A unit **@name** é usado para implementar os formulários genéricos **LCL**
    necessário para o  pacote **mi.rtl** quando o pacote **mi.rtl** for usado
    com um projeto **LCL**.

- Formulários genéricos registrado no projeto **mi.rtl**:
  - MI_MsgBox1InputBox;
  - MI_MsgBox1InputPassword;
  - MI_MsgBox1InputValue;
  - MI_MsgBox1MessageBox
  - MI_MsgBox1MessageBox_03
  - MI_MsgBox1MessageBox_04
  - MI_MsgBox1MessageBox_04_PSItem
  - MI_MsgBox1MessageBox_05
  - MI_MsgBox1MessageBox_ListBoxRec_PSItem

- Classe abstrada implementada aqui é MI_MsgBox1 : TMI_MsgBox;
  - Essa classe associa os formuário que vem no projeto lazarus ao projeto mi.rtl;
  - Nota:
    - Caso o projeto mi.rtl seja usado na web então essa classe deve ser usando
      código html ou javascript;
    - Caso o projeto mi.rtl seja usado no console então essa classe deve ser usando
      o projeto Freevision;
}
{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils
  ,Dialogs
  ,Graphics

  ,System.UITypes
  ,mi.rtl.Objects.Methods
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,mi.rtl.objectss;

type
  { TMI_UI_MsgBox_LCL }
  {: TMI_UI_MsgBox_LCL

     - EXEMPLO DE USO:

       ```pascal

           Program test_MI_MsgBox
           Var
             S : String[10] = '';
           begin
             if MI_MsgBox.InputBox('InputBox Test','Gual a sua indade? ',s,'ssssssssss') = Mrok
             then ShowMessage('Sua idade é: 's);


           end.

       ```

  }
  TMI_UI_MsgBox_LCL = class(TDataModule)
    MI_MsgBox1: TMI_MsgBox;


    {: - O evento **@name** é executado pelo método TMI_MsgBox.InputBox}
    function MI_MsgBox1InputBox(const aTitle,
                                       ALabel: AnsiString;
                                var Buff;
                                Template: AnsiString): TModalResult;


    {: - O evento **@name** é executado pelo método TMI_MsgBox.InputPassword}
    function MI_MsgBox1InputPassword(const aTitle: AnsiString;
                                     var aPassword: AnsiString): TModalResult;

    {: - O evento **@name** é executado pelo método TMI_MsgBox.InputValue}
    function MI_MsgBox1InputValue(const aTitle, aLabel: AnsiString;
                                  var aValue: Variant): TModalResult;

    {: - O evento **@name** é executado pelo método TMI_MsgBox.MessageBox(const aMsg: AnsiString)}
    function MI_MsgBox1MessageBox(const aMsg: AnsiString): TModalResult;

    {: - O evento **@name** é executado pelo método TMI_MsgBox.MessageBox(const aMsg: AnsiString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons) }
    function MI_MsgBox1MessageBox_03(const aMsg: AnsiString;DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TModalResult;

    {: - O evento **@name** é executado pelo método TMI_MsgBox.MessageBox(aPSItem : TMI_MsgBoxTypes.PSItem;
                                                                        DlgType: TMsgDlgType;
                                                                        Buttons: TMsgDlgButtons;
                                                                        ButtonDefault: TMsgDlgBtn)}
    function MI_MsgBox1MessageBox_04(aMsg: AnsiString;
                                     DlgType: TMsgDlgType;
                                     Buttons: TMsgDlgButtons;
                                     ButtonDefault: TMsgDlgBtn): TModalResult;


    {: - O evento **@name** é executado pelo método TMI_MsgBox.MessageBox(aTitle : AnsiString;
                                                                          Msg: AnsiString;
                                                                          DlgType: TMsgDlgType;
                                                                          Buttons: TMsgDlgButtons;
                                                                          ButtonDefault: TMsgDlgBtn)}
    function MI_MsgBox1MessageBox_05(ATitle: AnsiString;
                                     aMsg: AnsiString;
                                     DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn
                                    ): TModalResult;

    {: - O evento **@name** é executado pelo método TMI_MsgBox.MessageBox(aTitle : AnsiString;
                                                                          Msg: AnsiString;
                                                                          DlgType: TMsgDlgType;
                                                                          Buttons: TMsgDlgButtons;
                                                                          ButtonDefault: TMsgDlgBtn) }
    function MI_MsgBox1MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString;
                                                    APSItem: TMI_MsgBoxTypes.PSItem;
                                                    itemSelection: longint;
                                                    DlgType: TMsgDlgType;
                                                    Buttons: TMsgDlgButtons;
                                                    ButtonDefault: TMsgDlgBtn
                                                    ): TModalResult;

    private

    public constructor  create(aOwner:TComponent); override;

  end;

//  function get_MI_MsgBox: TMI_UI_MsgBox_LCL;

//var
//  MI_UI_MsgBox: TMI_UI_MsgBox_LCL;

implementation

{$R *.lfm}

//function get_MI_MsgBox: TMI_UI_MsgBox_LCL;
//begin
//  result := MI_UI_MsgBox;
//end;

{ TMI_UI_MsgBox_LCL }

function TMI_UI_MsgBox_LCL.MI_MsgBox1InputBox(const aTitle,
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





function TMI_UI_MsgBox_LCL.MI_MsgBox1InputPassword(const aTitle: AnsiString;
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

function TMI_UI_MsgBox_LCL.MI_MsgBox1InputValue(const aTitle, aLabel: AnsiString;
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

function TMI_UI_MsgBox_LCL.MI_MsgBox1MessageBox(const aMsg: AnsiString
                                              ): TModalResult;
begin
  result := MessageDlg('', aMsg, mtWarning, [mbOk],0);
end;

function TMI_UI_MsgBox_LCL.MI_MsgBox1MessageBox_03(const aMsg: AnsiString;
                                                  DlgType: TMsgDlgType;
                                                  Buttons: TMsgDlgButtons): TModalResult;
begin
  result := dialogs.MessageDlg(aMsg, DlgType,Buttons, 0);
end;

function TMI_UI_MsgBox_LCL.MI_MsgBox1MessageBox_04(aMsg: AnsiString;
  DlgType: TMsgDlgType; Buttons: TMsgDlgButtons; ButtonDefault: TMsgDlgBtn
  ): TModalResult;
begin
   result := dialogs.MessageDlg(aMsg, DlgType,Buttons, 0);
end;



function TMI_UI_MsgBox_LCL.MI_MsgBox1MessageBox_05(ATitle: AnsiString;
                                                 aMsg: AnsiString;
                                                 DlgType: TMsgDlgType;
                                                 Buttons: TMsgDlgButtons;
                                                 ButtonDefault: TMsgDlgBtn): TModalResult;
begin
  result := dialogs.MessageDlg(ATitle,aMsg, DlgType,Buttons, 0);
end;

function TMI_UI_MsgBox_LCL.MI_MsgBox1MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString;
                                                                 APSItem: TMI_MsgBoxTypes.PSItem;
                                                                 itemSelection: longint;
                                                                 DlgType: TMsgDlgType;
                                                                 Buttons: TMsgDlgButtons;
                                                                 ButtonDefault: TMsgDlgBtn
                                                                 ): TModalResult;
  Var
    aMsg : AnsiString;
begin
  with MI_MsgBox1,TObjectsMethods do
  if APSItem <> nil
  Then begin
         aMsg :=  SItemToString(APSItem);
        result := dialogs.MessageDlg(Atitulo,aMsg, DlgType,Buttons, 0);
       end
  else Result := MrCancel;

end;

constructor TMI_UI_MsgBox_LCL.create(aOwner: TComponent);
begin
  inherited create(aOwner);
end;


// Eventos implementados visualmente por isso não preciso registrar.
//  MI_MsgBox1 := TMI_MsgBox.Create(aOwner);
//  with MI_MsgBox1 do
//  begin
//    onMessageBox_03 := MI_MsgBox1MessageBox_03;
//    onMessageBox_04 := MI_MsgBox1MessageBox_04;
//    onMessageBox_05 := MI_MsgBox1MessageBox_05;
//    onMessageBox    := MI_MsgBox1MessageBox;
//    onMessageBox_ListBoxRec_PSItem := MI_MsgBox1MessageBox_ListBoxRec_PSItem;
//    onInputValue    := MI_MsgBox1InputValue;
//    onInputBox      := MI_MsgBox1InputBox;
//    onInputPassword := MI_MsgBox1InputPassword;
//  end;
//end;



{: Inicialização do projeto usado para criar o módudlo MI_UI_MsgBox}
initialization

  //MI_UI_MsgBox := TMI_UI_MsgBox_LCL.create(nil);
  //TObjectss.Set_MI_MsgBox(MI_UI_MsgBox.MI_MsgBox1);

finalization
// FreeAndNil(MI_UI_MsgBox);

end.

