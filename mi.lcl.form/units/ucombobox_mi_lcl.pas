unit uCombobox_mi_lcl;
{: A unit **@name** implementa a class TMI_ComboBox_LCL com objetivo de ligar os campo tipo TDmxFieldRec com o
   componente TComboBox do Lazarus.

   - **VERSÃO**
     - Alpha - 0.9.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/mi_ui_ComboBox_lcl.pas">mi_ui_ComboBox_LCL.pas</a>)

   - **PENDÊNCIAS**
     - T12: Documentar a unidade
     - T12 Mudar tipo de dado do campo Tmi_ui_ComboxBox_lcl.
           Ao invés de usar o índice salvar a descrição da lista selecionada.
           Pode ser que esteja travando por conta disso.
     - T12: Criar um filtro interativo caso o elemento selecionando seja alterado.

   - **HISTÓRICO**
     - **24/05/2022**
       - **16:30**
         - Documentar a unidade.

     - **20/06/2022**
       - **15:00**
         - Dar opção para getBuffer e putBuffer usar Value ou ItemIndex.
           - Quando **pDmxFieldRec.ListComboBox** <> nil usar **Value** e
             se **pDmxFieldRec.ListComboBox**=nil usar ItemIndex.
       - **20:30**
         - Documentar classe TMI_ComboBox_LCL .
}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}
{$H+}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,LResources
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  //,umi_lcl_ui_dmxscroller_form_attributes
  ,uMi_lcl_ui_Form_attributes
;

type

  { TMI_ComboBox_LCL }
  {: A classe **@name** permite edita um campo enumerado do componente **TDmxFieldRec**

     - **NOTA**
       - O item zero cont�m a string selecionada e caso a mesma seja editada o valor
         digitado passa ser o filtro de pesquisa.
  }
  TComboBox_mi_LCL = class(TComboBox)

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
    public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;overload;
    public destructor Destroy; override;

    {$REGION ' # Propriedade Mi_lcl_ui_Form_attributes'}
      private var _Mi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes;
      private Procedure SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
      published property Mi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes write SetMi_lcl_ui_Form_attributes;
    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes'}

    {: O método **@name** transfere os dados do controle para o componente TMI_rtl_ui_DmxScroller.
       - **NOTA**
         - Quando **pDmxFieldRec.ListComboBox** <> nil usar **Value** e
            se **pDmxFieldRec.ListComboBox**=nil usar ItemIndex.
         - A propriedade **Value** pode ser qualquer valor.
    }
    public Procedure PutBuffer;
    {: O método **@name** transfere os dados do controle para o componente TMI_rtl_ui_DmxScroller.
       - **NOTA**
         -  Quando **pDmxFieldRec.ListComboBox** <> nil usar **Value** e
             se **pDmxFieldRec.ListComboBox**=nil usar ItemIndex.
    }
    public Procedure GetBuffer;
    protected procedure DoOnMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    protected procedure DoOnEnter(Sender: TObject);
    protected procedure DoOnExit(Sender: TObject);
    protected procedure Select; override;
    protected procedure DoOnKeyPress(Sender: TObject; var Key: system.Char);

    {$REGION ' ---> Property DmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;
      private _reintranceSeTDmxFieldRec:Boolean;
      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );

      {: O atributo **@name** fornece os dados necess�rios para criar o componente TMI_MaskEdit_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo m�todo TMi_lcl_ui_Form_attributes.CreateStruct(var ATemplate : TString)
      }
      Public property  DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}

    public procedure Clear; Override;
    public procedure AddValue(aString:String);
    public property Value: String read GetValue write SetValue;

    protected procedure WMPaint(var Message: TLMPaint); message LM_PAINT;

  published
//    property Values: TStringlist read FValues write SetValues;
    property ImgIndexes: TStringList read FImgIndexes write SetImgIndexes;
    property Images: TImageList read FImages write SetImages;
    property ShowImages: Boolean read FShowImages write SetShowImages;
    property Color;
//    property Ctl3D;
    property Align;

    property AutoComplete;
    property AutoDropDown;
    property AutoSelect;
    property OnEditingDone;
    property AutoSize;
    property text;
    Property ItemIndex;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property Items;
    property MaxLength;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
    property Anchors;


  end;

//procedure Register;

implementation

//procedure Register;
//begin
//
//  {$I umi_ui_ComboBox_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl', [TComboBox_mi_LCL]);
//end;


procedure TComboBox_mi_LCL.WMPaint(var Message: TLMPaint);
begin
  //if not (csFocusing in ControlState)
  //then GetBuffer;
  inherited WMPaint(Message);
end;


procedure TComboBox_mi_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  Var
    SItems,P:PSItem;
    t1,t2 : Integer;
