unit umi_lcl_ui_ds_form;
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,controls,StdCtrls,forms,typInfo,types,Graphics,
    ActnList,db,dbctrls, variants, LazHelpHtml,UTF8Process,Dialogs

    ,mi.rtl.all
    ,uMi_LCL_Scrollbox
    ,mi.rtl.Consts

    ,uMaskedit_mi_lcl
    ,uDbedit_mi_lcl

    ,uComboBox_mi_lcl
    ,uDbcombobox_mi_lcl

    ,uDblookupcombobox_mi_lcl


    ,uButton_mi_lcl

    ,uCheckbox_mi_lcl
    ,uDbcheckbox_mi_lcl

    ,uRadiogroup_mi_lcl
    ,uDbradiogroup_mi_lcl

    ,uLabel_mi_lcl
    ,mi_rtl_ui_Dmxscroller
    ,mi_rtl_ui_dmxscroller_form

    ,uMi_lcl_ui_Form_attributes

  ;

 type
  { TMi_lcl_ui_ds_Form }
  TMi_lcl_ui_ds_Form = class(TMi_lcl_ui_Form_attributes,IMi_rtl_ui_Form)
    public procedure UpdateBuffers_Controls;override;

    {: O Método **@name** cria o formulário LCL baseado na lista de campos PDmxScroller. }
    public procedure CreateForm();override;
    public procedure DestroyForm();override;

  end;


procedure Register;

implementation
{%CLASSGROUP 'System.Classes.TPersistent'}

procedure Register;
begin
  RegisterComponents('MI.LCL', [TMi_lcl_ui_ds_Form]);
end;


{ TMi_lcl_ui_ds_Form }

procedure TMi_lcl_ui_ds_Form.UpdateBuffers_Controls;
  //Var
  //  typ,s:String;
begin
  if Assigned(dmxscroller_form) then //and (Not ControlsDisabled) then
  with DmxScroller_Form,CurrentField^ do
  begin
    //s := fieldName;
    //typ := TypeCode;
    if LinkEdit is TDbEdit_mi_LCL
    Then (LinkEdit as TDbEdit_mi_LCL).GetBuffer
    else if LinkEdit is TDBLookupComboBox_mi_Lcl
         then (LinkEdit as TDBLookupComboBox_mi_Lcl).GetBuffer
         else if (LinkEdit is TDbComboBox_mi_LCL)
              then (LinkEdit as TDbComboBox_mi_LCL).GetBuffer
              else if (LinkEdit is TMI_ui_DbRadioGroup_Lcl)
                   then (LinkEdit as TMI_ui_DbRadioGroup_Lcl).GetBuffer
                   else if (LinkEdit is TComboBox_mi_LCL)
                        then (LinkEdit as TComboBox_mi_LCL).GetBuffer
                        else if LinkEdit is TMaskEdit_mi_LCL
                             Then (LinkEdit as TMaskEdit_mi_LCL).GetBuffer
                             else if LinkEdit is TDBCheckBox_mi_Lcl
                                  Then (LinkEdit as TDBCheckBox_mi_Lcl).GetBuffer
                                  else if LinkEdit is TCheckBox_mi_Lcl
                                       Then (LinkEdit as TCheckBox_mi_Lcl).GetBuffer
                                       else Raise TException.Create({$I %CURRENTROUTINE%},'Corrente campo não tem controle implementado!');
  end;

end;

