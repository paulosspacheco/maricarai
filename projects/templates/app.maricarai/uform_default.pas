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
    , ExtCtrls,LCLType//,Messages
    ,TypInfo
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

  Protected procedure AjustaForm;
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
procedure Tform_default.Action1Execute(Sender: TObject);
begin
  ShowMessage('action 1');
end;

procedure Tform_default.FormClose(Sender: TObject; var CloseAction: TCloseAction  );
begin
  Visible := false;
  CloseAction:=caFree;
end;

procedure Tform_default.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := True; // Permite que o formulário seja fechado
  Visible := false;
end;

procedure Tform_default.ApplicationEvents1Hint(Sender: TObject);
begin
  //StatusBar1.SimpleText := 'App.OnHint : ' + Application.Hint;
end;

procedure Tform_default.FormPaint(Sender: TObject);
begin
  TMi_lcl_ui_Form.Apply_Rounded_Corners(self,13,13);
end;

constructor Tform_default.Create(TheOwner: TComponent);
begin
  inherited Create(TheOwner);
  miHint := TMenuItemHint.Create(self);
//  AjustaForm;
    //with TMi_rtl.THtml_tags do
    //  self.Color := HTMLToTColor(HColor_BG_Nav);

  //  self.Color := TMi_rtl.HTMLToTColor('#85C1E9');
  // self.Color := TMi_rtl.HTMLToTColor(HColor_Help);

   //with TMi_rtl.THtml_tags do
   //  self.Font.Color := HTMLToTColor(HColor_Fonts_Azul);
end;

procedure Tform_default.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  //if key=13 then
  //  Self.SelectNext(ActiveControl, true, true);
  // perform(WM_NEXTDLGCTL,0,0);
end;

procedure Tform_default.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //if Key = #13
  // then begin
  //        Key := #0;
  //        Perform(WM_KeyDown,VK_Tab,0)
  //      end;
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

var
  FAdjusting : Boolean  = False;
procedure Tform_default.AjustaForm;
  //Manter a janela no tamanho normal independente da resolução de vídeo
  //Declarar dentro do Formulário e chamar a partir do evento Create do Form

  procedure AjustaFonts;
    var
      i:integer;
  begin
    for i := componentCount - 1 downto 0 do
    with components[i] do
    begin
      if GetPropInfo(ClassInfo, 'font') <> nil
      then font.size := (Width DIV ScreeWidh_Design) * font.size;
    end;
  end;


Var
  nEscala : Double;
  nPorcento : Integer;
begin
  if not FAdjusting
  Then begin
         FAdjusting := true;
          if ScreeWidh_Design <> Screen.Width
          then begin
                 nEscala := ((Screen.Width-ScreeWidh_Design)/ScreeWidh_Design);
                 nPorcento := Round((nEscala*100) + 100);
                 Width := Round(Width * (nEscala+1));
                 Height := Round(Height * (nEscala+1));
                 ScaleBy(nPorcento,100);
                 AjustaFonts;
               end;
          FAdjusting := false;
       end;
end;


initialization
//  Form_WebBrowser_Hint := TForm_WebBrowser_Hint.Create(nil);

Finalization
  //FreeandNil(Form_WebBrowser_Hint);
end.

