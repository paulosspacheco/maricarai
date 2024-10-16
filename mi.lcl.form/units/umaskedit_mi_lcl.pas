unit uMaskedit_mi_lcl;
{: A unit **@name** implementa a class TMI_MaskEdit_LCL com objetivo de ligar os campo tipo TDMXField rec com o
   componente TMaskEdit do Lazarus.

   - **VERSÃO**
     - Alpha - 1.0.0

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
           - Remover o tipo fldStrNumber do conjunto que indica que se trata de números. ok.
           - Informar para maskEdit que não salva a máscara. ok
         -

   - **13/05/2022 09:03:47**
     - T12 A mascara de telefone está com problema.
       - O problema é está em pDmxFieldRec.PutString. O mesmo não considera a máscara do campo.
         - Solução:
           - Em putBuffer excluir a mascara do campo Text antes de enviar para pDmxFieldRec.AsString

   - **26/06/2022 15:50**
       - T12 Permite mascara II,IIII e ww,www e L,LLL,LLL,LLL nos campos integer, SmallWord e
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
  MaskEdit, LCLIntf, LCLType, LMessages,db,
{$ENDIF}
  SysUtils,Messages, Classes, Controls, StdCtrls, Forms,Grids ,dialogs,LResources
//  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, MaskEdit;
  ,mi.rtl.Consts.StrError
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  //,umi_lcl_ui_dmxscroller_form_attributes
  ,uMi_lcl_ui_Form_attributes
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

  { TMaskEdit_mi_LCL }

  TMaskEdit_mi_LCL = class(TMaskEdit)//,IInputText,IInputHidden,IInputPassword,IInputText)
      {: O atributo **@name** indica se o campo possui mascara ou não}
  private
      private Var _OkMask : boolean ;

//      { O atributo **@name** é atualizado em GetBuffer para que o PutBuffer set o campo pDmxFieldRec.FieldAltered}
//      Private Var _EdittextAnt : String;
      public var _StringGrid : TStringGrid;

      {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
        private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
        private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);

        {: A propriedade **@name** contém o modelo e os cálculos do formulário}
        published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes  write SetMi_lcl_ui_Form_attributes;
      {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

      Public constructor Create(AOwner:TComponent);override;overload;
      public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;

      public Destructor Destroy;Override;

      {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
        Private Var _pDmxFieldRec : pDmxFieldRec;

        {$REGION ' # Propriedade DispFormat '}
          private var _DispFormat : AnsiString;
   //       procedure SetDispFormat(aDispFormat: String);
          procedure SetDispFormat(AValue: AnsiString);
          {: A propriedade **@name** a mascara de saída usada para setar Field.DisplayFormat }
          public property DispFormat : AnsiString Read _DispFormat write SetDispFormat;
        {$endREGION ' # Propriedade DispFormat '}

        Private Procedure SetDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


        {: O atributo **@name** fornece os dados necessários para criar o componente TMaskEdit_mi_LCL.

           - **NOTA**
             - Esses dados devem ser criados pelo método Mi_lcl_ui_Form_attributesr.CreateStruct(var ATemplate : TString)
        }
        public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SetDmxFieldRec;
      {$ENDREGION}

       {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
       public Procedure PutBuffer;

       {: O método **@name** receber um string com mascara e retorna um string só com números}
       private Function GetDmxFieldRecNumber(S:AnsiString):AnsiString;

       {: O método **@name** receber um string com mascara e retorna um string sem a mascara}
       private Function GeTDmxFieldRecUnMask(S:AnsiString):AnsiString;

       {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
       Public Procedure GetBuffer;

       {: O método **@name** seleciona todas as letras ou número do controle focado. }
       Protected procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

       //{: O método **@name** ao receber o foco executa os métodos GetBuffer e pDmxFieldRec.DoOnEnter(Self).}
       //Protected procedure DoOnEnter(Sender: TObject);

       {: O método **@name** ao receber o foco executa os métodos GetBuffer e pDmxFieldRec.DoOnEnter(Self).}
       protected procedure DoEnter; override;

       public procedure SelectAll; reintroduce;

       //{: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
       //Protected procedure DoOnExit(Sender: TObject);
       {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
       protected procedure DoExit; override;


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


        {$REGION ' ---> Property reintrance_OnEnter : Boolean '}
          //strict Private Var _reintrance_OnEnter : Boolean;
          //strict Private Function  Getreintrance_OnEnter : Boolean;
          //strict Private Procedure Setreintrance_OnEnter (areintrance_OnEnter : Boolean );
          Public
                      ///<since>
                      ///  . Propriedade reintrance_OnEnter : Boolean
                      ///  . Objetivo: Usado para evitar reentrancia do evento DoOnEnter()
                      ///</since>
//          property  reintrance_OnEnter: Boolean Read Getreintrance_OnEnter   Write  Setreintrance_OnEnter;
        {$ENDREGION}

        {$REGION ' ---> Property reintrance_OnExit : Boolean '}
          //strict Private Var _reintrance_OnExit : Boolean;
          //strict Private Function  Getreintrance_OnExit : Boolean;
          //strict Private Procedure Setreintrance_OnExit (areintrance_OnExit : Boolean );
          Public
                      ///<since>
                      ///  . Propriedade reintrance_OnExit : Boolean
                      ///  . Objetivo: Usado para evitar reentrancia do evento DoOnExit()
                      ///</since>
//          property  reintrance_OnExit: Boolean Read Getreintrance_OnExit   Write  Setreintrance_OnExit;
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
     private _reintranceSetPDmxFieldRec:Boolean;

     public function GetHTMLContent: String;
   end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I umi_ui_maskedit_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl', [TMaskEdit_mi_LCL]);
//end;


{ TMaskEdit_mi_LCL }
procedure TMaskEdit_mi_LCL.WMPaint(var Message: TLMPaint);
begin
  //if not (csFocusing in ControlState)
  //then GetBuffer;
  inherited WMPaint(Message);
end;

function TMaskEdit_mi_LCL.GetHTMLContent: String;
  var
    Template :String = '<input type="text" class="form-field" id="~FieldName" name="~FieldName" placeholder="~FieldName" data-mask="~data-mask" data-mask-type="~datamask-type" style="top: ~toppx; left: ~leftpx; width: ~widthpx;"/>';
begin
  result :=  template;
  with DmxFieldRec^ do
  begin
    Result := StringReplace(Result, '~top'      , intToStr(top)   , [rfReplaceAll]);
    Result := StringReplace(Result, '~left'      , intToStr(left)  , [rfReplaceAll]);
    Result := StringReplace(Result, '~width'    , intToStr(width) , [rfReplaceAll]);
    Result := StringReplace(Result, '~FieldName', FieldName       , [rfReplaceAll]);
    Result := StringReplace(Result, '~data-mask', Template_org    , [rfReplaceAll]);
    Result := StringReplace(Result, '~datamask-type', TypeCode   , [rfReplaceAll]);
  end;
end;

constructor TMaskEdit_mi_LCL.Create(AOwner: TComponent);
begin
  inherited create(aOwner);
  if aOwner is TStringGrid
  then _StringGrid := aOwner as TStringGrid;
  AutoSize   := false;
  AutoSelect := true;
  ParentFont:=true;
end;

constructor TMaskEdit_mi_LCL.Create(aOwner: TComponent;
  aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(aOwner);
  Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
end;

destructor TMaskEdit_mi_LCL.Destroy;
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited Destroy;
end;

procedure TMaskEdit_mi_LCL.SetDispFormat(AValue: AnsiString);
begin
  if _DispFormat=AValue then Exit;
  _DispFormat:=AValue;
end;

procedure TMaskEdit_mi_LCL.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
  then SetDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;

//procedure TMaskEdit_mi_LCL.SetDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
////  var s : AnsiString;
//begin
//  if _pDmxFieldRec=apDmxFieldRec then Exit;
//
//  _pDmxFieldRec := apDmxFieldRec;
//  if  Assigned(Mi_lcl_ui_Form_attributes) and
//      Assigned(Mi_lcl_ui_Form_attributes.DmxScroller_Form) and
//      Assigned(DmxFieldRec) then
//  with Mi_lcl_ui_Form_attributes do
//  begin
//    self.SpaceChar  := DmxScroller_Form.SpaceChar;
//    DmxScroller_Form.CurrentField := DmxFieldRec;
//    name := DmxScroller_Form.GetNameValid(DmxScroller_Form.CurrentField.FieldName);
//
//    if DmxFieldRec.HelpCtx_Hint<>''
//    then hint := DmxFieldRec.HelpCtx_Hint
//    else hint := DmxFieldRec.FieldName;
//
//    if hint <> ''
//    Then ShowHint := true
//    else ShowHint := False;
//
//    if (upcase(DmxFieldRec.CharShowPassword) = DmxScroller_Form.CharShowPassword)
//    then Self.PasswordChar := DmxScroller_Form.CharShowPasswordChar;
//
//    {$REGION '---> Seta tipo de acesso'}
//       Self.Visible  := true;
//       Self.TabStop  := True;
//       Self.Enabled  := True;
//       Self.ReadOnly := false;
//
//       if ((DmxFieldRec^.access and accSkip)<>0)
//       then Self.TabStop  := False;
//
//       if ((DmxFieldRec^.access and accReadOnly)<>0)
//       then Self.ReadOnly := true;
//
//       if ((DmxFieldRec^.access and  accHidden)<>0)
//       then Visible := false;
//    {$ENDREGION}
//
////          OnMouseDown := DoOnMouseDown;
////    OnEnter := DoOnEnter;
////    onExit  := DoOnExit;
//
////          onKeyDown := DoOnKeyDown;
//    if DmxFieldRec^.IsNumber
//    then begin
//           OnKeyPress := DoEditNumberKeyPress;
//           text := '0';
//           editMask   := '';//Entrada de dados numérica é no evento DoEditNumberKeyPress;
//           _OkMask := false;
//           DmxFieldRec.OkSpc := false;
//
//           MaxLength := DmxFieldRec.GetMaxLength();
//           BiDiMode := bdRightToLeft; //Alinha o MaskEdit2 do lado direito do retângulo.
//         end
//    else begin
//           with DmxFieldRec^,DmxScroller_Form do
//              editMask  := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
//
//           MaxLength := DmxFieldRec.TrueLen; //pDmxFieldRec^.ColumnWid;
//           Edittext := '';
//           DmxFieldRec^.OkSpc := false;
////                 OnKeyPress := DoOnKeyPress;
//         end;
//
//
////          Self.Alignment := taCenter;
////          Self.Alignment := taRightJustify;
//    Self.Alignment := taLeftJustify;
//
//    if Owner is TScrollingWinControl
//    then Begin
//            Width  := ((DmxScroller_Form.WidthChar) * (DmxFieldRec.ShownWid))+15;
//            Height := DmxScroller_Form.HeightChar;
//
//            AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
//            Constraints.MinWidth := width;
//            Constraints.MaxWidth := Constraints.MinWidth+4;
//
//            Constraints.MinHeight:= Height;
//            Constraints.MaxHeight:= Constraints.MinHeight+4;
//         end;
//  end;
//end;
procedure TMaskEdit_mi_LCL.SetDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
begin
  _pDmxFieldRec := apDmxFieldRec;
  if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil) then
  with Mi_lcl_ui_Form_attributes do
  Try
    self.SpaceChar  := DmxScroller_Form.SpaceChar;
    _reintranceSetPDmxFieldRec := true;
    DmxFieldRec.reintrance_OnEnter := true;
    DmxScroller_Form.CurrentField := DmxFieldRec;
    name := DmxScroller_Form.GetNameValid(DmxFieldRec.FieldName);
    Caption := DmxFieldRec.FieldName;
    if DmxFieldRec.HelpCtx_Hint<>''
    then hint := DmxFieldRec.HelpCtx_Hint
    else hint := DmxFieldRec.FieldName;

    if hint <> ''
    Then ShowHint := true
    else ShowHint := False;
    {: A mascara só funciona se CustomEditMask = true.
       Motivo: Compatibilidade com o Delphi
    }
//    Self.CustomEditMask := true;
    MaxLength := DmxFieldRec.GetMaxLength();
    AutoSelected:=true;
    if (upcase(DmxFieldRec.CharShowPassword) = DmxScroller_Form.CharShowPassword)
    then Self.PasswordChar := DmxScroller_Form.CharShowPasswordChar;

    {$REGION '---> Seta tipo de acesso'}
       Self.Visible  := true;
       Self.TabStop  := True;
       Self.Enabled  := True;
       Self.ReadOnly := false;

       if ((DmxFieldRec^.access and accSkip)<>0)
       then Self.TabStop  := False;

       if ((DmxFieldRec^.access and accReadOnly)<>0)
       then Self.ReadOnly := true;

       if ((DmxFieldRec^.access and  accHidden)<>0)
       then Visible := false;
    {$ENDREGION}

 // onKeyDown := DoOnKeyDown;


    //if DmxFieldRec^.IsNumber
    //then with DmxFieldRec^,DmxScroller_Form do
    //     begin
    //       onKeyPress := DoEditNumberKeyPress;
    //       DispFormat := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
    //       DmxFieldRec.OkSpc := false;
    //       DmxFieldRec.OkMask:= _OkMask;
    //       MaxLength := DmxFieldRec.GetMaxLength();
    //       BiDiMode := bdRightToLeft; //Alinha do lado direito do retângulo.
    //     end
    //else with DmxFieldRec^,DmxScroller_Form do
    //     begin
    //        DispFormat := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
    //        DmxFieldRec.OkSpc := false;
    //
    //        MaxLength := DmxFieldRec.GetMaxLength();
    //
    //        if DmxFieldRec^.IsNumber
    //        then BiDiMode := bdRightToLeft //Alinha o DBEdit2 do lado direito do retângulo.
    //        else EditMask := DispFormat;
    //
    //        if DmxFieldRec^.IsData
    //        then DispFormat := Copy(Template_org,2,Length(Template_org)-1);
    //     end;

    with DmxFieldRec^,DmxScroller_Form do
         begin
            DispFormat := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
            DmxFieldRec.OkSpc := false;
            MaxLength := DmxFieldRec.GetMaxLength();
            if DmxFieldRec^.IsNumber
            then begin
                   BiDiMode := bdRightToLeft; //Alinha o DBEdit2 do lado direito do retângulo.
                 end
            else EditMask := DispFormat;

            if DmxFieldRec^.IsData
            then DispFormat := Copy(Template_org,2,Length(Template_org)-1);
         end;

    Self.Alignment := taLeftJustify;
    //SetData_Field;
    if self.Owner is TScrollingWinControl
    then Begin
           //AutoSize := true; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
           Height := Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;
           Width  := (Self.Owner as TScrollingWinControl).Canvas.TextWidth(Copy(DmxFieldRec^.Template_org,1,DmxFieldRec.ShownWid))+15;
           Constraints.MinWidth := width;
           Constraints.MaxWidth := Constraints.MinWidth;
           Constraints.MaxHeight:= Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;
           Constraints.MinHeight:= Constraints.MaxHeight;
         end;

  Finally
    DmxFieldRec.reintrance_OnEnter := False;
    _reintranceSetPDmxFieldRec := False;
  end;
end;


{
  procedure TMaskEdit_mi_LCL.DoOnKeyDown(Sender: TObject; var Key: system.Word; Shift: TShiftState);
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
           event.KeyCode := SmallWord(key);
           event.ShiftState   := 0;//
           wCurPos := GetSelStart;
           wSelEnd := GetSelLength;

           (pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).CurPos := wCurPos+1;
           (pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).SelEnd := wSelEnd+1;
           Self.PutBuffer;
           pDmxFieldRec.owner.HandleEvent(event);
           Self.GetBuffer;
           Self.SetSel(wCurPos,wSelEnd);
         end;
  end;
}

procedure TMaskEdit_mi_LCL.DoOnKeyPress(Sender: TObject; var Key: system.Char);
   var
      event :TDmxScroller_Form.TEvent;
      astr   : AnsiString;
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
    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
    begin
      if (DmxFieldRec <> nil) and (DmxFieldRec.TypeCode in [fldStr,fldStrAlfa,fldAnsiChar,fldAnsiCharAlfa ])
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

             Mi_lcl_ui_Form_attributes.DmxScroller_Form.HandleEvent(event);

             aStr := DmxFieldRec.AsString;
             if length(text)+1 <> length(aStr)
             then begin
                    aStr := copy(astr,wSelStart+2,length(AStr)-DmxFieldRec.SelStart);
                    if length(Astr) >= 1
                    then begin
                          getBuffer;
                          SelStart  := DmxFieldRec.SelStart;
                          SelLength := length(aStr);
                          SetFocus();
                          key := #0;
                         end;
                  end;


  //           Self.GetBuffer;
  //           Self.SetSel( (pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).CurPos , (pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).selEnd);
           end;

      end;


  end;

function TMaskEdit_mi_LCL.GetDmxFieldRecNumber(S: AnsiString): AnsiString;
begin
  if DmxFieldRec <> nil then
  begin
      with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
        if DmxFieldRec.IsNumber
        then begin
               result := trim(s);
                //Excluir máscara porque Text não aceita números formatados
                //result := DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
                //if pos(showDecimalSeparator  ,result)<>0
                //then begin
                //       result := Change_AnsiChar(result,showDecimalSeparator ,DecimalSeparator );
                //     end;
             end
        else Raise TException.Create(TStrError.ErrorMessage5('mi.ui.lcl',
                                                                     'mi_ui_maskedit_LCL',
                                                                     'TMaskEdit_mi_LCL',
                                                                     'GetDmxFieldRecNumber','Chamada inválida ao método.'));
  end
  else Result := '';
end;

function TMaskEdit_mi_LCL.GeTDmxFieldRecUnMask(S: AnsiString): AnsiString;
begin
  if DmxFieldRec <> nil then
  begin
    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
    begin
        if DmxFieldRec^.IsNumber
        then begin
               result := GetDmxFieldRecNumber(s)
             end
             else if DmxFieldRec^.IsData
                  then begin
                         result := DeleteMask(S,['0'..'9',' ']);
                       end
                  else begin
                         result := DeleteMask(S,DmxFieldRec^.Template_org);
                       end;
    end;
  end
  else Result := '';
end;

//procedure TMaskEdit_mi_LCL.GetBuffer;
// Var
//   waccess : Byte;
//   s : string;
//
// var
//   F : TField;
//
//begin
//  if DmxFieldRec <> nil then
//    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
//    try
//      waccess := DmxFieldRec.SetAccess(AccNormal);
//
//      if DmxFieldRec.isNumber
//      Then S := GetDmxFieldRecNumber(DmxFieldRec.AsString)
//      else begin
//            if _OkMask
//            then begin
//                   s := DmxFieldRec.AsString;
//                   if (not DmxFieldRec.IsData) or (s='')
//                   Then s := AddMask(s,DmxFieldRec.Template_org)
//                 end
//            else S := DmxFieldRec.AsString;
//           end;
//
//      text := s;       // s esta pegando o template no caso de data
//      s := text;
//    finally
//      DmxFieldRec.SetAccess(waccess);
//    end;
//end;
//
//procedure TMaskEdit_mi_LCL.PutBuffer;
// Var
//   waccess : Byte;
//   S : string;
//begin
//  if DmxFieldRec <> nil then
//    with TMi_lcl_ui_Form_attributes do
//    try
//       waccess := DmxFieldRec.SetAccess(AccNormal);
//
//       //if DmxFieldRec.IsData
//       //then s := text
//       //else s := GeTDmxFieldRecUnMask(text);
//
//       s := text;
//       DmxFieldRec^.AsString := s;
//       s := DmxFieldRec^.AsString ;
//
//       //if IsValidate then
//         //if not pDmxFieldRec.Valid(cmDMX_Enter)
//         //then abort;
//    finally
//      DmxFieldRec.SetAccess(waccess);
//    end;
//end;
//


procedure TMaskEdit_mi_LCL.GetBuffer;
  Var
    waccess : Byte;
begin
  if DmxFieldRec <> nil then
    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
    try
      waccess := DmxFieldRec.SetAccess(AccNormal);
      //field.AsAnsiString:= DmxFieldRec.AsString;
      //editText := DmxFieldRec.AsString;
      Text := DmxFieldRec.AsString;
    finally
      DmxFieldRec.SetAccess(waccess);
    end;
end;

procedure TMaskEdit_mi_LCL.PutBuffer;
 Var
   waccess : Byte;
   S : Ansistring;
begin
  if DmxFieldRec <> nil then
    with TMi_lcl_ui_Form_attributes do
    try
       waccess := DmxFieldRec.SetAccess(AccNormal);
       //DmxFieldRec.AsString := Field.AsAnsiString;
//        DmxFieldRec.AsString := editText;
        DmxFieldRec.AsString := Text;

       //if IsValidate then
         //if not pDmxFieldRec.Valid(cmDMX_Enter)
         //then abort;
    finally
      DmxFieldRec.SetAccess(waccess);
    end;
end;

procedure TMaskEdit_mi_LCL.DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectAll;
end;

procedure TMaskEdit_mi_LCL.DoEnter;

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
  if (DmxFieldRec<>nil ) and (not DmxFieldRec.reintrance_OnEnter)
  then begin
          try
           DmxFieldRec.reintrance_OnEnter := true;

           DmxFieldRec.DoOnEnter(Self);
           GetBuffer;

           //Usado quando Self estiver inserido em um stringGrid
           //if _StringGrid<>nil
           //then begin
           //       Visible := true;
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //não precisa recebe o dado do arquivo.
           //     end;
            SelectAll;
          finally
            DmxFieldRec.reintrance_OnEnter := false;

          end;
       end;
end;

procedure TMaskEdit_mi_LCL.SelectAll;
begin
  inherited SelectAll;
end;

procedure TMaskEdit_mi_LCL.DoExit;
begin
    if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.reintrance_OnExit)
    then with TMi_lcl_ui_Form_attributes do
         try
           DmxFieldRec.reintrance_OnExit := true;

           PutBuffer;
           DmxFieldRec.DoOnExit(Self);
         finally
           DmxFieldRec.reintrance_OnExit := False;
         end;

end;

var err:integer= 0;
procedure TMaskEdit_mi_LCL.DoEditNumberKeyPress(Sender: TObject; var Key: char);
  var
    s : String;
  function FieldIsEditable(Field: pDmxFieldRec): boolean;
  begin
    // with Mi_lcl_ui_Form_attributes do
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
   else  with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
         begin
           try

             Espaco := length(DeleteMask(DmxFieldRec.Template_org,MaskIsNumber));
             with DmxFieldRec^ do
               if pos(DecimalSeparator ,Template_org)<>0
               then Decimal := length(Template_org)-pos(DecimalSeparator ,Template_org)
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
                                        //Mi_lcl_ui_Form_attributes.
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
  function TMaskEdit_mi_LCL.GetAlias: AnsiString;
  begin
    if DmxFieldRec <> nil
    Then result := Self.DmxFieldRec.alias
    else result := '';
  end;

function TMaskEdit_mi_LCL.GetHelpCtx_Hint: AnsiString; // Documento do objeto.
  BEGIN
    Result := Hint;
  END;

  //function TMaskEdit_mi_LCL.GetHelpCtx_Historico: AnsiString;
  //begin
  //  Result := pDmxFieldRec.HelpCtx_Historico;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_Porque: AnsiString;
  //begin
  //   Result := '';//(pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).GetHelpCtx_Porque;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_Onde: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).GetHelpCtx_Onde;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_Como: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).GetHelpCtx_Como;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_Quais: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TMi_lcl_ui_Form_attributes).GetHelpCtx_Quais;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_StrCommand: AnsiString;
  //begin
  //  result := '';//pDmxFieldRec.HelpCtx_StrCommand;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_StrCommand_Topic: AnsiString;
  //begin
  //  result := '';//Self.pDmxFieldRec.HelpCtx_StrCommand_Topic;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_StrCurrentCommand_Topic: AnsiString;
  //begin
  //  result := '';//Self.pDmxFieldRec.HelpCtx_StrCurrentCommand_Topic;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;
  //begin
  //   result := '';//Self.pDmxFieldRec.HelpCtx_StrCurrentCommand_Topic_Content;
  //end;

  Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;
  begin
    result := false;//Self.pDmxFieldRec.Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
  end;

  //function TMaskEdit_mi_LCL.GetHelpCtx_StrModule: AnsiString;
  //begin
  //  result := '';//Self.pDmxFieldRec.HelpCtx_StrModule;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetHTMLContent: AnsiString;
  //begin
  //  result := hint;
  //end;
  //
  //function TMaskEdit_mi_LCL.GetID_Dynamic: AnsiString;
  //begin
  //  result := Self.pDmxFieldRec.ID_Dynamic;
  //end;

// ===================================================================================================
{$REGION '---> Customizações da classe TMaskEdit_mi_LCL para implementar a  Interface IInputText <---'}
  // ===================================================================================================

  procedure TMaskEdit_mi_LCL.SetAlias(const aAlias: AnsiString);
  BEGIN
    Caption := aAlias;
  END;


  //  function TMaskEdit_mi_LCL.GetValue_IInputText: Variant; // =string value passed to form processing application
  //BEGIN
  //  Result := Text;
  //END;

  //function TMaskEdit_mi_LCL.Getreintrance_OnEnter: Boolean;
  //begin
  //
  //end;
  //
  //function TMaskEdit_mi_LCL.Getreintrance_OnExit: Boolean;
  //begin
  //
  //end;

  //function TMaskEdit_mi_LCL.Get_ITable: ITable;
  //begin
  //  Result := nil;
  //end;

  //function TMaskEdit_mi_LCL.Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean;
  //begin
  //
  //end;

//function TMaskEdit_mi_LCL.IsInputCheckbox: IInputCheckbox;
//  begin
//    Result := nil;
//  end;
//
//  function TMaskEdit_mi_LCL.IsInputHidden: IInputHidden;
//  begin
//    if Self.Visible
//    then Result := nil
//    else Result := Self;
//  end;
//
//  function TMaskEdit_mi_LCL.isInputPassword: IInputPassword;
//  begin
//     if (upcase(pDmxFieldRec.CharShowPassword) = CharShowPassword)
//     then Result := Self
//     else Result := nil;
//  end;
//
//  function TMaskEdit_mi_LCL.IsInputRadio: IInputRadio;
//  begin
//    Result := nil;
//  end;
//
//  function TMaskEdit_mi_LCL.IsInputText: IInputText;
//  begin
//    result := Self;
//  end;
//
//  function TMaskEdit_mi_LCL.IsSelect: ISelect;
//  begin
//    Result := nil;
//  end;
//
//  function TMaskEdit_mi_LCL.IsTable: ITable;
//  begin
//    Result := nil;
//  end;

  //procedure TMaskEdit_mi_LCL.SetValue_IInputText(wValue: Variant);
  //BEGIN
  //  Text := Scg(wValue);
  //END;
  //
  //procedure TMaskEdit_mi_LCL.Setreintrance_OnEnter(areintrance_OnEnter: Boolean);
  //begin
  //  pDmxFieldRec.reintrance_OnEnter := areintrance_OnEnter;
  //end;
  //
  //procedure TMaskEdit_mi_LCL.Setreintrance_OnExit(areintrance_OnExit: Boolean);
  //begin
  //  pDmxFieldRec.reintrance_OnExit := areintrance_OnExit;
  //end;

//procedure TMaskEdit_mi_LCL.Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(
//  a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);
//begin
//
//end;


  //function TMaskEdit_mi_LCL.GetModule: Byte;
  //begin
  //  result := pDmxFieldRec.module;
  //end;

  function TMaskEdit_mi_LCL.GetName: AnsiString;
  begin
    Result := name;
  end;

  //function TMaskEdit_mi_LCL.GetNoTab: Variant;
  //begin
  //
  //end;


  function TMaskEdit_mi_LCL.GetSize: Variant;
  BEGIN
    Result := Width;
  END;

  //function TMaskEdit_mi_LCL.GetTabOrder: Variant;
  //begin
  //end;

/// <since>
  /// Construção da propriedade Size()
  /// =n specifies the number of AnsiCharacters to display
  /// <since>
    procedure TMaskEdit_mi_LCL.SetSize(aSize: Variant);
  BEGIN
    Width := aSize;
  END;
{$ENDREGION '---> Customizações da classe TMaskEdit_mi_LCL para implementar a  Interface IInputText <---'}
  // ===================================================================================================


end.
