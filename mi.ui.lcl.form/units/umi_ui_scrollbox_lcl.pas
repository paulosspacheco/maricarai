unit uMi_ui_scrollbox_lcl;
{:< A unit **@name** implementa a classe  TMi_ScrollBox_LCL para ser usado como
    container para UiDmxScroller.

  - **VERSÃO**
    - Alpha - 0.7.1

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.ui.lcl.scrollboxDmx.pas">mi.rtl.objects.methods.ui.DmxScroller.pas</a>)

  - **PENDÊNCIAS**
    - O evento onGetTemplate não está funcionando de forma automática, preciso setá-lo.
    - Antes de executar onGetTemplate definir um nome de fonte padrão e checar se o mesmo precede
      a fonte editada na IDE.

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)
      - **2022-02-21 **
        - Data em que essa unity foi criada.  ✅

      - **2022-02-22 14:00**
        - Documentar a unidade. ✅
        -
      - **2022-02-24 21:00**
        - Implementar os enventos OnEnter e OnExit de TMi_ScrollBox_LCL para executar
          os eventos OnEnter e onExit de UiDmxScroller ✅

     - **2022-03-01 11:00**
        - Em TMi_ScrollBox_LCL.Create inicializar a fonte fixa **Courie New** se windows ou
          **DejaVu Sans Mono** se linux e em ambas as plataformas foi definido o tamanho
          da fonte em 12 px. ✅

     - **2022-03-22 20:00**
       - Os eventos onEnter e OnExit não estavam executando TUiDmxScroller.DoOnEnter e TUiDmxScroller.OnExit
         caso o usuário não tenha iniciado os eventos OnEnter e OnExit do formulário isso gerava
         problema em GetBuffer e SetBuffer. Corrigido. ✅
     - **2022-06-27 18:19**
       - Redefinir  procedure ComputeScrollbars; virtual;
         - Implementei mais meus problema continuaram.
           Tem algo muito errado no controle ScrollBox do Lazarus.
}

{$mode Delphi}

interface

uses
  Classes, SysUtils, LResources, Forms, Controls, Graphics, Dialogs,LMessages,types
  ,mi_rtl_Ui_Methods
  ,mi_rtl_ui_Dmxscroller;


type PSItem =  TUiMethods.PSItem;


