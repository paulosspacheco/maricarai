// Para manter a compatibilidade de fonts com o windows instalar pacote:
// sudo apt-get install msttcorefonts
// Site: https://linuxhint.com/ttf-mscorefonts-installer/

program project1;
{:< O programa **@name** é usado para testar o pacote mi.db configurado para gerar
    código para: win32, win64 e linux.

  - **VERSÃO**:
    - Alpha - 1.0.0

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
  Interfaces // this includes the LCL widgetset
  //Forms,
  ,uMi_lcl_Application
//  ,mi.rtl.all

  ,unit1
  ,unit2
  { you can add units after this };

{$R *.res}

begin
  //RequireDerivedFormResource:=True;
  SetRequireDerivedFormResource(True);
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);

  Application.Run;
end.

