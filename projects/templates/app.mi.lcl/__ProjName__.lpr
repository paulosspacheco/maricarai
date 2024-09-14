program __ProjName__;
{:< O projeto **@name** é usado como modelo para projetos que usam o pacote
    **mi.rtl** e pacote **mi.lcl** configurado para 3 alvos, sendo **linux**,
     **i386-win32**, **x86_64-win64** e um formulário **Unit1** para demonstração
     do uso da unit

- **Notas**:
  - Este projeto depende dos seguintes pacotes:
    - mi.rtl
    - LCL;
    - mi.lcl

- **Versão atual - @name**

  - Data em que esta versão foi criada: 01/08/2024
  - Versão atual: 0.99.0
  - Versão do Free Pascal: 3.2.2
  - Versão do Lazarus: Lazarus_fixe-3.99

- **Descrição das tarefas a fazer em @name**

- **01/08/2024**  a  **02/08/2024**
  - [] Criar projeto @name**
  - [] Documentar projeto
}

  {$mode Delphi}{$H+}

  uses
    {$IFDEF UNIX}
    cthreads,
    {$ENDIF}
    {$IFDEF HASAMIGA}
    athreads,
    {$ENDIF}
    Interfaces // this includes the LCL widgetset
    ,mi.lcl.application
    ,uCustomForm1
    ,mi.rtl.all
    ,uCustomDataMudule
    ,uCustomMiConnectionsDb
    ,uTable_Json
    ,u__dm_xtable__
    ;

{$R *.res}

  var
    OutputFile: TextFile;
  var
    Table_Json_form: TCustomForm1;
    __dm_xtable__form: TCustomForm1;

begin
  try
    {$IFOPT D+}
   //   SetHeapTraceOutput(paramstr(0)+'.trc');
    {$ENDIF}
    TMi_rtl.redirectOutput(OutputFile,'output.txt');
    TMi_Rtl.Print_info_compile;
    SetRequireDerivedFormResource(True);
    Application.Scaled:=True;
   // Application.MainFormOnTaskbar:=True;
    Application.Initialize;

    TMi_rtl.ShowMessage('Modelo de uma aplicação maricarai configurado para gerar código para linux64, win32 e win64...');

    Application.CreateForm(TTable_Json, Table_Json);
    Application.CreateForm(T__dm_xtable__, __dm_xtable__);

    Application.CreateForm(TCustomForm1, Table_Json_form);
    Table_Json_form.SetDataModule(Table_Json,true);
    Table_Json_form.Show;

    Application.CreateForm(TCustomForm1, __dm_xtable__form);
    __dm_xtable__form.SetDataModule(__dm_xtable__,false);
    __dm_xtable__form.Show;

    Application.Run;

  finally
    Close(OutputFile);
  end;

end.

