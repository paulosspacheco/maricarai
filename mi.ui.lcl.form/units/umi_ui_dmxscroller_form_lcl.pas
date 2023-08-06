unit uMi_ui_Dmxscroller_form_lcl;
  {:< A unit **@name** implementa a classe TDmxScroller_Form.

    - Primeiro autor: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

    - **VERSÃO**
      - Alpha - 0.8.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/umi_ui_dmxscroller_form.pas">uMi_rtl_ui_Dmxscroller_form.pas</a>)

    - **HISTÓRICO**:
      - @html(<a href="../units/umi_ui_dmxscroller_form_historico.html">umi_ui_dmxscroller_form_historico.html</a>)

    - **PENDÊNCIAS**
      - T12 Documentar a unit.
      - T12 Em SetParentLCL ao selecionar a fonte Courier New é preciso saber se a mesma existe,
            caso não existe a tabulação fica maluca.
      - T12 TMi_ui_Data_lcl
      - T12 TMi_ui_Hora_lcl
      - T12 TMi_ui_DataHora_lcl
      - T12 TMI_ui_Text_LCL

    - **CONCLUÍDO**
      - Criar atributo protected FldRadioButtonsAdicionados:TStringList;✅
      - Criar método protected procedure ShowControlState;override;  ✅
      - Criar método procedure Scroll_it_inview_LCL ✅
      - Criar método public procedure Scroll_it_inview ✅
      - Criar método protected procedure CreateFormLCL ✅

      - Criar método protected   procedure UpdateBuffers_Controls;virtual;  ✅
      - Criar método public procedure UpdateBuffers;override;  ✅
      - Criar método public procedure Refresh;override;  ✅
      - Criar método private _ParentLCL : TScrollingWinControl;  ✅
      - Criar método private procedure SetParentLCL ✅
      - Criar propriedade published Property ParentLCL  ✅
      - Criar método protected procedure SetActiveLCL(aActive: Boolean);virtual;  ✅
      - Criar método public procedure ModifyFontsAll_LCL ✅
      - Criar método public procedure ModifyFontsAll_LCL(ctrl: TWinControl;aFontName:String); ✅
      - Criar método public function GetWidthChar():integer;Overload;  ✅
      - T12 TMI_ui_Edit_LCL ✅
      - T12 TMI_ui_ComboBox_LCL ✅
      - T12 TMI_ui_Check_LCL ✅
      - T12 TMI_ui_RadioButton_Lcl ✅
      - T12 TMI_ui_Button ✅
      - T12 TMi_ui_Label_Lcl ✅
  }

{$mode Delphi}

interface

uses
  Classes, SysUtils,controls,StdCtrls,forms,typInfo,types,Graphics,
  ActnList,db,dbctrls, variants, LazHelpHtml,UTF8Process,Dialogs
  ,mi.rtl.Consts
  ,mi_rtl_ui_DmxScroller_Form
  ,umi_ui_dmxscroller_form_lcl_attributes

//  ,mi_rtl_ui_Dmxscroller_sql
  ,uMi_ui_maskedit_lcl
  ,uMi_ui_ComboBox_lcl
//  ,uMi_bitbtn_lcl
  ,umi_ui_button_lcl
  ,umi_ui_checkbox_lcl
  ,umi_ui_radiogroup_lcl
  ,uMi_ui_Label_lcl
  ,uMi_ui_ScrollBox_lcl
   ;

//Constantes publicas
{$include ../mi.rtl/units/mi.rtl.consts.inc}

