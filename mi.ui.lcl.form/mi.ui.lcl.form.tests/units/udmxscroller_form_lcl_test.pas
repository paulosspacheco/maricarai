unit uDmxScroller_Form_Lcl_test;
{:< A unit **@name** implementa o teste dos componentes TUiConsts.MI_MsgBox, mi_scrollbox_LCL1 e
    TDmxScroller_Form_Lcl onde os mesmos são ligados no evento **TDmxScroller_Form_Lcl_test.FormCreate**

    - **NOTAS**
      - A constante **TUiConsts.MI_MsgBox** precisa se iniciada com o atributo 
        **TMi_ui_mi_msgBox.MI_MsgBox1** da unit **mi_ui_mi_msgbox_dm** para que os diálogos 
        internos do componente  **DmxScroller_Form_Lcl1** possa gerar mensagens sem depender 
        diretamente da **LCL**, ou seja: Será possível implementar dialogs em outros frameworks 
        visuais tais como **html**, **angula 4**, etc alterando o  método
        SetActive().
          - O método SetActive seleciona os método DmxScroller_Form_Lcl1.CreateFormLCL ou o método 
        DmxScroller_Form_Lcl1.CreateFormHTML conforme o tipo de aplicação.


      - O evento DmxScroller_Form_Lcl1.onGetTemplate precisa se iniciado em OnCreate
        do form porque a propriedade **onGetTemplate** ainda não foi lida do arquivo de recursos
        e precisamos da mesma para executar o método DmxScroller_Form_Lcl1.SetParentLcl.


    - **CÓDIGO PASCAL**

      ```pascal

          procedure TForm_Mi_Ui_Test.FormCreate(Sender: TObject);
          begin
             TUiConsts.MI_MsgBox := get_MI_MsgBox.MI_MsgBox1;
             DmxScroller_Form_Lcl1.onGetTemplate:= DmxScroller_Form_Lcl1GetTemplate;
             DmxScroller_Form_Lcl1.SetParentLcl(mi_scrollbox_LCL1);
          end;

      ```
}


{$mode Delphi}

interface

uses
  Classes, SysUtils, DB, BufDataset, memds, Forms, Controls, Graphics, Dialogs, typInfo,
  MaskEdit, StdCtrls, ExtCtrls, DBGrids, ButtonPanel, ActnList, DBCtrls, Spin,
  Buttons, DBExtCtrls, EditBtn, SpinEx, SynEdit, TAChartExtentLink, SQLite3Conn,
  SqlDb, mi.rtl.Types, mi_rtl_ui_consts, mi_rtl_ui_Dmxscroller,
  uMi_ui_scrollbox_lcl, uMi_Ui_DbComboBox_lcl, uMI_ui_DbEdit_LCL,
  uMi_ui_maskedit_lcl, uMi_ui_ComboBox_LCL, uMi_BitBtn_LCL,
  uMi_ui_DmxScroller_Form_Lcl, uMi_ui_mi_msgbox_dm,
  uMi_ui_DmxScroller_Form_Lcl_DS_Test
  ,umi_ui_InputBox_lcl
  ,uDmxScroller_Form_Lcl_add_test
  ,uMi_ui_DmxScroller_Form_Lcl_ds_test2
  ,umi_ui_inputbox_lcl_test
  ,uDmxScroller_Form_Lcl_add_test2
  ;
//  ,mi.rtl.Consts;

type

  { TDmxScroller_Form_Lcl_test }

  TDmxScroller_Form_Lcl_test = class(TForm)
    Button2: TButton;
    Form_ds_test2: TAction;
    Action_Form_ds_test: TAction;
    AddTemplate: TButton;
    Button1: TButton;
    GetTemplate: TButton;
    Novo: TAction;
    Gravar: TAction;
    Excluir: TAction;
    Pesquisar: TAction;
    Pesquisa: TAction;
    ActionList1: TActionList;
    Button_ModifyFontsAll_LCL: TButton;
    InputBox: TButton;
    form_ds_Test: TButton;
    Button_Cidades : TButton;
    ButtonPanel1 : TButtonPanel;
   
    DmxScroller_Form_Lcl1: TDmxScroller_Form_Lcl;
    GroupBox1: TGroupBox;
    Mi_ScrollBox_LCL1: TMi_ScrollBox_LCL;
