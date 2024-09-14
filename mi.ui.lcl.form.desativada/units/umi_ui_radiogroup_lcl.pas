unit umi_ui_radiogroup_lcl;
{: A unit **@name** implementa a class TMI_DbRadioButton_LCL com objetivo
   associar a classe TRadioButton ao registro TDMXCroller.CurrentField.fldRadioButton.

   - **VERSÃO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_radiogroup_lcl.pas">uMI_RadioGroup_LCL.pas</a>)

   - **PENDÊNCIAS**

   - **HISTÓRICO**
     - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
     - **2022-06-03**
       - T12 - Criar propriedade DmxScroller_Form_Lcl_attributes;  ✅
       - T12 - Criar propriedade pDmxFieldRec;   ✅
       - T12 - Criar método Procedure PutBuffer; ✅
       - T12 - Criar método Procedure GetBuffer; ✅
       - T12 - Criar evento Procedure DoOnEnter; ✅
       - T12 - Criar evento Procedure DoOnExit;  ✅


   }


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, ExtCtrls,StrUtils
  ,ActnList
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form

  ,umi_ui_dmxscroller_form_lcl_attributes
  ;


type
  { TMI_RadioGroup_LCL }
  {:< A a classe **@name** é usada para edição do campo tipo TDmxFieldRec^.fldRadioButton

       - **NOTA**
         - As coordenadas do retângulo são criados automaticamente baseado no número de itens
           e tamanho dos alias adicionados em items.

         - O tipo de dados, largura, altura, mascara de edição e tipo de acesso do campo
           são obtidos do tipo TDmxFieldRec no atributo DmxScroller_Form_Lcl_attributesr.CurrentField.

         - O componentes TScrollingWinControl deve ser passado por constructor.Create(TScrollingWinControl) já inicializado.

         - A propriedade DmxScroller_Form_Lcl_attributes deve ser passada após acriação do componente.

   }
  TMI_RadioGroup_LCL = class(TRadioGroup)
    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;
      private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes  write SetDmxScroller_Form_Lcl_attributes;

    {$endREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}

    {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
    Public Procedure GetBuffer;

    //protected procedure DoOnChange(Sender: TObject);
    protected procedure DoOnEnter(Sender: TObject);


    {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
    public Procedure PutBuffer;

    {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec^.DoOnExit(Self).}
    Protected procedure DoOnExit(Sender: TObject);


    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;

      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


      {: A propriedade **@name** fornece os dados necessários para criar o componente TMI_Button_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método DmxScroller_Form_Lcl_attributesr.CreateStruct(var ATemplate : TString)
      }
      public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}


  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I umi_ui_radiogroup_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TMI_RadioGroup_LCL]);
//end;

{ TMI_RadioGroup_LCL }

procedure TMI_RadioGroup_LCL.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;


procedure TMI_RadioGroup_LCL.GetBuffer;
  Var
    waccess : Byte;
    s : byte;
begin
 if DmxFieldRec <> nil then
   with TDmxScroller_Form_Lcl_attributes do
   try
    waccess := DmxFieldRec^.SetAccess(AccNormal);
    ItemIndex := DmxFieldRec^.Value;
   finally
     DmxFieldRec^.SetAccess(waccess);
   end;
end;

procedure TMI_RadioGroup_LCL.DoOnEnter(Sender: TObject);
begin
  if (DmxFieldRec<>nil ) and (not DmxFieldRec^.reintrance_OnEnter)
  then begin
          try
           DmxFieldRec^.reintrance_OnEnter := true;

           DmxFieldRec^.DoOnEnter(Self);
           GetBuffer;

           //Usado quando Self estiver inserido em um stringGrid
           //if _StringGrid<>nil
           //then begin
           //       Visible := true;
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //não precisa recebe o dado do arquivo.
           //     end;

          finally
            DmxFieldRec^.reintrance_OnEnter := false;
          end;
       end;
end;

procedure TMI_RadioGroup_LCL.PutBuffer;
  Var
    waccess : Byte;
    S : byte;
begin
 if DmxFieldRec <> nil then
   with TDmxScroller_Form_Lcl_attributes do
   try
      waccess := DmxFieldRec^.SetAccess(AccNormal);

      if ItemIndex >= 0
      Then DmxFieldRec^.Value := ItemIndex
      else Raise TException.Create(Self,'PutBuffer','O campo não aceita valor negativo!');

      //if IsValidate then
        //if not pDmxFieldRec^.Valid(cmDMX_Enter)
        //then abort;
   finally
     DmxFieldRec^.SetAccess(waccess);
   end;
end;

procedure TMI_RadioGroup_LCL.DoOnExit(Sender: TObject);
begin
  if (DmxFieldRec<>nil) and ( Not  DmxFieldRec^.reintrance_OnExit)
  then with TDmxScroller_Form_Lcl_attributes do
       try
         DmxFieldRec^.reintrance_OnExit := true;

         PutBuffer;
         DmxFieldRec^.DoOnExit(Self);

         //Is isValidate then
         //if not pDmxFieldRec^.Valid(cmDMX_Enter)
         //then abort;

       finally
         DmxFieldRec^.reintrance_OnExit := False;
       end;

end;

procedure TMI_RadioGroup_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  var
    ContainedAction  : TContainedAction;
    s : string;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil)
  then Try
    DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec;
    name := DmxScroller_Form_Lcl_attributes.GetNameValid(DmxScroller_Form_Lcl_attributes.CurrentField.FieldName);
    if DmxFieldRec^.HelpCtx_Hint<>''
    then hint := DmxFieldRec^.HelpCtx_Hint
    else hint := DmxFieldRec^.FieldName;

    if hint <> ''
    Then ShowHint := true
    else ShowHint := False;

    OnEnter := DoOnEnter;
    onExit  := DoOnExit;

    {$REGION '---> Seta tipo de acesso'}
       with DmxScroller_Form_Lcl_attributes do
       begin
         Self.Visible  := true;
         Self.TabStop  := True;
         Self.Enabled  := True;
//         self.ReadOnly := false;

         if ((DmxFieldRec^.access and accSkip)<>0)
         then begin
                Self.TabStop  := False;
              end;

         if ((DmxFieldRec^.access and accReadOnly)<>0)
         then begin
//                self.ReadOnly := true;
              end;

         if ((DmxFieldRec^.access and  accHidden)<>0)
         then Visible := false;

       end;
    {$ENDREGION}

    with DmxScroller_Form_Lcl_attributes do
    begin
      if ActionList<> nil
      Then Begin
              ContainedAction := ActionList.ActionByName(DmxFieldRec^.ExecAction);
              if ContainedAction is TAction
              then begin
                     Action := ContainedAction as TAction;
                   end;
      end;
    end;

    Caption := DmxFieldRec^.Alias;
//   Self.Alignment := taLeftJustify;

    if Owner is TScrollingWinControl
    then Begin
           AutoSize := true; //Necessário se autoSize para que se possa criar várias colunas usando a altura do caracter
//             Visible := false;
         end;

  Finally
  end;
end;

end.
