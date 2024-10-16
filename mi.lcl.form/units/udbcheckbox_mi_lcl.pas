unit uDbcheckbox_mi_lcl;
{: A unit **@name** implementa a class TMI_DbCheckBox_LCL com objetivo de ligar
   os campo tipo TDmxFieldRec.fldBoolean com o componente TDBCheckBox do Lazarus.

   - **VERSÂO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_ui_dbcheckbox_lcl.pas">uMi_Ui_DBCheckBox_Lcl.pas</a>)

   - **PENDÊNCIAS**

   - **HISTÓRICO**
     - **2022/06/07**
       - **9:30**
         - Criar a unit **@name**
         - Análise.
           - Implementar a propriedade DmxScroller_Form_Lcl_attributes;
           - Implementar o método GetBuffer;
           - Implementar o evento DoOnEnter;
           - Implementar o método PutBuffer;
           - Implementar o evento DoOnExit;
           - Implementar a propriedade DmxFieldRec;
}


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, DBCtrls
  ,ActnList
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  //,umi_lcl_ui_dmxscroller_form_attributes

  ,uMi_lcl_ui_Form_attributes
  ;

type
  {TMi_Ui_DBCheckBox_Lcl}
  {: A classe **@name** permite edita um campo boolean do registro **TDmxFieldRec**

     - **NOTA**
       -
  }

  { TDBCheckBox_mi_Lcl }

  TDBCheckBox_mi_Lcl = class(TDBCheckBox)

    Public constructor Create(AOwner:TComponent);override;overload;
    public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;

    public destructor destroy;override;

    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
      private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);
      published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes write SetMi_lcl_ui_Form_attributes;
    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

    //protected procedure DoOnChange(Sender: TObject);
    protected procedure DoOnEnter(Sender: TObject);


    {: O método **@name** ao perder o foco executa os métodos PuttBuffer e pDmxFieldRec.DoOnExit(Self).}
    Protected procedure DoOnExit(Sender: TObject);

    {: O método **@name** salva os dados do controle (Self) para a propriedade pDmxFieldRec}
    public Procedure PutBuffer;


    {: O método **@name** ler os dados da propriedade pDmxFieldRec para o controle (Self).}
    Public Procedure GetBuffer;

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      strict Private Var _pDmxFieldRec : pDmxFieldRec;
//             private _reintranceSeTDmxFieldRec:Boolean;
      strict Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );

      Public
      {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método TMi_lcl_ui_Form_attributes.CreateStruct(var ATemplate : TString)
      }
      property  DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}

    public function GetHTMLContent: String;
  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I uDBCheckBox_mi_Lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TDBCheckBox_mi_Lcl]);
//end;

{ TDBCheckBox_mi_Lcl }

constructor TDBCheckBox_mi_Lcl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner as TScrollingWinControl);
  ParentFont:=true;
end;

constructor TDBCheckBox_mi_Lcl.Create(aOwner: TComponent;
  aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(aOwner);
  Mi_lcl_ui_Form_attributes:=aMi_lcl_ui_Form_attributes;
end;

destructor TDBCheckBox_mi_Lcl.destroy;
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited destroy;
end;

procedure TDBCheckBox_mi_Lcl.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
  then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;

procedure TDBCheckBox_mi_Lcl.GetBuffer;
begin
  if DmxFieldRec <> nil
  then DmxFieldRec^.CopyTo(Field);
end;

procedure TDBCheckBox_mi_Lcl.DoOnEnter(Sender: TObject);
begin
  if (DmxFieldRec<>nil ) and
     (not DmxFieldRec.reintrance_OnEnter) and
     Field.DataSet.CanModify
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

procedure TDBCheckBox_mi_Lcl.PutBuffer;
begin
  if DmxFieldRec <> nil
  then DmxFieldRec^.CopyFrom(Field);
end;

procedure TDBCheckBox_mi_Lcl.DoOnExit(Sender: TObject);
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

procedure TDBCheckBox_mi_Lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
var
  ContainedAction  : TContainedAction;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil) then
  Try
    Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec;

    name := Mi_lcl_ui_Form_attributes.DmxScroller_Form.GetNameValid(Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField.FieldName);

    if DmxFieldRec^.HelpCtx_Hint<>''
    then hint := DmxFieldRec^.HelpCtx_Hint
    else hint := DmxFieldRec^.FieldName;

    if hint <> ''
    Then ShowHint := true
    else ShowHint := False;

    Self.DataSource := Mi_lcl_ui_Form_attributes.DmxScroller_Form.DataSource;
    Self.DataField  := Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField.FieldName ;

    OnEnter := DoOnEnter;
    onExit  := DoOnExit;

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

    with Mi_lcl_ui_Form_attributes.DmxScroller_Form do
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

      Caption := DmxFieldRec^.Alias;
      Self.Alignment := taLeftJustify;
    end;
    if Owner is TScrollingWinControl
    then Begin
            AutoSize := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
            Width    := (Mi_lcl_ui_Form_attributes.DmxScroller_Form.WidthChar * DmxFieldRec.ShownWid+2);
//            WriteLn(Format('Width %d ShowWidth %d ',[Width,DmxFieldRec.ShownWid]));
            Constraints.MinWidth := width;
            Constraints.MaxWidth := Constraints.MinWidth;
            Constraints.MaxHeight:= Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;
            Constraints.MinHeight:= Constraints.MaxHeight;
         end;

  Finally
  end;
end;

function TDBCheckBox_mi_Lcl.GetHTMLContent: String;
begin

end;


end.
