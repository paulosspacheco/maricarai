unit uconvenios;

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

  { Tconvenios }

  Tconvenios = class(Tdm_table)

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

{ Tconvenios }

procedure Tconvenios.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;
  end;
end;

procedure Tconvenios.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'status'
  Then aField.AsString := aField.owner_UiDmxScroller.GetDataSet_Status;
end;

class procedure Tconvenios.test_key_duplicate;
  var
    convenios : Tconvenios;

begin
  try
    convenios := Tconvenios.Create(nil);
    convenios.active:=true;
    convenios.DmxScroller_Form1.Active :=  true;

    if convenios.DmxScroller_Form1.Active
    then with convenios do
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
    freeandnil(convenios);
  end;
end;

class procedure Tconvenios.test2_key_duplicate;
  var
    convenios : Tconvenios;

begin
  try
    convenios := Tconvenios.Create(nil);
    convenios.active:=true;
    convenios.DmxScroller_Form1.Active :=  true;

    if convenios.DmxScroller_Form1.Active
    then with convenios do
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
    freeandnil(convenios);
  end;
end;

procedure Tconvenios.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
    Add('"ID:                       "\LLLLLL'+chFN+'id');
    Add('"ID_médico:                "\LLLLLL'+chFN+'id_medico'+CharHint+'Identificador do médico cadastrado no plano de saúde.');
    Add('"Nome do plano:            "\'+constStr(50,'s')+chFN+'nome');
    Add('"Login do médico no plano: "\'+constStr(50,'s')+chFN+'login'+CharHint+'Nome usado como identificador o médico no plano.');
    Add('"Senha do médico no plano: "\'+constStr(50,'s')+chFN+'senha'+CharHint+'Senha de acesso ao plano de saúde.');
    add('');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');

   // //Add('"CADASTRO "');
   // //add('');
   // add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
   // add('');
   //// Add('"Status:        "\ssssssssssssssssssssssssssssssssssssssssssssssssss`ssssssssssssssssssssssssssssssssssssss'+{CharAccSkip+}chFN+'status');
   // Add('"ID:            "\LLLLLL'+chFN+'id');
   // Add('"Nome:          "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome');
   // Add('"endereco       "\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco');
   // Add('"cnpj           "\##.###.###/####-##'+chFN+'cnpj');
   // Add('"cpf            "\###.###.###-##'+chFN+'cpf');
   // Add('"cep            "\##.###-###'+chFN+'cep');
   // Add('"valor_SMALLINT "\IIIII'+chFN+'valor_SMALLINT');
   // Add('"valor_Integer  "\LLLLLLLLLL'+chFN+'valor_Integer');//Maximo:2.147.483.647
   // Add('"valor_FLOAT8   "\RRR,RRR.ZZ'+chFN+'valor_FLOAT8');
   // Add('"Data_1         "\Ddd/mm/yy'+chFN+'Data_1');
   // Add('"hora_1         "\Dhh:nn:ss'+chFN+'hora_1');
   // Add('"hora_2         "\Dhh:nn'+chFN+'hora_2');
   // add('');
   // add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
   // add('');

  end;
end;



end.

