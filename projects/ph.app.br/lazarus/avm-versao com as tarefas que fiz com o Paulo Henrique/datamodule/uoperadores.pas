unit uoperadores;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, mi_rtl_ui_dmxscroller_form,
  mi_rtl_ui_Dmxscroller;

type

  { Toperadores }

  Toperadores = class(TDataModule)
    Consultar: TAction;
    Excluir: TAction;
    Gravar: TAction;
    Pesquisar: TAction;
    Novo: TAction;
    ActionList1: TActionList;
    DmxScroller_Form1: TDmxScroller_Form;
    procedure ConsultarExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller
      );
    procedure ExcluirExecute(Sender: TObject);
    procedure GravarExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure PesquisarExecute(Sender: TObject);


  private

  public

  end;

var
  operadores: Toperadores;

implementation

{$R *.lfm}

{ Toperadores }

procedure Toperadores.DataModuleCreate(Sender: TObject);
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

procedure Toperadores.DmxScroller_Form1AddTemplate(
  const aUiDmxScroller: TUiDmxScroller);
begin
with aUiDmxScroller do
  begin
    add('~CADASTRO DE OPERADORES~');
    add('');
    add('~id:       ~+\LLLLLL');
    add('~nome:     ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'); // String(50)
    add('~telefone: ~+\ssssssssssssssssssssssssssssss'); // String(20)
    add('');
    add('~     ~~ &Novo~'+ChEA+Novo.Name+
               '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
              '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
              '~❌ &Excluir~'+ChEA+Excluir.Name);
  end;


end;
// procedure Toperadores.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
// begin
//   with aUiDmxScroller do
//   begin
//     add('~dm_tableCADASTRO DE OPERADORES~');
//     add('');
//     add('~id:       ~+\LLLLLL'+chFN+SQLQuery1id.FieldName);
//     add('~nome:     ~+\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+SQLQuery1Nome.FieldName); // String(50)
//     add('~telefone: ~+\ssssssssssssssssssssssssssssss'+chFN+SQLQuery1Telefone.FieldName); // String(20)
//     add('');
//     add('~     ~~ &Novo~'+ChEA+Novo.Name+
//                '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
//               '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
//               '~❌ &Excluir~'+ChEA+Excluir.Name);

//   end;
// end;
procedure Toperadores.ConsultarExecute(Sender: TObject);
begin

end;



procedure Toperadores.ExcluirExecute(Sender: TObject);
begin

end;

procedure Toperadores.GravarExecute(Sender: TObject);
begin

end;

procedure Toperadores.NovoExecute(Sender: TObject);
begin

end;

procedure Toperadores.PesquisarExecute(Sender: TObject);
begin

end;







end.






