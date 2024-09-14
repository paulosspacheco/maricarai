unit uMI_ui_DbEdit_LCL;
{: A unit **@name** implementa a class TMI_DbDBEdit_LCL com objetivo de ligar os campo tipo
   TDMXField rec com o componente TDBEdit do Lazarus.

   - **VERSÂO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_ui_dbedit_lcl.pas">uMI_ui_DbEdit_LCL.pas</a>)

   - **PENDÊNCIAS**
     - T12: Análise:
       - Adaptar as propriedades e métodos do componente TMi_maskEdit_lcl para TMi_DbEdit_LCL.
         - O componente tDbEdit precisa do TDataSource para capturar os dados do dataset, por isso preciso que
           o componente TDmxScroller. ✅
         - A mascara de dbEdit não está funcionando, checar porque.



 - **HISTÓRICO**
   - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
   - **2022-04-27**
     - Data em que essa unity foi criada.
     - Copiar todas as pesonalizações do componente TMi_maskEdit_lcl para TMi_DbEdit_LCL.

   - **2022-04-28**
     - t12 Análise de como adaptar as propriedades e métodos do componente TMi_maskEdit_lcl para TMi_DbEdit_LCL.
       - Estudar a integração do componente tMaskEdit com o componente TDbEdit;

   - **2022-05-01**
     - **9:42**
       - Procurar o erro: Edição de campo tipo númerico não está funcioando.   ✅

   - **2022-05-05**
     - **9:33**
       - Implementar a propriedade displayFormat    ✅

     - **14:40**
       - A propriedade displayFormat  do controle deve ser iniciado em TMI_DbEdit_LCL.WMSetFocus  ✅

     - **15:34**
       - Quando o campo recebe o focus o mesmo de

}


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,StdCtrls, DBCtrls,LMessages,LCLType,db,Variants
  ,mi.rtl.objects.Methods.dates
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  ,umi_ui_dmxscroller_form_lcl_attributes

  ;

type

  { TMI_DbEdit_LCL }

  TMI_DbEdit_LCL = class(TDBEdit)

    {: O atributo **@name** indica se o campo possui mascara ou não}
    private Var _OkMask        : boolean;

    {: O atributo **@name** é atualizado em GetBuffer para que o PutBuffer set o campo pDmxFieldRec.FieldAltered}
