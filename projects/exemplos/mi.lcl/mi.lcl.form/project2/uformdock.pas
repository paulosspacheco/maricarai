unit uformdock;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls
  ,AnchorDocking,uform_default;

type

  { TFormDock }

  TFormDock = class(Tform_default)
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

    public class function GetForm(TheOwner: TComponent;InstanceClass: TComponentClass;aName: string; aDisableAutoSizing: boolean): TFormDock;
  end;

var
  FormDock: TFormDock;

implementation

{$R *.lfm}

{ TFormDock }
class function TFormDock.GetForm(TheOwner: TComponent;InstanceClass: TComponentClass; aName: string; aDisableAutoSizing: boolean): TFormDock;
  var
    FormDock : TFormDock;
    ok: boolean;
begin
  // Verifica se o formulário já existe
  Result := TFormDock(Screen.FindForm(aName));
  if Result is TFormDock then
  begin //Se existe livra-o
    (Result as TFormDock).visible := false;
    (Result as TFormDock).free;
  end;
  //if Result is TFormDock then
  //begin Se existir desabilita autosize e retorna
  //  if aDisableAutoSizing then
  //    Result.DisableAutoSizing;
  //  exit;
  //end;

  // Aloca a instância, sem chamar o construtor
  FormDock := TFormDock(InstanceClass.NewInstance);
  // Define a referência antes do construtor ser chamado
  TFormDock(Result) := FormDock;
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

procedure TFormDock.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  Visible := false;
  CloseAction:=caFree;
end;

//procedure TFormDock.HandleDockClose(Sender: TObject);
//begin
//  Close; // Fecha o formulário quando o DockHostSite tenta fechar
//end;

procedure TFormDock.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  inherited FormCloseQuery(Sender,CanClose);
end;





//procedure TFormDock.FormPaint(Sender: TObject);
//begin
//  with Canvas do begin
//    Pen.Color:=clRed;
//    MoveTo(0,0);
//    LineTo(ClientWidth-1,0);
//    MoveTo(ClientWidth-1,ClientHeight-1);
//    MoveTo(0,ClientHeight-1);
//    MoveTo(0,0);
//    MoveTo(ClientWidth-1,ClientHeight-1);
//  end;
//end;

end.

