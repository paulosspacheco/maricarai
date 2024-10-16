unit mi.lcl.application;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils
  ,mi.rtl.Objects.Methods.Paramexecucao.Application
  ,mi.rtl.all
  ,Forms
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,umi_lcl_msgbox
  ,umi_lcl_ds_inputbox
  ,mi.rtl.ui.dmxscroller.inputbox
  ;

type


  { Tmi_lcl_application }

  Tmi_lcl_application = class(mi.rtl.Objects.Methods.Paramexecucao.Application.TApplication)
//    private Var _MI_lcl_InputBox : TMI_lcl_InputBox; não precisa porque pode ter mais
    private var _MI_lcl_MsgBox   : TMI_lcl_MsgBox;//Caso não seja criado aqui o sistema visualiza mensagens.


    public constructor Create(AOwner: TComponent); override;  overload;
    public destructor Destroy; override;
    public procedure CreateForm(InstanceClass: TComponentClass; out Reference);overload;

    {:O método **@name** é um método abstrato definido em
      mi.rtl.Objects.Methods.Paramexecucao.Application
      com objetivo de criar formulários tipo TMi_lcl_inputbox ou TMI_Lcl_MsgBox
      quando a aplicação foir lcl, caso seja web deve retorna um dos tipos
      TMi_js_inputbox ou TMI_js_MsgBox.
    }
    public procedure CreateForm(aMI_MsgBoxTypes_Class : TMI_MsgBoxTypes_Class; out Reference);Override;overload;

    public procedure Run;
    public procedure HandleException(Sender: TObject); override;

  end;


  function Application : Forms.TApplication;
  function mi_lcl_application: Tmi_lcl_application;
  procedure SetRequireDerivedFormResource(aValue: Boolean);


implementation
  Var
    //Ao executar a função application a aplicação TMi_lcl_application deve ser
    //criada caso seja nil;
    _mi_lcl_application: TMi_lcl_application = nil;

  function mi_lcl_application: Tmi_lcl_application;
  begin
    if _mi_lcl_application = nil
    Then begin
           _mi_lcl_application := Tmi_lcl_application.Create(nil);
         end;
    result := _mi_lcl_application;
  end;


  function Get_Mi_lcl_application: mi.rtl.Objects.Methods.Paramexecucao.Application.TApplication;
  begin
    Result := _mi_lcl_application;
  end;

  function Application: TApplication;
  begin
    Result := Forms.Application;
    if _mi_lcl_application = nil
    Then _mi_lcl_application := mi_lcl_application;
  end;

  procedure SetRequireDerivedFormResource(aValue: Boolean);
  begin
    RequireDerivedFormResource := aValue;
  end;


  { Tmi_lcl_application }

  constructor Tmi_lcl_application.Create(AOwner: TComponent);
  begin
    inherited Create(AOwner);
    _MI_lcl_MsgBox  := TMI_lcl_MsgBox.Create(nil);
    TMi_Rtl.Set_MI_MsgBox(_MI_lcl_MsgBox.MI_MsgBox1);
   // Forms.MessageBoxFunction :=  @MessageBoxFunction;
    TMi_Rtl.SetFuncApplication(@Get_mi_lcl_application);
  end;

  destructor Tmi_lcl_application.Destroy;
  begin
    FreeAndNil(_MI_lcl_MsgBox);
    inherited Destroy;
  end;

  procedure Tmi_lcl_application.CreateForm(InstanceClass: TComponentClass; out Reference);
  begin
    forms.Application.CreateForm(InstanceClass,Reference);
  end;

  procedure Tmi_lcl_application.Run;
  begin
    forms.Application.run;
  end;

  procedure Tmi_lcl_application.HandleException(Sender: TObject);
  begin
    inherited HandleException(Sender);
  end;

  procedure Tmi_lcl_application.CreateForm( aMI_MsgBoxTypes_Class: TMI_MsgBoxTypes_Class; out Reference);
    var
      Instance: TComponent;//Usado para saber o tipo da classe.
      Input  : TMi_lcl_inputbox;
      MsgBox : TMI_Lcl_MsgBox;
  begin
    // Allocate the instance, without calling the constructor
    Instance := TComponent(aMI_MsgBoxTypes_Class.NewInstance);
    TComponent(Reference) := Instance;
    Instance.Create(Self);
    if (Instance is TMI_UI_InputBox)
    then begin
           freeandnil(Reference);
           Input := TMi_lcl_inputbox.Create(nil);
           TMI_MsgBoxTypes(Reference) := Input.MI_UI_InputBox1;
         end
         else if (Instance is TMI_MsgBox)
              then begin
                     freeandnil(Reference);
                     MsgBox := TMI_Lcl_MsgBox.Create(nil);
                     TMI_MsgBoxTypes(Reference) := MsgBox.MI_MsgBox1;
                   end
              else TMI_MsgBoxTypes(Reference) := nil;

  end;


//initialization


finalization

 Freeandnil(_mi_lcl_application);

end.

