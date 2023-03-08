unit uMi_ui_Label_lcl;
{: A unit **@name** implementa a class TMi_Label_lcl com objetivo de ligar
   os campo tipo TDmxFieldRec.fldEnum=0 com o componente TLabel do Lazarus.

   - **VERSÂO**
     - Alpha - 0.5.0.693

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
     - T12: Criar propriedade UiDmxScroller; ✅

   - **HISTÓRICO**
     - **29/06/2022**
       - **17:10**
         - Criar a classe TMi_ui_Label_lcl herdando de TLabel. ✅
         - T12: Criar unit **@name** herdado de TLabel.✅
         - T12: Criar propriedade UiDmxScroller; ✅

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

  ;

type

  { TMi_ui_Label_lcl }

  TMi_ui_Label_lcl = class(TLabel)

    {$REGION ' # Propriedade UiDmxScroller '}
      private var _UiDmxScroller : TUiDmxScroller;

      {: O método **@name** Inicia _UiDmxScroller e executa o método SeTDmxFieldRec}
      private Procedure SetUiDmxScroller (aUiDmxScroller : TUiDmxScroller);

      protected procedure DoOnClick(Sender: TObject);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property UiDmxScroller : TUiDmxScroller Read _UiDmxScroller  write SetUiDmxScroller;
    {$endREGION ' # Propriedade UiDmxScroller '}


    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;

      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


      {: A propriedade **@name** fornece os dados necessários para criar o componente TMI_BitBtn_LCL.

         - **NOTA**
           - Esses dados devem ser criados pelo método UiDmxScrollerr.CreateStruct(var ATemplate : TString)
      }
      public property DmxFieldRec: pDmxFieldRec Read _pDmxFieldRec   Write  SeTDmxFieldRec;
    {$ENDREGION}



  end;

procedure Register;

implementation

procedure Register;
begin
  {$I umi_ui_label_lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl',[TMi_ui_Label_lcl]);
end;

{ TMi_ui_Label_lcl }

procedure TMi_ui_Label_lcl.SetUiDmxScroller(aUiDmxScroller: TUiDmxScroller);
begin
  _UiDmxScroller := aUiDmxScroller;
  IF (_UiDmxScroller<>nil) and (_UiDmxScroller.CurrentField<>nil)
  then SeTDmxFieldRec(_UiDmxScroller.CurrentField);
end;

procedure TMi_ui_Label_lcl.DoOnClick(Sender: TObject);
begin
  DmxFieldRec.DoOnEnter(Self);
  if DmxFieldRec^.LinkExecAction<>nil
  Then UiDmxScroller.CurrentField := DmxFieldRec^.LinkExecAction;
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
  if (UiDmxScroller<>nil) and (DmxFieldRec<>nil) then
  Begin
      UiDmxScroller.CurrentField := DmxFieldRec;

      if DmxFieldRec^.HelpCtx_Hint<>''
      then hint := DmxFieldRec^.HelpCtx_Hint;

      with UiDmxScroller do
      begin
        if ((DmxFieldRec^.access and  accHidden)<>0)
        then begin
               Visible := false;
             end;
      end;

      OnClick := DoOnClick;

      {$REGION '---> Seta tipo de acesso'}
       with UiDmxScroller do
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

     with UiDmxScroller do
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
     width := ((DmxFieldRec^.ShownWid)*UiDmxScroller.WidthChar);
     Height   := UiDmxScroller.HeightChar;
     if Owner is TScrollingWinControl
     then Begin
            AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
            if s <> UiDmxScroller.CharLupa_Left  Then
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

end.