//      Private Var _EdittextAnt : String;

    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;
      private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário a ser criado em owner }
      public property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes write SetDmxScroller_Form_Lcl_attributes;
    {$endREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}

    Public constructor Create(AOwner:TComponent);overload;override;
    public constructor Create(aOwner:TComponent;aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);overload;

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;
      private _reintranceSeTDmxFieldRec:Boolean;
      protected Procedure SeTDmxFieldRec(apDmxFieldRec : pDmxFieldRec );Overload;


      {: O atributo **@name** fornece os dados necessários para criar o componente TMI_DbEdit_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método DmxScroller_Form_Lcl_attributesr.CreateStruct(var ATemplate : TString)
      }
      public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}

     {: O método **@name** receber um string com mascara e retorna um string sem a mascara}
       private Function GeTDmxFieldRecUnMask(S:AnsiString):AnsiString;

     {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
     public Procedure PutBuffer;

     private Function GeTDmxFieldRecNumber(S:AnsiString):AnsiString;

     {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
     Public Procedure GetBuffer;

     {: O método **@name** seleciona todas as letras ou número do controle focado. }
//     Protected procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

     {: O método **@name** ao receber o foco executa os métodos GetBuffer e pDmxFieldRec.DoOnEnter(Self).}
     Protected procedure DoOnEnter(Sender: TObject);

     {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
     Protected procedure DoOnExit(Sender: TObject);

     {: O método **@name** edita os campos números de 1 a 10 bytes}
     Protected procedure DoEditNumberKeyPress(Sender: TObject; var Key: char);

     //procedure DoOnKeyDown(Sender: TObject; var Key: system.Word; Shift: TShiftState);

     {: O método **@name** executa o método setFocus se puder.}
//     Protected procedure Select;


    // ===================================================================================================
    {$REGION ' ---> Implementação da Class THTML_Base,IInpuText <---'}
        {: O método **@name** captura a Idocumentação do campo definido na classe onde o campo for criado.

           - Com o programa **pasdoc** a Idocumentação não precisa está no arquivo de recursos,
             por isso, para obter o link para o campo � preciso saber apenas o endereço do link.

        }
        FUNCTION GetHelpCtx_Hint(): AnsiString; // Documento do objeto.

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


        Protected FUNCTION GetName(): AnsiString; // =name specifies the name of this input object
        Protected FUNCTION GetAlias: AnsiString;

    {$ENDREGION}
    // ===================================================================================================


     procedure WMSetFocus(var Message: TLMSetFocus); message LM_SETFOCUS;

     private  var _DataLink : TFieldDataLink;
     protected function GetDataLink:TFieldDataLink;

     {$REGION ' # Propriedade DisplayFormat '}
       private var _DisplayFormat : AnsiString;
       {: A propriedade **@name** a mascara de saída usada para setar Field.DisplayFormat }
       public property DisplayFormat : AnsiString Read _DisplayFormat;
     {$endREGION ' # Propriedade DisplayFormat '}

     {$REGION ' # Propriedade MaskEdit '}
       private var _MaskEdit : AnsiString;
       private Procedure SetMaskEdit (aMaskEdit : AnsiString);

       {: A propriedade **@name** contém o modelo e os cálculos do formulário a ser criado em owner }
       public property MaskEdit : AnsiString Read _MaskEdit write SetMaskEdit;
     {$endREGION ' # Propriedade MaskEdit '}

    protected procedure WMPaint(var Message: TLMPaint); message LM_PAINT;

    public procedure ValidateEdit; override;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I umi_ui_dbedit_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TMI_DbEdit_LCL]);
//end;


function TMI_DbEdit_LCL.GetDataLink: TFieldDataLink;
  var
    obj:TObject;
begin
  if _DataLink = nil
  then begin
          obj := TObject(TControl(Self).Perform(CM_GETDATALINK, 0, 0));
          if obj is TFieldDataLink then  //if there is a DataLink (see e.g. TcxDBButtonEdit.CMGetDataLink)
          begin
            _DataLink := obj as TFieldDataLink ;
            result := _DataLink;
          end
          else begin
                 result := nil;
                 _DataLink := nil;
               end;
  end
  else Result := _DataLink;
end;

procedure TMI_DbEdit_LCL.SetMaskEdit(aMaskEdit: AnsiString);
begin
  _MaskEdit := aMaskEdit;
  _DisplayFormat:= _MaskEdit;
  EditMask := _MaskEdit;
end;

procedure TMI_DbEdit_LCL.WMPaint(var Message: TLMPaint);
begin
  //if not not (csFocusing in ControlState)
  //then GetBuffer;
  inherited WMPaint(Message);
end;

procedure TMI_DbEdit_LCL.ValidateEdit;
 Var s : AnsiString;
begin
  if DmxFieldRec^.IsNumber
  then with TDmxScroller_Form_Lcl_attributes do
       begin  //Excluir máscara porque Text não aceita números formatados
         s := DeleteMask(text,['0'..'9','-','+',showDecimalSeparator ]);
         if pos(showDecimalSeparator  ,s)<>0
         then begin
                text := Change_AnsiChar(s,showDecimalSeparator ,DecimalSeparator );
              end
         else text := s;
  end;
  inherited ValidateEdit;
end;

//procedure Register;
//begin
//  RegisterComponents('Mi.Ui.Lcl', [TMI_DbEdit_LCL]);
//end;


{ TMI_DbEdit_LCL }

constructor TMI_DbEdit_LCL.Create(AOwner: TComponent);
begin
  inherited create(aOwner);
  AutoSize   := false;
  AutoSelect := true;
  SpaceChar  := '_';
end;

constructor TMI_DbEdit_LCL.Create(aOwner: TComponent;aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  Create(AOwner);
  DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  //ControlStyle:=;    //csOpaque,           //     // the control paints its area completely
end;

//procedure TMI_DbEdit_LCL.Select;
//begin
//  if Self.Parent.Visible and Self.Enabled
//     and (not _reintranceSeTDmxFieldRec)
//     and (not pDmxFieldRec.reintrance_OnEnter)
//     and (not pDmxFieldRec.reintrance_OnExit)
//  then Self.SetFocus;
//end;

procedure TMI_DbEdit_LCL.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;

procedure TMI_DbEdit_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
//  var S : String;
begin
  _pDmxFieldRec := apDmxFieldRec;
  if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil)
  then Try

          _reintranceSeTDmxFieldRec := true;
          DmxFieldRec.reintrance_OnEnter := true;
          DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec;

          name := DmxScroller_Form_Lcl_attributes.GetNameValid(DmxScroller_Form_Lcl_attributes.CurrentField.FieldName);

          if DmxFieldRec.HelpCtx_Hint<>''
          then hint := DmxFieldRec.HelpCtx_Hint
          else hint := DmxFieldRec.FieldName;

          if hint <> ''
          Then ShowHint := true
          else ShowHint := False;

          Self.DataSource := DmxScroller_Form_Lcl_attributes.DataSource;
          Self.DataField  := DmxScroller_Form_Lcl_attributes.CurrentField.FieldName ;

          {: A mascara só funciona se CustomEditMask = true.
             Motivo: Compatibilidade com o Delphi
          }
          Self.CustomEditMask := true;

          MaxLength := DmxFieldRec.GetMaxLength();
          if (upcase(DmxFieldRec.CharShowPassword) = DmxScroller_Form_Lcl_attributes.CharShowPassword)
          then Self.PasswordChar := DmxScroller_Form_Lcl_attributes.CharShowPasswordChar;


          {$REGION '---> Seta tipo de acesso'}
             with DmxScroller_Form_Lcl_attributes do
             begin
               Self.Visible  := true;
               Self.TabStop  := True;
               Self.Enabled  := True;
               Self.ReadOnly := false;

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
                      Self.TabStop  := false;//True;
                      Self.Enabled  := true;//false;
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
          then with DmxFieldRec^,DmxScroller_Form_Lcl_attributes do
               begin
                 onKeyPress := DoEditNumberKeyPress;

                 _DisplayFormat := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
                 //field.DisplayText;
                 //field.DisplayLabel
                 //if DmxFieldRec^.IsData
                 //then DisplayFormat:= _DisplayFormat;

                 editMask   := '';//Entrada de dados no evento DoEditNumberKeyPress;
                 //_DisplayFormat := '###,##0.00';
                 DmxFieldRec.OkSpc := false;
                 DmxFieldRec.OkMask:= false;
                 text := trim(NumToStr(Template_org,0,TypeCode,OkSpc));
                 _OkMask := false;

                 MaxLength := DmxFieldRec.GetMaxLength();
                 BiDiMode := bdRightToLeft; //Alinha do lado direito do retângulo.
               end
          else begin
                 with DmxFieldRec^,DmxScroller_Form_Lcl_attributes do
                    editMask  := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);

