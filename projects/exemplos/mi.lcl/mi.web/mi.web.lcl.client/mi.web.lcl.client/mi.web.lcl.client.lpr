program mi.web.lcl.client;

{$mode delphi}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  //Forms,
   Mi.lcl.Application.client
  ,form.main
  ,mi.rtl.web.module.form
  ,mi.rtl.all, data.module.client.rest
 ;




{$R *.res}

var
  OutputFile: TextFile;

begin
 // teste;
  try
    {$IFOPT D+}
      SetHeapTraceOutput(paramstr(0)+'.trc');
    {$IFEND}
    TMi_rtl.redirectOutput(OutputFile,'output.txt');
    TMi_Rtl.Print_info_compile;
    SetRequireDerivedFormResource(True);
    Application.Scaled:=True;
    Application.Initialize;
    Application.CreateForm(TForm_main, Form_main);
    Application.Run;

  finally
    Close(OutputFile);
  end;
end.

