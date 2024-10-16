unit data.module.client.rest;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, ActnList, DB, mi.web.dmxscroller.form.rest.client,
  mi.web.fphttpclient
  ,mi_rtl_ui_Dmxscroller
  ,mi_rtl_ui_dmxscroller_form
  ;

type

  { Tdata_module_client_rest }

  Tdata_module_client_rest = class(TDataModule)
    Cm_Pesquisa_em_outra_tabela: TAction;
    ActionList1: TActionList;
    CmBuildFormFromTemplate: TAction;
    CmCancel: TAction;
    CmDeleteRecord: TAction;
    CmGoBof: TAction;
    CmGoEof: TAction;
    CmNextRecord: TAction;
    CmPrevRecord: TAction;
    CmRefresh: TAction;
    CmUpdateRecord: TAction;
    CmNewRecord: TAction;
    CmLocate: TAction;
    DmxScroller_Form_Rest_Client1: TDmxScroller_Form_Rest_Client;
    Mi_FpHttpClient1: TMi_FpHttpClient;
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
    procedure DataModuleCreate(Sender: TObject);
    function DmxScroller_Form_Rest_Client1GetTemplate(aNext: PSItem): PSItem;

  private

  public

  end;

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

{ Tdata_module_client_rest }
procedure Tdata_module_client_rest.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(Self);
  DmxScroller_Form_Rest_Client1.Active:=true;
end;



function Tdata_module_client_rest.DmxScroller_Form_Rest_Client1GetTemplate(
  aNext: PSItem): PSItem;
