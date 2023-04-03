unit umi_ui_dmxscroller_form_lcl_ds;
{:< A unit **@name** implementa a classe TDmxScroller_Form_Lcl_attributes_Form_ds.

  - **VERSÃO**
    - Alpha - 0.7.0.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi_ui_dmxscroller_form_ds.pas">mi_ui_Dmxscroller_form_DS.pas</a>)

    - **PENDÊNCIAS**
      - T12 O Componente TMi_ui_DmxScroller_Form_ds  quando inserido em um
             dataModule os campos checkBox e RadioButton não estão visíveis.

      - T12 Corrigir problema quando vinculados ao dbGrid os controles do tipo:
        - fldEnum;
        - FldBoolean;
        - FldRadioButton;

      - T12 Criar Método procedure TDmxScroller_Form.CreateFormLCL(aOwner: TScrollingWinControl); ✅
        - Esse método deve usar as classes da Pallet Data Controls
          - TMI_ui_DbText_LCL
          - TMI_ui_DbEdit_LCL ✅
          - TMI_ui_DbLookupComboBox_LCL ✅
          - TMI_ui_DbCheck_LCL  ✅
          - TMI_ui_DbRadioButton_Lcl ✅
          - TMi_ui_DbData_lcl
          - TMi_ui_DbHora_lcl
          - TMi_ui_DbDataHora_lcl

      - T12 HABILITAR OS EVENTOS DE TDataSource.dataset
        - T12 Executar os eventos do dataSet associado aos controles dbText e Db dbComboBox
        - T12 Dar opção global para habilitar e desabilitar as mascaras dos textos.
          - Criar opção global OkEditMask para usar com a propriedade: TMI_DbEdit_LCL.CustomEditMask;

    = **CONCLUÍDO**
       - T12 A classe deve herdar de **TDmxScroller_Form_DS** ✅

    - **HISTÓRICO**
       - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br) ✅

       - **2022-04-27**
         - **14:10**
           - Análise de como implementar a unit;
           - Criar a classe TMI_ui_DbEdit_LCL ✅

       - **2022-06-07**
         - Criar a classe TMI_ui_DbCheck_LCL ✅
            - Em CreateFormLCL inserir classe TMI_ui_DbCheck_LCL se CurrentField
              for do tipo FldBoolean;  ✅

         - Criar a classe TMi_Ui_DBRadioGroup_Lcl ✅
           - Em CreateFormLCL inserir classe TMI_ui_DbRadioGroup_LCL se CurrentField
             for do tipo FldRadioButton;
             - Criar função CreateRadioGroup;

         - Em CreateFormLCL inserir classe TMi_Button_LCL se DmxFieldRec.ExecAction<>''

       - **2022-07-04**
         - **09:38**
           - T12 O Componente TMi_ui_DmxScroller_Form_ds  quando inserido em um
             dataModule os campos checkBox e RadioButton não estão visíveis.

}

//==============================================================
{$REGION ' Trabalhos do dia.'}
{
- **2022-06-16**
  - 18:25
    - T12 Em TDxmScrollerForm_ds trocar controle TMI_ui_DbComboBox_LCL por TMI_ui_DbLookupComboBox_LCL
      - T12 Criar componente TMI_ui_DbLookupComboBox_LCL.


}

{$ENDREGION 'Trabalhos do dia'}
//==============================================================


{$mode Delphi}{$H+}

