unit MI_UI_InputBox_lcl_u;
{:< A unit **@name** implementa o formulário TMI_UI_InputBox_lcl usado para criar
    formulários baseado em Template PSITem.

    - **VERSÃO**
      - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi_ui_inputBox_lcl_u.pas">MI_UI_InputBox_lcl_u.pas</a>)

    - **DEPENDÊNCIAS**
      - Criar uma função que receba um TForm e retorne um retangulo menor que a tela
        e maior que todos os componentes do mesmo.
        - Motivo: Lazarus apartir da versão 2.2.2 o método autosize deixa
          os scrollbar visiveis sem necessidade.

      - Criar a funcão InputBox sem eventos e fonte padronizada.
        ```pascal

           function InputBox (aTitle   : AnsiString;
                              aTemplate: AnsiString;
                              aOnCloseQueryLocal:TOnCloseQueryLocal;
                              aFont    : AnsiString;
                              aOnEnterLocal:TOnEnterLocal ;
                              aOnExitLocal:TOnExitLocal;
                              aOnEnterFieldLocal:TOnEnterFieldLocal;
                              aOnExitFieldLocal:TOnExitFieldLocal;
                              aArgs: array of const;

                              // Se o botão MrOk for pressionado aForm retorna um formulário tipo TMI_UI_InputBox
                              out aMi_ui_InputBox : TMI_UI_InputBox
                              ): TModalResult; overload;
}

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, ButtonPanel, ActnList, Dialogs
  , fpjson
  , mi.rtl.ui.dmxscroller.inputbox
  , mi.Rtl.Objectss
  , mi_rtl_ui_dmxscroller_form
  , mi_rtl_ui_Dmxscroller
  , mi.rtl.all
  , uMi_ui_scrollbox_lcl
  , uMi_ui_Dmxscroller_form_lcl, umi_ui_dmxscroller_form_lcl_ds;

type

  { TMI_UI_InputBox_lcl }

  TMI_UI_InputBox_lcl = class(TForm)
    Action_HelpButton: TAction;
    Action_CloseButton: TAction;
    Action_CancelButton: TAction;
    Action_OkButton: TAction;
    ActionList1: TActionList;
    ButtonPanel1: TButtonPanel;
    DmxScroller_Form_Lcl1: TDmxScroller_Form_Lcl;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    MI_UI_InputBox1: TMI_UI_InputBox;


    procedure DmxScroller_Form_Lcl1AddTemplate(      const aUiDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1CloseQuery(aDmxScroller: TUiDmxScroller;      var CanClose: boolean);
    procedure DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
    procedure DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1ExitField(aField: pDmxFieldRec);

    procedure DmxScroller_Form_Lcl1NewRecord(aDmxScroller: TUiDmxScroller);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    procedure MI_UI_InputBox1EnterLocal(aDmxScroller: TUiDmxScroller);

    function MI_UI_InputBox1InputBox(aTitle: AnsiString;
                                     aTemplate: AnsiString;
                                     aOnCloseQueryLocal: TOnCloseQueryLocal;
                                     aFont: AnsiString;
                                     aOnEnterLocal: TOnEnterLocal;
                                     aOnExitLocal: TOnExitLocal;
                                     aOnEnterFieldLocal: TOnEnterFieldLocal;
                                     aOnExitFieldLocal: TOnExitFieldLocal;
                                     aArgs: array of const;
                                     out aJSONObject: TJSONObject): TModalResult;

      private

      Private _CanClose: boolean ;
      private function GetMaxRectSizePossibile: TRect;
      public

        {$REGION Propriedade Template}
          private _Template:AnsiString;

          {: O Método **@name** inicia o atributo _Template e criar a lista _FormSItem : PSitem

             - **NOTAS**
               - Criar em TObjectss.TStringList o método
          }
          protected Procedure Set_Template(aTemplate:AnsiString);

          {: A propriedade **@name** é usada para criar uma lista de PSItem para ser usada como modelo do formulário.

             - **NOTAS**
               - Template é um string comum, onde cada linha é separada com ^J.
               - Template tem uma lista de string com formato Dmx.
                 - Formato da propriedade Template:

                   ```pascal

                       Template := '~Nome do Aluno:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Nome'+lf+
                                   '~     Endereço:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'endereco'+lf+
                                   '~          Cep:~\##-###-###'+ChFN+'cep'+lf+
                                   '~       Bairro:~\sssssssssssssssssssssssss'+ChFN+'bairro'+lf+
                                   '~       Cidade:~\sssssssssssssssssssssssss'+ChFN+'cidade'+lf+
                                   '~       Estado:~\SS'+ChFN+'estado'+lf+
                                   '~        Idade:~\BB'+ChFN+'idade'+FldUpperLimit+#18+lf+
                                   '~    Matricula:~\III'+ChFN+'matricula'+lf+
                                   '~     Valor da~'+lf+
                                   '~    Mensalidade:~\R,RRR.RR'+ChFN+'mensalidade';

                   ```

               - **SINTAXE**
                 - **~** (til) : Limitador de rótulos do formulário;
                 - **s** (s minúsculo) : caracteres alfanumérico incluindo os maiúsculas, minusculas, números e símbolos;
                 - **S** (S maiúsculo) : caracteres alfanumérico incluindo os maiúsculas, números e símbolos;
                 - **#** (# cancela) : Aceita somente números de 0 a 99
                 - **-** (literal ) : Separador de números
                 - **B** (B maiúsculo): Campo do tipo byte
                 - **FldUpperLimit** : O caractere seguinte indica o limite superior da variável. No exemplo acima é 18 anos;
                 - **R** : Indica um caractere de um campo do tipo double;
                 - **I** : Indica um caractere de um campo do tipo interger. Faixa: -32000 a +32000;
          }
          public property Template:AnsiString read _Template write Set_Template;
        {$ENDREGION Propriedade Template}

      public Procedure SetAlias(aTitle:AnsiString);
      public Procedure SetArgs(aArgs: array of const);

      public constructor Create(TheOwner: TComponent); override;

      class Procedure testInputBox;
  end;


  {: A função **@name** cria um formulário passado por Template e executa os
     eventos do formulário passado pelos parâmetros.

     - **PARÂMETROS**
       - atitle;        // Título do formulário;
       - aTemplate;     // Modelo do formulário cuja a sintaxe segue abaixo:
       - aOnEnter;      // Executado ao entrar no formulário criado baseado no Template;
       - aOnExit;       // Executado ao sair do formulário criado baseado no Template;
       - aOnEnterField; // Executado ao entrar um campo focado;
       - aOnExitField;  // Executado ao sair do campo focado;
       - aOnCloseQuery  // Executado ao fechar o form se CanClose = true;

     - **SINTAXE DO MODELO**
       - Exemplo
         ```pascal

             const
               Template := '~Nome do Aluno:~\sssssssssssssssssssssssss'+lf+
                           '~     Endereço:~\sssssssssssssssssssssssss`ssssssssssssssss'+lf+
                           '~          Cep:~\##-###-###'+lf+
                           '~       Bairro:~\sssssssssssssssssssssssss'+lf+
                           '~       Cidade:~\sssssssssssssssssssssssss'+lf+
                           '~       Estado:~\sssssssssssssssssssssssss'+lf+
                           '~        Idade:~\BB'+lf+
                           '~  Mensalidade:~\R,RRR.RR';
         ```

       - Tipos de dados do formulário:
         - s = Char alfanumérico
         - # = Char numérico
         - R = Double
         - B = Byte

     - Exemplo de chamada da função:

         ```pascal

            if InputBox('Dados do aluno',
                         '~Nome do Aluno:~\sssssssssssssssssssssssss'+lf+
                         '~     Endereço:~\sssssssssssssssssssssssss`ssssssssssssssss'+lf+
                         '~          Cep:~\##-###-###'+lf+
                         '~       Bairro:~\sssssssssssssssssssssssss'+lf+
                         '~       Cidade:~\sssssssssssssssssssssssss'+lf+
                         '~       Estado:~\sssssssssssssssssssssssss'+lf+
                         '~        Idade:~\BB'+lf+
                         '~    Mensalidade:~\R,RRR.RR',
                         nil,nil,nil,nil,nil
                    ) = MrOk
            then begin
                 end;

          ```
 }
 function InputBox ( aTitle   : AnsiString;
                     aTemplate: AnsiString;
                     aOnCloseQueryLocal:TOnCloseQueryLocal;
                     aFont    : AnsiString;
                     aOnEnterLocal:TOnEnterLocal ;
                     aOnExitLocal:TOnExitLocal;
                     aOnEnterFieldLocal:TOnEnterFieldLocal;
                     aOnExitFieldLocal:TOnExitFieldLocal;
                     aArgs_in: array of const;

                     {: Se o botão MrOk for pressionado aForm retorna um formulário tipo TMI_UI_InputBox }

                     out aArgs_out : TJSONObject

                     ): TModalResult; overload;



implementation

{$R *.lfm}


var
  MI_UI_InputBox_lcl: TMI_UI_InputBox_lcl;

{ TMI_UI_InputBox_lcl }


function TMI_UI_InputBox_lcl.GetMaxRectSizePossibile: TRect;

  function IIF(const Logica: Boolean; const E1,E2: Longint): Longint;
  Begin
     If Logica Then Result := E1 Else IIF := E2;
  End;

  class function MaxL(const a, b: Longint): Longint;
  Begin
    result := IIF(b > a , b , a );
  End;

  function HorzTopMax(ctrl: TWinControl):Integer;
  var
    i,c: Integer;
    xRect: TRect;
    Cont :TWinControl;
  begin
    Result:=0;
    c := ctrl.controlcount;
    for i := 0 to c - 1 do
      if ctrl.controls[i] is Twincontrol then
      begin
        Cont :=  (ctrl.controls[i] as Twincontrol);
        xRect := Cont.BoundsRect;
        Result := maxL(Result,xRect.Width);
      end;
  end;

  function VertTopMax(ctrl: TWinControl):Integer;
  var
    i: Integer;
    xRect: TRect;
  begin
    Result:=0;
    for i := 0 to ctrl.controlcount - 1 do
      if ctrl.controls[i] is Twincontrol then
      begin
        xRect := (ctrl.controls[i] as Twincontrol).BoundsRect;
        Result := maxL(Result,xRect.Bottom);
      end;
  end;

  function GetMaxRectSizeControl(ctrl: TWinControl;var aRect: TRect): TRect;
    var
      i: Integer;
    begin
      if ctrl=nil
      then ctrl :=  self;

      for i := 0 to ctrl.controlcount - 1 do
      begin
        if ctrl.controls[i] is Twincontrol then
        begin
          Result := (ctrl.controls[i] as Twincontrol).BoundsRect;
          Result.Right := maxL(Result.Right,aRect.Right);
          Result.Bottom := maxL(Result.Bottom,aRect.Bottom);


          if ctrl.controls[i] is TWinControl
          then begin
                 if (ctrl.controls[i] as TWinControl).ControlCount > 0
                 then aRect := GetMaxRectSizeControl((ctrl.controls[i] as TWinControl),Result);
               end;
        end;
      end
    end;

begin
  Result := TRect.Create(0,
                         0,
                         MaxL( HorzTopMax(self),self.Width),
                         VertTopMax(self)
                         );
  Result  := GetMaxRectSizeControl(self,Result);

  //writeLn(Format('(ALeft: %d, ATop: %d, ARight: %d, ABottom: %d',
  //        [Result.Left,
  //         Result.Top,
  //         Result.Right,
  //         Result.Bottom
  //        ]));

 SetBounds(Result.Left,Result.Top,Result.Right-15,Result.Bottom+15)
end;

procedure TMI_UI_InputBox_lcl.Set_Template(aTemplate: AnsiString);
begin
  _Template := aTemplate;
end;

procedure TMI_UI_InputBox_lcl.SetAlias(aTitle: AnsiString);
begin
  if DmxScroller_Form_Lcl1 <> nil
  then begin
         DmxScroller_Form_Lcl1.Alias := aTitle;
         Caption := DmxScroller_Form_Lcl1.Alias;
       end;
end;

procedure TMI_UI_InputBox_lcl.SetArgs(aArgs: array of const);
  var
    fld : PDmxFieldRec;
    i : integer;
begin
  If High(aArgs)<0 then  exit; ;
  For i:=0 to High(aArgs) do
  begin
    fld := DmxScroller_Form_lcl1.FieldByNumber(i+1);

    if fld <> nil
    then case aArgs[i].vtype of
            vtinteger    : fld^·Value := aArgs[i].vinteger;
            vtboolean    : fld^·Value := aArgs[i].vboolean;
            vtchar       : fld^·Value := aArgs[i].vchar;
            vtextended   : fld^·Value := aArgs[i].VExtended^;
            vtString     : fld^·Value := aArgs[i].VString^;

            {$ifdef CPU16}
              vtPointer    : fld^·Value := Longint(aArgs[i].VPointer);
            {$else}
              vtPointer    : fld^·Value := Int64(aArgs[i].VPointer);
            {$endif}

            vtPChar      : fld^·Value := aArgs[i].VPChar;
            vtObject     : fld^·Value := aArgs[i].VObject.Classname;
            vtClass      : fld^·Value := aArgs[i].VClass.Classname;
            vtAnsiString : fld^·Value := AnsiString(aArgs[I].VAnsiString);
            else           fld^·Value := '';
        end;
  end;

end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1Enter(  aDmxScroller: TUiDmxScroller);
begin
  if Assigned(MI_UI_InputBox1.OnEnterLocal)
  then MI_UI_InputBox1.OnEnterLocal(aDmxScroller);
end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1CloseQuery(  aDmxScroller: TUiDmxScroller; var CanClose: boolean);
begin
  if Assigned(MI_UI_InputBox1.OnCloseQueryLocal)
  then begin
         if (ModalResult = mrOk)
         then with Mi_ScrollBox_LCL1 do
              begin
                MI_UI_InputBox1.OnCloseQueryLocal(aDmxScroller,CanClose);
              End
         else canClose := true;
       end;
  _CanClose := CanClose;
end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1AddTemplate(  const aUiDmxScroller: TUiDmxScroller);
begin
  aUiDmxScroller .add(_Template);
end;

procedure TMI_UI_InputBox_lcl.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  DmxScroller_Form_Lcl1CloseQuery(DmxScroller_Form_Lcl1,CanClose);
end;

procedure TMI_UI_InputBox_lcl.MI_UI_InputBox1EnterLocal(  aDmxScroller: TUiDmxScroller);

    Var
      i : Integer;
    var
      aField: pDmxFieldRec;
//      s : string;

begin
  with aDmxScroller do
  begin
    For i:= 1 to aDmxScroller.Fields.Count-1 do
    begin
      aField := aDmxScroller.FieldByNumber(i);

      if  (aField <> nil) and  (aField.LinkEdit<>nil)
      and (aField.Fieldnum<>0) and (aField.LinkEdit is TControl)
      Then begin
             aField.AsString:= aField.AsString;
             (aField.LinkEdit as TControl).Show;
//               s:= aField^.FieldName;
           end;

    end;
  end;
end;


function TMI_UI_InputBox_lcl.MI_UI_InputBox1InputBox(
                                     aTitle: AnsiString;
                                     aTemplate: AnsiString;
                                     aOnCloseQueryLocal: TOnCloseQueryLocal;
                                     aFont: AnsiString;
                                     aOnEnterLocal: TOnEnterLocal;
                                     aOnExitLocal: TOnExitLocal;
                                     aOnEnterFieldLocal: TOnEnterFieldLocal;
                                     aOnExitFieldLocal: TOnExitFieldLocal;
                                     aArgs: array of const;
                                     out aJSONObject: TJSONObject): TModalResult;

begin
  with Mi_ScrollBox_LCL1 do
  begin
   if aFont<>''
   Then begin
          Font.Name := aFont;
          ParentFont := False;
        end;
   {$Region Setar eventos}
      MI_UI_InputBox1.OnCloseQueryLocal  := aOnCloseQueryLocal;
      if @aOnEnterLocal <> nil
      then MI_UI_InputBox1.OnEnterLocal  := aOnEnterLocal;
      MI_UI_InputBox1.OnExitLocal        := aOnExitLocal;
      MI_UI_InputBox1.OnEnterFieldLocal  := aOnEnterFieldLocal;
      MI_UI_InputBox1.OnExitFieldLocal   := aOnExitFieldLocal;

   {$EndRegion Setar eventos}

   SetAlias(aTitle);
   Template:= aTemplate;

   if Mi_ScrollBox_LCL1.UiDmxScroller= nil
   then Mi_ScrollBox_LCL1.UiDmxScroller := DmxScroller_Form_Lcl1
   else DmxScroller_Form_Lcl1.Active:= true;


   Mi_ScrollBox_LCL1.AutoScroll:= TRUE;
   Mi_ScrollBox_LCL1.AutoSize := true;
   SetArgs(aArgs);
   repeat
      GetMaxRectSizePossibile;
      Result := ShowModal;
   until (result in [MrCancel,MrOk]) and _CanClose;

   if Result = MrOk
   then aJSONObject := DmxScroller_Form_Lcl1.JSONObject;
  end;

end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1EnterField(  aField: pDmxFieldRec);
begin
  if Assigned(MI_UI_InputBox1.OnEnterFieldLocal)
  then MI_UI_InputBox1.OnEnterFieldLocal(aField);
end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1Exit(  aDmxScroller: TUiDmxScroller);
begin
  if Assigned(MI_UI_InputBox1.OnExitLocal)
  then MI_UI_InputBox1.OnExitLocal(aDmxScroller);
end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1ExitField(  aField: pDmxFieldRec);
begin
  if Assigned(MI_UI_InputBox1.OnExitFieldLocal)
  then MI_UI_InputBox1.OnExitFieldLocal(aField);
end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1NewRecord(  aDmxScroller: TUiDmxScroller);
begin

end;


constructor TMI_UI_InputBox_lcl.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);

  Mi_ScrollBox_LCL1 := TMi_ScrollBox_LCL.Create(self);
  InsertControl( Mi_ScrollBox_LCL1);
  with Mi_ScrollBox_LCL1 do
  begin

    Left := 0;
    Height := parent.Height-40;
    Top := 0;
    Width := parent.Width-15;
    Align := alTop;
    Anchors := [akTop, akLeft, akRight, akBottom];
    AutoScroll := FALSE;
    //Font.Height := 17;
    //Font.Name := 'Courier New';
    //ParentFont := False;
    ParentFont := true;
    TabOrder := 0;
    TabStop := True;
  end;

  DmxScroller_Form_lcl1 := TDmxScroller_Form_Lcl.Create(Mi_ScrollBox_LCL1);
  with DmxScroller_Form_lcl1 do
  begin
//      OnAddTemplate := DmxScroller_Form_Lcl1AddTemplate;

    Active        := False;
    AlignmentLabels := taLeftJustify;
    Left := 208;
    Top := 40;
    ParentLCL := Mi_ScrollBox_LCL1;
  end;

  ButtonPanel1 := TButtonPanel.Create(self);
  InsertControl(ButtonPanel1);
  with ButtonPanel1 do
  begin
//    Left   := 6;
//    Height := 38;
//    Top    := 106;
//    Width  := 329;
//    OKButton.Name := 'OKButton';
//    OKButton.DefaultCaption := True;
//    HelpButton.Name := 'HelpButton';
//    HelpButton.DefaultCaption := True;
//    CloseButton.Name := 'CloseButton';
//    CloseButton.Caption := '&Print';
////      CloseButton.OnClick := CloseButtonClick;
//    CancelButton.Name := 'CancelButton';
    CancelButton.DefaultCaption := True;
    OnCloseQuery := FormCloseQuery;
    TabOrder := 1;
  end;
  _CanClose := true;

end;


{: A função **@name** cria um formulário passado por Template e executa os
     eventos onEnter e onExit do formulário passados por aOnEnter: e aOnExit.}
function InputBox(aTitle: AnsiString;
                  aTemplate: AnsiString;
                  aOnCloseQueryLocal: TOnCloseQueryLocal;
                  aFont    : AnsiString;
                  aOnEnterLocal: TOnEnterLocal;
                  aOnExitLocal: TOnExitLocal;
                  aOnEnterFieldLocal: TOnEnterFieldLocal;
                  aOnExitFieldLocal: TOnExitFieldLocal;
                  aArgs_in: array of const;
                  //out aMi_ui_InputBox: TMI_UI_InputBox
                  out aArgs_out : TJSONObject

                  ): TModalResult;

  var
    aMI_UI_InputBox_lcl : TMI_UI_InputBox_lcl;

begin

  //aRecord := Rec;
  try
    Application.CreateForm(TMI_UI_InputBox_lcl, aMI_UI_InputBox_lcl);
     with aMI_UI_InputBox_lcl do
     begin
//       aMi_ui_InputBox.Align:= alClient;
       //Font.Height := 17;
       if aFont<>''
       Then begin
              Font.Name := aFont;
              ParentFont := False;
            end;
       {$Region Setar eventos}

          MI_UI_InputBox1.OnCloseQueryLocal  := aOnCloseQueryLocal;

          if @aOnEnterLocal = nil
          then MI_UI_InputBox1.OnEnterLocal  := MI_UI_InputBox1EnterLocal
          else MI_UI_InputBox1.OnEnterLocal  := aOnEnterLocal;

         MI_UI_InputBox1.OnExitLocal        := aOnExitLocal;
         MI_UI_InputBox1.OnEnterFieldLocal  := aOnEnterFieldLocal;
         MI_UI_InputBox1.OnExitFieldLocal   := aOnExitFieldLocal;

       {$EndRegion Setar eventos}

       SetAlias(aTitle);
       DmxScroller_Form_Lcl1.ParentLCL  := Mi_ScrollBox_LCL1;
       Template:= aTemplate;

       if Mi_ScrollBox_LCL1.UiDmxScroller= nil
       then Mi_ScrollBox_LCL1.UiDmxScroller := DmxScroller_Form_Lcl1
       else DmxScroller_Form_Lcl1.Active:= true;


       Mi_ScrollBox_LCL1.AutoScroll:= TRUE;
       Mi_ScrollBox_LCL1.AutoSize := true;
//       AutoSize:=true;

//       WriteDebug;
       aMI_UI_InputBox_lcl.SetArgs(aArgs_in);
       repeat
          GetMaxRectSizePossibile;
          Result := ShowModal;
       until (result in [MrCancel,MrOk]) and _CanClose;

       if Result = MrOk
       then begin
//              aArgs_out := GetArgs;
            end;
     end;

  finally
    Freeandnil(aMI_UI_InputBox_lcl);
  end;
end;

class Procedure TMI_UI_InputBox_lcl.testInputBox;
  var
    J: TJSONObject  ;
begin
  with TMi_rtl,MI_UI_InputBox do
    if InputBox('Teste input box','~Nome~:sssssss',nil,'',nil,nil,nil,nil,[],J) = mrok
    then ;
end;


{: Inicialização do projeto usado para criar o módudlo MI_UI_MsgBox}
initialization

  MI_UI_InputBox_lcl := TMI_UI_InputBox_lcl.create(nil);
  TMi_Rtl.Set_MI_UI_InputBox(MI_UI_InputBox_lcl.MI_UI_InputBox1);

finalization
 TMi_Rtl.Set_MI_UI_InputBox(nil);
 FreeAndNil(MI_UI_InputBox_lcl);

end.





