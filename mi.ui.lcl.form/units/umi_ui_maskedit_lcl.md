unit mi_ui_MaskEditDmx;
{: A unit **@name** � implementa a class TMI_MaskEdit_LCL com objetivo de ligar os campo tipo TDMXField rec com o
   componente TMaskEdit do Lazarus.

   - **VERSÃO**
     - Alpha - 0.7.1

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/mi_maskedit_lcl_u.pas">mi_maskedit_LCL_u.pas</a>)

   - **PENDÊNCIAS**
     -

 - **HISTÓRICO**
   - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
   - **2022-02-10**
     - Data em que essa unity foi criada.

   - **2022-02-19 15:00**
     - Documentar essa unit.
     - Quando o campo for selecionado posicionar o cursor na posição 1.


   - **2022-02-23 08:00**
     - O método PutBuffer ou GetBuffer está deformando o dado quando o campo � do tipo alfanumérico com a
       m�scara (##) # #### - ####.
       - O problema � que TMaskEditDmx estava usando formação de um número comum e esta
         formação � um string formatado que s� aceita números.
         - Para resolver preciso:
           - Remover o tipo FldStrNum do conjunto que indica que se trata de números. ok.
           - Informar para maskEdit que não salva a m�scara. ok
         -

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
  SysUtils,Messages, Classes, Controls, StdCtrls,
  Forms,Grids ,dialogs
  //,Unit_HTML_Interfaces
  ,mi.rtl.objects.Methods.dates
  ,mi_ui_DmxScroller
   //  ,mi.rtl.objects.methods.ui.Dmxscroller.Dmxform

   ;

type
  {:< A a classe **@name** � usada para edição do campo tipo TDmxFieldRec.

      - **NOTA**
        - As coordenadas do retângulo devem ser definidas após criação e inclusão
          do controle em TScrollBox ou TFrame ou TForm.

        - O tipo de dados, largura, altura, mascara de edição e tipo de acesso do campo
          são obtidos tipo TDmxFieldRec obtido emUiDmxScrollerr . CurrentField.

        - Os componentes UiDmxScroller e TScrollingWinControl devem ser passado
          por constructor.Create(TScrollingWinControl,UiDmxScroller) já inicializados.
  }
  TMI_MaskEdit_LCL = class(TMaskEdit)//,IInputText,IInputHidden,IInputPassword,IInputText)
      {: O atributo **@name** indica se o campo possui mascara ou não}
      private Var _OkMask        : boolean;

      {: O atributo **@name** � atualizado em GetBuffer para que o PutBuffer set o campo pDmxFieldRec.FieldAltered}
      Private Var _EdittextAnt : String;

      public var _StringGrid : TStringGrid;

      {$REGION ' # Propriedade UiDmxScroller '}
        private var _UiDmxScroller : TUiDmxScroller;
        private Procedure SetUiDmxScroller (aUiDmxScroller : TUiDmxScroller);

        {: A propriedade **@name** contém o modelo e os cálculos do formulário a ser criado em owner }
        published property UiDmxScroller : TUiDmxScroller Read _UiDmxScroller
                                                                                  write SetUiDmxScroller;
      {$endREGION ' # Propriedade UiDmxScroller '}

      Public constructor Create(AOwner:TComponent);overload;override;
      public constructor Create(aOwner:TComponent;aUiDmxScroller : TUiDmxScroller);

      {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
        strict Private Var _pDmxFieldRec : pDmxFieldRec;
               private _VidisSeTDmxFieldRec:Boolean;
        strict Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );Overload;

        {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

           - **NOTA**
             - Esses dados devem ser criados pelo método UiDmxScrollerr.CreateStruct(var ATemplate : TString)
        }
        public property pDmxFieldRec: mi_ui_DmxScroller.pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
      {$ENDREGION}

       {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
       public Procedure PutBuffer;

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

       //        procedure DoOnKeyDown(Sender: TObject; var Key: system.Word; Shift: TShiftState);

       {: O método **@name** não usado por enquanto???}
       procedure DoOnKeyPress(Sender: TObject; var Key: system.Char);

       {: O método **@name** executa o método setFocus se puder.}
       Protected procedure Select;

       //PUBLIC FUNCTION IsInputText: IInputText;
       //PUBLIC FUNCTION IsInputRadio: IInputRadio;
       //PUBLIC FUNCTION IsSelect: ISelect;
       //PUBLIC FUNCTION IsInputCheckbox: IInputCheckbox;
       //PUBLIC FUNCTION isInputPassword: IInputPassword;
       //PUBLIC FUNCTION IsInputHidden: IInputHidden;
       //PUBLIC FUNCTION IsTable: ITable; // <O objeto filho que implementar um tabela deve anular e retornar true;

// ===================================================================================================
{$REGION ' ---> Implementa��o da Class THTML_Base,IInpuText <---'}
      {: O método **@name** captura a documentação do campo definido na classe onde o campo for criado.

         - Com o programa **pasdoc** a documentação não precisa está no arquivo de recursos,
           por isso, para obter o link para o campo � preciso saber apenas o endereço do link.

      }
      FUNCTION GetHelpCtx_Hint(): AnsiString; // Documento do objeto.

      /// <since>
      /// Construção da propriedade Value()
      /// //= string value passed to form processing application
      /// </since>
      //FUNCTION GetValue_IInputText(): Variant;// =string value passed to form processing application
      //PROCEDURE SetValue_IInputText(wValue: Variant);

      /// <since>
      /// Construção da propriedade MaxLength()
      /// =n specifies the maximum number of AnsiCharacters
      /// </since>
      FUNCTION GetMaxLength(): Variant;
      PROCEDURE SetMaxLength(aMaxLength: Variant);

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
      procedure SetName(const NewName: TComponentName); override;

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
        //Protected  Function  GetModule : Byte; ///<since>Pode ser redefinido para ler o molule informado na class dona da atual.</since>
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



   end;

//procedure Register;

implementation

//procedure Register;
//begin
//  RegisterComponents('/\/\ar/\carai.UI', [TMI_MaskEdit_LCL]);
//end;


{ TMI_MaskEdit_LCL }

constructor TMI_MaskEdit_LCL.Create(AOwner: TComponent);
begin
  inherited create(aOwner);
  if aOwner is TStringGrid
  then _StringGrid := aOwner as TStringGrid;
  AutoSize   := false;
  AutoSelect := true;
  SpaceChar  := '_';
end;

constructor TMI_MaskEdit_LCL.Create(aOwner: TComponent;aUiDmxScroller: TUiDmxScroller);
begin
  Create(AOwner);
  UiDmxScroller := aUiDmxScroller;
end;

procedure TMI_MaskEdit_LCL.Select;
begin
  if Self.Parent.Visible and Self.Enabled
     and (not _VidisSeTDmxFieldRec)
     and (not pDmxFieldRec.vidis_OnEnter)
     and (not pDmxFieldRec.vidis_OnExit)
  then Self.SetFocus;
end;
Procedure TMI_MaskEdit_LCL.SetUiDmxScroller (aUiDmxScroller : TUiDmxScroller);
begin
  _UiDmxScroller := aUiDmxScroller;
  IF (_UiDmxScroller<>nil) and (_UiDmxScroller.CurrentField<>nil)
  then SeTDmxFieldRec(_UiDmxScroller.CurrentField);
end;

procedure TMI_MaskEdit_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
begin
  _pDmxFieldRec := apDmxFieldRec;
  if (UiDmxScroller<>nil) and (pDmxFieldRec<>nil)
  then //with UiDmxScroller do
       Try
          _VidisSeTDmxFieldRec := true;
          pDmxFieldRec.vidis_OnEnter := true;
          UiDmxScroller.CurrentField := pDmxFieldRec;


          with pDmxFieldRec^,UiDmxScroller do
            editMask  := Get_MaskEdit_LCL(Template_org, _OkMask);

          MaxLength := pDmxFieldRec.GetMaxLength();
          if (upcase(pDmxFieldRec.CharShowPassword) = UiDmxScroller.CharShowPassword)
          then Self.PasswordChar := UiDmxScroller.CharShowPasswordChar;

          with UiDmxScroller do
          begin
            if ((pDmxFieldRec^.access and  accSkip)<>0) or
               ((pDmxFieldRec^.access and  accReadOnly)<>0)
            then begin
                   ReadOnly := true;
                   //PerformTab(true);
                 end
            else if ((pDmxFieldRec^.access and  accHidden)<>0)
                 then begin
                         Visible := false;
                       end;
          end;

          OnMouseDown := DoOnMouseDown;
          OnEnter := DoOnEnter;
          onExit  := DoOnExit;
//          onKeyDown := DoOnKeyDown;
          if pDmxFieldRec^.IsNumber
          then begin
                 OnKeyPress := DoEditNumberKeyPress;
                 Edittext := '0';
                 editMask   := '';//Entrada de dados no evento DoEditNumberKeyPress;
                 pDmxFieldRec.OkSpc := true;
               end
          else begin
                 Edittext := '';
                 pDmxFieldRec.OkSpc := false;
//                 OnKeyPress := DoOnKeyPress;
               end;

          if pDmxFieldRec^.IsNumber
          then BiDiMode := bdRightToLeft; //Alinha o MaskEdit2 do lado direito do retângulo.
//          EditText      := pDmxFieldRec.asString;

          {$REGION '---> Seta tipo de acesso'}
             with UiDmxScroller do
             case pDmxFieldRec.access of
                accNormal : begin
                               Self.Visible  := true;
                               Self.TabStop  := True;
                               Self.Enabled  := True;
                               Self.ReadOnly := false;
                            end;

                accHidden : Self.Visible := false;

                accSkip   : begin
                              Self.Visible := true;
                              Self.TabStop  := False;
                              Self.ReadOnly := true;
                            end;
                accReadOnly : Begin
                                Self.ReadOnly := true;
                                Self.Visible  := true;
                                Self.TabStop  := True;
                              End;
             end;

          {$ENDREGION}


//          Self.Alignment := taCenter;
//          Self.Alignment := taRightJustify;
          Self.Alignment := taLeftJustify;


          if Owner is TScrollingWinControl
          then Begin
                  AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
                  Width      := UiDmxScroller.WidthChar * (pDmxFieldRec.ShownWid+2);
                  Constraints.MinWidth := width;
                  Constraints.MaxWidth := width;
                  Constraints.MaxHeight:= UiDmxScroller.HeightChar;
                  Constraints.MinHeight:= UiDmxScroller.HeightChar;
               end;
          MaxLength := pDmxFieldRec.TrueLen;
        Finally
          pDmxFieldRec.vidis_OnEnter := False;
//          pDmxFieldRec.Link_IInputText := Self;
          _VidisSeTDmxFieldRec := False;
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

           (pDmxFieldRec.owner as TUiDmxScroller).CurPos := wCurPos+1;
           (pDmxFieldRec.owner as TUiDmxScroller).SelEnd := wSelEnd+1;
           Self.PutBuffer;
           pDmxFieldRec.owner.HandleEvent(event);
           Self.GetBuffer;
           Self.SetSel(wCurPos,wSelEnd);
         end;
  end;
}

procedure TMI_MaskEdit_LCL.DoOnKeyPress(Sender: TObject; var Key: system.Char);
   var
      event :TUiDmxScroller.TEvent;
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
    with TUiDmxScroller do
    begin
      if (pDmxFieldRec <> nil) and (pDmxFieldRec.TypeCode in [fldSTR,fldSTR_Minuscula,fldAnsiChar,fldAnsiChar_Minuscula ])
      then begin
             Event.What    := evKeyDown;
             Event.InfoPtr := nil;
             event.AnsiCharCode := AnsiChar(key);
             event.ShiftState   := 0;//
             wSelStart := GetSelStart;
             wSelEnd   := wSelStart + GetSelLength;

             pDmxFieldRec.CurPos   := wSelStart;
             pDmxFieldRec.SelStart := wSelStart;
             pDmxFieldRec.SelEnd   := wSelEnd;

              Self.PutBuffer;

             UiDmxScroller.HandleEvent(event);

             str := pDmxFieldRec.AsString;
             if length(text)+1 <> length(str)
             then begin
                    str := copy(str,wSelStart+2,length(str)-pDmxFieldRec.SelStart);
                    if length(str) >= 1
                    then begin
                          getBuffer;
                          SelStart  := pDmxFieldRec.SelStart;
                          SelLength := length(str);
                          SetFocus();
                          key := #0;
                         end;
                  end;


  //           Self.GetBuffer;
  //           Self.SetSel( (pDmxFieldRec.owner as TUiDmxScroller).CurPos , (pDmxFieldRec.owner as TUiDmxScroller).selEnd);
           end;

      end;


  end;

procedure TMI_MaskEdit_LCL.GetBuffer;
 Var
   S : String;
   waccess : Byte;

begin
    with TUiDmxScroller do
    try
     waccess := pDmxFieldRec.SetAccess(AccNormal);

     S := pDmxFieldRec.AsString;
     if pDmxFieldRec.IsNumber
     then begin
             //Excluir m�scara
             s := DeleteMask(S,['0'..'9','-','+',showDecPt]);
             if pos(showDecPt ,s)<>0
             then begin
                    s := Change_AnsiChar(s,showDecPt,DecPt);
                  end;
          end;

//     showMessage(s);

     //If pDmxFieldRec.TypeCode  in [FldData,fldLData,fld_LData]
     //Then Begin {$REGION '--->'}
     //       while Pos('/',s) <> 0
     //       do DELETE(s,Pos('/',s),1);
     //
     //       while Pos(' ',s) <> 0
     //       do DELETE(s,Pos(' ',s),1);
     //     {$ENDREGION}
     //     end
     //else If pDmxFieldRec.TypeCode in [fldLHora,fld_LHora]
     //     Then Begin {$REGION '--->'}
     //             while Pos(':',s) <> 0
     //             do DELETE(s,Pos(':',s),1);
     //
     //             while Pos(' ',s) <> 0
     //             do DELETE(s,Pos(' ',s),1);
     //           {$ENDREGION}
     //           end;

     //if IsNumber_real(pDmxFieldRec.Template_org)
     //then begin
     //       //if pos(DecPt,s)<>0
     //       //then begin
     //       //       //S := FormatFloat('#0.00',StrToCurr(S));
     //       //       s := Change_AnsiChar(s,DecPt,showDecPt);
     //       //     end;
     //    end;

    finally
      text := s;
      _EdittextAnt := text;
      //Edittext := s;
      //_EdittextAnt := Edittext;
      pDmxFieldRec.SetAccess(waccess);
    end;
end;

procedure TMI_MaskEdit_LCL.PutBuffer;
 Var
   //s,Aux : AnsiString;
   //aData:TDates.TypeData;
   //LData,LHora,i,err : Longint;
   waccess : Byte;
begin
   if _EdittextAnt <> Edittext
   Then pDmxFieldRec.FieldAltered := true
   Else pDmxFieldRec.FieldAltered := False;

   if pDmxFieldRec.FieldAltered
   then with TUiDmxScroller do
        try
           waccess := pDmxFieldRec.SetAccess(AccNormal);
           pDmxFieldRec.AsString := text;
           //if IsValidate then
             //if not pDmxFieldRec.Valid(cmDMX_Enter)
             //then abort;
        finally
          pDmxFieldRec.SetAccess(waccess);
        end;
end;

procedure TMI_MaskEdit_LCL.DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  SelectAll;
end;

procedure TMI_MaskEdit_LCL.DoOnEnter(Sender: TObject);
begin
  if (pDmxFieldRec<>nil ) and (not pDmxFieldRec.vidis_OnEnter)
  then begin
          try
           pDmxFieldRec.vidis_OnEnter := true;

           pDmxFieldRec.DoOnEnter(Self);

           GetBuffer;

           //Usado quando Self estiver inserido em um stringGrid
           //if _StringGrid<>nil
           //then begin
           //       Visible := true;
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //não precisa recebe o dado do arquivo.
           //     end;

          finally
            pDmxFieldRec.vidis_OnEnter := false;
          end;
       end;
end;

procedure TMI_MaskEdit_LCL.DoOnExit(Sender: TObject);
begin

    if (pDmxFieldRec<>nil) and ( Not  pDmxFieldRec.vidis_OnExit)
    then with TUiDmxScroller do
         try
           pDmxFieldRec.vidis_OnExit := true;

           pDmxFieldRec.DoOnExit(Self);

           PutBuffer;

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
           pDmxFieldRec.vidis_OnExit := False;
         end;

end;

procedure TMI_MaskEdit_LCL.DoEditNumberKeyPress(Sender: TObject; var Key: char);

  procedure fMaskEdit(Objeto: TMaskEdit; Texto, VKey: String);
    Var
     vChar, vDiv,s : String;
    I : Integer;
    Espaco, Decimal: Integer;
  begin
    with UiDmxScroller do
    try
      Espaco := length(DeleteMask(pDmxFieldRec.Template_org,MaskIsNumber));
      with pDmxFieldRec^ do
        if pos(DecPt,Template_org)<>0
        then Decimal := length(Template_org)-pos(DecPt,Template_org)
        else Decimal := 0;

      vDiv := '1';
      For I := 1 to Decimal do
        vDiv := vDiv + '0';

      if (length(DeleteMask(text,MaskIsNumber)) = espaco) and (Key <> #8 ) //and (length(text)>1)
      then begin
             exit;
            end;
      Objeto.MaxLength := Espaco;

       if key = #8
       then begin
              if (length(Texto) > 1)
              then vChar := copy(Texto,1,(length(Texto)-1))
              else begin
                     vChar := '0';
                   end;
            end
       else vChar := copy(Texto,1,length(Texto));

       if key <> #8  then
       begin
         if (vchar = '') or (vchar = '0')
         then vchar := vkey
         else vchar := vchar + vkey;
       end;

       vChar := DeleteMask(vChar,['0'..'9']);

       if vchar <> ''
       Then Begin
               with pDmxFieldRec^ do
               begin
                  Objeto.Text := DeleteMask(
                                                   NumToStr(Template_org,StrToFloat(vchar)/StrToInt(vDiv),TypeCode,OkSpc),
                                                   ['0'..'9',DecPt,showDecPt]
                                                  );
               end;
            end;
     finally
       Objeto.SelStart := length(Objeto.text);
     end;
  end;

  //Const accNormal      =    0;
  //Const accReadOnly    =    1;
  //Const accHidden      =    2;
  //Const accSkip        =    4;
  //Const accDelimiter   =    8;

begin
   if not (key in ['0'..'9',',', #8])  then
      key := #0
   else  with UiDmxScroller do
         begin
            if (pDmxFieldRec^.access = 0)
            then begin
//                   if ;
                   fMaskEdit(Self,Self.text,key)

                 end
            else if (pDmxFieldRec^.access and  accSkip)<>0
                 then begin
                        PerformTab(true);
                      end;

            Key := #0;
         end;
end;

//==========================


  // Construção da propriedade HelpCtx_Hint()
  function TMI_MaskEdit_LCL.GetAlias: AnsiString;
  begin
    result := Self.pDmxFieldRec.alias;
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
  //   Result := '';//(pDmxFieldRec.owner as TUiDmxScroller).GetHelpCtx_Porque;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Onde: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TUiDmxScroller).GetHelpCtx_Onde;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Como: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TUiDmxScroller).GetHelpCtx_Como;
  //end;
  //
  //function TMI_MaskEdit_LCL.GetHelpCtx_Quais: AnsiString;
  //begin
  //  Result := '';//(pDmxFieldRec.owner as TUiDmxScroller).GetHelpCtx_Quais;
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

    procedure TMI_MaskEdit_LCL.SetName(const NewName: TComponentName);
  Begin
    Name := NewName;
  End;

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

// Construção da propriedade MaxLength()
  function TMI_MaskEdit_LCL.GetMaxLength: Variant; // =n specifies the maximum number of AnsiCharacters
  BEGIN
    Result := MaxLength;
  END;

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

    procedure TMI_MaskEdit_LCL.SetMaxLength(aMaxLength: Variant);
  BEGIN
    MaxLength := aMaxLength;
  END;

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
