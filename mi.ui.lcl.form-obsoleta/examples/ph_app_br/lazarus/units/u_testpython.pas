unit u_testpython;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs,PythonEngine;

type

  { TForm1 }

  TForm1 = class(TForm)
    PythonEngine1:TPythonEngine;
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

end.

