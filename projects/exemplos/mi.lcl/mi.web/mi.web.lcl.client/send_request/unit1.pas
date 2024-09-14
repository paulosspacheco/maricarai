unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Unit2
  ,fphttpclient, fpjson, jsonparser;





type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;



var
  Form1: TForm1;

implementation

{$R *.lfm}

  { TForm1 }

  procedure TForm1.Button1Click(Sender: TObject);
  begin
    Teste_TdmClientRest;
  end;



end.