//  MI_ui_Application_LCL1 : TMI_ui_Application_LCL;
    Panel1: TPanel;

    procedure Form_ds_test2Execute(Sender: TObject);
    procedure Action_Form_ds_testExecute(Sender: TObject);
    procedure AddTemplateClick(Sender: TObject);

    procedure GetTemplateClick(Sender: TObject);
    procedure Button_ModifyFontsAll_LCLClick(Sender: TObject);
    procedure form_ds_TestClick(Sender: TObject);

   {: O método **@name** demonstra o uso da função MsgBox_Form}
    procedure InputBoxClick(Sender: TObject);

    procedure DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
    procedure DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller);
    procedure DmxScroller_Form_Lcl1ExitField(aField: pDmxFieldRec);
    function DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;
    procedure DmxScroller_Form_Lcl1NewRecord(aDmxScroller: TUiDmxScroller);
    procedure ExcluirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure GravarExecute(Sender: TObject);


    procedure mi_scrollbox_LCL1Enter(Sender: TObject);
    procedure NovoExecute(Sender: TObject);
    procedure PesquisarExecute(Sender: TObject);
    procedure PesquisaExecute(Sender: TObject);
    procedure StaticText1Click(Sender: TObject);
    procedure StaticText2Click(Sender: TObject);


  private
    function  Heading(aNext: PSItem) : PSItem;
    function  Information(Next: PSItem) : PSItem;
    function  Instructions(Next: PSItem) : PSItem;
    function  ClientInfo(ANext: PSItem) : PSItem;
    function  FormAluno(aNext: PSItem) : PSItem;
    function  TestLabel(aNext: PSItem) : PSItem;
    function Cadastro(aNext: PSItem): PSItem;
  public destructor destroy;override;




  end;

Resourcestring

  tmp_Alunos_Idade = '\BB'+ChFN+'idade'+CharUpperlimit+#64+
                     CharHint+'A idade do aluno. Valores válidos 1 a 64'+
                     CharHintPorque+'Este campo é necessário para que se agrupe o alunos baseado em sua faixa etária'+
                     CharHintOnde+'Ele será usado pelo coordenador ao classificar a turma';
  tmp_Alunos_Matricula = '\IIII'+ChFN+'matricula'+CharHint+'A matricula do aluno é um campo sequencial e calculado ao incluir o registro';

  tmp_Alunos = '~     Idade:~ %s'+TDmxScroller_Form_Lcl.lf+
               '~ Matricula:~ %s'+TDmxScroller_Form_Lcl.lf;


var
  DmxScroller_Form_Lcl_test: TDmxScroller_Form_Lcl_test;

implementation

{$R *.lfm}

{ TDmxScroller_Form_Lcl_test }


procedure TDmxScroller_Form_Lcl_test.mi_scrollbox_LCL1Enter(Sender: TObject);
  var
    aField: pDmxFieldRec;
begin
  //aField := DmxScroller_Form_Lcl1.FieldByName('Campo1');
  //if aField.AsString = ''
  //then aField.AsString := 'Campo01';
end;

