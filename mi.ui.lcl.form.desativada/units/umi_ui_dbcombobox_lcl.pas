unit uMi_Ui_DbComboBox_lcl;
{: A unit **@name** implementa a class TMI_DbComboBox_LCL com objetivo de ligar os campo tipo TDmxFieldRec com o
   componente TDBComboBox do Lazarus.

   - **VERSÂO**
     - Alpha - 0.9.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_ui_dbComboBox_lcl.pas">uMi_Ui_DbComboBox_lcl.pas</a>)

   - **PENDÊNCIAS**
     - T12: Documentar a unidade.
     - T12: Criar um filtro interativo caso seja digitado um texto.

   - **HISTÓRICO**
     - **24/05/2022**
       - **16:30**
         - Documentar a unidade.
}


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  {$IFnDEF FPC}
    Windows,
  {$ELSE}
    LCLIntf, LCLType, LMessages,
  {$ENDIF}
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, DBCtrls,StdCtrls
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  ,umi_ui_dmxscroller_form_lcl_attributes

  ;

type

  { TMi_DbComboBox_LCL }
  {: A classe **@name** permite edita um campo enumerado do registro **TDmxFieldRec**

     - **NOTA**
       - O item zero contém a string selecionada e caso a mesma seja editada o valor
         digitado passa ser o filtro de pesquisa.
  }
  TMi_DbComboBox_LCL = class(TDBComboBox)
    private
      FImgIndexes: TStringList;
      FImages: TImageList;
      FShowImages: Boolean;
      _itemIndexAnt : Longint;
      procedure SetShowImages(B: Boolean);
      procedure SetImages(IL: TImageList);
      procedure SetImgIndexes(SL: TStringList);
      procedure SetValue(S: String);
      function GetValue: String;

    protected procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
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

    protected procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    protected procedure DoOnEnter(Sender: TObject);
    protected procedure DoOnExit(Sender: TObject);
    protected procedure Select; override;
    protected procedure DoOnKeyPress(Sender: TObject; var Key: system.Char);

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
        strict Private Var _pDmxFieldRec : pDmxFieldRec;
               private _reintranceSeTDmxFieldRec:Boolean;
        strict Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );

        Public
        {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

           - **NOTA**
             - Esses dados devem ser criados pelo método TDmxScroller_Form_Lcl_attributes.CreateStruct(var ATemplate : TString)
        }
        property  DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}

    public procedure Clear; Override;
    public procedure AddValue(aString:String);
    public property Value: String read GetValue write SetValue;

    protected procedure WMPaint(var Message: TLMPaint); message LM_PAINT;

    //published property Values: TStringlist read FValues write SetValues;
    published property ImgIndexes: TStringList read FImgIndexes write SetImgIndexes;
    published property Images: TImageList read FImages write SetImages;
    published property ShowImages: Boolean read FShowImages write SetShowImages;
    published property Color;
//  published  property Ctl3D;
    published property Align;

    published property AutoComplete;
    published property AutoDropDown;
    published property AutoSelect;
    published property OnEditingDone;
    published property AutoSize;
    published property text;
    published Property ItemIndex;
    published property DragMode;
    published property DragCursor;
    published property DropDownCount;
    published property Enabled;
    published property Font;
    published property ItemHeight;
    published property Items;
    published property MaxLength;
    published property ParentColor;
    published property ParentFont;
    published property ParentShowHint;
    published property PopupMenu;
    published property ShowHint;
    published property Sorted;
    published property TabOrder;
    published property TabStop;
    published property Visible;
    published property OnChange;
    published property OnClick;
    published property OnDblClick;
    published property OnDragDrop;
    published property OnDragOver;
    published property OnDrawItem;
    published property OnDropDown;
    published property OnEndDrag;
    published property OnEnter;
    published property OnExit;
    published property OnKeyDown;
    published property OnKeyPress;
    published property OnKeyUp;
    published property OnMeasureItem;
    published property OnStartDrag;
    published property Anchors;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I umi_ui_dbComboBox_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TMi_DbComboBox_lcl]);
//end;

{ TMi_DbComboBox_LCL }


procedure TMi_DbComboBox_LCL.WMPaint(var Message: TLMPaint);
begin
//  GetBuffer;
  inherited WMPaint(Message);
