unit form.exe01.frame;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, umi_lcl_scrollbox, umi_lcl_ui_ds_form,
  Data.Module.Exemplo,mi_rtl_ui_dmxscroller_form;

type

  { TForm_exe01_frame }

  TForm_exe01_frame = class(TFrame)
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_ds_Form1: TMi_lcl_ui_ds_Form;
    private DataModule_Exemplo:TDataModule_Exemplo;
    public constructor Create(AOwner: TComponent); override;
    public destructor Destroy; override;

  end;

implementation

{$R *.lfm}

{ TForm_exe01_frame }

constructor TForm_exe01_frame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  DataModule_Exemplo := TDataModule_Exemplo.Create(nil);
end;

destructor TForm_exe01_frame.Destroy;
begin
  //Mi_lcl_ui_ds_Form1.Active:=false;
  inherited Destroy;
  FreeAndNil(DataModule_Exemplo); //Precisa destruir so depos de destruir o formulário
end;

end.

