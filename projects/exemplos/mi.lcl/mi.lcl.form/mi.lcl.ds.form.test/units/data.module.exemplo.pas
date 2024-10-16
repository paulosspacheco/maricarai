unit Data.Module.Exemplo;

{$mode Delphi}

interface

uses
  Classes, SysUtils, fpjson, fpjsondataset, DB, SQLDB, ActnList,
  mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller, mi.rtl.all, Mi_SQLQuery,
  umi_lcl_ui_form;

type

  { TDataModule_Exemplo }

  TDataModule_Exemplo = class(TDataModule)
      Cm_Pesquisa_em_outra_tabela: TAction;
      Action_TestJson: TAction;
      CmCancel: TAction;
    ActionList1: TActionList;
    CmDeleteRecord: TAction;
    CmGoBof: TAction;
    CmGoEof: TAction;
    CmLocate: TAction;
    CmNewRecord: TAction;
    CmNextRecord: TAction;
    CmPrevRecord: TAction;
    CmRefresh: TAction;
    CmUpdateRecord: TAction;
    DmxScroller_Form1: TDmxScroller_Form;

    procedure Action_TestJsonExecute(Sender: TObject);
    procedure CmCancelExecute(Sender: TObject);
    procedure CmDeleteRecordExecute(Sender: TObject);
    procedure CmGoBofExecute(Sender: TObject);
    procedure CmGoEofExecute(Sender: TObject);
    procedure CmLocateExecute(Sender: TObject);
    procedure CmNewRecordExecute(Sender: TObject);
    procedure CmNextRecordExecute(Sender: TObject);
    procedure CmPrevRecordExecute(Sender: TObject);
    procedure CmRefreshExecute(Sender: TObject);
    procedure CmUpdateRecordExecute(Sender: TObject);
    procedure Cm_Pesquisa_em_outra_tabelaExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);

    procedure DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);

    procedure DmxScroller_Form1CloseQuery(aDmxScroller: TUiDmxScroller;
      var CanClose: boolean);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;

    public function Locate(): TModalResult;
    private procedure CalcFields( const aUiDmxScroller: TUiDmxScroller);

  end;

//var
//  DataModule_Exemplo: TDataModule_Exemplo;


Resourcestring

  tmp_Alunos_Idade = '\BB'+ChFN+'idade'+CharUpperlimit+#64+
                     CharHint+'A idade do aluno. Valores válidos 1 a 64'+
                     CharHintPorque+'Este campo é necessário para que se agrupe o alunos baseado em sua faixa etária'+
                     CharHintOnde+'Ele será usado pelo coordenador ao classificar a turma';

  tmp_Alunos_Matricula = '\IIII'+ChFN+'matricula'+CharHint+'A matricula do aluno é um campo sequencial e calculado ao incluir o registro';

  tmp_Alunos = '~     Idade:~ %s'+TDmxScroller_Form.lf+
               '~ Matricula:~ %s'+TDmxScroller_Form.lf;


implementation
{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.lfm}

{ TDataModule_Exemplo }

procedure TDataModule_Exemplo.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(Self);
  DmxScroller_Form1.Active:=true;
end;

procedure TDataModule_Exemplo.CalcFields( const aUiDmxScroller: TUiDmxScroller);
// 0 = 1/100
// 1 = 1
// 2 = 100*1000
  type
    TUnidade = (unCentimetro,unMetro,unKm);
  var
    valor_total,qt,preco,unidade : pDmxFieldRec;
begin
  with aUiDmxScroller do
  begin
    if Assigned(aUiDmxScroller.FieldByName('status'))
    Then aUiDmxScroller.FieldByName('status')^.AsString := GetDataSet_Status;

    valor_total := FieldByName('valor_total');
    qt          := FieldByName('qt');
    preco       := FieldByName('preco');
    unidade     := FieldByName('unidade');

    if Assigned(valor_total) and Assigned(qt) and Assigned(unidade) and Assigned(preco)
    then case TUnidade(unidade.Value) of
           unCentimetro : begin
                 valor_total.Value :=qt.value * preco.Value * (1/100);
               end;

           unMetro : begin
                 valor_total.Value :=qt.value * preco.Value * 1;
               end;

           unKm : begin
                 valor_total.Value :=qt.value  * preco.Value * (1*1000);
               end;

           else Raise TException.Create(self,'DmxScroller_Form1CalcFields','Parametro inválido no campo unidade');
         end;
  end;