end;



procedure TMi_DbComboBox_LCL.AddValue(aString: String);
begin
  Self.Items.Add(aString);
//  Self.Values.Add(aString);
end;

procedure TMi_DbComboBox_LCL.Clear;
begin
  inherited Clear;
//  Self.Values.Clear;
end;

constructor TMi_DbComboBox_LCL.Create(AOwner: TComponent);
  //Var
  //  i : Integer;
begin
  inherited Create(AOwner);
  //FValues := TStringList.Create;

  FImgIndexes := TStringList.Create;
  FShowImages := False;
  Style       := csOwnerDrawEditableFixed;//csOwnerDrawFixed; //csDropDown;
  DropDownCount := 10;
  Anchors      := [akLeft, akTop];//AnchorAlign[alNone];
end;

constructor TMi_DbComboBox_LCL.Create(aOwner: TComponent;aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  Create(aOwner);
  DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
end;

destructor TMi_DbComboBox_LCL.Destroy;
begin
  //Values.Free;
  FImgIndexes.Free;
  inherited Destroy;
end;
procedure TMi_DbComboBox_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  Var
    SItems,P:PSItem;
    //aTemplate: TDmxScroller_Form_Lcl_attributes.tString;
    i : Integer;
begin
  try
    _pDmxFieldRec := apDmxFieldRec;
    if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil)
    then //with DmxScroller_Form_Lcl_attributes do
         Try
            DmxFieldRec^.OkSpc := false;
            _reintranceSeTDmxFieldRec := true;
            DmxFieldRec^.reintrance_OnEnter := true;
            DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec;

            name := DmxScroller_Form_Lcl_attributes.GetNameValid(DmxScroller_Form_Lcl_attributes.CurrentField.FieldName);

            if DmxFieldRec^.HelpCtx_Hint<>''
            then hint := DmxFieldRec^.HelpCtx_Hint
            else hint := DmxFieldRec^.FieldName;

            if hint <> ''
            Then ShowHint := true
            else ShowHint := False;

            Self.DataSource := DmxScroller_Form_Lcl_attributes.DataSource;
            Self.DataField  := DmxScroller_Form_Lcl_attributes.CurrentField.FieldName ;
            Self.ItemIndex  := 0;

            //system.Move(DmxFieldRec^.Template,SItems,Sizeof(PSItem));
            //P := SItems;
            //While (P<>nil) do
            //begin
            //  if (p.Value<>nil) and (p.Value^ <>'')
            //  then Begin
            //         AddValue(p.Value^);
            //       end;
            //  P := P.next;
            //end;
            if DmxFieldRec^.ListComboBox = nil
            Then begin
                    system.Move(DmxFieldRec^.Template,SItems,Sizeof(PSItem));
                    P := SItems;
                 end
            else Begin
                   P := DmxFieldRec^.ListComboBox;
                 end;
            While (P<>nil) do
            begin
              if (p.Value<>nil) and (p.Value^ <>'')
              then Begin
                     AddValue(p.Value^);
                   end;
              P := P.next;
            end;


            OnMouseDown := DoOnMouseDown;
            OnEnter     := DoOnEnter;
            onExit      := DoOnExit;
  //          onKeyDown := DoOnKeyDown;
            OnKeyPress  := DoOnKeyPress;

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

  //          Self.Alignment := taCenter;
  //          Self.Alignment := taRightJustify;
//            Self.ItemIndex := StrToInt(DmxFieldRec^.AsString);

              Self.ItemIndex := DmxFieldRec^.ListComboBox_Default;
              self.Value     := Items[Self.ItemIndex];

            if Owner is TScrollingWinControl
            then with DmxScroller_Form_Lcl_attributes do Begin
                    AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
//                    WidthChar  := (Owner as TScrollingWinControl).Canvas.TextWidth('AbcdFGHIJKLMNopqRstuVxZ32489738') div 31 ;
                    //WidthChar  := ((Owner as TScrollingWinControl).Canvas.TextWidth(DmxScroller_Form_Lcl_attributes.CharAlfanumeric) div Length(DmxScroller_Form_Lcl_attributes.CharAlfanumeric));
                    //HeightChar := (Owner as TScrollingWinControl).Canvas.TextHeight(DmxScroller_Form_Lcl_attributes.CharAlfanumeric);

