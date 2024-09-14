unit operadores_u;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList
  ,dm_table_u
  , unit_dm_connections, DB
  ,mi.rtl.all
  ,mi_rtl_ui_dmxscroller_form

  , mi_rtl_ui_Dmxscroller;

type

  { Toperadores }

  Toperadores = class(Tdm_table)
    id: TLongintField;
    login: TStringField;
    nome: TStringField;
    password: TStringField;
    telefone: TStringField;

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller
      );
    procedure DmxScroller_Form1NewRecord(aDmxScroller: TUiDmxScroller);

  private

  public

  end;

var
  operadores: Toperadores;

implementation

{$R *.lfm}

{ Toperadores }

procedure Toperadores.DmxScroller_Form1AddTemplate( const aUiDmxScroller: TUiDmxScroller);
begin
  with DmxScroller_Form1 do
    begin
      AlignmentLabels:= taRightJustify;
      //AlignmentLabels:= taLeftJustify;
      //AlignmentLabels:= taCenter;
      add('~    ~'+
               '~   Inicio~'+ChH+'Posiciona no primeiro registro'+ChEA+Action_bof.Name+
               '~   Próximo~'+ChH+'Posiciona no próximo registro'+ChEA+Action_next.Name+
               '~   Anterior~'+ChH+'Posiciona registro anterior'+ChEA+Action_prev.Name+
               '~   Ultimo~'+ChH+'Posiciona útimo registro'+ChEA+Action_eof.Name);
      add('');
      add('');
      add(     '~🔲 &Novo~'+ChH+'Executa DoOnNewRecord'+ChEA+Action_novo.Name+
               '~✔  Gravar~'+ChEA+Action_gravar.Name+
               '~🔍 &Pesquisar~'+ChEA+Action_pesquisar.Name+
               '~❌ Excluir~'+ChEA+Action_excluir.Name);
      add('');
      add('');
      add('~      ID:~\LLLLLL'+ChFN+'id'+CharPfInKeyPrimary+  ChH+'Campo da chave primária');
      add('~    Nome:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'name');
      add('~   Login:~\ssssssssssssssssssss`sssssssssssssssssssss'+ChFN+'connectortype');
      add('~Password:~\ssssssssssssssssssss`sssssssssssssssssssss'+CharShowPassword+ChFN+'password');
      add('~Telefone:~\## #### ####'+ChFN+'telefone');

  end;
end;

procedure Toperadores.DmxScroller_Form1NewRecord(aDmxScroller: TUiDmxScroller);
begin
  //with DmxScroller_Form1 do
  //  ShowMessage('OnNewRecord!');
end;


end.

