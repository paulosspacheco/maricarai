unit Unit3;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls,
  umi_lcl_scrollbox, umi_lcl_ui_form, umi_lcl_ui_ds_form,
  Mi.rtl.WebModule.Custom, Unit2;

type

  { TForm2 }

  TForm2 = class(TForm)
    Label1: TLabel;
    Mi_LCL_Scrollbox1: TMi_LCL_Scrollbox;
    Mi_lcl_ui_Form1: TMi_lcl_ui_Form;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    DataModule1 : TDataModule1;
  public

  end;

var
  Form2: TForm2;

implementation

{$R *.lfm}

{ TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
  var
    tmp: TMi_lcl_ui_Form; //não sei porque mais é necessário
begin
  tmp := Mi_lcl_ui_Form1;
  DataModule1 := TDataModule1.Create(nil);
  //Mi_lcl_ui_Form1.DmxScroller_Form := DataModule1.DmxScroller_Form1;
  //Mi_lcl_ui_Form1.ParentLCL        := Mi_LCL_Scrollbox1;
  Mi_lcl_ui_Form1.Active:=true; //Criar o formulário aqui
  if Not Assigned(Mi_lcl_ui_Form1) //Já passei muitos dias e não achei porque ao ativar o fromulário o compente perde a referência no TForm;
  then Mi_lcl_ui_Form1 := tmp;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
  //Não sei porque mais se não desativa o formulário aqui vai gerar exceção.
  Mi_lcl_ui_Form1.Active:=false;
  FreeAndNil(DataModule1);
end;

end.

