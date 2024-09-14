unit u_dm_create_data_modules;

{$mode Delphi}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, udm_table, mi_rtl_ui_Dmxscroller;

type

  { Tdm_create_data_modules }

  Tdm_create_data_modules = class(Tdm_table)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
  private

  public

  end;

var
  dm_create_data_modules: Tdm_create_data_modules;

implementation

{$R *.lfm}

{ Tdm_create_data_modules }

procedure Tdm_create_data_modules.DataModuleCreate(Sender: TObject);
begin
  // Definindo a consulta SQL para obter comentários
  //Mi_SQLQuery1.SQL.Text :=
  //     'SELECT ' +
  //     '  cols.column_name, ' +
  //     '  pgd.description AS column_comment ' +
  //     'FROM ' +
  //     '  pg_catalog.pg_statio_all_tables AS st ' +
  //     '  INNER JOIN pg_catalog.pg_description pgd ON (pgd.objoid = st.relid) ' +
  //     '  RIGHT OUTER JOIN information_schema.columns cols ON (pgd.objsubid = cols.ordinal_position ' +
  //     '    AND  cols.table_schema = st.schemaname AND cols.table_name = st.relname) ' +
  //     'WHERE ' +
  //     '  cols.table_name = ''__dm_xtable__'' ' +  // Substitua pelo nome da sua tabela
  //     '  AND cols.table_schema = ''public'';';  // Substitua pelo seu esquema, se necessário
  //;

  inherited DataModuleCreate(Sender);
end;

procedure Tdm_create_data_modules.DataModuleDestroy(Sender: TObject);
begin
  inherited DataModuleDestroy(Sender);
end;

function Tdm_create_data_modules.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
    result :=
             NewSItem(^A,
             NewSItem('',
             NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
             NewSItem('',
             NewSItem('~Campo:      ~\ssssssssssssssssssssssssssss`ssssssssssss'+ChFN+'column_name',
             NewSItem('~Commentário:~\ssssssssssssssssssssssssssss`ssssssssssssssssssssssssssss'+ChFN+'column_comment',

             nil))))));
  end;
end;

end.