//                    if DmxFieldRec^.ListComboBox = nil
//                    then Width      := WidthChar * (DmxFieldRec^.ShownWid+7)
//                    else Begin
////                           i := DmxFieldRec^.MaxItemStrLen(DmxFieldRec^.ListComboBox);
//                           Width := WidthChar * (DmxFieldRec^.ShownWid+7);
//                         end;
                    Width      := (WidthChar * (DmxFieldRec.ShownWid))+(5*WidthChar);

                    Constraints.MinWidth := width;
                    Constraints.MaxWidth := Constraints.MinWidth;
                    Constraints.MaxHeight:= HeightChar;
                    Constraints.MinHeight:= Constraints.MaxHeight;
                 end;
//            MaxLength := DmxFieldRec^.TrueLen;

          Finally
            DmxFieldRec^.reintrance_OnEnter := False;
  //          DmxFieldRec^.Link_IInputText := Self;
            _reintranceSeTDmxFieldRec := False;
          end;

  Except
    ShowMessage('TMi_DbComboBox_LCL.SeTDmxFieldRec');
  end;
end;

  procedure TMi_DbComboBox_LCL.PutBuffer;
    Var
      waccess : Byte;
      s : String;
  begin
    with TDmxScroller_Form_Lcl_attributes do
    try
      waccess := DmxFieldRec^.SetAccess(AccNormal);

      try
        //s := IntToStr(Self.itemIndex);
        //DmxFieldRec^.AsString := S;
         if DmxFieldRec^.ListComboBox = nil
         then begin
                s := IntToStr(Self.itemIndex);
                DmxFieldRec^.AsString := S;
              end
         else Begin
                DmxFieldRec^.AsString := Self.Value;
                //s := DmxFieldRec^.AsString;
                //writeLn(s);
              end;

      Except
        ShowMessage('TMi_DbComboBox_LCL.PutBuffer');
      end;


    finally
      DmxFieldRec^.SetAccess(waccess);
    end;
  end;

  procedure TMi_DbComboBox_LCL.GetBuffer;
   Var
     waccess : Byte;
     I : Longint;
  begin
    with TDmxScroller_Form_Lcl_attributes do
    try
     waccess := DmxFieldRec^.SetAccess(AccNormal);

     try
       // i := StrToInt(DmxFieldRec^.AsString);
       //Self.ItemIndex := I;
       if DmxFieldRec^.ListComboBox = nil
       then begin
              i := StrToInt(DmxFieldRec^.AsString);
              Self.ItemIndex := I;
            end
       else Begin
              Self.Value := DmxFieldRec^.AsString;
              if ItemIndex= -1
              Then Self.ItemIndex := 0;
            end;

     Except
       ShowMessage('TMi_DbComboBox_LCL.GetBuffer');
     end;
     //text := Self.Items[Self.ItemIndex];

    finally
      _itemIndexAnt := itemIndex;
      DmxFieldRec^.SetAccess(waccess);
    end;
  end;

  procedure TMi_DbComboBox_LCL.DoOnMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  begin
      SelectAll;
  end;

  procedure TMi_DbComboBox_LCL.DoOnEnter(Sender: TObject);
  begin
    //if (Self.ItemIndex < 0) or (items.Count<=0)
    //then exit;

    if (DmxFieldRec<>nil ) and (not DmxFieldRec^.reintrance_OnEnter)
    then try
           DmxFieldRec^.reintrance_OnEnter := true;

           DmxFieldRec^.DoOnEnter(DmxScroller_Form_Lcl_attributes);
           GetBuffer;

         finally
           DmxFieldRec^.reintrance_OnEnter := false;
         end;


  end;

  procedure TMi_DbComboBox_LCL.DoOnExit(Sender: TObject);
  begin
    //if (Self.ItemIndex < 0) or (items.Count<=0)
    //then exit;
    if (DmxFieldRec<>nil) and ( Not  DmxFieldRec^.reintrance_OnExit)
    then //with TDmxScroller_Form_Lcl_attributes do
         try
           DmxFieldRec^.reintrance_OnExit := true;

           PutBuffer;
           DmxFieldRec^.DoOnExit(Self);



           try

             GetBuffer;

           Except
               ShowMessage('exceção inesperada em: TMi_DbComboBox_LCL.DoOnExit');
           end;

         finally
           DmxFieldRec^.reintrance_OnExit := False;
         end;


  end;

  procedure TMi_DbComboBox_LCL.Select;
  begin
    //if (Self.ItemIndex < 0) or (items.Count<=0)
    //then exit;
    //
    //if Self.Parent.Visible and Self.Enabled and (not _reintranceSeTDmxFieldRec)
    //   and (not DmxFieldRec^.reintrance_OnEnter) and (not DmxFieldRec^.reintrance_OnExit)
    //then SetFocus;
    inherited Select;
  end;

  procedure TMi_DbComboBox_LCL.DoOnKeyPress(Sender: TObject; var Key: system.Char);
    var
      event :TDmxScroller_Form_Lcl_attributes.TEvent;
      wSelStart,wSelEnd:Integer;
  begin
    if (Self.ItemIndex < 0) or (items.Count<=0)
    then exit;


    {if key = #9
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
      if (DmxFieldRec <> nil)
      then begin
             Event.What    := evKeyDown;
             Event.InfoPtr := nil;
             event.AnsiCharCode := AnsiChar(key);
             event.ShiftState   := 0;//
             wSelStart := GetSelStart;
             wSelEnd   := wSelStart + GetSelLength;

             DmxFieldRec^.CurPos   := wSelStart;
             DmxFieldRec^.SelStart := wSelStart;
             DmxFieldRec^.SelEnd   := wSelEnd;

             try
               Self.PutBuffer;
             Except
               ShowMessage('TMi_DbComboBox_LCL.DoOnKeyPress');
             end;

             DmxScroller_Form_Lcl_attributes.HandleEvent(event);
           end;
      end;

  end;

  Procedure TMi_DbComboBox_LCL.SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);
  begin
    _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
    IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
    then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
  end;

