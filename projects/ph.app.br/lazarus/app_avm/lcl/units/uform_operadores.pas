unit uform_operadores;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, uform_table
  ;

type

  { Tform_operadores }

  Tform_operadores = class(Tform_table)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

//var
//  form_operadores: Tform_operadores;

implementation

{$R *.lfm}

{ Tform_operadores }

procedure Tform_operadores.Button1Click(Sender: TObject);
  Var
   Id : string;
begin
  id := dm_table.ReturnMaxPKey('operadores','id',1);
  dm_table.DmxScroller_Form1.ShowMessage('Proxímo número = '+id);
end;

end.

