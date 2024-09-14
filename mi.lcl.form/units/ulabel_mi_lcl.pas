unit uLabel_mi_lcl;
{: A unit **@name** implementa a class TMi_Label_lcl com objetivo de ligar
   os campo tipo TDmxFieldRec.fldEnum=0 com o componente TLabel do Lazarus.

   - **VERSÂO**
     - Alpha - 0.9.0

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
//  ,umi_lcl_ui_dmxscroller_form_attributes
  ,uMi_lcl_ui_Form_attributes

  ;

type

  { TMi_ui_Label_lcl }

  { TLabel_mi_lcl }

  TLabel_mi_lcl = class(TLabel)
    Public constructor Create(AOwner:TComponent);override;overload;
    public constructor Create(aOwner:TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);overload;
    public Destructor Destroy;Override;
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
      private var _Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes;

      {: O método **@name** Inicia _Mi_lcl_ui_Form_attributes e executa o método SeTDmxFieldRec}
      private Procedure SetMi_lcl_ui_Form_attributes (aMi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes);

      {: A propriedade **@name** contém o modelo e os cálculos do formulário}
      published property Mi_lcl_ui_Form_attributes : TMi_lcl_ui_Form_attributes Read _Mi_lcl_ui_Form_attributes  write SetMi_lcl_ui_Form_attributes;
    {$endREGION ' # Propriedade Mi_lcl_ui_Form_attributes '}


  end;

//procedure Register;

implementation

//procedure Register;
//begin
//  {$I uLabel_mi_lcl_icon.lrs}
//  RegisterComponents('Mi.Ui.Lcl',[TMi_ui_Label_lcl]);
//end;

{ TMi_ui_Label_lcl }

constructor TLabel_mi_lcl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentFont:=true;
end;

constructor TLabel_mi_lcl.Create(aOwner: TComponent;aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  create(aOwner);
  Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
end;

destructor TLabel_mi_lcl.Destroy;
begin
  _pDmxFieldRec^.LinkEdit:= nil;
  _pDmxFieldRec := nil;
  inherited Destroy;
end;

procedure TLabel_mi_lcl.DoOnClick(Sender: TObject);
begin
  DmxFieldRec.DoOnEnter(Self);
  if DmxFieldRec^.LinkExecAction<>nil
  Then Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec^.LinkExecAction;
end;


procedure TLabel_mi_lcl.SeTDmxFieldRec(apDmxFieldRec: pDmxFieldRec);
var
  ContainedAction  : TContainedAction;
  S : AnsiString;
  sh : String;

  W1,W2 :Integer;

begin
  if _pDmxFieldRec=apDmxFieldRec
  then Exit;

  _pDmxFieldRec := apDmxFieldRec;
  if (Mi_lcl_ui_Form_attributes<>nil) and (DmxFieldRec<>nil) then
  Begin
    Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField := DmxFieldRec;

    if DmxFieldRec^.HelpCtx_Hint<>''
    then hint := DmxFieldRec^.HelpCtx_Hint;

    with Mi_lcl_ui_Form_attributes do
    begin
      if ((DmxFieldRec^.access and  accHidden)<>0)
      then begin
             Visible := false;
           end;
    end;

    OnClick := DoOnClick;

    {$REGION '---> Seta tipo de acesso'}
       with Mi_lcl_ui_Form_attributes do
       begin
           Self.Visible  := true;
//           Self.TabStop  := True;
           Self.Enabled  := True;
//           Self.ReadOnly := false;

         if ((DmxFieldRec^.access and accSkip)<>0)
         then begin
//                Self.TabStop  := false;
//               Self.ReadOnly := true;
              end;

         if ((DmxFieldRec^.access and accReadOnly)<>0)
         then begin
//                Self.ReadOnly := true;
              end;

         if ((DmxFieldRec^.access and  accHidden)<>0)
         then Visible := false;

       end;
    {$ENDREGION}

    with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
    begin
      if DmxFieldRec^.ExecAction<>''
      Then Action := Mi_lcl_ui_Form_attributes.getAction(self,DmxFieldRec^.ExecAction)
      else Action := nil;

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
     if Owner is TScrollingWinControl
     then with Mi_lcl_ui_Form_attributes,DmxScroller_Form do
          Begin
            AutoSize   := false; //Se não for definido Constraints quando autosize=false deixa maluco a altura.

            Height   := Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;
            Width  := ((DmxFieldRec^.ShownWid) * DmxScroller_Form.WidthChar);

            //Não posso usar a TextWidth porque as fontes de tamanho variável faz com que fique desalinhado
            //Width  := (Self.Owner as TScrollingWinControl).Canvas.TextWidth(DmxFieldRec^.Template_org);

            Constraints.MinWidth := width;
            Constraints.MaxWidth := Constraints.MinWidth;
            Constraints.MinHeight:= Mi_lcl_ui_Form_attributes.DmxScroller_Form.HeightChar;
            Constraints.MaxHeight:= Constraints.MinHeight;

          //  if s <> Mi_lcl_ui_Form_attributes.DmxScroller_Form.CharLupa_Left  Then
          //  begin
          //    Constraints.MinHeight:= Height;//Constraints.MaxHeight;
          //    Constraints.MaxHeight:= Constraints.MinHeight+4;
          //
          //    Constraints.MinWidth := width;
          //    Constraints.MaxWidth := Constraints.MinWidth+4;//Constraints.MinWidth;
          //  end
          //  else begin
          //         Constraints.MinHeight:= Height;//0;//Constraints.MaxHeight;
          //         Constraints.MaxHeight:= Constraints.MinHeight +4;//- 4;
          //
          //         Constraints.MinWidth := width; //+4;
          //         Constraints.MaxWidth := Constraints.MinWidth+4; //Constraints.MinWidth;
          //       end;
          end;
    end;
end;


procedure TLabel_mi_lcl.SetMi_lcl_ui_Form_attributes(aMi_lcl_ui_Form_attributes: TMi_lcl_ui_Form_attributes);
begin
  _Mi_lcl_ui_Form_attributes := aMi_lcl_ui_Form_attributes;
  IF (_Mi_lcl_ui_Form_attributes<>nil) and (_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField<>nil)
  then SeTDmxFieldRec(_Mi_lcl_ui_Form_attributes.DmxScroller_Form.CurrentField);
end;

end.
