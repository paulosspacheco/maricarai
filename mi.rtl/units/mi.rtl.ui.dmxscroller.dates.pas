unit mi.rtl.ui.Dmxscroller.dates;
 {:< -A Unit **@name** implementa a classe **TDatesFreePascal**.

    - **VERSÃO**
      - Alpha - 1.0.0

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi.rtl.ui.dmxscroller.dates.pas">mi.rtl.ui.Dmxscroller.dates.pas</a>)


    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
        - **28/03/24 18:322 a 08:00** - Conclui essa unit.

  }

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}


interface
Uses
  Classes,SysUtils,StrUtils
  ;


type
  { TDatesFreePascal  }
  {: A Class **@name** usado para acessar a data e hora usando formato TDateTime.

     - Programa usado para teste da unit

     ```Pascal

         unit Unit1;


         interface

         uses
           Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls
           ,Mi.rtl.All
           ,mi.rtl.ui.Dmxscroller.dates;


         type


           TForm1 = class(TForm)
             Button5: TButton;
             procedure Button5Click(Sender: TObject);

           private

           public

           end;

         var
           Form1: TForm1;

         implementation

         $R *.lfm



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
             TMi_rtl.Logs.info('Print-fmt='+Fmt+' Valor: '+s);
           end;

           Procedure Print_DateTimeToStr (Mask:  TDatesFreePascal.TMask );
             Var S : AnsiString;

           begin
             with TDatesFreePascal do
             begin
               s := DateTimeToStr(now,Mask);
               TMi_rtl.Logs.info('Print_DateTimeToStr: '+s);

             end;
           end;


           Procedure Print_StrToDateTime(Str:AnsiString;Mask:  TDatesFreePascal.TMask );
             Var
               d:TDateTime;
           begin
             with TDatesFreePascal do
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

         Begin

          with TDatesFreePascal do
          begin
            TMi_rtl.Logs.info('Mask: '+Mask_to_MaskDateTime(Mask_yy_mm_dd));
            Print(Mask_to_MaskDateTime(Mask_yy_mm_dd));
            Print_DateTimeToStr(Mask_yy_mm_dd);
            Print_StrToDateTime('24/03/28',Mask_yy_mm_dd);



            Print(Mask_to_MaskDateTime(Mask_dd_mm_yy));
            Print_DateTimeToStr(Mask_dd_mm_yy);
            Print_StrToDateTime('28/03/24',Mask_dd_mm_yy);

            Print(Mask_to_MaskDateTime(Mask_dd_mm_yyyy));
            Print_DateTimeToStr(Mask_dd_mm_yyyy);
            Print_StrToDateTime('28/03/2024',Mask_dd_mm_yyyy);

            Print(Mask_to_MaskDateTime(Mask_yyyy_mm_dd));
            Print_DateTimeToStr(Mask_yyyy_mm_dd);
            Print_StrToDateTime('2024/03/28',Mask_yyyy_mm_dd);

            Print(Mask_to_MaskDateTime(Mask_mm_yy));
            Print_DateTimeToStr(Mask_mm_yy);
         //    Print_StrToDateTime('03/24',Mask_mm_yy);Não é data válida

            Print(Mask_to_MaskDateTime(Mask_mm_yyyy));
            Print_DateTimeToStr(Mask_mm_yyyy);
            //Print_StrToDateTime('03/2024',Mask_mm_yyyy);  Não é data válida


            Print(Mask_to_MaskDateTime(Mask_dd_mm_yy_hh_nn_ss));
            Print_DateTimeToStr(Mask_dd_mm_yy_hh_nn_ss);
            Print_StrToDateTime('28/03/24 17:11:59',Mask_dd_mm_yy_hh_nn_ss);


            Print(Mask_to_MaskDateTime(Mask_dd_mm_yy_hh_nn));
            Print_DateTimeToStr(Mask_dd_mm_yy_hh_nn);
            Print_StrToDateTime('28/03/24 17:11',Mask_dd_mm_yy_hh_nn);

            Print(Mask_to_MaskDateTime(Mask_dd_mm_yyyy_hh_nn_ss));
            Print_DateTimeToStr(Mask_dd_mm_yyyy_hh_nn_ss);
            Print_StrToDateTime('28/03/24 17:11:59',Mask_dd_mm_yyyy_hh_nn_ss);



            Print(Mask_to_MaskDateTime(Mask_hh_nn));
            Print_DateTimeToStr(Mask_hh_nn_DateTime );
            Print_StrToDateTime('17:11',Mask_hh_nn_DateTime );

            Print(Mask_to_MaskDateTime(Mask_hh_nn_ss_DateTime));
            Print_DateTimeToStr(Mask_hh_nn_ss_DateTime);
            Print_StrToDateTime('17:11:59',Mask_hh_nn_ss_DateTime);

            Print(Mask_to_MaskDateTime(Mask_hh_nn_ss_s1000_DateTime ));
            Print_DateTimeToStr(Mask_hh_nn_ss_s1000_DateTime );
         //    Print_StrToDateTime('17:48:25:742',Mask_hh_nn_ss_s1000_DateTime ); Não é válido.
          end;

         End;

         end.


     ```

  }
  TDatesFreePascal = class
    public type SmallWord = System.word;

    {: Esse tipo é usado pelo interpretar o tipo TDateTime}
    public Type TMask = ( Mask_yy_mm_dd,   //00
                          Mask_yyyy_mm_dd, //01
                          Mask_dd_mm_yy,   //02
                          Mask_dd_mm_yyyy, //03
                          Mask_mm_yy,      //04
                          Mask_mm_yyyy,    //05
                          Mask_dd_mm_yy_hh_nn_ss,   //06
                          Mask_dd_mm_yy_hh_nn,      //07
                          Mask_dd_mm_yyyy_hh_nn_ss, //08
                          Mask_hh_nn ,              //09
                          Mask_hh_nn_ss,            //10
                          Mask_hh_nn_ss_zzz,      //11
                          Mask_Extenco,              //12
                          Mask_Invalid              //13
                        );

    {: O método **@name** recebe a mascara definida em aMask e retorna um
       string esperado pelo registro DefaultFormatSettings.
    }
    class function Mask_to_MaskDateTime(const aMask: TMask): AnsiString;

    class function Mask_to_MaskEdit(const aMask: TMask): AnsiString;

    class function MaskEdit_to_Mask(const aMaskEdit: AnsiString): TMask ;

    {: O método **@name** seta o o registro DefaultFormatSettings para a mascara
       definida em Mask e retorna o estado anterior de DefaultFormatSettings.
    }
    class function SetDefaultFormatSettings(Mask: TMask): TFormatSettings;

    class function StrToDateTime(const S: AnsiString;Const Mask: TMask):TDateTime;overload;
    class function StrToDateTime( const S: AnsiString):TDateTime;overload;

    class function DateTimeToStr(d:TDateTime; Mask:  TMask ): AnsiString;overload;
    class function DateTimeToStr(d:TDateTime):AnsiString;Overload;

    class function IsDateTime(const aTemplate: AnsiString): Boolean;
  end;

