unit uStatus_da_agenda_ou_consulta;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, mi_rtl_ui_dmxscroller_form,
  mi_rtl_ui_Dmxscroller;

type

  { TStatus_da_agenda_ou_consulta }

  TStatus_da_agenda_ou_consulta = class(TDataModule)
    ActionList1: TActionList;
    Consultar: TAction;
    DmxScroller_Form1: TDmxScroller_Form;
    Excluir: TAction;
    Gravar: TAction;
    Novo: TAction;
    Pesquisar: TAction;
    procedure DataModuleCreate(Sender: TObject);
    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller
      );
  private

  public

  end;

var
  Status_da_agenda_ou_consulta: TStatus_da_agenda_ou_consulta;

implementation

{$R *.lfm}

{ TStatus_da_agenda_ou_consulta }

procedure TStatus_da_agenda_ou_consulta.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
     add('~STATUS DA AGENDA~');
     add('');
     add('~id:   ~+\LLLLLL');
     add('~nome: ~+\ssssssssssssssssssss');
     add('');
     add('~     ~~ &Novo~'+ChEA+Novo.Name+
                '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
                 '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
                '~❌ &Excluir~'+ChEA+Excluir.Name);


  end;
end;

procedure TStatus_da_agenda_ou_consulta.DataModuleCreate(Sender: TObject);

  var
     ac : TDmxScroller_Form.TMi_Action;
begin
  with DmxScroller_Form1,Mi_ActionList do
  begin
    AddAction(TMi_Action.create(novo.name,novo.onExecute,asNormal));
    AddAction(TMi_Action.create(Pesquisar.name,Pesquisar.onExecute,asNormal));
    AddAction(TMi_Action.create(Gravar.name,Gravar.onExecute,asNormal));
    AddAction(TMi_Action.create(Excluir.name,Excluir.onExecute,asNormal));
  end;
end;

end.

with aUiDmxScroller do
begin
   add('~STATUS DA AGENDA~');
   add('');
   add('~id:   ~+\LLLLLL');




   add('');
   add('~     ~~ &Novo~'+ChEA+Novo.Name+
              '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
               '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
              '~❌ &Excluir~'+ChEA+Excluir.Name);


end;

