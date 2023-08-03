unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,mi.rtl.files;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
// [0] = Major version, [1] = Minor ver, [2] = Revision, [3] = Build Number
  Var
    sProgName:string;
begin

  With mi.rtl.files.Tfiles do
  begin

    sProgName :='PROJECT1';
    edit1.text:=sProgName + ' , Version:     ' + AppVersionInfo.MajorAsStr + '.'+AppVersionInfo.MinorAsStr+'.'+AppVersionInfo.RevisionAsStr+ '.'+AppVersionInfo.BuildNoAsStr;
    edit2.text:=sProgName + ' , VersionStr:  ' + AppVersionInfo.VersionStr;
    edit3.text:=sProgName + ' , VersionStrEx:' + AppVersionInfo.VersionStrEx[C_DEF_VER_FORMAT3];
  end;

end;

end.

