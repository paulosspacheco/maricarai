unit uButton_mi_lcl;
{: A unit **@name** implementa a class TMI_Button_LCL com objetivo selecionar TDMXCroller.CurrentField
   associado ao botão quando o botão for pressionado.

   - **VERSÃO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_button_lcl.pas">uMi_Button_LCL.pas</a>)

   - **PENDÊNCIAS**
     -

 - **HISTÓRICO**
   - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
   - **2022-06-01**
     - T12 - Criar propriedade DmxScroller_Form_Lcl_attributes;✅
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
  ,mi_rtl_ui_DmxScroller_Form
  //,umi_lcl_ui_dmxscroller_form_attributes
   ,uMi_lcl_ui_Form_attributes
  ;

type
  { TMi_Button_LCL }

  {: A classe **@name** é necessária para que se possa selecionar o controle associado
     ao botão criado pelo método: pDmxFieldRec^.createExecAction.
  }

  { TButton_mi_lcl }

  TButton_mi_lcl = class(TButton)
     Public constructor Create(AOwner:TComponent);override;overload;
     public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;
     public destructor destroy;override;

    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;
      private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes  write SetMi_lcl_ui_Form_attributes;
    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}

    protected procedure DoOnEnter(Sender: TObject);

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;

      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


      {: A propriedade **@name** fornece os dados necessários para criar o componente TButton_mi_lcl.

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
//  {$I umi_ui_button_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl.form',[TButton_mi_lcl]);
//end;

{ TButton_mi_lcl }

procedure TButton_mi_lcl.DoOnEnter(Sender: TObject);
begin
  DmxFieldRec.DoOnEnter(Self);
  if DmxFieldRec^.LinkExecAction<>nil
  Then begin
         Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec^.LinkExecAction;
       end;
  //if Assigned(Action)
  //then  Action.Execute;
end;

constructor TButton_mi_lcl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentFont:=true;
  //if aOwner is TScrollingWinControl
  //then begin
  //       font.name := (aOwner as TScrollingWinControl).Font.Name;
  //       font.Size := (aOwner as TScrollingWinControl).Font.Size;
  //     end;
end;

constructor TButton_mi_lcl.Create(aOwner: TComponent;
  aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  Create(aOwner);
  Mi_lcl_ui_Form_attributes:=aMi_lcl_ui_Form_attributes;
end;

destructor TButton_mi_lcl.destroy;
begin
  _pDmxFieldRec.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited destroy;
end;

procedure TButton_mi_lcl.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
  then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;


procedure TButton_mi_lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  var
    ContainedAction  : TContainedAction;
    S : AnsiString;
    sh : String;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil)
  then
   Try
      Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec;
      if DmxFieldRec^.HelpCtx_Hint<>''
      then hint := DmxFieldRec^.HelpCtx_Hint;
      OnEnter := DoOnEnter;

      {$REGION '---> Seta tipo de acesso'}
         with Mi_lcl_ui_Form_attributes do
         begin
            Self.Visible  := true;
            Self.TabStop  := True;
            Self.Enabled  := True;
//            Self.ReadOnly := false;

            //if ((DmxFieldRec^.access and accSkip)<>0)
            //then begin
            //       Self.TabStop  := False;
            //       //Self.ReadOnly := true;
            //     end;

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

        if DmxFieldRec^.Fieldnum=0
        then s := DmxFieldRec^.Template^
        else S := CharLupa_Left;

        s := trim(s);
        if s <> CharLupa_Left
        then s := ' '+s+' ';
    end;
    Font.name := 'Arial';
//        Font.name := 'verdana';

    //width  := (Owner as TScrollingWinControl).Canvas.TextWidth(s)+Mi_lcl_ui_Form_attributes.DmxScroller_Form.WidthChar;
    //Height := (Owner as TScrollingWinControl).Canvas.TextHeight(s)+(Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar div 2);
    Width  := (Mi_lcl_ui_Form_attributes.DmxScroller_Form.WidthChar * (DmxFieldRec^.ShownWid));
    Height := Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;

    Caption := s;

    if Owner is TScrollingWinControl
    then Begin
           AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.
           if s <> Mi_lcl_ui_Form_attributes.DmxScroller_Form.CharLupa_Left  Then
           begin
             Constraints.MinHeight:= Height;
             Constraints.MaxHeight:= Constraints.MinHeight+4;

             Constraints.MinWidth := width;
             Constraints.MaxWidth := Constraints.MinWidth+4;
           end
           else begin
                  Constraints.MinHeight:= Height;
                  Constraints.MaxHeight:= Constraints.MinHeight + 4;

                  Constraints.MinWidth := width;
                  Constraints.MaxWidth := Constraints.MinWidth+4;
//                      AutoSize   := true;
                end;
         end;



    Finally

//          pDmxFieldRec^.Link_IInputText := Self;

    end;
end;



end.
