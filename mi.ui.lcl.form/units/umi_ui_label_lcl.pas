unit uMi_ui_Label_lcl;
{: A unit **@name** implementa a class TMi_Label_lcl com objetivo de ligar
   os campo tipo TDmxFieldRec.fldEnum=0 com o componente TLabel do Lazarus.

   - **VERSÂO**
     - Alpha - 0.7.1

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_ui_label_lcl.pas">uMi_ui_Label_lcl.pas</a>)

   - **PENDÊNCIAS**
     - T12: Documentar a unidade.
     - T12: Criar propriedade pDmxFieldRec;
     - T12: Criar método procedure DoOnEnter(Sender: TObject);
       - Esse evento deve selecionar o campo viznho cujo o número seja <> zero.

   - **CONCLUÍDO**
     - Criar a classe TMi_ui_Label_lcl herdando de TLabel. ✅
     - T12: Criar unit **@name** herdado de TLabel.✅
     - T12: Criar propriedade DmxScroller_Form_Lcl_attributes; ✅

   - **HISTÓRICO**
     - **29/06/2022**
       - **17:10**
         - Criar a classe TMi_ui_Label_lcl herdando de TLabel. ✅
         - T12: Criar unit **@name** herdado de TLabel.✅
         - T12: Criar propriedade DmxScroller_Form_Lcl_attributes; ✅

       - **20:15**
         -

}

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,ActnList
  ,mi_rtl_ui_DmxScroller
  ,mi_rtl_ui_DmxScroller_Form
  ,umi_ui_dmxscroller_form_lcl_attributes

  ;

type

  { TMi_ui_Label_lcl }

  TMi_ui_Label_lcl = class(TLabel)

    protected procedure DoOnClick(Sender: TObject);

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;

      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


      {: A propriedade **@name** fornece os dados necessários para criar o componente TMI_BitBtn_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método DmxScroller_Form_Lcl_attributesr.CreateStruct(var ATemplate : TString)
      }
      public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}



    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;

      {: O método **@name** Inicia _DmxScroller_Form_Lcl_attributes e executa o método SeTDmxFieldRec}
      private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes  write SetDmxScroller_Form_Lcl_attributes;
    {$endREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}


  end;

procedure Register;

implementation

procedure Register;
begin
  {$I umi_ui_label_lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl',[TMi_ui_Label_lcl]);
end;

{ TMi_ui_Label_lcl }

procedure TMi_ui_Label_lcl.DoOnClick(Sender: TObject);
begin
  DmxFieldRec.DoOnEnter(Self);
  if DmxFieldRec^.LinkExecAction<>nil
  Then DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec^.LinkExecAction;
end;


procedure TMi_ui_Label_lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
var
  ContainedAction  : TContainedAction;
  S : AnsiString;
  sh : String;

  W1,W2 :Integer;

begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil) then
  Begin
      DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec;

      if DmxFieldRec^.HelpCtx_Hint<>''
      then hint := DmxFieldRec^.HelpCtx_Hint;

      with DmxScroller_Form_Lcl_attributes do
      begin
        if ((DmxFieldRec^.access and  accHidden)<>0)
        then begin
               Visible := false;
             end;
      end;

      OnClick := DoOnClick;

      {$REGION '---> Seta tipo de acesso'}
       with DmxScroller_Form_Lcl_attributes do
       begin
         Self.Visible  := true;
         Self.Enabled  := True;

         if ((DmxFieldRec^.access and accReadOnly)<>0)
         then begin
                Self.Visible  := true;
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


        if DmxFieldRec^.Fieldnum=0
        then s := DmxFieldRec^.Template^
        else S := CharLupa_Left;

        if AlignmentLabels in [taRightJustify, taCenter]
        then begin
               s := trim(s);
               Alignment := AlignmentLabels;
             end;
     end;

     Caption := s;
     width := ((DmxFieldRec^.ShownWid)*DmxScroller_Form_Lcl_attributes.WidthChar);
     Height   := DmxScroller_Form_Lcl_attributes.HeightChar;
     if Owner is TScrollingWinControl
     then Begin
            AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
            if s <> DmxScroller_Form_Lcl_attributes.CharLupa_Left  Then
            begin
              Constraints.MaxHeight:= Height;
              Constraints.MinHeight:= Constraints.MaxHeight;
              Constraints.MinWidth := width;
              Constraints.MaxWidth := Constraints.MinWidth;
            end
            else begin
                   Constraints.MaxHeight:= Height - 4;
                   Constraints.MinHeight:= 0;//Constraints.MaxHeight;
                   Constraints.MinWidth := width +4;
                   Constraints.MaxWidth := Constraints.MinWidth;
                 end;
          end;
    end;
end;


procedure TMi_ui_Label_lcl.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;

end.
