/// <since>
///   . Unit usada como base para todos os forms do projeto maricarai.
///   . REQUISITOS:
///        . A visualiza��o de hint flutuante onde o texto � mostrado em uma linha abaixo do item de menu.
/// </since>

unit uForm_Default;

{$MODE Delphi}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Menus
    , ExtCtrls,LCLType//,Messages
    ,TypInfo
    , uMi_lcl_ui_Form
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

  { TForm_Default }

  TForm_Default = class(TForm)
    ApplicationEvents1: TApplicationProperties;
    procedure Action1Execute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure ApplicationEvents1Hint(Sender: TObject);
    procedure FormPaint(Sender: TObject);

    public constructor Create(TheOwner: TComponent); override;
    private
      { Private declarations }
      var miHint : TMenuItemHint;
  //    procedure WMMenuSelect(var Msg: TWMMenuSelect) ; message WM_MENUSELECT;

//    Protected procedure AjustaForm; não funciona

    {: O método **@name** retorna uma formulário da classe passado por instanceClass.

       - **EXEMPLO DE USO**

         ```pascal
             var
               Control : TControl;
            begin
               Control := TCustomForm1.GetForm(Application,TCustomForm1,'Table_Json_form',false);
               Table_Json_form := control as TCustomForm1;
               Table_Json := TTable_Json.Create(Application);
               Table_Json_form.SetDataModule(Table_Json,true);
               Table_Json_form.Show;
            end;

         ```
    }
    public class function GetForm(TheOwner: TComponent;InstanceClass: TComponentClass;
                           aName: string; aDisableAutoSizing: boolean): TForm_Default;
  end;


var
  Form_Default: TForm_Default;


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
  //hideTimer.OnTimer := nil;
  //showTimer.OnTimer := nil;
  FreeAndNil(showTimer);
  FreeAndNil(hideTimer);
  self.ReleaseHandle;
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
procedure TForm_Default.Action1Execute(Sender: TObject);
begin
  ShowMessage('action 1');
end;

procedure TForm_Default.FormClose(Sender: TObject; var CloseAction: TCloseAction  );
begin
  Visible := false;
  CloseAction:=caFree;
end;

procedure TForm_Default.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True; // Permite que o formulário seja fechado
  Visible := false;
end;

procedure TForm_Default.ApplicationEvents1Hint(Sender: TObject);
begin
  //StatusBar1.SimpleText := 'App.OnHint : ' + Application.Hint;
end;

procedure TForm_Default.FormPaint(Sender: TObject);
begin
  TMi_lcl_ui_Form.Apply_Rounded_Corners(self,13,13);
end;

constructor TForm_Default.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  miHint := TMenuItemHint.Create(self);
  //AjustaForm;não funciona
    //with TMi_rtl.THtml_tags do
    //  self.Color := HTMLToTColor(HColor_BG_Nav);

  //  self.Color := TMi_rtl.HTMLToTColor('#85C1E9');
  // self.Color := TMi_rtl.HTMLToTColor(HColor_Help);

   //with TMi_rtl.THtml_tags do
   //  self.Font.Color := HTMLToTColor(HColor_Fonts_Azul);
end;

procedure TForm_Default.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //if key=13 then
  //  Self.SelectNext(ActiveControl, true, true);
  // perform(WM_NEXTDLGCTL,0,0);
end;

procedure TForm_Default.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //if Key = #13
  // then begin
  //        Key := #0;
  //        Perform(WM_KeyDown,VK_Tab,0)
  //      end;
end;

//procedure TForm_Default.WMMenuSelect(var Msg: TWMMenuSelect) ;
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

//var
//  FAdjusting : Boolean  = False;
//procedure TForm_Default.AjustaForm;
//  //Manter a janela no tamanho normal independente da resolução de vídeo
//  //Declarar dentro do Formulário e chamar a partir do evento Create do Form
//
//  procedure AjustaFonts;
//    var
//      i:integer;
//  begin
//    for i := componentCount - 1 downto 0 do
//    with components[i] do
//    begin
//      if GetPropInfo(ClassInfo, 'font') <> nil
//      then font.size := (Width DIV ScreeWidh_Design) * font.size;
//    end;
//  end;
//
//
//Var
//  nEscala : Double;
//  nPorcento : Integer;
//begin
//  if not FAdjusting
//  Then begin
//         FAdjusting := true;
//          if ScreeWidh_Design <> Screen.Width
//          then begin
//                 nEscala := ((Screen.Width-ScreeWidh_Design)/ScreeWidh_Design);
//                 nPorcento := Round((nEscala*100) + 100);
//                 Width := Round(Width * (nEscala+1));
//                 Height := Round(Height * (nEscala+1));
//                 ScaleBy(nPorcento,100);
//                 AjustaFonts;
//               end;
//          FAdjusting := false;
//       end;
//end;

class function TForm_Default.GetForm(TheOwner: TComponent;
                                     InstanceClass: TComponentClass;
                                     aName: string; aDisableAutoSizing: boolean): TForm_Default;
var
  Form_Default : TForm_Default;
  ok: boolean;
begin
  // Verifica se o formulário já existe
  Result := TForm_Default(Screen.FindForm(aName));
  if Result is TForm_Default then
  begin //Se existe livra-o
    (Result as TForm_Default).visible := false;
    (Result as TForm_Default).free;
  end;
  //if Result is TForm_Default then
  //begin Se existir desabilita autosize e retorna
  //  if aDisableAutoSizing then
  //    Result.DisableAutoSizing;
  //  exit;
  //end;

  // Aloca a instância, sem chamar o construtor
  Form_Default := TForm_Default(InstanceClass.NewInstance);
  // Define a referência antes do construtor ser chamado
  TForm_Default(Result) := Form_Default;
  Result.DisableAutoSizing;
  ok := false;
  try
    // Aqui você pode definir o dono do formulário,
    // por exemplo, Application ou outro componente
    Result.Create(TheOwner);
    ok := true;
    Result.Name := aName;
    if not aDisableAutoSizing then
      Result.EnableAutoSizing;
  finally
    if not ok then
    begin
      Result := nil;
    end;
  end;
end;


initialization
//  Form_WebBrowser_Hint := TForm_WebBrowser_Hint.Create(nil);

Finalization
  //FreeandNil(Form_WebBrowser_Hint);
end.

