unit test;

{$IFDEF FPC}
  {$MODE Delphi} {$H-}
{$ENDIF}

interface

uses
  Classes, SysUtils;

procedure testAnsi;

implementation

procedure testAnsi;
  type
    tString = type AnsiString;
//    TString = RawByteString;
//    tstring = OemString;
  var
//    s1: TString ;
    ch : char;
     s1: RawByteString ;
begin
//  setcodepage(s1,862,true);

  s1 := 'ç';

  writeLn;
  writeLn('s1 = ',s1,' len = ',length(s1));
end;

end.

