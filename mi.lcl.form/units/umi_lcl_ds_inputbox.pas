unit umi_lcl_ds_inputbox;
{:< A unit **@name** implementa o formulário TMi_lcl_inputbox usado para criar
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
  Classes, SysUtils, Forms, Controls, Graphics, ButtonPanel, ActnList, Dialogs,
  StdCtrls

  , fpjson
  , mi.rtl.ui.dmxscroller.inputbox
  , mi.Rtl.Objectss
  , mi_rtl_ui_Dmxscroller
  , mi.rtl.all, mi_rtl_ui_dmxscroller_form
  , uMi_lcl_scrollbox
  , uMi_lcl_ui_ds_form
  , mi.rtl.Objects.Consts.Mi_MsgBox;

type

  { TMi_lcl_inputbox }

  TMi_lcl_inputbox = class(TForm)
        CmOk: TAction;
        ActionList1: TActionList;
    Action_HelpButton: TAction;
    Action_CloseButton: TAction;
    Action_CancelButton: TAction;
    Action_OkButton: TAction;
    ButtonPanel1: TButtonPanel;
    CmCancel: TAction;
    CmDeleteRecord: TAction;
    CmGoBof: TAction;
    CmGoEof: TAction;
    CmLocate: TAction;
    CmNewRecord: TAction;
    CmNextRecord: TAction;
    CmPrevRecord: TAction;
    CmRefresh: TAction;
    CmUpdateRecord: TAction;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;

    MI_UI_InputBox1: TMI_UI_InputBox;
    
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    function Mi_lcl_ui_ds_Form1GetTemplate(aNext: PSItem): PSItem;
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
    procedure Mi_lcl_ui_ds_Form1Enter(aDmxScroller: TUiDmxScroller);
    procedure MI_UI_InputBox1Free_form_owner;

//    procedure MI_UI_InputBox1Free_form_owner;

    function MI_UI_InputBox1InputBox(aTitle: AnsiString;
                                     aTemplate: AnsiString;
                                     aOnCloseQuery: TOnCloseQuery;
                                     aFont: AnsiString;
                                     aOnEnter: TOnEnter;
                                     aOnExit: TOnExit;

                                     aOnEnterField:TOnEnterField;
                                     aOnExitField :TOnExitField;

                                     aIn_JSONObject: TJSONObject;
                                     out aOut_JSONObject: TJSONObject): TModalResult;


      private function SetBounds_local: TRect;
      private function IIF(const Logica: Boolean; const E1,E2: Longint): Longint;
      private function MaxL(const a, b: Longint): Longint;
      private function MinL(const a, b: Longint): Longint;

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
//      public Procedure SetArgs(aArgs: array of const);

      public procedure Create_Mi_lcl_ui_ds_Form1(aTemplate: AnsiString);
      public constructor Create(TheOwner: TComponent); override;
//      public Destructor Destroy; override;

      public Procedure testInputBox1;

      Private var _CanClose : boolean ;
      public var Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
      public var DmxScroller_Form1: TDmxScroller_Form;
  end;


  TMI_UI_InputBox_lcl_class = class of TMI_UI_InputBox;

//Procedure SetMI_UI_InputBox_lcl(aMI_UI_InputBox_lcl:TMi_lcl_inputbox);


implementation

{$R *.lfm}


//var
//  Mi_lcl_inputbox: TMi_lcl_inputbox;

//Procedure SetMI_UI_InputBox_lcl(aMI_UI_InputBox_lcl:TMi_lcl_inputbox);
//
//begin
//  if Assigned(Mi_lcl_inputbox)
//  then begin
//         TMi_Rtl.Set_MI_UI_InputBox(nil);
//         FreeAndNil(Mi_lcl_inputbox);
//       end;
//
//  if Mi_lcl_inputbox<>nil
//  Then TMi_Rtl.Set_MI_UI_InputBox(Mi_lcl_inputbox.MI_UI_InputBox1);
//end;

{ TMi_lcl_inputbox }


function TMi_lcl_inputbox.SetBounds_local: TRect;

  function HorzTopMax(ctrl: TWinControl):Integer;
    var
      i,c: Integer;
      xRect: TRect;
      Cont :TControl;
  begin
    Result:=0;
    c := ctrl.controlcount;
    for i := 0 to c - 1 do
      if ctrl.controls[i] is Tcontrol then
      begin
        Cont :=  (ctrl.controls[i] as Tcontrol);
        xRect := Cont.BoundsRect;
        Result := maxL(Result,xRect.BottomRight.X);
      end;
  end;

  function VertTopMax(ctrl: TWinControl):Integer;
    var
      i: Integer;
      xRect: TRect;
      n : string;

  begin
    Result:=0;

    for i := 0 to ctrl.controlcount - 1 do
    begin
      n := (ctrl.controls[i] as Tcontrol).name;
      xRect := (ctrl.controls[i] as Tcontrol).BoundsRect;
      Result := maxL(Result,xRect.BottomRight.y);
      Result := minL(Result, Screen.Height);
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
      if ctrl.controls[i] is Tcontrol then
      begin
        Result := (ctrl.controls[i] as Tcontrol).BoundsRect;
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

  var
    aVertTopMax: Integer;
begin //Inicio: SetBounds_local: TRect;
  AutoSize:=false;
  AutoScroll := false;
  Mi_LCL_Scrollbox1.AutoScroll:=false;
  Mi_LCL_Scrollbox1.AutoSize:=false;

  SetBounds(0,0,165,353);

  aVertTopMax := VertTopMax(Mi_LCL_Scrollbox1);
  Result := TRect.Create(0
                         ,0
                         ,HorzTopMax(Mi_LCL_Scrollbox1)
                         ,MinL(aVertTopMax,Screen.Height)
                         );

  Result  := GetMaxRectSizeControl(Mi_LCL_Scrollbox1,Result);

  SetBounds(Result.Left,
            Result.Top,
            Result.BottomRight.X+15,
            Result.BottomRight.Y+(15*6)
            );

  Mi_LCL_Scrollbox1.AutoScroll:=true;
  Mi_LCL_Scrollbox1.AutoSize:=true;
end;

procedure TMi_lcl_inputbox.Set_Template(aTemplate: AnsiString);
begin
  _Template := aTemplate;
end;

procedure TMi_lcl_inputbox.SetAlias(aTitle: AnsiString);
begin
  if Mi_lcl_ui_ds_Form1 <> nil
  then begin
         Mi_lcl_ui_ds_Form1.Alias := aTitle;
         Caption := Mi_lcl_ui_ds_Form1.Alias;
       end;
end;

procedure TMi_lcl_inputbox.Mi_lcl_ui_ds_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
end;

procedure TMi_lcl_inputbox.MI_UI_InputBox1Free_form_owner;
begin
  Mi_lcl_ui_ds_Form1.Active:=false;

end;

function TMi_lcl_inputbox.IIF(const Logica: Boolean; const E1,E2: Longint): Longint;
Begin
   If Logica Then Result := E1 Else IIF := E2;
End;

function TMi_lcl_inputbox.MaxL(const a, b: Longint): Longint;
Begin
  result := IIF(b > a , b , a );
End;

function TMi_lcl_inputbox.MinL(const a, b: Longint): Longint;
begin
  result := IIF(b < a , b , a );
end;

function TMi_lcl_inputbox.Mi_lcl_ui_ds_Form1GetTemplate(aNext: PSItem  ): PSItem;
begin
  with TMi_rtl do
  begin
    if _Template  <> ''
    then Result := StringToSItem(_Template)
    else Result := StringToSItem('~template não inicializado~');
  end;
end;

procedure TMi_lcl_inputbox.FormCreate(Sender: TObject);
begin
  DmxScroller_Form1.MessageBoxOff := true;
end;

procedure TMi_lcl_inputbox.FormClose(Sender: TObject;var CloseAction: TCloseAction);
begin
  CloseAction := CaFree;
end;

procedure TMi_lcl_inputbox.FormDestroy(Sender: TObject);
begin
  DmxScroller_Form1.MessageBoxOff := false;
end;

function TMi_lcl_inputbox.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  result := Mi_lcl_ui_ds_Form1GetTemplate(aNext);
end;

procedure TMi_lcl_inputbox.Create_Mi_lcl_ui_ds_Form1(aTemplate: AnsiString);
begin
  if Assigned(Mi_LCL_Scrollbox1)
  then begin
          AutoSize:=false;
          Height  := 165;
          Width   := 353 ;

          if Assigned(Mi_lcl_ui_ds_Form1)
          then Begin
                 FreeAndNil(Mi_lcl_ui_ds_Form1);
                 FreeAndNil(DmxScroller_Form1);
               end;

          Mi_lcl_ui_ds_Form1   := TMi_lcl_ui_ds_Form.Create  (Mi_LCL_Scrollbox1);
          DmxScroller_Form1 := TDmxScroller_Form.Create(Mi_LCL_Scrollbox1);
          DmxScroller_Form1.Mi_ActionList := ActionList1;
          Mi_lcl_ui_ds_Form1.DmxScroller_Form := DmxScroller_Form1;

          Mi_lcl_ui_ds_Form1.ParentLCL := Mi_LCL_Scrollbox1;
          Template:=aTemplate;
          with Mi_lcl_ui_ds_Form1.DmxScroller_Form do
            onGetTemplate := Mi_lcl_ui_ds_Form1GetTemplate;

          with Mi_LCL_Scrollbox1 do
          begin
            AutoSize:=false;
            AutoScroll:= false;
            Height  := 116;
            Width   := 353 ;
          end;

          with ButtonPanel1 do
          begin
            CancelButton.DefaultCaption := True;
            TabOrder := 1;
          end;
          _CanClose := true;
       end;
end;

function TMi_lcl_inputbox.MI_UI_InputBox1InputBox(aTitle: AnsiString;
                                                   aTemplate: AnsiString;
                                                   aOnCloseQuery: TOnCloseQuery;
                                                   aFont: AnsiString;
                                                   aOnEnter: TOnEnter;
                                                   aOnExit: TOnExit;
                                                   aOnEnterField: TOnEnterField;
                                                   aOnExitField: TOnExitField;
                                                   aIn_JSONObject: TJSONObject;
                                                   out aOut_JSONObject: TJSONObject): TModalResult;

  var
    s : TRect;
begin
  with Mi_LCL_Scrollbox1 do
  begin
    if AutoScroll
    Then AutoScroll:= false;

    if AutoSize
    Then AutoSize := false;
  end;

  Create_Mi_lcl_ui_ds_Form1(aTemplate);

  Template:= aTemplate;
  SetAlias(aTitle);
  with Mi_lcl_ui_ds_Form1.DmxScroller_Form do
  begin
    //GroupBox1.Caption:=Alias;

   {$Region Setar eventos}
      OnCloseQuery  := aOnCloseQuery;
      if @aOnEnter <> nil
      then OnEnter  := aOnEnter
      else OnEnter  := Mi_lcl_ui_ds_Form1Enter;

      OnExit        := aOnExit;
      OnEnterField  := aOnEnterField;
      OnExitField   := aOnExitField;
      onGetTemplate := Mi_lcl_ui_ds_Form1GetTemplate;
   {$EndRegion Setar eventos}

    Mi_lcl_ui_ds_Form1.Active:=true;

//    SetArgs(aArgs);
    JSONObject := aIn_JSONObject;
    JSONObject.free;
  end;

  with Mi_LCL_Scrollbox1 do
  begin
    if aFont<>''
    Then begin
           Font.Name := aFont;
           ParentFont := False;
         end;
  end;

 repeat
   s := SetBounds_local;
   Result := ShowModal;
   if Result = MrOk
   then with Mi_lcl_ui_ds_Form1,DmxScroller_Form do
        begin
          //O registro altual precisa ser selecionado para que se possa gravar no BufDataSet.
          DoOnEnter();
          UpDateRec; //Gravar
          if Assigned(OnCloseQuery)
          Then OnCloseQuery(DmxScroller_Form,_CanClose)
          else _CanClose := true;

          if _CanClose
          Then aOut_JSONObject := JSONObject;
        end
   else aOut_JSONObject := nil;
 until ((result in [MrOk]) and _CanClose) or (result in [mrCancel]);

 with Mi_lcl_ui_ds_Form1 do
 begin
   Mi_lcl_ui_ds_Form1.DmxScroller_Form.OnCloseQuery := nil;
 end;
end;

constructor TMi_lcl_inputbox.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  Create_Mi_lcl_ui_ds_Form1('~Form vazio~');

  if Assigned(Application.MainForm)
  Then Position:=poMainFormCenter;
end;

procedure TMi_lcl_inputbox.testInputBox1;
  var
    in_JSONObject,
    out_JSONObject : TJSONObject;

  var
    Mi_rtl : TMi_rtl;
begin
  try
    Mi_rtl := TMi_rtl.Create(nil);
    with Mi_rtl do
    begin
      in_JSONObject := TJSONObject.Create(['id'      , 1,
                                        'nome'    ,'Paulo Sérgio',
                                        'endereco','Rua Francisco de Souza Oliveira',
                                        'cep'     ,'61624-300']);

      //Exemplo com eventos
      if InputBox('Teste com eventos',
          ' ~Id:      ~\LLLLLL'+chFN+'id'+^M+
          ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'Nome'+^M+
          ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'Endereco'+^M+
          ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M
          ,  nil,'',nil,nil,nil,nil
          ,in_JSONObject
          ,out_JSONObject) = mrok
      then begin
             in_JSONObject.free;
             out_JSONObject.free;
           end;

    end;

  finally
    FreeAndNil(Mi_rtl);
  end;

end;

//class procedure TMi_lcl_inputbox.testInputBox2;
//
//  var
//    in_JSONObject,
//    out_JSONObject : TJSONObject;
//begin
//  with TMi_rtl,MI_UI_InputBox do
//  begin
//    in_JSONObject := TJSONObject.Create;
//    //Exemplo com evento OnCloseQuery
//    if InputBox('Teste com evento OnCloseQuery',
//        ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'nome'+^M+
//        ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'endereco'+^M+
//        ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M+
//        ' ~Número:  ~\#########'+ChFN+'numero'+^M
//        ,nil
//        ,in_JSONObject
//        ,out_JSONObject) = mrok
//    then begin
//           printaJsonObject(out_JSONObject);
//           FreeAndNil(out_JSONObject);
//         end;
//    Freeandnil(in_JSONObject);
//
//  end;
//end;
//
//class procedure TMi_lcl_inputbox.testInputBox3;
//var
//  in_JSONObject,
//  out_JSONObject : TJSONObject;
//begin
//  with TMi_rtl,MI_UI_InputBox do
//  begin
//      in_JSONObject := TJSONObject.Create;
//    //Exemplo sem eventos
//    if InputBox('Teste sem eventos',
//        ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'nome'+^M+
//        ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'endereco'+^M+
//        ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M+
//        ' ~Número:  ~\#########'+ChFN+'numero'+^M+
//        ' ~Bairro:  ~\ssssssssssssssssssss'+ChFN+'bairro'+^M
//        ,in_JSONObject
//        ,out_JSONObject) = mrok
//    then begin
//           printaJsonObject(out_JSONObject);
//           FreeAndNil(out_JSONObject);
//         end;
//    Freeandnil(in_JSONObject);
//  end;
//
//end;
//
//class procedure TMi_lcl_inputbox.testInputBox4;
//  var
//    in_JSONObject,
//    out_JSONObject : TJSONObject;
//begin
//  with TMi_rtl,MI_UI_InputBox do
//  begin
//    in_JSONObject := TJSONObject.Create;
//    // Exemplo sem eventos
//    if InputBox('Teste sem eventos',
//        '~EXEMPLO DE TEMPLATE~'+^M+
//        '~ Sexo...:~'+ CreateEnumField(TRUE, accNormal, 0,
//                                      NewSItem(' indefinido ',
//                                      NewSItem(' Masculino',
//                                      NewSItem(' Feminino',
//                                              nil))))+^M+
//        ' '+^M+
//        '~ Alfanumérico maiúscula com 15 posições:~'+^M+
//        '~ ~\SSSSSSSSSSSSSSS'+^M+
//        '~ Alfanumérico maiúscula e minuscula com 30 posições:~'+^M+
//        '~ ~\ssssssssssssssssssssssssssssssssssssss'+^M+
//        '~ Alfanumérico com a primeira letra maiúscula:~'+^M+
//        '~ ~\Sssssssssssssss'+^M+
//        '~ Valor double.......:~\RRR,RRR.RR'+^M+
//        '~ Valor SmalInt......:~\II,III'+^M+
//        '~ Valor Byte.........:~\BBB'+^M+
//        '~ Valor SmallWord....:~\WW,WWW'+^M+
//        '~ SEXO:~'+^M+
//        '~ ~\KA Indefinido  '+^M+
//        '~ ~\KA Masculino   '+^M+
//        '~ ~\KA Feminino    '+^M+
//        '~ ESTADO CIVIL~'+^M+
//        '~ ~\X Casado?                '+^M+
//        '~ ~\X Pretende se divorciar? '+^M+
//        '~ ~\X Tens filhos?           '+^M+
//        '~ Sexo...:~'+ CreateEnumField(TRUE, accNormal, 0,
//                                      NewSItem(' indefinido ',
//                                      NewSItem(' Masculino',
//                                      NewSItem(' Feminino',
//                                              nil))))+^M+
//        ' '+^M+
//        '~ Alfanumérico maiúscula com 15 posições:~'+^M+
//        '~ ~\SSSSSSSSSSSSSSS'+^M+
//        '~ Alfanumérico maiúscula e minuscula com 30 posições:~'+^M+
//        '~ ~\ssssssssssssssssssssssssssssssssssssss'+^M+
//        '~ Alfanumérico com a primeira letra maiúscula:~'+^M+
//        '~ ~\Sssssssssssssss'+^M+
//        '~ Valor double.......:~\RRR,RRR.RR'+^M+
//        '~ Valor SmalInt......:~\II,III'+^M+
//        '~ Valor Byte.........:~\BBB'+^M+
//        '~ Valor double.......:~\RRR,RRR.RR'+^M+
//        '~ Valor SmalInt......:~\II,III'+^M+
//        '~ Valor Byte.........:~\BBB'+^M+
//        '~ Valor SmallWord....:~\WW,WWW'+^M+
//        '~ SEXO:~'+^M+
//        '~ ~\KB Indefinido  '+^M+
//        '~ ~\KB Masculino   '+^M+
//        '~ ~\KB Feminino    '+^M+
//        '~ ESTADO CIVIL~'+^M+
//        '~ ~\X Casado?                '+^M+
//        '~ ~\X Pretende se divorciar? '+^M+
//        '~ ~\X Tens filhos?           '+^M+
//        '~ Sexo...:~'+ CreateEnumField(TRUE, accNormal, 0,
//                                      NewSItem(' indefinido ',
//                                      NewSItem(' Masculino',
//                                      NewSItem(' Feminino',
//                                              nil))))+^M+
//        ' '+^M+
//        '~ Alfanumérico maiúscula com 15 posições:~'+^M+
//        '~ ~\SSSSSSSSSSSSSSS'+^M+
//        '~ Alfanumérico maiúscula e minuscula com 30 posições:~'+^M+
//        '~ ~\ssssssssssssssssssssssssssssssssssssss'+^M+
//        '~ Alfanumérico com a primeira letra maiúscula:~'+^M+
//        '~ ~\Sssssssssssssss'+^M+
//        '~ Valor double.......:~\RRR,RRR.RR'+^M+
//        '~ Valor SmalInt......:~\II,III'+^M+
//        '~ Valor Byte.........:~\BBB'+^M+
//        '~ SEXO:~'+^M+
//        '~ ~\KC Indefinido  '+^M+
//        '~ ~\KC Masculino   '+^M+
//        '~ ~\KC Feminino    '+^M+
//        '~ Valor Byte.........:~\BBB'+^M
//        ,in_JSONObject
//        ,out_JSONObject) = mrok
//    then begin
//           printaJsonObject(out_JSONObject);
//           out_JSONObject.free;
//         end;
//    Freeandnil(in_JSONObject);
//  end;
//end;


{: Inicialização do projeto usado para criar o módudlo MI_UI_MsgBox}

initialization



finalization
//  setMI_UI_InputBox_lcl(nil);

end.





