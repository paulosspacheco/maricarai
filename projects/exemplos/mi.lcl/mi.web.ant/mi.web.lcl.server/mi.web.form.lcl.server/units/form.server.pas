unit form.server;
{:< A unit **name** implemnta a classe TForm_server}
{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, fphttpserver, fpjsondataset,  Controls, Graphics,
  Dialogs, StdCtrls, MaskEdit, ExtCtrls, Menus, ActnList
//  , u_datamodule1
  //, u_fpwebmodule1
  , mi.rtl.web.module
  ,fphttp
  ,Forms
  ,mi.web.fphttpserver, mi.web.fphttpclient;

type

  //object MI_web_application1: TMI_web_application
  //  MimeFile = '/home/paulosspacheco/v/Lazarus/fpcupdeluxe/lazarus/mime.type'
  //  UseSSL = False
  //  HostName = 'http://localhost'
  //  AllowDefaultModule = True
  //  Left = 280
  //  Top = 72
  //end
  { TForm_server }
  {A classe **@name** cria um servidor http para ser usado com a LCL.
  }
  TForm_server = class(TForm)
    Label1: TLabel;
    Label_hostName: TLabel;
    MaskEdit_hostName: TMaskEdit;
    MaskEdit_port: TMaskEdit;
    Mi_FpHttpServer1: TMi_FpHttpServer;
    Panel1: TPanel;
    StartButton: TButton;
    StopButton: TButton;
    CloseButton: TButton;

    procedure CloseButtonClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure StartButtonClick(Sender: TObject);
    procedure StopButtonClick(Sender: TObject);
  private

  public
//    datamodule1 : TDataModule1;
    //FPWebModule1: TFPWebModule1;
    //UsuarioController: TUsuarioController;
    mi_rtl_web_module  : Tmi_rtl_web_module;
  end;

var
  Form_server: TForm_server;

implementation

{$R *.lfm}

{ TForm_server }

procedure TForm_server.StartButtonClick(Sender: TObject);
  var
    p : variant;
begin
  With Mi_FpHttpServer1 do
  begin
    p := MaskEdit_port.Text;  Port :=  p;
    HostName:= MaskEdit_hostName.Text;

    start;
  end;
  StopButton.Enabled := true;
  StartButton.Enabled := false;
end;

procedure TForm_server.FormCreate(Sender: TObject);
begin
  //datamodule1 := TDataModule1.Create(self);
  //FPWebModule1:= TFPWebModule1.Create(self);
  //UsuarioController := TUsuarioController.Create(self);
  mi_rtl_web_module  := Tmi_rtl_web_module.Create(self);
  StopButton.Enabled := false;
end;


procedure TForm_server.CloseButtonClick(Sender: TObject);
begin
  close;
end;


procedure TForm_server.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  CloseAction:=caFree;
end;

procedure TForm_server.FormDestroy(Sender: TObject);
begin
  StopButtonClick(self);
  //freeandnil(datamodule1);
end;


procedure TForm_server.StopButtonClick(Sender: TObject);
begin
  Mi_FpHttpServer1.Stop;
  StopButton.Enabled := false;
  StartButton.Enabled := true;
end;

initialization
  RegisterHTTPModule('mi_rtl_WebModule', Tmi_rtl_web_module);
end.