begin
  try
    _pDmxFieldRec := apDmxFieldRec;
    if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil) then
    Try
      DmxFieldRec.OkSpc := false;
      _reintranceSeTDmxFieldRec := true;
      DmxFieldRec.reintrance_OnEnter := true;
      Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec;

      name := Mi_lcl_ui_Form_attributes.DmxScroller_Form.GetNameValid(Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField.FieldName);

      if DmxFieldRec.HelpCtx_Hint<>''
      then hint := DmxFieldRec.HelpCtx_Hint
      else hint := DmxFieldRec.Alias;

      if hint <> ''
      Then ShowHint := true
      else ShowHint := False;

      {$REGION '---> Seta tipo de acesso'}
         with Mi_lcl_ui_Form_attributes do
         begin
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

         end;
      {$ENDREGION}

      if (DmxFieldRec.TypeCode = fldENUM) or
         (DmxFieldRec.ListComboBox <> nil)
      then begin
              if DmxFieldRec.ListComboBox = nil
              Then begin
                      system.Move(DmxFieldRec.Template,SItems,Sizeof(PSItem));
                      P := SItems;
                   end
              else Begin
                     P := DmxFieldRec.ListComboBox;
                   end;
              While (P<>nil) do
              begin
                if (p.Value<>nil) and (p.Value^ <>'')
                then Begin
                       AddValue(p.Value^);
                     end;
                P := P.next;
              end;
           end;
      //t1 := DmxFieldRec^.ListComboBox_Default;
      //t2 := Items.Count;
      if DmxFieldRec^.ListComboBox_Default > Items.Count-1
      then begin
             //Procurar em que situação DmxFieldRec.ListComboBox_Default é maior
             //que Items.Count-1
             DmxFieldRec.ListComboBox_Default := 0;
          end;

      Self.ItemIndex := DmxFieldRec.ListComboBox_Default;
      if Self.ItemIndex>=0
      Then   self.Value     := Items[Self.ItemIndex];
//      PutBuffer;
      OnMouseDown := DoOnMouseDown;
      OnEnter     := DoOnEnter;
      onExit      := DoOnExit;
  //          onKeyDown := DoOnKeyDown;
      OnKeyPress  := DoOnKeyPress;


      Width  := (Mi_lcl_ui_Form_attributes.DmxScroller_Form.WidthChar * (DmxFieldRec.ShownWid+4));
      Height := Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;


      if Owner is TScrollingWinControl
      then with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
           Begin
              AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.


              Constraints.MinHeight:= Height;
              Constraints.MaxHeight:= Constraints.MinHeight+4;

              Constraints.MinWidth := width;
              Constraints.MaxWidth := Constraints.MinWidth+4;
           end;
       MaxLength := DmxFieldRec.TrueLen;

    Finally
      DmxFieldRec.reintrance_OnEnter := False;
    //          DmxFieldRec.Link_IInputText := Self;
      _reintranceSeTDmxFieldRec := False;
    end;

  Except
    ShowMessage('TComboBox_mi_LCL.SeTDmxFieldRec');
  end;
end;


procedure TComboBox_mi_LCL.AddValue(aString: String);
begin
  Self.Items.Add(aString);
//  Self.Values.Add(aString);
end;

procedure TComboBox_mi_LCL.Clear;
begin
  inherited Clear;
//  Self.Values.Clear;
end;

constructor TComboBox_mi_LCL.Create(AOwner: TComponent);
  //Var
  //  i : Integer;
begin
  inherited Create(AOwner);
  //FValues := TStringList.Create;

  FImgIndexes := TStringList.Create;
  FShowImages := False;
  Style       := csOwnerDrawFixed;//csDropDown;
  DropDownCount := 10;
//  Anchors      := [akLeft, akTop];//AnchorAlign[alNone];
  ParentFont:=true;
  //if aOwner is TScrollingWinControl
  //then begin
  //       font.name := (aOwner as TScrollingWinControl).Font.Name;
  //       font.Size := (aOwner as TScrollingWinControl).Font.Size;
  //     end;
end;

