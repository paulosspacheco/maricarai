unit umi_ui_InputBox_lcl;
{:< A unit **@name** implementa o formulário TMI_UI_InputBox usado para criar
    formulários baseado em Template PSITem.

    - **VERSÃO**
      - Alpha - 0.9.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/umi_ui_inputbox_lcl.pas">uMi_ui_InputBox_lcl.pas</a>)

    - **DEPENDÊNCIAS**
      - Criar uma função que receba um TForm e retorne um retangulo menor que a tela
        e maior que todos os componentes do mesmo.
        - Motivo: Lazarus apartir da versão 2.2.2 o método autosize deixa
          os scrollbar visiveis sem necessidade.

      - Criar a funcão InputBox sem eventos e fonte padronizada.
        ```pascal
          function InputBox ( aTitle   : AnsiString;
                              aTemplate: AnsiString;
                              //Permite processamento antes de sair do formulário.
                              aOnCloseQueryLocal:TOnCloseQueryLocal;

                              //: Se o botão MrOk for pressionado aForm retorna um formulário tipo TMI_UI_InputBox
                              out aMi_ui_InputBox : TMI_UI_InputBox

                            ): TModalResult;

        ```

      - A propriedade autoSize está errada porque está omitindo campo sem necessidade.


    - **CONCLUÍDO**
      - T12 A propriedade autosize deve ser true após o form for criado.  ✅️
      - T12 A classe Mi_ScrollBox_LCL1 deve ser criada em tempo de execução para que não
        tenha problema na instalação. ✅️
      - T12 A a classe DmxScroller_Form_Lcl1 deve ser criada em tempo de execução para que não
        tenha problema na instalação. ✅️
      - T12 A classe ButtonPanel1 deve ser criada em tempo de execução para que não
        tenha problema na instalação.  ✅️


  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
    - **2022-05-17**
      - T12 Análise de como será a classe TMI_UI_InputBox. ✅️
      - T12 Criar a unit **@name**.  ✅️
      - T12 Criar formulário TMI_UI_InputBox; ✅️
      - T12 Adicionar o componente ButtonPanel1 e habilitar os botões ok e cancel;  ✅️
      - T12 Adicionar o componente Mi_ScrollBox_LCL1 ;  ✅️
      - T12 Criar evento: function DmxScroller_Form_Lcl1GetTemplate; ✅️
      - T12 Criar atributo protected _FormSItem : PSitem;  ✅️
      - T12 Criar propriedade Template:AnsiString;  ✅️
        - Criar método Set_Template(aTemplate:AnsiString);  ✅️

    - **2022-05-18**
      - **10:51**
        - As alterações que fiz ontem no método TObjectsMethods.StringToSItem() criou efeito
          colateral.
          - Corrigido.  ✅️

      - **14:28**
        - Criar função:
          - function InputBox(): TModalResult;

    - **2022-05-19**
      - **11:13**
        - Criar os eventos
          - OnEnterLocal  ✅️
          - OnExistLocal  ✅️
          - onEnterFieldLocal  ✅️
          - OnExitFieldLocal  ✅️

        - Criar função:
          - function MI_MsgBox1MessageBox_04_PSItem(aPSItem: TMI_MsgBoxTypes.PSItem;
                                                    DlgType: TMsgDlgType;
                                                    Buttons: TMsgDlgButtons;
                                                    ButtonDefault: TMsgDlgBtn
                                                   ): TModalResult;


    - **2022-06-27**
      - **09:30**
        - T12 A classe Mi_ScrollBox_LCL1 deve ser criada em tempo de execução para quenão
        tenha problema na instalação. ✅️.

      - **10:25**
        - T12 A a classe DmxScroller_Form_Lcl1 deve ser criada em tempo de execução para que não
        tenha problema na instalação. ✅️

      - **10:41**
        - T12 A a classe ButtonPanel1 deve ser criada em tempo de execução para que não
        tenha problema na instalação.

    - **2022-06-28**
      - **15:52**
        - Criar unit **umi_ui_inputbox_lcl_test** para desmostrar o uso de InputBox.

    - **2022-06-30**
      - **22:00**
        - T12 A propriedade autosize deve ser true após o form for criado. ✅️
      - **22:21**
        - T12 A propriedade autoSize está errada porque está omitindo campo sem necessidade.
          - Não entendi o porque. Vou perguntar no grupo lazarus Br. (Disem que não funciona mesmo)

    - **2022-07-01**
      - **11:000**
        - Testar a chamada aos eventos OnCloseQueryLocal pq está gerando exeção. ✅️

      - **11:48**
        - Criar uma função que receba um TForm e retorne um retangulo menor que a tela
          e maior que todos os componentes do mesmo.
          - Motivo: Lazarus apartir da versão 2.2.2 o método autosize deixa
            os scrollbar sem necessidade.
}



