/// <since>
///   . Unit usada como base para todos os forms do projeto maricarai.
///   . REQUISITOS:
///        . A visualiza��o de hint flutuante onde o texto � mostrado em uma linha abaixo do item de menu.
/// </since>

unit uform_default;

{$MODE Delphi}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus
    , ExtCtrls,LCLType,Messages
    ,mi.rtl.all, uMi_lcl_ui_Form

   ;

Const
  ScreeWidh_Design : Integer = 1024;


type
   TMenuItemHint = class(THintWindow)
   private
     Var activeMenuItem: TMenuItem;
     Var showTimer: TTimer;
     Var hideTimer: TTimer;

     procedure HideTime(Sender: TObject);
     procedure ShowTime(Sender: TObject);
   public
     constructor Create(AOwner: TComponent); override;
     procedure DoActivateHint(menuItem: TMenuItem) ;
     procedure ActivateHint(Rect: TRect; const AHint: string); Override;
     destructor Destroy; override;
   end;

  { Tform_default }

  Tform_default = class(TForm)
    ApplicationEvents1: TApplicationProperties;

    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure FormPaint(Sender: TObject);

  private
    { Private declarations }
    var miHint : TMenuItemHint;
//    procedure WMMenuSelect(var Msg: TWMMenuSelect) ; message WM_MENUSELECT;

  private procedure AjustaFonts;

  Protected procedure AjustaForm;


  public function Show_Modal: Integer;

//
  public
    { Public declarations }
  end;


var
  form_default: Tform_default;


implementation

{$R *.lfm}



{ TMenuItemHint }
procedure TMenuItemHint.ActivateHint(Rect: TRect; const AHint: string);
begin
  //if Pos(UpperCase('<HTML>'),UpperCase(AHint)) = 0
  //then inherited ActivateHint(Rect,AHint)
  //Else WB_ShowHTML(rect,AHint);
end;

constructor TMenuItemHint.Create(AOwner: TComponent) ;
begin
  inherited;
  showTimer := TTimer.Create(self) ;
  showTimer.Interval := Application.HintPause;
  hideTimer := TTimer.Create(self) ;
  Application.HintHidePause := 50000;
  hideTimer.Interval := Application.HintHidePause;
end;

destructor TMenuItemHint.Destroy;
begin
  hideTimer.OnTimer := nil;
  showTimer.OnTimer := nil;
  self.ReleaseHandle;
//  Freeandnil(Form_WebBrowser_Hint);
  inherited;
end;

procedure TMenuItemHint.DoActivateHint(menuItem: TMenuItem) ;
begin
  //force remove of the "old" hint window
  hideTime(self) ;
  if (menuItem = nil) or (menuItem=nil) or (menuItem.Hint = '') then
  begin
    activeMenuItem := nil;
    Exit;
  end;
  activeMenuItem    := menuItem;
  showTimer.OnTimer := ShowTime;
  hideTimer.OnTimer := HideTime;
end; (*DoActivateHint*)

procedure TMenuItemHint.ShowTime(Sender: TObject) ;
var
  r: TRect;
  wdth: integer;
  hght: integer;
begin
  if activeMenuItem <> nil then
  begin
    //position and resize
    wdth := Canvas.TextWidth(activeMenuItem.Hint) ;
    hght := Canvas.TextHeight(activeMenuItem.Hint) ;
    r.Left := Mouse.CursorPos.X + 16;
    r.Top := Mouse.CursorPos.Y + 16;
    r.Right := r.Left + wdth + 6;
    r.Bottom := r.Top + hght + 4;
    ActivateHint(r,activeMenuItem.Hint) ;
  end;
   showTimer.OnTimer := nil;
end; (*ShowTime*)

procedure TMenuItemHint.HideTime(Sender: TObject) ;
begin
  //hide (destroy) hint window
//  Freeandnil(Form_WebBrowser_Hint);
  self.ReleaseHandle;
  hideTimer.OnTimer := nil;
end; (*HideTime*)