//                 MaxLength := DmxFieldRec.GetMaxLength();
                 MaxLength := DmxFieldRec.TrueLen; //DmxFieldRec^.ColumnWid;

                 Edittext := '';
                 DmxFieldRec^.OkSpc := false;
//                 OnKeyPress := DoOnKeyPress;
               end;

          if DmxFieldRec^.IsNumber
          then BiDiMode := bdRightToLeft; //Alinha o DBEdit2 do lado direito do retângulo.


//          Self.Alignment := taCenter;
//          Self.Alignment := taRightJustify;
          Self.Alignment := taLeftJustify;


          if self.Owner is TScrollingWinControl
          then Begin
                  AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
//                  Width      := DmxScroller_Form_Lcl_attributes.WidthChar * (DmxFieldRec.ShownWid+2);
                  Width  := (Self.Owner as TScrollingWinControl).Canvas.TextWidth(Copy(DmxFieldRec^.Template_org,1,DmxFieldRec.ShownWid))+15;
                  Constraints.MinWidth := width;
                  Constraints.MaxWidth := Constraints.MinWidth;
                  Constraints.MaxHeight:= DmxScroller_Form_Lcl_attributes.HeightChar;
                  Constraints.MinHeight:= Constraints.MaxHeight;
               end;

        Finally
          DmxFieldRec.reintrance_OnEnter := False;