{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ButtonPanel

  , mi.rtl.Consts
  , uMi_ui_Dmxscroller_form_lcl
  , mi_rtl_ui_Dmxscroller,
  uMi_ui_scrollbox_lcl;

{$I inc/mi.rtl.consts.inc}
type
  TUiDmxScroller = mi_rtl_ui_Dmxscroller.TUiDmxScroller;
  pDmxFieldRec   = mi_rtl_ui_Dmxscroller.pDmxFieldRec;
  TDmxScroller_Form_Lcl  = uMi_ui_Dmxscroller_form_lcl.TDmxScroller_Form_Lcl;

  {: O tipo **@name** é usado para implementar evento onEnterLocal do atributo **Mi_ScrollBox_LCL1** }
  TOnEnterLocal = Procedure(aDmxScroller:TUiDmxScroller);

  {: O tipo **@name** é usado para implementar evento onExitLocal do atributo **Mi_ScrollBox_LCL1** }
  TOnExitLocal  = Procedure(aDmxScroller:TUiDmxScroller);

  {: O tipo **@name** é usado para implementar evento OnEnterFieldLocal do atributo **Mi_ScrollBox_LCL1** }
  TOnEnterFieldLocal = Procedure(aField:pDmxFieldRec);

  {: O tipo **@name** é usado para implementar evento OnExitFieldLocal do atributo **Mi_ScrollBox_LCL1** }
  TOnExitFieldLocal = Procedure(aField:pDmxFieldRec);

  {: O tipo **@name** é usado para implementar evento OnCloseQueryLocal do atributo **Mi_ScrollBox_LCL1**.

     - **NOTA*
       - Este evento é disparado antes de desativar a classe **TUiDmxScroller**.
         - Obs: Se o parâmetro **CanClose** for **false**, então a classe **TUiDmxScroller** não é desativado.
  }
  TOnCloseQueryLocal = Procedure(aDmxScroller:TUiDmxScroller; var CanClose:boolean);


  { TMI_UI_InputBox }
  {: A class **@name** edita uma formulário passado em forma de Template e devolve
     o formulário LCL caso o botão **OK** seja pressionando ou nil caso o botão **Cancelar**
     seja pressionando.

     - **EXEMPLO**
       - O exemplo abaixo cria um formulário e permite interagir com com os eventos ao entrar e ao sair do formulário.

       ```pascal

          procedure InputBoxOnEnter(aDmxScroller: TUiDmxScroller);
           //Ao entrar no formulário este evento inicia os campos nome, endereço e cep

            procedure SetValue(Field:String;Value:String);
              var
                aField: pDmxFieldRec;
            begin
              with aDmxScroller do
              begin
                aField := FieldByName(Field);
                if aField<>nil
                Then aField.AsString:= value;
              end;
            end;

          begin
            with aDmxScroller do
            begin
              setValue('nome','Paulo Henrique');
              setValue('endereço','Rua Francisco de Souza Oliveira, 15');
              setValue('cep','60310770');
            end;
          end;

          procedure InputBoxOnEnterField(aField: pDmxFieldRec);
              // Ao entrar no campo 01 e o mesmo for vazio inicializa-o com o nome Paulo Sérgio

          begin
            Case aField.Fieldnum of
              1 : begin
                    if aField.AsString = ''
                    then aField.AsString := 'Paulo Sérgio';
                  end;
              2 : begin end;
            end;

          end;


          Procedure InputBoxOnCloseQuery (aDmxScroller:TUiDmxScroller; var CanClose:boolean);
            //Esta função permite validar o formulário ao pressionar o botão ok.

            var
              idade : byte;
              s : string;
          begin
            s := aDmxScroller.FieldByName('idade').AsString;
            idade := StrToInt(s);
            if  idade <> 64
            then begin
                   ShowMessage('O campo idade <> de 64!.');
                   CanClose := false;
                 end
            else CanClose := true;
          end;


          Procedure TestInputBox;
              //Criar o formulário

            Var
              MI_UI_InputBox : TMI_UI_InputBox = nil;
          begin
            with TDmxScroller_Form do
            if InputBox('Dados do aluno',
                           '~Nome do Aluno:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Nome'+lf+
                           '~     Endereço:~\Sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'endereco'+lf+
                           '~          Cep:~\##-###-###'+ChFN+'cep'+lf+
                           '~       Bairro:~\sssssssssssssssssssssssss'+ChFN+'bairro'+lf+
                           '~       Cidade:~\sssssssssssssssssssssssss'+ChFN+'cidade'+lf+
                           '~       Estado:~\SS'+ChFN+'estado'+lf+
                           '~        Idade:~\BB'+ChFN+'idade'+lf+
                           '~    Matricula:~\III'+ChFN+'matricula'+lf+
                           '~  Mensalidade:~\R,RRR.RR'+ChFN+'mensalidade',
                           InputBoxOnEnter,nil,

                           InputBoxOnEnterField,nil,
                           InputBoxOnCloseQuery,
                           MI_UI_InputBox
                      ) = MrOk
            then with MI_UI_InputBox.DmxScroller_Form_Lcl1 do
                 begin
                   if FieldByName('nome').AsString = ''
                   then begin
                          ShowMessage('Campo "nome" não pode ser vazio');
                        end;
                   MI_UI_InputBox.free;
                 end;
          end;

          procedure TDmxscroller_form_test.Button_InputBoxClick(Sender: TObject);
          begin
            TestInputBox;
          end;

       ```
  }
  TMI_UI_InputBox = class(TForm)
    public constructor Create(TheOwner: TComponent); override;
    protected procedure DmxScroller_Form_Lcl1CloseQuery(aDmxScroller: TUiDmxScroller;var CanClose: boolean);
    protected procedure DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    protected procedure DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
    protected procedure DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller);
    protected procedure DmxScroller_Form_Lcl1ExitField(aField: pDmxFieldRec);
    protected function DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;
    protected procedure DmxScroller_Form_Lcl1NewRecord(aDmxScroller: TUiDmxScroller);
    protected procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    protected procedure OKButtonClick(Sender: TObject);

    public Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    public DmxScroller_Form_lcl1: TDmxScroller_Form_lcl;
    public ButtonPanel1: TButtonPanel;
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
//     public var _Args: array of Variant;

     private _OnEnterLocal : TOnEnterLocal;
     private _OnExitLocal  : TOnExitLocal;
     private _OnEnterFieldLocal : TOnEnterFieldLocal;
     private _OnExitFieldLocal : TOnExitFieldLocal;
     private _OnCloseQueryLocal : TOnCloseQueryLocal;
     Private _CanClose: boolean ;

     private function GetMaxRectSizePossibile: TRect;

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
                     aArgs: array of const;

                     {:  o botão MrOk for pressionado aForm retorna um formulário tipo TMI_UI_InputBox }
                     out aMi_ui_InputBox : TMI_UI_InputBox
                     ): TModalResult; overload;



