unit __form_xtable_u__;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LCLProc, FileUtil, Forms, Controls, Graphics, Dialogs,
  StdCtrls, ExtCtrls
  ,__Unit_FormDock__
  ;

type

  { T__form_xtable__ }

  T__form_xtable__ = class(T__FormDock__)
  private
    { private declarations }
  public
    { public declarations }


  public class function CreateSimpleForm(aName, Title: string; NewBounds: TRect;  aDisableAutoSizing: boolean): T__FormDock__;
  end; 

var
  __form_xtable__: T__form_xtable__;


implementation


{$R *.lfm}


class function T__form_xtable__.CreateSimpleForm(aName, Title: string;  NewBounds: TRect; aDisableAutoSizing: boolean): T__FormDock__;
begin
  // primeiro verifica se o formulário já existe
  // a Tela LCL possui uma lista de todos os formulários existentes.
  // Nota: Lembre-se que a LCL permite como nomes de formulários apenas padrões
  // identificadores pascal e os compara sem diferenciar maiúsculas de minúsculas
  Result:=T__FormDock__(Screen.FindForm(aName));
  if Result is T__FormDock__ then begin
    if aDisableAutoSizing then
      Result.DisableAutoSizing;
    exit;
  end;

  // create it
  Result:=T__FormDock__(T__FormDock__.NewInstance);
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