type
  { TMi_ScrollBox_LCL }
  {: A Classe **@name** foi redefinida para que os eventos DmxScroller.OnEnter e
     DmxScroller.OnExit sejam executados quando o ScrollBox recebe e perde o foco.

     - **REFERẼNCIAS**
       - [TScrollBox](https://lazarus-ccr.sourceforge.io/docs/lcl/forms/tscrollbox.html)
       - [Form_Tutorial](https://wiki.freepascal.org/Form_Tutorial)
       -
  }
  TMi_ScrollBox_LCL = class(TScrollBox)

    {: A procedure **@name** é usado para executar o evento onEnter de  DmxScroller}
    protected procedure DoOnEnter(Sender: TObject);

    {: A procedure **@name** é usado para executar o evento onExit de  DmxScroller}
    protected procedure DoOnExit(Sender: TObject);

    {: O constructor **@name** foi redefinido para que os eventos OnEnter e OnExit
       sajam iniciados com DoOnEnter e DoOnExit respectivamente.}
    public Constructor Create(aOwner: TComponent);Override;
//    public Destructor Destroy;Override;

    {$REGION '<-- Propriedade DmxScroller'}

        Private Var _UiDmxScroller : TUiDmxScroller;

        {: O método **@name** é usado para inicializar o atributo _UiDmxScroller

           - **NOTA**
             - Caso a propriedade DmxScroller.Active seja **true**, então
               deve-se toná-la **false** para que perca o vínculo com a visão
               anterior.
        }
        protected Procedure SetUiDmxScroller(aUiDmxScroller:TUiDmxScroller);

        {: A propriedade **@name** foi crada para que os eventos DmxScroller.OnEnter e
           DmxScroller.OnExit sejam executados quando o ScrollBox recebe o foco e perde o foco.

           - A propriedade **@name** não deve ser published por que a mesma deve ser
           inicializada automatiocamente em TUiDmxScroller.SetParentLCL()
        }
        public property UiDmxScroller : TUiDmxScroller read _UiDmxScroller write SetUiDmxScroller;
    {$ENDREGION '<-- Propriedade DmxScroller'}

//    protected procedure WMPaint(var Message: TLMPaint); message LM_PAINT;
    Procedure Refresh;

     function WidthChar:Byte;
     function HeightChar:Byte;

//    procedure ComputeScrollbars; override;
  end;


procedure Register;

implementation

procedure Register;
begin
  {$I umi_ui_scrollbox_lcl_icon.lrs}
  RegisterComponents('Mi.Ui.Lcl.Form',[TMi_ScrollBox_LCL]);
end;

{ TMi_ScrollBox_LCL }

procedure TMi_ScrollBox_LCL.DoOnEnter(Sender: TObject);
begin
  if Assigned(UiDmxScroller)
  then begin
         UiDmxScroller.doOnEnter(UiDmxScroller);
       End;
end;

procedure TMi_ScrollBox_LCL.DoOnExit(Sender: TObject);
begin
  if Assigned(UiDmxScroller)
  then  begin
          UiDmxScroller.doOnExit(UIDmxScroller);
        End;
end;

constructor TMi_ScrollBox_LCL.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);

  onEnter := DoOnEnter;
  onExit  := DoOnExit;
  AutoScroll :=false;
  TabStop := true;
end;


procedure TMi_ScrollBox_LCL.SetUiDmxScroller(aUiDmxScroller: TUiDmxScroller);
begin
  if (_UiDmxScroller<> nil) and _UiDmxScroller.Active
  then begin //Desative o formulário incluido em TMi_ScrollBox_LCL;
         _UiDmxScroller.Active := false;
       end;
  _UiDmxScroller := aUiDmxScroller;

  if _UiDmxScroller <> nil
  Then begin //Ativa _UiDmxScroller
         _UiDmxScroller.Active:=true;
       end;
end;

//procedure TMi_ScrollBox_LCL.WMPaint(var Message: TLMPaint);
//begin
//   //if UiDmxScroller<> nil
//   //then UiDmxScroller.UpdateBuffers;
//   inherited WMPaint(Message);
//end;

procedure TMi_ScrollBox_LCL.Refresh;
Begin
  //if UiDmxScroller<> nil
  //then UiDmxScroller.UpdateBuffers;
  Invalidate;
  Update;
End;

function TMi_ScrollBox_LCL.WidthChar: Byte;

    Function WidthCharMax:Byte;
      var
        i,w,h : integer;
    begin
      result := 0;
      for i := 1 to length(UiDmxScroller.CharAlfanumeric) do
      begin
        Canvas.GetTextSize(UiDmxScroller.CharAlfanumeric[i],w,h);
        if w > Result
        then Result := w;
      end;
    end;

   var w,h:integer;
begin
  Canvas.GetTextSize(UiDmxScroller.CharAlfanumeric,w,h);
  result := w div length(UiDmxScroller.CharAlfanumeric);
//  Result := WidthCharMax;

  //s  := Canvas.TextExtent(UiDmxScroller.CharAlfanumeric);
  //writeLn(Format('Largura %d; Altura %d; S.Width %d; S.Height %d; WidthCharMax %d; Result %d',[w,h,s.Width,s.Height,WidthCharMax,Result]));
end;

function TMi_ScrollBox_LCL.HeightChar: Byte;
  var
    w,h:integer;
begin
  Canvas.GetTextSize(UiDmxScroller.CharAlfanumeric,w,h);
  result := h;
end;

{
procedure TMi_ScrollBox_LCL.ComputeScrollbars;
  Procedure WriteDebug;
  begin
      writeLn('AutoScroll: ',AutoScroll);
      writeLn();
      writeLn('**HorzScrollBar**',' Width: ',Width);
      writeLn('  HorzScrollBar.Smooth %d ',HorzScrollBar.Smooth);
      writeLn('  HorzScrollBar.Tracking: %d ',HorzScrollBar.Tracking);
      writeLn('  HorzScrollBar.Range: %d ',HorzScrollBar.Range);
      writeLn('  HorzScrollBar.Position: %d ',HorzScrollBar.Position);
      writeLn('  HorzScrollBar.Page: %d ',HorzScrollBar.Page);
      writeLn('  HorzScrollBar.Increment: %d ',HorzScrollBar.Increment);
      writeLn('  HorzScrollBar.Visible: %d ',HorzScrollBar.Visible);
      writeLn();
      writeLn('**VertScrollBar** ',' Height: ',Height);
      writeLn('VertScrollBar.Smooth: %d ',VertScrollBar.Smooth);
      writeLn('VertScrollBar.Tracking: %d ',VertScrollBar.Tracking);
      writeLn('VertScrollBar.Range: %d ',VertScrollBar.Range);
      writeLn('VertScrollBar.Page: %d ',VertScrollBar.Page);
      writeLn('VertScrollBar.Increment: %d ',VertScrollBar.Increment);
      writeLn('VertScrollBar.Visible: %d ',VertScrollBar.Visible);
      writeLn();


  end;

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
    i: Integer;
    xRect: TRect;
  begin
    Result:=0;
    for i := 0 to ctrl.controlcount - 1 do
      if ctrl.controls[i] is Twincontrol then
      begin
        xRect := (ctrl.controls[i] as Twincontrol).BoundsRect;
        Result := maxL(Result,xRect.Right);
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

begin
  //HorzScrollBar.Smooth := false;
  //HorzScrollBar.Tracking:= False;
  HorzScrollBar.Range := MaxL( HorzTopMax(self)-15,self.Width-15);
  HorzScrollBar.Page  := Width - 15;
  HorzScrollBar.Increment := HorzScrollBar.Page div 10;

  //VertScrollBar.Smooth := True;
  //VertScrollBar.Tracking:= True;
  VertScrollBar.Range := VertTopMax(self)-50;;
  VertScrollBar.Page := MaxL(Height -15,self.Height-15);
  VertScrollBar.Increment := VertScrollBar.Page div 10;
//   WriteDebug;
end;
}

end.