implementation
{$R *.lfm}

//var
//  MI_UI_InputBox: TMI_UI_InputBox;
//===============================================================
{$REGION TMi_ui_InputBox}

  { TMI_UI_InputBox }


  constructor TMI_UI_InputBox.Create(TheOwner: TComponent);
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
      OnNewRecord   := DmxScroller_Form_Lcl1NewRecord;
      onCloseQuery  := DmxScroller_Form_Lcl1CloseQuery;
      onEnter       := DmxScroller_Form_Lcl1Enter;
      onExit        := DmxScroller_Form_Lcl1Exit;
      onEnterField  := DmxScroller_Form_Lcl1EnterField;
      onExitField   := DmxScroller_Form_Lcl1ExitField;
      onGetTemplate := DmxScroller_Form_Lcl1GetTemplate;
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
      Left   := 6;
      Height := 38;
      Top    := 106;
      Width  := 329;
      OKButton.Name := 'OKButton';
      OKButton.DefaultCaption := True;
      HelpButton.Name := 'HelpButton';
      HelpButton.DefaultCaption := True;
      CloseButton.Name := 'CloseButton';
      CloseButton.Caption := '&Print';
  //      CloseButton.OnClick := CloseButtonClick;
      CancelButton.Name := 'CancelButton';
      CancelButton.DefaultCaption := True;
      OnCloseQuery := FormCloseQuery;
      TabOrder := 1;
    end;
    _CanClose := true;
  end;

  function TMI_UI_InputBox.DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;
  begin
    with DmxScroller_Form_lcl1 do
    begin
      if _Template  <> ''
      then Result := StringToSItem(_Template, 80)
  //    Result := StringToSItem(_Template, 40,TObjectsTypes.TAlinhamento.Alinhamento_Esquerda)
  //    Result := StringToSItem(_Template, 40,TObjectsTypes.TAlinhamento.Alinhamento_Central)
  //    Result := StringToSItem(_Template, 40,TObjectsTypes.TAlinhamento.Alinhamento_Direita)
  //    then Result := StringToSItem(_Template, 80,TObjectsTypes.TAlinhamento.Alinhamento_Justificado)
      else result := nil;
    end;
  end;

  procedure TMI_UI_InputBox.DmxScroller_Form_Lcl1NewRecord(  aDmxScroller: TUiDmxScroller);
  begin

  end;

  procedure TMI_UI_InputBox.DmxScroller_Form_Lcl1CloseQuery(aDmxScroller: TUiDmxScroller; var CanClose: boolean);
  begin
    if Assigned(_OnCloseQueryLocal)
    then begin
           if (ModalResult = mrOk)
           then with Mi_ScrollBox_LCL1 do
                begin
                  _OnCloseQueryLocal(aDmxScroller,CanClose);
  //                  UiDmxScroller.DoOnCloseQuery(canClose);
                End
           else canClose := true;
         end;
    _CanClose := CanClose;
  end;

  procedure TMI_UI_InputBox.FormCloseQuery(Sender: TObject;var CanClose: Boolean);
  begin
    DmxScroller_Form_Lcl1CloseQuery(DmxScroller_Form_Lcl1,CanClose);
  end;

  procedure TMI_UI_InputBox.DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
  begin
    if Assigned(_OnEnterLocal)
    then _OnEnterLocal(aDmxScroller);
  end;

  procedure TMI_UI_InputBox.DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
  begin
    if Assigned(_OnEnterFieldLocal)
    then _OnEnterFieldLocal(aField);
  end;

  procedure TMI_UI_InputBox.DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller    );
  begin
    if Assigned(_OnExitLocal)
    then _OnExitLocal(aDmxScroller);
  end;

  procedure TMI_UI_InputBox.DmxScroller_Form_Lcl1ExitField(aField: pDmxFieldRec);
  begin
    if Assigned(_OnExitFieldLocal)
    then _OnExitFieldLocal(aField);
  end;

  procedure TMI_UI_InputBox.OKButtonClick(Sender: TObject);
  begin

  end;

  procedure TMI_UI_InputBox.Set_Template(aTemplate: AnsiString);
  begin
    _Template := aTemplate;
  end;

  procedure TMI_UI_InputBox.SetAlias(aTitle: AnsiString);
  begin
    if DmxScroller_Form_Lcl1 <> nil
    then begin
           DmxScroller_Form_Lcl1.Alias := aTitle;
           Caption := DmxScroller_Form_Lcl1.Alias;
         end;
  end;


  procedure TMI_UI_InputBox.SetArgs(aArgs: array of const);
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



  function TMI_UI_InputBox.GetMaxRectSizePossibile: TRect;

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
        i,j: Integer;
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

    writeLn(Format('(ALeft: %d, ATop: %d, ARight: %d, ABottom: %d',
            [Result.Left,
             Result.Top,
             Result.Right,
             Result.Bottom
            ]));

   SetBounds(Result.Left,Result.Top,Result.Right-15,Result.Bottom+15)
  end;


  procedure InputBoxOnEnter(aDmxScroller: TUiDmxScroller);
    Var
      i : Integer;
    var
      aField: pDmxFieldRec;
      s : string;
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
                  aArgs: array of const;
                  out aMi_ui_InputBox: TMI_UI_InputBox): TModalResult;

