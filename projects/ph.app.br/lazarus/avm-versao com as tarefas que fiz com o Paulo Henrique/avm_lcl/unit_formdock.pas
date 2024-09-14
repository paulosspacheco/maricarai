unit unit_formdock;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { Tformdock }

  Tformdock = class(TForm)
//      procedure FormPaint(Sender: TObject);
    public class function GetForm(InstanceClass: TComponentClass;aName: string; aDisableAutoSizing: boolean): Tformdock;
  end;

var
  formdock: Tformdock;

implementation

{$R *.lfm}

{ Tformdock }



class function Tformdock.GetForm(InstanceClass: TComponentClass;  aName: string; aDisableAutoSizing: boolean): Tformdock;
  var
    Instance: TComponent;
    ok : boolean;

begin
  // primeiro verifica se o formulário já existe
  // a Tela LCL possui uma lista de todos os formulários existentes.
  // Nota: Lembre-se que a LCL permite como nomes de formulários apenas padrões
  // identificadores pascal e os compara sem diferenciar maiúsculas de minúsculas
  Result := Tformdock(Screen.FindForm(aName));
  if Result is Tformdock then
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

//procedure Tformdock.FormPaint(Sender: TObject);
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

