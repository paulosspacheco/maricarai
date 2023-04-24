unit mi.rtl.Objects.Consts.Mi_MsgBox;
{:< - A Unit **@name** implementa a classe TMI_MsgBox.
    - **VERSÃO**
      - Alpha - 0.7.1.621

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.objects.msgbox.pas">mi.rtl.objects.msgbox.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **11/08/2011**
          - 08:00 a 12:00 : Criada a unit @name e a classe **TMI_MsgBox**

}
{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface
  uses
     Classes,SysUtils
     ,System.UITypes
     ,LazarusPackageIntf
     ,mi.rtl.objects.consts
//     ,mi.rtl.objects.methods.Collection.SortedCollection.tstringcollection.TCollectionString;
//    type TCollectionString = mi.rtl.objects.methods.Collection.SortedCollection.tstringcollection.TCollectionString.TCollectionString;
     ;


    {: A classe **@name** reune os tipos utilizados na classe TMI_MsgBox.}
    Type
      TMI_MsgBoxTypes =
      Class(TObjectsConsts)

        {$REGION ' --->  Tipos e constantes '}

          public type
            // Message dialog related
          public Type TMsgDlgType = System.UITypes.TMsgDlgType;

          public Type TMsgDlgBtn  = System.UITypes.TMsgDlgBtn; //mbNone //Não existe em System.UITypes.TMsgDlgBtn mais peciso dele em TMI_ui_Methods.MsgDlgButtons_To_MsgDlgBtn
          //TMsgDlgBtn     = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore, mbAll, mbNoToAll, mbYesToAll, mbHelp, mbClose);

          public Type TMsgDlgButtons = System.UITypes.TMsgDlgButtons;

            // ModalResult
//          public Type TModalResult = System.UITypes.TModalResult;
//          public Type PModalResult = System.UITypes.PModalResult;

          public Type TArray_MsgDlgBtn = array[0..2] of TMsgDlgBtn;


        Type
          TPanel_Lista_de_Botoes = (En_Panel_Lista_de_Botoes_Yes_No_Cancel,
                                    En_Panel_Lista_de_Botoes_Yes_No,
                                    En_Panel_Lista_de_Botoes_Ok_Cancel,
                                    En_Panel_Lista_de_Botoes_Abort_Retry_Ignore
                                   );
        const
          MaxBufLength   = $ff00;

        type
          PEditBuffer = ^TEditBuffer;
          TEditBuffer = array[0..MaxBufLength] of AnsiChar;


        //Type
        //  TListBoxRec = record    {<-- omit if TListBoxRec is defined else where}
        //    PS    : TCollectionString;
        //    Selection : TMI_MsgBoxTypes.Sw_Integer {Word};
        //    {O campo a seguir devolve a pedaco da string limitadas por ~ usada para transferencia de dados}
        //    StrSelection : String;
        //  end;

        {$ENDREGION ' --->  Tipos e constantes '}
    end;

    {$REGION ' --->  Tipos e function of object '}
        Type TMessageBox = Function (Const aMsg:AnsiString):TModalResult of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma onde for usada.        }
        Type TMessageBox_03 = Function (Const aMsg:AnsiString;
                                        DlgType: TMsgDlgType;
                                        Buttons: TMsgDlgButtons):TModalResult of Object unimplemented;
        Type TMessageBox_04   = function (aMsg: AnsiString;
                                          DlgType: TMsgDlgType;
                                          Buttons: TMsgDlgButtons;
                                          ButtonDefault: TMsgDlgBtn): TModalResult of object unimplemented;

        Type TMessageBox_04_PSItem   = function (aPSItem : TMI_MsgBoxTypes.PSItem;
                                                 DlgType : TMsgDlgType;
                                                 Buttons : TMsgDlgButtons;
                                                 ButtonDefault: TMsgDlgBtn): TModalResult of object unimplemented;


        Type TMessageBox_05   = function (ATitle: AnsiString;
                                          aMsg: AnsiString;
                                          DlgType: TMsgDlgType;
                                          Buttons: TMsgDlgButtons;
                                          ButtonDefault: TMsgDlgBtn): TModalResult of object unimplemented;



        //type TMessageBox_Strings_Collection = Function(atitulo   : AnsiString;
        //                                               Var aList : TCollectionString;
        //                                               DlgType: TMsgDlgType;
        //                                               Buttons: TMsgDlgButtons):SmallInt of object unimplemented;

        Type TMessageBox_ListBoxRec_PSItem =
             Function (Atitulo: AnsiString;
                       APSItem:TMI_MsgBoxTypes.PSItem;
                       itemSelection : longint;
                       DlgType: TMsgDlgType;
                       Buttons: TMsgDlgButtons;
                       ButtonDefault: TMsgDlgBtn):TModalResult of object unimplemented;


        Type TMessageBox_Strings = function (aTitulo:AnsiString;
                                              Msg: AnsiString;
                                              DlgType: TMsgDlgType;
                                              Buttons: TMsgDlgButtons
                                              ) : TModalResult of Object unimplemented;

        type TInputValue = function (const aTitle,
                                     aLabel: AnsiString;
                                     var aValue : Variant): TModalResult of object  unimplemented;

        type TInputBox = function (const aTitle,
                                         ALabel: AnsiString;
                                         var Buff;
                                         Template: AnsiString): TModalResult of object  unimplemented;

        type TInputPassword = function (const aTitle:AnsiString;
                                        var aPassword : AnsiString): TModalResult of object  unimplemented;

        Type THandleException = procedure (Sender: TObject) of object  unimplemented;

        type TShowHTML_02 = procedure (aTitle,aHTMLCode: AnsiString) of object  unimplemented;

        type TShowHTML_03 = procedure (aRect : TMI_MsgBoxTypes.TPoint; aTitle,aHTMLCode: AnsiString) of object unimplemented;
        type THideHTML = procedure () of object unimplemented;
        type TCloseHTML = procedure () of object unimplemented;

    {$ENDREGION ' --->  Tipos e function of object '}


    {: A classe **@name** reune todas as contates utilizadas na classe TMI_MsgBox.}
    Type
      TMI_MsgBoxConsts =
      Class(TMI_MsgBoxTypes)
        const
          // Used for ModalResult
          mrNone = System.UITypes.mrNone;
          mrOK = System.UITypes.mrOK;
          mrCancel = System.UITypes.mrCancel;
          mrAbort = System.UITypes.mrAbort;
          mrRetry = System.UITypes.mrRetry;
          mrIgnore = System.UITypes.mrIgnore;
          mrYes = System.UITypes.mrYes;
          mrNo = System.UITypes.mrNo;
          mrAll = System.UITypes.mrAll;
          mrNoToAll = System.UITypes.mrNoToAll;
          mrYesToAll = System.UITypes.mrYesToAll;
          mrClose = System.UITypes.mrClose;
          mrLast = System.UITypes.mrLast;
          //mbNone     = System.UITypes.mbNone; não existe
          mbYes      = System.UITypes.mbYes;
          mbNo       = System.UITypes.mbNo;
          mbOK       = System.UITypes.mbOK;
          mbCancel   = System.UITypes.mbCancel ;
          mbAbort    = System.UITypes.mbAbort;
          mbRetry    = System.UITypes.mbRetry;
          mbIgnore   = System.UITypes.mbIgnore ;
          mbAll      = System.UITypes.mbAll ;
          mbNoToAll  = System.UITypes.mbNoToAll;
          mbYesToAll = System.UITypes.mbYesToAll;
          mbHelp     = System.UITypes.mbHelp;
          mbClose    = System.UITypes.mbClose  ;

          // String representation of ModalResult values
          ModalResultStr: array[mrNone..mrLast] of shortstring = (
            'mrNone',
            'mrOk',
            'mrCancel',
            'mrAbort',
            'mrRetry',
            'mrIgnore',
            'mrYes',
            'mrNo',
            'mrAll',
            'mrNoToAll',
            'mrYesToAll',
            'mrClose');


      mtWarning = System.UITypes.mtWarning;
      mtError = System.UITypes.mtError;
      mtInformation = System.UITypes.mtInformation;
      mtConfirmation = System.UITypes.mtConfirmation;
      mtCustom = System.UITypes.mtCustom;
      //mfInsertInApp = 12;

      const
        mbOKButton = [mbOK];
        mbYesNoCancel = [mbYes, mbNo, mbCancel];
        mbYesNo = [mbYes, mbNo];
        mbOKCancel = [mbOK, mbCancel];
        mbAbortRetryIgnore = [mbAbort, mbRetry, mbIgnore];

        //mfAbortRetryIgnore = mbAbortRetryIgnore;
        {  AnsiChar_Control_Template : AnsiCharSet = [#0..#31,'`',^a..^z,^A..^Z];}

        {Se MessageBoxOff = true entÆo nao mostra o dialogo e torna o comando defaust

         Usada quando se se que despresar a acao do usuario e que ler os erros de um
         arquivo de erros. Normalmente deve ser usado nos programas controlados em linha
         de comando.
        }
        const MessageBoxOff    : Boolean = false;

      end;

    {: - A classe **@name** é uma classe abstrata para comunicação com o usuário
         cujo a implementação deve ser feita nas plataformas:  LCL, HTML e  JavaScript.
    }
    Type

      { TMI_MsgBox }

      TMI_MsgBox =
      Class(TMI_MsgBoxConsts)

        Public procedure ShowMessage(Msg:AnsiString);Overload;

        {$REGION ' ---> Property onMessageBox_03 : TMessageBox_03 '}
            strict Private Var _onMessageBox_03 : TMessageBox_03;
            Published property  onMessageBox_03: TMessageBox_03 Read _onMessageBox_03   Write  _onMessageBox_03;
          {$ENDREGION}
        {: O método **@name** recebe 3 parâmetros criar um dialogo e retrona as opções escolhidas.}
        public function MessageBox(const aMsg: AnsiString;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons): TModalResult;

        {$REGION ' ---> Property onMessageBox_04 : TMessageBox_04'}
           Published strict Private Var _onMessageBox_04 : TMessageBox_04;
           {: - A propriedade @name mostra uma mensage com o title customizado.
           }
           Published property  onMessageBox_04: TMessageBox_04 Read _onMessageBox_04 Write _onMessageBox_04;
        {$ENDREGION}
        public function MessageBox(Msg: AnsiString;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons;
                                   ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;

        {$REGION ' ---> Property MessageBox_04_PSItem : TMessageBox_04_PSItem'}
          Published strict Private Var _MessageBox_04_PSItem : TMessageBox_04_PSItem;
          {: - A propriedade @name mostra uma mensage com o title customizado.
          }
          Published property  onMessageBox_04_PSItem: TMessageBox_04_PSItem Read _MessageBox_04_PSItem Write _MessageBox_04_PSItem;
        {$ENDREGION}
        public function MessageBox(aPSItem : TMI_MsgBoxTypes.PSItem;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons;
                                   ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;


        {$REGION ' ---> Property onMessageBox_05 : TMessageBox_05'}
           Published strict Private Var _onMessageBox_05 : TMessageBox_05;
           {: - A propriedade @name mostra uma mensage com o title customizado.
           }
           Published property  onMessageBox_05: TMessageBox_05 Read _onMessageBox_05 Write _onMessageBox_05;
        {$ENDREGION}
        public function MessageBox(aTitle : AnsiString;
                                   Msg: AnsiString;
                                   DlgType: TMsgDlgType;
                                   Buttons: TMsgDlgButtons;
                                   ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;



        {$REGION ' ---> Property onMessageBox : TMessageBox '}
             strict Private Var _onMessageBox : TMessageBox;
             Published property  onMessageBox: TMessageBox Read _onMessageBox   Write  _onMessageBox;
        {$ENDREGION}
        public Function MessageBox(Const aMsg:AnsiString):TModalResult;Overload;

        {$REGION ' ---> Property onMessageBox_ListBoxRec_PSItem : TMessageBox_ListBoxRec_PSItem '}
           strict Private Var _onMessageBox_ListBoxRec_PSItem : TMessageBox_ListBoxRec_PSItem;
           Published property  onMessageBox_ListBoxRec_PSItem: TMessageBox_ListBoxRec_PSItem Read _onMessageBox_ListBoxRec_PSItem   Write _onMessageBox_ListBoxRec_PSItem;
        {$ENDREGION}
        Public Function MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString;
                                                     APSItem:PSItem;
                                                     itemSelection : longint;
                                                     DlgType: TMsgDlgType;
                                                     Buttons: TMsgDlgButtons;
                                                     ButtonDefault: TMsgDlgBtn):TModalResult;//Não desaloca APSItem

        {$REGION ' ---> Property onInputBox : TInputBox '}
           strict Private Var _onInputValue : TInputValue;

           {: O evento **@name** ler um valor na tela e retorna em **aValue** o valor e em result
           retona **MrOk** ou **MrCancel**
              - **Nota**
                - Essa propriedade deve ser implementada na plataforma selecionada. Ou  seja: LCL,
                  Android, html etc...
           }
           Published  property  onInputValue: TInputValue Read _onInputValue   Write  _onInputValue;
        {$ENDREGION}
        {: O método **@name** ler um valor na tela e retorna em **aValue** o valor e em result
           retorna **MrOk** ou **MrCancel**}
        Public function InputValue(const aTitle,
                                    aLabel: AnsiString;
                                    var aValue : Variant
                                   ): TModalResult;


        {$REGION ' ---> Property onInputBox : TInputBox '}
          strict Private Var _onInputBox : TInputBox;
          Published  property  onInputBox: TInputBox Read _onInputBox   Write  _onInputBox;
        {$ENDREGION}
        Public function InputBox(const
                                  aTitle,
                                  aLabel: AnsiString;
                                  var
                                    Buff; {:< uffer da variável para ler.}
                                  Template: AnsiString
                               ): TModalResult;

        {$REGION ' ---> Property onInputPassword : TInputPassword '}
          strict Private Var _onInputPassword : TInputPassword;
          Published  property  onInputPassword: TInputPassword Read _onInputPassword   Write  _onInputPassword;
        {$ENDREGION}
        Public function InputPassword(const aTitle:AnsiString;var aPassword : AnsiString): TModalResult;



        {$REGION ' ---> Property OnHandleException : THandleException '}
          strict Private Var _OnHandleException : THandleException;

          {: - Propriedade OnHandleException : THandleException
             - Objetivo:
                 - This is the exception handler which is called if an exception is raised
                   while the component is being stream in or streamed out.  In most cases this
                   should be implemented useing the application exception handler as follows.

          }
          Published property  OnHandleException: THandleException Read _OnHandleException   Write  _OnHandleException;
        {$ENDREGION}
        Public procedure HandleException(Sender: TObject);

        {$REGION ' ---> Property OnShowHTML_02 : TShowHTML_02 '}
          strict Private Var _OnShowHTML_02 : TShowHTML_02;
          //            strict Private Function  GetOnShowHTML_02 : TShowHTML_02;
          //            strict Private Procedure SetOnShowHTML_02 (aOnShowHTML_02 : TShowHTML_02 );

          {: - Propriedade OnShowHTML_02 : TShowHTML_02  visualizar código html
          }
          Published property  OnShowHTML_02: TShowHTML_02 Read _OnShowHTML_02 Write  _OnShowHTML_02;
        {$ENDREGION}
         public procedure ShowHTML(aTitle,aHTMLCode: AnsiString);Overload;

        {$REGION ' ---> Property OnShowHTML_03 : TShowHTML_03 '}
          strict Private Var _OnShowHTML_03 : TShowHTML_03;
          //strict Private Function  GetOnShowHTML_03 : TShowHTML_03;
          //strict Private Procedure SetOnShowHTML_03 (aOnShowHTML_03 : TShowHTML_03 );

          Published property  OnShowHTML_03: TShowHTML_03 Read _OnShowHTML_03 Write  _OnShowHTML_03;
        {$ENDREGION}
        public procedure ShowHTML(aRect : TPoint;aTitle,aHTMLCode: AnsiString);Overload;

        {$REGION ' ---> Property OnHideHTML : THideHTML '}
          strict Private Var _OnHideHTML : THideHTML;
          {:- Propriedade OnHideHTML : THideHTML tornar invisível o browser corrente
          }
          Published property  OnHideHTML: THideHTML Read _OnHideHTML Write  _OnHideHTML;
        {$ENDREGION}
        public procedure HideHTML();

        {$REGION ' ---> Property OnCloseHTML : TCloseHTML '}
          strict Private Var _OnCloseHTML : TCloseHTML;
          {: -Propriedade OnCloseHTML : TCloseHTML destroy a janela do browser corrente
          }
          Published property  OnCloseHTML: TCloseHTML Read _OnCloseHTML Write  _OnCloseHTML;
        {$ENDREGION}
        public procedure CloseHTML();

      End;


//      public type TMI_MsgBox = mi.rtl.objects.Methods.TMI_MsgBox.TMI_MsgBox;
//      const  MI_MsgBox: TMI_MsgBox = nil;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mi.Rtl', [TMI_MsgBox]);
end;


{ TMI_MsgBox }

procedure TMI_MsgBox.ShowMessage(Msg: AnsiString);
begin
  MessageBox(Msg);
end;

function TMI_MsgBox.MessageBox(Msg: AnsiString;
                               DlgType: TMsgDlgType;
                               Buttons: TMsgDlgButtons;
                               ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
begin
  If (Not ok_Set_Transaction)
  then begin
        if @onMessageBox_04<>nil
        then Result := onMessageBox_04(Msg,DlgType,Buttons,ButtonDefault)
        Else Result :=  mrNone;

       end
  else Push_MsgErro(Msg);
end;

function TMI_MsgBox.MessageBox(aPSItem : TMI_MsgBoxTypes.PSItem;
                               DlgType: TMsgDlgType;
                               Buttons: TMsgDlgButtons;
                               ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
begin
  If (Not ok_Set_Transaction)
  then begin
        if @onMessageBox_04_PSItem<>nil
        then Result := onMessageBox_04_PSItem(aPSItem,DlgType,Buttons,ButtonDefault)
        Else Result :=  mrNone;
       end;
//  else Push_MsgErro(Msg);
end;

function TMI_MsgBox.MessageBox(aTitle : AnsiString;
                               Msg: AnsiString;
                               DlgType: TMsgDlgType;
                               Buttons: TMsgDlgButtons;
                               ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onMessageBox_05<>nil
         then Result := onMessageBox_05(aTitle,Msg,DlgType,Buttons,ButtonDefault)
         Else Result :=  mrNone;
  end
  else Push_MsgErro(Msg);
end;


function TMI_MsgBox.MessageBox(const aMsg: AnsiString): TModalResult;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onMessageBox<>nil
         then Result := onMessageBox(aMsg)
         Else Result := mrOK;
  end
  else Push_MsgErro(aMsg);
end;

function TMI_MsgBox.MessageBox(const aMsg: AnsiString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TModalResult;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onMessageBox_03<>nil
         then Result := onMessageBox_03(aMsg,DlgType, Buttons)
         Else Result := mrNone;
  end
  else Push_MsgErro(aMsg);
end;

function TMI_MsgBox.MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString; APSItem: PSItem;
                                                 itemSelection : longint;
                                                 DlgType: TMsgDlgType;
                                                 Buttons: TMsgDlgButtons;
                                                 ButtonDefault: TMsgDlgBtn): TModalResult;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onMessageBox_ListBoxRec_PSItem<>nil
         then Result := onMessageBox_ListBoxRec_PSItem(Atitulo,APSItem,itemSelection,DlgType,Buttons,ButtonDefault)
         Else Result := mrNone;
       end;
end;

function TMI_MsgBox.InputValue(const aTitle,
                                aLabel: AnsiString;
                                var aValue: Variant): TModalResult;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onInputValue<>nil
         then Result := onInputValue(aTitle, ALabel,aValue)
         Else Result := MrCancel;
  end;
end;

function TMI_MsgBox.InputBox(const aTitle, ALabel: AnsiString; var Buff; Template: AnsiString): TModalResult;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onInputBox<>nil
         then Result := onInputBox(aTitle, ALabel,Buff,Template)
         Else Result := MrCancel;
  end;
end;

function TMI_MsgBox.InputPassword(const aTitle:AnsiString;var aPassword : AnsiString): TModalResult;
begin
  If (Not ok_Set_Transaction)
  then begin
         if @onInputPassword<>nil
         then Result := onInputPassword(aTitle, aPassword)
         Else Result := MrCancel;

  end;
end;

{ This is the exception handler which is called if an exception is raised
  while the component is being stream in or streamed out.  In most cases this
  should be implemented useing the application exception handler as follows. }

procedure TMI_MsgBox.HandleException(Sender: TObject);
begin
  if @OnHandleException<>nil
  then OnHandleException(Sender)
  else raise EArgumentException.Create('A procedure '+Self.ClassName+' não implementada.');
end;

procedure TMI_MsgBox.ShowHTML(aTitle,aHTMLCode: AnsiString);
begin
  if @OnShowHTML_02<>nil
  then OnShowHTML_02(aTitle,aHTMLCode)
  else raise EArgumentException.Create('A procedure '+Self.ClassName+' não implementada.');
end;

procedure TMI_MsgBox.ShowHTML(aRect: TPoint; aTitle, aHTMLCode: AnsiString);
begin
  if @OnShowHTML_03<>nil
  then OnShowHTML_03(aRect,aTitle,aHTMLCode)
  else raise EArgumentException.Create('A procedure '+Self.ClassName+' não implementada.');
end;

procedure TMI_MsgBox.HideHTML();
begin
  if @OnHideHTML<>nil
  then OnHideHTML()
  else raise EArgumentException.Create('A procedure '+Self.ClassName+' não implementada.');
end;

procedure TMI_MsgBox.CloseHTML;
begin
  if @OnCloseHTML<>nil
  then OnCloseHTML()
  else raise EArgumentException.Create('A procedure '+Self.ClassName+' não implementada.');
end;



end.