begin
  Application.CreateForm(TMI_UI_InputBox, aMi_ui_InputBox);
     with aMi_ui_InputBox do
     begin
//       aMi_ui_InputBox.Align:= alClient;
       //Font.Height := 17;
       if aFont<>''
       Then begin
              Font.Name := aFont;
              ParentFont := False;
            end;
       {$Region Setar eventos}
          _OnCloseQueryLocal  := aOnCloseQueryLocal;

          if @aOnEnterLocal = nil
          then _OnEnterLocal  := InputBoxOnEnter
          else _OnEnterLocal  := aOnEnterLocal;

         _OnExitLocal        := aOnExitLocal;
         _OnEnterFieldLocal  := aOnEnterFieldLocal;
         _OnExitFieldLocal   := aOnExitFieldLocal;

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
       aMi_ui_InputBox.SetArgs(aArgs);
       repeat
          GetMaxRectSizePossibile;
          Result := ShowModal;
       until (result in [MrCancel,MrOk]) and _CanClose;

       if Result = MrCancel
       then Freeandnil(aMi_ui_InputBox);
     end;
end;





{$ENDREGION TMi_ui_InputBox}
//===============================================================

//===============================================================
{$REGION InputBox e MI_MsgBox1MessageBox_04_PSItem}

{$ENDREGION InputBox e MI_MsgBox1MessageBox_04_PSItem}
//===============================================================

