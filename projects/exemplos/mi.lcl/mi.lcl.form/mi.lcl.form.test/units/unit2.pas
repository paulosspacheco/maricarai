unit Unit2;

{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, BufDataset, memds, dbf, SdfData, ActnList,
  mi_rtl_ui_dmxscroller_form, mi_rtl_ui_Dmxscroller;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    DmxScroller_Form1: TDmxScroller_Form;
    Excluir: TAction;
    FixedFormatDataSet1Line: TStringField;
    Pesquisar: TAction;
    Gravar: TAction;
    Novo: TAction;
    ActionList1: TActionList;
//    proc0edure DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller      );
    procedure DataModuleCreate(Sender: TObject);
    procedure DmxScroller_Form1CalcField(aField: pDmxFieldRec);
    procedure DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form1ChangeField(aField: pDmxFieldRec);

    procedure DmxScroller_Form1ExitField(aField: pDmxFieldRec);
    function DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
    procedure ExcluirExecute(Sender: TObject);
    procedure FixedFormatDataSet1LineChange(Sender: TField);
    procedure GravarExecute(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure PesquisarExecute(Sender: TObject);

  private
    function  TestUmTipo(aNext: PSItem) : PSItem;
    function  Heading(aNext: PSItem) : PSItem;
    function  Information(Next: PSItem) : PSItem;
    function  Instructions(Next: PSItem) : PSItem;
    function  ClientInfo(ANext: PSItem) : PSItem;
    function  FormAluno(aNext: PSItem) : PSItem;
    function  TestLabel(aNext: PSItem) : PSItem;
    function Cadastro(aNext: PSItem): PSItem;
    function TestDateTime(aNext: PSItem): PSItem;
    function Test_Mask(aNext: PSItem): PSItem;
  public


    private procedure CalcFields( const aUiDmxScroller: TUiDmxScroller);
  end;

var
  DataModule1: TDataModule1;


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

Var
  qt,tipo_de_licenca,preco,valor_total: pDmxFieldRec;

{ TDataModule1 }

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  RemoveDataModule(Self);
  DmxScroller_Form1.Active:=true;
end;


procedure TDataModule1.CalcFields( const aUiDmxScroller: TUiDmxScroller);
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


procedure TDataModule1.DmxScroller_Form1ExitField(aField: pDmxFieldRec);
begin
end;

procedure TDataModule1.DmxScroller_Form1CalcField(aField: pDmxFieldRec);
begin
  CalcFields(aField.owner_UiDmxScroller);
end;

procedure TDataModule1.DmxScroller_Form1CalcFields(const aUiDmxScroller: TUiDmxScroller);
begin
 CalcFields(aUiDmxScroller);
end;

procedure TDataModule1.DmxScroller_Form1ChangeField(aField: pDmxFieldRec);
begin
//  DmxScroller_Form1.ShowMessage('OnChangeField: Campo: '+aField.FieldName+' - Value Atual:'+aField.Value);
end;

procedure TDataModule1.ExcluirExecute(Sender: TObject);
begin
  DmxScroller_Form1.ShowMessage('Botão Excluir pressionando!');
end;

procedure TDataModule1.FixedFormatDataSet1LineChange(Sender: TField);
begin

end;

procedure TDataModule1.GravarExecute(Sender: TObject);
begin
  DmxScroller_Form1.ShowMessage('Botão graver pressionando!');
end;

procedure TDataModule1.NovoExecute(Sender: TObject);
begin
  DmxScroller_Form1.ShowMessage('Botão novo pressionando!');
end;

procedure TDataModule1.PesquisarExecute(Sender: TObject);
begin
  DmxScroller_Form1.ShowMessage('Botão pesquisar pressionando!');
end;



function TDataModule1.TestUmTipo(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin

    Result :=   NewSItem('~Data: dia/mes/ano ~',
                NewSItem(' ~Data_1         ~\Ddd/mm/yy'+chFN+'Data_1',
                NewSItem(' ~Data_2         ~\Ddd/mm/yyyy'+chFN+'Data_2',
                NewSItem('',
                NewSItem('~Data: ano/mes/dia ~',
                NewSItem(' ~Data_3         ~\Dyy/mm/dd'+chFN+'Data_3',
                NewSItem(' ~Data_4         ~\Dyyyy/mm/dd'+chFN+'Data_4',
                NewSItem('',
                NewSItem('~Horas: dia/mes/ano ~',
                NewSItem(' ~hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
                NewSItem(' ~hora_2         ~\Dhh:nn'+chFN+'hora_2'+ChH+'Campo hora e minutos',
                NewSItem('',
                NewSItem('~Data e Horas: dia/mes/ano hora:minutos:segundos~',
                NewSItem(' ~dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN+'DateTime_1',
                NewSItem(' ~dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'DateTime_2',
                NewSItem('',
                NewSItem('~Data e Horas: dia/mes/ano hora:minutos~',
                NewSItem(' ~dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'DateTime_3',
                NewSItem(' ~dd/mm/yyyy hh:nn:    ~\Ddd/mm/yyyy hh:nn'+chFN+'DateTime_4',
                NewSItem(''
                        ,aNext))))))))))))))))))));






  end;
end;

{ The labels are enclosed by tilde ('~') symbols, and
  the '\' delimiter is used to separate text from literals. }

function  TDataModule1.Heading(aNext: PSItem) : PSItem;
  //var
  //  vr : Extended;
begin

  with DmxScroller_Form1 do
  begin

    //vr := 999999999999.99;
    //writeLn(NumToStr('EEE,EEE,EEE,EEE.EE',vr,fldExtended,true));
//    CustomBufDataset.FileName:= 'TvDmx_Example'; //Nome do arquivo para gravação de dados em disco local

    Result :=
     NewSItem('~ ~',
     NewSItem('~Status:    ~\ssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss'+CharAccSkip+chFN+'status',//+CharAccReadOnly,
     NewSItem('~ ~',
     NewSItem('~Vencimento:~\sssssssssssssssss'+ChFN+'Dia'+chDF+'Dia 30 e 60 e 90'+
                              CreateOptions(NewSItem('Dia 10',
                                            NewSItem('Dia 15',
                                            NewSItem('Dia 20',
                                            NewSItem('Dia 30 e 60 e 90',
                                            nil))))
                                           )+ChH+'O campo dia, é um string com 11 posições. Nota: O número '+
                     'de caracteres do maior item da lista, não pode ter mais de 11 caracteres.',

     NewSItem('~➕&Novo~'+ChEA+Novo.Name+
              '~✔ &️Gravar~'+ChEA+(Gravar.Name)+
              '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
              '~➖ Excluir~'+ChEA+(Excluir.Name),
     NewSItem('~ ~',
     NewSItem('~Sustentação~',
     NewSItem('~Senha:~ \sssssssssssssss'+CharShowPassword+ChFN+'Fld01'+ChH+'Campo alfanumerico com 15 posicoes',
     NewSItem('~Emojis: https://emojidb.org/arrow-emojis?user_typed_query=1&utm_source=user_search~',
     NewSItem('~Emojis: https://emojipedia.org/search/?q=refres~',
     NewSItem('~Emojis: 📲 ◻️ 🔲 ⬜🆓 📂 🗂 📖 🗃  📄 🗄  🆕  🆗 ✅ ✔️🔷 🔶 🔍 🗑 ✖ ❎◾◽      xx~',
     NewSItem('~Emojis: ⇄ ↵ ↳ └➤ּ ➳ ➡ ⬌ ⬇ ⬅ ⬆ ⬉ ⇫ ⏎ ⬃ ⬁ ⇓ ⟺ ⇰ ⟰  ⇚ ✔️ ⇶ ⇇ ➤ ▶ ◀ ▼ ▲ ⇥ ➜ ➢▪  xx~',
     NewSItem('~Emojis: 👉 👇 👈 ☝  ⏩ 🔼 🔽 ⏪ ⏫ ⏬ ❌ ❓ ❗ 🔺🔻 🚩  🟥 ⭕ 🔴 🚫  🛑 🔇    xx~',
     NewSItem('~Emojis: 👁️ 💭 💬 💭 🗨 🗯 💫 ✋ 👏 🫀 👩🏫 🎤 🎧 🔎 📷 🔦 📄 📰 📖 📒 💰 🧾 💹 💸 💳 💲 🪙 ✉ 📧 📩 ✒xx~',
     NewSItem('~Emojis: 📥 📤 📋 ☎️~ ⛔️ ➕ ➖  ✔️  🔄 ☑️ 🫂',
     NewSItem('~~',
     NewSItem('~ Remit to: 🇺🇸              From: 🇧🇷~',
     NewSItem('',
     NewSItem('~  Billy the Kid         ~ \sssssssssssssssssssssssss`sssssssssssssssss'+ChFN+'Campo1',
     NewSItem('~  1000 Stage Coach Drive~ \sssssssssssssssssssssssss`sssssssssssssssss'+ChFN+'Campo2',
     NewSItem('~  Wild West, CA  90352  ~ \sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo3',
     NewSItem('~  U.S.A.                ~ \sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo4',
     NewSItem('~                        ~ \sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo5',
     NewSItem('~                        ~ \(##)#####-####'+ChFN+'phone',
     NewSItem('~~',
     NewSItem('~Contact individual:~',
     NewSItem('~~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo6',
     NewSItem('~~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo7',
     NewSItem('~Idade:~'+tmp_Alunos_Idade+CreateExecAction('Idade',Pesquisar.Name),
     NewSItem('~Valor:~'+'\R$ EEE,EEE,EEE,EEE.EE', //Extended
     aNext))))))))))))))))))))))))))))));
  End;
end;

function  TDataModule1.Information(Next: PSItem) : PSItem;
begin
  with DmxScroller_Form1 do
  result :=
  NewSItem('~Qt:        ~\IIIII'+chdf+'5'+ChFN+'qt',
  NewSItem('~Unidade:   ~\'+CreateEnumField(TRUE, accNormal, 1,NewSItem('Centímetro',  //1/100
                                                NewSItem('Metro',       //1
                                                NewSItem('km',          //100*1000
                                                        nil))))+ChFN+'unidade',
  NewSItem('~Preço:     ~\RRR,RRR.zz'+ChAS+ChARO+ChFN+'preco'+ChDf+'10',
  NewSItem('~Total:     ~\RRR,RRR,RRR.ZZ'+ChARO+ChFN+'valor_total',

  NewSItem('~  I prefer ~\' + CreateEnumField(TRUE, accNormal, 1,
                                                   NewSItem(' indefinido ',
                                                   NewSItem(' 3 1/2"     ',
                                                   NewSItem(' 5 1/4"     ',
                                                            nil))))+ChFN+'Campo12' + '~ disks.~',
      Next)))));
end;

function  TDataModule1.Instructions(Next: PSItem) : PSItem;
begin
  with DmxScroller_Form1 do
    result :=
      NewSItem('~Note that the Trade toolkit has been delivered and accepted by~',
      NewSItem('~the customer. A current disk, including full documentation and~',
      NewSItem('~more units, will be sent~  \'
              + CreateEnumField(TRUE, accNormal, 0,
                      NewSItem('when the next update is available.',
                      NewSItem('upon receipt of this paid invoice.',
                              nil)))+ChFN+'Campo13',
              Next)));
end;

//function  TDataModule1.ClientInfo(ANext: PSItem) : PSItem;
//begin
//  with DmxScroller_Form1 do
//  result :=
//    NewSItem('~  Where did you find tvDMX?~',
//    NewSItem('   \Ka Internet'+ChFN+'Indicação',
//    NewSItem('   \Ka 4g      ',
//    NewSItem('   \Ka User group',
//    NewSItem('   \Ka friend or collegue',
//    ANext)))));
//end;

function  TDataModule1.ClientInfo(ANext: PSItem) : PSItem;
begin
  with DmxScroller_Form1 do
  result :=
    NewSItem('~Client Information (Optional)~',
    NewSItem('~=============================~',
    NewSItem('',
    NewSItem('~How long have you been using Turbo Vision?~\BB'+ChFN+'Campo14'+CharUpperlimit+#3+
             '~years~\WWW'+ChFN+'Campo15'+CharUpperlimit+#10+'~months~',
    NewSItem('',
    NewSItem('~Which version of Turbo Pascal are you using?~\##.##.##.####'+ChFN+'Campo16',
    NewSItem('',
    NewSItem('~List tools that you use:         Where did you find tvDMX?~',
    NewSItem('   \X AnsiView                      \KA BBS                  '+chFN+'Indicação',//+chFN+'Where did you',
    NewSItem('   \X Blaise                        \KA CompuServe           ',
    NewSItem('   \X Btrieve                       \KA Internet             ',
    NewSItem('   \X Paradox Engine                \KA User group           ',
    NewSItem('   \X Topaz                         \KA friend or collegue   ',
    NewSItem('   \X Turbo Pascal for Windows      \KA Other:',
    NewSItem('   \X TurboPower                   ',
    NewSItem('',
    NewSItem('',
    NewSItem('~     Others:~\ssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'Campo17',
    NewSItem('~            ~\ssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'Campo18',
    NewSItem('~            ~\ssssssssssssssssssssssssssssssssssssssssssss'+ChFN+'Campo19',
    NewSItem('~ ~'
            ,ANext)))))))))))))))))))));
end;

function  TDataModule1.FormAluno(aNext: PSItem) : PSItem;
begin
  with DmxScroller_Form1 do
  begin

    Result :=
      NewSItem('~Nome do aluno: ~\ssssssssssssssssssssssssssss'+ChFN+'Nome',
      NewSItem('',
      NewSItem('~     Endereço: ~\ssssssssssssssssssssssssssss'+ChFN+'Endereco',
      NewSItem('~          Cep: ~\##.###-###'+ChFN+'cep',
      NewSItem('~       Cidade: ~\sssssssssssssssssssssssss'+ChFN+'cidade',
      NewSItem('~       Estado: ~\SS'+ChFN+'Estado',
      NewSItem('',
      aNext)))))));
  end;
end;

function  TDataModule1.TestLabel(aNext: PSItem) : PSItem;
begin
  with DmxScroller_Form1 do
  begin

    Result :=
      NewSItem('~Nome do aluno: ~',
      NewSItem('~     Endereço: ~',
      NewSItem('~          Cep: ~',
      NewSItem('~       Cidade: ~',
      NewSItem('~       Estado: ~',
      NewSItem('',
      aNext))))));
  end;
end;

function TDataModule1.Cadastro(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    Result :=
      NewSItem('',
      NewSItem('~Estado:~\SS'+ChFN+'estado'+CharPfInKeyPrimary,
      NewSItem('~Cidade:~\Ssssssssssssssssssssss`sssss'+ChFN+'cidade'+CharPfInKeyPrimary,
      NewSItem('~   Cep:~\##.###-###'+ChFN+'cep',
      NewSItem('~Valor.:~\RRR,RRR.ZZ'+ChFN+'valor',
      NewSItem('~Driver:~'+ CreateEnumField(TRUE, accNormal, 0,
                             NewSItem('indefinido',
                             NewSItem('3  1/2"   ',
                             NewSItem('5  1/4"   ',
                                      nil))))+ChFN+'driver' + '~Disks.~',
      NewSItem('~Casado?.:~\X '+ChFN+'casado',

      NewSItem('~sexo :~\Ks Indefinido '+chFN+'sexo',
      NewSItem(         '\Ks Maculino   ',
      NewSItem(         '\Ks Feminino   ',
      NewSItem('~ ~',
      NewSItem('~     ~~ &Novo~'+ChEA+Novo.Name+
               '~✔ ️Gravar~'+ChEA+(Gravar.Name)+
               '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
               '~❌ Excluir~'+ChEA+(Excluir.Name),
      NewSItem('~ ~',
      aNext)))))))))))));
  end;

end;

function TDataModule1.TestDateTime(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin

    Result :=   NewSItem('~ ~',
                NewSItem('~TESTE DE DATAS E HORAS~',
                NewSItem('~ ~',
                NewSItem('~ Data: dia/mes/ano ~',
                NewSItem('~    Data_1         ~\Ddd/mm/yy'+chFN+'Data_1',
                NewSItem('~    Data_2         ~\Ddd/mm/yyyy'+chFN+'Data_2',
                NewSItem('~ ~',
                NewSItem('~ Data: ano/mes/dia ~',
                NewSItem('~    Data_3         ~\Dyy/mm/dd'+chFN+'Data_3',
                NewSItem('~    Data_4         ~\Dyyyy/mm/dd'+chFN+'Data_4',
                NewSItem('~ ~',
                NewSItem('~ Horas: dia/mes/ano ~',
                NewSItem('~    hora_1         ~\Dhh:nn:ss'+chFN+'hora_1',
                NewSItem('~    hora_2         ~\Dhh:nn'+chFN+'hora_2'+ChH+'Campo hora e minutos',
                NewSItem('~ ~',
                NewSItem('~ Data e Horas: dia/mes/ano hora:minutos:segundos~',
                NewSItem('~    dd/mm/yy hh:nn:ss:   ~\Ddd/mm/yy hh:nn:ss'+chFN+'DateTime_1',
                NewSItem('~    dd/mm/yyyy hh:nn:ss: ~\Ddd/mm/yyyy hh:nn:ss'+chFN+'DateTime_2',
                NewSItem('',
                NewSItem('~ Data e Horas: dia/mes/ano hora:minutos~',
                NewSItem('~    dd/mm/yy hh:nn:      ~\Ddd/mm/yy hh:nn'+chFN+'DateTime_3',
                NewSItem('~    dd/mm/yyyy hh:nn:    ~\Ddd/mm/yyyy hh:nn'+chFN+'DateTime_4',
                NewSItem('~ ~'
                        ,aNext)))))))))))))))))))))));
  end;
end;

function TDataModule1.Test_Mask(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
    result :=
             NewSItem(^A,
             NewSItem('~CEP:  ~\##.###-###'+ChFN+'cep'+ChDf+'61624300',
             NewSItem('~CNPJ: ~\##.###.###/####-##'+ChFN+'cnpj'+ChDf+'01100200000150',
             NewSItem('~fone: ~\(##) # #### ####'+ChFN+'fone'+ChDf+'85997024498',
             NewSItem('~CPF:  ~\###.###.###-##'+ChFN+'cpf'+ChDf+'14149621349',
             NewSItem('~Valor real4   :~\OOO,OOO.OO'+ChFN+'valorreal4'+chDF+'45879.45',
             NewSItem('~Valor Extented:~\EEE,ERE,EEE.EE'+ChFN+'valorextended'+chDF+'4444555.78',
             NewSItem('~Valor Float   :~\RRR,RRR,RRR.RR'+ChFN+'valorfloat'+chDF+'1254,78',
             NewSItem('~test: ~\ss-SSSSS-####'+ChFN+'teste'+ChDf+'paCEARA1958',
             NewSItem('~Data_1~\Ddd/mm/yyyy'+chFN+'Data_1'+ChDf+'22061958',
             nil))))))))));
  end;
end;

function TDataModule1.DmxScroller_Form1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form1 do
  begin
    AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;
    AlignmentLabels:= taCenter;//taLeftJustify;taRightJustify;
    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
    //result := NewSItem(^A,
    //            Heading(
    //            Information(
    //            Instructions(
    //            ClientInfo(
    //            Cadastro(
    //            TestDateTime(
    //            Test_Mask(
    //            nil))))))));

     result := NewSItem(^A,
//                TestUmTipo(
                  Test_Mask(
                nil));


  end;
end;






end.

