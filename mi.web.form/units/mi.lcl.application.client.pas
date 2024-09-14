unit mi.lcl.application.client;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,mi.lcl.application,forms
  ,mi.rtl.all;

  Type

    { Tmi_web_application }

    Tmi_lcl_application_client=class(Tmi_lcl_application)
      public function GetTypeApplication:TEnumApplication;Override;
      public constructor Create(AOwner: TComponent); override;  overload;
    end;

    function Application : Forms.TApplication;
    function mi_lcl_application_client: Tmi_lcl_application_client;
    procedure SetRequireDerivedFormResource(aValue: Boolean);

implementation

  Var
    //Ao executar a função application a aplicação Tmi_lcl_application_client deve ser
    //criada caso seja nil;
    _mi_lcl_application_client: Tmi_lcl_application_client = nil;

  function mi_lcl_application_client: Tmi_lcl_application_client;
  begin
    if _mi_lcl_application_client = nil
    Then begin
           _mi_lcl_application_client := Tmi_lcl_application_client.Create(nil);
         end;
    result := _mi_lcl_application_client;
  end;


  function Get_mi_lcl_application_client: Tmi_rtl.TApplication;
  begin
    Result := _mi_lcl_application_client;
  end;

  function Application: TApplication;
  begin
    Result := Forms.Application;
    if _mi_lcl_application_client = nil
    Then _mi_lcl_application_client := mi_lcl_application_client;
  end;

  procedure SetRequireDerivedFormResource(aValue: Boolean);
  begin
    RequireDerivedFormResource := aValue;
  end;



{ Tmi_lcl_application_client }

function Tmi_lcl_application_client.GetTypeApplication: TEnumApplication;
begin
  Result:=App_LCL_Http_Client;
end;

constructor Tmi_lcl_application_client.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Tmi_rtl.SetFuncApplication(@Get_mi_lcl_application_client);
end;

end.

