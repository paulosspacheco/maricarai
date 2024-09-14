unit uconsulta;

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

  { Tconsulta }

  Tconsulta = class(Tdm_table)

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);


    private

    public

  end;


implementation

{$R *.lfm}

{ Tconsulta }

procedure Tconsulta.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;

  end;
end;


procedure Tconsulta.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    Add('"CADASTRO "');
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
    //Add('"Status: "\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+CharAccSkip+chFN+'status');
    Add('"ID:     "\LLLLLL'+chFN+'id');
    Add('"Nome:   "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome');
    add('');
    add('');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');

  end;
end;



end.

