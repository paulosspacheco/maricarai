unit Unit2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, BufDataset, dbf, SdfData, fpjson, fpjsondataset,
  ActnList, mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller, mi.rtl.all;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
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
    DataSource1: TDataSource;
    DmxScroller_Form1: TDmxScroller_Form;
    Excluir: TAction;
    Pesquisar: TAction;
    Gravar: TAction;
    Novo: TAction;
//    procedure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );


    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;

    public
    //private  JSONDataSet: TJSONDataSet;
    public  class procedure Test_FirtRec_AddRec_NextRec_PrevRec_LastRec;
    public  class procedure Test_FirtRec_AddRec_NextRec_PrevRec_LastRec_Json;
  end;

//var
//  DataModule1: TDataModule1;

const
  // this is the sample JSON data used in the demo
  JSON_STRING = '['
               +'{"id":"409-56-7008","nome":"Bennet","endereco":"Abraham" ,"Active": False},'
               +'{"id":"213-46-8915","nome":"Green" ,"endereco":"Marjorie","Active": True}'    +']';

Resourcestring

  tmp_Alunos_Idade = '\BB'+ChFN+'idade'+CharUpperlimit+#64+
                     CharHint+'A idade do aluno. Valores válidos 1 a 64'+
                     CharHintPorque+'Este campo é necessário para que se agrupe o alunos baseado em sua faixa etária'+
                     CharHintOnde+'Ele será usado pelo coordenador ao classificar a turma';
  tmp_Alunos_Matricula = '\IIII'+ChFN+'matricula'+CharHint+'A matricula do aluno é um campo sequencial e calculado ao incluir o registro';

  tmp_Alunos = '~     Idade:~ %s'+TDmxScroller_Form.lf+
               '~ Matricula:~ %s'+TDmxScroller_Form.lf;


implementation

{$R *.lfm}

{ TDataModule1 }
procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  //RemoveDataModule(Self);
  DmxScroller_Form1.Active:=true;
 end;

procedure TDataModule1.DataModuleDestroy(Sender: TObject);
begin
  DmxScroller_Form1.Active:=False;
end;

//procedure TDataModule1.DataModuleCreate(Sender: TObject);
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

//procedure TDataModule1.DataModuleDestroy(Sender: TObject);
//begin
// JSONDataSet.free;
//end;

//procedure TDataModule1.CalcFields( const aUiDmxScroller: TUiDmxScroller);
//// 0 = 1/100
//// 1 = 1
//// 2 = 100*1000
//  type
//    TUnidade = (unCentimetro,unMetro,unKm);
//  var
//    valor_total,qt,preco,unidade : pDmxFieldRec;
//begin
//  with aUiDmxScroller do
//  begin
//    if Assigned(aUiDmxScroller.FieldByName('status'))
//    Then aUiDmxScroller.FieldByName('status')^.AsString := GetDataSet_Status;
//
//    valor_total := FieldByName('valor_total');
//    qt          := FieldByName('qt');
//    preco       := FieldByName('preco');
//    unidade     := FieldByName('unidade');
//
//    if Assigned(valor_total) and Assigned(qt) and Assigned(unidade) and Assigned(preco)
//    then case TUnidade(unidade.Value) of
//           unCentimetro : begin
//                 valor_total.Value :=qt.value * preco.Value * (1/100);
//               end;
//
//           unMetro : begin
//                 valor_total.Value :=qt.value * preco.Value * 1;
//               end;
//
//           unKm : begin
//                 valor_total.Value :=qt.value  * preco.Value * (1*1000);
//               end;
//
//           else Raise TException.Create(self,'DmxScroller_Form1CalcFields','Parametro inválido no campo unidade');
//         end;
//  end;
//end;
//
//procedure TDataModule1.DmxScroller_Form1CalcField(aField: pDmxFieldRec);
//begin
//  CalcFields(aField.owner_UiDmxScroller);
//end;
//
//
//
//procedure TDataModule1.DmxScroller_Form1CalcFields( const aUiDmxScroller: TUiDmxScroller);
//begin
//  CalcFields(aUiDmxScroller);
//end;
//
//procedure TDataModule1.DmxScroller_Form1ChangeField(aField: pDmxFieldRec);
//begin
// //  DmxScroller_Form1.ShowMessage('OnChangeField: '+aField.AsString);
//end;
//
//procedure TDataModule1.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
//begin
// // DmxScroller_Form1.ShowMessage(aField.AsString);
//end;
//
//procedure TDataModule1.DmxScroller_Form1ExitField(aField: pDmxFieldRec);
//begin
////  DmxScroller_Form1.ShowMessage(aField.AsString);
//end;
//
//
//procedure TDataModule1.ExcluirExecute(Sender: TObject);
//begin
//  DmxScroller_Form1.DeleteRec;
//end;
//
//procedure TDataModule1.GravarExecute(Sender: TObject);
//begin
//  DmxScroller_Form1.UpdateRec_if_RecordAltered;
//end;
//
//procedure TDataModule1.NovoExecute(Sender: TObject);
//begin
//  DmxScroller_Form1.DoOnNewRecord;
//end;
//
//procedure TDataModule1.PesquisarExecute(Sender: TObject);
//begin
//  DmxScroller_Form1.ShowMessage('Botão pesquisar pressionado!');
//end;
//
//testes

