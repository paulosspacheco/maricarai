// Para manter a compatibilidade de fonts com o windows instalar pacote:
// sudo apt-get install msttcorefonts
// Site: https://linuxhint.com/ttf-mscorefonts-installer/

program mi.lcl.ds.form.test;
{:< O programa **@name** é usado para testar o pacote mi.rtl.form configurado para gerar
    código para: win32, win64 e linux.

  - **VERSÃO**:
    - Alpha - 1.0.0

  - Instalação do Lazarus
    - [Manual do Usuário criado pelo: gladiston](https://gladiston.net.br/programacao/lazarus-ide/)
    - [Instalar as fontes da Microsot para compatibilidade com o windows](https://linuxhint.com/ttf-mscorefonts-installer/)
}

{$mode delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,   //CMem,https://www.freepascal.org/docs-html/rtl/cmem/index.html
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, sdflaz // this includes the LCL widgetset
  ,SysUtils
//  ,Forms
  ,Mi.lcl.Application
  , form.Main
  , Data.Module.Exemplo
  ,mi.rtl.all, mi.rtl.webmodule.custom
  , Mi.rtl.WebModule.Custom1, form.exe01.frame, form.Exe02;
{$R *.res}

  var
    OutputFile: TextFile;

//  const chTest = ^3;
begin
  try
    {$IFOPT D+}
      SetHeapTraceOutput(paramstr(0)+'.trc');
    {$IFEND}
    TMi_rtl.redirectOutput(OutputFile,'output.txt');
    TMi_Rtl.Print_info_compile;
    //RequireDerivedFormResource:=True;
    SetRequireDerivedFormResource(True);
    Application.Scaled:=True;
    Application.Initialize;
    Application.CreateForm(TForm_Main, Form_Main);
    Application.Run;
  finally
    Close(OutputFile);
  end;

end.




