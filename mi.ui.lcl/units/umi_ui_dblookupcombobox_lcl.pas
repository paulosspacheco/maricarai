unit umi_ui_dblookupComboBox_lcl;
{: A unit **@name** implementa a class TMI_LookupComboBox_LCL com objetivo de ligar
   os campo tipo TDmxFieldRec.fldEnum com o componente TDbLookupComboBox do Lazarus.

   - **VERSÂO**
     - Alpha - 0.5.0.687

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
         - T12: Criar constructor Create(aOwner:TComponent;aUiDmxScroller : TUiDmxScroller);overload;overload; ✅️
         - T12: Criar destructor Destroy; override;  ✅️
         - T12: Criar propriedade UiDmxScroller; ✅️
         - T12: Criar método Procedure PutBuffer; ✅️
         - T12: Criar método Procedure GetBuffer; ✅️
         - T12: Criar método procedure DoOnEnter(Sender: TObject); ✅️
         - T12: Criar método procedure DoOnExit(Sender: TObject); ✅️
         - T12: Criar propriedade pDmxFieldRec; ✅️
         - T12: Setar atributos:
                - DataField  = TDmxFieldRec.FieldName;✅️
                - DataSource = UiDmxScroller.DataSource✅️
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
  ,mi_rtl_ui_DmxScroller  ;

type

  { TMi_ui_DBLookupComboBox_Lcl }

  TMi_ui_DBLookupComboBox_Lcl = class(TDBLookupComboBox)
     public constructor Create(AOwner:TComponent); override;overload;
     public constructor Create(aOwner:TComponent;aUiDmxScroller : TUiDmxScroller);overload;overload;
     public destructor Destroy; override;
     {$REGION ' # Propriedade UiDmxScroller '}
       private var _UiDmxScroller : TUiDmxScroller;
       private Procedure SetUiDmxScroller (aUiDmxScroller : TUiDmxScroller);
       published property UiDmxScroller : TUiDmxScroller Read _UiDmxScroller write SetUiDmxScroller;
     {$ENDREGION ' # Propriedade UiDmxScroller '}

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
              - Esses dados devem ser criados pelo método TUiDmxScroller.CreateStruct(var ATemplate : TString)
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

constructor TMi_ui_DBLookupComboBox_Lcl.Create(aOwner: TComponent;aUiDmxScroller: TUiDmxScroller);
begin
  Create(aOwner);
  UiDmxScroller := aUiDmxScroller;
end;

destructor TMi_ui_DBLookupComboBox_Lcl.Destroy;
begin
  inherited Destroy;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.SetUiDmxScroller(aUiDmxScroller: TUiDmxScroller);
begin
  _UiDmxScroller := aUiDmxScroller;
  IF (_UiDmxScroller<>nil) and (_UiDmxScroller.CurrentField<>nil)
  then SeTDmxFieldRec(_UiDmxScroller.CurrentField);
end;

procedure TMi_ui_DBLookupComboBox_Lcl.PutBuffer;
Var
  waccess : Byte;
  s : String;
begin
  with TUiDmxScroller do
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
 with TUiDmxScroller do
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

        DmxFieldRec.DoOnEnter(UiDmxScroller);
        GetBuffer;

      finally
        DmxFieldRec.vidis_OnEnter := false;
      end;
end;

procedure TMi_ui_DBLookupComboBox_Lcl.DoOnExit(Sender: TObject);
begin
 if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.vidis_OnExit)
 then //with TUiDmxScroller do
      try
        DmxFieldRec.vidis_OnExit := true;

        PutBuffer;
        DmxFieldRec.DoOnExit(Self);


        if not DmxFieldRec.Valid(TUiDmxScroller.cmDMX_Enter)
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
    if (UiDmxScroller<>nil) and (DmxFieldRec<>nil) then
    Try
      DmxFieldRec.OkSpc := false;
      _VidisSeTDmxFieldRec := true;
      DmxFieldRec.vidis_OnEnter := true;
      UiDmxScroller.CurrentField := DmxFieldRec;

      name := UiDmxScroller.GetNameValid(UiDmxScroller.CurrentField.FieldName);

      if DmxFieldRec.HelpCtx_Hint<>''
      then hint := DmxFieldRec.HelpCtx_Hint
      else hint := DmxFieldRec.FieldName;

      if hint <> ''
      Then ShowHint := true
      else ShowHint := False;

      Self.DataSource := UiDmxScroller.DataSource;
      Self.DataField  := UiDmxScroller.CurrentField.FieldName ;
      Self.KeyField   := UiDmxScroller.CurrentField.FldEnum_Lookup.KeyField;
      Self.ListField  := UiDmxScroller.CurrentField.FldEnum_Lookup.ListField;
      Self.ListSource := UiDmxScroller.CurrentField.FldEnum_Lookup.DataSource;
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
         with UiDmxScroller do
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
      then with UiDmxScroller do Begin
              AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
              //WidthChar  := ((Owner as TScrollingWinControl).Canvas.TextWidth(UiDmxScroller.CharAlfanumeric)
              //               div Length(UiDmxScroller.CharAlfanumeric));
              //HeightChar := (Owner as TScrollingWinControl).Canvas.TextHeight(UiDmxScroller.CharAlfanumeric);

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
