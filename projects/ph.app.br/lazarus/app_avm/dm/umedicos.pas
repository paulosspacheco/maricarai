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

{ Tmedicos }

procedure Tmedicos.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;
  end;
end;

procedure Tmedicos.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'status'
  Then aField.AsString := aField.owner_UiDmxScroller.GetDataSet_Status;
end;

class procedure Tmedicos.test_key_duplicate;
  var
    medicos : Tmedicos;

begin
  try
    medicos := Tmedicos.Create(nil);
    medicos.active:=true;
    medicos.DmxScroller_Form1.Active :=  true;

    if medicos.DmxScroller_Form1.Active
    then with medicos do
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
    freeandnil(medicos);
  end;
end;

class procedure Tmedicos.test2_key_duplicate;
  var
    medicos : Tmedicos;

begin
  try
    medicos := Tmedicos.Create(nil);
    medicos.active:=true;
    medicos.DmxScroller_Form1.Active :=  true;

    if medicos.DmxScroller_Form1.Active
    then with medicos do
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
    freeandnil(medicos);
  end;
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
    add('"Telefone da secretária: "\ssssssssssssssssssssssssssssssssss'+chFN+'telefone_da_secretaria');
    add('"Login:                  "\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'login');
    add('"Senha:                  "\sssssssssssssssss`ssssssssssssssssssssssssssssssssssssss'+CharShowPassword+chFN+'senha'); // String(20) //+CharShowPassword
    add('');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');
  end;
end;



end.

