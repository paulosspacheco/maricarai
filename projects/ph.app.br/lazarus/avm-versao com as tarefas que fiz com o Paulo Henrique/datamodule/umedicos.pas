unit umedicos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;

type

  { TMedicos }

  TMedicos = class(TDataModule)
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
  Medicos: TMedicos;

implementation

{$R *.lfm}

{ TMedicos }

procedure TMedicos.DataModuleCreate(Sender: TObject);
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

procedure TMedicos.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
     add('~MEDICOS~');
     add('');
     add('~id:   ~+\LLLLLL');
     add('~id_operadores:          ~+\LLLLLL');
     add('~nome:                   ~+\ssssssssssssssssssssssssssssssssssssssssssssssss');
     add('~telefone_da_secretaria: ~+\ssssssssssssssssssssssssssssssssss');
     add('~login:                  ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss');
     add(''~senha:                  ~+\ssssssssssssssssssss');
     add('');
     add('~     ~~ &Novo~'+ChEA+Novo.Name+
                '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
                 '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
                '~❌ &Excluir~'+ChEA+Excluir.Name);


  end;
end;

end.


Médicos
'~id:                     ~+\LLLLLL'+^M+
'~id_operadores:          ~+\LLLLLL'+^M+
'~nome:                   ~+\ssssssssssssssssssssssssssssssssssssssssssssssss'+^M+ // String(50) '~telefone:               ~+\ssssssssssssssssssssssssssssssssss'+^M+ // String(25)
'~telefone_da_secretaria: ~+\ssssssssssssssssssssssssssssssssss'+^M+ // String(25)
'~login:                  ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+^M+ // String(50)
'~senha:                  ~+\ssssssssssssssssssss'+^M+ // String(20)