begin
  with DmxScroller_Form_Rest_Client1 do
  begin
    result :=
     NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel),
     NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
     NewSItem('~~',
     NewSItem('~ID:            ~\LLLLLL'+ChFN+'id'+CharAccSkip+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,
     NewSItem('~ ~',
     NewSItem('~Nome do aluno: ~\ssssssssssssssssssssssssssss`ssssssssssss'+ChFN+'Nome',
     NewSItem('',
     //NewSItem('~Endereço:      ~\ssssssssssssssssssssssssssss`ssssssssssssssssssssssssssss'+ChFN+'Endereco',
     //NewSItem('~Cep:           ~\##.###-###'+ChFN+'cep',
     //NewSItem('~Cidade:        ~\sssssssssssssssssssssssss'+ChFN+'cidade',
     //NewSItem('~Estado:        ~\SS'+ChFN+'Estado',
     //NewSItem('~ ~',
     //NewSItem('~Idade:         ~'+tmp_Alunos_Idade+CreateExecAction('Idade',
     //                                          Cm_Pesquisa_em_outra_tabela.Name),
     //NewSItem('~Valor:         ~'+'\R$ EEE,EEE,EEE,EEE.EE'+ChFN+'valor_extended', //Extended
     //
     //NewSItem('~Vencimento:    ~\sssssssssss'+ChFN+'vencimento'+ChDf+'Dia 20'+
     //                                           CreateOptions(NewSItem('Dia 10',
     //                                                         NewSItem('Dia 15',
     //                                                         NewSItem('Dia 20',
     //                                                         NewSItem('Dia 25 e 26',
     //                                                         nil)))))+
     //                                           ChH+'O campo dia, é um string com 11 posições. Nota: O número '+
     //                                               'de caracteres do maior item da lista, não pode ter mais'+
     //                                               'de 11 caracteres porque o buffer tem 11 caracteres.',
     //
     //NewSItem('~Tipo de midia: ~'
     //          + CreateEnumField(TRUE, accNormal, 0,
     //                 NewSItem(' indefinido ',
     //                 NewSItem(' HD         ',
     //                 NewSItem(' SSD        ',
     //                 NewSItem(' Pen drive  ',
     //                         nil)))))+ChFN+'midia',
     //
     //
     //
     //NewSItem('~Senha:         ~ \sssssssssssssss'+CharShowPassword+ChFN+'senha'+ChH+'Campo alfanumerico com 15 posicoes',
     //NewSItem('~~',
     //NewSItem('~Qt:            ~\II,III'+chdf+'5'+ChFN+'qt',
     //NewSItem('~Unidade:       ~\'+CreateEnumField(TRUE, accNormal, 1,
     //                                              NewSItem('Centímetro',  //1/100
     //                                              NewSItem('Metro',       //1
     //                                              NewSItem('km',          //100*1000
     //                                              nil))))+ChFN+'unidade',
     //NewSItem('~Preço:         ~\RRR,RRR.zz'+ChAS+ChARO+ChFN+'preco'+ChDf+'10',
     //NewSItem('~Total:         ~\RRR,RRR,RRR.ZZ'+ChARO+ChFN+'valor_total',
     //NewSItem('~Cor:           ~\sssssssssssssss'+ChFN+'cor'+chdf+'Azul claro'+
     //          CreateOptions(NewSItem('sem preferência',
     //                        NewSItem('Azul',
     //                        NewSItem('Amarelo',
     //                        NewSItem('Azul claro',
     //                        nil))))),
     //NewSItem('',
     //NewSItem('~Versão :       ~\##.##.##.####'+ChFN+'versao',
     //NewSItem('',
     //NewSItem('~Tipo Boolean:  ~\X AnsiView                  '+ChFN+'AnsiView',
     //NewSItem('~               ~\X Blaise                    '+ChFN+'Blaise',
     //NewSItem('~               ~\X Btrieve                   '+ChFN+'Btrieve',
     //NewSItem('~               ~\X Paradox Engine            '+ChFN+'Paradox Engine',
     //NewSItem('~               ~\X Topaz                     '+ChFN+'Topaz',
     //NewSItem('~               ~\X Turbo Pascal for Windows  '+ChFN+'Turbo Pascal for Windows',
     //NewSItem('~               ~\X TurboPower                '+ChFN+'TurboPower',
     //NewSItem('',
     //NewSItem('~               ~\Ka Indefinido '+chFN+'sexo',
     //NewSItem('~               ~\Ka Maculino   ',
     //NewSItem('~               ~\Ka Feminino   ',
     //NewSItem('',
     //NewSItem('~               ~\Kb Casado    '+chFN+'EstadoCivil',
     //NewSItem('~               ~\Kb solteiro  ',
     //NewSItem('~               ~\Kb divorciado',
     //NewSItem('',
     //NewSItem('~ ~',
     ////Quando todas as letras são maiúsculas e o alinhamento é a direta
     ////é necessário colocar espaços em branco a direta para compensar o tamanho.
     ////Do contrário o TLabel omite o inicio do lebal pq o texto fica maior
     ////que o a largura do label.
     //NewSItem('~TESTE DE DATAS E HORAS   ~',
     //NewSItem('~ ~',
     //NewSItem('~ Data: dia/mes/ano~',
     //NewSItem('~  dd/mm/yy:        ~\Ddd/mm/yy'+chFN+'ddmmyy',
     //NewSItem('~  dd/mm/yyyy:      ~\Ddd/mm/yyyy'+chFN+'ddmmyyyy',
     //NewSItem('~ ~',
     //NewSItem('~ Horas: Hora:Minutos:Segundos ~',
     //NewSItem('~  hh:nn:ss:        ~\Dhh:nn:ss'+chFN+'hhnnss',
     //NewSItem('~  hh:nn:           ~\Dhh:nn'+chFN+'hhnn'+ChH+'Campo hora e minutos',
     //NewSItem('~ ~',
     //NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
     //NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN  +'ddmmyyhhnnss',
     //NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'ddmmyyyyhhnnss',
     //NewSItem('',
     //NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
     //NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'ddmmyyhhnn',
     //
     //NewSItem('~ ~',

     nil)))))));//)))))))))))))))))))))))))))))))))))))))))))))))))))));
    end;
end;

procedure Tdata_module_client_rest.CmLocateExecute(Sender: TObject);
begin
  //DmxScroller_Form_Rest_Client1.Locate('id','2',[]);
  DmxScroller_Form_Rest_Client1.Locate();
