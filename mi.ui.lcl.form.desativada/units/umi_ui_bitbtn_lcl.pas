unit umi_ui_bitbtn_lcl;
{: A unit **@name** implementa a class TMI_BitBtn_LCL com objetivo selecionar TDMXCroller.CurrentField
   associado ao botão quando o botão for pressionado.

   - **VERSÃO**
     - Alpha - 1.0.0

   - **CÓDIGO FONTE**:
     - @html(<a href="../units/umi_bitbtn_lcl.pas">uMi_BitBtn_LCL.pas</a>)

   - **PENDÊNCIAS**
     -

 - **HISTÓRICO**
   - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
   - **2022-05-31**
     - T12 - Criar propriedade UiDmxScroller; ✅
     - T12 - Criar propriedade pDmxFieldRec; ✅
     - T12 - Criar evento DoOnEnter ✅
     - T12 - Selecionar o campo pDmxFieldRec^.LinkExecAction ;✅

   }


{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs, Buttons,ActnList
  ,mi_rtl_ui_DmxScroller_Form
  ,umi_ui_dmxscroller_form_lcl_attributes   ;

type
  { TMi_BitBtn_LCL }
  {: A classe ** @name ** é necessária para que se possa selecionar o controle associado
     ao botão criado pelo método: pDmxFieldRec^.createExecAction na construção da classe **TDmxScroller_Form_Lcl**.
  }
  TMi_BitBtn_LCL = class(TBitBtn)

    {$REGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}
      private var _DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes;
      private Procedure SetDmxScroller_Form_Lcl_attributes (aDmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property DmxScroller_Form_Lcl_attributes : TDmxScroller_Form_Lcl_attributes Read _DmxScroller_Form_Lcl_attributes  write SetDmxScroller_Form_Lcl_attributes;
    {$endREGION ' # Propriedade DmxScroller_Form_Lcl_attributes '}

    protected procedure DoOnEnter(Sender: TObject);

    {$REGION ' ---> Property pDmxFieldRec : pDmxFieldRec '}
      Private Var _pDmxFieldRec : pDmxFieldRec;

      Private Procedure SeTDmxFieldRec (apDmxFieldRec : pDmxFieldRec );


      {: A propriedade **@name** fornece os dados necessários para criar o componente TMI_BitBtn_LCL .

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
//  {$I umi_ui_bitbtn_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl.form',[TMi_BitBtn_LCL]);
//end;

{ TMi_BitBtn_LCL }

procedure TMi_BitBtn_LCL.DoOnEnter(Sender: TObject);
begin
  DmxFieldRec.DoOnEnter(Self);
//  writeLn('TMi_BitBtn_LCL.DoOnEnter: '+DmxFieldRec^.FieldName);
  if DmxFieldRec^.LinkExecAction<>nil
  Then DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec^.LinkExecAction;
end;

procedure TMi_BitBtn_LCL.SetDmxScroller_Form_Lcl_attributes(aDmxScroller_Form_Lcl_attributes: TDmxScroller_Form_Lcl_attributes);
begin
  _DmxScroller_Form_Lcl_attributes := aDmxScroller_Form_Lcl_attributes;
  IF (_DmxScroller_Form_Lcl_attributes<>nil) and (_DmxScroller_Form_Lcl_attributes.CurrentField<>nil)
  then SeTDmxFieldRec(_DmxScroller_Form_Lcl_attributes.CurrentField);
end;


procedure TMi_BitBtn_LCL.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
  var
    ContainedAction  : TContainedAction;
    S : AnsiString;
    sh : String;
begin
  if _pDmxFieldRec=apDmxFieldRec then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (DmxScroller_Form_Lcl_attributes<>nil) and (DmxFieldRec<>nil)
  then
   Try
      DmxScroller_Form_Lcl_attributes.CurrentField := DmxFieldRec;

      name := DmxScroller_Form_Lcl_attributes.GetNameValid(DmxScroller_Form_Lcl_attributes.CurrentField.FieldName);

      if DmxFieldRec^.HelpCtx_Hint<>''
      then hint := DmxFieldRec^.HelpCtx_Hint;

      with DmxScroller_Form_Lcl_attributes do
      begin
        if ((DmxFieldRec^.access and  accHidden)<>0)
        then begin
               Visible := false;
             end;
      end;

      OnEnter := DoOnEnter;


      {$REGION '---> Seta tipo de acesso'}
       with DmxScroller_Form_Lcl_attributes do
       begin
         Self.Visible  := true;
         Self.TabStop  := True;
         Self.Enabled  := True;
//         self.ReadOnly := false;

         if ((DmxFieldRec^.access and accSkip)<>0)
         then begin
                self.TabStop := false;
              end;

         if ((DmxFieldRec^.access and accReadOnly)<>0)
         then begin
           //     self.ReadOnly := true;
              end;

         if ((DmxFieldRec^.access and  accHidden)<>0)
         then Visible := false;

       end;
     {$ENDREGION}

//          Self.Alignment := taCenter;
//          Self.Alignment := taRightJustify;
//        Self.Alignment := taLeftJustify;

      with DmxScroller_Form_Lcl_attributes do
      begin
        if (DmxFieldRec^.access and  accHidden)<>0
        then Visible:= false;
      //          AutoSize:= true;
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

      width  := (Owner as TScrollingWinControl).Canvas.TextWidth(s)+DmxScroller_Form_Lcl_attributes.WidthChar;
      Height := (Owner as TScrollingWinControl).Canvas.TextHeight(s)+(DmxScroller_Form_Lcl_attributes.HeightChar div 2);
      //if s = CharLupa
      //Then Begin
      //       Font.PixelsPerInch := 72;
      //       font.Height:= 10;
      //     end;
      Caption := s;

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
      //                      AutoSize   := true;
                  end;
           end;



    Finally

//          pDmxFieldRec^.Link_IInputText := Self;

    end;
end;

end.
