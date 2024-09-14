unit uRadiogroup_mi_lcl;
{: A unit **@name** implementa a class TMI_DbRadioButton_LCL com objetivo
   associar a classe TRadioButton ao registro TDMXCroller.CurrentField.fldRadioButton.

   - **VERSÃO**
     - Alpha - 0.9.0

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

  //,umi_lcl_ui_dmxscroller_form_attributes
  ,uMi_lcl_ui_Form_attributes
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

  { TRadiogroup_mi_lcl }

  TRadiogroup_mi_lcl = class(TRadioGroup)

     Public constructor Create(AOwner:TComponent);override;overload;
     public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;

     public destructor destroy;override;

    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
      private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes  write SetMi_lcl_ui_Form_attributes;

    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

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
           - Esses dados devem ser criados pelo método Mi_lcl_ui_Form_attributesr.CreateStruct(var ATemplate : TString)
      }
      public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}


  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I umi_ui_radiogroup_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TRadiogroup_mi_lcl]);
//end;

{ TRadiogroup_mi_lcl }

constructor TRadiogroup_mi_lcl.Create(AOwner: TComponent);
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;

  inherited Create(AOwner);
  ParentFont:=true;
end;

constructor TRadiogroup_mi_lcl.Create(aOwner: TComponent;
  aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(aOwner);
  Mi_lcl_ui_Form_attributes:=aMi_lcl_ui_Form_attributes;
end;

destructor TRadiogroup_mi_lcl.destroy;
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited destroy;
end;

procedure TRadiogroup_mi_lcl.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
  then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;


procedure TRadiogroup_mi_lcl.GetBuffer;
  Var
    waccess : Byte;
    s : byte;
begin
 if DmxFieldRec <> nil then
   with TMi_lcl_ui_Form_attributes do
   try
    waccess := DmxFieldRec^.SetAccess(AccNormal);
    ItemIndex := DmxFieldRec^.Value;
   finally
     DmxFieldRec^.SetAccess(waccess);
   end;
end;

procedure TRadiogroup_mi_lcl.DoOnEnter(Sender: TObject);
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

procedure TRadiogroup_mi_lcl.PutBuffer;
  Var
    waccess : Byte;
    S : byte;
begin
 if DmxFieldRec <> nil then
   with TMi_lcl_ui_Form_attributes do
   try
      waccess := DmxFieldRec^.SetAccess(AccNormal);

      if ItemIndex >= 0
      Then DmxFieldRec^.Value := ItemIndex
      else Raise Mi_lcl_ui_Form_attributes.DmxScroller_Form.TException.Create(Self,'PutBuffer','O campo não aceita valor negativo!');

      //if IsValidate then
        //if not pDmxFieldRec^.Valid(cmDMX_Enter)
        //then abort;
   finally
     DmxFieldRec^.SetAccess(waccess);
   end;
end;

procedure TRadiogroup_mi_lcl.DoOnExit(Sender: TObject);
begin
  if (DmxFieldRec<>nil) and ( Not  DmxFieldRec^.reintrance_OnExit)
  then with TMi_lcl_ui_Form_attributes do
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

procedure TRadiogroup_mi_lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  var
    ContainedAction  : TContainedAction;
    s : string;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil)
  then Try
    Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec;
    name := Mi_lcl_ui_Form_attributes.DmxScroller_Form.GetNameValid(Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField.FieldName);
    if DmxFieldRec^.HelpCtx_Hint<>''
    then hint := DmxFieldRec^.HelpCtx_Hint
    else hint := DmxFieldRec^.FieldName;

    if hint <> ''
    Then ShowHint := true
    else ShowHint := False;

    OnEnter := DoOnEnter;
    onExit  := DoOnExit;

    {$REGION '---> Seta tipo de acesso'}
       with Mi_lcl_ui_Form_attributes do
       begin
         Self.Visible  := true;
         Self.TabStop  := True;
         Self.Enabled  := True;
//         Self.ReadOnly := false;

         if ((DmxFieldRec^.access and accSkip)<>0)
         then begin
                Self.TabStop  := False;
//                Self.ReadOnly := true;
              end;

         //if ((DmxFieldRec^.access and accReadOnly)<>0)
         //then Self.ReadOnly := true;

         if ((DmxFieldRec^.access and  accHidden)<>0)
         then Visible := false;

       end;
    {$ENDREGION}

    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
    begin

      Action := Mi_lcl_ui_Form_attributes.getAction(self,DmxFieldRec^.ExecAction);
      //if ActionList<> nil
      //Then Begin
      //        ContainedAction := ActionList.ActionByName(DmxFieldRec^.ExecAction);
      //        if ContainedAction is TAction
      //        then begin
      //               Action := ContainedAction as TAction;
      //             end;
      //end;
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