constructor TComboBox_mi_LCL.Create(aOwner: TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(aOwner);
  Mi_lcl_ui_Form_attributes:= aMi_lcl_ui_Form_attributes;
end;

destructor TComboBox_mi_LCL.Destroy;
begin
  //Values.Free;
  FImgIndexes.Free;
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited Destroy;
end;

  procedure TComboBox_mi_LCL.PutBuffer;
    Var
      waccess : Byte;
      s : String;
  begin
    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
    try
      waccess := DmxFieldRec.SetAccess(AccNormal);
      try
         if DmxFieldRec.ListComboBox = nil
         then begin
                s := IntToStr(Self.itemIndex);
                DmxFieldRec.AsString := S;
              end
         else Begin
                DmxFieldRec.AsString := Self.Value;
              end;
      Except
        ShowMessage('TComboBox_mi_LCL.PutBuffer');
      end;

      //if not DmxFieldRec.Valid(cmDMX_Enter)
      //then abort;

    finally
      DmxFieldRec.SetAccess(waccess);
    end;
  end;

  procedure TComboBox_mi_LCL.GetBuffer;
   Var
     waccess : Byte;
     I : Longint;
     s : AnsiString;
  begin
    with TMi_lcl_ui_Form_attributes do
    try
     waccess := DmxFieldRec.SetAccess(AccNormal);

     try
       if DmxFieldRec.ListComboBox = nil
       then begin
              i := StrToInt(DmxFieldRec.AsString);
              Self.ItemIndex := I;
            end
       else Begin
              Self.Value := DmxFieldRec.AsString;
              if ItemIndex= -1
              Then Self.ItemIndex := 0;
            end;
     Except
       ShowMessage('TComboBox_mi_LCL.GetBuffer');
     end;

    finally
      _itemIndexAnt := itemIndex;
      DmxFieldRec.SetAccess(waccess);
    end;
  end;

  procedure TComboBox_mi_LCL.DoOnMouseDown(Sender: TObject; Button: TMouseButton;Shift: TShiftState; X, Y: Integer);
  begin
//    Inherited DoOnMouseDown(Sender,Button,Shift,X, Y);
    SelectAll;
  end;

  procedure TComboBox_mi_LCL.DoOnEnter(Sender: TObject);
  begin
    if (DmxFieldRec<>nil ) //and (not DmxFieldRec.reintrance_OnEnter)
    then try
//           DmxFieldRec.reintrance_OnEnter := true;

           DmxFieldRec.DoOnEnter(Mi_lcl_ui_Form_attributes);
           if DmxFieldRec.FieldAltered
           then GetBuffer;

         finally
//           DmxFieldRec.reintrance_OnEnter := false;
         end;


  end;

  procedure TComboBox_mi_LCL.DoOnExit(Sender: TObject);
  begin


    if (DmxFieldRec<>nil) //and ( Not  DmxFieldRec.reintrance_OnExit)
    then with Mi_lcl_ui_Form_attributes do
         try
//           DmxFieldRec.reintrance_OnExit := true;
           PutBuffer;
           DmxFieldRec.DoOnExit(Self);

           try
             GetBuffer;
           Except
             ShowMessage('Excessão inesperada em: TComboBox_mi_LCL.DoOnExit');
           end;

         finally
//           DmxFieldRec.reintrance_OnExit := False;
         end;


  end;

  procedure TComboBox_mi_LCL.Select;
  begin
    if (Self.ItemIndex < 0) or (items.Count<=0)
    then exit;

    //if Self.Parent.Visible andSelf.Enabled //and (not _reintranceSeTDmxFieldRec)
    //   //and (not DmxFieldRec.reintrance_OnEnter) and (not DmxFieldRec.reintrance_OnExit)
    //then SetFocus;
    inherited Select;
  end;

  procedure TComboBox_mi_LCL.DoOnKeyPress(Sender: TObject; var Key: system.Char);
    var
      event :TDmxScroller_Form.TEvent;
      wSelStart,wSelEnd:Integer;
  begin
    if (Self.ItemIndex < 0) or (items.Count<=0)
    then exit;

    //pesquisa interativa com banco de dados nos campos ComboBox.
    with Mi_lcl_ui_Form_attributes do
    begin
      if (DmxFieldRec <> nil)
      then begin
             Event.What    := TDmxScroller_Form.evKeyDown;
             Event.InfoPtr := nil;
             event.AnsiCharCode := AnsiChar(key);
             event.ShiftState   := 0;//
             wSelStart := GetSelStart;
             wSelEnd   := wSelStart + GetSelLength;

             DmxFieldRec.CurPos   := wSelStart;
             DmxFieldRec.SelStart := wSelStart;
             DmxFieldRec.SelEnd   := wSelEnd;

             try
               Self.PutBuffer;
             Except
               ShowMessage('TComboBox_mi_LCL.DoOnKeyPress');
             end;

             Mi_lcl_ui_Form_attributes.DmxScroller_Form.HandleEvent(event);
           end;
      end;

  end;

  procedure TComboBox_mi_LCL.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
  begin
    _Mi_lcl_ui_Form_attributes:= aMi_lcl_ui_Form_attributes;
    IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
    then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
  end;


procedure TComboBox_mi_LCL.SetShowImages(B: Boolean);
begin
  if FShowImages = B
  then Exit;

  FShowImages := B;
  Invalidate;
end;

procedure TComboBox_mi_LCL.SetImages(IL: TImageList);
begin
  FImages := IL;
end;

//procedure TComboBox_mi_LCL.SetValues(SL: TStringList);
//begin
//  FValues.Assign(SL);
//end;

procedure TComboBox_mi_LCL.SetImgIndexes(SL: TStringList);
begin
  FImgIndexes.Assign(SL);
end;

procedure TComboBox_mi_LCL.SetValue(S: String);
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
//function TComboBox_mi_LCL.GetValue: String;
//begin
//  Result := '';
//  if Values.Count > ItemIndex then
//    Result := Values[ItemIndex];
//end;
function TComboBox_mi_LCL.GetValue: String;
begin
  Result := '';
  if (Items.Count > ItemIndex) and (ItemIndex>=0) then
    Result := Items[ItemIndex];
end;

procedure TComboBox_mi_LCL.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
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


