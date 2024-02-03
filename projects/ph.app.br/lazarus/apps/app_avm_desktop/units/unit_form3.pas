unit unit_form3;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLProc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls
  ,unit_FormDock
  ;

type

  { Tform3 }

  Tform3 = class(TFormDock)
    Memo1: TMemo;
  private
    { private declarations }
  public
    { public declarations }


  public class function CreateSimpleForm(aName, Title: string; NewBounds: TRect;  aDisableAutoSizing: boolean): TFormDock;
  end; 

var
  form3: Tform3;


implementation


{$R *.lfm}


class function Tform3.CreateSimpleForm(aName, Title: string;  NewBounds: TRect; aDisableAutoSizing: boolean): TFormDock;
begin
  // primeiro verifica se o formulário já existe
  // a Tela LCL possui uma lista de todos os formulários existentes.
  // Nota: Lembre-se que a LCL permite como nomes de formulários apenas padrões
  // identificadores pascal e os compara sem diferenciar maiúsculas de minúsculas
  Result:=TFormDock(Screen.FindForm(aName));
  if Result is TFormDock then begin
    if aDisableAutoSizing then
      Result.DisableAutoSizing;
    exit;
  end;

  // create it
  Result:=TFormDock(TFormDock.NewInstance);
  Result.DisableAutoSizing;
  Result.Create(Application);
  Result.Caption:=Title;
  Result.Name:=aName;
//  Result.Memo1.Lines.Text:=Name;
  Result.BoundsRect:=NewBounds;
  if not aDisableAutoSizing then
    Result.EnableAutoSizing;
end;


end.

