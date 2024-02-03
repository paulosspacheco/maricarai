unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, mi.rtl.Objectss;

type

  { TForm1 }

  TForm1 = class(TForm)
    Objectss1: TObjectss;
    procedure FormCreate(Sender: TObject);
  private
    pagePruduce:TObjectss.TPageProducer;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  pagePruduce:=TObjectss.TPageProducer.create(self);


end;

end.

