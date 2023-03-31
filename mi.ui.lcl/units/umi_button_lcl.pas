unit uMI_Button_LCL;
{: A unit **@name** implementa a class TMI_Button_LCL com objetivo selecionar TDMXCroller.CurrentField
   associado ao botão quando o botão for pressionado.

   - **VERSÃO**
     - Alpha - 0.5.0.687

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_button_lcl.pas">uMi_Button_LCL.pas</a>)

   - **PENDÊNCIAS**
     -

 - **HISTÓRICO**
   - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
   - **2022-06-01**
     - T12 - Criar propriedade UiDmxScroller;✅
     - T12 - Criar propriedade pDmxFieldRec;✅
     - T12 - Criar evento DoOnEnter; ✅
     - T12 - Selecionar o campo pDmxFieldRec^.LinkExecAction ; ✅

   }


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, StdCtrls,ActnList
  ,mi_rtl_ui_DmxScroller;

type
  { TMi_Button_LCL }

  {: A classe **@name** é necessária para que se possa selecionar o controle associado
     ao botão criado pelo método: pDmxFieldRec^.createExecAction.
  }
  TMI_Button_LCL = class(TButton)
    {$REGION ' # Propriedade UiDmxScroller '}
      private var _UiDmxScroller : TUiDmxScroller;
      private Procedure SetUiDmxScroller (aUiDmxScroller : TUiDmxScroller);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property UiDmxScroller : TUiDmxScroller Read _UiDmxScroller  write SetUiDmxScroller;
    {$endREGION ' # Propriedade UiDmxScroller '}

    protected procedure DoOnEnter(Sender: TObject);

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;

      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


      {: A propriedade **@name** fornece os dados necessários para criar o componente TMI_Button_LCL.

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
  {$I umi_button_lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl',[TMI_Button_LCL]);
end;

{ TMi_Button_LCL }

procedure TMI_Button_LCL.DoOnEnter(Sender: TObject);
begin
  DmxFieldRec.DoOnEnter(Self);
//  writeLn('TMI_Button_LCL.DoOnEnter: '+DmxFieldRec^.FieldName);
  if DmxFieldRec^.LinkExecAction<>nil
  Then begin
         UiDmxScroller.CurrentField := DmxFieldRec^.LinkExecAction;
       end;
end;

procedure TMI_Button_LCL.SetUiDmxScroller(aUiDmxScroller: TUiDmxScroller);
begin
  _UiDmxScroller := aUiDmxScroller;
  IF (_UiDmxScroller<>nil) and (_UiDmxScroller.CurrentField<>nil)
  then SeTDmxFieldRec(_UiDmxScroller.CurrentField);
end;


procedure TMI_Button_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  var
    ContainedAction  : TContainedAction;
    S : AnsiString;
    sh : String;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (UiDmxScroller<>nil) and (DmxFieldRec<>nil)
  then
   Try
      UiDmxScroller.CurrentField := DmxFieldRec;
      if DmxFieldRec^.HelpCtx_Hint<>''
      then hint := DmxFieldRec^.HelpCtx_Hint;
      OnEnter := DoOnEnter;

      {$REGION '---> Seta tipo de acesso'}
         with UiDmxScroller do
         begin

           Self.Visible  := true;
           Self.TabStop  := True;
           Self.Enabled  := True;

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

        s := trim(s);
        if s <> CharLupa_Left
        then s := ' '+s+' ';
    end;
    Font.name := 'Arial';
//        Font.name := 'verdana';

    width  := (Owner as TScrollingWinControl).Canvas.TextWidth(s)+UiDmxScroller.WidthChar;
    Height := (Owner as TScrollingWinControl).Canvas.TextHeight(s)+(UiDmxScroller.HeightChar div 2);
    Caption := s;

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
//                      AutoSize   := true;
                end;
         end;



    Finally

//          pDmxFieldRec^.Link_IInputText := Self;

    end;
end;


end.
