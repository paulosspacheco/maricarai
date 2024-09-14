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
  Classes, SysUtils, Forms, Controls, Graphics, ButtonPanel, ActnList, Dialogs,
  StdCtrls
  , fpjson
  , mi.rtl.ui.dmxscroller.inputbox
  , mi.Rtl.Objectss
 // , mi_rtl_ui_dmxscroller_form
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
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
    MI_UI_InputBox1: TMI_UI_InputBox;
    

    procedure DmxScroller_Form_Lcl1CloseQuery(aDmxScroller: TUiDmxScroller;      var CanClose: boolean);
    procedure DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    function DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;

//    procedure DmxScroller_Form_Lcl1NewRecord(aDmxScroller: TUiDmxScroller);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    function MI_UI_InputBox1InputBox(aTitle: AnsiString;
                                     aTemplate: AnsiString;
                                     aOnCloseQuery: TOnCloseQuery;
                                     aFont: AnsiString;
                                     aOnEnter: TOnEnter;
                                     aOnExit: TOnExit;
                                     aOnEnterField: TOnEnterField;
                                     aOnExitField:
                                     TOnExitField;
                                     aIn_JSONObject: TJSONObject;
                                     out aOut_JSONObject: TJSONObject): TModalResult;

      Private _CanClose: boolean ;
      private function SetBounds_local: TRect;
      private function IIF(const Logica: Boolean; const E1,E2: Longint): Longint;
      private function MaxL(const a, b: Longint): Longint;

      public   DmxScroller_Form_Lcl1: TDmxScroller_Form_Lcl;

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

      public procedure Create_DmxScroller_Form_Lcl1;
      public constructor Create(TheOwner: TComponent); override;

      class Procedure testInputBox1;
      class Procedure testInputBox2;
      class Procedure testInputBox3;
      class Procedure testInputBox4;
  end;

  TMI_UI_InputBox_lcl_class = class(TMI_UI_InputBox)

  end;

//Procedure SetMI_UI_InputBox_lcl(aMI_UI_InputBox_lcl:TMI_UI_InputBox_lcl);


implementation

{$R *.lfm}


//var
//  MI_UI_InputBox_lcl: TMI_UI_InputBox_lcl;
//
//Procedure SetMI_UI_InputBox_lcl(aMI_UI_InputBox_lcl:TMI_UI_InputBox_lcl);
//
//begin
//  if Assigned(MI_UI_InputBox_lcl)
//  then begin
//         TMi_Rtl.Set_MI_UI_InputBox(nil);
//         FreeAndNil(MI_UI_InputBox_lcl);
//       end;
//
//  if MI_UI_InputBox_lcl<>nil
//  Then TMi_Rtl.Set_MI_UI_InputBox(MI_UI_InputBox_lcl.MI_UI_InputBox1);
//end;

{ TMI_UI_InputBox_lcl }


function TMI_UI_InputBox_lcl.SetBounds_local: TRect;

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
  begin
    Result:=0;
    for i := 0 to ctrl.controlcount - 1 do
      if ctrl.controls[i] is Twincontrol then
      begin
        xRect := (ctrl.controls[i] as Twincontrol).BoundsRect;
        Result := maxL(Result,xRect.BottomRight.y);
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

begin //Inicio: SetBounds_local: TRect;
  SetBounds(0,0,165,353);

  Result := TRect.Create(0
                         ,0
                         ,HorzTopMax(Mi_ScrollBox_LCL1)
                         ,VertTopMax(Mi_ScrollBox_LCL1)
                         );
  Result  := GetMaxRectSizeControl(Mi_ScrollBox_LCL1,Result);
  SetBounds(Result.Left,
            Result.Top,
            Result.Right+15,
            Result.Bottom+44);
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

procedure TMI_UI_InputBox_lcl.FormCloseQuery(Sender: TObject;  var CanClose: Boolean);
begin
  DmxScroller_Form_Lcl1CloseQuery(DmxScroller_Form_Lcl1,CanClose);
end;



procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    Var
      i : Integer;
    var
      aField: pDmxFieldRec;
//      s : string;

begin
//  with aDmxScroller do
//  begin
//    For i:= 1 to aDmxScroller.Fields.Count-1 do
//    begin
//      aField := aDmxScroller.FieldByNumber(i);
//
//      if  (aField <> nil) and  (aField.LinkEdit<>nil)
//      and (aField.Fieldnum<>0) and (aField.LinkEdit is TControl)
//      Then begin
//             aField.AsString:= aField.AsString;
//             (aField.LinkEdit as TControl).Show;
////               s:= aField^.FieldName;
//           end;
//
//    end;
//  end;
end;

procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1CloseQuery(  aDmxScroller: TUiDmxScroller; var CanClose: boolean);
begin

end;

function TMI_UI_InputBox_lcl.IIF(const Logica: Boolean; const E1,E2: Longint): Longint;
Begin
   If Logica Then Result := E1 Else IIF := E2;
End;

function TMI_UI_InputBox_lcl.MaxL(const a, b: Longint): Longint;
Begin
  result := IIF(b > a , b , a );
End;

function TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem  ): PSItem;
begin
  with DmxScroller_Form_lcl1 do
  begin
    if _Template  <> ''
    then Result := StringToSItem(_Template)
    else Result := StringToSItem('~template não inicializado~');
  end;
end;

function TMI_UI_InputBox_lcl.MI_UI_InputBox1InputBox(aTitle: AnsiString;
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
  with Mi_ScrollBox_LCL1 do
  begin
    if AutoScroll
    Then AutoScroll:= false;

    if AutoSize
    Then AutoSize := false;
  end;

  Create_DmxScroller_Form_Lcl1;

  Template:= aTemplate;
  SetAlias(aTitle);

  with DmxScroller_Form_Lcl1 do
  begin
   {$Region Setar eventos}
      OnCloseQuery  := aOnCloseQuery;
      if @aOnEnter <> nil
      then OnEnter  := aOnEnter
      else OnEnter  := DmxScroller_Form_Lcl1Enter;

      OnExit        := aOnExit;
      OnEnterField  := aOnEnterField;
      OnExitField   := aOnExitField;
      onGetTemplate := DmxScroller_Form_Lcl1GetTemplate;
   {$EndRegion Setar eventos}

    if not Active
    then Active:= true;

//    SetArgs(aArgs);
    JObject := aIn_JSONObject;

  end;

  with Mi_ScrollBox_LCL1 do
  begin
    if aFont<>''
    Then begin
           Font.Name := aFont;
           ParentFont := False;
         end;

    //AutoScroll:= TRUE;
    //AutoSize := true;
  end;

 repeat
    s := SetBounds_local;
    Result := ShowModal;
 until (result in [MrCancel,MrOk]) and _CanClose;

 if Result = MrOk
 then begin
        aOut_JSONObject := DmxScroller_Form_Lcl1.JObject;
//          printaJsonObject;
      end
 else aOut_JSONObject := nil;

 with DmxScroller_Form_Lcl1 do
 begin
   if Active
   then Active:= false;
 end;

end;


//function TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem  ): PSItem;
//begin
//
//  with DmxScroller_Form_Lcl1 do
//  begin
//    //AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;
//    //AlignmentLabels:= taCenter;//taLeftJustify;taRightJustify;
//    //AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
//    result := NewSItem(^A,
//      NewSItem('',
//      NewSItem(_Template,
//      NewSItem('',
//      aNext))));
// end;
//end;

//procedure TMI_UI_InputBox_lcl.DmxScroller_Form_Lcl1NewRecord(  aDmxScroller: TUiDmxScroller);
//begin
//
//end;

procedure TMI_UI_InputBox_lcl.Create_DmxScroller_Form_Lcl1;
begin
  AutoSize:=false;
  Height  := 165;
  Width   := 353 ;

  if Assigned(DmxScroller_Form_Lcl1)
  then FreeAndNil(DmxScroller_Form_Lcl1);

  DmxScroller_Form_Lcl1 := TDmxScroller_Form_Lcl.Create(Mi_ScrollBox_LCL1);

  with Mi_ScrollBox_LCL1 do
  begin
    UiDmxScroller := DmxScroller_Form_Lcl1;
    AutoSize:=false;
    AutoScroll:= false;
    Height  := 116;
    Width   := 353 ;
  end;

  with ButtonPanel1 do
  begin
    CancelButton.DefaultCaption := True;
    OnCloseQuery := FormCloseQuery;
    TabOrder := 1;
  end;


  _CanClose := true;
end;

constructor TMI_UI_InputBox_lcl.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  Create_DmxScroller_Form_Lcl1;
end;

class procedure TMI_UI_InputBox_lcl.testInputBox1;

  var
    in_JObject,
    out_JObject : TJSONObject;
begin
  with TMi_rtl,MI_UI_InputBox do
  begin

{   class operadores {
        +id: Integer
        +nome: String(50) not null
        +telefone: String(14)
}
    in_JObject := TJSONObject.Create(['id'    ,1,
                                      'nome','Paulo Pacheco',
                                      'telefone' ,'85997024498']);

    //Exemplo com todos os eventos
    if InputBox('Teste Operadores',
        ' ~id:      ~\IIIII'+ChFN+'id'+^M+
        ' ~nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'nome'+^M+
        ' ~telefone:~\## # #### ####'+ChFN+'telefone'+^M
        ,  nil,'',nil,nil,nil,nil
        ,in_JObject
        ,out_JObject) = mrok
    then begin
           printaJsonObject(out_JObject);
           FreeAndNil(out_JObject);
         end;

    FreeAndNil(in_JObject);
  end;
end;

class procedure TMI_UI_InputBox_lcl.testInputBox2;

  var
    in_JObject,
    out_JObject : TJSONObject;
begin
  with TMi_rtl,MI_UI_InputBox do
  begin
    in_JObject := TJSONObject.Create;
    //Exemplo com evento OnCloseQuery
    if InputBox('Teste com evento OnCloseQuery',
        ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'nome'+^M+
        ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'endereco'+^M+
        ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M+
        ' ~Número:  ~\#########'+ChFN+'numero'+^M
        ,nil
        ,in_JObject
        ,out_JObject) = mrok
    then begin
           printaJsonObject(out_JObject);
           FreeAndNil(out_JObject);
         end;
    Freeandnil(in_JObject);

  end;
end;

class procedure TMI_UI_InputBox_lcl.testInputBox3;
var
  in_JObject,
  out_JObject : TJSONObject;
begin
  with TMi_rtl,MI_UI_InputBox do
  begin
      in_JObject := TJSONObject.Create;
    //Exemplo sem eventos
    if InputBox('Teste sem eventos',
        ' ~Nome:    ~\sssssssssssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'nome'+^M+
        ' ~Endereço:~\sssssssssssssssssssssssssssss`ssssssssssssssssssssssss'+ChFN+'endereco'+^M+
        ' ~Cep:     ~\##.###-###'+ChFN+'cep'+^M+
        ' ~Número:  ~\#########'+ChFN+'numero'+^M+
        ' ~Bairro:  ~\ssssssssssssssssssss'+ChFN+'bairro'+^M
        ,in_JObject
        ,out_JObject) = mrok
    then begin
           printaJsonObject(out_JObject);
           FreeAndNil(out_JObject);
         end;
    Freeandnil(in_JObject);
  end;

end;

class procedure TMI_UI_InputBox_lcl.testInputBox4;
  var
    in_JObject,
    out_JObject : TJSONObject;
begin
  with TMi_rtl,MI_UI_InputBox do
  begin
    in_JObject := TJSONObject.Create;
    // Exemplo sem eventos
    if InputBox('Teste sem eventos',
        '~EXEMPLO DE TEMPLATE~'+^M+
        '~ Sexo...:~'+ CreateEnumField(TRUE, accNormal, 0,
                                      NewSItem(' indefinido ',
                                      NewSItem(' Masculino',
                                      NewSItem(' Feminino',
                                              nil))))+^M+
        ' '+^M+
        '~ Alfanumérico maiúscula com 15 posições:~'+^M+
        '~ ~\SSSSSSSSSSSSSSS'+^M+
        '~ Alfanumérico maiúscula e minuscula com 30 posições:~'+^M+
        '~ ~\ssssssssssssssssssssssssssssssssssssss'+^M+
        '~ Alfanumérico com a primeira letra maiúscula:~'+^M+
        '~ ~\Sssssssssssssss'+^M+
        '~ Valor double.......:~\RRR,RRR.RR'+^M+
        '~ Valor SmalInt......:~\II,III'+^M+
        '~ Valor Byte.........:~\BBB'+^M+
        '~ Valor Smallword....:~\WW,WWW'+^M+
        '~ ESTADO CIVIL~'+^M+
        '~ ~\X Casado?                '+^M+
        '~ ~\X Pretende se divorciar? '+^M+
        '~ ~\X Tens filhos?           '+^M+
        '~ SEXO:~'+^M+
        '~ ~\KA Indefinido  '+^M+
        '~ ~\KA Masculino   '+^M+
        '~ ~\KA Feminino    '+^M
        ,in_JObject
        ,out_JObject) = mrok
    then begin
           printaJsonObject(out_JObject);
           out_JObject.free;
         end;
    Freeandnil(in_JObject);
  end;
end;


{: Inicialização do projeto usado para criar o módudlo MI_UI_MsgBox}

initialization



finalization
//  setMI_UI_InputBox_lcl(nil);

end.





