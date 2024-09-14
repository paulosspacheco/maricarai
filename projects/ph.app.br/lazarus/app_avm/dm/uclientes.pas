unit uclientes;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, DB, SQLDB  
  ,mi.rtl.all  
  ,mi_rtl_ui_Dmxscroller  
  ,mi_rtl_ui_dmxscroller_form
 // ,udm_connections
  ,udm_table
  ;

type

  { Tclientes }

  Tclientes = class(Tdm_table)

    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form1EnterField(aField: pDmxFieldRec);
    procedure DmxScroller_Form1NewRecord(aDmxScroller: TUiDmxScroller);


    private

    public
      class procedure test_key_duplicate;
      class procedure test2_key_duplicate;
  end;


implementation

{$R *.lfm}

{ Tclientes }

procedure Tclientes.DmxScroller_Form1Enter(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    if FieldByName('status')<>nil
    Then FieldByName('status')^.AsString := GetDataSet_Status;
  end;
end;

procedure Tclientes.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin
  if aField.FieldName = 'status'
  Then aField.AsString := aField.owner_UiDmxScroller.GetDataSet_Status;
end;

procedure Tclientes.DmxScroller_Form1NewRecord(aDmxScroller: TUiDmxScroller);
begin
  with aDmxScroller do
  begin
    //if FieldByName('datatime')<>nil
    //Then FieldByName('datatime')^.Value := ;
  end;
end;

class procedure Tclientes.test_key_duplicate;
  var
    clientes : Tclientes;

begin
  try
    clientes := Tclientes.Create(nil);
    clientes.active:=true;
    clientes.DmxScroller_Form1.Active :=  true;

    if clientes.DmxScroller_Form1.Active
    then with clientes do
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
    freeandnil(clientes);
  end;
end;

class procedure Tclientes.test2_key_duplicate;
  var
    clientes : Tclientes;

begin
  try
    clientes := Tclientes.Create(nil);
    clientes.active:=true;
    clientes.DmxScroller_Form1.Active :=  true;

    if clientes.DmxScroller_Form1.Active
    then with clientes do
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
    freeandnil(clientes);
  end;
end;

procedure Tclientes.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
begin
  with aUiDmxScroller do
  begin
    add('');
    add(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord));
    add('');
    Add('"ID:                    "\LLLLLL'+chFN+'id');
    Add('"ID_convenio:           "\LLLLLL'+chFN+'id_convenio'+CharHint+'Identificador do plano de saúde do cliente.');
    Add('"Matrícula do convênio: "\'+constStr(50,'s')+chFN+'matricula_no_convenio'+CharHint+'Número do cliente no convênio informado em id_convênio.');
    Add('"Nome do cliente:       "\'+constStr(50,'s')+chFN+'nome');
    Add('"Data cadastro:         "\Ddd/mm/yy'+chFN+'datatime'+CharHint+'Data em que o cliente foi cadastrado. Calculado automáticanente pelo sistema.');
    Add('"Telefone WhatsApp:     "\(##)#-####-####'+chFN+'telefone_whatsapp'+CharHint+'Telefone usado para comunicar-se através do aplicativo WhatsApp.');
    Add('"E-Mail do cliente:     "\'+constStr(50,'s')+chFN+'e_mail'+CharHint+'E-Mail de contato com o cliente.');
    Add('"Login do cliente:      "\'+constStr(50,'s')+chFN+'login'+CharHint+'Nome usado como identificador de acesso ao cadastro do cliente.');
    Add('"Senha do cliente:      "\'+constStr(20,'s')+chFN+'senha'+CharHint+'Senha de acesso ao cadastro do cliente.');
    add('');
    add('');
    add(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh));
    add('');
  end;
end;



end.

