unit uDbedit_mi_lcl;
{: A unit **@name** implementa a class TMI_DbDBEdit_LCL com objetivo de ligar
   os campo tipo TDMXFieldRec com o componente TDBEdit do Lazarus.

   - **VERSÂO**
     - Alpha - 1.0.0
     - Data Criação:  27/04/2022
     - Data Ultima atulização : 10/06/2024

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_ui_dbedit_lcl.pas">uMI_ui_DbEdit_LCL.pas</a>)

   - **PENDÊNCIAS**
     - Quando a mascara é do tipo string o número de caractere lido é menor 2 bytes
       por isso a mesma não funciona.

   - **CONCLUÍDO**
     - Se o campo for senha, então a propriedade Field.visible = false.✅
     - Adaptar as propriedades e métodos do componente TMi_maskEdit_lcl para
       TMi_DbEdit_LCL.✅
     - A mascara de dbEdit não está funcionando, checar porque. ✅
     - O componente tDbEdit precisa do TDataSource para capturar os dados do dataset,
       por isso preciso que o componente TDmxScroller. ✅
     - Copiar todas as pesonalizações do componente TMi_maskEdit_lcl para TMi_DbEdit_LCL.✅

     - 2022-04-28
       - t12 Análise de como adaptar as propriedades e métodos do componente
         TMi_maskEdit_lcl para TMi_DbEdit_LCL. ✅
       - Estudar a integração do componente tMaskEdit com o componente TDbEdit; ✅

     - 2022-05-01
       - 9:42        

         - Procurar o erro: Edição de campo tipo númerico não está funcioando.   ✅

     - 2022-05-05
       - 9:33
         - Implementar a propriedade displayFormat    ✅

       - 14:40
         - A propriedade displayFormat  do controle deve ser iniciado em
           TMI_DbEdit_LCL.WMSetFocus  ✅
}


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,StdCtrls,
   DBCtrls,LMessages,LCLType,db,Variants
  ,mi.rtl.all
  ,mi.rtl.objects.types
  ,mi.rtl.objects.Methods.dates
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  ,uMi_lcl_ui_Form_attributes
  ;

type

  { TMI_DbEdit_LCL }

  { TDbEdit_mi_LCL }

  TDbEdit_mi_LCL = class(TDBEdit)
    //{$IFDEF WINDOWS}
    //   Const Use_DoEditNumberKeyPress = false;
    //{$ELSE}
    //   Const Use_DoEditNumberKeyPress = true;
    //{$ENDIF}

    {: O atributo **@name** indica se o campo possui mascara ou não}
    private Var _OkMask        : boolean;

    {: O atributo **@name** é atualizado em GetBuffer para que o PutBuffer set o campo pDmxFieldRec.FieldAltered}
//      Private Var _EdittextAnt : String;
    Public constructor Create(AOwner:TComponent);overload;override;
    public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);overload;
    public destructor Destroy;override;
    {$REGION ' # Propriedade DispFormat '}
      private var _DispFormat : AnsiString;
