unit u__dm_xtable__;

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

  { T__dm_xtable__ }

  T__dm_xtable__ = class(Tdm_table)

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form1EnterField(aField: pDmxFieldRec);


    private

    public
      class procedure test_key_duplicate;
      class procedure test2_key_duplicate;
  end;


implementation

{$R *.lfm}

{ T__dm_xtable__ }

procedure T__dm_xtable__.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;
  end;
end;

procedure T__dm_xtable__.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'status'
  Then aField.AsString := aField.owner_UiDmxScroller.GetDataSet_Status;
end;

class procedure T__dm_xtable__.test_key_duplicate;
  var
    __dm_xtable__ : T__dm_xtable__;

begin
  try
    __dm_xtable__ := T__dm_xtable__.Create(nil);
    __dm_xtable__.active:=true;
    __dm_xtable__.DmxScroller_Form1.Active :=  true;

    if __dm_xtable__.DmxScroller_Form1.Active
    then with __dm_xtable__ do
         begin
            with DmxScroller_Form1 do
            begin
              DoOnNewRecord;
              FieldByName('id').AsString:='1';
              FieldByName('nome').AsString:='Roberto Hugo';
              if not AddRec
              Then begin
                     Appending:=false;
                     DoOnNewRecord;
                     FieldByName('id').AsString:='3';
                     FieldByName('nome').AsString:='Roberto Hugo';
                     if AddRec
                     then begin
                             FirstRec;
                             ShowMessage('Primeiro ID:'+FieldByName('id').AsString);
                           end;

                   end;
            end;

         end;

  finally
    freeandnil(__dm_xtable__);
  end;
end;

class procedure T__dm_xtable__.test2_key_duplicate;
  var
    __dm_xtable__ : T__dm_xtable__;

begin
  try
    __dm_xtable__ := T__dm_xtable__.Create(nil);
    __dm_xtable__.active:=true;
    __dm_xtable__.DmxScroller_Form1.Active :=  true;

    if __dm_xtable__.DmxScroller_Form1.Active
    then with __dm_xtable__ do
         begin
            with DmxScroller_Form1 do
            begin
              DoOnNewRecord;
              FieldByName('id').AsString:='1';
              FieldByName('nome').AsString:='Roberto Hugo';
              if not AddRec
              Then begin
                     Appending:=false;
                     DoOnNewRecord;
                     FieldByName('id').AsString:='3';
                     FieldByName('nome').AsString:='Roberto Hugo';
                     if AddRec
                     then begin
                             FirstRec;
                             ShowMessage('Primeiro ID:'+FieldByName('id').AsString);
                           end;

                   end;
            end;

         end;

  finally
    freeandnil(__dm_xtable__);
  end;
end;

procedure T__dm_xtable__.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    //Add('"CADASTRO __dm_table__"');
    //add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
   // Add('"Status:        "\ssssssssssssssssssssssssssssssssssssssssssssssssss`ssssssssssssssssssssssssssssssssssssss'+{CharAccSkip+}chFN+'status');
    Add('"ID:            "\LLLLLL'+chFN+'id');
    Add('"Nome:          "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome');
    Add('"endereco       "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco');
    Add('"cnpj           "\##.###.###/####-##'+chFN+'cnpj');
    Add('"cpf            "\###.###.###-##'+chFN+'cpf');
    Add('"cep            "\##.###-###'+chFN+'cep');
    Add('"valor_SMALLINT "\IIIII'+chFN+'valor_SMALLINT');
    Add('"valor_Integer  "\LLLLLLLLLL'+chFN+'valor_Integer');//Maximo:2.147.483.647
    Add('"valor_FLOAT8   "\RRR,RRR.ZZ'+chFN+'valor_FLOAT8');
    Add('"Data_1         "\Ddd/mm/yy'+chFN+'Data_1');
    Add('"hora_1         "\Dhh:nn:ss'+chFN+'hora_1');
    Add('"hora_2         "\Dhh:nn'+chFN+'hora_2');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');

  end;
end;



end.

