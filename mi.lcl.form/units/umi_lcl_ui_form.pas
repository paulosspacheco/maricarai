unit umi_lcl_ui_form;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,controls,StdCtrls,forms,typInfo,types,Graphics,
    ActnList,db,dbctrls, variants, LazHelpHtml,UTF8Process,Dialogs
    ,uMi_LCL_Scrollbox
    ,mi.rtl.All
    ,uMaskedit_mi_lcl
    ,uComboBox_mi_lcl

    ,uButton_mi_lcl
    ,uCheckbox_mi_lcl
    ,uRadiogroup_mi_lcl
    ,uLabel_mi_lcl
    ,mi_rtl_ui_Dmxscroller
    ,mi_rtl_ui_dmxscroller_form

    ,uMi_lcl_ui_Form_attributes

  ;


 type
  { TMi_lcl_ui_Form }

  TMi_lcl_ui_Form = class(TMi_lcl_ui_Form_attributes,IMi_rtl_ui_Form)
    public procedure UpdateBuffers_Controls;override;
    {: O Método **@name** cria o formulário LCL baseado na lista de campos PDmxScroller. }
    public procedure CreateForm();override;
    public procedure DestroyForm();override;

//    private var aOwner : TScrollingWinControl;
    published Property ParentLCL;
    published Property Active; //Não consegui fazer com que o formulário fosse criado em tempo de designer

  end;



procedure Register;

implementation
{%CLASSGROUP 'System.Classes.TPersistent'}

procedure Register;
begin
  RegisterComponents('MI.LCL', [TMi_lcl_ui_Form]);
end;


{ TMi_lcl_ui_Form }

procedure TMi_lcl_ui_Form.UpdateBuffers_Controls;
begin
  if Assigned(dmxscroller_form) then
  with DmxScroller_Form do
  begin
    if CurrentField^.LinkEdit is TMaskEdit_mi_LCL
    Then begin
           (CurrentField^.LinkEdit as TMaskEdit_mi_LCL).GetBuffer;
         End
    else if (CurrentField^.LinkEdit is TComboBox_mi_LCL)
         then (CurrentField^.LinkEdit as TComboBox_mi_LCL).GetBuffer;

    //inherited UpdateBuffers_Controls;
  end;

end;

procedure TMi_lcl_ui_Form.CreateForm;


     {: O método **@name** pesquisa todos os campo que são iguais a tipo DMXFields[i]
       e insere um controle TRadioGroup com os itens TRadioButton dentro.
     }
    Function GetRadioButtonLCL(aFristRadioGroupField:pDmxFieldRec;j:integer):TRadioGroup_mi_LCL;

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
        if JaFoiInserido(aFristRadioGroupField^.FieldNum)
        then exit;

        with DmxScroller_Form do
        begin
          if aFristRadioGroupField^.FieldName <> ''
          then FldRadioButtonsAdicionados.Add(IntToStr(aFristRadioGroupField^.FieldNum));

          Result := TRadioGroup_mi_LCL.Create(_Owner);
          Result.Mi_lcl_ui_Form_attributes := self;

          if aFristRadioGroupField^.Fieldnum <> 0
          Then Result.Caption := aFristRadioGroupField^.FieldName;

          // Adiciona a lista de opções
          for i := j to  DMXFields.Count-1 do
          begin
            p  := DMXFields[i];
            while (p) <> nil do
            begin
              if p^.Template <> nil
              then begin
                     if (p^.TypeCode = FldRadioButton) and
                        (aFristRadioGroupField^.FieldNum=p^.FieldNum)
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
            begin
        Result := nil;
        if JaFoiInserido(aFristRadioGroupField^.FieldNum)
        then exit;

        with DmxScroller_Form do
        begin
          if aFristRadioGroupField^.FieldName <> ''
          then FldRadioButtonsAdicionados.Add(IntToStr(aFristRadioGroupField^.FieldNum));

          Result := TRadioGroup_mi_LCL.Create(_Owner,self);
