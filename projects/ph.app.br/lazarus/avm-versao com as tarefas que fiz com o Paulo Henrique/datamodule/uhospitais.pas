unit uHospitais;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, mi_rtl_ui_dmxscroller_form,
  mi_rtl_ui_Dmxscroller;

type

  { THospitais }

  THospitais = class(TDataModule)
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
  Hospitais: THospitais;

implementation

{$R *.lfm}

{ THospitais }

procedure THospitais.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
     add('~CADASTRO DE HOSPITAIS~');
     add('');
     add('~id:       ~+\LLLLLL');
     add('~nome:     ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss');
     add('~telefone: ~+\ssssssssssssssssssssssssssssss');
     add('');
     add('~     ~~ &Novo~'+ChEA+Novo.Name+
                '~✔ &️Gravar~'+ChEA+Gravar.Name+
                 '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
                '~❌ &Excluir~'+ChEA+Excluir.Name);


  end;
end;

procedure THospitais.DataModuleCreate(Sender: TObject);
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


