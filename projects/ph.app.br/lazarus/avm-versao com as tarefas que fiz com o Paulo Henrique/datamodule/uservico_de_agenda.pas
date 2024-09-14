unit uservico_de_agenda;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;

type

  { TDataModule2 }

  TDataModule2 = class(TDataModule)
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
  DataModule2: TDataModule2;

implementation

{$R *.lfm}

{ TDataModule2 }

procedure TDataModule2.DataModuleCreate(Sender: TObject);
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

procedure TDataModule2.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
   begin
     add('~SERVICO DE AGENDA~');
     add('');
     add('~id:   ~+\LLLLLL');
     add('~id_operadores:          ~+\LLLLLL');
     add('~nome:                   ~+\ssssssssssssssssssssssssssssssssssssssssssssssss');
     add('~login:       ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss');
     add('~senha:       ~+\ssssssssssssssssssssssssssssssssssssssssssssssssssssss');
     add('');
     add('~     ~~ &Novo~'+ChEA+Novo.Name+
                '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
                 '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
                '~❌ &Excluir~'+ChEA+Excluir.Name);


  end;
end;

end.



Serviço de agenda:
'~id:          ~+\LLLLLL'+^M+
'~id_operador: ~+\LLLLLL'+^M+
'~nome:        ~+\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+^M+ // String(100)
'~login:       ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+^M+ // String(50)
'~senha:       ~+\ssssssssssssssssssssssssssssssssssssssssssssssssssssss'+^M+ // String(50)


