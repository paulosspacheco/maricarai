unit form.main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  Data.Module.Client.Rest, mi.rtl.web.module.form;

type

  { TForm_main }

  TForm_main = class(TForm)
    Button_mi_rtl_web_module_form: TButton;
    procedure Button_mi_rtl_web_module_formClick(Sender: TObject);
  private

  public

  end;

var
  Form_main: TForm_main;

implementation

{$R *.lfm}

{ TForm_main }

procedure TForm_main.Button_mi_rtl_web_module_formClick(Sender: TObject);
   var
     mi_rtl_web_module_form: Tmi_rtl_web_module_form;
begin
  try
   mi_rtl_web_module_form := Tmi_rtl_web_module_form.Create(self);
   mi_rtl_web_module_form.showmodal;

  finally
     FreeandNil(mi_rtl_web_module_form);
  end;
end;

end.