end.
//Template := '~Nome do Aluno:~\sssssssssssssssssssssssss'+lf+
//            '~     Endereco:~\sssssssssssssssssssssssss`ssssssssssssssss'+lf+
//            '~          Cep:~\##-###-###'+lf+
//            '~       Bairro:~\sssssssssssssssssssssssss'+lf+
//            '~       Cidade:~\sssssssssssssssssssssssss'+lf+
//            '~       Estado:~\sssssssssssssssssssssssss'+lf+
//
//
//           '~ Linha 01 do teste do formulário~'+lf+
//           '~ Linha 02 do teste do Formulário~'+lf+
//           '~ Linha 03 do teste do Formulário~'+lf+
//           '~ Linha 04 do teste do Formulário~'+lf+
//           '~ Linha 05 do teste do Formulário~'+lf+
//           '~ Linha 06 do teste do Formulário~'+lf+
//           '~ Linha 07 do teste do Formulário~'+lf+
//           '~ Linha 08 do teste do Formulário~'+lf+
//           '~ Linha 09 do teste do Formulário~'+lf+
//           '~ Linha 10 do teste do Formulário~'+lf+
//           '~ Linha 11 do teste do Formulário~'+lf+
//           '~ Linha 12 do teste do Formulário~'+lf+
//           '~ Linha 13 do teste do Formulário~'+lf+
//           '~ Linha 14 do teste do Formulário~'+lf+
//           '~ Linha 15 do teste do Formulário~'+lf+
//           '~ Linha 16 do teste do Formulário~'+lf+
//           '~ Linha 17 do teste do Formulário~'+lf+
//           '~ Linha 18 do teste do Formulário~'+lf+
//           '~ Linha 19 do teste do Formulário~'+lf+
//           '~ Linha 20 do teste do Formulário~'+lf+
//           '~ Linha 21 do teste do Formulário~'+lf+
//           '~ Linha 22 do teste do Formulário~'+lf+
//           '~ Linha 23 do teste do Formulário~'+lf+
//           '~ Linha 24 do teste do Formulário~'+lf+
//           '~ Linha 25 do teste do Formulário~'+lf+
//           '~ Linha 26 do teste do Formulário~'+lf+
//           '~ Linha 27 do teste do Formulário~'+lf+
//           '~ Linha 28 do teste do Formulário~'+lf+
//           '~ Linha 29 do teste do Formulário~'+lf+
//           '~ Linha 30 do teste do Formulário~'+lf+
//           '~ Linha 31 do teste do Formulário~'+lf+
//           '~ Linha 32 do teste do Formulário~'+lf+
//           '~ Linha 33 do teste do Formulário~'+lf+
//           '~ Linha 34 do teste do Formulário~'+lf+
//           '~ Linha 35 do teste do Formulário~'+lf+
//           '~ Linha 36 do teste do Formulário~'+lf+
//           '~ Linha 37 do teste do Formulário~'+lf+
//           '~ Linha 38 do teste do Formulário~'+lf+
//           '~ Linha 39 do teste do Formulário~'+lf+
//           '~ Linha 40 do teste do Formulário~';

//  DmxScroller_Form_Lcl1.Active:= true;

