// Para manter a compatibilidade de fonts com o windows instalar pacote:
// sudo apt-get install msttcorefonts
// Site: https://linuxhint.com/ttf-mscorefonts-installer/

program mi.lcl.form.test;
{:< O programa **@name** é usado para testar o pacote mi.rtl.form configurado para gerar
    código para: win32, win64 e linux.

  - **VERSÃO**:
    - Alpha - 0.9.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.ui.tests.pas">mi.ui.tests.pas.pas</a>)

  - Instalação do Lazarus
    - [Manual do Usuário criado pelo: gladiston](https://gladiston.net.br/programacao/lazarus-ide/)
    - [Instalar as fontes da Microsot para compatibilidade com o windows](https://linuxhint.com/ttf-mscorefonts-installer/)
}

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,   //CMem,https://www.freepascal.org/docs-html/rtl/cmem/index.html
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, memdslaz, sdflaz, lazcontrols // this includes the LCL widgetset
// ,Forms
  ,Mi.lcl.Application

//  ,unit1
  ,unit2
  ,unit3
 // ,Mi.rtl.WebModule
  ,mi.rtl.all

  ;

{$R *.res}

var
  OutputFile: TextFile;

begin
  try
    {$IFOPT D+}
     SetHeapTraceOutput(paramstr(0)+'.trc');
    {$ENDIF}
    TMi_rtl.redirectOutput(OutputFile,'output.txt');
    TMi_Rtl.Print_info_compile;
    //RequireDerivedFormResource:=True;
    SetRequireDerivedFormResource(True);
    Application.Scaled:=True;
    Application.Initialize;
    //Application.CreateForm(TDataModule1, DataModule1);
    //DataModule1.free;

    //Application.CreateForm(TMi_rtl_WebModule_Custom, Mi_rtl_WebModule_Custom);
//    Application.CreateForm(TForm1, Form1);
    Application.CreateForm(TForm2, Form2);

    Application.Run;

  finally
    TMi_Rtl.Print_info_compile;
    Close(OutputFile);
  end;
end.

