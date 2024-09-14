unit mi.rtl.ActionList;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils,ActnList
  ,mi.rtl.miStringlist
  ;


type
  TMi_ActionState = (asNormal, asEnable, AsDisable);
  TMi_Action = class;
  TActionEvent = TNotifyEvent;//procedure (AAction: TMi_Action; var Handled: Boolean) of object;

  {: A Classe **@name** contém o nome  }

  { TMi_Action }

  TMi_Action = class(TObject)
                 name        : String;
                 OnExecute   : TActionEvent;
                 ActionState : TMi_ActionState;
                 constructor create(aName:String;
                                    aOnExecute :TActionEvent;
                                    aActionState :TMi_ActionState);
                 function Execute: Boolean;
               end;

  { TMi_CustomActionList }

  {: A classe **@name** contém todas as opções registradas

     - Exemplo de usdo:
       - Este exemplo funciona em um TdataModule1 com as ações  novo,
         pesquisar, Gravar e Excluir adicionadas em TActionList1.
       - Obs:
         - As ações podem ser difinida pelo editor de ações ou não. Caso seja
           definida manualmente deve-se criar os evento TActionEvent  para cada
           ação a ser executada.

       ```pascal

          procedure TDataModule1.DataModuleCreate(Sender: TObject);
            var
              ac : TDmxScroller_Form.TMi_Action;
          begin
            with DmxScroller_Form1,Mi_ActionList do
            begin
              AddAction(TMi_Action.create(novo.name,novo.onExecute,asNormal));
              AddAction(TMi_Action.create(Pesquisar.name,Pesquisar.onExecute,asNormal));
              AddAction(TMi_Action.create(Gravar.name,Gravar.onExecute,asNormal));
              AddAction(TMi_Action.create(Excluir.name,Excluir.onExecute,asNormal));

              ac := ActionByName(novo.name);
              if Assigned(ac)
              then ac.Execute;

              execute(novo.name);
              execute(self,novo.name);
            end;

          end;


         class procedure TMi_CustomActionList.teste2;
           var
             ac : TDmxScroller_Form1.TMi_Action;
         begin
           with DmxScroller_Form1,Mi_ActionList do
           begin
             AddAction(TMi_Action.create(novo.name,novo.onExecute,asNormal));
             AddAction(TMi_Action.create(Pesquisar.name,Pesquisar.onExecute,asNormal));
             AddAction(TMi_Action.create(Gravar.name,Gravar.onExecute,asNormal));
             AddAction(TMi_Action.create(Excluir.name,Excluir.onExecute,asNormal));

             ac := ActionByName(novo.name);
             if Assigned(ac)
             then ac.Execute;

             execute(novo.name);
             execute(self,novo.name);
           end;

         end;


       ```
  }
  TMi_CustomActionList = Class(TMiStringList)
    Public Constructor Create;
    public function AddAction(aMi_Action:TMi_Action):TMi_Action;
    public Function ActionByName(aAction  : String):Tmi_Action;Overload;Virtual;

    public function Execute(Sender: TObject;aName:String): Boolean;overload;
    public function Execute(aName:String): Boolean;overload;

    public class procedure teste1;
    public class procedure teste2;

   End;

  TMi_ActionList = class(TMi_CustomActionList)

  end;



  //{ TCustomActionList }
  //TCustomActionList = class(TComponent)
  //private
  //  FActions: TFPList;// list of TContainedAction
  //
  //  FState: TActionListState;
  //  function GetAction(Index: Integer): TContainedAction;
  //  function GetActionCount: Integer;
  //  procedure ImageListChange(Sender: TObject);
  //  procedure SetAction(Index: Integer; Value: TContainedAction);
  //  procedure SetState(const Value: TActionListState);
  //protected
  //  procedure AddAction(Action: TContainedAction); virtual;
  //  procedure RemoveAction(Action: TContainedAction); virtual;
  //  procedure Change; virtual;
  //  procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  //  procedure Notification(AComponent: TComponent;
  //    Operation: TOperation); override;
  //  procedure SetChildOrder(Component: TComponent; Order: Integer); override;
  //  procedure SetImages(Value: TCustomImageList); virtual;
  //  property OnChange: TNotifyEvent read FOnChange write FOnChange;
  //  property OnExecute: TActionEvent read FOnExecute write FOnExecute;
  //  property OnUpdate: TActionEvent read FOnUpdate write FOnUpdate;
  //public
  //  constructor Create(AOwner: TComponent); override;
  //  destructor Destroy; override;
  //
  //  function ActionByName(const ActionName: string): TContainedAction;
  //  function ExecuteAction(Action: TBasicAction): Boolean; override;
  //  function GetEnumerator: TActionListEnumerator;
  //  function IndexOfName(const ActionName: string): integer;
  //  function IsShortCut(var Message: TLMKey): Boolean;
  //  function UpdateAction(Action: TBasicAction): Boolean; override;
  //
  //  property Actions[Index: Integer]: TContainedAction read GetAction write SetAction; default;
  //  property ActionCount: Integer read GetActionCount;
  //  property Images: TCustomImageList read FImages write SetImages;
  //  property State: TActionListState read FState write SetState default asNormal;
  //end;

