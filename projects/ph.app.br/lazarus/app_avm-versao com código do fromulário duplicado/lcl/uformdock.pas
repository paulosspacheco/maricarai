unit uformdock;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls
  ,uform_default;

type

  { TFormDock }

  TFormDock = class(Tform_default)
      procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
//      procedure FormPaint(Sender: TObject);
    public class function GetForm(InstanceClass: TComponentClass;aName: string; aDisableAutoSizing: boolean): TFormDock;
//    public class function CreateSimpleForm(aName, Title: string; NewBounds: TRect;  aDisableAutoSizing: boolean): TFormDock;
    public destructor Destroy;override;
  end;

var
  FormDock: TFormDock;

implementation

{$R *.lfm}

{ TFormDock }


procedure TFormDock.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  inherited;
  ShowMessage('TFormDock.FormClose');
end;

class function TFormDock.GetForm(InstanceClass: TComponentClass;  aName: string; aDisableAutoSizing: boolean): TFormDock;
  var
    Instance: TComponent;
    ok : boolean;

begin
  // primeiro verifica se o formulário já existe
  // a Tela LCL possui uma lista de todos os formulários existentes.
  // Nota: Lembre-se que a LCL permite como nomes de formulários apenas padrões
  // identificadores pascal e os compara sem diferenciar maiúsculas de minúsculas
  Result := TFormDock(Screen.FindForm(aName));
  if Result is TFormDock then
  begin
    if aDisableAutoSizing
    then  Result.DisableAutoSizing;
    exit;
  end;

  // Aloca a instância, sem chamar o construtor
  Instance := TComponent(InstanceClass.NewInstance);

  // define a Referência antes do construtor ser chamado, para que
  // eventos e construtores podem fazer referência a ele
   TComponent(result) := Instance;
   Result.DisableAutoSizing;

  ok:=false;
  try
    Instance.Create(Application);
    ok:=true;
    Instance.Name:=aName;

    if not aDisableAutoSizing
    then result.EnableAutoSizing;

  finally
    if not ok then begin
      TComponent(result) := nil;
    end;
  end;

end;


destructor TFormDock.Destroy;
begin
  inherited Destroy;
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

