//https://wiki.freepascal.org/IDE_Window:_ToDo_List

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
  - Alpha - 1.0.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/rtl.pas">rtl.pas</a>)

  - **REFERÊNCIAS**
    - [Página de código](https://www.freepascal.org/docs-html/rtl/system/defaultfilesystemcodepage.html)
    - [Pandoc Conversor universal de documentos](https://pandoc.org/)
    - [TFPHTMLModule - é igual a TpagePriduce do Delphi](https://wiki.freepascal.org/fpWeb_Tutorial#Architecture_.28PLEASE_read.29)
}


{$mode Delphi}{$H+}
{$macro on}


uses
  {$IFDEF UNIX}
  cthreads,
   baseunix,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces //Note: this, includes the LCL widgetset
  ,sysutils
//  ,Forms
  ,fpJson
  ,unit1
  ,mi.rtl.Objectss{$define Obj := mi.rtl.Objectss}
  ,mi.rtl.all
  ,Forms, unit2
  //,uMi_lcl_Application
  ;

{$R *.res}

//procedure SomeName;
//begin
//  Writeln('Name is ', {$I %CURRENTROUTINE%});
//end;

{$MACRO ON }


Procedure InfoDemo;
begin
  Writeln('Name is ', {$I %CURRENTROUTINE%});
  With Obj.TObjectss,TConsts do
  begin
    Writeln ('This program was compiled ',DateCompiler);
    Writeln ('By ',User);
    Writeln ('Compiler version: ',FPC_Version);
    Writeln ('Target CPU: ',FPC_Target);
    Writeln ('HOME: ',{$I %HOME%});
  end;
end;


var
  OutputFile: text;


begin
  try
    {$IFOPT D+}
      SetHeapTraceOutput(paramstr(0)+'.trc');
    {$IFEND}
    TMi_rtl.redirectOutput(OutputFile,'output.txt');
    Writeln('Toda escrita para o vídeo foi redirecionada para ./Output.txt');
    InfoDemo;

    //Note: gerar relatório de vazamento de memória
    //Note: ReportMemoryLeaksOnShutdown := True;

    RequireDerivedFormResource:=True;
    //SetRequireDerivedFormResource(True);
    Application.Title:='mi.rtl';
    Application.Scaled:=True;
    Application.Initialize;

    //Application.CreateForm(TDataModule1,DataModule1);
    //FreeAndNil(DataModule1);
    Application.CreateForm(TForm1, Form1);
    Application.Run;

  finally
    Close(OutputFile);
  end;

end.

//# Gera documento de todos os arquivo .pas da pasta ./units
//pasdoc --markdown --output=./doc `find ./units/ -iname '*.pas'`