{ TForm1 }
procedure Tform_default.Action1Execute(Sender: TObject);
begin
  ShowMessage('action 1');
end;

procedure Tform_default.ApplicationEvents1Hint(Sender: TObject);
begin
  //StatusBar1.SimpleText := 'App.OnHint : ' + Application.Hint;
end;

procedure Tform_default.FormPaint(Sender: TObject);
begin
  TMi_lcl_ui_Form.Aplique_cantos_arredondados(self,13,13);
end;



procedure Tform_default.FormCreate(Sender: TObject);
begin
//  AjustaForm;
  miHint := TMenuItemHint.Create(self);

  //with TMi_rtl.THtml_tags do
  //  self.Color := HTMLToTColor(HColor_BG_Nav);

//  self.Color := TMi_rtl.HTMLToTColor('#85C1E9');
// self.Color := TMi_rtl.HTMLToTColor(HColor_Help);

 //with TMi_rtl.THtml_tags do
 //  self.Font.Color := HTMLToTColor(HColor_Fonts_Azul);
end;

procedure Tform_default.FormClose(Sender: TObject; var CloseAction: TCloseAction  );
begin
  CloseAction:=caFree;
  Visible := false;
end;

procedure Tform_default.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=13 then
    Self.SelectNext(ActiveControl, true, true);
//    perform(WM_NEXTDLGCTL,0,0);
end;

procedure Tform_default.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13
   then begin
          Key := #0;
          Perform(WM_KeyDown,VK_Tab,0)
        end;
end;


//procedure Tform_default.WMMenuSelect(var Msg: TWMMenuSelect) ;
//var
//   menuItem : TMenuItem;
//   hSubMenu : HMENU;
//begin
//   inherited; // from TCustomForm (so that Application.Hint is assigned)
//   menuItem := nil;
//
//   if miHint<>nil
//   then begin
//           if (Msg.MenuFlag <> $FFFF) or (Msg.IDItem <> 0) then
//           begin
//             if Msg.MenuFlag and MF_POPUP = MF_POPUP then
//             begin
//               hSubMenu := GetSubMenu(Msg.Menu, Msg.IDItem);
//               if Self.Menu<>nil
//               then menuItem := Self.Menu.FindItem(hSubMenu, fkHandle)
//               else menuItem := nil;
//             end
//             else
//             begin
//               if Self.Menu<>nil
//               then menuItem := Self.Menu.FindItem(Msg.IDItem, fkCommand)
//               else menuItem := nil;
//             end;
//           end;
//
//           if menuItem<>nil
//           then miHint.DoActivateHint(menuItem);
//         end;
//end;


//WMMenuSelect




procedure Tform_default.AjustaForm;
{Manter a janela no tamanho normal independente da resolu��o de v�deo}
{Declarar dentro do Type do Formul�rio e chamar a partir do evento Create do Form}
Var
  nEscala : Double;
  nPorcento : Integer;
begin
  if ScreeWidh_Design <> Screen.Width
  then begin
         nEscala := ((Screen.Width-ScreeWidh_Design)/ScreeWidh_Design);
         nPorcento := Round((nEscala*100) + 100);
         Width := Round(Width * (nEscala+1));
         Height := Round(Height * (nEscala+1));
         ScaleBy(nPorcento,100);
         AjustaFonts;
       end;
end;

procedure Tform_default.AjustaFonts;
  var
    i:integer;
begin
  //for i := componentCount - 1 downto 0 do
  //with components[i] do
  //begin
  //  if GetPropInfo(ClassInfo, 'font') <> nil
  //  then font.size := (Width DIV ScreeWidh_Design) * font.size;
  //end;
end;

function Tform_default.Show_Modal: Integer;
  //Excecuta o form e mant�m o estilo corrente.
  var
    aFormStyle : TFormStyle;
begin
  if IsConsole
  then Begin
          Try
            aFormStyle := self.FormStyle;
            //SysSetFocus(self,fsnormal);
            SetFocus;
            Visible := false;
            Result := ShowModal;
          Finally
            //SysSetFocus(self,aFormStyle);
            SetFocus
          End;
       End
  Else Result := ShowModal;
