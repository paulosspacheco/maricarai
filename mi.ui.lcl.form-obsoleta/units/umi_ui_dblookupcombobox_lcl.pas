unit umi_ui_dblookupComboBox_lcl;
{: A unit **@name** implementa a class TMI_LookupComboBox_LCL com objetivo de ligar
   os campo tipo TDmxFieldRec.fldEnum com o componente TDbLookupComboBox do Lazarus.

   - **VERSÂO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/uMi_ui_DBLookupComboBox_Lcl.pas">uMi_ui_DBLookupComboBox_Lcl.pas</a>)

   - **PENDÊNCIAS**
     - T12: Documentar a unidade.
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
  ,umi_ui_dmxscroller_form_lcl_attributes  ;

type

  { TMi_ui_DBLookupComboBox_Lcl }

  TMi_ui_DBLookupComboBox_Lcl = class(TDBLookupComboBox)
     public constructor Create(AOwner:TComponent); override;overload;
     public constructor Create(aOwner:TComponent;aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);overload;overload;
     public destructor Destroy; override;
     {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
       private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;
       private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);
       published property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes write SetDmxScroller_Form_Lcl_attributes;
     {$ENDREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}

     public Procedure PutBuffer;
     public Procedure GetBuffer;
     protected procedure DoOnEnter(Sender: TObject);
     protected procedure DoOnExit(Sender: TObject);


     {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
         strict Private Var _pDmxFieldRec : pDmxFieldRec;
                private _VidisSeTDmxFieldRec:Boolean;
         strict Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );

         Public
         {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

            - **NOTA**
              - Esses dados devem ser criados pelo método TDmxScroller_Form_Lcl_attributes.CreateStruct(var ATemplate : TString)
         }
         property  DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
     {$ENDREGION}



  end;

procedure Register;

implementation

procedure Register;
begin
  {$I uMi_ui_DBLookupComboBox_Lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl',[TMi_ui_DBLookupComboBox_Lcl]);
end;

{ TMi_ui_DBLookupComboBox_Lcl }

constructor TMi_ui_DBLookupComboBox_Lcl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Style       := csOwnerDrawEditableFixed;//csOwnerDrawFixed; //csDropDown;
  DropDownCount := 10;
  Anchors      := [akLeft, akTop];//AnchorAlign[alNone];
end;

constructor TMi_ui_DBLookupComboBox_Lcl.Create(aOwner: TComponent;aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  Create(aOwner);
  DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
end;

destructor TMi_ui_DBLookupComboBox_Lcl.Destroy;
begin
  inherited Destroy;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;

procedure TMi_ui_DBLookupComboBox_Lcl.PutBuffer;
Var
  waccess : Byte;
  s : String;
begin
  with TDmxScroller_Form_Lcl_attributes do
  try
    waccess := DmxFieldRec.SetAccess(AccNormal);

    try
      s := IntToStr(Self.itemIndex);
      DmxFieldRec.AsString := S;
    Except
      ShowMessage('TMi_ui_DBLookupComboBox_Lcl.PutBuffer');
    end;

    if not DmxFieldRec.Valid(cmDMX_Enter)
    then abort;

  finally
    DmxFieldRec.SetAccess(waccess);
  end;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.GetBuffer;
Var
  waccess : Byte;
  I : Longint;
begin
 with TDmxScroller_Form_Lcl_attributes do
 try
  waccess := DmxFieldRec.SetAccess(AccNormal);

  try
     i := StrToInt(DmxFieldRec.AsString);
     Self.ItemIndex:= i;;
//     Self.KeyValue  := i;
  Except
    ShowMessage('TMi_ui_DBLookupComboBox_Lcl.GetBuffer');
  end;
  //text := Self.Items[Self.ItemIndex];

 finally
   DmxFieldRec.SetAccess(waccess);
 end;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.DoOnEnter(Sender: TObject);
begin
 //if (Self.ItemIndex < 0) or (items.Count<=0)
 //then exit;

 if (DmxFieldRec<>nil ) and (not DmxFieldRec.vidis_OnEnter)
 then try
        DmxFieldRec.vidis_OnEnter := true;

        DmxFieldRec.DoOnEnter(DmxScroller_Form_Lcl_attributes);
        GetBuffer;

      finally
        DmxFieldRec.vidis_OnEnter := false;
      end;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.DoOnExit(Sender: TObject);
begin
 if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.vidis_OnExit)
 then //with TDmxScroller_Form_Lcl_attributes do
      try
        DmxFieldRec.vidis_OnExit := true;

        PutBuffer;
        DmxFieldRec.DoOnExit(Self);


        if not DmxFieldRec.Valid(TDmxScroller_Form_Lcl_attributes.cmDMX_Enter)
        then abort;

        try

          GetBuffer;

        Except
            ShowMessage('exceção inesperada em: TMi_ui_DBLookupComboBox_Lcl.DoOnExit');
        end;

      finally
        DmxFieldRec.vidis_OnExit := False;
      end;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  Var
    SItems,P:PSItem;
    s : AnsiString;
begin
  try
    _pDmxFieldRec := apDmxFieldRec;
    if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil) then
    Try
      DmxFieldRec.OkSpc := false;
      _VidisSeTDmxFieldRec := true;
      DmxFieldRec.vidis_OnEnter := true;
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
      Self.KeyField   := DmxScroller_Form_Lcl_attributes.CurrentField.FldEnum_Lookup.KeyField;
      Self.ListField  := DmxScroller_Form_Lcl_attributes.CurrentField.FldEnum_Lookup.ListField;
      Self.ListSource := DmxScroller_Form_Lcl_attributes.CurrentField.FldEnum_Lookup.DataSource;
      Self.ListFieldIndex := 1;
      DmxFieldRec^.Value := DmxFieldRec^.ListComboBox_Default ;
      Self.ItemIndex := StrToInt(DmxFieldRec.AsString);
//            s := IntToStr(DmxFieldRec^.ListComboBox_Default);
//            Self.DataSource.DataSet.Locate('id',s,[loCaseInsensitive]);

//            OnMouseDown := DoOnMouseDown;
      OnEnter     := DoOnEnter;
      onExit      := DoOnExit;
//          onKeyDown := DoOnKeyDown;
//            OnKeyPress  := DoOnKeyPress;

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
                  Self.TabStop  := True;
                  Self.Enabled  := false;
                  Self.ReadOnly := true;
                end;

           if ((DmxFieldRec^.access and  accHidden)<>0)
           then Visible := false;

         end;
      {$ENDREGION}

//          Self.Alignment := taCenter;
//          Self.Alignment := taRightJustify;

      if Owner is TScrollingWinControl
      then with DmxScroller_Form_Lcl_attributes do Begin
              AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
              //WidthChar  := ((Owner as TScrollingWinControl).Canvas.TextWidth(DmxScroller_Form_Lcl_attributes.CharAlfanumeric)
              //               div Length(DmxScroller_Form_Lcl_attributes.CharAlfanumeric));
              //HeightChar := (Owner as TScrollingWinControl).Canvas.TextHeight(DmxScroller_Form_Lcl_attributes.CharAlfanumeric);

              Width      := WidthChar * (DmxFieldRec.ShownWid+7);
              Constraints.MinWidth := width;
              Constraints.MaxWidth := Constraints.MinWidth;
              Constraints.MaxHeight:= HeightChar;
              Constraints.MinHeight:= Constraints.MaxHeight;
           end;
      MaxLength := DmxFieldRec.TrueLen;

    Finally
      DmxFieldRec.vidis_OnEnter := False;
//          DmxFieldRec.Link_IInputText := Self;
      _VidisSeTDmxFieldRec := False;
    end;

  Except
    ShowMessage('TMi_ui_DBLookupComboBox_Lcl.SeTDmxFieldRec');
  end;
end;


end.