//          DmxFieldRec.Link_IInputText := Self;
          _reintranceSeTDmxFieldRec := False;
        end;
end;

function TMI_DbEdit_LCL.GeTDmxFieldRecNumber(S: AnsiString): AnsiString;
begin
  if DmxFieldRec <> nil then
  begin
      with TDmxScroller_Form_Lcl_attributes do
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
                                                             'mi_ui_DBEdit_LCL',
                                                             'TMI_DbEdit_LCL',
                                                             'GeTDmxFieldRecNumber','Chamada inválida ao método.'));

  end
  else Result := '';
end;

procedure TMI_DbEdit_LCL.GetBuffer;
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

//procedure TMI_DbEdit_LCL.GetBuffer;
// Var
//   S : AnsiString;
//   waccess : Byte;
//
//begin
//    with TDmxScroller_Form_Lcl_attributes do
//    try
//     waccess := DmxFieldRec.SetAccess(AccNormal);
//
//     S := DmxFieldRec.AsString;
//     if DmxFieldRec.IsNumber
//     then begin
//             //Excluir máscara
//             s := DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
//             if (pos(showDecimalSeparator  ,s)<>0) and (showDecimalSeparator <>DecimalSeparator )
//             then begin
//                    s := Change_AnsiChar(s,showDecimalSeparator ,DecimalSeparator );
//                  end;
//          end;
//
////     showMessage(s);
//
//     //If DmxFieldRec.TypeCode  in [FldDateTime,FldDateTime,FldDateTime]
//     //Then Begin {$REGION '--->'}
//     //       while Pos('/',s) <> 0
//     //       do DELETE(s,Pos('/',s),1);
//     //
//     //       while Pos(' ',s) <> 0
//     //       do DELETE(s,Pos(' ',s),1);
//     //     {$ENDREGION}
//     //     end
//     //else If DmxFieldRec.TypeCode in [fldLHora,fld_LHora]
//     //     Then Begin {$REGION '--->'}
//     //             while Pos(':',s) <> 0
//     //             do DELETE(s,Pos(':',s),1);
//     //
//     //             while Pos(' ',s) <> 0
//     //             do DELETE(s,Pos(' ',s),1);
//     //           {$ENDREGION}
//     //           end;
//
//     //if IsNumber_real(DmxFieldRec.Template_org)
//     //then begin
//     //       //if pos(DecimalSeparator ,s)<>0
//     //       //then begin
//     //       //       //S := FormatFloat('#0.00',StrToCurr(S));
//     //       //       s := Change_AnsiChar(s,DecimalSeparator ,showDecimalSeparator );
//     //       //     end;
//     //    end;
//
//    finally
//      text := s;
////      Field.AsAnsiString := s;
////      _EdittextAnt := text;
//      DmxFieldRec.SetAccess(waccess);
//    end;
//end;

function TMI_DbEdit_LCL.GeTDmxFieldRecUnMask(S: AnsiString): AnsiString;
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
                       end;
    end;
  end
  else Result := '';
end;

procedure TMI_DbEdit_LCL.PutBuffer;
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
         //if not DmxFieldRec.Valid(cmDMX_Enter)
         //then abort;
    finally
      DmxFieldRec.SetAccess(waccess);
    end;