interface

  uses
    Classes, SysUtils,controls,StdCtrls,forms,db
    ,mi_rtl_ui_Dmxscroller
    ,uMi_ui_Dmxscroller_form_Lcl


    //,uMI_ui_DbText_LCL
    ,uMI_ui_DbEdit_LCL
    ,uMi_Ui_DbLookupComboBox_lcl
    ,uMi_Ui_DbComboBox_lcl
    ,uMi_Ui_DBCheckBox_Lcl
    ,uMi_Ui_DbRadioGroup_Lcl
    ,umi_ui_button_lcl
    ,uMi_ui_Label_lcl
    ;

  const
    AccNormal  = mi_rtl_ui_Dmxscroller.AccNormal;

  type
    { Os tipos abaixo foi declarado fora de TDmxScroller_Form_Atributos para
       que os componentes não derivados de TDmxScroller_Form_Atributos possa enchergar com facilidade}
    TDmxFieldRec = uMi_ui_Dmxscroller_form_Lcl.TDmxFieldRec;
    pDmxFieldRec = uMi_ui_Dmxscroller_form_Lcl.pDmxFieldRec;
    SmallWord    = uMi_ui_Dmxscroller_form_Lcl.SmallWord;

  type

     { TDmxScroller_Form_Lcl_DS }

     TDmxScroller_Form_Lcl_DS = class(TDmxScroller_Form_Lcl)

        {: O método **@name** desenha um formulário TScrollingWinControl usando
           várias linha.
           - O modelo cria um registro usando os tipos de dados primitivos.

           - **EXEMPLO**:

              ```pascal

                function TDMAlunos.DmxScroller_Form_AlunoGetTemplate(aNext: PSItem): PSItem;
                begin
                  with DmxScroller_Form1_DS do
                  begin
                    // AlignmentLabels:= taCenter;
                    AlignmentLabels := taLeftJustify;
                    // AlignmentLabels := taRightJustify ;
                    Result :=
                      NewSItem('~     Matrícula ~\LLLLL'+CharFieldName+'matricula'+CharAccReadOnly+CharPfInKeyPrimary+CharPfInAutoIncrement,
                      NewSItem('~Nome do aluno: ~\ssssssssssssssssssss`sssssss'+CharFieldName+'Nome'+CharPfInKey,
                      NewSItem('',
                      NewSItem('~     Endereço: ~\ssssssssssssssssssss`sssssssssss'+CharFieldName+'Endereco',
                      NewSItem('~P. Referência: ~\ssssssssssssssssssss`sssss'+CharFieldName+'PontoDeReferencia',
                      NewSItem('~          Cep: ~\##.###-###'+CharFieldName+'cep',
                      NewSItem('~       Estado: ~\SS'+CharFieldName+'Estado'+CharForeignKeyN_Um_false+'Estados,Estado',
                      NewSItem('~       Cidade: ~\ssssssssssssssssssss`sssss'+CharFieldName+'cidade'+CharForeignKeyN_Um_false+'Cidades,Estado;Cidade',

                      NewSItem('',
                      aNext)))))))));

                  end;
                end;

              ```
        }
        protected procedure CreateFormLCL(aOwner:TScrollingWinControl);override;

        {: O método **@name** ler o buffer dos campos dos arquivos associados a classe
           **TDmxScroller_Form_Lcl_attributes_sql**  para o buffer dos campos da classe **TDmxScroller_Form_Lcl_attributes**}


        protected   procedure UpdateBuffers_Controls;override;
        protected procedure SetActiveTarget(aActive: Boolean);override;

        published property TableName;
        published property DataSource;
     end;

  procedure Register;

implementation

  procedure Register;
  begin
    RegisterComponents('Mi.Ui.Lcl.Form', [TDmxScroller_Form_Lcl_DS]);
  end;

  { TDmxScroller_Form_Lcl_DS }
  procedure TDmxScroller_Form_Lcl_DS.CreateFormLCL(aOwner: TScrollingWinControl);

      {: O método **@name** pesquisa todos os campo que são iguais a tipo DMXFields[i]
         e insere um controle TRadioGroup com os itens TRadioButton dentro.
      }
      Function GetRadioButtonLCL(aFristRadioGroupField:pDmxFieldRec;j:integer):TMi_Ui_DbRadioGroup_Lcl;

        Function JaFoiInserido(var aFieldNum:Integer):Boolean;
        begin
          result := FldRadioButtonsAdicionados.IndexOf(IntToStr(aFieldNum)) >= 0;
        end;

        Var
          i,k : integer;
          p : pDmxFieldRec  ;

      begin
        Result := nil;

        if JaFoiInserido(aFristRadioGroupField^.FieldNum)
        then exit;

        if aFristRadioGroupField^.FieldName <> ''
        then FldRadioButtonsAdicionados.Add(IntToStr(aFristRadioGroupField^.FieldNum));

        Result := TMi_Ui_DbRadioGroup_Lcl.Create(aOwner);
        Result.DmxScroller_Form_Lcl_attributes := Self;

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
                   if (p^.TypeCode = FldDbRadioButton) and
                      (aFristRadioGroupField^.FieldNum=p^.FieldNum)
                   then begin
         //                 writeLn(Format('Número: %d | Nome: %s | Alias %s',[p^.FieldNum,p^.FieldName,p^.alias]));

//                          Result.Items.Insert(k,p^.Alias);
                          Result.Items.Add(p^.Alias);
//                          inc(k);
                        end;
                 end;
             p := p^.Next;
          end;
        end;
        Result.ItemIndex  := 0;
      end;

    { public access        :  byte;       // read-only, hidden, skip, accSpecX
      public Fieldnum      :  Integer;    // 1..totalFields (0=none)
      public ScreenTab     :  integer;    // Override column num.

      public ColumnWid     :  byte;       // width of Field column
      public ShownWid      :  byte;       // visible width of column
      public TypeCode      :  AnsiChar;   // 's', 'r', etc.
      public FillValue     :  AnsiChar;    // #0 or ' '
      public UpperLimit    :  byte;       // maximum value limit
      public ShowZeroes    :  boolean;    // display zero values
      public TrueLen       :  byte;       // unformatted text length
      public Parenthesis   :  boolean;    // '('/')' AnsiCharacters
      public Decimals      :  byte;       // decimal point or cluster value
      public FieldSize     :  integer;    // sizeof (datatype)
      public DataTab       :  integer;    // position in record
      public Template      :  ptString;   // Field Template
    }

     Var
       ViRect : TDmxScroller_Form_LCL.TViRect;
       //Width,Height : integer;

       RectNew : TDmxScroller_Form_LCL.TRect;
       overfow : Boolean;
       s,s1    : AnsiString;
       aTop,aLen : integer;

       Control : TControl;
             i : integer;

     Procedure Insert(DmxFieldRec : pDmxFieldRec; aAddCol:Boolean);

        Procedure CreateLabel;
        begin
          if DmxFieldRec^.Template^ <> ''
          then Begin
                 Control := TMi_ui_Label_lcl.Create(aOwner);
                 (Control as TMi_ui_Label_lcl).DmxScroller_Form_Lcl_attributes := Self;
               end
          else Control := nil;
        end;


        //Procedure CreateLabel;
        //begin
        //  if DmxFieldRec^.Template^ <> ''
        //  then begin
        //         Control := TLabel.Create(aOwner)
        //       end
        //  else begin
        //         Control := nil;
        //         exit;
        //       end;
        //  if (DmxFieldRec^.access and  accHidden)<>0
        //  then Control.Visible:= false;
        //  control.AutoSize:= false;
        //  s := DmxFieldRec^.Template^;
        //  if AlignmentLabels in [taRightJustify, taCenter]
        //  then begin
        //         Control.Caption := trim(s);
        //         (Control as TLabel).Alignment := AlignmentLabels;
        //       end
        //  else Control.Caption := s;
        //
        //  Control.width := ((DmxFieldRec^.ShownWid)*WidthChar);
        //end;

        Procedure CreateButton;
        begin
          if DmxFieldRec^.Template^ <> ''
          Then begin
                  Control := TMi_Button_LCL.Create(aOwner);
                 (Control as TMi_Button_LCL).DmxScroller_Form_Lcl_attributes := Self;
               end
          else Control := nil;
        end;

        Procedure CreateBoolean;
        begin
          Control := TMi_Ui_DBCheckBox_Lcl.Create(aOwner);
          (Control as TMi_Ui_DBCheckBox_Lcl).DmxScroller_Form_Lcl_attributes := Self;
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
   //              writeLn(Format('Fieldnum: %d | FieldName: %s | Width %d | Height %d ' ,[FieldNum,FieldName,Control.Width, Control.Height]));
               end;
        end;


     Begin
       //width := DmxFieldRec^.ShownWid*WidthChar;

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
       else Begin
              if DmxFieldRec^.IsInputText
              then begin
                     if DmxFieldRec.ListComboBox = nil
                     then begin
                            Control := TMI_DbEdit_LCL.Create(AOwner);
                            (Control as TMI_DbEdit_LCL).DmxScroller_Form_Lcl_attributes := Self;
                          end
                     else Begin
                            Control := TMI_DbComboBox_LCL.Create(aOwner);
                            (Control as TMI_DbComboBox_LCL).DmxScroller_Form_Lcl_attributes := Self;
                          end;
                   end
              else if DmxFieldRec^.IsComboBox
                   then Begin
                          Control := TMi_ui_DbLookupComboBox_LCL.Create(aOwner);
                          (Control as TMi_ui_DbLookupComboBox_LCL).DmxScroller_Form_Lcl_attributes := Self;
                        end
                   else if DmxFieldRec^.IsInputCheckbox
                        then Begin
                               CreateBoolean;
                             end
                        else if DmxFieldRec^.IsInputDbRadio
                             then Begin
                                    CreateRadioGroup;
                                  end
                             else Control :=  nil;
            end;

       if Control <> nil
       Then begin
              if aAddCol
              then Begin
                     with Control do
                       overfow := ViRect.GetRect_AddCol(Width,Height,RectNew);
                   End
              Else Begin
                     with Control do
                       overfow := ViRect.GetRect_AddRow(Width,Height,RectNew);
                   End;

              DmxFieldRec^.LinkEdit  := Control;
              aOwner.InsertControl(Control);
              Control.SetBounds(RectNew.A.X,RectNew.A.Y, RectNew.B.X, RectNew.B.Y);
            end;
     End;

     Var
       OkAddRow : Boolean = false;
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

    for i := 0 to DMXFields.Count-1 do
    begin
      CurrentField := DMXFields[i];
      while (CurrentField) <> nil do
      begin
  //      Logs.Warning('Current Field = %s.', [CurrentField^.FieldName]);
        if CurrentField^.Template <> nil
        then begin
               if not OkAddRow
               then insert(CurrentField,true)
               else begin
                      ViRect.Assign(0,atop,0,1);
                      insert(CurrentField,true);
                      OkAddRow := false;
                    end;
             end;

        if CurrentField <> nil
        Then CurrentField := CurrentField^.Next;
      end;

      OkAddRow := true;

      aTop := aTop + HeightChar;
    end;

    { Não pode porque bagunça o formulário
    (aOwner as TScrollingWinControl).AutoSize:= true;}

    { A instrução abaixo só é válida se Height for menor que owner.Height
    (aOwner as TScrollingWinControl).Height:=  aTop+10;}

    If aOwner is TForm
    then (aOwner as TForm).AutoScroll := true
    else if aOwner is TScrollBox
         then begin
                (aOwner as TScrollBox).AutoScroll :=true;
              end;
  end;


  procedure TDmxScroller_Form_Lcl_DS.UpdateBuffers_Controls;
  begin
    //inherited UpdateBuffers_Controls; Nunca os controles não associados a DataSet nunca existirar aqui.
    if CurrentField^.LinkEdit is TMI_DbEdit_LCL
    Then begin
           (CurrentField^.LinkEdit as TMI_DbEdit_LCL).GetBuffer;
         End
    else if (CurrentField^.LinkEdit is TMi_ui_DbLookupComboBox_LCL)
    then (CurrentField^.LinkEdit as TMi_ui_DbLookupComboBox_LCL).GetBuffer;
  end;

  procedure TDmxScroller_Form_Lcl_DS.SetActiveTarget(aActive: Boolean);
  begin
    inherited SetActiveTarget(aActive);
  end;

end.

