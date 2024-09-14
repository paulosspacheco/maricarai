program project1;
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

{$mode delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,   //CMem,https://www.freepascal.org/docs-html/rtl/cmem/index.html
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces
  ,SysUtils
//  ,Forms
  ,uMi_lcl_Application
  ,unit1
  ,mi.rtl.all
  ;
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

    TMi_Rtl.InfoDemo;
//    writeLn(ord(chTest));

    //RequireDerivedFormResource:=True;
    SetRequireDerivedFormResource(True);
    Application.Scaled:=True;
    Application.Initialize;

//     Application.CreateForm(TDataModule1, DataModule1);
    Application.CreateForm(TForm1, Form1);

    Application.Run;

  finally
    Close(OutputFile);
  end;

end.





