{ <description>

  Copyright (c) <year> <copyright holders>

  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to
  deal in the Software without restriction, including without limitation the
  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
  sell copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:

  The above copyright notice and this permission notice shall be included in
  all copies or substantial portions of the Software.

  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
  IN THE SOFTWARE.
}

//{$M StackSize,HeapSize}
//{$M 65535,65535}
program mi.rtl.tests;
{:< - O programa **@name** é usado para compilar as units com as rotina de acesso aos sistemas operacionais win32, win64 e linux.

   - Unit **mi.rtl.Types** contém  todos os tipos da classe TFiles usados pelo pacote mi.rtl;
   - Unit **mi.rtl.consts** contém  todas as contantes da classe TFiles usados pelo pacote mi.rtl;
   - Unit **mi.rtl.files** contém as funções de acesso a arquivo usadas pelo projeto MarIcarai.

- **VERSÃO**:
  - Alpha - 0.7.1

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/rtl.pas">rtl.pas</a>)

  - **REFERÊNCIAS**
    - [Página de código](https://www.freepascal.org/docs-html/rtl/system/defaultfilesystemcodepage.html)
    - [Pandoc Conversor universal de documentos](https://pandoc.org/)
    - [TFPHTMLModule - é igual a TpagePriduce do delphi](https://wiki.freepascal.org/fpWeb_Tutorial#Architecture_.28PLEASE_read.29)



}



{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
//  cp8859_1,
  sysUtils,
  Forms, sdflaz, lazcontrols,
  drivers,
  LCLIntf,
  dialogs,
  dos,
  Mi_ui_mi_msgBox_dm
  , unit1
  ;

{$R *.res}



begin
  //gerar relatório de vazamento de memória
  //ReportMemoryLeaksOnShutdown := True;

  RequireDerivedFormResource:=True;
  Application.Title:='mi.rtl';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TMi_ui_mi_msgBox, Mi_ui_mi_msgBox);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.

//# Gera documento de todos os arquivo .pas da pasta ./units
//pasdoc --markdown --output=./doc `find ./units/ -iname '*.pas'`





