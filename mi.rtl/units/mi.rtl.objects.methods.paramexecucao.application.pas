unit mi.rtl.Objects.Methods.Paramexecucao.Application;

{$MODE Delphi} {$H+}

interface

uses
  Classes, SysUtils,
  mi.rtl.types,
  mi.rtl.applicationabstract,
  mi.rtl.objects.consts.MI_MsgBox,
  mi.rtl.objects.consts.progressdlg_if,
  mi.rtl.objects.consts.logs,
  mi.rtl.objects.methods.ParamExecucao;


  type
    TApplication = class;


    {: A class *@name** é usada para capsular todas as variáveis globais do projeto e
       gerenciar o ciclo de vida do aplicativo
    }
    TApplication_type = Class(TApplicationAbstract)
      type TMI_MsgBox = mi.rtl.objects.consts.MI_MsgBox.TMI_MsgBox;
      type TProgressDlg_If = mi.rtl.objects.consts.progressdlg_if.TProgressDlg_If;
      type TProgressDlg_If_Class = mi.rtl.objects.consts.progressdlg_if.TProgressDlg_If_Class;
      type TFilesLogs     = mi.rtl.objects.Consts.logs.TFilesLogs;

      {: O tipo **@name** usado para habilita e desabilitar comandos.}
      Type TCommandSet       = Array of ansistring;
    end;

    TApplicationConsts = Class(TApplication_type)
        {: Ponto inferior a esqueda da aplicação}
       public origin : TTypes.TPoint;

        {: Ponto superior a direta da aplicação}
       public Size   : TTypes.TPoint;

       public MI_MsgBox : TMI_MsgBox;
       public Logs : TFilesLogs; //:< - Logs é inicializado em Initialization e destruído em finalization
    end;

    { TApplication }
    TApplication = Class(TApplicationConsts)
       public ParamExecucao : TParamExecucao;
       public constructor Create(AOwner: TComponent); override;
       public destructor Destroy; override;

       {: O método **@name** deve ser redefinido na aplicações filhas para indicar
          se o comando a ser executado está habilitado no arquivo de opções.
       }
       public function FileOptions_CommandEnabled(aCommand: AnsiString): Boolean;Virtual;

       Public procedure EnableCommands(aCommands: TCommandSet);virtual;
       Public procedure DisableCommands(aCommands: TCommandSet);virtual;

    end;

    function application : TApplication;
    Procedure Setapplication(aApplication : TApplication);

implementation

  var
    _Application : TApplication;
    _ok_destroy_Application : boolean = false;

  function application : TApplication;
  begin
    result := _Application;
  end;

  Procedure Setapplication(aApplication : TApplication);
  begin
    if _ok_destroy_Application
    then freeAndNil(_Application);

    _Application := aApplication;
  end;

{ TApplication }

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

initialization

  _Application := TApplication.Create(nil);
  _ok_destroy_Application := true;

finalization
  if _ok_destroy_Application
  then freeAndNil(_Application);

end.