procedure TDmxScroller_Form_Lcl_test.NovoExecute(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then WriteLn('Novo = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName);
end;
procedure TDmxScroller_Form_Lcl_test.GravarExecute(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then WriteLn('Gravar = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName );
end;

procedure TDmxScroller_Form_Lcl_test.PesquisarExecute(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then writeLn('Pesquisar = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName);
end;

procedure TDmxScroller_Form_Lcl_test.PesquisaExecute(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then writeLn('Pesquisa = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName);
end;

procedure TDmxScroller_Form_Lcl_test.StaticText1Click(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then writeLn('Static Text1 = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName);
end;

procedure TDmxScroller_Form_Lcl_test.StaticText2Click(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then writeLn('Static Text2 = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName);
end;

procedure TDmxScroller_Form_Lcl_test.ExcluirExecute(Sender: TObject);
begin
  if DmxScroller_Form_Lcl1.CurrentField<>nil
  Then WriteLn('Excluir = '+DmxScroller_Form_Lcl1.CurrentField^.FieldName)
end;

procedure TDmxScroller_Form_Lcl_test.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
//  ShowMessage('Comfirma finalização do formulário');
end;


//Procedure Pesquisa(Const AOwner:TUiDmxScroller; Const aDmxFieldRec:PDmxFieldRec);
//begin
//  if DmxScroller_Form_Lcl1.CurrentField<>nil
//  Then writeln(aDmxFieldRec.FieldName);
//end;

{ The labels are enclosed by tilde ('~') symbols, and
  the '\' delimiter is used to separate text from literals. }

function  TDmxScroller_Form_Lcl_test.Heading(aNext: PSItem) : PSItem;
  //var
  //  vr : Extended;
begin

  with DmxScroller_Form_Lcl1 do
  begin

    //vr := 999999999999.99;
    //writeLn(NumToStr('EEE,EEE,EEE,EEE.EE',vr,fldExtended,true));

//    CustomBufDataset.FileName:= 'TvDmx_Example'; //Nome do arquivo para gravação de dados em disco local
    Result :=
     NewSItem('~Alfanumerico 01:~\SSSSSSSSSSSSSSS'+ChFN+'Fld01'+ChH+'Campo alfanumerico com 15 posicoes maiúsculas.',
     NewSItem('~Emojis: https://emojidb.org/arrow-emojis?user_typed_query=1&utm_source=user_search~',
     NewSItem('~Emojis: https://emojipedia.org/search/?q=refres~',
     NewSItem('~Emojis: 📲 ◻️ 🔲 ⬜🆓 📂 🗂 📖 🗃  📄 🗄  🆕  🆗 ✅ ✔️🔷 🔶 🔍 🗑 ✖ ❎◾◽      xx~',
     NewSItem('~Emojis: ⇄ ↵ ↳ └➤ּ ➳ ➡ ⬌ ⬇ ⬅ ⬆ ⬉ ⇫ ⏎ ⬃ ⬁ ⇓ ⟺ ⇰ ⟰  ⇚ ✔️ ⇶ ⇇ ➤ ▶ ◀ ▼ ▲ ⇥ ➜ ➢▪  xx~',
     NewSItem('~Emojis: 👉 👇 👈 ☝  ⏩ 🔼 🔽 ⏪ ⏫ ⏬ ❌ ❓ ❗ 🔺🔻 🚩  🟥 ⭕ 🔴 🚫  🛑 🔇    xx~',

     NewSItem('',
     NewSItem('~    ~'+
              '~ Form_ds~'+CharHint+'TestExecute...'+ChEA+Action_Form_ds_test.name,
      NewSItem('~~',
      NewSItem('~ Remit to: 🇺🇸              From: 🇧🇷~',
      NewSItem('',
      NewSItem('~  Billy the Kid            ~\sssssssssssssssssssssssss`sssssssssssssssss'+ChFN+'Campo1',
      NewSItem('~  1000 Stage Coach Drive   ~\sssssssssssssssssssssssss`sssssssssssssssss'+ChFN+'Campo2',
      NewSItem('~  Wild West, CA  90352     ~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo3',
      NewSItem('~  U.S.A.                   ~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo4',
      NewSItem('~                           ~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo5',
      NewSItem('~                           ~\(##) # ####-####'+ChFN+'phone',
      NewSItem('~~',
      NewSItem('~Contact individual:~',
      NewSItem('~~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo6',
      NewSItem('~~\sssssssssssssssssssssssss`ssssssssssssssss'+ChFN+'Campo7',
      NewSItem('~Idade:~'+tmp_Alunos_Idade+CreateExecAction('Idade',Pesquisa.Name),
      NewSItem('~Valor:~'+'\R$ EEE,EEE,EEE,EEE.EE', //Extended
      //NewSItem('~Cliente:~'+'\LLLLL'+CreateExecAction('Cliente',Pesquisa.Name)+CharHint+'Pesquisa...'+
      //                      '~ Este é uma pesquisa.~',


      aNext)))))))))))))))))))))));
  End;
end;

function  TDmxScroller_Form_Lcl_test.Information(Next: PSItem) : PSItem;
begin
  with DmxScroller_Form_Lcl1 do
  result :=
      NewSItem('~             Qty                        Unit Price~',
      NewSItem('~______________________________________________________~',
      NewSItem('~         ~\II'+ChFN+'Campo8'
                +'~ ~\'
                +CreateEnumField(TRUE, accNormal, 0,NewSItem(' Trade Registration ',
                                                    NewSItem(' Trade Site License ',
                                                            nil)))+ChFN+'Campo9'
                +'~  ~'
                +'\RRR,RRR.zz'+ChAS+ChARO+ChFN+'Campo10',
      NewSItem('~                                    Total: ~\RRR.ZZ'+ChARO+ChFN+'Campo11',
      NewSItem('~  I prefer ~'
                + CreateEnumField(TRUE, accNormal, 0,
                        NewSItem(' indefinido ',
                        NewSItem(' 3 1/2"     ',
                        NewSItem(' 5 1/4"     ',
                                nil))))+ChFN+'Campo12' + '~ disks.~',
              Next)))));
end;

function  TDmxScroller_Form_Lcl_test.Instructions(Next: PSItem) : PSItem;
begin
  with DmxScroller_Form_Lcl1 do
    result :=
      NewSItem('~Note that the Trade toolkit has been delivered and accepted by~',
      NewSItem('~the customer. A current disk, including full documentation and~',
      NewSItem('~more units, will be sent~\'
              + CreateEnumField(TRUE, accNormal, 0,
                      NewSItem('when the next update is available.',
                      NewSItem('upon receipt of this paid invoice.',
                              nil)))+ChFN+'Campo13',
              Next)));
end;

//function  TDmxScroller_Form_Lcl_test.ClientInfo(ANext: PSItem) : PSItem;
//begin
//  with DmxScroller_Form_Lcl1 do
//  result :=
//    NewSItem('~  Where did you find tvDMX?~',
//    NewSItem('   \Ka Internet'+ChFN+'Indicação',
//    NewSItem('   \Ka 4g      ',
//    NewSItem('   \Ka User group',
//    NewSItem('   \Ka friend or collegue',
//    ANext)))));
//end;

function  TDmxScroller_Form_Lcl_test.ClientInfo(ANext: PSItem) : PSItem;
begin
  with DmxScroller_Form_Lcl1 do
  result :=
    NewSItem('~Client Information (Optional)~',
    NewSItem('~=============================~',
    NewSItem('',
    NewSItem('~How long have you been using Turbo Vision?~\BB'+ChFN+'Campo14'+CharUpperlimit+#3+
             '~years ~\WWW'+ChFN+'Campo15'+CharUpperlimit+#10+'~months~',
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
    NewSItem('~ ~',
    NewSItem('~ ~',
    NewSItem('~     ~~ &Novo~'+ChEA+Novo.Name+
            '~✔ ️Gravar~'+ChEA+(Gravar.Name)+
            '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
            '~❌ Excluir~'+ChEA+(Excluir.Name)
            ,ANext)))))))))))))))))))))));