function TDataModule1.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
    result := NewSItem(^A,
               NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmLocate),
               NewSItem('',
               NewSItem('~~',
               NewSItem('~Author  ID: ~\sssssssssss'+ChFN+'id',
               NewSItem('~Nome      : ~\sssssssssssssssssssssssss'+ChFN+'nome',
               NewSItem('~Endereço  : ~\sssssssssssssssssssssssss'+ChFN+'endereco'+ChDF+'Francisco de Souza Oliveira',
               NewSItem('~            ~\X Active                '+ChFN+'active'+ChDf+'1',
               NewSItem('~~',
               NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
               NewSItem('~~',
             nil)))))))))));
  end;
end;


//testes
//function TDataModule1.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
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
//             NewSItem('~Valor real4     :~\OOO,OOO.OO'+ChFN+'valorreal4'+chDF+'1879,45',
//             NewSItem('~Valor Extented:~\EEE,ERE,EEE.EE'+ChFN+'valorextended'+chDF+'4444555,78',
//             NewSItem('~Valor Float   :~\RRR,RRR,RRR.RR'+ChFN+'valorfloat'+chDF+'1254,78',
//             NewSItem('~Valor smallInt :~\II,III'+ChFN+'valorSmallint'+chDF+'12547',
//             NewSItem('~Valor Longint  :~\L,LLL,LLL,LLL'+ChFN+'valorLongint'+chDF+'1245789',
//             NewSItem('~test: ~\ss-SSSSS-####'+ChFN+'teste'+ChDf+'paCEARA1958',
//             NewSItem('~Data_1~\Ddd/mm/yyyy'+chFN+'Data_1'+ChDf+'22061958',
//             NewSItem('~~',
//             NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//             NewSItem('~~',
//             nil))))))))))))))))));
//  end;
//end;

