unit mi.rtl.web.module;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ActnList,
  httpdefs, fpHTTP, fpWeb, DB,fpJson
  ,mi.rtl.all
  ,mi.rtl.webmodule.base
  ,mi_rtl_ui_Dmxscroller
  ,mi_rtl_ui_dmxscroller_form
  ;

type

  { Tmi_rtl_web_module }

  Tmi_rtl_web_module = class(TMi_rtl_WebModule_base)
    Cm_Pesquisa_em_outra_tabela: TAction;
    procedure Cm_Pesquisa_em_outra_tabelaExecute(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
    function DmxScroller_Form1BeforeInsert(const aUiDmxScroller: TUiDmxScroller
      ): boolean;
    function DmxScroller_Form1BeforeUpdate(const aUiDmxScroller: TUiDmxScroller
      ): boolean;

    procedure DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form1ChangeField(aField: pDmxFieldRec);
    procedure DmxScroller_Form1EnterField(aField: pDmxFieldRec);
    procedure DmxScroller_Form1ExitField(aField: pDmxFieldRec);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
  private
     qt,tipo_de_licenca,preco,valor_total,unidade : pDmxFieldRec;
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

{ Tmi_rtl_web_module }

procedure Tmi_rtl_web_module.DataModuleCreate(Sender: TObject);
begin
  inherited;
  if Not Assigned(DmxScroller_Form1.Mi_ActionList)
  then DmxScroller_Form1.Mi_ActionList := ActionList1;
  DmxScroller_Form1.Active:=true;

  writeLn('Tmi_rtl_web_module.DataModuleCreate: ',TimeToStr(time));
  Flush(output);
end;

function Tmi_rtl_web_module.DmxScroller_Form1BeforeInsert(
  const aUiDmxScroller: TUiDmxScroller): boolean;
begin
  //if not DmxScroller_Form1.ControlsDisabled
  //Then Raise TMi_rtl.TException.Create(self,'DmxScroller_Form1CalcFields','Teste');
  result := true;
end;

function Tmi_rtl_web_module.DmxScroller_Form1BeforeUpdate(
  const aUiDmxScroller: TUiDmxScroller): boolean;
begin
  //if not DmxScroller_Form1.ControlsDisabled
  //Then Raise TMi_rtl.TException.Create(self,'DmxScroller_Form1CalcFields','Teste');
  result := true;
end;

procedure Tmi_rtl_web_module.Cm_Pesquisa_em_outra_tabelaExecute(Sender: TObject);
begin

end;

procedure Tmi_rtl_web_module.DmxScroller_Form1EnterField(aField: pDmxFieldRec);
begin

end;

procedure Tmi_rtl_web_module.DmxScroller_Form1ExitField(aField: pDmxFieldRec);
begin
  DmxScroller_Form1CalcFields(aField^.owner_UiDmxScroller);
end;

procedure Tmi_rtl_web_module.DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);

  // 0 = 1/100
  // 1 = 1
  // 2 = 100*1000
  type
    TUnidade = (unCentimetro,unMetro,unKm);
  var
    Un : TUnidade;
    r : string;
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
    then case TUnidade(unidade^.Value) of
           unCentimetro : begin
                 valor_total^.Value :=qt^.value * preco^.Value * (1/100);
               end;

           unMetro : begin
                 valor_total^.Value :=qt^.value * preco^.Value * 1;
                 r:= valor_total^.Value;
               end;

           unKm : begin
                 valor_total^.Value :=qt^.value  * preco^.Value * (1*1000);
               end;

           else Raise TException.Create(self,'DmxScroller_Form1CalcFields','Parametro inválido no campo unidade');
         end;

  end;
end;

procedure Tmi_rtl_web_module.DmxScroller_Form1ChangeField(aField: pDmxFieldRec);
begin

end;