end;

function  TDmxScroller_Form_Lcl_test.FormAluno(aNext: PSItem) : PSItem;
begin
  with DmxScroller_Form_Lcl1 do
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


function  TDmxScroller_Form_Lcl_test.TestLabel(aNext: PSItem) : PSItem;
begin
  with DmxScroller_Form_Lcl1 do
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


function TDmxScroller_Form_Lcl_test.Cadastro(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form_Lcl1 do
  begin
    Result :=
      NewSItem('',
      NewSItem('~Estado:~\SS'+ChFN+'estado'+CharPfInKeyPrimary,
      NewSItem('~Cidade:~\Ssssssssssssssssssssss`sssss'+ChFN+'cidade'+CharPfInKeyPrimary,
      NewSItem('~   Cep:~\##.###-###'+ChFN+'cep',
      NewSItem('~Valor.:~\RRR,RRR.ZZ'+ChFN+'valor',
      NewSItem('~Driver:~'+ CreateEnumField(TRUE, accNormal, 0,
                             NewSItem('null',
                             NewSItem('3 1/2"',
                             NewSItem('5 1/4"',
                                      nil))))+ChFN+'driver' + '~Disks.~',
      NewSItem('~Satus.:~\X '+ChFN+'status',
      NewSItem('~sexoo :~\Ks Indefinido '+chFN+'sexo',
      NewSItem(         '\Ks Maculino   ',
      NewSItem(         '\Ks Feminino   ',
      NewSItem('',
      aNext)))))))))));
  end;

end;

destructor TDmxScroller_Form_Lcl_test.destroy;
begin
  inherited destroy;
end;



function TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1GetTemplate(aNext: PSItem): PSItem;
begin
  with DmxScroller_Form_Lcl1 do
  begin
    AlignmentLabels:= taRightJustify;//taCenter;//taLeftJustify;
    AlignmentLabels:= taCenter;//taLeftJustify;taRightJustify;
    AlignmentLabels:= taLeftJustify;//taCenter;taRightJustify;
    result := NewSItem(^A,
                Heading(
                Information(
                Instructions(
                ClientInfo(
                Cadastro(
                nil))))));
 end;

//  with DmxScroller_Form_Lcl1 do
//    //vr := 999999999999.99;
//    //writeLn(NumToStr('EEE,EEE,EEE,EEE.EE',vr,fldExtended,true));
//
////    CustomBufDataset.FileName:= 'TvDmx_Example'; //Nome do arquivo para gravação de dados em disco local
//    Result :=
//     NewSItem('~Alfanumerico 01:~\SSSSSSSSSSSSSSS'+ChFN+'Fld01'+ChH+'Campo alfanumerico com 15 posicoes maiúsculas.',
//     NewSItem('~ Icons:   ~~🔲 ⬜🆓 📂 🗂 📖 🗃  📄 🗄  🆕  🆗 ✔ ✅🔷🔶◾◽🔺🔻® © 🔍 ❌🗑 ✖ ❎❗  ~',
//     NewSItem('',
//     NewSItem('~    ~'+
//              '~🔲 &Novo~'+CharHint+'Pesquisa...'+ChEA+Novo.Name+
//              '~✔  Gravar~'+ChEA+(Gravar.Name)+
//              '~🔍 &Pesquisar~'+ChEA+Pesquisar.Name+
//              '~❌ Excluir~'+ChEA+(Excluir.Name),
//     NewSItem('~~', nil)))));


end;

procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1NewRecord(aDmxScroller: TUiDmxScroller);
begin

end;

procedure TDmxScroller_Form_Lcl_test.FormCreate(Sender: TObject);
begin
  DmxScroller_Form_Lcl1.MI_MsgBox := get_MI_MsgBox.MI_MsgBox1;
  DmxScroller_Form_Lcl1.ParentLCL := Mi_ScrollBox_LCL1;
  GroupBox1.Caption:=DmxScroller_Form_Lcl1.Alias;
  DmxScroller_Form_Lcl1.Active:= true;
  GroupBox1.Caption:=DmxScroller_Form_Lcl1.Alias;
  //DmxScroller_Form_Lcl1.FieldByName('Campo1').HelpCtx_Hint:='Endereço do destinatário';
//  writeLn(Mi_ScrollBox_LCL1.WidthChar);
end;




//procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1EnterField(aField: pDmxFieldRec);
//begin
//  //with DmxScroller_Form_Lcl1 do
//  //  MessageBox(Format('OnEnterField %s',[aField.FieldName]));
//  //
//  //Case aField.Fieldnum of
//  //  1 : begin
//  //        if aField.AsString = ''
//  //        then aField.AsString := 'ITEM SISTEMAS';
//  //      end;
//  //  2 : begin end;
//  //end;
//  //
//  //if aField.FieldName = 'Campo1'
//  //then begin
//  //       aField.AsString := 'Entrou no campo1';
//  //end;                 GetBu
//
//end;

//procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
//begin
//  //with DmxScroller_Form_Lcl1 do
//  //  MessageBox(Format('OnEnter %s',[aDmxScroller.Alias]));
//end;

//procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller);
//begin
////  with DmxScroller_Form_Lcl1,Mi_MsgBox do
////  If MessageBox('Comnfirma saída do formulário'
////                ,MtConfirmation,mbYesNoCancel,mbYes)= MrYes
////  then abort
////  else MessageBox(Format('OnExit %s',[aDmxScroller.Alias]));
//end;

//Procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1NewRecord (aDmxScroller : TUiDmxScroller ) ;
//Begin
//  ShowMessage('OnNewRecor');
//end;

procedure TDmxScroller_Form_Lcl_test.form_ds_TestClick(Sender: TObject);
begin
  if Mi_ui_DmxScroller_Form_Lcl_DS_Test<> nil
  Then Mi_ui_DmxScroller_Form_Lcl_DS_Test.ShowModal

end;


{
Question:
  What is the most easy way to set a same font name to all controls
  in project in run time?

Answer:
  By default all controls have ParentFont = true, so if you did not change
  that  for specific controls you could just change the forms Font
  property, e.g. in code attached to the Screen.OnActiveFormChange event.
  If you cannot rely on all controls having Parentfont = true you would
  have to loop over all controls on the form and set the font property for
  each or at least for those that have ParentFont set to false. You can
  use the routines from unit TypInfo for that, they allow you to access
  published properties by name. The code, again sitting in a handler for
  Screen.onActiveFormChange, would be something like this:

  ModifyFontsFor( Screen.ActiveControl );

where
}



// Remember to add TypInfo to your uses clause.

procedure TDmxScroller_Form_Lcl_test.Button_ModifyFontsAll_LCLClick(Sender: TObject);
begin
  DmxScroller_Form_Lcl1.ModifyFontsAll_LCL(Self,'arial',12);
end;

procedure TDmxScroller_Form_Lcl_test.AddTemplateClick(Sender: TObject);
begin
  DmxScroller_Form_Lcl_add_test.ShowModal;
end;



procedure TDmxScroller_Form_Lcl_test.Action_Form_ds_testExecute(Sender: TObject);
begin
  Mi_ui_DmxScroller_Form_Lcl_DS_Test.ShowModal;
end;

procedure TDmxScroller_Form_Lcl_test.Form_ds_test2Execute(Sender: TObject);
begin
  Mi_ui_DmxScroller_Form_Lcl_DS_Test2.ShowModal;
end;



//function GetAddr(send:Tobject;var p):Pointer;
//begin
//
//end;

procedure TDmxScroller_Form_Lcl_test.GetTemplateClick(Sender: TObject);
  Const
    s = 'Nome do Método: %s ';

begin
  //writeLn(Format(s,[self.ClassName+'.Button1Click.html']));
  DmxScroller_Form_Lcl_add_test2.ShowModal;
end;



procedure TDmxScroller_Form_Lcl_test.InputBoxClick(Sender: TObject);
begin
  TestinputBox;
end;



procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1Enter(aDmxScroller: TUiDmxScroller);
begin

end;

procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1EnterField(
  aField: pDmxFieldRec);
begin

end;

procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1Exit(aDmxScroller: TUiDmxScroller);
begin

end;


//const
//  vidis : boolean = false;

Var
  Campo8,campo9,Campo10,Campo11: pDmxFieldRec;

procedure TDmxScroller_Form_Lcl_test.DmxScroller_Form_Lcl1ExitField(aField: pDmxFieldRec);
begin
  with DmxScroller_Form_Lcl1,MI_MsgBox do
  if (aField.FieldName = 'campo8') or (aField.FieldName = 'campo9')
  then begin
//         vidis := true;
        Campo8 := FieldByName('campo8');
        Campo9 := FieldByName('campo9');
        Campo10 := FieldByName('campo10');
        Campo11 := FieldByName('campo11');
        if (Campo8 <> nil) and  (Campo9 <> nil) and  (Campo10 <> nil) and  (Campo11 <> nil)
        then begin
               Case Campo9.Value of
                 0 : begin
                       Campo10.Value := 15;
                       Campo11.Value:= Campo8.Value * Campo10.Value;
                     end;
                 1 : begin
                       Campo10.Value := 25;
                       Campo11.Value:= Campo8.Value * Campo10.Value;
                     end;
               end;
                //Checar: https://www.cc.gatech.edu/data_files/public/doc/gtk/tutorial/gtk_tut-15.html
               if aField.FieldAltered
               then begin
                      If MessageBox(Format('Campo %S foi alterado',[AField.FieldName])+^M+
                                    ^M+
                                    'Confime a alteração?'
                                    ,MtConfirmation,mbYesNo,mbYes) = MrNo
                      Then begin
                             CancelBuffers;
                           end;

                    End;
            end;

//         vidis := false;
       end
  else
end;

end.

