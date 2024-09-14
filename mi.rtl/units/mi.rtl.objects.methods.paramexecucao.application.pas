unit mi.rtl.Objects.Methods.Paramexecucao.Application;

{$MODE Delphi} {$H+}

interface

uses
  Classes, SysUtils,
  mi.rtl.types,
  mi.rtl.applicationabstract,
  mi.rtl.objects.consts.MI_MsgBox,
  mi.rtl.Consts.transaction,
  mi.rtl.objects.consts.progressdlg_if,
  mi.rtl.objects.consts.logs,
  mi.rtl.objects.methods.ParamExecucao;

  type
    TMI_UI_InputBox_Base = class

    end;

  type
    TApplication = class;


    {: A class *@name** é usada para capsular todas as variáveis
       globais do projeto e gerenciar o ciclo de vida do aplicativo
    }
    TApplication_type = Class(TApplicationAbstract)
      public
      Type TEnumApplication =( EnApp_Console      ,
                               EnApp_Console_Cgi          ,
                               EnApp_Console_FastCgi      ,
                               EnApp_Console_ServerHttp   ,
                               EnApp_LCL,
                               EnApp_LCL_Http_Server  ,
                               EnApp_LCL_Http_Client );

      type TMI_MsgBox = mi.rtl.objects.consts.MI_MsgBox.TMI_MsgBox;
      type TMi_Transaction = mi.rtl.Consts.transaction.TMi_Transaction;
      type TProgressDlg_If = mi.rtl.objects.consts.progressdlg_if.TProgressDlg_If;
      type TProgressDlg_If_Class = mi.rtl.objects.consts.progressdlg_if.TProgressDlg_If_Class;
      type TFilesLogs     = mi.rtl.objects.Consts.logs.TFilesLogs;

      {: O tipo **@name** usado para habilita e desabilitar comandos.}
      Type TCommandSet       = Array of ansistring;
    end;



    { TApplicationConsts }

    TApplicationConsts = Class(TApplication_type)
       public const App_Console           = EnApp_Console;
       public const App_Console_Cgi       = EnApp_Console_Cgi;
       public const App_Console_FastCgi   = EnApp_Console_FastCgi;
       public const App_Console_ServerHttp= EnApp_Console_ServerHttp;
       public const App_LCL               = EnApp_LCL;
       public const App_LCL_Http_Server   = EnApp_LCL_Http_Server;
       public const App_LCL_Http_Client   = EnApp_LCL_Http_Client;


        {: Ponto inferior a esqueda da aplicação}
       public origin : TTypes.TPoint;

        {: Ponto superior a direta da aplicação}
       public Size   : TTypes.TPoint;
       public MI_MsgBox : TMI_MsgBox;
       public Logs : TFilesLogs; //:< - Logs é inicializado em Initialization e destruído em finalization
       public Mi_Transaction : TMi_Transaction;
       public ParamExecucao : TParamExecucao;

    end;

    { TApplication }
    TApplication = Class(TApplicationConsts)
       public function GetTypeApplication:TEnumApplication;Virtual;
       public constructor Create(AOwner: TComponent); override;
       public destructor Destroy; override;

       {: O método **@name** deve ser redefinido na aplicações filhas para indicar
          se o comando a ser executado está habilitado no arquivo de opções.
       }
       public function FileOptions_CommandEnabled(aCommand: AnsiString): Boolean;Virtual;

       Public procedure EnableCommands(aCommands: TCommandSet);virtual;
       Public procedure DisableCommands(aCommands: TCommandSet);virtual;
//      public Procedure StartTran

       {: O Método **@name** deve ser implementado para criar um diálogo com as
          caractestísticas do tipo de aplicação, podendo ser LCL, html, javascript etc...

          - **EXEMPLO DE IMPLEMENTAÇÃO DE APP LCL**

            ```pascal

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


            ```
       }
       public procedure CreateForm(aMI_MsgBoxTypes_Class : TMI_MsgBoxTypes_Class; out Reference);Virtual;overload;abstract;

    end;

    type
      TFuncApplication = function : TApplication;

    var
      FuncApplication : TFuncApplication =nil;


    function application : TApplication;

    Procedure Setapplication(aApplication : TApplication);

implementation

  var
    _Application : TApplication;
    _ok_destroy_Application : boolean = false;

  function application : TApplication;
  begin
    result := _Application;
    if result = nil
    Then  raise Exception.CreateFmt('O método '+{$I %CURRENTROUTINE%}+' não inicializado: %s', [Result]);
  end;

  Procedure Setapplication(aApplication : TApplication);
  begin
    if _ok_destroy_Application
    then begin
           freeAndNil(_Application);
           _ok_destroy_Application := false;
         end;

    _Application := aApplication;
    FuncApplication := application
  end;

{ TApplication }

function TApplication.GetTypeApplication: TEnumApplication;
begin
  result := App_LCL;
end;

constructor TApplication.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParamExecucao := TParamExecucao.Create(Self);
end;

destructor TApplication.Destroy;
begin
  TParamExecucao.Set_ParamExecucao(nil) ;
  inherited Destroy;
end;

function TApplication.FileOptions_CommandEnabled(aCommand: AnsiString): Boolean;
begin
  result := true;
end;

procedure TApplication.EnableCommands(aCommands: TCommandSet);
begin

end;

procedure TApplication.DisableCommands(aCommands: TCommandSet);
begin

end;

{ TApplicationConsts }


//procedure TApplication.CreateForm(aMI_MsgBoxTypes_Class: TMI_MsgBoxTypes_Class;
//  out Reference);
//begin
//
//end;

initialization

  _Application := TApplication.Create(nil);
  _ok_destroy_Application := true;
  FuncApplication := application;

finalization
  if _ok_destroy_Application
  then freeAndNil(_Application);

end.

