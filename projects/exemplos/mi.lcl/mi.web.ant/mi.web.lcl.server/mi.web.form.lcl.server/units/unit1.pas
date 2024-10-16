unit Unit1;
{:< A unit **name** implemnta a classe TServer}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fphttpserver, Forms, Controls, Graphics, Dialogs, StdCtrls,
  MaskEdit, ExtCtrls; //uMi_web_application

type

  { TServer }
  {:A classe **name** cria um servidor http}
  TServer = class(TForm)
    CloseButton: TButton;
    Label1: TLabel;
    Label_hostName: TLabel;
    MaskEdit_hostName: TMaskEdit;
    MaskEdit_port: TMaskEdit;
    MI_web_application1: TMI_web_application;

    Panel1: TPanel;
    StartButton: TButton;
    StopButton: TButton;
    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
  private

  public
    DataModule1 : TDataModule1;
  end;

var
  Server: TServer;

implementation

{$R *.lfm}

{ TServer }

procedure TServer.StartButtonClick(Sender: TObject);
  var
    p : variant;
begin
  With MI_web_application1 do
  begin
    p := MaskEdit_port.Text;  Port :=  p;
    HostName:= MaskEdit_hostName.Text;
    start;
  end;
  StopButton.Enabled := true;
  StartButton.Enabled := false;
end;

procedure TServer.FormCreate(Sender: TObject);
begin
  DataModule1 := TDataModule1.Create(nil);
  StopButton.Enabled := false;
end;


procedure TServer.CloseButtonClick(Sender: TObject);
begin
  close;
end;

procedure TServer.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TServer.FormDestroy(Sender: TObject);
begin
  StopButtonClick(self);
  freeandnil(DataModule1);
end;


procedure TServer.StopButtonClick(Sender: TObject);
begin
  MI_web_application1.Stop;
  StopButton.Enabled := false;
  StartButton.Enabled := true;
end;

end.

