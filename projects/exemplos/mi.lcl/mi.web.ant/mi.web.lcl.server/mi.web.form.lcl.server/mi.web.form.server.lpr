program mi.web.form.server;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  //Forms,
  sysutils,
  Mi.lcl.Application
  ,form.server
  ,u_datamodule1
//  ,u_fpwebmodule1
//  ,uUsuarioController
  ,mi.rtl.all
  ,mi.rtl.webmodule.base
  ,mi.rtl.web.module
  ,mi.rtl.web.module.form
  ,form.main, unit1;
{$R *.res}


var
  OutputFile: TextFile;
//  const chTest = ^3;
  var  s : string;
begin
  try
    {$IFOPT D+}
      SetHeapTraceOutput(paramstr(0)+'.trc');
    {$IFEND}
    TMi_rtl.redirectOutput(OutputFile,'output.txt');

    TMi_Rtl.Print_info_compile;
  //    writeLn(ord(chTest));

    //RequireDerivedFormResource:=True;
    SetRequireDerivedFormResource(True);
    Application.Scaled:=True;
    Application.Initialize;

    with mi_lcl_application,ParamExecucao do
     PathRaiz:= '/home/paulosspacheco/maricarai-trunk/projects/exemplos/mi.lcl/mi.web/mi.web.lcl.server/mi.web.form.lcl.server';

    Application.CreateForm(TFormMain, FormMain);


    Application.Run;

  finally
    Close(OutputFile);
  end;
end.

