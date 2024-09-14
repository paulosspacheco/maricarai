program send_request;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  //Forms
  uMi_lcl_Application
  ,mi.rtl.all
  ,unit1
  ,unit2, unit3
  { you can add units after this };

{$R *.res}

var
  OutputFile: TextFile;

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

    LocateParamsToJsonTest;

    Application.CreateForm(TForm1, Form1);
    Application.Run;

  finally
    Close(OutputFile);
  end;
end.

