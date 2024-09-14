unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, MaskEdit
  ,Mi.rtl.All
  //,mi.rtl.ui.Dmxscroller.dates
  ,mi.rtl.objects.Methods.dates
  ,DateUtils,StrUtils;


type

  { TForm1 }

  TForm1 = class(TForm)
    Button5: TButton;
    MaskEdit1: TMaskEdit;
    procedure Button5Click(Sender: TObject);

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Button5Click(Sender: TObject);

  Procedure today (Fmt : string);

    Var S : AnsiString;

  begin
    DateTimeToString (S,Fmt,Date);
    Writeln (S);
  end;

  Procedure Print (Fmt : string);

    Var S : AnsiString;

  begin
    TMi_rtl.Logs.info('fmt='+'...');
    TMi_rtl.Logs.info('fmt='+Fmt);

    DateTimeToString (S,Fmt,now);
    Writeln (S);
    TMi_rtl.Logs.info('Print: Valor: '+s);
  end;

  Procedure Print_DateTimeToStr (Mask:  TDates.TMask );
    Var S : AnsiString;

  begin
    with TDates do
    begin
      s := DateTimeToStr(now,Mask);
      TMi_rtl.Logs.info('Print_DateTimeToStr: '+s);

    end;
  end;

  Procedure Print_StrToDateTime(Str:AnsiString;Mask:  TDates.TMask );
    Var
      d:TDateTime;
  begin
    with TDates do
    begin
      d := StrToDateTime(str,Mask);
      str := DateTimeToStr(d,Mask);
      TMi_rtl.Logs.info('Print_StrToDateTime: '+str);
    end;
  end;


  procedure test1;
  begin
    Today ('"Today is "dddd dd mmmm y');
    Today ('"Today is "d mmm yy');
    Today ('"Today is "d/mm/yy');
    Today ('"Today is "yy/mm/dd');
    Today ('"Today is "yyyy/mm/dd');
    //Now ('''The time is ''am/pmh:n:s');
    //Now ('''The time is ''hh:nn:ssam/pm');
    //Now ('''The time is ''tt');
  end;


  //function GetCompileDateTime: TdateTime;
  //begin
  //  Result := ScanDateTime('YYYYMMDD hhnnss', DelChars(DelChars(GetCompiledDate, '/'), ':'));
  //end;

Begin
 with TDates do
 begin
   TMi_rtl.Logs.info('Mask: '+Mask_to_MaskDateTime(TMask.Mask_yy_mm_dd));
   Print(Mask_to_MaskDateTime(TMask.Mask_yy_mm_dd));
   Print_DateTimeToStr(TMask.Mask_yy_mm_dd);
   Print_StrToDateTime('24/03/28',TMask.Mask_yy_mm_dd);

   Print(Mask_to_MaskDateTime(TMask.Mask_dd_mm_yy));
   Print_DateTimeToStr(TMask.Mask_dd_mm_yy);
   Print_StrToDateTime('28/03/24',TMask.Mask_dd_mm_yy);

   Print(Mask_to_MaskDateTime(TMask.Mask_dd_mm_yyyy));
   Print_DateTimeToStr(TMask.Mask_dd_mm_yyyy);
   Print_StrToDateTime('28/03/2024',TMask.Mask_dd_mm_yyyy);

   Print(Mask_to_MaskDateTime(TMask.Mask_yyyy_mm_dd));
   Print_DateTimeToStr(TMask.Mask_yyyy_mm_dd);
   Print_StrToDateTime('2024/03/28',TMask.Mask_yyyy_mm_dd);

   Print(Mask_to_MaskDateTime(TMask.Mask_mm_yy));
   Print_DateTimeToStr(TMask.Mask_mm_yy);
//    Print_StrToDateTime('03/24',Mask_mm_yy);Não é data válida

   Print(Mask_to_MaskDateTime(TMask.Mask_mm_yyyy));
   Print_DateTimeToStr(TMask.Mask_mm_yyyy);
   //Print_StrToDateTime('03/2024',Mask_mm_yyyy);  Não é data válida


   Print(Mask_to_MaskDateTime(TMask.Mask_dd_mm_yy_hh_nn_ss));
   Print_DateTimeToStr(TMask.Mask_dd_mm_yy_hh_nn_ss);
   Print_StrToDateTime('28/03/24 17:11:59',TMask.Mask_dd_mm_yy_hh_nn_ss);


   Print(Mask_to_MaskDateTime(TMask.Mask_dd_mm_yy_hh_nn));
   Print_DateTimeToStr(TMask.Mask_dd_mm_yy_hh_nn);
   Print_StrToDateTime('28/03/24 17:11',TMask.Mask_dd_mm_yy_hh_nn);

   Print(Mask_to_MaskDateTime(TMask.Mask_dd_mm_yyyy_hh_nn_ss));
   Print_DateTimeToStr(TMask.Mask_dd_mm_yyyy_hh_nn_ss);

   Print_StrToDateTime('28/03/24 17:11:59.999',TMask.Mask_hh_nn_ss_zzz);



   Print(Mask_to_MaskDateTime(TMask.Mask_hh_nn ));
   Print_DateTimeToStr(TMask.Mask_hh_nn );
   Print_StrToDateTime('17:11',TMask.Mask_hh_nn );

   Print(Mask_to_MaskDateTime(TMask.Mask_hh_nn_ss));
   Print_DateTimeToStr(TMask.Mask_hh_nn_ss);
   Print_StrToDateTime('17:11:59',TMask.Mask_hh_nn_ss);

   Print(Mask_to_MaskDateTime(TMask.Mask_hh_nn_ss_zzz ));
   Print_DateTimeToStr(TMask.Mask_hh_nn_ss_zzz );
//    Print_StrToDateTime('17:48:25:742',Mask_hh_nn_ss_zzz_DateTime ); Não é válido.


   Print(Mask_to_MaskDateTime(TMask.Mask_Extenco));
   Print_DateTimeToStr(TMask.Mask_Extenco );
   Print_StrToDateTime('28/03/2024',TMask.Mask_Extenco );

   ShowMessage('As infromações foram gravadas no arquivo de log test_time.log.');
 end;

End;

end.

