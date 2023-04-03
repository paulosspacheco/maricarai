unit uMi_ui_maskedit_lcl;
{: A unit **@name** implementa a class TMI_MaskEdit_LCL com objetivo de ligar os campo tipo TDMXField rec com o
   componente TMaskEdit do Lazarus.

   - **VERSÃO**
     - Alpha - 0.7.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/mi_maskedit_lcl_u.pas">mi_maskedit_LCL_u.pas</a>)

   - **PENDÊNCIAS**
     - T12 A mascara sssss não está aceitando caractere maiúsculo.
     - T12 O cursor não está piscando ao receber o foco de campo tipo TMaskEditDmx
     - T12 Quando o campo é maiúscula o sistema não mostra a primeira letra.!!!!

 - **HISTÓRICO**
   - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
   - **2022-02-10**
     - Data em que essa unity foi criada.

   - **2022-02-19 15:00**
     - Documentar essa unit.
     - Quando o campo for selecionado posicionar o cursor na posição 1.


   - **2022-02-23 08:00**
     - O método PutBuffer ou GetBuffer está deformando o dado quando o campo é do tipo alfanumérico com a
       máscara (##) # #### - ####.
       - O problema é que TMaskEditDmx estava usando formatação de um número comum e esta
         formatação é um string formatado que só aceita números.
         - Para resolver preciso:
           - Remover o tipo FldStrNum do conjunto que indica que se trata de números. ok.
           - Informar para maskEdit que não salva a máscara. ok
         -

   - **13/05/2022 09:03:47**
     - T12 A mascara de telefone está com problema.
       - O problema é está em pDmxFieldRec.PutString. O mesmo não considera a máscara do campo.
         - Solução:
           - Em putBuffer excluir a mascara do campo Text antes de enviar para pDmxFieldRec.AsString

   - **26/06/2022 15:50**
       - T12 Permite mascara II,IIII e ww,www e L,LLL,LLL,LLL nos campos integer, smallword e
         logint respectivamente.

   - **29/06/2022 14:25**
         - T12 Quando o campo tem máscara os dois últimos caracteres ficam escondidos.
           - Usar o length da mascara original.
}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Mask, Windows,
{$ELSE}
  MaskEdit, LCLIntf, LCLType, LMessages,
{$ENDIF}
  SysUtils,Messages, Classes, Controls, StdCtrls, Forms,Grids ,dialogs,LResources
//  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, MaskEdit;
  ,mi.rtl.Consts.StrError
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  ,umi_ui_dmxscroller_form_lcl_attributes
;


type
  { TMI_MaskEdit_LCL }
  {:< A a classe **@name** é usada para edição do campo tipo TDmxFieldRec.

      - **NOTA**
        - As coordenadas do retângulo devem ser definidas após a criação e inclusão
          do controle em TScrollBox ou TFrame ou TForm.

        - O tipo de dados, largura, altura, mascara de edição e tipo de acesso do campo
          são obtidos do tipo TDmxFieldRec no atributo DmxScroller_Form_Lcl_attributesr.CurrentField.

        - O componentes TScrollingWinControl deve ser passado por constructor.Create(TScrollingWinControl) já inicializado.

        - A propriedade DmxScroller_Form_Lcl_attributes deve ser passada após acriação do componente.

  }
  TMI_MaskEdit_LCL = class(TMaskEdit)//,IInputText,IInputHidden,IInputPassword,IInputText)
      {: O atributo **@name** indica se o campo possui mascara ou não}
  private
      private Var _OkMask        : boolean;

//      { O atributo **@name** é atualizado em GetBuffer para que o PutBuffer set o campo pDmxFieldRec.FieldAltered}
//      Private Var _EdittextAnt : String;
      public var _StringGrid : TStringGrid;

      {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
        private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;
        private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);

        {: A propriedade **@name** contém o modelo e os cálculos do formulário}
        published property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes  write SetDmxScroller_Form_Lcl_attributes;
      {$endREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}

      Public constructor Create(AOwner:TComponent);override;

      {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
        Private Var _pDmxFieldRec : pDmxFieldRec;

        Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


        {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

           - **NOTA**
             - Esses dados devem ser criados pelo método DmxScroller_Form_Lcl_attributesr.CreateStruct(var ATemplate : TString)
        }
        public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
      {$ENDREGION}

       {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
       public Procedure PutBuffer;

       {: O método **@name** receber um string com mascara e retorna um string só com números}
       private Function GeTDmxFieldRecNumber(S:AnsiString):AnsiString;

       {: O método **@name** receber um string com mascara e retorna um string sem a mascara}
       private Function GeTDmxFieldRecUnMask(S:AnsiString):AnsiString;

       {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
       Public Procedure GetBuffer;

       {: O método **@name** seleciona todas as letras ou número do controle focado. }
       Protected procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

       {: O método **@name** ao receber o foco executa os métodos GetBuffer e pDmxFieldRec.DoOnEnter(Self).}
       Protected procedure DoOnEnter(Sender: TObject);

       {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
       Protected procedure DoOnExit(Sender: TObject);

       {: O método **@name** edita os campos números de 1 a 10 bytes}
       Protected procedure DoEditNumberKeyPress(Sender: TObject; var Key: char);

       //procedure DoOnKeyDown(Sender: TObject; var Key: system.Word; Shift: TShiftState);

       {: O método **@name** não usado por enquanto???}
       procedure DoOnKeyPress(Sender: TObject; var Key: system.Char);

       {: O método **@name** executa o método setFocus se puder.}
//       Protected procedure Select;


// ===================================================================================================
{$REGION ' ---> Implementação da Class THTML_Base,IInpuText <---'}
      {: O método **@name** captura a documentação do campo definido na classe onde o campo for criado.

         - Com o programa **pasdoc** a documentação não precisa está no arquivo de recursos,
           por isso, para obter o link para o campo é preciso saber apenas o endereço do link.
      }
      FUNCTION GetHelpCtx_Hint(): AnsiString; // Documento do objeto.

      /// <since>
      /// Construção da propriedade Value()
      /// //= string value passed to form processing application
      /// </since>
      //FUNCTION GetValue_IInputText(): Variant;// =string value passed to form processing application
      //PROCEDURE SetValue_IInputText(wValue: Variant);


      /// <since>
      /// Construção da propriedade Size()
      /// =n specifies the number of AnsiCharacters to display
      /// <since>
      FUNCTION GetSize(): Variant;

      /// <since>
      /// Construção da propriedade Size()
      /// =n specifies the number of AnsiCharacters to display
      /// <since>
      PROCEDURE SetSize(aSize: Variant);
      procedure SetAlias(const aAlias: AnsiString);


        {$REGION ' ---> Property vidis_OnEnter : Boolean '}
          //strict Private Var _vidis_OnEnter : Boolean;
          //strict Private Function  Getvidis_OnEnter : Boolean;
          //strict Private Procedure Setvidis_OnEnter (avidis_OnEnter : Boolean );
          Public
                      ///<since>
                      ///  . Propriedade vidis_OnEnter : Boolean
                      ///  . Objetivo: Usado para evitar reentrancia do evento DoOnEnter()
                      ///</since>
//          property  vidis_OnEnter: Boolean Read Getvidis_OnEnter   Write  Setvidis_OnEnter;
        {$ENDREGION}

        {$REGION ' ---> Property vidis_OnExit : Boolean '}
          //strict Private Var _vidis_OnExit : Boolean;
          //strict Private Function  Getvidis_OnExit : Boolean;
          //strict Private Procedure Setvidis_OnExit (avidis_OnExit : Boolean );
          Public
                      ///<since>
                      ///  . Propriedade vidis_OnExit : Boolean
                      ///  . Objetivo: Usado para evitar reentrancia do evento DoOnExit()
                      ///</since>
//          property  vidis_OnExit: Boolean Read Getvidis_OnExit   Write  Setvidis_OnExit;
        {$ENDREGION}

//        Protected Function Get_ITable : ITable;
        //Protected FUNCTION GetID_Dynamic: AnsiString;
        Protected FUNCTION GetName(): AnsiString; // =name specifies the name of this input object
        Protected FUNCTION GetAlias: AnsiString;
        //Protected Public Function GetHTMLContent : AnsiString;
        //
        //Protected Function GetNoTab():Variant;Virtual;// specifies that this element is not part of the tabbing order
        //Protected Function GetTabOrder():Variant;Virtual;//=n specifies the position of this element in the tabbing order
        //Protected  Function  GetModule : Byte; ///<since>Pode ser redefinido para ler o módulo informando na class dona da atual.</since>
        //protected Function GetHelpCtx_StrModule :AnsiString;
        //protected Function GetHelpCtx_StrCommand: AnsiString;
        //protected Function GetHelpCtx_StrCommand_Topic: AnsiString;
        //
        ////protected Function GetHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;
        //
        //Protected Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;
        //
        //Protected procedure Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File
        //                       (a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);
        //protected Function GetHelpCtx_StrCurrentCommand_Topic: AnsiString;
        //protected Function GetHelpCtx_StrCurrentCommand_Topic_Content:AnsiString;
        //protected Function GetHelpCtx_Historico : AnsiString;
        //Protected Function GetHelpCtx_Porque : AnsiString;
        //Protected Function GetHelpCtx_Onde : AnsiString;
        //Protected Function GetHelpCtx_Como : AnsiString;
        //Protected Function GetHelpCtx_Quais : AnsiString;
{$ENDREGION}
// ===================================================================================================

      protected procedure WMPaint(var Message: TLMPaint); message LM_PAINT;

   end;

procedure Register;

implementation

procedure Register;
begin
  {$I umi_ui_maskedit_lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl', [TMI_MaskEdit_LCL]);
end;


{ TMI_MaskEdit_LCL }
procedure TMI_MaskEdit_LCL.WMPaint(var Message: TLMPaint);
begin
  //if not (csFocusing in ControlState)
  //then GetBuffer;
  inherited WMPaint(Message);
end;

constructor TMI_MaskEdit_LCL.Create(AOwner: TComponent);
begin
  inherited create(aOwner);
  if aOwner is TStringGrid
  then _StringGrid := aOwner as TStringGrid;
  AutoSize   := false;
  AutoSelect := true;
  SpaceChar  := '_';
end;

//procedure TMI_MaskEdit_LCL.Select;
//begin
//  if pDmxFieldRec <> nil
//  Then begin
//          if Self.Parent.Visible and Self.Enabled
//
//             and (not pDmxFieldRec.vidis_OnEnter)
//             and (not pDmxFieldRec.vidis_OnExit)
//          then Self.SetFocus;
//     end;
//
//
//end;

procedure TMI_MaskEdit_LCL.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;

procedure TMI_MaskEdit_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil)
  then //with DmxScroller_Form_Lcl_attributes do
     Try
        DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec;
        name := DmxScroller_Form_Lcl_attributes.GetNameValid(DmxScroller_Form_Lcl_attributes.CurrentField.FieldName);

        if DmxFieldRec.HelpCtx_Hint<>''
        then hint := DmxFieldRec.HelpCtx_Hint
        else hint := DmxFieldRec.FieldName;

        if hint <> ''
        Then ShowHint := true
        else ShowHint := False;

        if (upcase(DmxFieldRec.CharShowPassword) = DmxScroller_Form_Lcl_attributes.CharShowPassword)
        then Self.PasswordChar := DmxScroller_Form_Lcl_attributes.CharShowPasswordChar;

        {$REGION '---> Seta tipo de acesso'}
           with DmxScroller_Form_Lcl_attributes do
           begin
             if ((DmxFieldRec^.access and accNormal)<>0)
             then begin
                    Self.Visible  := true;
                    Self.TabStop  := True;
                    Self.Enabled  := True;
                    Self.ReadOnly := false;
                  end;

             if ((DmxFieldRec^.access and accSkip)<>0)
             then begin
                    Self.Visible := true;
                    Self.TabStop  := False;
                    Self.Enabled  := false;
                    Self.ReadOnly := true;
                  end;

             if ((DmxFieldRec^.access and accReadOnly)<>0)
             then begin
                    Self.Visible  := true;
                    Self.TabStop  := True;
                    Self.Enabled  := false;
                    Self.ReadOnly := true;
                  end;

             if ((DmxFieldRec^.access and  accHidden)<>0)
             then Visible := false;

           end;
        {$ENDREGION}


  //          OnMouseDown := DoOnMouseDown;
        OnEnter := DoOnEnter;
        onExit  := DoOnExit;
  //          onKeyDown := DoOnKeyDown;
        if DmxFieldRec^.IsNumber
        then begin
               OnKeyPress := DoEditNumberKeyPress;
               //Edittext := '0';
               text := '0';
               editMask   := '';//Entrada de dados numérica é no evento DoEditNumberKeyPress;
               _OkMask := false;
               DmxFieldRec.OkSpc := false;

               MaxLength := DmxFieldRec.GetMaxLength();
               BiDiMode := bdRightToLeft; //Alinha o MaskEdit2 do lado direito do retângulo.
             end
        else begin
               with DmxFieldRec^,DmxScroller_Form_Lcl_attributes do
                  editMask  := Get_MaskEdit_LCL(Template_org, _OkMask);

               MaxLength := DmxFieldRec.TrueLen; //pDmxFieldRec^.ColumnWid;

               Edittext := '';
               DmxFieldRec^.OkSpc := false;
  //                 OnKeyPress := DoOnKeyPress;
             end;


  //          Self.Alignment := taCenter;
  //          Self.Alignment := taRightJustify;
        Self.Alignment := taLeftJustify;

        if Owner is TScrollingWinControl
        then Begin
                AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
//                Width      := (DmxScroller_Form_Lcl_attributes.WidthChar * (DmxFieldRec.ShownWid))+4;
                Width  := (Owner as TScrollingWinControl).Canvas.TextWidth(Copy(DmxFieldRec^.Template_org,1,DmxFieldRec.ShownWid))+15;
                Constraints.MinWidth := width;
                Constraints.MaxWidth := Constraints.MinWidth;
                Constraints.MaxHeight:= DmxScroller_Form_Lcl_attributes.HeightChar;
                Constraints.MinHeight:= Constraints.MaxHeight;
             end;

      Finally

  //          pDmxFieldRec.Link_IInputText := Self;

      end;
end;


{
  procedure TMI_MaskEdit_LCL.DoOnKeyDown(Sender: TObject; var Key: system.Word; Shift: TShiftState);
    var
      ch    : AnsiChar;
      event :TEvent;
      str   : AnsiString;
      wCurPos,wSelEnd:Integer;
  begin
    inherited;
    if pDmxFieldRec <> nil
    then begin
           Event.What    := evKeyDown;
           Event.InfoPtr := nil;
           event.KeyCode := smallword(key);
           event.ShiftState   := 0;//
           wCurPos := GetSelStart;
           wSelEnd := GetSelLength;

           (pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).CurPos := wCurPos+1;
           (pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).SelEnd := wSelEnd+1;
           Self.PutBuffer;
           pDmxFieldRec.owner.HandleEvent(event);
           Self.GetBuffer;
           Self.SetSel(wCurPos,wSelEnd);
         end;
  end;
}

procedure TMI_MaskEdit_LCL.DoOnKeyPress(Sender: TObject; var Key: system.Char);
   var
      event :TDmxScroller_Form_Lcl_attributes.TEvent;
      str   : AnsiString;
      wCurPos,wSelStart,wSelEnd:Integer;
  begin

{    if key = #9
    then begin
           Exit;
         end;
}

{    if key= #13
    then begin
//           Self.SelectNext(ActiveControl, true, true);
         end;
}
{    if Key = #13
     then begin
            Key := #0;
            Perform(WM_KeyDown,VK_Tab,0);
            exit;
          end;  }


    //pesquisa interativa com banco de dados nos campos ComboBox.
    with TDmxScroller_Form_Lcl_attributes do
    begin
      if (DmxFieldRec <> nil) and (DmxFieldRec.TypeCode in [fldSTR,fldSTR_Minuscula,fldAnsiChar,fldAnsiChar_Minuscula ])
      then begin
             Event.What    := evKeyDown;
             Event.InfoPtr := nil;
             event.AnsiCharCode := AnsiChar(key);
             event.ShiftState   := 0;//
             wSelStart := GetSelStart;
             wSelEnd   := wSelStart + GetSelLength;

             DmxFieldRec.CurPos   := wSelStart;
             DmxFieldRec.SelStart := wSelStart;
             DmxFieldRec.SelEnd   := wSelEnd;

              Self.PutBuffer;

             DmxScroller_Form_Lcl_attributes.HandleEvent(event);

             str := DmxFieldRec.AsString;
             if length(text)+1 <> length(str)
             then begin
                    str := copy(str,wSelStart+2,length(str)-DmxFieldRec.SelStart);
                    if length(str) >= 1
                    then begin
                          getBuffer;
                          SelStart  := DmxFieldRec.SelStart;
                          SelLength := length(str);
                          SetFocus();
                          key := #0;
                         end;
                  end;


  //           Self.GetBuffer;
  //           Self.SetSel( (pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).CurPos , (pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).selEnd);
           end;

      end;


  end;

Function TMI_MaskEdit_LCL.GeTDmxFieldRecNumber(S:AnsiString):AnsiString;
begin
  if DmxFieldRec <> nil then
  begin
      with TDmxScroller_Form_Lcl_attributes do
        if DmxFieldRec.IsNumber
        then begin
               result := trim(s);
                //Excluir máscara porque Text não aceita números formatados
                //result := DeleteMask(S,['0'..'9','-','+',showDecPt]);
                //if pos(showDecPt ,result)<>0
                //then begin
                //       result := Change_AnsiChar(result,showDecPt,DecPt);
                //     end;
             end
        else Raise TException.Create(TStrError.ErrorMessage5('mi.ui.lcl',
                                                                     'mi_ui_maskedit_LCL',
                                                                     'TMI_MaskEdit_LCL',
                                                                     'GeTDmxFieldRecNumber','Chamada inválida ao método.'));
  end
  else Result := '';
end;

Function TMI_MaskEdit_LCL.GeTDmxFieldRecUnMask(S:AnsiString):AnsiString;
begin
  if DmxFieldRec <> nil then
  begin
    with TDmxScroller_Form_Lcl_attributes do
    begin
        if DmxFieldRec^.IsNumber
        then begin
               result := GeTDmxFieldRecNumber(s)
             end
             else if DmxFieldRec^.IsData
                  then begin
                         while Pos('/',s) <> 0
                         do DELETE(s,Pos('/',s),1);

                         while Pos(' ',s) <> 0
                         do DELETE(s,Pos(' ',s),1);
                       end
                  else if DmxFieldRec^.IsHora
                       then begin
                            end
                            else if DmxFieldRec^.IsHora
                                 then begin
                                        while Pos(':',s) <> 0
                                        do DELETE(s,Pos(':',s),1);

                                        while Pos(' ',s) <> 0
                                        do DELETE(s,Pos(' ',s),1);
                                      end
                                      else begin
                                             result := DeleteMask(S,DmxFieldRec^.Template_org);
                                           end;
    end;
  end
  else Result := '';
end;

procedure TMI_MaskEdit_LCL.GetBuffer;
 Var
   waccess : Byte;
   s : string;
begin
  if DmxFieldRec <> nil then
    with TDmxScroller_Form_Lcl_attributes do
    try

     waccess := DmxFieldRec.SetAccess(AccNormal);

     if DmxFieldRec.isNumber
     Then S := GeTDmxFieldRecNumber(DmxFieldRec.AsString)
     else begin
            if _OkMask
            then begin
                    s := AddMask(DmxFieldRec.AsString,DmxFieldRec.Template_org)
                 end
            else S := DmxFieldRec.AsString;
          end;

     text := s;

    finally
      DmxFieldRec.SetAccess(waccess);
    end;
end;

procedure TMI_MaskEdit_LCL.PutBuffer;
 Var
   waccess : Byte;
   S : string;
begin
  if DmxFieldRec <> nil then
    with TDmxScroller_Form_Lcl_attributes do
    try
       waccess := DmxFieldRec.SetAccess(AccNormal);

       s := GeTDmxFieldRecUnMask(text);
       DmxFieldRec^.AsString := s;

       //if IsValidate then
         //if not pDmxFieldRec.Valid(cmDMX_Enter)
         //then abort;
    finally
      DmxFieldRec.SetAccess(waccess);
    end;
end;

procedure TMI_MaskEdit_LCL.DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectAll;
end;

procedure TMI_MaskEdit_LCL.DoOnEnter(Sender: TObject);

//   Procedure Scroller;
//   begin
//     if Owner is TScrollingWinControl
//     then with Owner as TScrollingWinControl do
//          begin
////            ScrollInView(self);
//           Scroll_it_inview(Owner as TScrollingWinControl,self);
//          end;
//   end;

begin
  if (DmxFieldRec<>nil ) and (not DmxFieldRec.vidis_OnEnter)
  then begin
          try
           DmxFieldRec.vidis_OnEnter := true;

           DmxFieldRec.DoOnEnter(Self);
           GetBuffer;

           //Usado quando Self estiver inserido em um stringGrid
           //if _StringGrid<>nil
           //then begin
           //       Visible := true;
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //não precisa recebe o dado do arquivo.
           //     end;

          finally
            DmxFieldRec.vidis_OnEnter := false;
          end;
       end;
end;

procedure TMI_MaskEdit_LCL.DoOnExit(Sender: TObject);
begin
    if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.vidis_OnExit)
    then with TDmxScroller_Form_Lcl_attributes do
         try
           DmxFieldRec.vidis_OnExit := true;

           PutBuffer;
           DmxFieldRec.DoOnExit(Self);

           //Is isValidate then
           //if not pDmxFieldRec.Valid(cmDMX_Enter)
           //then abort;

           //if _StringGrid<>nil
           //then begin
           //        _StringGrid.Cells[_StringGrid.col,_StringGrid.row] := text; //Atualiza a visão do grid.
           //       Visible := false;
           //       //Seleciona o focus de  _StringGrid
           //       _StringGrid.SetFocus;
           //     end;

         finally
           DmxFieldRec.vidis_OnExit := False;
         end;

end;
var err:integer;
procedure TMI_MaskEdit_LCL.DoEditNumberKeyPress(Sender: TObject; var Key: char);
  var
    s : String;
  function FieldIsEditable(Field: pDmxFieldRec): boolean;
  begin
    // with DmxScroller_Form_Lcl_attributes do
    //   s := DeleteMask(text,['0'..'9']);
    //
    //while (length(s)>0) and (s[1] = '0') do
    //  system.delete(s,1,1);
    //
    with Field^ do
    result := (Field<>nil) and (Field.Access in [AccNormal]);

    //result := (Field<>nil) and (not Field.Calculated) and
    //          (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
  end;

  function FieldCanAcceptKey(Field: pDmxFieldRec; AKey: char): boolean;
  begin
    Result := FieldIsEditable(Field) and (Key in ['0'..'9',',', #8]) ;
  end;

  Var
   vChar, vDiv: TString;
   I : Integer;
   Espaco, Decimal: Integer;

begin
   if (not FieldCanAcceptKey(_pDmxFieldRec, Key))
   then Key := #0
   else  with DmxScroller_Form_Lcl_attributes do
         begin
           try

             Espaco := length(DeleteMask(DmxFieldRec.Template_org,MaskIsNumber));
             with DmxFieldRec^ do
               if pos(DecPt,Template_org)<>0
               then Decimal := length(Template_org)-pos(DecPt,Template_org)
               else Decimal := 0;

             vDiv := '1';
             For I := 1 to Decimal do
               vDiv := vDiv + '0';

               s := DeleteMask(Text,['0'..'9','.','-','+']);
               if (length(s) = espaco) and (Key <> #8 )
                  then begin
                         exit;
                       end;

               if Key = #8
               then begin
                      if (length(s) > 1)
                      then vChar := copy(s,1,(length(s)-1))
                      else begin
                             vChar := '0';
                           end;
                    end
               else vChar := copy(s,1,length(s));

              if Key <> #8  then
              begin
                if (vchar = '') or (vchar = '0')
                then vchar := Key
                else vchar := vchar + Key;
              end;

              vChar := DeleteMask(vChar,['0'..'9']);

              if vchar <> ''
              Then Begin
                      with DmxFieldRec^ do
                      begin
                        if decimal = 0
                        then begin
                               if (Upperlimit>0) then
                               begin //Controla o limite superior do campo. Só pega 1..255
                                 if (StrToInt(vchar) <= Upperlimit)
                                 then s := vchar
                                 else begin
                                        //DmxScroller_Form_Lcl_attributes.
                                        MI_MsgBox.MessageBox('ATENÇÃO',Format('Esse campo só aceita valores entre %d a %d  ',[1,Upperlimit]),mtWarning, [mbOK],mbOk);

                                        Key := #0;exit;
                                      end;
                                 end
                               else begin
                                      If IntValid(vchar,TypeCode)
                                      then s := trim(NumToStr(Template_org,StrToInt(vchar),TypeCode,OkSpc))
                                      else begin
                                             if err<>0
                                             then begin
                                                    Key := #0;exit;
                                                  end;
                                           end;
                                    end;
                             end
                        else begin
                               //  A função NumToStr não pode ser usada porque text não aceita número formatados.
                               s := trim(NumToStr(Template_org,StrToFloat(vchar)/StrToInt(vDiv),TypeCode,OkSpc));
                               //S := formatFloat('0.'+conststr(decimal,'0'),StrToFloat(vchar)/StrToInt(vDiv));
                             end;

                        text := s;
//                        writeLn(text);
                      end;
                   end;
            finally
              SelStart := length(text);
            end;
           Key := #0;
         end;
end;



  // Construção da propriedade HelpCtx_Hint()
  function TMI_MaskEdit_LCL.GetAlias: AnsiString;
  begin
    if DmxFieldRec <> nil
    Then result := Self.DmxFieldRec.alias
    else result := '';
  end;

function TMI_MaskEdit_LCL.GetHelpCtx_Hint: AnsiString; // Documento do objeto.
  BEGIN
    Result := Hint;
  END;

  //function TMI_MaskEdit_LCL.GetHelpCtx_Historico: AnsiString;
  //begin
  //  Result := pDmxFieldRec.HelpCtx_Historico;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Porque: AnsiString;
  //begin
  //   Result := '';//(pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Porque;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Onde: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Onde;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Como: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Como;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Quais: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Quais;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_StrCommand: AnsiString;
  //begin
  //  result := '';//pDmxFieldRec.HelpCtx_StrCommand;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_StrCommand_Topic: AnsiString;
  //begin
  //  result := '';//Self.pDmxFieldRec.HelpCtx_StrCommand_Topic;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_StrCurrentCommand_Topic: AnsiString;
  //begin
  //  result := '';//Self.pDmxFieldRec.HelpCtx_StrCurrentCommand_Topic;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;
  //begin
  //   result := '';//Self.pDmxFieldRec.HelpCtx_StrCurrentCommand_Topic_Content;
  //end;

  Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;
  begin
    result := false;//Self.pDmxFieldRec.Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
  end;

  //function TMI_MaskEdit_LCL.GetHelpCtx_StrModule: AnsiString;
  //begin
  //  result := '';//Self.pDmxFieldRec.HelpCtx_StrModule;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHTMLContent: AnsiString;
  //begin
  //  result := hint;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetID_Dynamic: AnsiString;
  //begin
  //  result := Self.pDmxFieldRec.ID_Dynamic;
  //end;

// ===================================================================================================
{$REGION '---> Customizações da classe TMI_MaskEdit_LCL para implementar a  Interface IInputText <---'}
  // ===================================================================================================

  procedure TMI_MaskEdit_LCL.SetAlias(const aAlias: AnsiString);
  BEGIN
    Caption := aAlias;
  END;


  //  function TMI_MaskEdit_LCL.GetValue_IInputText: Variant; // =string value passed to form processing application
  //BEGIN
  //  Result := Text;
  //END;

  //function TMI_MaskEdit_LCL.Getvidis_OnEnter: Boolean;
  //begin
  //
  //end;
  //
  //function TMI_MaskEdit_LCL.Getvidis_OnExit: Boolean;
  //begin
  //
  //end;

  //function TMI_MaskEdit_LCL.Get_ITable: ITable;
  //begin
  //  Result := nil;
  //end;

  //function TMI_MaskEdit_LCL.Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean;
  //begin
  //
  //end;

//function TMI_MaskEdit_LCL.IsInputCheckbox: IInputCheckbox;
//  begin
//    Result := nil;
//  end;
//
//  function TMI_MaskEdit_LCL.IsInputHidden: IInputHidden;
//  begin
//    if Self.Visible
//    then Result := nil
//    else Result := Self;
//  end;
//
//  function TMI_MaskEdit_LCL.isInputPassword: IInputPassword;
//  begin
//     if (upcase(pDmxFieldRec.CharShowPassword) = CharShowPassword)
//     then Result := Self
//     else Result := nil;
//  end;
//
//  function TMI_MaskEdit_LCL.IsInputRadio: IInputRadio;
//  begin
//    Result := nil;
//  end;
//
//  function TMI_MaskEdit_LCL.IsInputText: IInputText;
//  begin
//    result := Self;
//  end;
//
//  function TMI_MaskEdit_LCL.IsSelect: ISelect;
//  begin
//    Result := nil;
//  end;
//
//  function TMI_MaskEdit_LCL.IsTable: ITable;
//  begin
//    Result := nil;
//  end;

  //procedure TMI_MaskEdit_LCL.SetValue_IInputText(wValue: Variant);
  //BEGIN
  //  Text := Scg(wValue);
  //END;
  //
  //procedure TMI_MaskEdit_LCL.Setvidis_OnEnter(avidis_OnEnter: Boolean);
  //begin
  //  pDmxFieldRec.vidis_OnEnter := avidis_OnEnter;
  //end;
  //
  //procedure TMI_MaskEdit_LCL.Setvidis_OnExit(avidis_OnExit: Boolean);
  //begin
  //  pDmxFieldRec.vidis_OnExit := avidis_OnExit;
  //end;

//procedure TMI_MaskEdit_LCL.Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(
//  a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);
//begin
//
//end;


  //function TMI_MaskEdit_LCL.GetModule: Byte;
  //begin
  //  result := pDmxFieldRec.module;
  //end;

  function TMI_MaskEdit_LCL.GetName: AnsiString;
  begin
    Result := name;
  end;

  //function TMI_MaskEdit_LCL.GetNoTab: Variant;
  //begin
  //
  //end;


  function TMI_MaskEdit_LCL.GetSize: Variant;
  BEGIN
    Result := Width;
  END;

  //function TMI_MaskEdit_LCL.GetTabOrder: Variant;
  //begin
  //end;

/// <since>
  /// Construção da propriedade Size()
  /// =n specifies the number of AnsiCharacters to display
  /// <since>
    procedure TMI_MaskEdit_LCL.SetSize(aSize: Variant);
  BEGIN
    Width := aSize;
  END;
{$ENDREGION '---> Customizações da classe TMI_MaskEdit_LCL para implementar a  Interface IInputText <---'}
  // ===================================================================================================


end.
