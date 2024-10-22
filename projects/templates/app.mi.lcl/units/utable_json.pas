unit uTable_Json;

{$mode Delphi}

interface

uses
  Classes, SysUtils, ActnList, uCustomDataMudule, mi_rtl_ui_Dmxscroller,
  mi.rtl.all;

type
  { TTable_Json }

  TTable_Json = class(TCustomDataMudule)
    Cm_Pesquisa_em_outra_tabela: TAction;
    procedure DataModuleCreate(Sender: TObject);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;

  private

  public

  end;

var
  Table_Json: TTable_Json;

Resourcestring

  tmp_Alunos_Idade = '\BB'+TMi_rtl.ChFN+'idade'+TMi_rtl.CharUpperlimit+#64+
                     TMi_rtl.CharHint+'A idade do aluno. Valores válidos 1 a 64'+
                     TMi_rtl.CharHintPorque+'Este campo é necessário para que se agrupe o alunos baseado em sua faixa etária'+
                     TMi_rtl.CharHintOnde+'Ele será usado pelo coordenador ao classificar a turma';

  tmp_Alunos_Matricula = '\IIII'+TMi_rtl.ChFN+'matricula'+TMi_rtl.CharHint+'A matricula do aluno é um campo sequencial e calculado ao incluir o registro';

  tmp_Alunos = '~     Idade:~ %s'+TMi_rtl.lf+
               '~ Matricula:~ %s'+TMi_rtl.lf;

implementation

{$R *.lfm}

{ TTable_Json }

function TTable_Json.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    result :=
             //NewSItem(^A,
             //NewSItem('~ ~',
             //NewSItem('~     ~~ &Novo~'+ChEA+'CmNewRecord'+
             //         '~✔ ️Gravar~'+ChEA+'CmUpdadeRecord'+
             //         '~🔍 &Pesquisar~'+ChEA+'CmLocate'+
             //         '~❌ Excluir~'+ChEA+'CmDeleteRecord',
             //NewSItem('~~',
             NewSItem(GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel),
             NewSItem(GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh),
             NewSItem('~~',
             NewSItem('~ID:            ~\LLLLLL'+ChFN+'id'+CharAccSkip+CharAccReadOnly,
             NewSItem('~ ~',
             NewSItem('~Nome do aluno: ~\ssssssssssssssssssssssssssss`ssssssssssss'+ChFN+'Nome',
             NewSItem('',
             NewSItem('~Endereço:      ~\ssssssssssssssssssssssssssss`ssssssssssssssssssssssssssss'+ChFN+'Endereco',
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
             NewSItem('~Qt:            ~\IIIII'+chdf+'5'+ChFN+'qt',
             NewSItem('~Unidade:       ~\'+CreateEnumField(TRUE, accNormal, 1,NewSItem('Centímetro',  //1/100
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
             NewSItem('~               ~\Ka Masculino   ',
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

             nil))))))))))))))))))))))))))))))))))))))))))))))))))))))))))));
  end;
end;

procedure TTable_Json.DataModuleCreate(Sender: TObject);
begin
  inherited;
end;

end.