end;





initialization
//  Form_WebBrowser_Hint := TForm_WebBrowser_Hint.Create(nil);

Finalization

  //FreeandNil(Form_WebBrowser_Hint);
end.



//*** Adaptando para resolu��es de v�deo diferentes ***
(*
O autor diz:

'' Sempre que procurei algo sobre esse tema, ia para no Tip da Borland #2861, que � a mesma informa��o do arquivo de help da
Loyd's. Esse texto tamb�m aparece nos bancos de dados da Q&A. Eu suponho que essa seja a informa��o definitiva. Encontrei
uma informa��o que n�o foi mencionada aqui. Pela lista de correios do Delphi-Talk havia mensagens de Brien King e Michael
Novak que discutiam esse assunto.''

LOYD�S TIPS:

�����Resolu��o de V�deo:

Quando criamos formul�rios, as vezes � �til escrever um c�digo para que a tela e todos os seus objetos sejam mostrados no
mesmo tamanho, n�o importando qual a resolu��o da tela. Aqui esta um c�digo que mostra como isso � feito:

Implementation

const
ScreenWidth: LongInt = 800; //I designed my form in 800x600 mode.
ScreenHeight: LongInt = 600;

{$R *.DFM}

procedure TForm1.FormCreate (Sender: Tobject);

begin
����scaled := true;
����if (screen.width <> ScreenWidth) then
����begin
��������height := longint(height) * longint(screen.height) DIV ScreenHeight;
��������width := longint(width) * longint(screen.width) DIV ScreenWidth;
��������scaleyBy(screen.width, ScreenWidth);
����end;
end;

Agora, voc� vai querer checar, se o tamanho dos fontes(de letra) est�o OK. Antes de trocar o tamanho do fonte, voc� precisar� ter
certeza de que o objeto realmente tem a propriedade fonte pela checagem da RTTI. Isso pode ser feito assim:

USES tyinfo; {Add this to your USES statement.}

var

i:integer;

begin
����for i := componentCount - 1 downto 0 do
����with components[i] do
����begin
��������if GetPropInfo(ClassInfo, �font�) <> nil then
��������font.size := (NewFormWidth DIV OldFormWidth) * font.size;
����end;
end;


//Esta � a maneira longa de fazer a mesma coisa

var

i:integer;

p:PPropInfo;

begin
����for i := componentCount - 1 downto 0 do
����with components [i] do
����begin
��������p := GetPropInfo (ClassInfo, �font�);
��������if assigned (p) then
��������font.size := (NewFormWidth DIV OldFormWidth) * font.size;
����end;
end;

Aten��o: Nem todos os objetos tem a propriedade FONT. Isso deve ser o suficiente para voc� come�ar.

Aten��o: A seguir, algumas dicas para ter em mente quando representar aplica��es Delphi (formul�rios) em diferentes resolu��es
de Tela:

* Decida antecipadamente, na etapa de cria��o do formul�rio, se ele ser� escal�vel ou n�o. A vantagem de um n�o escal�vel �
que nada muda em tempo de execu��o. A desvantagem � equivalente (seu formul�rio pode ser muito pequeno ou grande para
alguns sistemas se n�o for usada escala).

* Se voc� n�o for usar formul�rio escal�vel, configure o set scaled to False.

* Ou ent�o, configure a propriedade scaled do formul�rio para True.

* Configure a propriedade AutoScroll para False. AutoScroll = True quer dizer "n�o mexa no tamanho do frame do formul�rio em
tempo de execu��o", o que n�o parece bom quando o conte�do do formul�rio muda de tamanho.

* Configure a fonte do formul�rio para uma True Type escal�vel, como a Arial MS. San Serif � uma boa alternativa, mas lembre que
ainda � uma fonte bitmapped. S� a Arial dar� uma fonte dentro de um pixel da altura desejada.ATEN��O: Se a fonte usada em
uma aplica��o n�o estiver instalada no computador, o Windows selecionar� uma fonte alternativa da mesma fam�lia para utilizar. O
tamanho dessa fonte pode n�o corresponder ao da fonte original, podendo causar problemas.

* Configure a propriedade position do formul�rio para uma op��o diferente de poDesigned. poDesigned deixa o formul�rio onde voc�
o deixou ( no design Time), o que sempre termina fora da margem, � esquerda da minha tela 1280 x 1024 - e completamente fora
da tela 640 x 480.

* N�o amontoe controles no formul�rio - deixe pelo menos 4 pixels entre else, para que uma mudan�a de um pixel nas margens
(devido a apresenta��o em escala) n�o mostre controles sobrepostos.

* Para labels de uma linha alinhadas � esquerda ou � direita, configure o AutoSize para True. Para outras formas de alinhamento
configure o AutoSize para False.

* Tenha certeza de que h� espa�o em branco suficiente num componente de labels para altera��es no tamanho da fonte - um
espa�o de 25% do comprimento da linha de caracteres mostrada � um pouco a mais do que se precisa, mas � mais seguro.
(Voc� vai precisar de um espa�o equivalente a 30% de espans�o para string labels se voc� pretende traduzir sua aplica��o para
outra linguagem). Se o Autosize estiver em False, tenha certeza de que realmente configurou o tamanho do label corretamente.
Se o Autosize estiver em True, esteja certo de que h� espa�o suficiente para que o label se amplie.

* Em labels de m�ltiplas linhas ou de termos ocultos, deixe pelo menos uma linha em branco na base. Isso vai ser necess�rio
para incluir o que estiver sobrando quando o texto for oculto de maneira diferente, pela mudan�a do tamanho da fonte com a
escala. N�o assuma isso porque est� usando fontes grandes. Voc� n�o tem que deixar sobra de texto - as fontes (grandes) de
outros usu�rios podem ser maiores que as suas!

* Tenha cuidado quando abrir um projeto em IDEs com resolu��es diferentes. Assim que o formul�rio for aberto, sua propriedade
Pixel per Inch ser� moditificada, e gravada para o DFM se voc� salvar o projeto. � melhor testar a aplica��o rodando sozinho, e
editar o formul�rio em apenas uma resolu��o. Editar em v�rias resolu��es e tamanhos de fonte provoca problemas de fluxo e
tamanho dos componentes.

*Falando em fluxo de componentes, n�o represente o formul�rio em escala muitas vezes, quando estiver sendo criado ou quando
tiver sendo executado. Cada escala introduz erros de roundoff que se acumulam muito rapidamente, uma vez que as coordenadas
s�o rigorosamente inteiras. Quando valores fracion�rios forem retirados das origens e tamanhos do controle com cada sucessiva
representa��o em escala, os controles parecer�o deslizar para noroeste e ficar menores. Se voc� quer deixar seus usu�rios
representarem o formul�rios em escala quantas vezes quiserem, comece com um formul�rio recentemente criado para que erros
de escala n�o se acumulem.

* Definitivamente, n�o mexa na propriedade Pixel pre Inch do formul�rio.

* Em geral, n�o � necess�rio criar formul�rios em uma resolu��o espec�fica, mas � essencial que voc� os revise em 640 x 480
com fontes pequenas e/ou grandes, e em alta resolu��o com fontes pequenas e/ou grandes antes de liberar suas aplica��es. Isso
deve ser parte de sua lista de confer�ncia para testar a compatibilidade do sistema regularmente.

* Preste bastante aten��o em todos os componentes que s�o basicamamente TMemo de uma linha - com oTDBLookupCombo. O
controle de edi��o (multi-linhas) do Windows sempre mostra apenas linhas inteiras de texto. Se o controle for muito curto para
sua fonte, um TMemo n�o mostrar� coisa alguma, e um TEdit mostrar� um peda�o do texto. � melhor fazer esses componentes
um pouco maiores do que deix�-los um pixel menores e n�o aparecer nada do texto.

�* Tenha em mente que toda representa��o em escala � proporcional � diferen�a da altura da fonte entre o modo de execu��o e o
modo de desenho, N�O � resolu��o ou ao tamanho do monitor. Lembre tamb�m que as origens dos seus controles ser�o
alteradas quando o formul�rio for representado em escala. Voc� n�o pode aumentar componentes muito bem sem tamb�m
mov�-los um pouco, novamente.



===============================================
Vers�o do 2 do documento.
===============================================



Ajustando o Formul�rio a resolu��es de v�deo diferentes
procedure AjustaForm;
{Manter a janela no tamanho normal independente da resolu��o de v�deo}
//Declarar dentro do Type do Formul�rio e chamar a partir do evento Create do Form
Const
ScreeWidh_Design = 640;
Var
nEscala : Double;
nPorcento : Integer;
begin
if ScreeWidh_Design <> Screen.Width then
begin
nEscala := ((Screen.Width-ScreeWidh_Design)/ScreeWidh_Design);
nPorcento := Round((nEscala*100) + 100);
Width := Round(Width * (nEscala+1));
Height := Round(Height * (nEscala+1));
ScaleBy(nPorcento,100);
end;
end;



Ajustando o Formul�rio a resolu��es de v�deo diferentes (2)
Quando criamos formul�rios, as vezes � �til escrever um c�digo para que a tela e todos os seus objetos sejam mostrados no mesmo tamanho, n�o importando qual a resolu��o da tela. Aqui esta um c�digo que mostra como isso � feito:

Implementation
const
ScreenWidth: LongInt = 800; {I designed my form in 800x600 mode.}
ScreenHeight: LongInt = 600;

{$R *.DFM}

procedure TForm1.FormCreate (Sender: Tobject);
begin
����scaled := true;
����if (screen.width <> ScreenWidth) then
����begin
��������height := longint(height) * longint(screen.height) DIV ScreenHeight;
��������width := longint(width) * longint(screen.width) DIV ScreenWidth;
��������scaleBy(screen.width, ScreenWidth);
����end;
end;

Agora, voc� vai querer checar, se o tamanho dos fontes(de letra) est�o OK. Antes de trocar o tamanho da fonte, voc� precisar� ter certeza de que o objeto realmente tem a propriedade fonte pela checagem da RTTI. Isso pode ser feito assim:

USES tyinfo;
ou
USES typinfo;

var
i:integer;
begin
����for i := componentCount - 1 downto 0 do
����with components[i] do
�������begin
�����������if GetPropInfo(ClassInfo, 'font') <> nil then
��������������font.size := (NewFormWidth DIV OldFormWidth) * font.size;
�����end;
end;

Esta � a maneira longa de fazer a mesma coisa:

var
i:integer;
p:PPropInfo;
begin
����for i := componentCount - 1 downto 0 do
����with components [i] do
�������begin
�����������p := GetPropInfo (ClassInfo, 'font');
�����������if assigned (p) then
��������������font.size := (NewFormWidth DIV OldFormWidth) * font.size;
�����end;
end;

Aten��o: Nem todos os objetos tem a propriedade FONT. Isso deve ser o suficiente para voc� come�ar.
Aten��o: A seguir, algumas dicas para ter em mente quando representar aplica��es Delphi (formul�rios) em diferentes resolu��es de Tela:

* Decida antecipadamente, na etapa de cria��o do formul�rio, se ele ser� escal�vel ou n�o. A vantagem de um n�o escal�vel � que nada muda em tempo de execu��o. A desvantagem � equivalente (seu formul�rio pode ser muito pequeno ou grande para alguns sistem

* Se voc� n�o for usar formul�rio escal�vel, configure o set scaled to False.

* Ou ent�o, configure a propriedade scaled do formul�rio para True.

* Configure a propriedade AutoScroll para False. AutoScroll = True quer dizer "n�o mexa no tamanho do frame do formul�rio em tempo de execu��o", o que n�o parece bom quando o conte�do do formul�rio muda de tamanho.

* Configure a fonte do formul�rio para uma True Type escal�vel, como a Verdana MS. San Serif � uma boa alternativa, mas lembre que ainda � uma fonte bitmapped. S� a Verdana dar� uma fonte dentro de um pixel da altura desejada. ATEN��O: Se a fonte usada em

* Configure a propriedade position do formul�rio para uma op��o diferente de "PoDesigned". PoDesigned deixa o formul�rio onde voc� o deixou ( no design Time), o que sempre termina fora da margem, � esquerda da minha tela 1280 x 1024 - e completamente fora

* N�o amontoe controles no formul�rio - deixe pelo menos 4 pixels entre eles, para que uma mudan�a de um pixel nas margens (devido a apresenta��o em escala) n�o mostre controles sobrepostos.

* Para labels, de uma linha alinhada a esquerda ou � direita, configure o AutoSize para True. Para outras formas de alinhamento configure o AutoSize para False.

* Tenha certeza de que h� espa�o em branco suficiente num componente de labels para altera��es no tamanho da fonte - um espa�o de 25% do comprimento da linha de caracteres mostrada � um pouco a mais do que se precisa, mas � mais seguro. (Voc� vai precisar

* Em labels de m�ltiplas linhas ou de termos ocultos, deixe pelo menos uma linha em branco na base. Isso vai ser necess�rio para incluir o que estiver sobrando quando o texto for oculto de maneira diferente, pela mudan�a do tamanho da fonte com a escala.

* Tenha cuidado quando abrir um projeto em IDEs com resolu��es diferentes. Assim que o formul�rio for aberto, sua propriedade Pixel per Inch ser� moditificada, e gravada para o DFM se voc� salvar o projeto. � melhor testar a aplica��o rodando sozinho, e e

* Falando em fluxo de componentes, n�o represente o formul�rio em escala muitas vezes, quando estiver sendo criado ou quando tiver sendo executado. Cada escala introduz erros de roundoff que se acumulam muito rapidamente, uma vez que as coordenadas s�o ri

* Definitivamente, n�o mexa na propriedade Pixel pre Inch do formul�rio.

* Em geral, n�o � necess�rio criar formul�rios em uma resolu��o espec�fica, mas � essencial que voc� os revise em 640 x 480 com fontes pequenas e/ou grandes, e em alta resolu��o com fontes pequenas e/ou grandes antes de liberar suas aplica��es. Isso deve

* Preste bastante aten��o em todos os componentes que s�o basicamamente TMemo de uma linha - com oTDBLookupCombo. O controle de edi��o (multi-linhas) do Windows sempre mostra apenas linhas inteiras de texto. Se o controle for muito curto para sua fonte, u

* Tenha em mente que toda representa��o em escala � proporcional � diferen�a da altura da fonte entre o modo de execu��o e o modo de desenho, N�O � resolu��o ou ao tamanho do monitor. Lembre tamb�m que as origens dos seus controles ser�o alteradas quando



Ajustando o Formul�rio a resolu��es de v�deo diferentes (3)
Fa�a uma chamada a esta rotina no evento OnCreate do formul�rio

procedure VideoAdjust(Form: TForm);
const
�ScreenWidth: LongInt = 800; // n�mero de pontos usado no desenvolvimento
�ScreenHeight: LongInt = 600; // n�mero de pontos usado no desenvolvimento
var
��i: integer;
begin
with Form do
�begin
��if Screen.Width = ScreenWidth then
�����Exit;
��Scaled := true;
��Height := Longint(height) * Longint(Screen.Height) DIV ScreenHeight;
��Width := Longint(Width) * Longint(Screen.Width) DIV ScreenWidth;
��ScaleyBy(Screen.Width, ScreenWidth);

// O tamanho da fonte dos objetos que tem essa propriedade dever� ser ajustado
// Para usar GetPropInfo, dever� ser adicionado Uses TypInfo.
��for i := ComponentCount - 1 downto 0 do
����with components[i] do
�������if GetPropInfo(ClassInfo, 'font') <> nil then
����������Font.Size := (NewFormWidth DIV OldFormWidth) * Font.Size;
�end; // with
end; // VideoAdjust
}
*)