//function TDataModule1.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
//begin
//  with DmxScroller_Form1 do
//  begin
//    AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;
//    AlignmentLabels:= taCenter;//taLeftJustify;taRightJustify;
//    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
//    result :=
//             NewSItem(^A,
//             NewSItem('~ ~',
//             NewSItem('~     ~~ &Novo~'+ChEA+Novo.Name+
//                      '~✔ ️Gravar~'+ChEA+(Gravar.Name)+
//                      '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
//                      '~❌ Excluir~'+ChEA+(Excluir.Name),
//             NewSItem('~~',
//             NewSItem('~Status:    ~\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'status',//+CharAccReadOnly+CharAccSkip,
//             NewSItem('~ ~',
//             NewSItem('~Idade:     ~'+tmp_Alunos_Idade+CreateExecAction('Idade',Pesquisar.Name),
//             NewSItem('~Valor:     ~'+'\R$ EEE,EEE,EEE,EEE.EE'+ChFN+'valor_extended', //Extended
//             NewSItem('~Vencimento:~\sssssssssss'+ChFN+'vencimento'+ChDf+'Dia 20'+
//                                                        CreateOptions(NewSItem('Dia 10',
//                                                                      NewSItem('Dia 15',
//                                                                      NewSItem('Dia 20',
//                                                                      NewSItem('Dia 25 e 26',
//                                                                      nil)))))+
//                                                        ChH+'O campo dia, é um string com 11 posições. Nota: O número '+
//                                                            'de caracteres do maior item da lista, não pode ter mais'+
//                                                            'de 11 caracteres porque o buffer tem 11 caracteres.',
//             NewSItem('~Senha:     ~ \sssssssssssssss'+CharShowPassword+ChFN+'senha'+ChH+'Campo alfanumerico com 15 posicoes',
//             NewSItem('~~',
//             NewSItem('~Qt:        ~\IIIII'+chdf+'5'+ChFN+'qt',
//             NewSItem('~Unidade:   ~\'+CreateEnumField(TRUE, accNormal, 1,NewSItem('Centímetro',  //1/100
//                                                           NewSItem('Metro',       //1
//                                                           NewSItem('km',          //100*1000
//                                                                   nil))))+ChFN+'unidade',
//             NewSItem('~Preço:     ~\RRR,RRR.zz'+ChAS+ChARO+ChFN+'preco'+ChDf+'10',
//             NewSItem('~Total:     ~\RRR,RRR,RRR.ZZ'+ChARO+ChFN+'valor_total',
//             NewSItem('~Cor:       ~\sssssssssssssss'+ChFN+'cor'+chdf+'Azul claro'+
//                       CreateOptions(NewSItem('sem preferência',
//                                     NewSItem('Azul',
//                                     NewSItem('Amarelo',
//                                     NewSItem('Azul claro',
//                                     nil))))),
//             NewSItem('',
//             NewSItem('~Versão :~\##.##.##.####'+ChFN+'versao',
//             NewSItem('',
//             NewSItem('~List tools that you use:       ',
//             NewSItem('   \X AnsiView                  '+ChFN+'AnsiView',
//             NewSItem('   \X Blaise                    '+ChFN+'Blaise',
//             NewSItem('   \X Btrieve                   '+ChFN+'Btrieve',
//             NewSItem('   \X Paradox Engine            '+ChFN+'Paradox Engine',
//             NewSItem('   \X Topaz                     '+ChFN+'Topaz',
//             NewSItem('   \X Turbo Pascal for Windows  '+ChFN+'Turbo Pascal for Windows',
//             NewSItem('   \X TurboPower                '+ChFN+'TurboPower',
//             NewSItem('',
//             NewSItem('',
//             NewSItem('~     Others:~\ssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'outros1',
//             NewSItem('~            ~\ssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'outros2',
//             NewSItem('~            ~\ssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'outros3',
//             NewSItem('~ ~',
//             NewSItem('~Nome do aluno: ~\ssssssssssssssssssssssssssss'+ChFN+'Nome',
//             NewSItem('',
//             NewSItem('~     Endereço: ~\ssssssssssssssssssssssssssss'+ChFN+'Endereco',
//             NewSItem('~          Cep: ~\##.###-###'+ChFN+'cep',
//             NewSItem('~       Cidade: ~\sssssssssssssssssssssssss'+ChFN+'cidade',
//             NewSItem('~       Estado: ~\SS'+ChFN+'Estado',
//             NewSItem('',
//             NewSItem('~~\Ka Indefinido '+chFN+'sexo',
//             NewSItem('~~\Ka Maculino   ',
//             NewSItem('~~\Ka Feminino   ',
//             NewSItem('',
//             NewSItem('~~\Kb Casado    '+chFN+'EstadoCivil',
//             NewSItem('~~\Kb solteiro  ',
//             NewSItem('~~\Kb divorciado',
//             NewSItem('',
//             NewSItem('~ ~',
//             NewSItem('~TESTE DE DATAS E HORAS~',
//             NewSItem('~ ~',
//             NewSItem('~ Data: dia/mes/ano ~',
//             NewSItem('~    Data_1         ~\Ddd/mm/yy'+chFN+'Data_1',
//             NewSItem('~    Data_2         ~\Ddd/mm/yyyy'+chFN+'Data_2',
//             NewSItem('~ ~',
//             NewSItem('~ Data: ano/mes/dia ~',
//             NewSItem('~    Data_3         ~\Dyy/mm/dd'+chFN+'Data_3',
//             NewSItem('~    Data_4         ~\Dyyyy/mm/dd'+chFN+'Data_4',
//             NewSItem('~ ~',
//             NewSItem('~ Horas: dia/mes/ano ~',
//             NewSItem('~    hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
//             NewSItem('~    hora_2         ~\Dhh:nn'+chFN+'hora_2'+ChH+'Campo hora e minutos',
//             NewSItem('~ ~',
//             NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
//             NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN+'DateTime_1',
//             NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'DateTime_2',
//             NewSItem('',
//             NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
//             NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'DateTime_3',
//             NewSItem('~    dd/mm/yyyy hh:nn:ss    ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'DateTime_4',
//             NewSItem('~ ~',
//             nil)))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
//  end;
//end;
//

class procedure TDataModule1.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec;
  var
    DataModule1 :TDataModule1;
    s : string;
    i : Integer;
