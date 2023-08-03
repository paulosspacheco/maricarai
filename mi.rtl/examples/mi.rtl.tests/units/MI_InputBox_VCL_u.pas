{$H-}
unit MI_InputBox_VCL_u;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

{$I z:\TV32\MarIcaraiV1\s{$IFnDEF FPC}
  Mask, Windows,
{$ELSE}
  Masks, LCLIntf, LCLType, LMessages,
{$ENDIF}
  latform_inc.pas}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes,ics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls,Use32,Mi_MsgBox,MI_ComboBoxEx_VCL,DMXGIZMA;

  function InputBox_VCL(const Title,ALabel: AnsiString; Var Buff; Template: AnsiString ): Word;

  function VCL_InputBox(const
                      Title,
                      ALabel: AnsiString;
                      Buffer : AnsiString;
                    Var
                      ResultShowModal: Word;
                      Template: TString
                   ): AnsiString;//Variant;

  Function Template_To_EditMask(aTemplate : ShortString; Var Size_TypeFld,aLength_Buffer : SmallWord;var OkMask : Boolean) : AnsiString;
  Function TextWidth_M(aForm:TForm;AnsiCharWidthMaximo:string):Longint;

Implementation

{R *.dfm}

 Uses
   Db_Global,objects,Db_Error,BBError,Db_datas,ViDialog,Db_Generic;

  Function Template_To_EditMask(aTemplate : ShortString; Var Size_TypeFld,aLength_Buffer : SmallWord;var OkMask : Boolean) : AnsiString;
  {Caracter Descri��o da mascara da VCL
    ! Espa�os em branco n�o aparecer�o
    > Todos os caracteres seguintes ser�o mai�sculos at� que apare�a o caracter
    < Todos os caracteres seguintes ser�o min�sculos at� que apare�a o caracter
    \ Indica um caracter literal
    l (L minusculo) Somente caracter alfab�tico
    L Obrigatoriamente um caracter alfab�tico (A-Z, a-z)
    a Somente caracter alfanum�rico
    A Obrigatoriamente caractere alfanum�rico ( A-Z, a-z, 0-9)
    9 Somente caracter num�rico
    0 Obrigatoriamente caracter num�rico
    c permite um caracter
    C Obrigatoriamente um caracter
    # Permite um caracter num�rico ou sinal de mais ou de menos, mas n�o os requer.
    : Separador de horas, minutos e segundos
    / Separador de dias, meses e anos
    }

    {
    A m�scara basicamente consiste de tr�s campos, separados por ponto e v�rgula. A primeira parte � a m�scara propriamente dita.
    A segunda parte determina se os caracteres fixos devem ser ou n�o salvos com a m�scara (ex: /, -, (, ...).
    A terceira parte da m�scara representa o caracter em branco, podendo ser substitu�do por outro (ex: _, @, ...).

    Caracteres especiais utilizados com a m�scara:

    ! Faz com que a digita��o da m�scara fique parada no primeiro caracter, fazendo com que os caracteres digitados que se movam. Ex: !;0;_

    > Todos os caracteres alfab�ticos digitados ap�s este s�mbolo ser�o convertidos para mai�sculos. Ex: >aaa;0;_

    < Todos os caracteres alfab�ticos digitados ap�s este s�mbolo ser�o convertidos para min�sculos. Ex: <aaa;0;_

    <> Anula o uso dos caracteres > e <. Ex: >aaa<>aaa;0;_

    \ Utilizado para marcar determinado caractere n�o especial como fixo, n�o podendo sobrescrev�-lo. Ex: !\(999\)000-0000;0;_

    L Caracteres alfab�ticos (A-Z, a-z.) de preenchimento obrigat�rio. Ex: LLL;1;_

    l (Letra ele min�scula) Caracteres alfab�ticos (A-Z, a-z.) de preenchimento opcional. Ex: lll;1;_

    A Caracteres alfanum�ricos (A-Z, a-z, 0-9) de preenchimento obrigat�rio. Ex: AAA;1;_

    a Caracteres alfanum�ricos (A-Z, a-z, 0-9) de preenchimento opcional. Ex: aaa;1;_

    C Exige preenchimento obrigat�rio com qualquer caractere para a posi��o. Ex: CCC;1;_

    c Permite qualquer caractere para a posi��o de preenchimento opcional. Ex: ccc;1;_

    0 Caracteres num�ricos (0-9) de preenchimento obrigat�rio. Ex: 000;1;_

    9 Caracteres num�ricos (0-9) de preenchimento opcional. Ex: 999;1;_

    # Caracteres num�ricos (0-9) e os sinais de - ou + de preenchimento opcional. Ex: ###;1;_

    : Utilizado como separador de horas, minutos e segundos. Ex: !00:00:00;1;_

    / Utilizado como separador de dia, m�s e ano. Ex: !99/99/9999;1;_

    ; Separa os tr�s campos da m�scara.

    _ Caractere usado normalmente nas posi��es do campo ainda n�o preenchidas.

    }


    Var
      I : Byte;
//      OKMaiuscula: Boolean;
      aTypeFld    : AnsiChar;
      OKSeparador:boolean;
  Begin
    Result := '';
    OkMask := false;
    OKSeparador := false;
    aLength_Buffer := 0;
//    OKMaiuscula := false;
    aTypeFld    := TypeFld(aTemplate,Size_TypeFld);
    If aTypeFld  in [FldData,fldLData,fld_LData]
    Then  Begin
            OkMask := true;
            Result  := '99/99/00;0;_';
            aLength_Buffer := 6;
            exit;
          end
    Else
    If aTypeFld in [fldLHora,fld_LHora]
    Then  Begin
            OkMask := true;
            Result  := '!90:00;0;_';
            aLength_Buffer := 6;
            exit;
          end
    Else
    For i := 1 to length(aTemplate) do
    Begin
      case aTemplate[i] of
        fldSTR          ,//    'S';  { string Field }
        fldAnsiChar         ://    'C';  { AnsiCharacter Field }
         Begin
           OkMask := true;
           Result := Result + '>c';
//           oKMaiuscula := true;
           aLength_Buffer := aLength_Buffer + 1;
         End;

        fldAnsiChar_Minuscula,   //  'c';  // AnsiCharacter Field
        fldSTR_Minuscula       : //  's'   // Minusculo e maiusculo
        begin
           Result := Result + 'c';
           aLength_Buffer := aLength_Buffer + 1;
        end;

        'z',
        fldZEROMOD      ,//   'Z';  { zero modifier }
        fldHexValue     ,//   'H';  { hexadecimal numeric entry }
        fldSTRNUM       ,//   '#';  { numeric string Field }
        fldAnsiCharNUM      ,//   '0';  { numeric AnsiCharacter Field }
        fldAnsiCharVAL      ,//   'N';  { dbase formatted numeric Field }
        fldBYTE         ,//   'B';  { byte Field }
        fldSHORTINT     ,//   'J';  { shortint Field }
        fldSmallWORD    ,//   'W';  { word Field NortSoft}
        fldSmallInt     ,//   'I';  { integer Field NortSoft}
        fldLONGINT      ://   'L';  { longint Field }
        Begin
          OkMask := true;
          Result := Result + '#'; //0..9, + ,  -
          aLength_Buffer := aLength_Buffer + 1;
        end;

        fldExtended     ,//  'E';  {Real 10 bytes}
        fldReal6        ,//  'O';  { Real 6 Byte positivos e negativos }
        fldReal6P       ,//  'P';  { P = Real de mostrado x por 100 positivos e negativos}
        fldRealNum      ://  'R';  { real number Field  (uses TRealNum) }
        Begin
          Result := Result + '#';
          aLength_Buffer := aLength_Buffer + 1;
        end;

        fldRealNum_Positivo, // 'r';  { real number Field positive (uses TRealNum) }
        fldReal6Positivo   , // 'o';  { Real 6 Byte positivos}
        fldReal6PPositivo  : // 'p';  { P = Real de mostrado x por 100 positivos}
        Begin
          Result := Result + '#';
          aLength_Buffer := aLength_Buffer + 1;
        End;


        fldCheckBox         ,//  'K';  {fldCheckBox,FldRadioButton Campo Bit onde varios bits podem estar setado ao mesmo tempo}
        FldRadioButton      ,//  'k';  {fldCheckBox,FldRadioButton Campo Bit onde apenas 1 bit pode estar setado               }
        fldENUM             ://  ^E;   { enumerated Field }
        Begin
          Result := Result + '9';
          aLength_Buffer := aLength_Buffer + 1;
        end;

        fldData             ,//'D';  { D = TipoData DD/DD/DD}
        fldLData            ,//#1  ;  { #1 = Longint;Guarda a data compactada '##/##/##'}
        fld_LData           ://'d' ;  { d = Longint;Guarda a data compactada 'dd/dd/dd'}
        Begin
          // foi lido acima
        end;

        fldLHora           ,// #2 ;  { #2 = Longint;Guarda a hora compactada  ##:##:##}
        fld_LHora          :// 'h';  { h = Longint;Guarda a hora compactada   hh:hh:hh}
        Begin
          Result := Result + '0';
          aLength_Buffer := aLength_Buffer + 1;
        end;

        ' '  : Result := Result + '_';
        '~'  : begin end;


        Else If IsNumber_Real(aTypeFld)
             Then Begin
                    If aTemplate[i] = DecPt
                    Then Result := Result + ',';
                    OKSeparador := true;

{Caso coloque os caracteres abaixo na mascara o delphi n�o reconhecer� como n�mero.
                    If (aTypeFld in [fldExtended,fldReal6,fldReal6P,fldRealNum,fldRealNum_Positivo,fldReal6Positivo,fldReal6PPositivo])
                        and (aTemplate[i] in [' ','%','$'])
                    Then Result := Result + aTemplate[i];
}
                  end
             Else begin
                    if not OkMask
                    then OkMask := true;
                    OKSeparador := true;

                    Result := Result + aTemplate[i];
                  end;
(*
        fldBOOLEAN          =   'X';  { boolean value Field }
        fldBLOb             =   ^M;   { unformatted data Field }
        FldOperador = #3; { #3 = Byte indica que o campo � um operador matemático}
        FldMemo  = 'M';
        CharShowPassword  = ^W;  { Usado para omitir da os caracteres que estão sendo digitados em qualquer tipo de campo}
        CharExecProc   = ^T;  { O Ponteiro para um procedimento}
        fldCONTRACTION      =   '`';  { limit of visible text }
        fldAPPEND           =   ^G;   { append from pointer }
        fldSItems           =   ^I;   { link to chain of TSItem Templates }
        fldXSPACES          =   ' ';  { spaces --extended code follows <Esc> }
        fldXTABTO           =   ^I;   { tab    --extended code follows <Esc> }
        fldXFieldNUM        =   ^F;   { fnum   --extended code follows <Esc> }
*)

      end;
    end;

//    If oKMaiuscula
//    Then Result := '>'+Result;


    If IsNumber_Real(aTypeFld) //or IsNumber_Integer(aTypeFld)
    Then begin
           if OKSeparador
           then Result := '!'+Result; //Espa�os em branco n�o aparecer�o

           result := Result+
                   ';'+
                   '1'+ // Retorna a mascara junto com o campo
                   ';_' // Escreva o caractere _ ao inves de brancos.
         end
    Else begin
           if OkMask
           then begin
                  if OKSeparador
                  then Result := '!'+Result; //Espa�os em branco n�o aparecer�o


                  Result := Result+
                   ';'+
                   '0'+  // Nao Retorna a mascara junto com o campo
                   ';_' // Escreva o caractere _ ao inves de brancos.
                end
           else Result := '';
         end;
  end;

  Function TextWidth_M(aForm:TForm;AnsiCharWidthMaximo:string):Longint;
  Begin
    If aForm <> nil
    Then bEGIN
           if length(AnsiCharWidthMaximo) = 1
           Then Begin
                   IF AnsiCharWidthMaximo[1] IN ['0'..'9']
                   THEN Result := aForm.Canvas.TextWidth(AnsiCharWidthMaximo)+1
                   ELSE Result := aForm.Canvas.TextWidth(AnsiCharWidthMaximo)+2;
                End
           Else Begin
                  If Pos('`',AnsiCharWidthMaximo) <> 0
                  Then AnsiCharWidthMaximo := Copy(AnsiCharWidthMaximo,1,Pos('`',AnsiCharWidthMaximo)-1)
                  else begin
                         if Pos(';',AnsiCharWidthMaximo)<>0
                         then AnsiCharWidthMaximo := Copy(AnsiCharWidthMaximo,1,Pos(';',AnsiCharWidthMaximo)-1);

                         Result := aForm.Canvas.TextWidth(AnsiCharWidthMaximo)+TextWidth_M(aForm,'M');
                       end;
                End;
         END
    Else Result := 0;
  end;

  function VCL_InputBox(const
                          Title,
                          ALabel: AnsiString;
                          Buffer : AnsiString;
                        Var
                          ResultShowModal: Word;
                          Template: tString
                       ): AnsiString;//Variant;

  { EXEMPLO DE COMO ESTA FUNCAO DEVE SER USADA
  Programa teste1;
  Var
    R : TRealNum;
    S : String;
  BEGIN
    R := 100.78;
    Application_GCIC_EC_C.App_GCIC_EC.MI_MsgBox.InputBox('VALOR TOTAL DA NOTA FISCAL','Qual o valor declarado na nota fiscal?',R,'$rrr,rrr,rrr.zz'); $ n�o aparecer�.
    Application_GCIC_EC_C.App_GCIC_EC.MI_MsgBox.InputBox('Informe um n�mero TRealNum: ','N�mero TRealNum: ',R,'RRR,RRR.ZZ')
    Application_GCIC_EC_C.App_GCIC_EC.MI_MsgBox.InputBox('Informe um n�mero TRealNum: ','N�mero TRealNum: ',v,'$RRR,RRR.zz')  //O $ n�o aparecer�.

    S := 'Paulo';
    Application_GCIC_EC_C.App_GCIC_EC.MI_MsgBox.InputBox('Qual o seu nome?','',
             S,'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS`SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS');
  END.

  Programa teste2;
  Var
    V : TRealNum;
  begin
    v := 100.78;
    if Application_GCIC_EC_C.App_GCIC_EC.MI_MsgBox.InputBox('Informe um n�mero TRealNum: ','N�mero TRealNum: ',v,'$RRR,RRR.zz') = CmOk
    then begin
             Application_GCIC_EC_C.App_GCIC_EC.MI_MsgBox.ShowMessage(FloatToStr(v));
         end;
  end.

  }

    Var
      Form           : TForm;
      E              : TMaskEdit;
      MI_ComboBoxEx1 : TMI_ComboBoxEx;
      Items,P        : PSitem;

      L1,L2          : TLabel;
      BitBtn         : TBitBtn;
      Panel1         : TPanel;
      Org_Template   : tString;
      Size_TypeFld,
      aLength_Buffer : SmallWord;

      Result_TypeFld : AnsiChar;
      OkMask         : boolean;
      MaxWidth      : integer;

  begin
    if Application= nil
    then Application.Initialize;

    Try
      Result_TypeFld := TypeFld(Template,Size_TypeFld);
//      Forms.Application.CreateForm(TForm,Form);

      Form := TForm.Create(nil);
      with form do
      Begin
        MI_ComboBoxEx1 := nil;
        e           := nil;

        BorderIcons := [];
        FormStyle        := fsNormal;
        Form.Caption     := Title;

        If (Application.MainForm<>Nil) and (Height < Application.MainForm.Height)
        Then Position    := poOwnerFormCenter
        else Position    := poDesktopCenter;

        ParentFont       := true;

        If (Application.MainForm<>Nil)
        Then Begin
               Color            := Application.MainForm.Color;
               Font             := Application.MainForm.Font;
             End;

//        form.AutoSize := true;


        {$REGION '---> Insere um painel no topo para os bot�es.'}
          Panel1             := TPanel.Create(form);
//          Panel1.Parent      := form;
          Panel1.Align       := alTop;
          form.InsertControl(Panel1);
        {$ENDREGION}

        {$REGION '---> Insere o botao ok.'}
          BitBtn             := TBitBtn.Create(form);
//          BitBtn.Parent      := Panel1;
          BitBtn.Caption     := 'O&K';
          BitBtn.ModalResult := MrOk;
          BitBtn.Align       := AlLeft;
          Panel1.InsertControl(BitBtn);
        {$ENDREGION}

        {$REGION '---> Insere o botao cancela.'}
          BitBtn             := TBitBtn.Create(form);
//          BitBtn.Parent      := Panel1;
          BitBtn.Caption     := '&Cancela';
          BitBtn.ModalResult := MrCancel;
          BitBtn.Align       := AlLeft;
          Panel1.InsertControl(BitBtn);
        {$ENDREGION}

        {$REGION '---> Insert label'}
          L1         := TLabel.create(form);
//          L1.Parent  := form;
          L1.Caption := aLabel;
          L1.Left    := TextWidth_M(Form,'M');
          L1.Top     := Panel1.Height+L1.Height;
          form.InsertControl(L1);
        {$ENDREGION}

        Case Result_TypeFld of
          FldEnum : begin
                      {$REGION '--->'}
                        MI_ComboBoxEx1 := TMI_ComboBoxEx.Create(form);
                        Form.InsertControl(MI_ComboBoxEx1);
//                        MI_ComboBoxEx1.Parent := form;
                        MI_ComboBoxEx1.Height    := L1.Font.Height;
                        MI_ComboBoxEx1.Left      := L1.Left+Form.Canvas.TextWidth('M')*2;
                        MI_ComboBoxEx1.Top       := L1.Top+L1.Height;

                        //Inicializa a Lista de op��es;
                        MaxWidth := 0;
                        Move(Template[2],Items,Sizeof(PSItem));
                        P := Items;
                        While (P<>nil) do
                        begin
                           if (p.Value<>nil) and (p.Value^ <>'')
                           then Begin
                                  MI_ComboBoxEx1.AddValue(scg(p.Value^));

                                  if MaxWidth < Form.Canvas.TextWidth(p.Value^)
                                  then MaxWidth := Form.Canvas.TextWidth(p.Value^);

                                end;
                           P := P.next;
                        end;

//                        MI_ComboBoxEx1.Width := MaxWidth * Form.Canvas.TextWidth('M');
                         MI_ComboBoxEx1.Width  := MaxWidth+Form.Canvas.TextWidth('M')*2;

//                        MI_ComboBoxEx1.Value  := Buffer;
                        MI_ComboBoxEx1.ItemIndex := StrToInt(Buffer);


                      {$ENDREGION}
                    end;
          fldSTR              , //=   'S';  //< tString Field maiúscula
          fldSTR_Minuscula    , //=   's';  //< tString Field minusculo
          fldSTRNUM           , //=   '#';  //< numeric tString Field
          fldAnsiChar         , //   =   'C';  {< AnsiCharacter Field }
          fldAnsiChar_Minuscula , //  =   'c';  {< AnsiCharacter Field }
          fldAnsiCharNUM        , //  =   '0';  {< numeric AnsiCharacter Field }
          fldAnsiCharVAL        , //  =   'N';  {< dbase formatted numeric Field }
          fldBYTE               , // =   'B';  {< byte Field }
          fldSHORTINT           , //=   'J';  {< shortint Field }
        { fldWORD               , //=  'W';}  {< word Field }
          fldSmallWORD          , //=   'W';  {< word Field NortSoft}
        { fldInteger            , //=  'I'; } {< integer Field }
          fldSmallInt           , //=   'I';  {< integer Field NortSoft}
          fldLONGINT            , //=   'L';  {< longint Field }
          fldRealNum            , //=   'R';  {< real number Field  (uses TRealNum) }
          fldRealNum_Positivo   ,
          FldData,fldLData,fld_LData
          :
                  Begin
                    {$REGION '---> TMaskEdit.Create()'}

                      If Result_TypeFld  in [FldData,fldLData,fld_LData]
                      Then Begin {$REGION '--->'}
                             while Pos('/',buffer) <> 0
                             do DELETE(buffer,Pos('/',buffer),1);

                             while Pos(' ',buffer) <> 0
                             do DELETE(buffer,Pos(' ',buffer),1);
                           {$ENDREGION}
                           end;

                      If Result_TypeFld in [fldLHora,fld_LHora]
                        Then Begin {$REGION '--->'}
                               while Pos(':',buffer) <> 0
                               do DELETE(buffer,Pos(':',buffer),1);

                               while Pos(' ',buffer) <> 0
                               do DELETE(buffer,Pos(' ',buffer),1);
                             {$ENDREGION}
                             end;

                      If Pos('`',Template) <> 0
                      Then BEGIN {$REGION '--->'}
                             Org_Template := Template;
                             WHILE (Pos('`',Template) <> 0) AND (Template<>'')
                             DO DELETE(Template,Pos('`',Template),1);
                           {$ENDREGION}
                           END
                      ELSE Begin
                             Org_Template := Template;
                           end;

                      E           := TMaskEdit.create(form);
//                      E.Parent    := form;
                      E.Height    := L1.Font.Height;

                      if Pos(CharShowPassword,Template)<>0
                      then Begin
              {$REGION ' ---> 2013/04/03 - Tarefa: A mascara de campos do tipo senha n�o est� funcionando na convers�o de mascaras de tv32 para VCL.'}
                { DONE 3 -oVers�o.9.36.26.3138>MI_InputBox_VCL_u.Template_To_EditMask -cBUG DO C�DIGO :
               2013/05/17. Criado em: 2013/04/03.
                 � PROBLEMA: A mascara de campos do tipo senha n�o est� funcionando na convers�o de mascaras de tv32 para VCL.
                     � CAUSA:
                         � Outras pessoas n�o ver a senha digitada.
                     � SOLU��O:
                         �
                }
                             e.PasswordChar := '*';
              {$ENDREGION}
              //==========================================================================================================
                           End
                      else begin
                             E.editMask  := Template_To_EditMask(Template,Size_TypeFld,aLength_Buffer,OkMask);
                             E.MaxLength := aLength_Buffer;
                             e.Text      := Buffer;
                           end;

                      E.Left      := L1.Left+Form.Canvas.TextWidth('M')*2;
                      E.Top       := L1.Top+L1.Height;

                      if okMask
                      then E.Width     := TextWidth_M(Form,Template_To_EditMask(Org_Template ,Size_TypeFld,aLength_Buffer,okMask))
                      else Begin
                             if pos('`',Org_Template )<>0
                             then E.Width := pos('`',Org_Template )* Form.Canvas.TextWidth('M')
                             else E.Width := aLength_Buffer * Form.Canvas.TextWidth('M');
                           End;

              //        E.Width := E.MaxLength * Form.Canvas.TextWidth('M');

                      if Del_SpcED(Buffer)<>''
                      then begin
                             e.ShowHint := true;
                             e.Hint := Del_SpcED(Buffer);
                           end;
                      //E.Text      := Del_SpcED(Buffer);
                      Form.InsertControl(E);

                    {$ENDREGION}
                  End;

        End;


        {$REGION '---> Insert label'}
          L2         := TLabel.create(form);
//          L2.Parent  := form;
          L2.Left      := L1.Left;
          if e<>nil
          then L2.Top       := E.Top+E.Height
          else if MI_ComboBoxEx1 <> nil
               then L2.Top       := MI_ComboBoxEx1.Top + MI_ComboBoxEx1.Height;

          form.InsertControl(L2);
        {$ENDREGION}

        if e<>nil
        then Form.ActiveControl := E
        else if MI_ComboBoxEx1<>nil
             then Form.ActiveControl := MI_ComboBoxEx1;

        AutoSize := true;
      End;

      ResultShowModal := Form.ShowModal;

      If ResultShowModal = MrOk
      Then begin
             if e<>nil
             then Result := Del_SpcED(E.Text)
             else if MI_ComboBoxEx1<>nil
             then Result := IntToStr(MI_ComboBoxEx1.ItemIndex) ;
           end;

    finally
      discard(TObject(Form));
    end;
  end;


  function InputBox_VCL(const Title,ALabel: AnsiString; Var Buff; Template: AnsiString ): Word;

      Function Command_VCL_to_TV (Const ACommand : Word):Word ;
      Begin
         Case ACommand of
           Controls.MrOk       : Result := cmOK;
           Controls.MrCancel   : Result := cmCancel;
           Controls.MrYes      : Result := cmYes;
           Controls.MrNo       : Result := cmNo;

      {    MbAbort    : Result := ;
           MbRetry    : Result := ;
           MbIgnore   : Result := ;}
           else Abort;
         end;
      end;

    Var
      Size_TypeFld : SmallWord;

     Function GetString:AnsiString;
       Var
         Result_TypeFld : AnsiChar;
     Begin

         Result_TypeFld := TypeFld(Template,Size_TypeFld);
          Case Result_TypeFld  of
            fldENUM,
             ^X,  {Boolean Especial}
            fldBOOLEAN,
            fldBYTE,
            fldSHORTINT        : Result := IntToStr(Byte(Buff));

            fldSmallWORD       : Result := IntToStr(SmallWord(Buff));
            fldSmallInt        : Result := IntToStr(SmallInt(Buff));

            fldData            : Result := Db_Datas.DateToStr(TypeData(Buff),DateMask_DD_MM_AA);
            fldLData,
            fld_LData          : Result := DateToStr(LONGINT(Buff),DateMask_DD_MM_AA);
            fldLHora,
            fld_LHora          : Result := HourToStr(LONGINT(Buff),HourMask_HH_MM,False);
            fldLONGINT         : Result := IntToStr(LONGINT(Buff));

            FldRealNum,
            FldRealNum_Positivo : begin
                                    Result := FloatToStr(TrealNum(Buff));
                                  end;

            fldReal6P,
            fldReal6PPositivo  : Begin
  //                                  Result := FloatToStr(Real(Buff)*100);
                                    Result := NumToStr(Template,Real(Buff)*100,Result_TypeFld,false);
                                    If Pos('.',Result) <> 0
                                    Then Result[Pos('.',Result)] := ',';
                                 end;
            fldReal6,
            fldReal6Positivo   : Begin
                                    Result := FloatToStr(Real(Buff));
                                 End;

            FldExtended        : Begin
                                   Result := FloatToStr(Extended(Buff));
                                 End;

            FldCheckBox,
            FldRadioButton    : Begin
                                  Result := IntToStr(SmallWord(Buff));
                                end;

            fldSTRNUM,
            fldSTR_Minuscula,
            fldSTR            : Begin
                                  Result := ShortString(Buff);
                                End;

            fldAnsiChar,
            fldAnsiChar_Minuscula,
            fldAnsiCharNUM,
            fldAnsiCharVAL        : Result := AnsiString(Buff);

                Else Begin
                     Raise TException.Create('/\/\ar/\carai',
                                         'MI_InputBox.Pas',
                                         'InputBox.GetString',
                                          ParametroInvalido);
                     End;
            end;

     end;

     Procedure PutString(VarBuff:Variant);
       Var
         S : ShortString;
         E : Extended;
         R : Real;
         Err : Integer;
     Begin

          Case TypeFld(Template,Size_TypeFld) of
            fldENUM,
             ^X,  {Boolean Especial}
            fldBOOLEAN,
            fldBYTE,
            fldSHORTINT        : Byte(Buff)      := StrToInt(DeleteMask(VarBuff,['0'..'9',',']));

            fldSmallWORD       : SmallWord(Buff) := StrToInt(DeleteMask(VarBuff,['0'..'9',',']));
            fldSmallInt        : SmallInt(Buff)  := StrToInt(DeleteMask(VarBuff,['0'..'9',',']));
            fldLONGINT         : LONGINT(Buff)   := StrToInt(DeleteMask(VarBuff,['0'..'9',',']));

            fldData            : TypeData(Buff) := StrToDate(VarBuff,DateMask_DD_MM_AA)^;
            fldLData,
            fld_LData          : Longint(Buff) := PackDate(VarBuff,DateMask_DD_MM_AA);
            fldLHora,
            fld_LHora          : Longint(Buff) := StrToHour(VarBuff,HourMask_HH_MM);// Falta implementar esta funcao.

            FldRealNum,
            FldRealNum_Positivo: begin
                                   TRealNum(Buff) := StrToFloat(DeleteMask(VarBuff,['0'..'9',',']));
                                 end;

            fldReal6P,
            fldReal6PPositivo  : Begin
  //                                 Real(Buff) := VarBuff/100;
  {                                 S := VarBuff;
                                   If Pos(',',S) <> 0
                                   Then S[Pos(',',S)] := '.';}

                                   {$I-}
  //                                 Val(S,R,Err);
                                   {$I+}
  //                                 VarBuff := FDelSpc(S);

                                   Real(Buff) := StrToFloat(DeleteMask(VarBuff,['0'..'9',',']));

  //                                 R := StrToFloat(S)/100;
  //                                 R := STRealNum(Real(Buff),Length(FDelSpc(Template)),2);

                                   Real(Buff) := Real(Buff)/100;
                                 end;

            fldReal6,
            fldReal6Positivo   : Real(Buff) := StrToFloat(DeleteMask(VarBuff,['0'..'9',',']));

            FldExtended       : Extended(Buff) := StrToFloat(DeleteMask(VarBuff,['0'..'9',',']));

            FldCheckBox,
            FldRadioButton    : Begin
                                  SmallWord(Buff) := StrToInt(DeleteMask(VarBuff,['0'..'9',',']));
                                end;

            fldSTRNUM,
            fldSTR_Minuscula,
            fldSTR            : ShortString(Buff) := VarBuff;

            fldAnsiChar,
            fldAnsiChar_Minuscula,
            fldAnsiCharNUM,
            fldAnsiCharVAL        : AnsiString(Buff) := VarBuff;

                Else Begin
                     Raise TException.Create('/\/\ar/\carai',
                                         'MI_InputBox.Pas',
                                         'InputBox.PutString',
                                          ParametroInvalido);
                     End;
            end;


     end;

    Var
  //    VarBuff : Variant;
      VarBuff : AnsiString;
      OkValid : Boolean;
  Begin
    VarBuff := scg(GetString);
    Repeat
      OkValid := true;
      Result  := -1;
      Try // Except
          VarBuff := VCL_InputBox(Title,ALabel,VarBuff,Result,Template);
          Result := Command_VCL_to_TV(Result); //Del_SpcED
          If Result = CmOk
          Then PutString(Sgc(VarBuff));

      Except
        OkValid := false;
  {       Raise TException.Create('/\/\ar/\carai',
                                     'MI_InputBox.Pas',
                                     'InputBox',
                                     'Excessao inesperada!!!');

  }
      end;
    Until  OkValid or (Result = CmCancel);
  end;



end.




