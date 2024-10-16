unit uCheckbox_mi_lcl;
{: A unit **@name** implementa a class TMI_Button_LCL com objetivo selecionar TDMXCroller.CurrentField
   associado ao botão quando o botão for pressionado.

   - **VERSÃO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_checkBox_lcl.pas">uMI_CheckBox_LCL.pas</a>)

   - **PENDÊNCIAS**

   - **HISTÓRICO**
     - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
     - **2022-06-01**
       - T12 - Criar propriedade DmxScroller_Form_Lcl_attributes; ✅
       - T12 - Criar propriedade pDmxFieldRec;  ✅

     - **2022-06-02**
       - T12 - Criar método Procedure PutBuffer;  ✅
       - T12 - Criar método Procedure GetBuffer;  ✅
       - T12 - Criar evento Procedure DoOnEnter;  ✅
       - T12 - Criar evento Procedure DoOnExit;   ✅


   }


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls
    ,ActnList
    ,mi_rtl_ui_DmxScroller
    ,mi_rtl_ui_DmxScroller_Form
    //,umi_lcl_ui_dmxscroller_form_attributes
    ,uMi_lcl_ui_Form_attributes
  ;

type
  {TMI_CheckBox_LCL}

  {:< A a classe **@name** é usada para edição do campo tipo TDmxFieldRec.fldBoolea e fldCheckbox

      - **NOTA**
        - As coordenadas do retângulo devem ser definidas após a criação e inclusão
          do controle em TScrollBox ou TFrame ou TForm.

        - O tipo de dados, largura, altura, mascara de edição e tipo de acesso do campo
          são obtidos do tipo TDmxFieldRec no atributo DmxScroller_Form_Lcl_attributesr.CurrentField.

        - O componentes TScrollingWinControl deve ser passado por constructor.Create(TScrollingWinControl) já inicializado.

        - A propriedade DmxScroller_Form_Lcl_attributes deve ser passada após acriação do componente.

  }

  { TCheckbox_mi_lcl }

  TCheckbox_mi_lcl = class(TCheckBox)

    Public constructor Create(AOwner:TComponent);override;overload;
    public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;

    public destructor destroy;override;


    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
      private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes  write SetMi_lcl_ui_Form_attributes;

    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

    {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
    public Procedure PutBuffer;


    {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
    Public Procedure GetBuffer;

    //protected procedure DoOnChange(Sender: TObject);
    protected procedure DoOnEnter(Sender: TObject);


    {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
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

    public function GetHTMLContent: String;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I umi_ui_checkbox_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TCheckbox_mi_lcl]);
//end;

{ TCheckbox_mi_lcl }

constructor TCheckbox_mi_lcl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentFont:=true;
  //if aOwner is TScrollingWinControl
  //then begin
  //       font.name := (aOwner as TScrollingWinControl).Font.Name;
  //       font.Size := (aOwner as TScrollingWinControl).Font.Size;
  //     end;
end;

constructor TCheckbox_mi_lcl.Create(aOwner: TComponent;
  aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(aOwner);
  Mi_lcl_ui_Form_attributes:= aMi_lcl_ui_Form_attributes;
end;

destructor TCheckbox_mi_lcl.destroy;
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited destroy;
end;

procedure TCheckbox_mi_lcl.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
  then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;

procedure TCheckbox_mi_lcl.PutBuffer;
Var
  waccess : Byte;
  S : byte;
begin
 if DmxFieldRec <> nil then
   with TMi_lcl_ui_Form_attributes do
   try
      waccess := DmxFieldRec.SetAccess(AccNormal);
      if Checked
      then s := 1
      else S := 0;
      DmxFieldRec^.Value := s;

      //if IsValidate then
        //if not pDmxFieldRec.Valid(cmDMX_Enter)
        //then abort;
   finally
     DmxFieldRec.SetAccess(waccess);
   end;
end;

procedure TCheckbox_mi_lcl.GetBuffer;
Var
  waccess : Byte;
  s : byte;
begin
 if DmxFieldRec <> nil then
   with TMi_lcl_ui_Form_attributes do
   try

    waccess := DmxFieldRec.SetAccess(AccNormal);

    S := DmxFieldRec.Value;
    if s = 0
    Then Checked:= false
    else Checked:= True;

   finally
     DmxFieldRec.SetAccess(waccess);
   end;
end;

procedure TCheckbox_mi_lcl.DoOnEnter(Sender: TObject);
begin
  if (DmxFieldRec<>nil ) and (not DmxFieldRec.reintrance_OnEnter)
  then begin
          try
           DmxFieldRec.reintrance_OnEnter := true;

           DmxFieldRec.DoOnEnter(Self);
           GetBuffer;

           //Usado quando Self estiver inserido em um stringGrid
           //if _StringGrid<>nil
           //then begin
           //       Visible := true;
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //não precisa recebe o dado do arquivo.
           //     end;

          finally
            DmxFieldRec.reintrance_OnEnter := false;
          end;
       end;
end;

procedure TCheckbox_mi_lcl.DoOnExit(Sender: TObject);
begin
  if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.reintrance_OnExit)
  then with TMi_lcl_ui_Form_attributes do
       try
         DmxFieldRec.reintrance_OnExit := true;

         PutBuffer;
         DmxFieldRec.DoOnExit(Self);

         //Is isValidate then
         //if not pDmxFieldRec.Valid(cmDMX_Enter)
         //then abort;

       finally
         DmxFieldRec.reintrance_OnExit := False;
       end;

end;

procedure TCheckbox_mi_lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
var
  ContainedAction  : TContainedAction;
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
                //Self.ReadOnly := true;
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
    Self.Alignment := taLeftJustify;

    Width  := (Mi_lcl_ui_Form_attributes.DmxScroller_Form.WidthChar * (DmxFieldRec^.ShownWid+2));
    Height := Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;

    if Owner is TScrollingWinControl
    then Begin
            AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
//            Width                := Mi_lcl_ui_Form_attributes.DmxScroller_Form.WidthChar * (DmxFieldRec.ShownWid+2);
            Constraints.MinWidth := width;
            Constraints.MaxWidth := Constraints.MinWidth+4;

            Constraints.MinHeight:= Height;
            Constraints.MaxHeight:= Constraints.MinHeight+4;

         end;

  Finally
  end;
end;

function TCheckbox_mi_lcl.GetHTMLContent: String;
begin

end;


end.