function Tmi_rtl_web_module.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    result :=
     NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel),
     NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
     NewSItem('~ID:            ~\LLLLLL'+ChFN+'id'+CharAccSkip+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,
     NewSItem('~Nome do aluno: ~\ssssssssssssssssssssssssssss`ssssssssssss'+ChFN+'Nome'+ChDf+'Qual o nome?',
     NewSItem('~Endereço:      ~\ssssssssssssssssssssssssssss`ssssssssssssssssssssssssssss'+ChFN+'Endereco',
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
     //NewSItem('~               ~\Ka Indefinido '+chFN+'sexo',
     //NewSItem('~               ~\Ka Masculino   ',
     //NewSItem('~               ~\Ka Feminino   ',
     //NewSItem('~~\Kb Casado    '+chFN+'EstadoCivil~~\Kc Indefinido'+chFN+'Religiao',
     //NewSItem('~~\Kb solteiro  ~~\Kc Católico',
     //NewSItem('~~\Kb divorciado~~\Kc Evangélico',
     //NewSItem('~ ~',
     //Quando todas as letras são maiúsculas e o alinhamento é a direta
     //é necessário colocar espaços em branco a direta para compensar o tamanho.
     //Do contrário o TLabel omite o inicio do lebal pq o texto fica maior
     //que o a largura do label.
     NewSItem('~TESTE DE DATAS E HORAS   ~',
     //NewSItem('~ ~',
     //NewSItem('~ Data: dia/mes/ano~',
     //NewSItem('~  dd/mm/yy:        ~\Ddd/mm/yy'+chFN+'ddmmyy',
     //NewSItem('~  dd/mm/yyyy:      ~\Ddd/mm/yyyy'+chFN+'ddmmyyyy',
     //NewSItem('~ ~',
     //NewSItem('~ Horas: Hora:Minutos:Segundos ~',
     //NewSItem('~  hh:nn:ss:        ~\Dhh:nn:ss'+chFN+'hhnnss',
     //NewSItem('~  hh:nn:           ~\Dhh:nn'+chFN+'hhnn'+ChH+'Campo hora e minutos',
     //NewSItem('~ ~',
     NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
     NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN  +'ddmmyyhhnnss',
     //NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'ddmmyyyyhhnnss',
     //NewSItem('',
     //NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
     //NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'ddmmyyhhnn',

     NewSItem('~ ~',

     nil)))))))));//)))))))))))))))))))))))))))))))))))))))))))));
    end;


  //with DmxScroller_Form1 do
  //begin
  //  Result :=
  //  NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'CmLocate',CmDeleteRecord,CmCancel),
  //  NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
  //  NewSItem('~~',
  //  NewSItem('~ID:            ~\LLLLLL'+chFN+'id'+CharAccReadOnly+CharPfInKeyPrimary+CharPfInKeyPrimaryAutoIncrement,//+CharAccSkip,
  //  NewSItem('~Nome:          ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'nome'+ChDf+'Nome?'+CharHint+'Campo alfanumérico aceita maiuscula e minuscula',
  //  NewSItem('~endereco       ~\ssssssssssssssssssssssssssssssssssssssssssssssssss'+chFN+'endereco',
  //  NewSItem('~cnpj           ~\##.###.###/####-##'+chFN+'cnpj',
  //  NewSItem('~cpf            ~\###.###.###-##'+chFN+'cpf',
  //  NewSItem('~cep            ~\##.###-###'+chFN+'cep',
  //  NewSItem('~valor_SMALLINT ~\IIIII'+chFN+'valor_SMALLINT',
  //  NewSItem('~valor_Integer  ~\LLL.LLL'+chFN+'valor_Integer',//Maximo:2.147.483.647
  //  NewSItem('~valor_FLOAT8   ~\RRR,RRR,RRR.RR'+chFN+'valor_FLOAT8',
  //  NewSItem('~TESTE DE DATAS E HORAS~',
  //  NewSItem('~ ~',
  //  NewSItem('~ Data: dia/mes/ano ~',
  //  NewSItem('~  dd/mm/yy         ~\Ddd/mm/yy'+chFN+'dd_mm_yy',
  //  NewSItem('~  dd/mm/yyyy       ~\Ddd/mm/yyyy'+chFN+'dd_mm_yyyy',
  //  NewSItem('~ ~',
  //  NewSItem('~ Horas: Hora:Minutos:Segundos ~',
  //  NewSItem('~  hh:nn:ss         ~\Dhh:nn:ss'+chFN+'hh_nn_ss',
  //  NewSItem('~  hh:nn            ~\Dhh:nn'+chFN+'hh_nn'+ChH+'Campo hora e minutos',
  //  NewSItem('~ ~',
  //  NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
  //  NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN  +'dd_mm_yy_hh_nn_ss',
  //  NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'dd_mm_yyyy_hh_nn_ss',
  //  NewSItem('',
  //  NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
  //  NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'dd_mm_yy_hh_nn',
  //  NewSItem('~    dd/mm/yyyy hh:nn:    ~\Ddd/mm/yyyy hh:nn'+chFN+'dd_mm_yyyy_hh_nn',
  //  NewSItem('',
  //  NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,'',CmDeleteRecord,CmCancel),
  //  NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
  //  NewSItem('',
  //  aNext)))))))))))))))))))))))))))))))));
  //end;

end;




initialization
  RegisterHTTPModule('Tmi_rtl_web_module', Tmi_rtl_web_module);

end.