//          Result.DmxScroller_Form_Lcl_attributes:= Self;
          //Result.Mi_lcl_ui_Form_attributes := self;

          if aFristRadioGroupField^.Fieldnum <> 0
          Then Result.Caption := aFristRadioGroupField^.FieldName;

          // Adiciona a lista de opções
          for i := j to  DMXFields.Count-1 do
          begin
            p  := DMXFields[i];
            while (p) <> nil do
            begin
              if p^.Template <> nil
              then begin
                     if (p^.TypeCode = FldRadioButton) and
                        (aFristRadioGroupField^.FieldNum=p^.FieldNum)
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
      end;
   //begin
          //  Result.TabStop:=true;
          //end;
        end;
      end;

    //Variáveis privadas comum a função insert e ao método aos métodos TDmxScroller_Form_Lcl.CreateFormLCL
    Var
       ViRect : TDmxScroller_Form.TViRect;
       RectNew : TDmxScroller_Form.TRect;
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
                 Control := TLabel_mi_lcl.Create(_Owner,self);
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
                  Control := TButton_mi_LCL.Create(_Owner,self);
               end
          else Control := nil;
        end;

        Procedure CreateBoolean;
        begin
          Control := TCheckBox_mi_lcl.Create(_Owner,self);
        end;

        procedure CreateRadioGroup;
          var
            CurrentFieldActual:pDmxFieldRec;
        begin
          CurrentFieldActual:= DmxScroller_Form.CurrentField;
          control := GetRadioButtonLCL(DmxScroller_Form.CurrentField,i);
          DmxScroller_Form.CurrentField := CurrentFieldActual;
        end;

     Begin
       if DmxFieldRec^.FieldSize = 0
       then begin //Create label
              if (DmxFieldRec^.ExecAction='')
              then CreateLabel
              else CreateButton;
            end
       else Begin //Create TMI_MaskEdit_LCL
              if (DmxFieldRec^.IsInputText)
              then begin
                     if (DmxFieldRec^.ListComboBox=nil)
                     Then Control := TMaskEdit_mi_LCL.Create(_Owner,self)
                     else Control := TComboBox_mi_LCL.Create(_Owner,self);
                   end
              else if DmxFieldRec^.IsComboBox
                   then Control := TComboBox_mi_LCL.Create(_Owner,self)
                   else begin
                          if DmxFieldRec^.IsInputCheckbox
                          then CreateBoolean
                          else if DmxFieldRec^.IsInputRadio
                               then CreateRadioGroup
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

              _ControlFields.Add(Control);
              DmxFieldRec^.LinkEdit  := Control;
              _Owner.InsertControl(DmxFieldRec^.LinkEdit as TControl);

              Control.SetBounds(RectNew.A.X+10,RectNew.A.Y, RectNew.B.X, RectNew.B.Y);

              with Control do
              begin
                 //ParentShowHint := false;
                 if hint <> ''
                 Then ShowHint := true
                 else ShowHint := False;
              end;
            end;
     End;

    {  Procedure WriteDebug;
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

//  function WidthChar: Byte;
//
//      Function WidthCharMax:Byte;
//        var
//          i,w,h : integer;
//      begin
//        result := 0;
//
//        for i := 1 to length(DmxScroller_Form.CharAlfanumeric) do
//        begin
//          aOwner.Canvas.GetTextSize(DmxScroller_Form.CharAlfanumeric[i],w,h);
//          if w > Result
//          then Result := w;
//        end;
//      end;
//
//     var w,h:integer;
//  begin
//    if Assigned(aOwner)
//    Then If not Assigned(DmxScroller_Form)
//         then begin
//                result := 0;
//                exit;
//              end;
//
//    aOwner.Canvas.GetTextSize(DmxScroller_Form.CharAlfanumeric,w,h);
//    result := w div length(DmxScroller_Form.CharAlfanumeric);
//  //  Result := WidthCharMax;
//
//    //s  := Canvas.TextExtent(Mi_lcl_ui_Form_attributes.CharAlfanumeric);
//    //writeLn(Format('Largura %d; Altura %d; S.Width %d; S.Height %d; WidthCharMax %d; Result %d',[w,h,s.Width,s.Height,WidthCharMax,Result]));
//  end;
//
//  function HeightChar: Byte;
//    var
//      w,h:integer;
//  begin
//    if Assigned(aOwner)
//    Then If not Assigned(DmxScroller_Form)
//         then begin
//                result := 0;
//                exit;
//              end;
//
//    aOwner.Canvas.GetTextSize(DmxScroller_Form.CharAlfanumeric,w,h);
//    result := h;
//  end;

 Var
   OkAddRow : Boolean = false;
   f : TFont;
//***Principal para dezenhar o formulário associado a lista pDmxFieldRec.
begin
  if (ComponentState * [csLoading, csInline, csDesigning] = []) and
     (Assigned(DmxScroller_Form))
  then
  begin
    FldRadioButtonsAdicionados.Clear;
    if Assigned(ParentLCL) and (ParentLCL is TMi_LCL_Scrollbox)
    Then _Owner := (ParentLCL as TMi_LCL_Scrollbox)
    else if Owner is TScrollingWinControl
         then _Owner := Owner as TScrollingWinControl
         else raise TMi_rtl.TException.Create('O atributo DMXFields não inicializado!');

    if DmxScroller_Form.DMXFields = nil
    then exit;

    If _Owner is TForm
    then (_Owner as TForm).AutoScroll :=false
    else if _Owner is TScrollBox
         then begin
                (_Owner as TScrollBox).AutoScroll :=false;

                if (ParentLCL is TMi_LCL_Scrollbox) and
                  ((ParentLCL as TMi_LCL_Scrollbox).Mi_lcl_ui_Form_attributes=nil)
                then (ParentLCL as TMi_LCL_Scrollbox).Mi_lcl_ui_Form_attributes := self;
              end
         else raise TMi_Rtl.TException.Create('Não posso criar formulário caso o dono não seja TScrollBox ou TForm');

//    f := (aOwner.owner as TScrollingWinControl).Font;
    f := _Owner.font;

    DmxScroller_Form.WidthChar := GetWidthChar;
    DmxScroller_Form.HeightChar := GetHeightChar;

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

    for i := 0 to DmxScroller_Form.DMXFields.Count-1 do
    begin
      DmxScroller_Form.CurrentField := DmxScroller_Form.DMXFields[i];
      while (DmxScroller_Form.CurrentField) <> nil do
      begin
        // Logs.Warning('Current Field = %s.', [CurrentField^.FieldName]);
        if DmxScroller_Form.CurrentField^.Template <> nil
        then begin
               if not OkAddRow
               then begin
                      insert(DmxScroller_Form.CurrentField,true)
                    end
               else begin
                      ViRect.Assign(0,atop,0,1);
                      insert(DmxScroller_Form.CurrentField,true);

                      if VertTopMax<aTop
                      Then VertTopMax := aTop;

                      if HorzTopMax<WidthRow
                      Then HorzTopMax := WidthRow;

                      OkAddRow := false;
                    end;
             end;

        if DmxScroller_Form.CurrentField <> nil
        Then DmxScroller_Form.CurrentField := DmxScroller_Form.CurrentField^.Next;
      end;
      OkAddRow := true;

      If Control is TRadioGroup_mi_LCL
      Then aTop := aTop + (DmxScroller_Form.HeightChar *
                        (Control as TRadioGroup_mi_LCL).Items.Count-1)
      else aTop := aTop + DmxScroller_Form.HeightChar+
                         DmxScroller_Form.space_between_lines;
    end;

    If _Owner is TForm
    then with  (_Owner as TForm) do
         begin
           AutoScroll := true
         end
    else if _Owner is TScrollBox
         then with  _Owner as TScrollBox do
              begin
                AutoScroll :=true;
              end;

    //Briguei muito para fazer funcionar autoscroll quando em tempo de designer ele é setado
    // como true e os controle são inseridos em tempo de execução. Não obedece.
    //
    // - obrigatoriamente ele precisa ser false em tempo de designer.

    // Código usado para testar tScrollbox.
    // A propriedade AutoScroll :=true calcula os parâmetros, por isso não adianta informar aqui;
    //if aOwner is TScrollBox
    //then with (aOwner as TScrollBox) do
    //     begin
    //       AutoScroll :=false;
    //
    //       HorzScrollBar.Smooth := false;
    //       HorzScrollBar.Tracking:= False;
    //       HorzScrollBar.Range := MaxL( HorzTopMax+(WidthChar*2),(aOwner as TScrollBox).Width-15);
    //       HorzScrollBar.Page  := aOwner.Width - 15;
    //       HorzScrollBar.Increment := aOwner.HorzScrollBar.Page div 10;
    //
    //       VertScrollBar.Smooth := True;
    //       VertScrollBar.Tracking:= True;
    //       VertScrollBar.Range := VertTopMax+(HeightChar*2);
    //       VertScrollBar.Page := MaxL(aOwner.Height -15,(aOwner as TScrollBox).Height-15);
    //       VertScrollBar.Increment := aOwner.VertScrollBar.Page div 10;
    //
    //       AutoScroll:=true;
    //       WriteDebug;
    //   end;
  end;
end;

procedure TMi_lcl_ui_Form.DestroyForm();
  Var
    i,t : Integer;
    c :TControl;
begin
 if Assigned(DmxScroller_Form)
 then With DmxScroller_Form do
      begin
        t := _ControlFields.Count;
        for i := 0 to t-1 do
        begin
          c := Tcontrol(_ControlFields.Items[i]);
          if Assigned(c)
          then begin
                 FreeAndNil(c);
               end;
        end;
        _ControlFields.Clear;

        if Assigned(Mi_ActionList)
        then Mi_ActionList := nil;

        if Assigned(Parent)
        then Parent := nil;
      end;
end;






end.

