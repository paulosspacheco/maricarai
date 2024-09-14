unit uoperadores;

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

  { Toperadores }

  Toperadores = class(Tdm_table)

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);


    private

    public

  end;


implementation

{$R *.lfm}

{ Toperadores }

procedure Toperadores.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;
  end;
end;


procedure Toperadores.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    Add('"CADASTRO "');
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
    add('~id:        ~\LLLLLL'+chFN+'id');
    add('~nome:      ~\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'); // String(50)
    add('~Login:     ~\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'login'); // String(50)
    add('~Password:  ~\sssssssssssssssss`ssssssssssssssssssssssssssssssssssssss'+chFN+'password'); // String(20) //+CharShowPassword
    add('~telefone:  ~\##-#####-####'+chFN+'telefone'); // String(20)
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');

  end;
end;



end.

    //add('~telefone~');
    //add('~secretária:~+\ssssssssssssssssssssssssssssss'); // String(20)