begin
  try
    DataModule1 := TDataModule1.Create(nil);
    with DataModule1.DmxScroller_Form1 do
    if active then
    begin
      TMi_rtl.Logs.Warning('TDataModule1.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec');
      TMi_rtl.Logs.Warning('--------------------------------------------------------');
      DoOnNewRecord;
      FieldByName('nome').Value:= 'Paulo Sérgio da Silva Pacheco';
      if not AddRec
      then raise Exception.Create('Não posso adcionar o registro.')
      else TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+' | Nome: '+FieldByName('nome').AsString+')');

      DoOnNewRecord;
      FieldByName('nome').Value:= 'Marcos Venícios da Silva Pacheco';
      if not AddRec
      then raise Exception.Create('Não posso adcionar o registro.')
      else TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+' | Nome: '+FieldByName('nome').AsString+')');

      for i := 0 to 20 do
      begin
        DoOnNewRecord;
        FieldByName('nome').Value:= 'Nome: '+IStr(i,'III');
        if not AddRec
        then Raise Exception.Create('Erro ao adicionar registro');
      end;

      FirstRec;
      if not eof
      Then begin
             TMi_rtl.Logs.Warning('FirstRec(id:'+FieldByName('id').AsString+' | Nome= '+FieldByName('nome').AsString+')');
           end;

      while not eof do
      begin
       NextRec;
       if not eof
       Then TMi_rtl.Logs.Warning('NextRec(id:'+FieldByName('id').AsString+' | Nome= '+FieldByName('nome').AsString+')');
      end;

    end;

  finally
    FreeAndNil(DataModule1);
  end;

end;



//procedure TDataModule1.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec;
//  var
//    s : string;
//    i : Integer;
//    MaxRecord : integer = 0;
//begin
//  with DmxScroller_Form1 do
//  if active then
//  begin
//    TMi_rtl.Logs.Warning('TDataModule1.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec');
//    TMi_rtl.Logs.Warning('--------------------------------------------------------');
//    for i := 0 to MaxRecord do
//    begin
//      DoOnNewRecord;
//      FieldByName('nome').Value:= 'Nome: '+IStr(i,'III');
//      if not AddRec
//      then Raise Exception.Create('Erro ao adicionar registro');
//    end;
//
//    FirstRec;
//    if not eof
//    Then TMi_rtl.Logs.Warning('FirstRec(id:'+FieldByName('id').AsString+' | Nome= '+FieldByName('nome').AsString+')');
//
//    while not eof do
//    begin
//     NextRec;
//     if not eof
//     Then TMi_rtl.Logs.Warning('NextRec(id:'+FieldByName('id').AsString+' | Nome= '+FieldByName('nome').AsString+')');
//    end;
//
//  end;
//end;
//


class procedure TDataModule1.Test_FirtRec_AddRec_NextRec_PrevRec_LastRec_Json;
  var
    DataModule1 :TDataModule1;
    s : String;
    wJSONObject : TJSONObject;
begin
  try
    DataModule1 := TDataModule1.Create(nil);
    with DataModule1.DmxScroller_Form1 do
    begin
//      Active:=true;
      TMi_rtl.Logs.Warning('TDataModule1.Test_FirtRec_AddRec_Json;');
      TMi_rtl.Logs.Warning('--------------------------------------------------------');
      DoOnNewRecord;
      FieldByName('id').Value:= 1;
      FieldByName('nome').Value:= 'Paulo Sérgio da Silva Pacheco';
      TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+'- Nome= '+FieldByName('nome').AsString+')');
      AddRec;

      DoOnNewRecord;
      FieldByName('id').Value:= 2;
      FieldByName('nome').Value:= 'Marcos Venícios da Silva Pacheco';
      TMi_rtl.Logs.Warning('AddRec(id:'+FieldByName('id').AsString+'- Nome= '+FieldByName('nome').AsString+')');
      AddRec;

      FirstRec;
      if not eof
      Then begin
             wJSONObject := JSONObject;
             s := FieldByName('id').Value;
             s := wJSONObject.AsJSON;
             TMi_rtl.Logs.Warning('JSONObject.AsString='+s+')');
             FreeAndNil(wJSONObject);
           end;

      if not eof
      Then begin
             NextRec;
             wJSONObject := JSONObject;
             s := wJSONObject.AsJSON;
             TMi_rtl.Logs.Warning('JSONObject.AsJson='+s+')');
             FreeAndNil(wJSONObject);
           end;

      //Active:=false;
    end;

  finally
    FreeAndNil(DataModule1);
  end;

end;


end.