procedure TMi_DbComboBox_LCL.SetShowImages(B: Boolean);
begin
  if FShowImages = B
  then Exit;

  FShowImages := B;
  Invalidate;
end;

procedure TMi_DbComboBox_LCL.SetImages(IL: TImageList);
begin
  FImages := IL;
end;

//procedure TMi_DbComboBox_LCL.SetValues(SL: TStringList);
//begin
//  FValues.Assign(SL);
//end;

procedure TMi_DbComboBox_LCL.SetImgIndexes(SL: TStringList);
begin
  FImgIndexes.Assign(SL);
end;

//procedure TMi_DbComboBox_LCL.SetValue(S: String);
//var
//  I, E: Integer;
//begin
//  E := -1;
//  for I := 0 to Values.Count-1 do
//  begin
//    if UpperCase(Values[I]) = UpperCase(S)
//     then E := I;
//  end;
//  ItemIndex := E;
//end;
procedure TMi_DbComboBox_LCL.SetValue(S: String);
var
  I, E: Integer;
begin
  E := -1;
  for I := 0 to Items.Count-1 do
  begin
    if UpperCase(Items[I]) = UpperCase(S)
     then E := I;
  end;
  ItemIndex := E;
end;
//function TMi_DbComboBox_LCL.GetValue: String;
//begin
//  Result := '';
//  if Values.Count > ItemIndex then
//    Result := Values[ItemIndex];
//end;
function TMi_DbComboBox_LCL.GetValue: String;
begin
  Result := '';
  if (Items.Count > ItemIndex) and (ItemIndex>=0) then
    Result := Items[ItemIndex];
end;

procedure TMi_DbComboBox_LCL.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  I: Integer;
begin
  if (ShowImages = False) or
     (Assigned(Images) = False)
  then begin
         inherited DrawItem(Index, Rect, State);
         Exit;
       end;

  with Canvas do
  begin
    Brush.Color := clWindow;
    if odSelected in State
    then Brush.Color := clActiveCaption;

    FillRect(Rect);

    if ImgIndexes.Count > Index
    then I := StrToInt(ImgIndexes.Strings[Index])
    else I := 0;

    Images.Draw(Canvas, Rect.Left+2, Rect.Top+0, I);
    Font.Color := clWindowText;

    if odSelected in State then Font.Color := clCaptionText;
    TextOut(Rect.Left+23, Rect.Top+2, Items[Index]);
  end;


end;


end.
