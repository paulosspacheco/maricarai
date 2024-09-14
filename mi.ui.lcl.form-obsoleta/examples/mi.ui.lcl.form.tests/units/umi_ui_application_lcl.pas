unit uMi_ui_Application_lcl;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,mi.rtl.Objects.Methods.Paramexecucao.Application
  ,mi.rtl.all
  ,Forms
  ,umi_ui_msgbox_lcl
  ,MI_UI_InputBox_lcl_u

  ;


type

  { TMi_ui_Application_LCL }

  TMi_ui_Application_LCL = class (mi.rtl.Objects.Methods.Paramexecucao.Application.TApplication)
    private Var _MI_UI_InputBox_lcl : TMI_UI_InputBox_lcl;
    private var _MI_UI_MsgBox_LCL   : TMI_UI_MsgBox_LCL;

    public constructor Create(AOwner: TComponent); override;  overload;
    public destructor Destroy; override;
    public procedure CreateForm(InstanceClass: TComponentClass; out Reference);
    public procedure Run;
  end;

//  function Application : TMi_ui_Application_LCL;


function Application : Forms.TApplication;
procedure SetRequireDerivedFormResource(aValue: Boolean);


implementation

Var
  //Ao executar a função application a aplicação TMI_ui_application_lcl deve criada caso seja nil;
  _Mi_ui_Application_LCL: TMi_ui_Application_LCL = nil;
  function Mi_ui_Application_LCL: TMi_ui_Application_LCL;
  begin
    if _Mi_ui_Application_LCL = nil
    Then begin
           _Mi_ui_Application_LCL := TMi_ui_Application_LCL.Create(nil);
         end;
    result := _Mi_ui_Application_LCL;
  end;

function Application: TApplication;
begin
  Result := Forms.Application;
  if _Mi_ui_Application_LCL = nil
  Then Mi_ui_Application_LCL;
end;

procedure SetRequireDerivedFormResource(aValue: Boolean);
begin
  RequireDerivedFormResource := aValue;
end;



{ TMi_ui_Application_LCL }

constructor TMi_ui_Application_LCL.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetApplication(self);

  _MI_UI_MsgBox_LCL  := TMI_UI_MsgBox_LCL.Create(self);
  TMi_Rtl.Set_MI_MsgBox(_MI_UI_MsgBox_LCL.MI_MsgBox1);

  _MI_UI_InputBox_lcl := TMI_UI_InputBox_lcl.Create(self);
  TMi_Rtl.Set_MI_UI_InputBox(_MI_UI_InputBox_lcl.MI_UI_InputBox1);





end;

destructor TMi_ui_Application_LCL.Destroy;
begin
  FreeAndNIl(_MI_UI_InputBox_lcl);
  FreeAndNil(_MI_UI_MsgBox_LCL);

  inherited Destroy;
end;

procedure TMi_ui_Application_LCL.CreateForm(InstanceClass: TComponentClass; out Reference);
begin
  forms.Application.CreateForm(InstanceClass,Reference);
end;

procedure TMi_ui_Application_LCL.Run;
begin
  forms.Application.run;
end;




{ TMi_ui_Application_LCL }


//constructor TMi_ui_Application_LCL.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  RequireDerivedFormResource:=True;
//  Scaled:=True;
//  Initialize;
//end;

//destructor TMi_ui_Application_LCL.Destroy;
//begin
//  inherited Destroy;
//end;


//procedure TMi_ui_Application_LCL.Run;
//begin
//  inherited run;
//end;

initialization

finalization

 Freeandnil(_Mi_ui_Application_LCL);

end.

