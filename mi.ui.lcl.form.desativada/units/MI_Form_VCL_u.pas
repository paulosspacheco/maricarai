/// <since>
///   . Unit usada como base para todos os forms do projeto maricarai.
///   . REQUISITOS:
///        . A visualização de hint flutuante onde o texto é mostrado em uma linha abaixo do item de menu.
/// </since>

unit MI_Form_VCL_u;

{$MODE Delphi}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus
    , ExtCtrls
    ,mi.rtl.all
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

  { TMI_Form_VCL }

  TMI_Form_VCL = class(TForm)
    ApplicationEvents1: TApplicationProperties;

    procedure FormCreate(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Hint(Sender: TObject);
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
  MI_Form_VCL: TMI_Form_VCL;

procedure Register;

implementation

{$R *.lfm}

procedure Register;
begin
  RegisterComponents('mi.ui.lcl.form', [TMI_Form_VCL]);
end;

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
procedure TMI_Form_VCL.Action1Execute(Sender: TObject);
begin
  ShowMessage('action 1');
end;

procedure TMI_Form_VCL.ApplicationEvents1Hint(Sender: TObject);
begin
  //StatusBar1.SimpleText := 'App.OnHint : ' + Application.Hint;
end;

procedure TMI_Form_VCL.FormCreate(Sender: TObject);
begin
//  AjustaForm;
  miHint := TMenuItemHint.Create(self);

  with TMi_rtl.THtml_tags do
    self.Color := HTMLToTColor(HColor_BG_Nav);

//  self.Color := TMi_rtl.HTMLToTColor('#85C1E9');
// self.Color := TMi_rtl.HTMLToTColor(HColor_Help);

 with TMi_rtl.THtml_tags do
   self.Font.Color := HTMLToTColor(HColor_Fonts_Azul);
end;

procedure TMI_Form_VCL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key=13 then
    Self.SelectNext(ActiveControl, true, true);
//    perform(WM_NEXTDLGCTL,0,0);
end;

procedure TMI_Form_VCL.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //if Key = #13
  // then begin
  //        Key := #0;
  //        Perform(WM_KeyDown,VK_Tab,0)
  //      end;
end;


//procedure TMI_Form_VCL.WMMenuSelect(var Msg: TWMMenuSelect) ;
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




procedure TMI_Form_VCL.AjustaForm;
{Manter a janela no tamanho normal independente da resolução de vídeo}
{Declarar dentro do Type do Formulário e chamar a partir do evento Create do Form}
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

procedure TMI_Form_VCL.AjustaFonts;
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

function TMI_Form_VCL.Show_Modal: Integer;
  //Excecuta o form e mantém o estilo corrente.
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

{ TForm_WebBrowser_Hint }



initialization
//  Form_WebBrowser_Hint := TForm_WebBrowser_Hint.Create(nil);

Finalization

  //FreeandNil(Form_WebBrowser_Hint);
end.



//*** Adaptando para resoluções de vídeo diferentes ***
(*
O autor diz:

'' Sempre que procurei algo sobre esse tema, ia para no Tip da Borland #2861, que é a mesma informação do arquivo de help da
Loyd's. Esse texto também aparece nos bancos de dados da Q&A. Eu suponho que essa seja a informação definitiva. Encontrei
uma informação que não foi mencionada aqui. Pela lista de correios do Delphi-Talk havia mensagens de Brien King e Michael
Novak que discutiam esse assunto.''

LOYD´S TIPS:

     Resolução de Vídeo:

Quando criamos formulários, as vezes é útil escrever um código para que a tela e todos os seus objetos sejam mostrados no
mesmo tamanho, não importando qual a resolução da tela. Aqui esta um código que mostra como isso é feito:

Implementation

const
ScreenWidth: LongInt = 800; //I designed my form in 800x600 mode.
ScreenHeight: LongInt = 600;

{$R *.DFM}

procedure TForm1.FormCreate (Sender: Tobject);

begin
    scaled := true;
    if (screen.width <> ScreenWidth) then
    begin
        height := longint(height) * longint(screen.height) DIV ScreenHeight;
        width := longint(width) * longint(screen.width) DIV ScreenWidth;
        scaleyBy(screen.width, ScreenWidth);
    end;
end;

Agora, você vai querer checar, se o tamanho dos fontes(de letra) estão OK. Antes de trocar o tamanho do fonte, você precisará ter
certeza de que o objeto realmente tem a propriedade fonte pela checagem da RTTI. Isso pode ser feito assim:

USES tyinfo; {Add this to your USES statement.}

var

i:integer;

begin
    for i := componentCount - 1 downto 0 do
    with components[i] do
    begin
        if GetPropInfo(ClassInfo, ´font´) <> nil then
        font.size := (NewFormWidth DIV OldFormWidth) * font.size;
    end;
end;


//Esta é a maneira longa de fazer a mesma coisa

var

i:integer;

p:PPropInfo;

begin
    for i := componentCount - 1 downto 0 do
    with components [i] do
    begin
        p := GetPropInfo (ClassInfo, ´font´);
        if assigned (p) then
        font.size := (NewFormWidth DIV OldFormWidth) * font.size;
    end;
end;

Atenção: Nem todos os objetos tem a propriedade FONT. Isso deve ser o suficiente para você começar.

Atenção: A seguir, algumas dicas para ter em mente quando representar aplicações Delphi (formulários) em diferentes resoluções
de Tela:

* Decida antecipadamente, na etapa de criação do formulário, se ele será escalável ou não. A vantagem de um não escalável é
que nada muda em tempo de execução. A desvantagem é equivalente (seu formulário pode ser muito pequeno ou grande para
alguns sistemas se não for usada escala).

* Se você não for usar formulário escalável, configure o set scaled to False.

* Ou então, configure a propriedade scaled do formulário para True.

* Configure a propriedade AutoScroll para False. AutoScroll = True quer dizer "não mexa no tamanho do frame do formulário em
tempo de execução", o que não parece bom quando o conteúdo do formulário muda de tamanho.

* Configure a fonte do formulário para uma True Type escalável, como a Arial MS. San Serif é uma boa alternativa, mas lembre que
ainda é uma fonte bitmapped. Só a Arial dará uma fonte dentro de um pixel da altura desejada.ATENÇÃO: Se a fonte usada em
uma aplicação não estiver instalada no computador, o Windows selecionará uma fonte alternativa da mesma família para utilizar. O
tamanho dessa fonte pode não corresponder ao da fonte original, podendo causar problemas.

* Configure a propriedade position do formulário para uma opção diferente de poDesigned. poDesigned deixa o formulário onde você
o deixou ( no design Time), o que sempre termina fora da margem, à esquerda da minha tela 1280 x 1024 - e completamente fora
da tela 640 x 480.

* Não amontoe controles no formulário - deixe pelo menos 4 pixels entre else, para que uma mudança de um pixel nas margens
(devido a apresentação em escala) não mostre controles sobrepostos.

* Para labels de uma linha alinhadas à esquerda ou à direita, configure o AutoSize para True. Para outras formas de alinhamento
configure o AutoSize para False.

* Tenha certeza de que há espaço em branco suficiente num componente de labels para alterações no tamanho da fonte - um
espaço de 25% do comprimento da linha de caracteres mostrada é um pouco a mais do que se precisa, mas é mais seguro.
(Você vai precisar de um espaço equivalente a 30% de espansão para string labels se você pretende traduzir sua aplicação para
outra linguagem). Se o Autosize estiver em False, tenha certeza de que realmente configurou o tamanho do label corretamente.
Se o Autosize estiver em True, esteja certo de que há espaço suficiente para que o label se amplie.

* Em labels de múltiplas linhas ou de termos ocultos, deixe pelo menos uma linha em branco na base. Isso vai ser necessário
para incluir o que estiver sobrando quando o texto for oculto de maneira diferente, pela mudança do tamanho da fonte com a
escala. Não assuma isso porque está usando fontes grandes. Você não tem que deixar sobra de texto - as fontes (grandes) de
outros usuários podem ser maiores que as suas!

* Tenha cuidado quando abrir um projeto em IDEs com resoluções diferentes. Assim que o formulário for aberto, sua propriedade
Pixel per Inch será moditificada, e gravada para o DFM se você salvar o projeto. É melhor testar a aplicação rodando sozinho, e
editar o formulário em apenas uma resolução. Editar em várias resoluções e tamanhos de fonte provoca problemas de fluxo e
tamanho dos componentes.

*Falando em fluxo de componentes, não represente o formulário em escala muitas vezes, quando estiver sendo criado ou quando
tiver sendo executado. Cada escala introduz erros de roundoff que se acumulam muito rapidamente, uma vez que as coordenadas
são rigorosamente inteiras. Quando valores fracionários forem retirados das origens e tamanhos do controle com cada sucessiva
representação em escala, os controles parecerão deslizar para noroeste e ficar menores. Se você quer deixar seus usuários
representarem o formulários em escala quantas vezes quiserem, comece com um formulário recentemente criado para que erros
de escala não se acumulem.

* Definitivamente, não mexa na propriedade Pixel pre Inch do formulário.

* Em geral, não é necessário criar formulários em uma resolução específica, mas é essencial que você os revise em 640 x 480
com fontes pequenas e/ou grandes, e em alta resolução com fontes pequenas e/ou grandes antes de liberar suas aplicações. Isso
deve ser parte de sua lista de conferência para testar a compatibilidade do sistema regularmente.

* Preste bastante atenção em todos os componentes que são basicamamente TMemo de uma linha - com oTDBLookupCombo. O
controle de edição (multi-linhas) do Windows sempre mostra apenas linhas inteiras de texto. Se o controle for muito curto para
sua fonte, um TMemo não mostrará coisa alguma, e um TEdit mostrará um pedaço do texto. É melhor fazer esses componentes
um pouco maiores do que deixá-los um pixel menores e não aparecer nada do texto.

 * Tenha em mente que toda representação em escala é proporcional à diferença da altura da fonte entre o modo de execução e o
modo de desenho, NÃO à resolução ou ao tamanho do monitor. Lembre também que as origens dos seus controles serão
alteradas quando o formulário for representado em escala. Você não pode aumentar componentes muito bem sem também
movê-los um pouco, novamente.



===============================================
Versão do 2 do documento.
===============================================



Ajustando o Formulário a resoluções de vídeo diferentes
procedure AjustaForm;
{Manter a janela no tamanho normal independente da resolução de vídeo}
//Declarar dentro do Type do Formulário e chamar a partir do evento Create do Form
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



Ajustando o Formulário a resoluções de vídeo diferentes (2)
Quando criamos formulários, as vezes é útil escrever um código para que a tela e todos os seus objetos sejam mostrados no mesmo tamanho, não importando qual a resolução da tela. Aqui esta um código que mostra como isso é feito:

Implementation
const
ScreenWidth: LongInt = 800; {I designed my form in 800x600 mode.}
ScreenHeight: LongInt = 600;

{$R *.DFM}

procedure TForm1.FormCreate (Sender: Tobject);
begin
    scaled := true;
    if (screen.width <> ScreenWidth) then
    begin
        height := longint(height) * longint(screen.height) DIV ScreenHeight;
        width := longint(width) * longint(screen.width) DIV ScreenWidth;
        scaleBy(screen.width, ScreenWidth);
    end;
end;

Agora, você vai querer checar, se o tamanho dos fontes(de letra) estão OK. Antes de trocar o tamanho da fonte, você precisará ter certeza de que o objeto realmente tem a propriedade fonte pela checagem da RTTI. Isso pode ser feito assim:

USES tyinfo;
ou
USES typinfo;

var
i:integer;
begin
    for i := componentCount - 1 downto 0 do
    with components[i] do
       begin
           if GetPropInfo(ClassInfo, 'font') <> nil then
              font.size := (NewFormWidth DIV OldFormWidth) * font.size;
     end;
end;

Esta é a maneira longa de fazer a mesma coisa:

var
i:integer;
p:PPropInfo;
begin
    for i := componentCount - 1 downto 0 do
    with components [i] do
       begin
           p := GetPropInfo (ClassInfo, 'font');
           if assigned (p) then
              font.size := (NewFormWidth DIV OldFormWidth) * font.size;
     end;
end;

Atenção: Nem todos os objetos tem a propriedade FONT. Isso deve ser o suficiente para você começar.
Atenção: A seguir, algumas dicas para ter em mente quando representar aplicações Delphi (formulários) em diferentes resoluções de Tela:

* Decida antecipadamente, na etapa de criação do formulário, se ele será escalável ou não. A vantagem de um não escalável é que nada muda em tempo de execução. A desvantagem é equivalente (seu formulário pode ser muito pequeno ou grande para alguns sistem

* Se você não for usar formulário escalável, configure o set scaled to False.

* Ou então, configure a propriedade scaled do formulário para True.

* Configure a propriedade AutoScroll para False. AutoScroll = True quer dizer "não mexa no tamanho do frame do formulário em tempo de execução", o que não parece bom quando o conteúdo do formulário muda de tamanho.

* Configure a fonte do formulário para uma True Type escalável, como a Verdana MS. San Serif é uma boa alternativa, mas lembre que ainda é uma fonte bitmapped. Só a Verdana dará uma fonte dentro de um pixel da altura desejada. ATENÇÃO: Se a fonte usada em

* Configure a propriedade position do formulário para uma opção diferente de "PoDesigned". PoDesigned deixa o formulário onde você o deixou ( no design Time), o que sempre termina fora da margem, à esquerda da minha tela 1280 x 1024 - e completamente fora

* Não amontoe controles no formulário - deixe pelo menos 4 pixels entre eles, para que uma mudança de um pixel nas margens (devido a apresentação em escala) não mostre controles sobrepostos.

* Para labels, de uma linha alinhada a esquerda ou à direita, configure o AutoSize para True. Para outras formas de alinhamento configure o AutoSize para False.

* Tenha certeza de que há espaço em branco suficiente num componente de labels para alterações no tamanho da fonte - um espaço de 25% do comprimento da linha de caracteres mostrada é um pouco a mais do que se precisa, mas é mais seguro. (Você vai precisar

* Em labels de múltiplas linhas ou de termos ocultos, deixe pelo menos uma linha em branco na base. Isso vai ser necessário para incluir o que estiver sobrando quando o texto for oculto de maneira diferente, pela mudança do tamanho da fonte com a escala.

* Tenha cuidado quando abrir um projeto em IDEs com resoluções diferentes. Assim que o formulário for aberto, sua propriedade Pixel per Inch será moditificada, e gravada para o DFM se você salvar o projeto. É melhor testar a aplicação rodando sozinho, e e

* Falando em fluxo de componentes, não represente o formulário em escala muitas vezes, quando estiver sendo criado ou quando tiver sendo executado. Cada escala introduz erros de roundoff que se acumulam muito rapidamente, uma vez que as coordenadas são ri

* Definitivamente, não mexa na propriedade Pixel pre Inch do formulário.

* Em geral, não é necessário criar formulários em uma resolução específica, mas é essencial que você os revise em 640 x 480 com fontes pequenas e/ou grandes, e em alta resolução com fontes pequenas e/ou grandes antes de liberar suas aplicações. Isso deve

* Preste bastante atenção em todos os componentes que são basicamamente TMemo de uma linha - com oTDBLookupCombo. O controle de edição (multi-linhas) do Windows sempre mostra apenas linhas inteiras de texto. Se o controle for muito curto para sua fonte, u

* Tenha em mente que toda representação em escala é proporcional à diferença da altura da fonte entre o modo de execução e o modo de desenho, NÃO à resolução ou ao tamanho do monitor. Lembre também que as origens dos seus controles serão alteradas quando



Ajustando o Formulário a resoluções de vídeo diferentes (3)
Faça uma chamada a esta rotina no evento OnCreate do formulário

procedure VideoAdjust(Form: TForm);
const
 ScreenWidth: LongInt = 800; // número de pontos usado no desenvolvimento
 ScreenHeight: LongInt = 600; // número de pontos usado no desenvolvimento
var
  i: integer;
begin
with Form do
 begin
  if Screen.Width = ScreenWidth then
     Exit;
  Scaled := true;
  Height := Longint(height) * Longint(Screen.Height) DIV ScreenHeight;
  Width := Longint(Width) * Longint(Screen.Width) DIV ScreenWidth;
  ScaleyBy(Screen.Width, ScreenWidth);

// O tamanho da fonte dos objetos que tem essa propriedade deverá ser ajustado
// Para usar GetPropInfo, deverá ser adicionado Uses TypInfo.
  for i := ComponentCount - 1 downto 0 do
    with components[i] do
       if GetPropInfo(ClassInfo, 'font') <> nil then
          Font.Size := (NewFormWidth DIV OldFormWidth) * Font.Size;
 end; // with
end; // VideoAdjust
}
*)