//       procedure SetDispFormat(aDispFormat: String);
      procedure SetDispFormat(AValue: AnsiString);
      {: A propriedade **@name** a mascara de saída usada para setar Field.DisplayFormat }
      public property DispFormat : AnsiString Read _DispFormat write SetDispFormat;
    {$endREGION ' # Propriedade DispFormat '}

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}

      Private Var _pDmxFieldRec : pDmxFieldRec;
      private _reintranceSetPDmxFieldRec:Boolean;
      protected Procedure SetPDmxFieldRec(apDmxFieldRec : pDmxFieldRec );Overload;


      {: O atributo **@name** fornece os dados necessários para criar o componente TDbEdit_mi_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método Mi_lcl_ui_Form_attributesr.CreateStruct(var ATemplate : TString)
      }
      public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SetPDmxFieldRec;
    {$ENDREGION}

    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
      private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);
      {: A propriedade **@name** contém o modelo e os cálculos do formulário a ser criado em owner }
      public property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes write SetMi_lcl_ui_Form_attributes;
    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

    //{: O método **@name** receber um string númerico com mascara e retorna um string sem a mascara}
    //private Function GetDmxFieldRecNumber(S:AnsiString):AnsiString;
    //
    //{: O método **@name** receber um string com mascara e retorna um string sem a mascara}
    //private Function GetDmxFieldRecUnMask(S:AnsiString):AnsiString;


    {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
    public Procedure PutBuffer;

    {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
    Public Procedure GetBuffer;

    //private procedure CMEnter(var Message: TCMEnter); message CM_ENTER;

    {: O método **@name** ao receber o foco executa os métodos GetBuffer e pDmxFieldRec.DoOnEnter(Self).}
    protected procedure DoEnter; override;
    public procedure SelectAll; reintroduce;

    {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
    protected procedure DoExit; override;

    Protected procedure DoGetText(Sender: TField; var aText: string;DisplayText: Boolean);
    Protected procedure DoSetText(Sender: TField; const aText: string);

    
    protected function GetEditText: string; override;

    {: O método **@name** edita os campos números de 0 a 10 bytes}
//    Protected procedure DoEditNumberKeyPress(Sender: TObject; var Key: char);

    {: O método **@name** executa o método setFocus se puder.}
    Protected procedure Select;

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
//        FUNCTION GetMaxLength(): Variant;
//        PROCEDURE SetMaxLength(aMaxLength: Variant);

        /// <since>
        /// Construção da propriedade Size()
        /// =n specifies the number of AnsiCharacters to display
        /// <since>
        //FUNCTION GetSize(): Variant;

        /// <since>
        /// Construção da propriedade Size()
        /// =n specifies the number of AnsiCharacters to display
        /// <since>
        //PROCEDURE SetSize(aSize: Variant);
        procedure SetAlias(const aAlias: AnsiString);


        Protected FUNCTION GetName(): AnsiString; // =name specifies the name of this input object
        Protected FUNCTION GetAlias: AnsiString;

    {$ENDREGION}
    // ===================================================================================================

     {: O Método **@name** Seta displayformat do datafield}
//     procedure WMSetFocus(var Message: TLMSetFocus); message LM_SETFOCUS;

     //private  var _DataLink : TFieldDataLink;
     //protected function GetDataLink:TFieldDataLink;
     //{: O método **@name** retorna true se o campo pode ser editado e falso caso contrário}
     //protected function FieldIsEditable(Field: TField): boolean;

     private procedure SetProperty_Data_field;

     {: A propriedade **@name** seta nome de dataField e suas propriedades }
      private procedure SetData_Field;

    protected procedure WMPaint(var Message: TLMPaint); message LM_PAINT;

//    protected procedure ValidateEditDateTime(Sender: TField);
    public procedure ValidateEdit; Override;
    protected  procedure Change; override;

    {: O evento **@name** mostra no browser a documentação da classe
       DmxFieldRec.owner_UiDmxScroller.owner.ClassName.

       - **NOTAS**
         - Tecla usada F1;
         - O documento deve ser gerado com o programa pasdoc na pasta de documentos
           do proejto.
         - Nome do arquivo de documento:
           - Nome da pasta de documentos\
           - Nome da unit da classe dona de DmxFieldRec.owner_UiDmxScroller\
           - Nome da classe DmxFieldRec.owner_UiDmxScroller.owner\
           - .html
             - Exemplo prático: ```/docs/Unit2.TDataModule1.html```
    }
    protected procedure OnKeyDownF1(Sender: TObject; var Key: Word; Shift: TShiftState);

    public function  GetHTMLContent :String;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  RegisterComponents('Mi.Lcl',[TDbEdit_mi_LCL]);
//  Tmi_rtl.UnlistPublishedProperty(TDbEdit_mi_LCL,'DataSource');
//end;

{ TDbEdit_mi_LCL }

function TDbEdit_mi_LCL.GetAlias: AnsiString;
begin
  If Assigned(DmxFieldRec)
  Then result := Self.DmxFieldRec.alias
  else result :=  '';
end;

//function TDbEdit_mi_LCL.GetDataLink: TFieldDataLink;
//  var
//    obj:TObject;
//begin
//  if _DataLink = nil
//  then begin
//        obj := TObject(TControl(Self).Perform(CM_GETDATALINK, 0, 0));
//        if obj is TFieldDataLink then  //if there is a DataLink (see e.g. TcxDBButtonEdit.CMGetDataLink)
//        begin
//          _DataLink := obj as TFieldDataLink ;
//          result := _DataLink;
//        end
//        else begin
//               result := nil;
//               _DataLink := nil;
//             end;
//       end
//  else Result := _DataLink;
//end;

//function TDbEdit_mi_LCL.FieldIsEditable(Field: TField): boolean;
//begin
//  result := (Field<>nil) and (not Field.Calculated) and
//            (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
//end;

procedure TDbEdit_mi_LCL.SetProperty_Data_field;
  var
    s : string;
begin
  with Mi_lcl_ui_Form_attributes.DmxScroller_Form do
  begin
    if Assigned(DataSource.DataSet.FindField(DmxFieldRec.FieldName))
    then begin
           if ((DmxFieldRec^.access and  accHidden)<>0)
           then Field.Visible := false
           else if (upcase(DmxFieldRec.CharShowPassword) = CharShowPassword)
                then Field.Visible := false
                else Field.Visible := true;

           if ((DmxFieldRec^.access and accReadOnly)<>0)
           then Field.ReadOnly := true
           else Field.ReadOnly := false;

           Field.DisplayLabel := DmxFieldRec^.FieldName;
           Field.DisplayWidth := DmxFieldRec^.ShownWid;

           field.OnSetText:=DoSetText;
           field.OnGetText := DoGetText;

           Field.EditMask := EditMask ;


           if Assigned(Field) and (Field is TStringField)
           then with Field as TStringField do
                begin
                  if ((DmxFieldRec^.access and accSkip)<>0)
                  then TabStop  := False
                  else TabStop  := True;
                  Enabled  := True;
                 (Field as TStringField).EditMask := self.DispFormat;
                 //(Field as TStringField).MaxLength := Self.MaxLength;
                 if Field.Size < Self.MaxLength
                 then Field.Size := Self.MaxLength;

                end
           else if Assigned(Field) and  (Field is TNumericField)
                then begin
                       if ((DmxFieldRec^.access and accSkip)<>0)
                       then TabStop  := False
                       else TabStop  := True;
                       Enabled  := True;
                       if (Field is TCurrencyField)
                       then  with Field as TCurrencyField do
                             begin
                               if (Field is TCurrencyField)
                               then begin
                                      (Field as TNumericField).DisplayFormat:=self.DispFormat;
                                      (Field as TNumericField).EditMask := self.EditMask;
                                      (Field as TCurrencyField).Precision:=2;
                                    end;
                             end
                        else if (Field is TFloatField)
                             then with Field as TFloatField do
                                  begin
                                    (Field as TNumericField).DisplayFormat:=self.DispFormat;
                                    (Field as TNumericField).EditMask := self.EditMask;
                                   // (Field as TFloatField).Precision:=2;
                                  end
                     end
                     else if Assigned(Field) and (Field is TTimeField)
                          then begin
                                 if ((DmxFieldRec^.access and accSkip)<>0)
                                 then TabStop  := False
                                 else TabStop  := True;
                                 Enabled  := True;

                                 (Field as TTimeField).DisplayFormat:=self.DispFormat;
                                 (Field as TTimeField).EditMask:=self.EditMask;
                               end
                          else if Assigned(Field) and (Field is TDateField)
                               then begin
                                     if ((DmxFieldRec^.access and accSkip)<>0)
                                     then TabStop  := False
                                     else TabStop  := True;
                                     Enabled  := True;
                                     (Field as TDateField).DisplayFormat := self.DispFormat;
                                      (Field as TDateField).EditMask:=self.EditMask;
                                    end
                               else if Assigned(Field) and (Field is TDateTimeField)
                                    then begin
                                          if ((DmxFieldRec^.access and accSkip)<>0)
                                          then TabStop  := False
                                          else TabStop  := True;
                                          Enabled  := True;
                                          // Configurar o evento OnValidate e OnSetText para o campo de data
                                          //(Field as TDateTimeField).OnValidate := ValidateEditDateTime;
                                          //(Field as TDateTimeField).OnSetText  := DoSetText;

                                          (Field as TDateTimeField).DisplayFormat := self.DispFormat;
                                          (Field as TDateTimeField).EditMask:=self.EditMask;
                                        end;

    end;
  end;
end;

procedure TDbEdit_mi_LCL.SetData_Field;
begin
  with Mi_lcl_ui_Form_attributes.DmxScroller_Form do
  begin
    if Assigned(DataSource.DataSet.FindField(DmxFieldRec.FieldName))
    then begin
           Self.DataSource := DataSource;
           Self.DataField  := DmxFieldRec.FieldName;
//           Self._Field     := Self.DataSource.DataSet.FieldByName(Self.DataField);
           //if Not Assigned(Self._Field)
           //then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Tipo de controle não existe do banco de dados!.');

           //if Self._Field.FieldName<>field.FieldName
           //Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Tipo de controle não existe do banco de dados!.');

           SetProperty_Data_field;
         end;
  end;
end;

procedure TDbEdit_mi_LCL.WMPaint(var Message: TLMPaint);
begin
  //if not not (csFocusing in ControlState)
  //then GetBuffer;
  inherited WMPaint(Message);
end;

//procedure TDbEdit_mi_LCL.ValidateEditDateTime(Sender: TField);
//  var
//    s : AnsiString;
//begin
//   With DmxFieldRec^,owner_UiDmxScroller do
//   begin
////     s := TDates.FormatMask(Sender.AsAnsiString,mask);
//     s := Text;
////     s := Sender.AsAnsiString;
//     if (s<>'') and (s<>'00:00:00') and
//                    (s<>'00:00') and
//                    (s<>' //:00:00') and
//                    (s<>'/     :  :' ) and
//                    (s<>'  /  /     :  :  ') and
//                    (s<>'/       :  :') and
//                    (s<>'/') and
//                    (s<>' //') and
//                    (s<>'Null')
//     Then begin
//            exit;
//          end
//     else Sender.AsAnsiString := '';
//   end;
//end;

procedure TDbEdit_mi_LCL.ValidateEdit;
  //var
  //  s,s1 : AnsiString;
begin
  //if _pDmxFieldRec.IsData
  //Then With DmxFieldRec^,owner_UiDmxScroller do
  //     begin
  //       s := Text;
  //       if not TDates.DateTimeValid(s)
  //       then Text := '0';
  //     end;
  inherited ValidateEdit;
end;

procedure TDbEdit_mi_LCL.Change;
begin
  inherited Change;
end;

constructor TDbEdit_mi_LCL.Create(AOwner: TComponent);
begin
  inherited create(aOwner);
  AutoSize   := false;
  AutoSelect := true;
  ParentFont:=true;
end;

constructor TDbEdit_mi_LCL.Create(aOwner: TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(AOwner);
  Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  //ControlStyle:=;    //csOpaque,  // the control paints its area completely
end;

destructor TDbEdit_mi_LCL.Destroy;
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited Destroy;
end;

procedure TDbEdit_mi_LCL.SetDispFormat(AValue: AnsiString);
begin
  if _DispFormat=AValue then Exit;
  _DispFormat:=AValue;
end;

procedure TDbEdit_mi_LCL.Select;
begin
  if Self.Parent.Visible and Self.Enabled
     and (not _reintranceSetPDmxFieldRec)
     and (not DmxFieldRec^.reintrance_OnEnter)
     and (not DmxFieldRec^.reintrance_OnExit)
  then Self.SetFocus;
end;

procedure TDbEdit_mi_LCL.SetPDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  var
    FormatSettings: TFormatSettings;
    s : AnsiString;
begin
  _pDmxFieldRec := apDmxFieldRec;
  if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil) then
  with Mi_lcl_ui_Form_attributes do
  Try
    Self.OnKeyDown:=OnKeyDownF1;

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
    {: A mascara só funciCanModifyona se CustomEditMask = true.
       Motivo: Compatibilidade com o Delphi
    }
    Self.CustomEditMask := true;

    //AutoSelected:=true;
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
    with DmxFieldRec^,DmxScroller_Form do
    begin
      DispFormat := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
      DmxFieldRec.OkSpc := false;
      MaxLength := DmxFieldRec.GetMaxLength();
      if DmxFieldRec^.IsNumber
      then begin
             // Nas entrada númericas o TDbEdit.EditMask não dever
             // ser informado pq não funcina.
             // O displayFormat não deve usar caracteres 0 ou 9
             // porque fica maluco a entrada de dados.
             // Por exemplo:
             //   - Para editar um número com formato 99.999,99
             //     deve-se ignorar TdbEdit.Editmask e em Field.displayformat
             //     assinalar field.displayFormat = '##.###,##'.
           end
      else EditMask := DispFormat;

      if DmxFieldRec^.IsData
      then DispFormat := Copy(Template_org,2,Length(Template_org)-1);

    end;

    if self.Owner is TScrollingWinControl
    then Begin
          // AutoSize := true; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
           if DmxFieldRec^.ShownWid<>GetMaxLength
           then begin
                  If DmxFieldRec^.IsData
                  Then Width  :=  (DmxFieldRec^.ShownWid * DmxScroller_Form.WidthChar)+20
                  else begin
                         s:= Copy(DmxFieldRec^.Template_org,1,DmxFieldRec^.ShownWid);
                         Width  := (Self.Owner as TScrollingWinControl).Canvas.TextWidth(s)+25;
//                         Width  := ((DmxFieldRec^.ShownWid) * DmxScroller_Form.WidthChar)
                        end;
                end
           else begin
                  if _OkMask
                  then begin //Se tem mascara deve considerar a largura de 1 caractere.
                         If not DmxFieldRec^.IsData
                         Then Width  :=  (DmxFieldRec^.ShownWid * DmxScroller_Form.WidthChar)+20
                         else Width  :=  (DmxFieldRec^.ShownWid * DmxScroller_Form.WidthChar)+10;
                       end
                  else Width  := (Self.Owner as TScrollingWinControl).Canvas.TextWidth(DmxFieldRec^.Template_org)+25;
               end;

           Constraints.MinWidth := width;
           Constraints.MaxWidth := Constraints.MinWidth;
           Constraints.MinHeight:= Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;
           Constraints.MaxHeight:= Constraints.MinHeight;
         end;
    SetData_Field;
    if DmxFieldRec^.IsNumber
    Then Self.Alignment:= taRightJustify
    else Self.Alignment := taLeftJustify;

  Finally
    DmxFieldRec.reintrance_OnEnter := False;
    _reintranceSetPDmxFieldRec := False;
  end;
end;

procedure TDbEdit_mi_LCL.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF Assigned(_Mi_lcl_ui_Form_attributes) and
     Assigned(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField) and
     Assigned(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField)
  then SetPDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;

procedure TDbEdit_mi_LCL.GetBuffer;
begin
  //Tmi_rtl.Print_info_compile;
  //O teste foi colocado aqui porque quando dmxscroller.locate é assionado
  //em um campo tipo data; não sei porque, mais _pDmxFieldRec^.FieldName fica
  //diferente de self.field,fieldname.
  if Assigned(Self.Field) and (Self.Field.FieldName=_pDmxFieldRec^.FieldName)
  Then _pDmxFieldRec^.CopyTo(Field);
end;

procedure TDbEdit_mi_LCL.PutBuffer;
begin
  //O teste foi colocado aqui porque quando dmxscroller.locate é assionado
  //em um campo tipo data; não sei porque, mais _pDmxFieldRec^.FieldName fica
  //diferente de self.field,fieldname.
  if Assigned(Self.Field) and (Self.Field.FieldName =_pDmxFieldRec.FieldName)
  Then _pDmxFieldRec^.copyFrom(field);
end;

//procedure TDbEdit_mi_LCL.CMEnter(var Message: TCMEnter);
//begin
//  inherited;
//  SelectAll;
//end;

procedure TDbEdit_mi_LCL.DoEnter;
begin
  if (DmxFieldRec<>nil ) and
     (not DmxFieldRec.reintrance_OnEnter) and
//     Field.DataSet.CanModify and
     EditCanModify
  then begin
          try
           DmxFieldRec.reintrance_OnEnter := true;
           DmxFieldRec.DoOnEnter(Self);
           GetBuffer;
          finally
            DmxFieldRec.reintrance_OnEnter := false;
          end;
       end;
  inherited DoEnter;
  SelectAll;
end;

procedure TDbEdit_mi_LCL.SelectAll;
  //var
  //  s1,s2 : AnsiString;
  //   SelStartt,SelLengthh:integer;
begin
  inherited SelectAll;
  //if Self.HandleAllocated and (Text <> '') then
  //begin
  //       s1 := Text;
  //       s2 := selText;
  //
  //  SelStart := 0;
  //  SelLength := Length(Text);
  //  SelStartt := SelStart;
  //  SelLengthh := SelLength;
  //end;
end;

procedure TDbEdit_mi_LCL.DoExit;
  var
    s : string;
begin
  if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.reintrance_OnExit)
  then with Mi_lcl_ui_Form_attributes do
       try
         DmxFieldRec.reintrance_OnExit := true;
         PutBuffer;
         DmxFieldRec^.DoOnExit(Self);
       finally
         DmxFieldRec.reintrance_OnExit := False;
         Refresh;
       end;
  inherited DoExit;
end;

procedure TDbEdit_mi_LCL.DoGetText(Sender: TField;
                                   var aText: string;DisplayText: Boolean);

  Function GetData:AnsiString;
    Var
      W : TFormatSettings;
      s : AnsiString;
  begin
    if Sender.AsDateTime <> 0
    Then begin
           Result := Sender.AsString;
           with DmxFieldRec^,owner_UiDmxScroller do
             Result  :=   TDates.FormatMask(Result,DmxFieldRec^.Mask);

           if (Result = '31/12/1899') or
              (Result = '31/12/99')
           then Result := '-';
         end
    else Result := '-';
  end;

  var
    s_mask,s: string;
    OkMask_temp :Boolean;
    VExtended : Extended;
begin
   if (DmxFieldRec<>nil) and DisplayText
   then with DmxFieldRec^,owner_UiDmxScroller do
        begin
          if Not DmxFieldRec^.IsData
          Then begin
                 if DmxFieldRec^.IsNumber
                 then begin
                        if DmxFieldRec^.IsNumberReal
                        then begin
                               s := Sender.AsString;
                               if s<>''
                               then begin
                                      VExtended := Sender.AsFloat;
                                      aText := NumToStr(Template_org,VExtended,TypeCode,false)
                                    end
                               else aText := '';
                             end
                        else begin
                               s := Sender.AsString;
                               if s<>''
                               then aText := NumToStr(Template_org,Sender.AsLongint,TypeCode,false)
                               else aText := '';
                             end;
                      end
                 else begin
                        s := Sender.AsString;
                        if (s<>'')
                        Then begin
                               s_mask := Get_MaskEdit_LCL(Template_org,SpaceChar,OkMask_temp);
                               if(s_mask<>'')
                               Then aText := FormatMaskEdit_LCL(s,s_mask,true)
                               else aText :=  s;
                               s := aText;
                             end
                        else aText := '';
                      end;
               end
          else begin
                 aText := GetData;
               end;
        end
   else begin
          if DmxFieldRec^.IsData
          then aText := GetData
          else aText := Sender.AsString;
        end;

end;

procedure TDbEdit_mi_LCL.DoSetText(Sender: TField; const aText: string);
  function FieldIsEditable(Field: TField): boolean;
  begin
    result := (Field<>nil) and (not Field.Calculated) and
              (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
  end;

  Function GetData:TDateTime;
    var
      s : AnsiString;
  begin
     With DmxFieldRec^,owner_UiDmxScroller do
     begin
       s := TDates.FormatMask(aText,mask);
       if TDates.DateTimeValid(s)
       Then begin
              Result := TDates.StrToDateTime(s,Mask,true);
              if Result<>0
              Then s := SysUtils.DateTimeToStr(Result);
            end
       else Result := 0;
     end;
  end;

 var
   W : TFormatSettings;
   Value: Double;
   R    : real;
   s : string;
begin
  //If sender.ReadOnly
  //then exit;

  if Sender is TCurrencyField
  then begin
         s := TMi_rtl.DeleteMask(aText,['0'..'9','-','+',TMi_rtl.showDecimalSeparator ]);
         if TryStrToFloat(s, Value) then
            Sender.AsCurrency := Value
         else
            Sender.Clear; // ou atribuir um valor padrão como 0.00
       end
  else if Sender is TFloatField
       then begin
              s := TMi_rtl.DeleteMask(aText,['0'..'9','-','+',TMi_rtl.showDecimalSeparator ]);
              if TryStrToFloat(s, R)
              then Sender.AsFloat := R
              else Sender.Clear; // ou atribuir um valor padrão como 0.00
            end
       else if Sender is TLongintField
            then begin
                   try
                     s := TMi_rtl.DeleteMask(aText,['0'..'9','-','+',TMi_rtl.showDecimalSeparator ]);
                     Sender.AsLongint:= StrToInt(s);
                   except
                     Sender.Clear; // ou atribuir um valor padrão como 0.00
                   end
                 end
             else If DmxFieldRec^.IsData
                  then begin
                         Sender.AsDateTime := GetData
                       end
                  else begin
                         try
                           Sender.AsString := aText;
                         except
                           Sender.Clear; // ou atribuir um valor padrão como 0.00
                         end;
                       end;
end;

function TDbEdit_mi_LCL.GetEditText: string;
begin
  Result:=inherited GetEditText;
end;

//procedure TDbEdit_mi_LCL.WMSetFocus(var Message: TLMSetFocus);
//begin
//  inherited  WMSetFocus(Message);
//end;

function TDbEdit_mi_LCL.GetHelpCtx_Hint: AnsiString; // Documento do objeto.
  BEGIN
    Result := Hint;
  END;

procedure TDbEdit_mi_LCL.SetAlias(const aAlias: AnsiString);
BEGIN
  Caption := aAlias;
END;

// Construção da propriedade MaxLength()
//function TDbEdit_mi_LCL.GetMaxLength: Variant; // =n specifies the maximum number of AnsiCharacters
//BEGIN
//  Result := MaxLength;
//END;

function TDbEdit_mi_LCL.GetName: AnsiString;
begin
  Result := name;
end;

//procedure TDbEdit_mi_LCL.SetMaxLength(aMaxLength: Variant);
//BEGIN
//  MaxLength := aMaxLength;
//END;

//function TDbEdit_mi_LCL.GetSize: Variant;
//BEGIN
//  Result := Width;
//END;

//procedure TDbEdit_mi_LCL.SetSize(aSize: Variant);
//BEGIN
//  Width := aSize;
//END;

procedure TDbEdit_mi_LCL.OnKeyDownF1(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then
  begin
    ShowMessage('Ação de ajuda acionada!'+DmxFieldRec.owner_UiDmxScroller.owner.ClassName+
                'Nome da Unit:'+DmxFieldRec.owner_UiDmxScroller.owner.UnitName

                   );
    Key := 0;  // Previne o processamento padrão da tecla F1
  end;
end;

function TDbEdit_mi_LCL.GetHTMLContent: String;
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
    Result := StringReplace(Result, '~datamask-type', TypeCode       , [rfReplaceAll]);
  end;
end;

end.





//Desativei pq no windows não funcionou como deveria
//if DmxFieldRec^.IsNumber and Use_DoEditNumberKeyPress
//then with DmxFieldRec^,DmxScroller_Form do
//     begin
//       if Use_DoEditNumberKeyPress
//       Then onKeyPress := DoEditNumberKeyPress;
//
//       DispFormat := Get_MaskEdit_LCL(Template_org,SpaceChar, _OkMask);
//       DmxFieldRec.OkSpc := false;
//       MaxLength := DmxFieldRec.GetMaxLength();
//       BiDiMode := bdRightToLeft; //Alinha do lado direito do retângulo.
//     end
//else caso não seja número
//
//
//var err:integer = 0;
//procedure TDbEdit_mi_LCL.DoEditNumberKeyPress(Sender: TObject; var Key: char);
//  var
//    s : String;
//
//  function FieldIsEditable(Field: TField): boolean;
//  begin
//    result := (Field<>nil) and (not Field.Calculated) and
//              (Field.DataType<>ftAutoInc) and (Field.FieldKind<>fkLookup)
//  end;
//
//  function FieldCanAcceptKey(Field: TField; AKey: char): boolean;
//  begin
//    Result := FieldIsEditable(Field) and (Key in ['0'..'9',',', #8]) ;
//  end;
//
//  Var
//   vChar, vDiv: TString;
//   I : Integer;
//   Espaco, Decimal: Integer;
//   Valor:double;
//   PosDecimalSeparator : integer;
//begin
//  if (not FieldCanAcceptKey(Field, Key))
//       or (not GetDataLink.Edit)
//   then Key := #0
//   else  with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
//         begin
//           try
//             Espaco := length(DeleteMask(DmxFieldRec.Template_org,MaskIsNumber));
//             with DmxFieldRec^ do
//               if pos(DecimalSeparator ,Template_org)<>0
//               then begin
//                      PosDecimalSeparator := pos(ShowDecimalSeparator ,Template_org);
//                      Decimal := length(Template_org)-PosDecimalSeparator;
//                    end
//               else Decimal := 0;
//
//             vDiv := '1';
//             For I := 1 to Decimal do
//               vDiv := vDiv + '0';
//
//               s := DeleteMask(Text,['0'..'9','.','-','+']);
//               if (length(s) = espaco) and (Key <> #8 )
//                  then begin
//                         exit;
//                       end;
//
//               if Key = #8
//               then begin
//                      if (length(s) > 1)
//                      then vChar := copy(s,1,(length(s)-1))
//                      else begin
//                             vChar := '0';
//                           end;
//                    end
//               else vChar := copy(s,1,length(s));
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
//                        then begin
//                               if (Upperlimit>0) then
//                               begin //Controla o limite superior do campo. Só pega 1..255
//                                 if (StrToInt(vchar) <= Upperlimit)
//                                 then s := vchar
//                                 else begin
//                                        Key := #0;
//                                        exit;
//                                      end;
//                                 end
//                               else begin
//                                      If IntValid(vchar,TypeCode)
//                                      then s := trim(NumToStr(Template_org,StrToInt(vchar),TypeCode,OkSpc))
//                                      else begin
//                                             if err<>0
//                                             then begin
//                                                    Key := #0;exit;
//                                                  end;
//                                           end;
//                                     end;
//                             end
//                        else begin
////                               valor := StrToFloat(vchar)/StrToInt(vDiv);
//                               //s := trim(NumToStr(Template_org,valor,TypeCode,OkSpc));
//                              valor := StrToInt(vchar)/StrToInt(vDiv);
//                               s := FloatToStrf(valor,ffFixed,PosDecimalSeparator-1,decimal);
//                             end;
//
//                        text := s;
////                        writeLn(text);
//                      end;
//                   end;
//            finally
//              SelStart := length(text);
//            end;
//           Key := #0;
//         end;
//end;
