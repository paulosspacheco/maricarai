program project1; 

{$mode delphi}{$H+}

uses
  Interfaces, Forms, unit1, mi.rtl.Class_Of_Char, mi.rtl.ApplicationAbstract,
  mi.rtl.Types;

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWForm1, WForm1);
  Application.Run;
end.