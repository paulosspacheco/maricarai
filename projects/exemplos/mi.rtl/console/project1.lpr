program project1;

  uses
    mi.rtl.Objectss;

 type
   F = mi.rtl.Objectss.TObjectss.TFiles;
begin
  If f.FileExists('./project1')
  Then writeLn('Arquivo exite')
  else writeLn('Arquivo não exite');

  f.CtrlSleep(20);
end.