end;

//procedure TMI_DbEdit_LCL.PutBuffer;
// Var
//   waccess : Byte;
//   s : TDmxScroller_Form_Lcl_attributes.TString;
//begin
//  with TDmxScroller_Form_Lcl_attributes do
////  if isValueDbChanged(Self) Then
//  try
//    waccess := DmxFieldRec.SetAccess(AccNormal);
//
//     s := text;
//     //s := text;
//     DmxFieldRec.AsString := s;
//     //if IsValidate then
//       //if not DmxFieldRec.Valid(cmDMX_Enter)
//       //then abort;
//  finally
//    DmxFieldRec.SetAccess(waccess);
//  end;
//end;

procedure TMI_DbEdit_LCL.DoOnEnter(Sender: TObject);
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
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //Não precisa recebe o dado do arquivo.
           //     end;

          finally
            DmxFieldRec.reintrance_OnEnter := false;
          end;
       end;
end;

procedure TMI_DbEdit_LCL.DoOnExit(Sender: TObject);
begin

    if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.reintrance_OnExit)
    then with TDmxScroller_Form_Lcl_attributes do
         try
           DmxFieldRec.reintrance_OnExit := true;

           PutBuffer;
           DmxFieldRec.DoOnExit(Self);

           //Is isValidate then
           //if not DmxFieldRec.Valid(cmDMX_Enter)
           //then abort;

           //if _StringGrid<>nil
           //then begin
           //        _StringGrid.Cells[_StringGrid.col,_StringGrid.row] := text; //Atualiza a visão do grid.
           //       Visible := false;
           //       //Seleciona o focus de  _StringGrid
           //       _StringGrid.SetFocus;
           //     end;

         finally
           DmxFieldRec.reintrance_OnExit := False;
         end;
