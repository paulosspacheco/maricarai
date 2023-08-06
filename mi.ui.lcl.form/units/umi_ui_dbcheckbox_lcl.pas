unit uMi_Ui_DBCheckBox_Lcl;
{: A unit **@name** implementa a class TMI_DbCheckBox_LCL com objetivo de ligar
   os campo tipo TDmxFieldRec.fldBoolean com o componente TDBCheckBox do Lazarus.

   - **VERSÂO**
     - Alpha - 0.8.0

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
  ,umi_ui_dmxscroller_form_lcl_attributes
  ;

type
  {TMi_Ui_DBCheckBox_Lcl}
  {: A classe **@name** permite edita um campo boolean do registro **TDmxFieldRec**

     - **NOTA**
       -
  }
  TMi_Ui_DBCheckBox_Lcl = class(TDBCheckBox)
    Public constructor Create(AOwner:TComponent);override;
    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;
      private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);
      published property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes write SetDmxScroller_Form_Lcl_attributes;
    {$endREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}

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
//             private _VidisSeTDmxFieldRec:Boolean;
      strict Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );

      Public
      {: O atributo **@name** fornece os dados necessários para criar o componente TMI_MaskEdit_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método TDmxScroller_Form_Lcl_attributes.CreateStruct(var ATemplate : TString)
      }
      property  DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}

  end;

procedure Register;

implementation

procedure Register;
begin
  {$I umi_ui_dbcheckbox_lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl',[TMi_Ui_DBCheckBox_Lcl]);
end;

{ TMi_Ui_DBCheckBox_Lcl }

constructor TMi_Ui_DBCheckBox_Lcl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner as TScrollingWinControl);
end;

procedure TMi_Ui_DBCheckBox_Lcl.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;

procedure TMi_Ui_DBCheckBox_Lcl.GetBuffer;
Var
  waccess : Byte;
  s : byte;
begin
 if DmxFieldRec <> nil then
   with TDmxScroller_Form_Lcl_attributes do
   try

    waccess := DmxFieldRec.SetAccess(AccNormal);

    S := DmxFieldRec.Value;
    if s = 0
    Then ValueChecked:= '0'
    else ValueChecked:= '1';

   finally
     DmxFieldRec.SetAccess(waccess);
   end;
end;

procedure TMi_Ui_DBCheckBox_Lcl.DoOnEnter(Sender: TObject);
begin
  if (DmxFieldRec<>nil ) and (not DmxFieldRec.vidis_OnEnter)
  then begin
          try
           DmxFieldRec.vidis_OnEnter := true;

           DmxFieldRec.DoOnEnter(Self);
           GetBuffer;

           //Usado quando Self estiver inserido em um stringGrid
           //if _StringGrid<>nil
           //then begin
           //       Visible := true;
           //       text := _StringGrid.Cells[_StringGrid.col,_StringGrid.row]; //não precisa recebe o dado do arquivo.
           //     end;

          finally
            DmxFieldRec.vidis_OnEnter := false;
          end;
       end;
end;

procedure TMi_Ui_DBCheckBox_Lcl.PutBuffer;
Var
  waccess : Byte;
  S : boolean;
begin
 if DmxFieldRec <> nil then
   with TDmxScroller_Form_Lcl_attributes do
   try
      waccess := DmxFieldRec.SetAccess(AccNormal);
      if Checked
      then s := true
      else S := false;
      DmxFieldRec^.Value := s;

      //if IsValidate then
        //if not pDmxFieldRec.Valid(cmDMX_Enter)
        //then abort;
   finally
     DmxFieldRec.SetAccess(waccess);
   end;
end;

procedure TMi_Ui_DBCheckBox_Lcl.DoOnExit(Sender: TObject);
begin
  if (DmxFieldRec<>nil) and ( Not  DmxFieldRec.vidis_OnExit)
  then with TDmxScroller_Form_Lcl_attributes do
       try
         DmxFieldRec.vidis_OnExit := true;

         PutBuffer;
         DmxFieldRec.DoOnExit(Self);

         //Is isValidate then
         //if not pDmxFieldRec.Valid(cmDMX_Enter)
         //then abort;

       finally
         DmxFieldRec.vidis_OnExit := False;
       end;

end;


procedure TMi_Ui_DBCheckBox_Lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
var
  ContainedAction  : TContainedAction;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil) then
  Try
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

    OnEnter := DoOnEnter;
    onExit  := DoOnExit;

    {$REGION '---> Seta tipo de acesso'}
       with DmxScroller_Form_Lcl_attributes do
       begin
         Self.Visible  := true;
         Self.TabStop  := True;
         Self.Enabled  := True;

         if ((DmxFieldRec^.access and accSkip)<>0)
         then begin
                Self.Visible := true;
                Self.TabStop  := False;
                Self.Enabled  := false;
              end;

         if ((DmxFieldRec^.access and accReadOnly)<>0)
         then begin
                Self.Visible  := true;
                Self.TabStop  := True;
                Self.Enabled  := false;
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

      Caption := DmxFieldRec^.Alias;
      Self.Alignment := taLeftJustify;
    end;
    if Owner is TScrollingWinControl
    then Begin
            AutoSize := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
            Width    := (DmxScroller_Form_Lcl_attributes.WidthChar * DmxFieldRec.ShownWid+2);
//            WriteLn(Format('Width %d ShowWidth %d ',[Width,DmxFieldRec.ShownWid]));
            Constraints.MinWidth := width;
            Constraints.MaxWidth := Constraints.MinWidth;
            Constraints.MaxHeight:= DmxScroller_Form_Lcl_attributes.HeightChar;
            Constraints.MinHeight:= Constraints.MaxHeight;
         end;

  Finally
  end;
end;


end.
