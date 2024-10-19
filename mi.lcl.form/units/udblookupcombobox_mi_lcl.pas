unit uDblookupcombobox_mi_lcl;
{: A unit **@name** implementa a class TMI_LookupComboBox_LCL com objetivo de ligar
   os campo tipo TDmxFieldRec.fldEnum com o componente TDbLookupComboBox do Lazarus.

   - **VERSÂO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/uMi_ui_DBLookupComboBox_Lcl.pas">uMi_ui_DBLookupComboBox_Lcl.pas</a>)

   - **PENDÊNCIAS**
     - T12: Documentar a unidade.
     - T12: Implementar a possibilidade de montar a lista basedado em um TDataSource
            informado na aplicação customizada.
   - **HISTÓRICO**
     - **16/06/2022**
       - **18:19**
         - Criar a classe TMi_ui_DBLookupComboBox_Lcl herdando de TDbLookupComboBox. ✅

     - **17/06/2022**
       - **9:40**
         - T12: Criar constructor Create(AOwner:TComponent); override;overload; ✅️
         - T12: Criar constructor Create(aOwner:TComponent;aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);overload;overload; ✅️
         - T12: Criar destructor Destroy; override;  ✅️
         - T12: Criar propriedade DmxScroller_Form_Lcl_attributes; ✅️
         - T12: Criar método Procedure PutBuffer; ✅️
         - T12: Criar método Procedure GetBuffer; ✅️
         - T12: Criar método procedure DoOnEnter(Sender: TObject); ✅️
         - T12: Criar método procedure DoOnExit(Sender: TObject); ✅️
         - T12: Criar propriedade pDmxFieldRec; ✅️
         - T12: Setar atributos:
                - DataField  = TDmxFieldRec.FieldName;✅️
                - DataSource = DmxScroller_Form_Lcl_attributes.DataSource✅️
                - KeyField   = TDmxFieldRec.FldEnum_Lookup.KeyField✅️
                - ListField  = TDmxFieldRec.FldEnum_Lookup.ListField✅️
                - ListFieldIndex = 1✅️
                - ListSource = TDmxFieldRec.FldEnum_Lookup.DataSource✅️

}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}
{$H+}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, DBCtrls,StdCtrls,db
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  //,umi_lcl_ui_dmxscroller_form_attributes
  ,uMi_lcl_ui_Form_attributes
  ,mi.rtl.all
  ;

