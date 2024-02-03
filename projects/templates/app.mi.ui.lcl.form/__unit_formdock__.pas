unit __Unit_FormDock__;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { T__FormDock__ }

  T__FormDock__ = class(TForm)
//      procedure FormPaint(Sender: TObject);
    public class function GetForm(InstanceClass: TComponentClass;aName: string; aDisableAutoSizing: boolean): T__FormDock__;
  end;

var
  __FormDock__: T__FormDock__;

implementation

{$R *.lfm}

{ T__FormDock__ }



class function T__FormDock__.GetForm(InstanceClass: TComponentClass;  aName: string; aDisableAutoSizing: boolean): T__FormDock__;
  var
    Instance: TComponent;
    ok : boolean;

begin
  // primeiro verifica se o formulário já existe
  // a Tela LCL possui uma lista de todos os formulários existentes.
  // Nota: Lembre-se que a LCL permite como nomes de formulários apenas padrões
  // identificadores pascal e os compara sem diferenciar maiúsculas de minúsculas
  Result := T__FormDock__(Screen.FindForm(aName));
  if Result is T__FormDock__ then
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

//procedure T__FormDock__.FormPaint(Sender: TObject);
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

