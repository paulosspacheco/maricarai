unit mi.rtl.Objects.Consts.Mi_MsgBox;
{:< - A Unit **@name** implementa a classe TMI_MsgBox.
    - **VERSÃO**
      - Alpha - 1.0.0

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
     ;


    {: A classe **@name** reune os tipos utilizados na classe TMI_MsgBox.}
    Type
      TFree_form_owner = Procedure of object unimplemented;


      { TMI_MsgBoxTypes }

      TMI_MsgBoxTypes =
      Class(TObjectsConsts)
        {$REGION ' ---> Property Free_form_owner : TComponent'}
          private _Free_form_owner: TFree_form_owner;
          {: O evento **@name** é usado para desalocar o formulário
             que implementa o diálogo TMi_Msg_Box ou TMi_Input_Box.

             - **EXEMPLO**

               ```pascal

                  procedure TMi_lcl_inputbox.MI_UI_InputBox1Free_form_owner;
                  begin
                    Free;
                  end;


               ```
          }
          published property  OnFree_form_owner: TFree_form_owner Read _Free_form_owner write _Free_form_owner;
        {$ENDREGION}

      {$REGION ' --->  Constantes '}
        // Used for ModalResult
        const
          MaxBufLength   = $ff00;
          mbOK       = System.UITypes.mbOK;
          mrOK       = System.UITypes.mrOK;

          mbCancel   = System.UITypes.mbCancel ;
          mrCancel   = System.UITypes.mrCancel;

          mbAbort    = System.UITypes.mbAbort;
          mrAbort    = System.UITypes.mrAbort;
          mrIgnore   = System.UITypes.mrIgnore;

          mbYes      = System.UITypes.mbYes;
          mrYes      = System.UITypes.mrYes;

          mbNo       = System.UITypes.mbNo;
          mrNo       = System.UITypes.mrNo;

          mbClose    = System.UITypes.mbClose;
          mrClose    = System.UITypes.mrClose;

          mbAll      = System.UITypes.mbAll;
          mrAll      = System.UITypes.mrAll;

          mbNoToAll  = System.UITypes.mbNoToAll;
          mrNoToAll  = System.UITypes.mrNoToAll;

          mbYesToAll = System.UITypes.mbYesToAll;
          mrYesToAll = System.UITypes.mrYesToAll;

          // Used for ModalResult
          mrNone     = System.UITypes.mrNone;

          mrLast     = System.UITypes.mrLast    ;




          //mrLast     = ;
          //mbNone     = System.UITypes.mbNone; não existe

          mbRetry    = System.UITypes.mbRetry;
          mrRetry    = System.UITypes.mrRetry;

          mbIgnore   = System.UITypes.mbIgnore ;
          mbHelp     = System.UITypes.mbHelp;


      {$ENDREGION ' --->  Constantes '}

      {$REGION ' --->  Tipos'}

            // Message dialog related
          public Type TMsgDlgType = System.UITypes.TMsgDlgType;
          public Type TMsgDlgBtn  = System.UITypes.TMsgDlgBtn;
          public Type TMsgDlgButtons = System.UITypes.TMsgDlgButtons;

          // ModalResult
          type TModalResult = System.UITypes.TModalResult;

          public Type TArray_MsgDlgBtn = array[0..2] of TMsgDlgBtn;


          public Type TPanel_Lista_de_Botoes = (En_Panel_Lista_de_Botoes_Yes_No_Cancel,
                                                En_Panel_Lista_de_Botoes_Yes_No,
                                                En_Panel_Lista_de_Botoes_Ok_Cancel,
                                                En_Panel_Lista_de_Botoes_Abort_Retry_Ignore
                                               );
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

      TMI_MsgBoxTypes_Class = Class of TMI_MsgBoxTypes;

    {$REGION ' --->  Tipos e function of object '}


        Type TMessageBox = Function (Const aMsg:AnsiString):TModalResult of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        Type TMessageBox_03 = Function (Const aMsg:AnsiString;
                                        DlgType: TMsgDlgType;
                                        Buttons: TMsgDlgButtons):TModalResult of Object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
               onde for usada.        }
        Type TMessageBox_04   = function (aMsg: AnsiString;
                                          DlgType: TMsgDlgType;
                                          Buttons: TMsgDlgButtons;
                                          ButtonDefault: TMsgDlgBtn): TModalResult of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        Type TMessageBox_04_PSItem   = function (aPSItem : TMI_MsgBoxTypes.PSItem;
                                                 DlgType : TMsgDlgType;
                                                 Buttons : TMsgDlgButtons;
                                                 ButtonDefault: TMsgDlgBtn): TModalResult of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        Type TMessageBox_05   = function (ATitle: AnsiString;
                                          aMsg: AnsiString;
                                          DlgType: TMsgDlgType;
                                          Buttons: TMsgDlgButtons;
                                          ButtonDefault: TMsgDlgBtn): TModalResult of object unimplemented;



        //type TMessageBox_Strings_Collection = Function(atitulo   : AnsiString;
        //                                               Var aList : TCollectionString;
        //                                               DlgType: TMsgDlgType;
        //                                               Buttons: TMsgDlgButtons):SmallInt of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        Type TMessageBox_ListBoxRec_PSItem =
             Function (Atitulo: AnsiString;
                       APSItem:TMI_MsgBoxTypes.PSItem;
                       itemSelection : longint;
                       DlgType: TMsgDlgType;
                       Buttons: TMsgDlgButtons;
                       ButtonDefault: TMsgDlgBtn):TModalResult of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
         Type TMessageBox_Strings = function (aTitulo:AnsiString;
                                              Msg: AnsiString;
                                              DlgType: TMsgDlgType;
                                              Buttons: TMsgDlgButtons
                                              ) : TModalResult of Object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        Type THandleException = procedure (Sender: TObject) of object  unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        type TShowHTML_02 = procedure (aTitle,aHTMLCode: AnsiString) of object  unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        type TShowHTML_03 = procedure (aRect : TMI_MsgBoxTypes.TPoint; aTitle,aHTMLCode: AnsiString) of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        type THideHTML = procedure () of object unimplemented;

        {: - O type **@name** é um evento que deve ser implementada na plataforma
             onde for usada.        }
        type TCloseHTML = procedure () of object unimplemented;

    {$ENDREGION ' --->  Tipos e function of object '}


    {: A classe **@name** reune todas as contates utilizadas na classe TMI_MsgBox.}
    Type
      TMI_MsgBoxConsts =
      Class(TMI_MsgBoxTypes)

        {$IF FPC_FULLVERSION > 30202}
            //Versao freepascal 3.3.1
            Const
            mrNone    = System.UITypes.mrNone;
            mrOK      = System.UITypes.mrOK;
            mrCancel  = System.UITypes.mrCancel;
            mrAbort   = System.UITypes.mrAbort;
            mrRetry   = System.UITypes.mrRetry;
            mrIgnore  = System.UITypes.mrIgnore;
            mrYes     = System.UITypes.mrYes;
            mrNo      = System.UITypes.mrNo;
            mrAll     = System.UITypes.mrAll;
            mrNoToAll = System.UITypes.mrNoToAll;
            mrYesToAll = System.UITypes.mrYesToAll;
            mrClose    = System.UITypes.mrClose;
            mrContinue = System.UITypes.mrContinue;
            mrTryAgain = System.UITypes.mrTryAgain;
            mrLast     = System.UITypes.mrLast;

            //Versão freepascal 3.3.1
            ModalResultStr: array[mrNone..mrLast]
                            of shortstring = ('mrNone',
                                              'mrOK',
                                              'mrCancel',
                                              'mrAbort',
                                              'mrRetry',
                                              'mrIgnore',
                                              'mrYes',
                                              'mrNo',
                                              'mrAll',
                                              'mrNoToAll',
                                              'mrYesToAll',
                                              'mrClose',
                                              'mrContinue',
                                              'mrTryAgain');

        {$ELSE}

          // Used for ModalResult
          const mrNone     = System.UITypes.mrNone;
          const mrAbort    = System.UITypes.mrAbort   ;
          const mrRetry    = System.UITypes.mrRetry   ;
          const mrIgnore   = System.UITypes.mrIgnore  ;
          const mrYes      = System.UITypes.mrYes     ;
          const mrNo       = System.UITypes.mrNo      ;
          const mrAll      = System.UITypes.mrAll     ;
          const mrNoToAll  = System.UITypes.mrNoToAll ;
          const mrYesToAll = System.UITypes.mrYesToAll;
          const mrClose    = System.UITypes.mrClose   ;
          const mrLast     = System.UITypes.mrLast    ;

          mbAbort    = System.UITypes.mbAbort;
          mbYes      = System.UITypes.mbYes;
          mbNo       = System.UITypes.mbNo;
          mbClose    = System.UITypes.mbClose;
          mbAll      = System.UITypes.mbAll;
          mbNoToAll  = System.UITypes.mbNoToAll;
          mbYesToAll = System.UITypes.mbYesToAll;
          mbRetry    = System.UITypes.mbRetry;
          mbIgnore   = System.UITypes.mbIgnore ;
          mbHelp     = System.UITypes.mbHelp;
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
            'mrN10:10oToAll',
            'mrYesToAll',
            'mrClose');
      {$ENDIF}

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
        {  AnsiChar_Control_Template : AnsiCharSet = [#0..#31,fldCONTRACTION,^a..^z,^A..^Z];}

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
      TMI_MsgBox = class;

      { TMI_MsgBox }

      TMI_MsgBox =
      Class(TMI_MsgBoxConsts)
        {: O método **@name** retorna o equivalente ModalResult ao botão default}
        public function ButtonDefault_to_ModalResult(aButtonDefault: TMsgDlgBtn):TModalResult;

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

        public class function SItemsLen(S: PSItem): SmallInt;var  Len : integer;
        public class function SItemToString(Items: PSItem): AnsiString;



      End;


//      public type TMI_MsgBox = mi.rtl.objects.Methods.TMI_MsgBox.TMI_MsgBox;
//      const  MI_MsgBox: TMI_MsgBox = nil;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Mi.Rtl', [TMI_MsgBox]);
end;

{ TMI_MsgBoxTypes }


{ TMI_MsgBox }

function TMI_MsgBox.ButtonDefault_to_ModalResult(aButtonDefault: TMsgDlgBtn ): TModalResult;
begin
  case aButtonDefault of
    mbOK     : Result := mrOK;
    mbCancel : Result := mrCancel;
    mbYes    : Result := mrYes;
    mbNo     : Result := mrNo;
    mbAbort  : Result := mrAbort;
    mbRetry  : Result := mrRetry;
    mbIgnore : Result := mrIgnore;
    mbAll    : Result := mrAll;
//    mbHelp   : Result := mrHelp;
    mbClose  : Result := mrClose;
    else result := mrNone;
  end;
end;

procedure TMI_MsgBox.ShowMessage(Msg: AnsiString);
begin
  MessageBox(Msg);
end;

function TMI_MsgBox.MessageBox(Msg: AnsiString;
                               DlgType: TMsgDlgType;
                               Buttons: TMsgDlgButtons;
                               ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
begin
  If (Not ok_Set_Transaction) and (Not Get_ok_Set_Server_Http)
  then begin
        if Assigned(onMessageBox_04)
        then Result := onMessageBox_04(Msg,DlgType,Buttons,ButtonDefault)
        Else Result := ButtonDefault_to_ModalResult(ButtonDefault);

       end
  else begin
         PushMsgErro(Msg);
         Result := ButtonDefault_to_ModalResult(ButtonDefault);
       end;
end;

function TMI_MsgBox.MessageBox(aPSItem : TMI_MsgBoxTypes.PSItem;
                               DlgType: TMsgDlgType;
                               Buttons: TMsgDlgButtons;
                               ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
  var
    s:AnsiString;
begin
  If (Not ok_Set_Transaction) and (Not Get_ok_Set_Server_Http)
  then begin
        if @onMessageBox_04_PSItem<>nil
        then Result := onMessageBox_04_PSItem(aPSItem,DlgType,Buttons,ButtonDefault)
        Else Result :=  ButtonDefault_to_ModalResult(ButtonDefault);
       end
  else begin
         s := SItemToString(aPSItem);
         PushMsgErro(s);
         Result := ButtonDefault_to_ModalResult(ButtonDefault);
       end;

end;

function TMI_MsgBox.MessageBox(aTitle : AnsiString;
                               Msg: AnsiString;
                               DlgType: TMsgDlgType;
                               Buttons: TMsgDlgButtons;
                               ButtonDefault: TMsgDlgBtn):TModalResult ;Overload;
begin
  If (Not ok_Set_Transaction) and (Not Get_ok_Set_Server_Http)
  then begin
         if @onMessageBox_05<>nil
         then Result := onMessageBox_05(aTitle,Msg,DlgType,Buttons,ButtonDefault)
         Else Result := ButtonDefault_to_ModalResult(ButtonDefault);
  end
  else begin
         PushMsgErro(Msg);
         Result := ButtonDefault_to_ModalResult(ButtonDefault);
       end;
end;


function TMI_MsgBox.MessageBox(const aMsg: AnsiString): TModalResult;
begin
  If (Not ok_Set_Transaction) and (Not get_ok_Set_Server_Http)
  then begin
         if @onMessageBox<>nil
         then Result := onMessageBox(aMsg)
         Else Result := mrOK;
  end
  else begin
         PushMsgErro(aMsg);
         Result := mrOK;
       end;
end;

function TMI_MsgBox.MessageBox(const aMsg: AnsiString; DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TModalResult;
begin
  If (Not ok_Set_Transaction) and (Not get_ok_Set_Server_Http)
  then begin
         if @onMessageBox_03<>nil
         then Result := onMessageBox_03(aMsg,DlgType, Buttons)
         Else Result := mrNone;
  end
  else begin
         PushMsgErro(aMsg);
         Result := mrNone;
       end;
end;

function TMI_MsgBox.MessageBox_ListBoxRec_PSItem(Atitulo: AnsiString;
                                                 APSItem: PSItem;
                                                 itemSelection : longint;
                                                 DlgType: TMsgDlgType;
                                                 Buttons: TMsgDlgButtons;
                                                 ButtonDefault: TMsgDlgBtn): TModalResult;

begin
  If (Not ok_Set_Transaction) and (Not get_ok_Set_Server_Http)
  then begin
         if @onMessageBox_ListBoxRec_PSItem<>nil
         then Result := onMessageBox_ListBoxRec_PSItem(Atitulo,APSItem,itemSelection,DlgType,Buttons,ButtonDefault)
         Else Result := ButtonDefault_to_ModalResult(ButtonDefault);
       end
  else begin
         PushMsgErro(SItemToString(APSItem));
         Result := ButtonDefault_to_ModalResult(ButtonDefault);
       end;
end;

//function TMI_MsgBox.InputValue(const aTitle,
//                                aLabel: AnsiString;
//                                var aValue: Variant): TModalResult;
//begin
//  If (Not ok_Set_Transaction) and (Not ok_Set_Server_Http)
//  then begin
//         if @onInputValue<>nil
//         then Result := onInputValue(aTitle, ALabel,aValue)
//         Else Result := MrCancel;
//  end
//  else PushMsgErro(aMsg);
//end;

//function TMI_MsgBox.InputBox(const aTitle, ALabel: AnsiString; var Buff; Template: AnsiString): TModalResult;
//begin
//  If (Not ok_Set_Transaction) and (Not ok_Set_Server_Http)
//  then begin
//         if @onInputBox<>nil
//         then Result := onInputBox(aTitle, ALabel,Buff,Template)
//         Else Result := MrCancel;
//  end
//  else PushMsgErro(aMsg);
//end;

//function TMI_MsgBox.InputPassword(const aTitle:AnsiString;var aPassword : AnsiString): TModalResult;
//begin
//  If (Not ok_Set_Transaction) and (Not ok_Set_Server_Http)
//  then begin
//         if @onInputPassword<>nil
//         then Result := onInputPassword(aTitle, aPassword)
//         Else Result := MrCancel;
//
//  end;
//end;

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

class function TMI_MsgBox.SItemsLen(S: PSItem): SmallInt;var  Len : integer;
begin
  Len := 0;
  While (S <> nil) do
  begin
    If (S^.Value <> nil)
    then Inc(Len, length(S^.Value^));
    S := S^.Next;
  end;
  SItemsLen := Len;
end;

class function TMI_MsgBox.SItemToString(Items: PSItem): AnsiString;
   Var
     Len : Longint;
Begin
  Result := '';
  Len := SItemsLen(Items);
  If (Len > 0) then
    While (Items <> nil) do
    begin
      If (Items.Value <> nil) then
          begin
            Result := Result + Items.Value^+^M;
          end;
      Items := Items.Next;
    end;
end;


end.

