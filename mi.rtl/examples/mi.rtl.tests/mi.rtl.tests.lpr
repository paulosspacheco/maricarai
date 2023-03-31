//{$M StackSize,HeapSize}
//{$M 65535,65535}
program mi.rtl.tests;
{:< - O programa **@name** é usado para compilar as units com as rotina de acesso aos sistemas operacionais win32, win64 e linux.

   - Unit **mi.rtl.Types** contém  todos os tipos da classe TFiles usados pelo pacote mi.rtl;
   - Unit **mi.rtl.consts** contém  todas as contantes da classe TFiles usados pelo pacote mi.rtl;
   - Unit **mi.rtl.files** contém as funções de acesso a arquivo usadas pelo projeto MarIcarai.

- **VERSÃO**:
  - lpha - 0.5.0.687

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





