{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit mi.web.form;

{$warn 5023 off : no warning about unused units}
interface

uses
  mi.web.fphttpclient, mi.web.fphttpserver, 
  mi.web.dmxscroller.form.rest.client, mi.lcl.application.client, 
  LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('mi.web.fphttpclient', @mi.web.fphttpclient.Register);
  RegisterUnit('mi.web.fphttpserver', @mi.web.fphttpserver.Register);
  RegisterUnit('mi.web.dmxscroller.form.rest.client', 
    @mi.web.dmxscroller.form.rest.client.Register);
end;

initialization
  RegisterPackage('mi.web.form', @Register);
end.