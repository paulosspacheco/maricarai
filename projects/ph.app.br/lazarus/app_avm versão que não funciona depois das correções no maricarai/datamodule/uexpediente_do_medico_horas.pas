unit uexpediente_do_medico_horas;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, DB, SQLDB  
  ,mi.rtl.all  
  ,mi_rtl_ui_Dmxscroller  
  ,mi_rtl_ui_dmxscroller_form
  ,udm_connections
  ,udm_table
  ;

type

  { Texpediente_do_medico_horas }

  Texpediente_do_medico_horas = class(Tdm_table)

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);


    private

    public

  end;


implementation

{$R *.lfm}

{ Texpediente_do_medico_horas }

procedure Texpediente_do_medico_horas.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;

  end;
end;


procedure Texpediente_do_medico_horas.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
    add('"id_expediente_do_medico_data: "\LLLLLL'+chFN+'id_expediente_do_medico_data');
    add('"Hora inicial:                 "\Dhh:nn'+chFN+'dataTime_inicial'); // Assume DateTime como String simplificado
    add('"Hora final:                   "\Dhh:nn'+chFN+'dataTime_final'); // Assume DateTime como String simplificado
    add('');
    add('');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');

  end;
end;



end.