end;

procedure Tdata_module_client_rest.CmDeleteRecordExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.DeleteRec;
end;

procedure Tdata_module_client_rest.CmCancelExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.Cancel;
end;

procedure Tdata_module_client_rest.CmGoBofExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.FirstRec;
end;


procedure Tdata_module_client_rest.CmGoEofExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.LastRec;
end;

procedure Tdata_module_client_rest.CmNewRecordExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.DoOnNewRecord;
end;

procedure Tdata_module_client_rest.CmNextRecordExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.NextRec;
end;

procedure Tdata_module_client_rest.CmPrevRecordExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.PrevRec;
end;

procedure Tdata_module_client_rest.CmRefreshExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.Refresh;
end;

procedure Tdata_module_client_rest.CmUpdateRecordExecute(Sender: TObject);
begin
  DmxScroller_Form_Rest_Client1.UpdateRec;
end;



//function Tdata_module_client_rest.DmxScroller_Form_Rest_Client1GetTemplate(aNext: PSItem): PSItem;
//begin
//
//  //with DmxScroller_Form_Rest_Client1 do
//  //begin
//  //  Result :=
//  //  NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'CmLocate',CmDeleteRecord,CmCancel),
//  //  NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//  //  NewSItem('~~',                                //CharAccReadOnly+
//  //  NewSItem('~ID:            ~\LLLLLL'+chFN+'id'+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,//+CharAccSkip,
//  //  NewSItem('~Nome:          ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'+CharHint+'Campo alfanumérico aceita maiuscula e minuscula',
//  //  NewSItem('~endereco       ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco',
//  //  NewSItem('~cnpj           ~\##.###.###/####-##'+chFN+'cnpj',
//  //  NewSItem('~cpf            ~\###.###.###-##'+chFN+'cpf',
//  //  NewSItem('~cep            ~\##.###-###'+chFN+'cep',
//  //  NewSItem('~valor_SMALLINT ~\IIIII'+chFN+'valor_SMALLINT',
//  //  NewSItem('~valor_Integer  ~\LLL.LLL'+chFN+'valor_Integer',//Maximo:2.147.483.647
//  //  NewSItem('~valor_FLOAT8   ~\RRR,RRR,RRR.RR'+chFN+'valor_FLOAT8',
//  //  NewSItem('~TESTE DE DATAS E HORAS~',
//  //  NewSItem('~ ~',
//  //  NewSItem('~ Data: dia/mes/ano ~',
//  //  NewSItem('~  dd/mm/yy         ~\Ddd/mm/yy'+chFN+'dd_mm_yy',
//  //  NewSItem('~  dd/mm/yyyy       ~\Ddd/mm/yyyy'+chFN+'dd_mm_yyyy',
//  //  NewSItem('~ ~',
//  //  NewSItem('~ Horas: Hora:Minutos:Segundos ~',
//  //  NewSItem('~  hh:nn:ss         ~\Dhh:nn:ss'+chFN+'hh_nn_ss',
//  //  NewSItem('~  hh:nn            ~\Dhh:nn'+chFN+'hh_nn'+ChH+'Campo hora e minutos',
//  //  NewSItem('~ ~',
//  //  NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
//  //  NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN  +'dd_mm_yy_hh_nn_ss',
//  //  NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'dd_mm_yyyy_hh_nn_ss',
//  //  NewSItem('',
//  //  NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
//  //  NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'dd_mm_yy_hh_nn',
//  //  NewSItem('~    dd/mm/yyyy hh:nn:    ~\Ddd/mm/yyyy hh:nn'+chFN+'dd_mm_yyyy_hh_nn',
//  //  NewSItem('',
//  //  NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'',CmDeleteRecord,CmCancel),
//  //  NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
//  //  NewSItem('',
//  //  aNext)))))))))))))))))))))))))))))))));
//  //end;
//
//end;


end.