end;
var err:integer;
procedure TMI_DbEdit_LCL.DoEditNumberKeyPress(Sender: TObject; var Key: char);
  var
    s : String;

  function FieldIsEditable(Field: TField): boolean;
  begin
    result := (Field<>nil) and (not Field.Calculated) and
              (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
  end;

  function FieldCanAcceptKey(Field: TField; AKey: char): boolean;
  begin
    Result := FieldIsEditable(Field) and (Key in ['0'..'9',',', #8]) ;
  end;

  Var
   vChar, vDiv: TString;
   I : Integer;
   Espaco, Decimal: Integer;

begin
  if (not FieldCanAcceptKey(Field, Key))
       or (not GetDataLink.Edit)
   then Key := #0
   else  with DmxScroller_Form_Lcl_attributes do
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
                                        Key := #0;
                                        exit;
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


//procedure TMI_DbEdit_LCL.DoEditNumberKeyPress(Sender: TObject; var Key: char);
//
  //function FieldIsEditable(Field: TField): boolean;
  //begin
  //  result := (Field<>nil) and (not Field.Calculated) and
  //            (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
  //end;
  //
  //function FieldCanAcceptKey(Field: TField; AKey: char): boolean;
  //begin
  //  Result := FieldIsEditable(Field) and (Key in ['0'..'9',',', #8]) ;
  //end;
//
//  Var
//   vChar, vDiv,s : TString;
//   I,iaux : Integer;
//   Espaco, Decimal: Integer;
//
//begin
   //if (not FieldCanAcceptKey(Field, Key))
   //   or (not GetDataLink.Edit)
//   then Key := #0
//   else  with DmxScroller_Form_Lcl_attributes do
//         begin
//           try
//             Espaco := length(DeleteMask(DmxFieldRec.Template_org,MaskIsNumber));
//             with DmxFieldRec^ do
//               if pos(DecimalSeparator ,Template_org)<>0
//               then Decimal := length(Template_org)-pos(DecimalSeparator ,Template_org)
//               else Decimal := 0;
//
//             vDiv := '1';
//             For I := 1 to Decimal do
//               vDiv := vDiv + '0';
//
//             if (length(DeleteMask(text,MaskIsNumber)) = espaco) and (Key <> #8 ) //and (length(text)>1)
//             then begin
//                    exit;
//                   end;
//             MaxLength := Espaco;
//
//              if Key = #8
//              then begin
//                     if (length(Text) > 1)
//                     then vChar := copy(Text,1,(length(Text)-1))
//                     else begin
//                            vChar := '0';
//                          end;
//                   end
//              else vChar := copy(Text,1,length(Text));
//
//              if Key <> #8  then
//              begin
//                if (vchar = '') or (vchar = '0')
//                then vchar := Key
//                else vchar := vchar + Key;
//              end;
//
//              vChar := DeleteMask(vChar,['0'..'9']);
//
//              if vchar <> ''
//              Then Begin
//                      with DmxFieldRec^ do
//                      begin
//                        if decimal = 0
//                        then s := vchar
//                        else s := formatFloat('0.'+conststr(decimal,'0'),StrToFloat(vchar)/StrToInt(vDiv));
//
//                        text := s;
//                      end;
//                   end;
//            finally
//              SelStart := length(text);
//            end;
//           Key := #0;
//         end;
//end;



//==========================

  // Construção da propriedade HelpCtx_Hint()
  function TMI_DbEdit_LCL.GetAlias: AnsiString;
  begin
    result := Self.DmxFieldRec.alias;
  end;


procedure TMI_DbEdit_LCL.WMSetFocus(var Message: TLMSetFocus);
begin
  inherited  WMSetFocus(Message);
  if (Field is TNumericField)
  then (Field as TNumericField).DisplayFormat:= DisplayFormat
  else if Field is TDateTimeField
       then (Field as TDateTimeField).DisplayFormat:= DisplayFormat
       else if Field is TDateField
            then (Field as TDateField).DisplayFormat:= DisplayFormat
            else if Field is TTimeField
            then (Field as TTimeField).DisplayFormat:= DisplayFormat;
end;


function TMI_DbEdit_LCL.GetHelpCtx_Hint: AnsiString; // Documento do objeto.
  BEGIN
    Result := Hint;
  END;

  //function TMI_DbEdit_LCL.GetHelpCtx_Historico: AnsiString;
  //begin
  //  Result := DmxFieldRec.HelpCtx_Historico;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_Porque: AnsiString;
  //begin
  //   Result := '';//(DmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Porque;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_Onde: AnsiString;
  //begin
  //  Result := '';//(DmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Onde;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_Como: AnsiString;
  //begin
  //  Result := '';//(DmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Como;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_Quais: AnsiString;
  //begin
  //  Result := '';//(DmxFieldRec.owner as TDmxScroller_Form_Lcl_attributes).GetHelpCtx_Quais;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_StrCommand: AnsiString;
  //begin
  //  result := '';//DmxFieldRec.HelpCtx_StrCommand;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_StrCommand_Topic: AnsiString;
  //begin
  //  result := '';//Self.DmxFieldRec.HelpCtx_StrCommand_Topic;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_StrCurrentCommand_Topic: AnsiString;
  //begin
  //  result := '';//Self.DmxFieldRec.HelpCtx_StrCurrentCommand_Topic;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;
  //begin
  //   result := '';//Self.DmxFieldRec.HelpCtx_StrCurrentCommand_Topic_Content;
  //end;

  Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;
  begin
    result := false;//Self.DmxFieldRec.Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
  end;

  //function TMI_DbEdit_LCL.GetHelpCtx_StrModule: AnsiString;
  //begin
  //  result := '';//Self.DmxFieldRec.HelpCtx_StrModule;
  //end;
  //
  //function TMI_DbEdit_LCL.GetHTMLContent: AnsiString;
  //begin
  //  result := hint;
  //end;
  //
  //function TMI_DbEdit_LCL.GetID_Dynamic: AnsiString;
  //begin
  //  result := Self.DmxFieldRec.ID_Dynamic;
  //end;

// ===================================================================================================
{$REGION '---> Customizações da classe TMI_DbEdit_LCL para implementar a  Interface IInputText <---'}
  // ===================================================================================================

  procedure TMI_DbEdit_LCL.SetAlias(const aAlias: AnsiString);
  BEGIN
    Caption := aAlias;
  END;


  //  function TMI_DbEdit_LCL.GetValue_IInputText: Variant; // =string value passed to form processing application
  //BEGIN
  //  Result := Text;
  //END;

  //function TMI_DbEdit_LCL.Getreintrance_OnEnter: Boolean;
  //begin
  //
  //end;
  //
  //function TMI_DbEdit_LCL.Getreintrance_OnExit: Boolean;
  //begin
  //
  //end;

  //function TMI_DbEdit_LCL.Get_ITable: ITable;
  //begin
  //  Result := nil;
  //end;

  //function TMI_DbEdit_LCL.Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean;
  //begin
  //
  //end;

//function TMI_DbEdit_LCL.IsInputCheckbox: IInputCheckbox;
//  begin
//    Result := nil;
//  end;
//
//  function TMI_DbEdit_LCL.IsInputHidden: IInputHidden;
//  begin
//    if Self.Visible
//    then Result := nil
//    else Result := Self;
//  end;
//
//  function TMI_DbEdit_LCL.isInputPassword: IInputPassword;
//  begin
//     if (upcase(DmxFieldRec.CharShowPassword) = CharShowPassword)
//     then Result := Self
//     else Result := nil;
//  end;
//
//  function TMI_DbEdit_LCL.IsInputRadio: IInputRadio;
//  begin
//    Result := nil;
//  end;
//
//  function TMI_DbEdit_LCL.IsInputText: IInputText;
//  begin
//    result := Self;
//  end;
//
//  function TMI_DbEdit_LCL.IsSelect: ISelect;
//  begin
//    Result := nil;
//  end;
//
//  function TMI_DbEdit_LCL.IsTable: ITable;
//  begin
//    Result := nil;
//  end;

  //procedure TMI_DbEdit_LCL.SetValue_IInputText(wValue: Variant);
  //BEGIN
  //  Text := Scg(wValue);
  //END;
  //
  //procedure TMI_DbEdit_LCL.Setreintrance_OnEnter(areintrance_OnEnter: Boolean);
  //begin
  //  DmxFieldRec.reintrance_OnEnter := areintrance_OnEnter;
  //end;
  //
  //procedure TMI_DbEdit_LCL.Setreintrance_OnExit(areintrance_OnExit: Boolean);
  //begin
  //  DmxFieldRec.reintrance_OnExit := areintrance_OnExit;
  //end;

//procedure TMI_DbEdit_LCL.Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(
//  a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);
//begin
//
//end;

// Construção da propriedade MaxLength()
  function TMI_DbEdit_LCL.GetMaxLength: Variant; // =n specifies the maximum number of AnsiCharacters
  BEGIN
    Result := MaxLength;
  END;

  //function TMI_DbEdit_LCL.GetModule: Byte;
  //begin
  //  result := DmxFieldRec.module;
  //end;

  function TMI_DbEdit_LCL.GetName: AnsiString;
  begin
    Result := name;
  end;

  //function TMI_DbEdit_LCL.GetNoTab: Variant;
  //begin
  //
  //end;

  procedure TMI_DbEdit_LCL.SetMaxLength(aMaxLength: Variant);
  BEGIN
    MaxLength := aMaxLength;
  END;

  function TMI_DbEdit_LCL.GetSize: Variant;
  BEGIN
    Result := Width;
  END;

  //function TMI_DbEdit_LCL.GetTabOrder: Variant;
  //begin
  //end;

/// <since>
  /// Construção da propriedade Size()
  /// =n specifies the number of AnsiCharacters to display
  /// <since>
    procedure TMI_DbEdit_LCL.SetSize(aSize: Variant);
  BEGIN
    Width := aSize;
  END;
{$ENDREGION '---> Customizações da classe TMI_DbEdit_LCL para implementar a  Interface IInputText <---'}
  // ===================================================================================================



end.


procedure TMI_DbEdit_LCL.DoonEditNumberKeyPress( Sender: TObject;  var UTF8Key: TUTF8Char);

  function FieldIsEditable(Field: TField): boolean;
  begin
    result := (Field<>nil) and (not Field.Calculated) and
              (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
  end;

  function FieldCanAcceptKey(Field: TField; AKey: char): boolean;
  begin
    Result := FieldIsEditable(Field) and Field.IsValidChar(AKey);
  end;

  procedure fDBEdit(Texto, VKey: String);
    Var
     vChar, vDiv,s : TString;
    I,iaux : Integer;
    Espaco, Decimal: Integer;
  begin
    with DmxScroller_Form_Lcl_attributes do
    try
      Espaco := length(DeleteMask(DmxFieldRec.Template_org,MaskIsNumber));
      with DmxFieldRec^ do
        if pos(DecimalSeparator ,Template_org)<>0
        then Decimal := length(Template_org)-pos(DecimalSeparator ,Template_org)
        else Decimal := 0;

      vDiv := '1';
      For I := 1 to Decimal do
        vDiv := vDiv + '0';

      if (length(DeleteMask(text,MaskIsNumber)) = espaco) and (UTF8Key <> #8 ) //and (length(text)>1)
      then begin
             exit;
            end;
      MaxLength := Espaco;

       if UTF8Key = #8
       then begin
              if (length(Texto) > 1)
              then vChar := copy(Texto,1,(length(Texto)-1))
              else begin
                     vChar := '0';
                   end;
            end
       else vChar := copy(Texto,1,length(Texto));

       if UTF8Key <> #8  then
       begin
         if (vchar = '') or (vchar = '0')
         then vchar := vkey
         else vchar := vchar + vkey;
       end;

       vChar := DeleteMask(vChar,['0'..'9']);

       if vchar <> ''
       Then Begin
               with DmxFieldRec^ do
               begin
                 s := NumToStr(Template_org,StrToFloat(vchar)/StrToInt(vDiv),TypeCode,OkSpc);
                 s := DeleteMask(s,['0'..'9',DecimalSeparator ,showDecimalSeparator ]);
                 iaux := pos(showDecimalSeparator ,s);
                 if (Iaux<>0) and (DecimalSeparator <>showDecimalSeparator )
                 then begin
                        system.delete(s,iaux,1);
                        system.insert(DecimalSeparator ,s,iaux);
                      end;
                 Text := s;

//                 text  := formatFloat('#,##0.00',StrToFloat(vchar)/StrToInt(vDiv));


//               Objeto.Text := FormatFloat('#,##0.00',StrToFloat(vchar)/StrToInt(vDiv));
//               Objeto.Text := FormatFloat('0,00',StrToFloat(vchar)/StrToInt(vDiv));
               end;
            end;
     finally
       SelStart := length(text);
     end;
  end;

  //Const accNormal      =    0;
  //Const accReadOnly    =    1;
  //Const accHidden      =    2;
  //Const accSkip        =    4;
  //Const accDelimiter   =    8;

begin

  //if not FieldCanAcceptKey(fDataLink.Field, UTF8Key) or not Datalink.Edit
  //then UTF8Key := #0;

   //if not (UTF8Key in ['0'..'9',',', #8]) then UTF8Key := #0
   if not (( (UTF8Key >='0') and (UTF8Key <='9')) or (UTF8Key = ',') or (UTF8Key = #8) ) then UTF8Key := #0
   else  with DmxScroller_Form_Lcl_attributes do
         begin
           fDBEdit(text,UTF8Key);
            UTF8Key := #0;
         end;
end;