type
  { Os tipos abaixo foi declarado fora da classe TDmxScroller_Form_Atributos para
     que os componentes não derivados de TDmxScroller_Form_Atributos possam reconhece-los 
     sem declarar o nome da classe TDmxScroller_Form_Atributos.}

  TDmxFieldRec = mi_rtl_ui_DmxScroller_Form.TDmxFieldRec;
  pDmxFieldRec = mi_rtl_ui_DmxScroller_Form.pDmxFieldRec;
  SmallWord    = mi_rtl_ui_DmxScroller_Form.SmallWord;

  { TDmxScroller_Form_Lcl }
  {: A classe **@name** implementa a construção de formulários usando uma lista
     de Templates do tipo TDmxScroller}
  TDmxScroller_Form_Lcl = class(TDmxScroller_Form_Lcl_attributes)
    public constructor Create(aOwner:TComponent);Override;

    protected procedure ShowControlState;override;

    {: https://lazarus-ccr.sourceforge.io/docs/lcl/forms/tcontrolscrollbar.html}
    procedure Scroll_it_inview_LCL(AScrollWindow:TScrollingWinControl; AControl: TControl);

    {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
       - **NOTA**
          - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
    }
    public procedure Scroll_it_inview(AControl: pDmxFieldRec);override;

    {: O Método **@name** cria o formulário LCL baseado na lista de campos PDmxScroller. }
    protected procedure CreateFormLCL(aOwner:TScrollingWinControl);virtual;

    protected   procedure UpdateBuffers_Controls;override;
    public procedure UpdateBuffers;override;

    {: O método **@name** refresh repinta os campo se foi auterado. }
    public procedure Refresh;override;

    {: A procedure **@name** seta a propriedade active  e criar um formulário
       LCL
    }
    protected procedure SetActiveTarget(aActive: Boolean);Override;

    {: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
    public procedure ModifyFontsAll_LCL(ctrl: TWinControl;aFontName:String;aSize:integer);overload;

    {: O método **@name** altera a fonte do controle passado por **ctrl** e de seus filhos.}
    public procedure ModifyFontsAll_LCL(ctrl: TWinControl;aFontName:String);overload;

    {: Essa média só funciona bem para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
    public function GetWidthChar():integer;Overload;
//    public function GetWidthChar(s:string):integer;Overload;

    //Verifica se o componente fornecido possui uma relação db e se o conteúdo foi alterado
    public class function isValueDbChanged(Sender: TComponent): Boolean;override;

    public class function TextWidthChar(AFont: TFont): Integer;

    {: O método @name Executa o browser padrão do sistema operacional.

       - Exemplo:

         ```pascal

           program Project1;
            uses
              Interfaces,
              mi_rtl_ui_methods;
           begin

            TUiMethods.ShowHtml('https://wiki.freepascal.org/Webbrowser');

           end.
         ```
    }
    Public class Procedure ShowHtml(URL:string);override;

    {: O método **@name** inicia a documentação resumida do campo. aFldNum }
    Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;override;

    {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
    Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);override;overload;

    published property name;
    published property Alias;
    published property Strings;
    published property OnAddTemplate;
    Published property OnNewRecord;
    published Property onCloseQuery;
    published Property onEnter;
    published Property onExit;
    published Property onEnterField;
    published Property onExitField;
    published property onGetTemplate;
    published property Active;
    published property AlignmentLabels;
    published property ActionList;
  end;

procedure Register;

implementation

const
  vidis : boolean = false;

procedure Register;
begin
  RegisterComponents('Mi.Ui.Lcl.Form', [TDmxScroller_Form_Lcl]);
end;


constructor TDmxScroller_Form_Lcl.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
//
//  If MessageDlg('Test','Teste do raise no constuctor.'+^M+
//              ^M+
//              'Aborta o componente?'
//              ,MtConfirmation,mbYesNoCancel,0,mbNo)= MrYes
//  then raise EFOpenError.Createfmt('teste raise em constructor',[]);
end;

procedure TDmxScroller_Form_Lcl.ShowControlState;
  //var s: string;
begin
  if ParentLCL is TScrollingWinControl
  then begin
         if csFocusing in (ParentLCL as TScrollingWinControl).ControlState
         then MessageBox('csFocusing in ControlState ');
  end;
  //inherited ShowControlState;
end;


//https://lazarus-ccr.sourceforge.io/docs/lcl/forms/tcontrolscrollbar.html
procedure TDmxScroller_Form_Lcl.Scroll_it_inview_LCL(AScrollWindow:TScrollingWinControl; AControl: TControl);
var
  xRect: types.TRect;
  APar :TControl; //added;
  aClientHeight,aClientWidth :Integer;
begin

  With AScrollWindow do
  Begin
    if AControl=nil
    then Exit;
    aClientHeight := AScrollWindow.ClientHeight;
    aClientWidth  := AScrollWindow.ClientWidth;
//    aPosition     := VertScrollBar.Position;

    xRect := AControl.BoundsRect;

   {---Added---}
    APar := ACOntrol.Parent;
    While APar <> AScrollWindow do
    Begin
      OffsetRect(xRect, Apar.BoundsRect.Left, Apar.BoundsRect.Top);
      Apar := Apar.Parent;
      if Apar = Nil
      Then Exit; //Obviously the control isn't parented
    end;

    {--_End of added--}
    OffsetRect(xRect, -HorzScrollBar.Position, -VertScrollBar.Position);

    if xRect.Left < 0
    then HorzScrollBar.Position := HorzScrollBar.Position + xRect.Left
    else if xRect.Right > aClientWidth
         then begin
                if xRect.Right - xRect.Left > aClientWidth
                then xRect.Right := xRect.Left + aClientWidth;
                HorzScrollBar.Position := HorzScrollBar.Position + xRect.Right - aClientWidth;
              end;

    if xRect.Top < 0
    then VertScrollBar.Position := VertScrollBar.Position + xRect.Top +HeightChar
    else if xRect.Bottom > ClientHeight then
         begin
           if xRect.Bottom - xRect.Top > aClientHeight
           then xRect.Bottom := xRect.Top + aClientHeight;
           VertScrollBar.Position := VertScrollBar.Position + xRect.Bottom - aClientHeight + HeightChar;
         end;
  end;
end;

procedure TDmxScroller_Form_Lcl.Scroll_it_inview(AControl: pDmxFieldRec);
begin
  inherited Scroll_it_inview(AControl);
  if Assigned(AControl) and (ParentLCL is TScrollingWinControl) and (AControl.LinkEdit is TControl)
  then with ParentLCL as TScrollingWinControl do
       begin
//         Scroll_it_inview_LCL(ParentLCL as TScrollingWinControl,  AControl.LinkEdit as TControl);
//         ScrollBy(WidthChar,-HeightChar);
        ScrollInView((AControl.LinkEdit as TControl));
       end;
end;

{function TextWidthChar(AFont: TFont): Integer;
var
  bmp: TCustomBitmap;
begin
  Result := 0;
  bmp := TCustomBitmap.Create;
  try
    bmp.Canvas.Font.Assign(AFont);
    Result := bmp.Canvas.TextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738') div 32;
//    WidthChar  := MyGetTextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738',(aOwner as TScrollingWinControl).Canvas.font)  div 32;

  finally
    bmp.Free;
  end;
end;
}

procedure TDmxScroller_Form_Lcl.CreateFormLCL(aOwner: TScrollingWinControl);

   {: O método **@name** pesquisa todos os campo que são iguais a tipo DMXFields[i]
       e insere um controle TRadioGroup com os itens TRadioButton dentro.
    }
   Function GetRadioButtonLCL(aFristRadioGroupField:pDmxFieldRec;j:integer):TMi_RadioGroup_LCL;

     Function JaFoiInserido(var aFieldNum:Integer):Boolean;
      begin
        result := FldRadioButtonsAdicionados.IndexOf(IntToStr(aFieldNum)) >= 0;
      end;

     Var
        i : integer;
        p : pDmxFieldRec  ;
        R : TRadioButton;

   begin
      Result := nil;
      if JaFoiInserido(aFristRadioGroupField.FieldNum)
      then exit;

      if aFristRadioGroupField.FieldName <> ''
      then FldRadioButtonsAdicionados.Add(IntToStr(aFristRadioGroupField.FieldNum));

      Result := TMi_RadioGroup_LCL.Create(aOwner);
      Result.DmxScroller_Form_Lcl_attributes:= Self;
      if aFristRadioGroupField.Fieldnum <> 0
      Then Result.Caption := aFristRadioGroupField.FieldName;

      // Adiciona a lista de opções
      for i := j to DMXFields.Count-1 do
      begin
        p  := DMXFields[i];
        while (p) <> nil do
        begin
          if p^.Template <> nil
          then begin
                 if (p^.TypeCode = FldRadioButton) and
                    (aFristRadioGroupField.FieldNum=p.FieldNum)
                 then begin
//                        writeLn(Format('Número: %d | Nome: %s | Alias %s',[p^.FieldNum,p^.FieldName,p^.alias]));
                        Result.Items.Add(p^.Alias);
                      end;
               end;
           p := p^.Next;
        end;
      end;

      //Atualiza as propriedades dos itens da lista. Não sei como fazer...
      //For i := 0 to Result.Items.Count-1 do
      //begin
      //  Result.TabStop:=true;
      //end;
    end;

  //Variáveis privadas comum a função insert e ao método aos métodos TDmxScroller_Form_Lcl.CreateFormLCL
   Var
     ViRect : TDmxScroller_Form_Lcl.TViRect;
     RectNew : TDmxScroller_Form_Lcl.TRect;
     overfow : Boolean;
     s,s1    : AnsiString;
     aTop,
     VertTopMax,
     WidthRow,
     HorzTopMax,aLen : integer;

     Control : TControl;
           i : integer;

   {: A função **@name** insere o controle LCL associado ao campo pDmxFieldRec}

   Procedure Insert(DmxFieldRec : pDmxFieldRec; aAddCol:Boolean);

        Procedure CreateLabel;
        begin
          if DmxFieldRec^.Template^ <> ''
          then Begin
                 Control := TMi_ui_Label_lcl.Create(aOwner);
                 (Control as TMi_ui_Label_lcl).DmxScroller_Form_Lcl_attributes:= Self;
               end
          else Control := nil;
        end;

      //Procedure CreateLabel;
      //begin
      //  if DmxFieldRec^.Template^ <> ''
      //  then Control := TLabel.Create(aOwner)
      //  else begin
      //         Control := nil;
      //         exit;
      //       end;
      //
      //  if (DmxFieldRec^.access and  accHidden)<>0
      //  then Control.Visible:= false;
      //
      //  control.AutoSize:= false;
      //  s := DmxFieldRec^.Template^;
      //
      //  if AlignmentLabels in [taRightJustify, taCenter]
      //  then begin
      //         Control.Caption := trim(s);
      //         (Control as TLabel).Alignment := AlignmentLabels;
      //       end
      //  else Control.Caption := s;
      //
      //  Control.width := ((DmxFieldRec^.ShownWid+2)*WidthChar);
      //end;

      Procedure CreateButton;
      begin
        if DmxFieldRec^.Template^ <> ''
        Then begin
                Control := TMi_Button_LCL.Create(aOwner);
               (Control as TMi_Button_LCL).DmxScroller_Form_Lcl_attributes:= Self;
             end
        else Control := nil;
      end;

      Procedure CreateBoolean;
      begin
        Control := TMi_CheckBox_lcl.Create(aOwner);
       (Control as TMi_CheckBox_lcl).DmxScroller_Form_Lcl_attributes:= Self;
      end;

      procedure CreateRadioGroup;
        var
          CurrentFieldActual:pDmxFieldRec;
      begin
        CurrentFieldActual:= CurrentField;
        control := GetRadioButtonLCL(CurrentField,i);
        CurrentField := CurrentFieldActual;
        if (control <> nil) and (CurrentField<>nil)
        then with CurrentField^ do begin
               writeLn(Format('Fieldnum: %d | FieldName: %s | Width %d | Height %d ' ,[FieldNum,FieldName,Control.Width, Control.Height]));
             end;
      end;

   Begin
     with DmxFieldRec^ do
       writeLn(Format('Num: %d ;Template: %s ; Template_org %s ; Alias: %s',[Fieldnum,Template^,Template_org,alias]));

     if DmxFieldRec^.FieldSize = 0
     then begin //Create label
            if (DmxFieldRec^.ExecAction='')
            then begin
                   CreateLabel;
                 end
            else Begin //Insere botão.
                   CreateButton;
                 end;
          end
     else Begin //Create TMI_MaskEdit_LCL
            if (DmxFieldRec^.IsInputText)
            then begin
                   if (DmxFieldRec^.ListComboBox=nil)
                   Then Begin
                          Control := TMI_MaskEdit_LCL.Create(AOwner);
                         (Control as TMI_MaskEdit_LCL).DmxScroller_Form_Lcl_attributes:= Self;
                        end
                   else Begin
                          Control := TMI_ComboBox_LCL.Create(aOwner);
                          (Control as TMI_ComboBox_LCL).DmxScroller_Form_Lcl_attributes:= Self;
                        end;
                 end
            else if DmxFieldRec^.IsComboBox
                 then Begin
                        Control := TMI_ComboBox_LCL.Create(aOwner);
                        (Control as TMI_ComboBox_LCL).DmxScroller_Form_Lcl_attributes:= Self;
                      end
                 else begin
                        if DmxFieldRec^.IsInputCheckbox
                        then begin
                               CreateBoolean;
                             end
                        else if DmxFieldRec^.IsInputRadio
                             then begin
                                    CreateRadioGroup;
                                  end
                             else control := nil;
                      end;
          end;

//     Height := HeightChar;
//     Height := Control.Height;

     if Control <> nil
     Then begin
            if aAddCol
            then Begin
        //         overfow := ViRect.GetRect_AddCol(Width,Height,RectNew);
                   with Control do
                   begin
                     overfow := ViRect.GetRect_AddCol(Width,Height,RectNew);
                     WidthRow := Width;
                   end;

                  End
            Else Begin
        //         overfow := ViRect.GetRect_AddRow(Width,Height,RectNew);
                   with Control do
                   begin
                     overfow := ViRect.GetRect_AddRow(Width,Height,RectNew);
                     WidthRow := WidthRow +  Width;
                   End;
            end;
            DmxFieldRec^.LinkEdit  := Control;
            aOwner.InsertControl(Control);
            Control.SetBounds(RectNew.A.X,RectNew.A.Y, RectNew.B.X, RectNew.B.Y);

            with Control do
            begin
               //ParentShowHint := false;
               if hint <> ''
               Then ShowHint := true
               else ShowHint := False;
            end;
          end;
   End;
{
   Procedure WriteDebug;
   begin
     with (aOwner as TScrollBox) do
     begin
       writeLn('AutoScroll: ',AutoScroll);
       writeLn();
       writeLn('**HorzScrollBar**',' aOwner.Width: ',aOwner.Width);
       writeLn('  HorzScrollBar.Smooth %d ',HorzScrollBar.Smooth);
       writeLn('  HorzScrollBar.Tracking: %d ',HorzScrollBar.Tracking);
       writeLn('  HorzScrollBar.Range: %d ',HorzScrollBar.Range);
       writeLn('  HorzScrollBar.Position: %d ',HorzScrollBar.Position);
       writeLn('  HorzScrollBar.Page: %d ',HorzScrollBar.Page);
       writeLn('  HorzScrollBar.Increment: %d ',HorzScrollBar.Increment);
       writeLn('  HorzScrollBar.Visible: %d ',HorzScrollBar.Visible);
       writeLn();
       writeLn('**VertScrollBar** ',' aOwner.Height: ',aOwner.Height);
       writeLn('VertScrollBar.Smooth: %d ',VertScrollBar.Smooth);
       writeLn('VertScrollBar.Tracking: %d ',VertScrollBar.Tracking);
       writeLn('VertScrollBar.Range: %d ',VertScrollBar.Range);
       writeLn('VertScrollBar.Page: %d ',VertScrollBar.Page);
       writeLn('VertScrollBar.Increment: %d ',VertScrollBar.Increment);
       writeLn('VertScrollBar.Visible: %d ',VertScrollBar.Visible);
       writeLn();


     end;

   end;
}

   Var
     OkAddRow : Boolean = false;

//     RadioGroup1: TMi_RadioGroup_LCL;

//***Principal para dezenhar o formulário associado a lista pDmxFieldRec.
begin
  if DMXFields = nil
  then raise TException.Create(ParametroInvalido);

  If aOwner is TForm
  then (aOwner as TForm).AutoScroll :=false
  else if aOwner is TScrollBox
       then (aOwner as TScrollBox).AutoScroll :=false;

  //Como aOwner tem scroller eu não preciso limitar o quadrado do grupo
  ViRect.AssignLimits(0,0,65000,65000); //aOwner.Width //aOwner.Height
  ViRect.Assign(0,
                1,
                0,
                1);
  { O aTop pode se maior que zero se o height do ultimo controle fosse < que
    aOwner as TScrollingWinControl).Height
  }
  aTop := 0;
  VertTopMax := 0;
  HorzTopMax := 0;
  for i := 0 to DMXFields.Count-1 do
  begin
    CurrentField := DMXFields[i];
    while (CurrentField) <> nil do
    begin
      // Logs.Warning('Current Field = %s.', [CurrentField^.FieldName]);
      if CurrentField^.Template <> nil
      then begin
             if not OkAddRow
             then begin
                    insert(CurrentField,true)
                  end
             else begin
                    ViRect.Assign(0,atop,0,1);
                    insert(CurrentField,true);

                    if VertTopMax<aTop
                    Then VertTopMax := aTop;

                    if HorzTopMax<WidthRow
                    Then HorzTopMax := WidthRow;

                    OkAddRow := false;
                  end;
           end;

      if CurrentField <> nil
      Then CurrentField := CurrentField^.Next;
    end;
    OkAddRow := true;
    aTop := aTop + HeightChar;
  end;

  If aOwner is TForm
  then with  (aOwner as TForm) do begin AutoScroll := true end
  else if aOwner is TScrollBox
       then with  aOwner as TScrollBox do begin AutoScroll :=true;end;

  {Briguei muito para fazer funcionar autoscroll quando em tempo de designer ele é setado
   como true e os controle são inseridos em tempo de execução. Não obedece.

   - Obrigatóriamente ele precisa ser false em tempo de designer.
  }
  // Código usado para testar tScrollbox.
  // A propriedade AutoScroll :=true calcula os parâmetros, por isso não adianta informar aqui;
  {
  if aOwner is TScrollBox
  then with (aOwner as TScrollBox) do
       begin
         AutoScroll :=false;

         HorzScrollBar.Smooth := false;
         HorzScrollBar.Tracking:= False;
         HorzScrollBar.Range := MaxL( HorzTopMax+(WidthChar*2),(aOwner as TScrollBox).Width-15);
         HorzScrollBar.Page  := aOwner.Width - 15;
         HorzScrollBar.Increment := aOwner.HorzScrollBar.Page div 10;

         VertScrollBar.Smooth := True;
         VertScrollBar.Tracking:= True;
         VertScrollBar.Range := VertTopMax+(HeightChar*2);
         VertScrollBar.Page := MaxL(aOwner.Height -15,(aOwner as TScrollBox).Height-15);
         VertScrollBar.Increment := aOwner.VertScrollBar.Page div 10;

         AutoScroll:=true;
         WriteDebug;
     end;
   }
end;

procedure TDmxScroller_Form_Lcl.UpdateBuffers_Controls;
begin
  if CurrentField^.LinkEdit is TMI_MaskEdit_LCL
  Then begin
         (CurrentField^.LinkEdit as TMI_MaskEdit_LCL).GetBuffer;
       End
  else if (CurrentField^.LinkEdit is TMI_ComboBox_LCL)
   then (CurrentField^.LinkEdit as TMI_ComboBox_LCL).GetBuffer;
end;

procedure TDmxScroller_Form_Lcl.UpdateBuffers;
  Var i : integer;
      wCurrentField : pDmxFieldRec;
begin
  if not vidis then
  begin
    try
      vidis := true;
      wCurrentField := CurrentField;

      for i := 0 to DMXFields.Count-1 do
      begin
        CurrentField := DMXFields[i];
        while (CurrentField) <> nil do
        begin
          if (CurrentField^.Template <> nil)
             and (CurrentField^.Fieldnum<>0)
             and (CurrentField^.LinkEdit<>nil)
          then begin
                 UpdateBuffers_Controls;
               end;

          if CurrentField <> nil
          Then CurrentField := CurrentField^.Next;
        end;

        if CurrentField <> nil
        Then CurrentField := CurrentField^.Next;

      End;

    Finally
      CurrentField := wCurrentField;
      vidis := false;
    end;

  end;
end;

procedure TDmxScroller_Form_Lcl.Refresh;
Begin
  if Owner is TScrollingWinControl
  then with Owner as TScrollingWinControl do
       begin
         UpdateBuffers;
         Invalidate;
         Update;
       end;
End;

procedure TDmxScroller_Form_Lcl.SetActiveTarget(aActive: Boolean);
begin
  if active
  then active := false;

  if not Assigned(ParentLCL) and (Owner is TScrollingWinControl)
  then ParentLCL := Owner as TScrollingWinControl;

  if aActive
     and (Assigned(onGetTemplate) or
          Assigned(onAddTemplate) or
         ((Strings <>nil) and (Strings.Count>0))
         )
  then if Assigned(ParentLCL) then
       begin
         SetState(Mb_St_Creating,true);
         CreateStruct;

         if (DataSource<>nil) and  (DataSource.DataSet=nil)
         then DataSource.DataSet := BufDataset;

         CreateFormLCL(ParentLCL);
         _Active := aActive;
         SetState(Mb_St_Active,true);
         SetState(Mb_St_Creating,False);
         if Assigned(onEnter)
         then begin
                 onEnter(Self);
                 Refresh;
              end;
       end;
end;


{: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
procedure TDmxScroller_Form_Lcl.ModifyFontsAll_LCL(ctrl: TWinControl;aFontName: String; aSize: integer);

  procedure ModifyFont(ctrl: TControl);
  var
    f: TFont;
  begin
    if IsPublishedProp(ctrl, 'Parentfont')
      and (GetOrdProp(ctrl, 'Parentfont') = Ord(false))
      and IsPublishedProp(ctrl, 'font')
      then begin
             f := TFont(GetObjectProp(ctrl, 'font', TFont));

             if aFontName <> ''
             Then f.Name := aFontName;

             If aSize<>0
             then f.size := aSize;
           end;
  end;
var
  i: Integer;
begin
  ModifyFont(ctrl);
  for i := 0 to ctrl.controlcount - 1 do
    if ctrl.controls[i] is Twincontrol then
      ModifyFontsAll_LCL(TWincontrol(ctrl.controls[i]),aFontName)
    else
      Modifyfont(ctrl.controls[i]);
end;

procedure TDmxScroller_Form_Lcl.ModifyFontsAll_LCL(ctrl: TWinControl;aFontName:String);
begin
  ModifyFontsAll_LCL(ctrl,aFontName,0);
end;

function TDmxScroller_Form_Lcl.GetWidthChar(): integer;
begin
//  Result := (Owner as TScrollingWinControl).Canvas.TextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738') div 32;
  Result := ((Owner as TScrollingWinControl).Canvas.TextWidth(CharAlfanumeric)
             div Length(CharAlfanumeric));
end;

//Verifica se o componente fornecido possui uma relação db e se o conteúdo foi alterado
class function TDmxScroller_Form_Lcl.isValueDbChanged(Sender: TComponent): Boolean;
  var
    tmp_Field: TField;
    dlink: TObject;
  begin
    Result:= inherited isValueDbChanged(Sender);
    if not result
    Then begin
          dlink := TObject(TControl(Sender).Perform(CM_GETDATALINK, 0, 0));
          if dlink is TFieldDataLink then
          begin //se houver um DataLink (consulte, por exemplo, TcxDBButtonEdit.CMGetDataLink)
            tmp_Field := (dlink as TFieldDataLink).Field;
            result :=  Assigned(tmp_Field)  and not(VarSameValue(tmp_Field.OldValue, tmp_Field.Value));
          end
          else result := false;
    end;
  end;

class function TDmxScroller_Form_Lcl.TextWidthChar(AFont: TFont): Integer;
var
  bmp: TCustomBitmap;
begin
  Result := 0;
  bmp := TCustomBitmap.Create;
  try
    bmp.Canvas.Font.Assign(AFont);
    Result := bmp.Canvas.TextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738') div 32;
//    WidthChar  := MyGetTextWidth('AbcXdFGHIJKLMNopqRstuVxZ32489738',(aOwner as TScrollingWinControl).Canvas.font)  div 32;

  finally
    bmp.Free;
  end;
end;

class procedure TDmxScroller_Form_Lcl.ShowHtml(URL: string);
  var
    v: THTMLBrowserHelpViewer;
    BrowserPath, BrowserParams: string;
    p: LongInt;
    BrowserProcess: TProcessUTF8;
  begin
    v:=THTMLBrowserHelpViewer.Create(nil);
    try
      v.FindDefaultBrowser(BrowserPath,BrowserParams);
      //debugln(['Path=',BrowserPath,' Params=',BrowserParams]);

      //URL:='http://www.lazarus.freepascal.org';
      p:=System.Pos('%s', BrowserParams);
      System.Delete(BrowserParams,p,2);
      System.Insert(URL,BrowserParams,p);

      // start browser
      BrowserProcess:=TProcessUTF8.Create(nil);
      try
        BrowserProcess.CommandLine:=BrowserPath+' '+BrowserParams;
        BrowserProcess.Execute;
      finally
        BrowserProcess.Free;
      end;
    finally
      v.Free;
    end;
  end;

function TDmxScroller_Form_Lcl.SetHelpCtx_Hint(aFldNum: Integer;a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
begin
  result := inherited SetHelpCtx_Hint(aFldNum, a_HelpCtx_Hint);
  if result.LinkEdit is TControl
  Then (result.LinkEdit as TControl).Hint := a_HelpCtx_Hint ;
end;

procedure TDmxScroller_Form_Lcl.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec; a_HelpCtx_Hint: AnsiString);
begin
  inherited SetHelpCtx_Hint(apDmxFieldRec,a_HelpCtx_Hint);
  if Assigned(apDmxFieldRec) and (apDmxFieldRec.LinkEdit is TControl)
  Then (apDmxFieldRec.LinkEdit as TControl).Hint := a_HelpCtx_Hint ;
end;


end.