Implementation



{ TDates }


class function TDatesFreePascal.Mask_to_MaskDateTime(const aMask: TMask): AnsiString;
Begin
  Case aMask of
    Mask_yy_mm_dd       : Result := 'yy/mm/dd';
    Mask_dd_mm_yy       : Result := 'dd/nn/yy';

    Mask_yyyy_mm_dd     : Result := 'yyyy/mm/dd';
    Mask_dd_mm_yyyy     : Result := 'dd/nn/yyyy';

//    Mask_mm_yy          : Result := 'mm/yy';
    Mask_dd_mm_yyyy_hh_nn : Result := 'dd/mm/yyyy hh:nn';

    Mask_mm_yyyy        : Result := 'mm/yyyy';

    Mask_hh_nn        : Result := 'hh:nn';
    Mask_hh_nn_ss     : Result := 'hh:nn:ss';
    Mask_hh_nn_ss_zzz : Result := 'hh:nn:ss.zzz';

    Mask_dd_mm_yy_hh_nn_ss   : Result := 'dd/nn/yy hh:nn:ss';
    Mask_dd_mm_yy_hh_nn      : Result := 'dd/nn/yy hh:nn';
    Mask_dd_mm_yyyy_hh_nn_ss : Result := 'dd/nn/yyyy hh:nn:ss';
    Mask_Extenco         : Result := 'ddd of mmm of yyyy';
    Else Begin
           Result := '';
         End;
  End;
end;

class function TDatesFreePascal.Mask_to_MaskEdit(const aMask: TMask ): AnsiString;
  // O char # usado identificar o ano
  // O campo ano aceita o sinal de  + ou -
begin
  Case aMask of
    Mask_yy_mm_dd            : Result := '##/99/99';
    Mask_dd_mm_yy            : Result := '99/99/##';
    Mask_yyyy_mm_dd          : Result := '####/99/99';
    Mask_dd_mm_yyyy          : Result := '99/99/####';
    Mask_mm_yy               : Result := '99/##';
    Mask_mm_yyyy             : Result := '99/####';
    Mask_Extenco             : Result := 'ssssssssssssssssssssssssss';
    Mask_dd_mm_yy_hh_nn_ss   : Result := 'dd/nn/## hh:nn:ss';
    Mask_dd_mm_yy_hh_nn      : Result := 'dd/nn/## hh:nn';
    Mask_dd_mm_yyyy_hh_nn_ss : Result := 'dd/nn/#### hh:nn:ss';
    Else Begin
           Result := '';
         End;
  End;