implementation

{ TMi_Action }

constructor TMi_Action.create(aName: String; aOnExecute: TActionEvent; aActionState: TMi_ActionState);
begin
  name        := aname;
  OnExecute   := aOnExecute;
  ActionState := aActionState;
end;

function TMi_Action.Execute: Boolean;
begin
  if Assigned(OnExecute)
  then begin
         OnExecute(self);
         result := true;
       end
  else result := false;
end;

{ TMi_CustomActionList }

constructor TMi_CustomActionList.Create;
begin
  inherited create;
  Sorted := true; //insere em ordem alfabetica
  Duplicates := dupError; //Não aceita duplicatas
  OkDestroy_Object:=true;
end;

function TMi_CustomActionList.AddAction(aMi_Action: TMi_Action): TMi_Action;
begin
  AddObject(UpperCase(aMi_Action.name),aMi_Action);
  result := aMi_Action;
end;

function TMi_CustomActionList.ActionByName(aAction: String): Tmi_Action;
  Var
    i : Integer;
begin
  if find(aAction,i)
  then begin
         if Objects[i]<> nil
         then result := Objects[i] as TMI_Action
         else result := nil;
       end
  else result := nil;
end;

function TMi_CustomActionList.Execute(Sender: TObject; aName: String): Boolean;
  var
    ac : TMi_Action;
begin
  ac := ActionByName(aName);
  if Assigned(ac) and Assigned(ac.OnExecute)
  then begin
         ac.OnExecute(Sender);
         result := true;
       end
  else result := false;
end;

function TMi_CustomActionList.Execute(aName: String): Boolean;
  var
    ac : TMi_Action;
begin
  ac := ActionByName(aName);
  if Assigned(ac)
  then result := ac.Execute
  else result := false;
end;

class procedure TMi_CustomActionList.teste1;
  var
    Mi_CustomActionList:TMi_CustomActionList;
    ac : Tmi_Action;
begin
  Mi_CustomActionList := TMi_CustomActionList.Create;
  with Mi_CustomActionList do
  begin
    AddAction(TMi_Action.create('acInclusao',nil,asNormal));

    ac := ActionByName('acInclusao');
    if ac <> nil
    then writeLn(ac.name);

  end;
  Mi_CustomActionList.free;

end;

class procedure TMi_CustomActionList.teste2;
  // Este exemplo funciona em um TdataModule com as ações  novo, pesquisar,
  // Gravar e Excluir adicionadas em TActionList1
  //var
  //  ac : TDmxScroller_Form1.TMi_Action;
begin
  //with DmxScroller_Form1,Mi_ActionList do
  //begin
  //  AddAction(TMi_Action.create(novo.name,novo.onExecute,asNormal));
  //  AddAction(TMi_Action.create(Pesquisar.name,Pesquisar.onExecute,asNormal));
  //  AddAction(TMi_Action.create(Gravar.name,Gravar.onExecute,asNormal));
  //  AddAction(TMi_Action.create(Excluir.name,Excluir.onExecute,asNormal));
  //
  //  ac := ActionByName(novo.name);
  //  if Assigned(ac)
  //  then ac.Execute;
  //
  //  execute(novo.name);
  //  execute(self,novo.name);
  //end;

end;

end.

