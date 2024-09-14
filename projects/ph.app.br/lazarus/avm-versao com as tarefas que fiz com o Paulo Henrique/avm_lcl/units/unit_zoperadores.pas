unit unit_ZOperadores;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLProc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, DBGrids
  ,unit_formdock, unit_XOperadores
  ;

type

  { TZOperadores }

  TZOperadores = class(Tformdock)
    DBGrid1: TDBGrid;
  private
    { private declarations }
  public
    { public declarations }


  public class function CreateSimpleForm(aName, Title: string; NewBounds: TRect;  aDisableAutoSizing: boolean): Tformdock;
  end; 

var
  ZOperadores: TZOperadores;


implementation


{$R *.lfm}


class function TZOperadores.CreateSimpleForm(aName, Title: string;  NewBounds: TRect; aDisableAutoSizing: boolean): Tformdock;
begin
  // primeiro verifica se o formulário já existe
  // a Tela LCL possui uma lista de todos os formulários existentes.
  // Nota: Lembre-se que a LCL permite como nomes de formulários apenas padrões
  // identificadores pascal e os compara sem diferenciar maiúsculas de minúsculas
  Result:=Tformdock(Screen.FindForm(aName));
  if Result is Tformdock then begin
    if aDisableAutoSizing then
      Result.DisableAutoSizing;
    exit;
  end;

  // create it
  Result:=Tformdock(Tformdock.NewInstance);
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