procedure TMi_lcl_ui_ds_Form.CreateForm();

    Function JaFoiInserido(var aFieldNum:Integer):Boolean;
    begin
      result := FldRadioButtonsAdicionados.IndexOf(IntToStr(aFieldNum)) >= 0;
    end;

    {: O método **@name** pesquisa todos os campo que são iguais a tipo DMXFields[i]
       e insere um controle TRadioGroup com os itens TRadioButton dentro.
    }
    Function GetDbRadioButtonLCL(aFristRadioGroupField:pDmxFieldRec;j:integer):TControl;
      Var
        i,k : integer;
        p : pDmxFieldRec  ;

    begin
      Result := nil;

      if JaFoiInserido(aFristRadioGroupField^.FieldNum)
      then exit;
      with DmxScroller_Form do
      begin
        if aFristRadioGroupField^.FieldName <> ''
        then FldRadioButtonsAdicionados.Add(IntToStr(aFristRadioGroupField^.FieldNum));

        if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(aFristRadioGroupField^.FieldName))
        then begin
               Result := TMi_Ui_DbRadioGroup_Lcl.Create(_Owner,self);
               //(Result as TMi_Ui_DbRadioGroup_Lcl).Mi_lcl_ui_Form_attributes := Self;
             end
        else begin
               Result := TRadioGroup_mi_LCL.Create(_Owner,self);
               //(Result as TRadioGroup_mi_LCL).Mi_lcl_ui_Form_attributes := Self;
             end;

        if aFristRadioGroupField^.Fieldnum <> 0
        Then Result.Caption := aFristRadioGroupField^.FieldName;
      //        k:= 0;
        // Adiciona a lista de opções
        for i := j to DMXFields.Count-1 do
        begin
          p  := DMXFields[i];
          while (p) <> nil do
          begin
            if p^.Template <> nil
            then begin
                   if (p^.TypeCode = FldRadioButton) and
                      (aFristRadioGroupField^.FieldNum=p^.FieldNum)
                   then begin
                          if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(aFristRadioGroupField^.FieldName))
                          then begin
                                 (Result as TMi_Ui_DbRadioGroup_Lcl).Items.Add(p^.Alias);
                               end
                          else begin
                                 (Result as TRadioGroup_mi_LCL).Items.Add(p^.Alias);
                               end;
                        end;
                 end;
             p := p^.Next;
          end;
        end;

        if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(aFristRadioGroupField^.FieldName))
        then begin
               (Result as TMi_Ui_DbRadioGroup_Lcl).ItemIndex  := 0;
             end
        else begin
               (Result as TRadioGroup_mi_LCL).ItemIndex  := 0;
             end;
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
          if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(DmxFieldRec^.FieldName))
          then begin
                 Control := TDBCheckBox_mi_Lcl.Create(_Owner,self);
               end
          else begin
                  Control := TCheckBox_mi_lcl.Create(_Owner,self);
               end;

        end;

        procedure CreateRadioGroup;
          var
            CurrentFieldActual:pDmxFieldRec;
        begin
          CurrentFieldActual:= DmxScroller_Form.CurrentField;
          control := GetDbRadioButtonLCL(DmxScroller_Form.CurrentField,i);
          DmxScroller_Form.CurrentField := CurrentFieldActual;
        end;

        Begin
         if DmxFieldRec^.FieldSize = 0
         then begin //Create label
                if (DmxFieldRec^.ExecAction='')
                then CreateLabel
                else CreateButton;//Insere botão.
              end
         else Begin //Create TMI_MaskEdit_LCL
                if (DmxFieldRec^.IsInputText)
                then begin
                       if (DmxFieldRec^.ListComboBox=nil)
                       Then Begin
                              if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(DmxFieldRec^.FieldName))
                              then Control := TDbEdit_mi_LCL.Create(_Owner,self)
                              else Control := TMaskEdit_mi_LCL.Create(_Owner,self);
                            end
                       else Begin
                              if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(DmxFieldRec^.FieldName))
                              then Control := TDbComboBox_mi_LCL.Create(_Owner,self)
                              else Control := TComboBox_mi_LCL.Create(_Owner,self);
                            end;
                     end
                else if DmxFieldRec^.IsComboBox
                     then Begin
                            if Assigned(DmxScroller_Form.DataSource.DataSet.FindField(DmxFieldRec^.FieldName))
                            then begin
                                   case DmxFieldRec^.TypeCode of
                                     fldENum_db,
                                     fldENum: begin //Campos lookup são do tipo integer
                                                Control := TDBLookupComboBox_mi_Lcl.Create(_Owner,self);
                                              end;
                                     else raise TMi_rtl.TException.Create(self,{$I %CURRENTROUTINE%},tMi_rtl.ParametroInvalido);
                                   end;

                                 end
                            else Control := TComboBox_mi_LCL.Create(_Owner,self);
                          end
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

    Var
      OkAddRow : Boolean = false;
      f : TFont;
//***Principal para dezenhar o formulário associado a lista pDmxFieldRec.
begin
  if (ComponentState * [csLoading, csInline, csDesigning] = []) and
     (Assigned(DmxScroller_Form)) and DmxScroller_Form.isDataSetActive
  then
  begin
    FldRadioButtonsAdicionados.Clear;
    if Assigned(ParentLCL) and (ParentLCL is TMi_LCL_Scrollbox)
    Then _Owner := (ParentLCL as TMi_LCL_Scrollbox)
    else if Owner is TScrollingWinControl
         then _Owner := Owner as TScrollingWinControl
         else raise TMi_rtl.TException.Create('O atributo DMXFields não inicializado!');


    if DmxScroller_Form.DMXFields = nil
    then exit;//raise TException.Create('O atributo DMXFields não inicializado!');

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

      If Control is TMI_ui_DbRadioGroup_Lcl//TRadioGroup_mi_LCL
      Then aTop := aTop + (DmxScroller_Form.HeightChar *
                   (Control as TMI_ui_DbRadioGroup_Lcl).Items.Count-1)
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

procedure TMi_lcl_ui_ds_Form.DestroyForm();
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


