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
    procedure DmxScroller_Form1EnterField(aField: pDmxFieldRec);

    private
      class procedure test_key_duplicate;
      class procedure test2_key_duplicate;
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

procedure Toperadores.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'status'
  Then aField.AsString := aField.owner_UiDmxScroller.GetDataSet_Status;
end;




procedure Toperadores.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,cmCancel));
    add('');
    add('"id:        "\LLLLLL'+chFN+'id'+CharAccSkip);
    add('"nome:      "\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'); // String(50)
    add('"Login:     "\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'login'); // String(50)
    add('"Password:  "\sssssssssssssssss`ssssssssssssssssssssssssssssssssssssss'+CharShowPassword+chFN+'password'); // String(20) //+CharShowPassword
    add('"telefone:  "\##-#####-####'+chFN+'telefone'); // String(20)
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');
  end;
end;


class procedure Toperadores.test_key_duplicate;
  var
    operadores : Toperadores;

begin
  try
    operadores := Toperadores.Create(nil);
    operadores.active:=true;
    operadores.DmxScroller_Form1.Active :=  true;

    if operadores.DmxScroller_Form1.Active
    then with operadores do
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
    freeandnil(operadores);
  end;
end;

class procedure Toperadores.test2_key_duplicate;
  var
    operadores : Toperadores;

begin
  try
    operadores := Toperadores.Create(nil);
    operadores.active:=true;
    operadores.DmxScroller_Form1.Active :=  true;

    if operadores.DmxScroller_Form1.Active
    then with operadores do
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
    freeandnil(operadores);
  end;
end;


end.