type

  { TMi_ui_DBLookupComboBox_Lcl }

  { TDBLookupComboBox_mi_Lcl }

  TDBLookupComboBox_mi_Lcl = class(TDBLookupComboBox)
     public constructor Create(AOwner:TComponent); override;overload;
     public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);overload;overload;
     public destructor Destroy; override;
     {$REGION ' # Propriedade Mi_lcl_ui_Form_attributes '}
       private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
       private Procedure SetMi_lcl_ui_Form_attributes (Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);
       published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes write SetMi_lcl_ui_Form_attributes;
     {$ENDREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

     public Procedure PutBuffer;
     public Procedure GetBuffer;
     protected procedure DoOnEnter(Sender: TObject);
     protected procedure DoOnExit(Sender: TObject);

     private procedure SetProperty_Data_field;

     {: A propriedade **@name** seta nome de dataField e suas propriedades }
     private procedure SetData_Field;


     {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
         strict Private Var _pDmxFieldRec : pDmxFieldRec;
                private _reintranceSeTDmxFieldRec:Boolean;
         strict Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );

         Public
         {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

            - **NOTA**
              - Esses dados devem ser criados pelo método TMi_lcl_ui_Form_attributes.CreateStruct(var ATemplate : TString)
         }
         property  DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
     {$ENDREGION}


     public function  GetHTMLContent :String;
  end;

//procedure Register;

implementation

  //procedure Register;
  //begin
  //  {$I uDBLookupComboBox_mi_Lcl_icon.lrs}
  //  RegisterComponents('Mi.Ui.Lcl',[TDBLookupComboBox_mi_Lcl]);
  //end;

  { TDBLookupComboBox_mi_Lcl }

  constructor TDBLookupComboBox_mi_Lcl.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);
    Style       := csOwnerDrawEditableFixed;//csOwnerDrawFixed; //csDropDown;
    DropDownRows := 10;
    Anchors      := [akLeft, akTop];//AnchorAlign[alNone];
    ParentFont:=true;
  end;

  constructor TDBLookupComboBox_mi_Lcl.Create(aOwner: TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
  begin
    Create(aOwner);
    Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  end;

  destructor TDBLookupComboBox_mi_Lcl.Destroy;
  begin
    _pDmxFieldRec.LinkEdit:= nil;
    _pDmxFieldRec := nil;
    inherited Destroy;
  end;

  procedure TDBLookupComboBox_mi_Lcl.SetMi_lcl_ui_Form_attributes(Mi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
  begin
    _Mi_lcl_ui_Form_attributes := Mi_lcl_ui_Form_attributes;
    IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
    then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
  end;

  procedure TDBLookupComboBox_mi_Lcl.PutBuffer;
  begin
    DmxFieldRec^.copyFrom(field);
  end;

  procedure TDBLookupComboBox_mi_Lcl.GetBuffer;
  //Var
  //  waccess : Byte;
  //  I : Longint;
  begin
   DmxFieldRec^.CopyTo(Field);
  // with TMi_lcl_ui_Form_attributes do
  // try
  //  waccess := DmxFieldRec.SetAccess(AccNormal);
  //
  //  try
  //     i := StrToInt(DmxFieldRec.AsString);
  //     Self.ItemIndex:= i;;
  ////     Self.KeyValue  := i;
  //  Except
  //    ShowMessage('TDBLookupComboBox_mi_Lcl.GetBuffer');
  //  end;
  //  //text := Self.Items[Self.ItemIndex];
  //
  // finally
  //   DmxFieldRec.SetAccess(waccess);
  // end;
  end;

  procedure TDBLookupComboBox_mi_Lcl.DoOnEnter(Sender: TObject);
  begin
   //if (Self.ItemIndex < 0) or (items.Count<=0)
   //then exit;

   if (DmxFieldRec<>nil ) and (not DmxFieldRec.reintrance_OnEnter)
   then try
          DmxFieldRec.reintrance_OnEnter := true;

          DmxFieldRec.DoOnEnter(Mi_lcl_ui_Form_attributes);
          GetBuffer;

        finally
          DmxFieldRec.reintrance_OnEnter := false;
        end;
  end;

  procedure TDBLookupComboBox_mi_Lcl.DoOnExit(Sender: TObject);
  begin
   if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.reintrance_OnExit)
   then with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
        try
          DmxFieldRec.reintrance_OnExit := true;

          PutBuffer;
          DmxFieldRec.DoOnExit(Self);


          try

            GetBuffer;

          Except
              ShowMessage('exceção inesperada em: TDBLookupComboBox_mi_Lcl.DoOnExit');
          end;

        finally
          DmxFieldRec.reintrance_OnExit := False;
        end;
  end;

  procedure TDBLookupComboBox_mi_Lcl.SetProperty_Data_field;
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

             Field.DisplayLabel := Caption;
             Field.DisplayWidth := DmxFieldRec^.ShownWid;
           end;
    end;
  end;

  procedure TDBLookupComboBox_mi_Lcl.SetData_Field;
  begin
    with Mi_lcl_ui_Form_attributes.DmxScroller_Form do
    begin
      if Assigned(DataSource.DataSet.FindField(DmxFieldRec.FieldName))
      then begin
             Self.DataSource := DataSource;
             Self.DataField  := DmxFieldRec.FieldName;
             if Assigned(DmxFieldRec.FldEnum_Lookup)
             then begin
                     Self.KeyField   := DmxFieldRec.FldEnum_Lookup.KeyField;
                     Self.ListField  := DmxFieldRec.FldEnum_Lookup.ListField;
                     Self.ListSource := DmxFieldRec.FldEnum_Lookup.DataSource;
                  end;
             Self.ListFieldIndex := 1;
             SetProperty_Data_field;
           end;
    end;
  end;


  procedure TDBLookupComboBox_mi_Lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
    Var
      SItems,P:PSItem;
      s : AnsiString;
  begin
    try
      _pDmxFieldRec := apDmxFieldRec;
      if (Mi_lcl_ui_Form_attributes<>nil)
          and (DmxFieldRec<>nil) then
      Try
        Self.Visible  := true;
        Self.TabStop  := True;
        Self.Enabled  := True;
        Self.ReadOnly := false;

        if ((DmxFieldRec^.access and accSkip)<>0)
        then begin
               Self.TabStop  := False;
               Self.ReadOnly := true;
             end;

        if ((DmxFieldRec^.access and accReadOnly)<>0)
        then Self.ReadOnly := true;

        if ((DmxFieldRec^.access and  accHidden)<>0)
        then Visible := false;

        DmxFieldRec.OkSpc := false;
        _reintranceSeTDmxFieldRec := true;
        DmxFieldRec.reintrance_OnEnter := true;
        Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec;

        name := Mi_lcl_ui_Form_attributes.DmxScroller_Form.GetNameValid(Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField.FieldName);

        if DmxFieldRec.HelpCtx_Hint<>''
        then hint := DmxFieldRec.HelpCtx_Hint
        else hint := DmxFieldRec.FieldName;

        if hint <> ''
        Then ShowHint := true
        else ShowHint := False;

        OnEnter     := DoOnEnter;
        onExit      := DoOnExit;
  //          onKeyDown := DoOnKeyDown;
  //            OnKeyPress  := DoOnKeyPress;

        {$REGION '---> Seta tipo de acesso'}
           with Mi_lcl_ui_Form_attributes do
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
                    Self.TabStop  := True;
                    Self.Enabled  := false;
                    Self.ReadOnly := true;
                  end;

             if ((DmxFieldRec^.access and  accHidden)<>0)
             then Visible := false;

           end;
        {$ENDREGION}

        SetData_Field;

        if Owner is TScrollingWinControl
        then with Mi_lcl_ui_Form_attributes do Begin
                AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
                //WidthChar  := ((Owner as TScrollingWinControl).Canvas.TextWidth(Mi_lcl_ui_Form_attributes.CharAlfanumeric)
                //               div Length(Mi_lcl_ui_Form_attributes.CharAlfanumeric));
                //HeightChar := (Owner as TScrollingWinControl).Canvas.TextHeight(Mi_lcl_ui_Form_attributes.CharAlfanumeric);

                Width      := DmxScroller_Form.WidthChar * (DmxFieldRec.ShownWid+7);
                Constraints.MinWidth := width;
                Constraints.MaxWidth := Constraints.MinWidth;
                Constraints.MaxHeight:= DmxScroller_Form.HeightChar;
                Constraints.MinHeight:= Constraints.MaxHeight;
             end;
        MaxLength := DmxFieldRec.TrueLen;

      Finally
        DmxFieldRec.reintrance_OnEnter := False;
  //          DmxFieldRec.Link_IInputText := Self;
        _reintranceSeTDmxFieldRec := False;
      end;

    Except
  //    Raise T ShowMessage('TDBLookupComboBox_mi_Lcl.SeTDmxFieldRec');
      Raise Tmi_Rtl.TException.Create(self,{$I %CURRENTROUTINE%},'Exceção Inesperada!');
    end;
  end;

  function TDBLookupComboBox_mi_Lcl.GetHTMLContent: String;

    var template_select : string = '<select id="~FieldName" name="~FieldName" data-mask-type="~DataMaskType" data-mask="~DataMask" style="position: absolute; top: ~toppx; left: ~leftpx; width: ~widthpx;">';

    var template_options : string =  '<option value="~value">~value</option>';

    //Exemplo de select:
    //'<label for="unidade">Escolha a unidade de medida:</label>'
    //'<select id="unidade" name="unidade">'
    //    '<option value="0">Centímetros</option>'
    //    '<option value="1">Metro</option>'
    //    '<option value="2">Km</option>'
    //'</select>'

   var
     i : integer;
     s : string;
     typCode : string='';
  begin
    result :=  template_select;
    with DmxFieldRec^,owner_UiDmxScroller do
    begin
      Result := StringReplace(Result, '~top'      , intToStr(top)   , [rfReplaceAll]);
      Result := StringReplace(Result, '~left'     , intToStr(left)  , [rfReplaceAll]);
      Result := StringReplace(Result, '~width'     , intToStr(left)  , [rfReplaceAll]);
      case TypeCode of
        ^E : TypCode := '#5';
        ^D : TypCode := '#4';
        else TypCode := '#6'; //Caso o campo tenha sido criada com CreateOptions então o browser deve encarar como campo enumerado
      end;
      Result := StringReplace(Result, '~DataMaskType', TypCode       , [rfReplaceAll]);
      Result := StringReplace(Result, '~DataMask'     , Template_org , [rfReplaceAll]);
      Result := StringReplace(Result, '~FieldName'     , FieldName   , [rfReplaceAll]);


      for I := 0 to Items.Count-1 do
      begin
        s := StringReplace(template_options, '~value', Items[I] , [rfReplaceAll]);
        Result := New_Line + Result+s;
      end;
      Result := New_Line + Result+'</select>';
    end;
  end;


end.
