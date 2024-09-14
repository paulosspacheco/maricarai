unit umedicos;

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

  { Tmedicos }

  Tmedicos = class(Tdm_table)
      procedure DataModuleCreate(Sender: TObject);
      procedure DataModuleDestroy(Sender: TObject);

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);



    private

    public

  end;


implementation

{$R *.lfm}

{ Tmedicos }

procedure Tmedicos.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;

  end;
end;



procedure Tmedicos.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

procedure Tmedicos.DataModuleDestroy(Sender: TObject);
begin
   inherited;
end;

procedure Tmedicos.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
    add('"id:                     "\LLLLLL'+chFN+'id');
    add('"id_operadores:          "\LLLLLL'+chFN+'id_operadores');
    add('"Nome:                   "\ssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome');
    add('"Telefone da secretaria: "\ssssssssssssssssssssssssssssssssss'+chFN+'telefone_da_secretaria');
    add('"Login:                  "\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'login');
    add('"Senha:                  "\sssssssssssssssss`ssssssssssssssssssssssssssssssssssssss'+CharShowPassword+chFN+'senha'); // String(20) //+CharShowPassword
    add('');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');

  end;
end;



end.