end;

//procedure TDataModule_Exemplo.DmxScroller_Form1CalcField(aField: pDmxFieldRec);
//begin                    RectNew
//  CalcFields(aField.owner_UiDmxScroller);
//end;

procedure TDataModule_Exemplo.DmxScroller_Form1CalcFields( const aUiDmxScroller: TUiDmxScroller);
begin
  CalcFields(aUiDmxScroller);
end;


procedure TDataModule_Exemplo.DmxScroller_Form1CloseQuery( aDmxScroller: TUiDmxScroller; var CanClose: boolean);
begin
  With TMi_rtl do
    if Confirm('Confirma','Deseja sair do formulário?')
    Then CanClose := true
    else CanClose := false;
//  CanClose := true;
end;


function TDataModule_Exemplo.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    result :=
   NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel),
   NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
   NewSItem('~~',
   NewSItem('~ID:            ~\LLLLLL'+ChFN+'id'+CharAccSkip+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,
   NewSItem('~ ~',
   NewSItem('~Nome do aluno: ~\ssssssssssssssssssssssssssss`ssssssssssss'+ChFN+'Nome',
   NewSItem('',
   NewSItem('~Endereço:      ~\ssssssssssssssssssssssssssss`ssssssssssssssssssssssssssss'+ChFN+'Endereco',
   NewSItem('~IP:            ~\###.###.###.###'+ChFN+'ip',
   NewSItem('~Cep:           ~\##.###-###'+ChFN+'cep',
   NewSItem('~Cidade:        ~\sssssssssssssssssssssssss'+ChFN+'cidade',
   NewSItem('~Estado:        ~\SS'+ChFN+'Estado',
   NewSItem('~ ~',
   NewSItem('~Idade:         ~'+tmp_Alunos_Idade+CreateExecAction('Idade',
                                             Cm_Pesquisa_em_outra_tabela.Name),
   NewSItem('~Valor:         ~'+'\R$ EEE,EEE,EEE,EEE.EE'+ChFN+'valor_extended', //Extended

   NewSItem('~Vencimento:    ~\sssssssssss'+ChFN+'vencimento'+ChDf+'Dia 20'+
                                              CreateOptions(NewSItem('Dia 10',
                                                            NewSItem('Dia 15',
                                                            NewSItem('Dia 20',
                                                            NewSItem('Dia 25 e 26',
                                                            nil)))))+
                                              ChH+'O campo dia, é um string com 11 posições. Nota: O número '+
                                                  'de caracteres do maior item da lista, não pode ter mais'+
                                                  'de 11 caracteres porque o buffer tem 11 caracteres.',

   NewSItem('~Tipo de midia: ~'
             + CreateEnumField(TRUE, accNormal, 0,
                    NewSItem(' indefinido ',
                    NewSItem(' HD         ',
                    NewSItem(' SSD        ',
                    NewSItem(' Pen drive  ',
                            nil)))))+ChFN+'midia',



   NewSItem('~Senha:         ~ \sssssssssssssss'+CharShowPassword+ChFN+'senha'+ChH+'Campo alfanumerico com 15 posicoes',
   NewSItem('~~',
   NewSItem('~Qt:            ~\II,III'+chdf+'5'+ChFN+'qt',
   NewSItem('~Unidade:       ~\'+CreateEnumField(TRUE, accNormal, 1,
                                                 NewSItem('Centímetro',  //1/100
                                                 NewSItem('Metro',       //1
                                                 NewSItem('km',          //100*1000
                                                 nil))))+ChFN+'unidade',
   NewSItem('~Preço:         ~\RRR,RRR.zz'+ChAS+ChARO+ChFN+'preco'+ChDf+'10',
   NewSItem('~Total:         ~\RRR,RRR,RRR.ZZ'+ChARO+ChFN+'valor_total',
   NewSItem('~Cor:           ~\sssssssssssssss'+ChFN+'cor'+chdf+'Azul claro'+
             CreateOptions(NewSItem('sem preferência',
                           NewSItem('Azul',
                           NewSItem('Amarelo',
                           NewSItem('Azul claro',
                           nil))))),
   NewSItem('',
   NewSItem('~Versão :       ~\##.##.##.####'+ChFN+'versao',
   NewSItem('',
   NewSItem('~Tipo Boolean:  ~\X AnsiView                  '+ChFN+'AnsiView',
   NewSItem('~               ~\X Blaise                    '+ChFN+'Blaise',
   NewSItem('~               ~\X Btrieve                   '+ChFN+'Btrieve',
   NewSItem('~               ~\X Paradox Engine            '+ChFN+'Paradox Engine',
   NewSItem('~               ~\X Topaz                     '+ChFN+'Topaz',
   NewSItem('~               ~\X Turbo Pascal for Windows  '+ChFN+'Turbo Pascal for Windows',
   NewSItem('~               ~\X TurboPower                '+ChFN+'TurboPower',
   NewSItem('',
   NewSItem('~               ~\Ka Indefinido '+chFN+'sexo',
   NewSItem('~               ~\Ka Maculino   ',
   NewSItem('~               ~\Ka Feminino   ',
   NewSItem('',
   NewSItem('~               ~\Kb Casado    '+chFN+'EstadoCivil',
   NewSItem('~               ~\Kb solteiro  ',
   NewSItem('~               ~\Kb divorciado',
   NewSItem('',
   NewSItem('~ ~',
   //Quando todas as letras são maiúsculas e o alinhamento é a direta
   //é necessário colocar espaços em branco a direta para compensar o tamanho.
   //Do contrário o TLabel omite o inicio do lebal pq o texto fica maior
   //que o a largura do label.
   NewSItem('~TESTE DE DATAS E HORAS   ~',
   NewSItem('~ ~',
   NewSItem('~ Data: dia/mes/ano~',
   NewSItem('~  dd/mm/yy:        ~\Ddd/mm/yy'+chFN+'ddmmyy',
   NewSItem('~  dd/mm/yyyy:      ~\Ddd/mm/yyyy'+chFN+'ddmmyyyy',
   NewSItem('~ ~',
   NewSItem('~ Horas: Hora:Minutos:Segundos ~',
   NewSItem('~  hh:nn:ss:        ~\Dhh:nn:ss'+chFN+'hhnnss',
   NewSItem('~  hh:nn:           ~\Dhh:nn'+chFN+'hhnn'+ChH+'Campo hora e minutos',
   NewSItem('~ ~',
   NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
   NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN  +'ddmmyyhhnnss',
   NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'ddmmyyyyhhnnss',
   NewSItem('',
   NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
   NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'ddmmyyhhnn',

   NewSItem('~ ~',

   nil)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
  end;
end;

procedure TDataModule_Exemplo.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DoOnNewRecord;
end;

procedure TDataModule_Exemplo.CmNextRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.NextRec;
end;

procedure TDataModule_Exemplo.CmPrevRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.PrevRec;
end;

procedure TDataModule_Exemplo.CmRefreshExecute(Sender: TObject);
begin
  DmxScroller_Form1.Refresh;
end;

procedure TDataModule_Exemplo.CmDeleteRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.DeleteRec;
end;

procedure TDataModule_Exemplo.CmCancelExecute(Sender: TObject);
begin
  DmxScroller_Form1.Cancel;
end;

procedure TDataModule_Exemplo.Action_TestJsonExecute(Sender: TObject);
begin

end;

procedure TDataModule_Exemplo.CmGoBofExecute(Sender: TObject);
begin
  DmxScroller_Form1.FirstRec;
end;

procedure TDataModule_Exemplo.CmGoEofExecute(Sender: TObject);
begin
  DmxScroller_Form1.LastRec;
end;

procedure TDataModule_Exemplo.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form1.UpdateRec;
end;

procedure TDataModule_Exemplo.Cm_Pesquisa_em_outra_tabelaExecute(Sender: TObject);
begin
  DmxScroller_Form1.ShowMessage('Botão pesquisar pressionado!');
end;

function TDataModule_Exemplo.Locate(): TModalResult;
begin
  result := DmxScroller_Form1.Locate();
end;

procedure TDataModule_Exemplo.CmLocateExecute(Sender: TObject);
begin
  if Locate()= mrNo
  Then TMi_rtl.ShowMessage('Registro não localizado');
end;



end.





//Teste do Test_FirtRec_AddRec_NextRec_PrevRec_LastRec_Json

//function TDataModule_Exemplo.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
//  //Usado para teste da função TDataModule_Exemplo.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec_Json;
//begin
//  with DmxScroller_Form1 do
//  begin
//    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
//    result := NewSItem(^A,
//               NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,cmCancel),
//               NewSItem('~~',
//               NewSItem('~Author  ID: ~\sssssssssss'+ChFN+'id'+CharAccSkip, //+CharAccReadOnly
//               NewSItem('~Nome      : ~\sssssssssssssssssssssssss'+ChFN+'nome',
//               NewSItem('~Endereço  : ~\sssssssssssssssssssssssss'+ChFN+'endereco'+ChDF+'Francisco de Souza Oliveira',
//               NewSItem('~            ~\X Active                '+ChFN+'active'+ChDf+'1',
//               NewSItem('~~',
//               NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//               NewSItem('~~',
//             nil))))))))));
//  end;
//end;

//class procedure TDataModule_Exemplo.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec_Json;
//  var
//    DataModule_Exemplo :TDataModule_Exemplo;
//    s : String;
//    wJSONObject : TJSONObject;
//begin
//  try
//    DataModule_Exemplo := TDataModule_Exemplo.Create(nil);
//    with DataModule_Exemplo.DmxScroller_Form1 do
//    begin
//      if not Active
//      Then Active:=true;
//
//      TMi_rtl.Logs.Warning('TDataModule1.Test_FirtRec_AddRec_Json;');
//      TMi_rtl.Logs.Warning('--------------------------------------------------------');
//      DoOnNewRecord;
//      FieldByName('id').Value:= 1;
//      FieldByName('nome').Value:= 'Paulo Sérgio da Silva Pacheco';
//      TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+'- Nome= '+FieldByName('nome').AsString+')');
//      AddRec;
//
//      DoOnNewRecord;
//      FieldByName('id').Value:= 2;
//      FieldByName('nome').Value:= 'Marcos Venícios da Silva Pacheco';
//      TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+'- Nome= '+FieldByName('nome').AsString+')');
//      AddRec;
//
//      FirstRec;
//      if not eof
//      Then begin
//             wJSONObject := JSONObject;
//             s := FieldByName('id').Value;
//             s := wJSONObject.AsJSON;
//             TMi_rtl.Logs.Warning('JSONObject.AsString='+s+')');
//             FreeAndNil(wJSONObject);
//           end;
//
//      if not eof
//      Then begin
//             NextRec;
//             wJSONObject := JSONObject;
//             s := wJSONObject.AsJSON;
//             TMi_rtl.Logs.Warning('JSONObject.AsJson='+s+')');
//             FreeAndNil(wJSONObject);
//           end;
//    end;
//
//  finally
//    FreeAndNil(DataModule_Exemplo);
//  end;
//
//end;
//

//
//
//testes

//function TDataModule_Exemplo.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
//begin
//  with DmxScroller_Form1 do
//  begin
//    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
//    result :=
//             NewSItem(^A,
//             NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord),
//             NewSItem('',
//             NewSItem('~~',
//             NewSItem('~ID:       ~\LLLLLL'+ChFN+'id',
//             NewSItem('~Nome:     ~\sssssssssssssssssssssssss`sssssssssssssssssssssssss'+ChFN+'nome'+chDF+'Qual o seu nome?',
//             NewSItem('~Endereço: ~\sssssssssssssssssssssssss`sssssssssssssssssssssssss'+ChFN+'endereco'+chDF+'Qual o seu endereço?',
//             NewSItem('~Ativo:    ~ \X '+ChFN+'active',
//             NewSItem('~~',
//             NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//             NewSItem('~~',
//             nil)))))))))));
//  end;
//end;

//testes

//function TDataModule_Exemplo.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
//begin
//  with DmxScroller_Form1 do
//  begin
//    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
//    result :=
//             NewSItem(^A,
//             NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord),
//             NewSItem('',
//             NewSItem('~~',
//             NewSItem('~CEP:  ~\##.###-###'+ChFN+'cep'+ChDf+'61624300',
//             NewSItem('~CNPJ: ~\##.###.###/####-##'+ChFN+'cnpj'+ChDf+'01100200000150',
//             NewSItem('~fone: ~\(##) # #### ####'+ChFN+'fone'+ChDf+'85997024498',
//             NewSItem('~CPF:  ~\###.###.###-##'+ChFN+'cpf'+ChDf+'14149621349',
//             NewSItem('~Valor real4     :~\OO,OOO.O'+ChFN+'valorreal4'+chDF+'100,15',
//             NewSItem('~Valor Extented:~\EEE,ERE,EEE.EE'+ChFN+'valorextended'+chDF+'100,15',
//             NewSItem('~Valor Float   :~\RRR,RRR,RRR.RR'+ChFN+'valorfloat'+chDF+'100,15',
//             NewSItem('~Valor smallInt :~\II,III'+ChFN+'valorSmallint'+chDF+'2500',
//             NewSItem('~Valor Longint  :~\L,LLL,LLL,LLL'+ChFN+'valorLongint'+chDF+'125000',
//             NewSItem('~Alfanumérico: ~\sssssssssssssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'string1'+ChDf+'Paulo Sérgio'+ChH+'Alfanumérico pode receber maiuscula e minuscula com visibilidade na posição 25.',
//             NewSItem('~Data_1~\Ddd/mm/yyyy'+chFN+'Data_1'+ChDf+'22061958',
//             NewSItem('~Data_2~\Ddd/mm/yy'+chFN+'Data_2'+ChDf+'220658',
//             NewSItem('~~',
//             NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//             NewSItem('~~',
//             nil)))))))))))))))))));
//  end;
//end;


//class procedure TDataModule_Exemplo.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec;
//  var
//    Data️Module1 :TDataModule_Exemplo;
//    s : string;
//    i : Integer;
//begin
//  try
//    DataModule_Exemplo := TDataModule_Exemplo.Create(nil);
//    with DataModule_Exemplo.DmxScroller_Form1 do
//    if active then
//    begin
//      TMi_rtl.Logs.Warning('TDataModule1.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec');
//      TMi_rtl.Logs.Warning('--------------------------------------------------------');
//      DoOnNewRecord;
//      FieldByName('nome').Value:= 'Paulo Sérgio da Silva Pacheco';
//      if not AddRec
//      then raise Exception.Create('Não posso adcionar o registro.')
//      else TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+' | Nome: '+FieldByName('nome').AsString+')');
//
//      DoOnNewRecord;
//      FieldByName('nome').Value:= 'Marcos Venícios da Silva Pacheco';
//      if not AddRec
//      then raise Exception.Create('Não posso adcionar o registro.')
//      else TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+' | Nome: '+FieldByName('nome').AsString+')');
//
//      for i := 0 to 20 do
//      begin
//        DoOnNewRecord;
//        FieldByName('nome').Value:= 'Nome: '+IStr(i,'III');
//        if not AddRec
//        then Raise Exception.Create('Erro ao adicionar registro');
//      end;
//
//      FirstRec;
//      if not eof
//      Then begin
//             TMi_rtl.Logs.Warning('FirstRec(id:'+FieldByName('id').AsString+' | Nome= '+FieldByName('nome').AsString+')');
//           end;
//
//      while not eof do
//      begin
//       NextRec;
//       if not eof
//       Then TMi_rtl.Logs.Warning('NextRec(id:'+FieldByName('id').AsString+' | Nome= '+FieldByName('nome').AsString+')');
//      end;
//
//    end;
//
//  finally
//    FreeAndNil(DataModule_Exemplo);
//  end;
//
//end;
//function TDataModule_Exemplo.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
//begin
//  with DmxScroller_Form1 do
//  begin
//    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
//    result :=
//       NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel),
//       NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//       NewSItem('~~',
//       NewSItem('~ID:   ~\LLLLLL'+ChFN+'id'+CharAccSkip+CharAccReadOnly+ChH+'Esse identificador é calculado automaticamente',
//       NewSItem('~Nome: ~\sssssssssssssssssssssssss`ssssssssssssssssssssssssssssss'+ChFN+'nome'+
//                ChH+'Alfanumérico pode receber maiuscula e minuscula com visibilidade na posição 25.',
//       NewSItem('~CEP:  ~\##.###-###'+ChFN+'cep',
//       NewSItem('~CNPJ: ~\##.###.###/####-##'+ChFN+'cnpj',
//       NewSItem('~fone: ~\(##) # #### ####'+ChFN+'fone',
//       NewSItem('~CPF:  ~\###.###.###-##'+ChFN+'cpf',
//       NewSItem('~Valor real4:    ~\OO,OOO.O'+ChFN+'valorreal4',
//       NewSItem('~Valor Extented: ~\EEE,ERE,EEE.EE'+ChFN+'valorextended',
//       NewSItem('~Valor Float:    ~\RRR,RRR,RRR.RR'+ChFN+'valorfloat',
//       NewSItem('~Valor smallInt: ~\II,III'+ChFN+'valorSmallint',
//       NewSItem('~Valor Longint:  ~\L,LLL,LLL,LLL'+ChFN+'valorLongint',
//       NewSItem('~Data_1:         ~\Ddd/mm/yyyy'+chFN+'Data_1',
//       NewSItem('~Data_2:         ~\Ddd/mm/yy'+chFN+'Data_2',
//       NewSItem('~hora_1          ~\Dhh:nn:ss'+chFN+'hora_1',
//       NewSItem('~hora_2          ~\Dhh:nn'+chFN+'hora_2',
//
//       NewSItem('~~',
//
//       NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel),
//       NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//       NewSItem('~~',
//       nil))))))))))))))))))))));
//  end;
//end;

//const
//  // this is the sample JSON data used in the demo
//  JSON_STRING = '['
//               +'{"id":"409-56-7008","nome":"Bennet","endereco":"Abraham" ,"Active": False},'
//               +'{"id":"213-46-8915","nome":"Green" ,"endereco":"Marjorie","Active": True}'    +']';

//procedure TDataModule_Exemplo.DataModuleCreate(Sender: TObject);
//  var
//    data: TJSONArray;
//  begin
//    // parse the JSON string
//    data := GetJSON(JSON_STRING) as TJSONArray;
//    // create a new TJSONDataSet
//    JSONDataSet := TJSONDataSet.Create(Self);
//    // you'll need to create the FieldDefs manually
//    // ftString requires a length specified
//    JSONDataSet.FieldDefs.Add('id', ftString, 11, True);
//    JSONDataSet.FieldDefs.Add('nome', ftString, 40);
//    JSONDataSet.FieldDefs.Add('endereco', ftString, 20);
//    JSONDataSet.FieldDefs.Add('active', ftBoolean);
//    // set OwnsData to True, and the JSON data will be
//    // set OwnsData to True, and the JSON data will be destroyed when the dataset is destroyed
//    JSONDataSet.OwnsData := True;
//    // the JSON data is an array of objects
//    JSONDataSet.RowType := rtJSONObject;
//    // assign the JSON data to the dataset
//    JSONDataSet.Rows := data;
//    // activate the dataset
//    JSONDataSet.Active := True;
//    // assign the dataset to the datasource
//    DataSource1.DataSet := JSONDataSet;
//
//    DmxScroller_Form1.Active:=false;
//    //if Not Assigned(DmxScroller_Form1.Mi_ActionList)
//    //Then DmxScroller_Form1.Mi_ActionList := ActionList1;
//end;

//procedure TDataModule_Exemplo.DataModuleDestroy(Sender: TObject);
//begin
// JSONDataSet.free;
//end;

//procedure TDataModule_Exemplo.Action_TestJsonExecute(Sender: TObject);
//begin
//  Test_FirtRec_AddRec_NextRec_PrevRec_LastRec_Json;
//end;