end;

class function TDatesFreePascal.MaskEdit_to_Mask(const aMaskEdit: AnsiString ): TMask;
begin
  case AnsiIndexStr(aMaskEdit,['##/99/99',                    //0
                               '99/99/##',                    //1
                               '####/99/99',                  //2
                               '99/99/####',                  //3
                               '99/##',                       //3
                               '99/####',                     //4
                               'ssssssssssssssssssssssssss',  //5
                               'dd/nn/## hh:nn:ss',           //6
                               'dd/nn/## hh:nn',              //7
                               'dd/nn/#### hh:nn:ss'          //9
                              ])
    of
     0 : result := Mask_yy_mm_dd ;
     1 : result := Mask_dd_mm_yy;
     2 : result := Mask_yyyy_mm_dd;
     3 : result := Mask_dd_mm_yyyy;
     4 : result := Mask_mm_yy;
     5 : result := Mask_mm_yyyy;
     6 : result := Mask_Extenco;
     7 : result := Mask_dd_mm_yy_hh_nn_ss;
     8 : result := Mask_dd_mm_yy_hh_nn;
     9 : result := Mask_dd_mm_yyyy_hh_nn_ss;
     else Result := TMask.Mask_Invalid;
   end;

end;

class function TDatesFreePascal.SetDefaultFormatSettings(Mask: TMask): TFormatSettings;
begin
  Result := DefaultFormatSettings;

  with DefaultFormatSettings do
  begin
    DateSeparator := '/';
    Case Mask of
      Mask_yy_mm_dd,
      Mask_dd_mm_yy,
      Mask_yyyy_mm_dd,
      Mask_dd_mm_yyyy
      Mask_mm_yy,
      Mask_mm_yyyy        : ShortDateFormat := Mask_to_MaskDateTime(Mask);


      //Mask_yyyy_mm_dd,     antes eu usava como longformato mais estava errado
      //Mask_dd_mm_yyyy     : begin
      //                        LongDateFormat := Mask_to_MaskDateTime(Mask);
      //                        ShortDateFormat := LongDateFormat;
      //                       end;

      Mask_hh_nn,
      Mask_hh_nn_ss,
      Mask_hh_nn_ss_zzz,
      Mask_dd_mm_yy_hh_nn_ss      : begin
                                          TimeSeparator := ':';
                                          LongTimeFormat := Mask_to_MaskDateTime(Mask);
                                          ShortTimeFormat := LongTimeFormat;
                                        end;


      Mask_dd_mm_yy_hh_nn  : begin
                                   TimeSeparator := ':';
                                   ShortTimeFormat := Mask_to_MaskDateTime(Mask);
                                   LongTimeFormat  := ShortTimeFormat;
                                 end;


      Mask_dd_mm_yyyy_hh_nn_ss : begin
                                       TimeSeparator := ':';
                                       LongTimeFormat := Mask_to_MaskDateTime(Mask);
                                       ShortTimeFormat := LongTimeFormat;
                                      end;

    End;
  end;
end;

class function TDatesFreePascal.StrToDateTime(const S: AnsiString; const Mask: TMask  ): TDateTime;overload;
  Var
    W : TFormatSettings;
begin
  w := SetDefaultFormatSettings(Mask);
  Result := SysUtils.StrToDateTime(s,DefaultFormatSettings);
  DefaultFormatSettings := w;
end;

class function TDatesFreePascal.StrToDateTime(const S: AnsiString): TDateTime;overload;
begin
  Result := SysUtils.StrToDateTime(s,DefaultFormatSettings);
end;

class function TDatesFreePascal.DateTimeToStr(d: TDateTime; Mask: TMask  ): AnsiString;
  Var
    W : TFormatSettings;
begin
  w := SetDefaultFormatSettings(Mask);
  Result := SysUtils.FormatDateTime(Mask_to_MaskDateTime(Mask),d) ;
  DefaultFormatSettings := w;
end;

class function TDatesFreePascal.DateTimeToStr(d: TDateTime): AnsiString;
begin
  Result := SysUtils.DateTimeToStr(d,DefaultFormatSettings);
end;

class function TDatesFreePascal.IsDateTime(const aTemplate: AnsiString): Boolean;
begin
  result := MaskEdit_to_Mask(aTemplate) <> TMask.Mask_Invalid ;
end;



end.


