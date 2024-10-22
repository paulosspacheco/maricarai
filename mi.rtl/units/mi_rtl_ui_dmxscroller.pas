unit mi_rtl_ui_Dmxscroller;
  {TODO -oOwnerName -cCategoryName: Todo_text}
  {DONE -oOwnerName -cCategoryName: Todo_text}
  //#todo -oOwnerName -cCategoryName: Todo_text
  {#done -oOwnerName -cCategoryName: Todo_text}

  {:< A unit **@name** implementa a classe TUiDmxScroller e registro TDmxFieldRec.

    - **ORIGEM DESTA IDEIA**:
      - Este projeto foi criado baseado na ideia do projeto:
        - [TvDmx](https://www.pcorner.com/list/PASCAL/TVDMX.ZIP/)

    - **VERSÃO**
      - Alpha - 1.0.0

    - **HISTÓRICO**
      - @html(<a href="../units/mi_rtl_ui_dmxscroller_historico.html">./mi_rtl_ui_dmxscroller_historico.html </a>)   
   
    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi_rtl_ui_dmxscroller.pas">mi_rtl_ui_DmxScroller.pas</a>)

    - **PENDÊNCIAS**
        - T12 Criar Property TMi_rtl_dmxScroller.TemplateClient_Path
       - T12 Criar Property TMi_rtl_dmxScroller.ClientTemplates_ dataModule_FileName
       - T12 Criar Property TMi_rtl_dmxScroller.ClientTemplates_Form_FileName

       - T12 O grupo TMi_RadioGroup_Lcl não é selecionado com a tecla na tecla **TAB**
         - Quando os botões TRadioButton estão dentro do TRadioGroup  a propriedade
           TRadioGroup.TabStop não funciona.

       - T12 Implementar o campo FldLink. (Esse campo executa uma ação usando
             controle TStaticText.

       - T12 Implementar a possibilidade das fontes do label ser personalizada
             baseado em um estilo que pode ser uma variável global.

             -  Suponha que ^Z = <h1> Título e ^D = <B> de negrito então o sistema
                informa a TDmxFieldRec.Style = nome do estilo onde nome do estilo =
                'Font = FonteX; Size= XX; etc..  '

                - Exemplo:

                 ~^ZCADASTRO DE ALUNOS^Z~

                 ~^DÑome do Aluno^D:~\ssssssssss

      - T12 Implementar a edição de campo **FldMemo**.

      - T!2 Implementar a campo **fldBLOb**;

      - t12 Implementar a edição de **fldHexValue**.
        - O campo Hexadecimal deve ser campo longint mais a edição é uma string comum . fldStr

      - T12 Implementar  a execução do evento do tipo CharExecProc quando a tecla F7
            é pressionada.

      - T12 Criar opção para gerar cliente HTML a partir de TDmxScroller
        - Referência: [Componente que espoe dados para o browser](https://wiki.freepascal.org/SqlDbRestBridge#Purpose)

      - T12 Nosso código só é executado com o editor de
            propriedade. Se não estamos no editor de propriedade
            então não temos controle do código no modo design.
            Qual o meu problema:
              O formulário deve ser criado em tempo de execução,
              porém eu queria ver como ele estava ficando sem precisar
              compilar e executar o código, por isso coloquei o código
              em um stringList e ao ativar o objeto, o formulário é
              criado. Porém esses objetos criados no designer não podem
              ficar no arquivo de recursos porque quando for executado
              vai haver duplicidade.
              - Quando eu desativo o objetos todos os objetos que ele
                criou são excluídos do arquivo de recursos.
              - Isso eu já faço agora, mais quando distribuir o
                componente as pessoas vão deixar esses componente
                usado no teste e ao executar vai haver error.
              - Por isso eu queria que caso a propriedade active tivesse
                em true eu queria que ela ficasse em false.

    - **CONCLUÍDO**
       - T12 Criar tipo TEn_OnEvent_DmxFieldRec;
       - T12 Criar TEnClientsApplication = (ApLcl,ApJavaScript,ApDynamichtml,ApVueJs,ApAngular); ✅
       - T12 Implementar o método public function Locate(): Boolean;override;overload;✅

       - T12 Implementar a propriedade public property CanModify: Boolean;
       - T12 Implementar a propriedade public property TDmxScrooler.Modified : Boolean read _Modified; ✅
       - T12 Criar método Select_First_Field_Normal para se acionado no método
             DoOnNewRecord.

       - T12 Implementar o evento OnChange em todos os controles, visto que o mesmo
         é mais fácil criar lógica de negócios visto que o mesmo só é executado
         se o campo for modificado. ✅

       - T12 Criar evento Procedure OnCalcField;✅
       - T12 Criar evento Procedure OnCalcFields;✅

       - T12 Criar evento TUiDmxScroller.OnBeforeDelete.✅
       - T12 Criar evento TUiDmxScroller.OnAfterDelete.✅

       - T12 Criar evento TUiDmxScroller.OnBeforeUpdate.✅
       - T12 Criar evento TUiDmxScroller.OnAfterUpdate. ✅

       - T12 Criar evento onAfterInsert e depurar as consequencias caso retorne false; ✅
       - T12 Criar método Procedure updateCommands;  ✅
       - T12 Criar evento onBoforeInsert ✅
       - T12 Criar function GetNextValue(const SequenceName: string; IncrementBy: integer): Int64;✅
       - T12 Criar function MaxPKey(aTabela, aID: String): LongInt;overload;✅
       - T12 Criar Function MaxPKey: LongInt;Virtual;overload;✅
       - T12 Criar function GetRecNo: LongInt; virtual;✅
       - T12 Criar function TDmxFieldRec.Mask :TMask.✅
         - Retorna o tipo da mascrara contida no template;✅
       - T12 Checar porque o campo combobox não está funcinando o valor default;✅
       - T12 Criar método: Public Function UpdateRec_if_RecordAltered:Boolean;Virtual;✅
       - T12 Implementar edição do campo FldDateTime. Obs: 'D';   //:< D = TipoData dd/nn/yy✅
       - T12 Criar Método StarTransaction;✅
       - T12 Criar Método Commit✅
       - T12 Criar Método Rollback✅
       - T12 Quando o usuário teclar tab para passar o campo e o campo seguinte não
             estiver visível o sistema deve passar a página do  controle parent.✅

       - T12 Implementar a edição **FldBoolean**. ✅
             - Os campo Boolean deve ser editados como uma campo enumerado onde:
               - 0 - False; não
               - 1 = True;  sim

       - T12 Implementar a propriedade  AlignmentLabels := taCenter;  ✅
                                        AlignmentLabels := taLeftJustify;  ✅
                                        AlignmentLabels := taRightJustify ; ✅

       - T12 Na construção do formulário LCL setar o campo PDmxFieldRec.LinkEdit; ✅

       - T12 Implementar o método: function FieldByNum(aFieldnum:Integer):PDmxFieldRec; ✅

      - T12 Criar método Edit semelhante a TdataSet.edit ✅
      - T12 Criar método: Public Function UpdateRec_if_RecordAltered:Boolean;Virtual;✅

      - T12 Criar método para habilitar e desabilitar a tabela de acordo com seu
            estado atual; ✅

        - O método EnableUpdateNewRecord é habilita os botões grava e Refresh
          quando o modo appending for true. É acionando em ChangeMadeOnOff.
          - public procedure EnableUpdateNewRecord;✅

        - O método EnableUpdateRecord habilita os botões Novo, grava e Refresh quando
          o modo appending for false. É acionando em ChangeMadeOnOff.
          - public procedure EnableUpdateRecord;✅

        - T12 Criar método habilitar todos os botões quando em changeMadeOnOff
          O registro não foi alterado;
          - Public procedure EnableRefresh; ✅

        - T12 O Método Refresh deve anular o que foi digitado até o momento com
          os dados do dataset. ✅

        - T12 Quando o DataSet estiver vazio o evento Do OnNewRecord deve ser
          acionado no método .Refresh  ✅

        - T12 Criar Método: public procedure DisableCommands(aCommands: Array of AnsiString);✅
        - T12 Criar Método: Public procedure EnableCommands(aCommands: Array of AnsiString);✅
        - T12 Criar atributo: public Var Mi_ActionList : TActionList;✅
        - T12 Criar métodos: Public function GetAction(aName:AnsiString):TAction;✅
        - T12 Criar métodos: public Procedure SetStateAction(aName:AnsiString;aEnable:Boolean);✅
        - T12 Criar métodos: public Function getStateAction(aName:AnsiString):Boolean; ✅
        - T12 Criar métodos: public function CommandsEnabled(aCommands : array of ansistring): Boolean; ✅
        - T12 Criar métodos: public function CommandsDisabled(aCommands : array of ansistring): Boolean;  ✅
        - T12 Publica a propriedade DoOnNewRecord_FillChar e atualizar o buffer
             quando setado em true; ✅
        - T12 Criar atributo CurrentBookmark: TBookMark; ✅
        - T12 Criar método: Public Function GetRec :Boolean; Virtual; ✅
        - T12 Criar método: Public Function DeleteRec :Boolean; Virtual; ✅
        - T12 Criar método: Public Function PutRec:Boolean;Virtual;  ✅
        - T12 Criar método: Public Function UpdateRec: Boolean; Virtual;  ✅

        - T12 Criar método: Public Function AddRec:Boolean ;Virtual; ✅;
        - T12 Criar método: Public Function LastRec: Boolean;overload;virtual; ✅
        - T12 Criar método: Public Function FirstRec: Boolean;overload;virtual;  ✅
        - T12 Criar método: Public Function PrevRec: Boolean;overload;virtual;  ✅
        - T12 Criar método: Public Function NextRec: Boolean;overload;virtual; ✅


        - T12 O campo FldCheckBox não está funcionando o flag charHint  ✅.

        - T12 Implementar o controle ChatHint no Template para seja possível passar
              um documento markdown pelo Template; ✅.

        - T12 Ao executar o evento OnExit é necessário o redraw em de todos os campo caso
              haja alteração ao retorna da chamada. ✅.

        - T12 O componente TMi_ui_Button_lcl não está na lista dos campos 
              selecionados na tecla tab. ✅
        - T12 Os campos FldEnum não estão mostrando o help.  ✅

        - T12 Criar a propriedade Locked;  ✅

        - T12 No pacote mi.rtl.ui, transferir toda dependência do pacote LCL para o pacote mi.rtl.form.

        - T12  Implementar a propriedade TUiDmxScroller.JSONObject  ✅

        - T12 No método SetString em caso de erro de gera exceção informando
         valor máximo do campo  e não o valor digitado. ✅
}

{$mode Delphi}{$H+}
{$modeswitch advancedrecords}
interface

uses
  Classes, SysUtils,ActnList
  ,db
  ,BufDataset
  ,xmldatapacketreader
  ,SqlDb
  ,fpjson
  ,Variants
  ,mi.rtl.miStringlist
  ,mi.rtl.Consts.StrError
  ,mi.rtl.Objects.Methods.Exception
  ,mi.rtl.Objects.Methods
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,mi_rtl_ui_Types
  //,mi.rtl.ui.Dmxscroller.dates
  ,mi.rtl.objects.Methods.dates
  ,mi.rtl.Consts
  ,mi_rtl_ui_methods;

  type PSItem =  TUiMethods.PSItem;
  type tString =  TUiMethods.tString;
  type ptString = TUiMethods.Ptstring;
  type TDates = mi.rtl.objects.Methods.dates.TDates;
  type PValue = TUiMethods.PValue;
  type TValue = TUiMethods.TValue;
  type TEvent = TUiMethods.TEvent;
  type SmallWord  = TUiMethods.SmallWord;
  {:O tipo **@name** é usado para identificar o tipo de aplicação atual.
  }
  type TEnClientsApplication = TUiMethods.TEnClientsApplication ;

  {:O tipo **@name** é usado nos metodos que retornam nome de arquivos.
  }
  type TNameClientsApplication = TUiMethods.TNameClientsApplication;


  const AccNormal  = TUiMethods.AccNormal;
  const LF        = TConsts.LF;

  type

    { TUiDmxScroller }
    TUiDmxScroller = class;

//  type PAction = ^TAction;

    {: O tipo **@name** aponta para o campo do tipo TDmxFieldRec }
    pDmxFieldRec = ^TDmxFieldRec;

    { IMi_rtl_ui_Form }
    {: A interface **@name** é usado para garantir que os métodos necessários
       para implementação da classe visual de edição do TDmxScroller_Form sejam
       implementado.

       - Aplicações a fazer com a interface abaixo:

         ```text

           clients
           ├── dynamic_html
           │   ├── templates
           │   │   ├── mi.rtl.web.module.form.html
           │   │   └── mi.rtl.web.module.html
           │   ├── Tmi_rtl_web_module.form.html
           │   └── Tmi_rtl_web_module.html
           ├── javascript
           │   ├── templates
           │   │   ├── mi.rtl.web.module.form.js
           │   │   └── mi.rtl.web.module.js
           │   ├── Tmi_rtl_web_module.form.js
           │   └── Tmi_rtl_web_module.js
           ├── lcl
           │   ├── templates
           │   │   ├── mi.rtl.web.module.form.pas
           │   │   └── mi.rtl.web.module.pas
           │   ├── Tmi_rtl_web_module.form.pas
           │   └── Tmi_rtl_web_module.pas
           ├── reactjs
           │   ├── templates
           │   │   ├── mi.rtl.web.module.form.js
           │   │   └── mi.rtl.web.module.js
           │   ├── Tmi_rtl_web_module.form.js
           │   └── Tmi_rtl_web_module.js
           └── vuejs
               ├── templates
               │   ├── mi.rtl.web.module.form.vue
               │   └── mi.rtl.web.module.vue
               ├── Tmi_rtl_web_module.form.vue
               └── Tmi_rtl_web_module.vue

           11 directories, 20 files

77         ```

    }
    IMi_rtl_ui_Form= Interface
      ['{A43BA3BA-DE34-4F62-A32E-C65FFB94701B}']
      {$REGION '--->Construção da propriedade Alias'}
        Function GetAlias:AnsiString;virtual;
        Procedure SetAlias(Const aAlias:AnsiString);Virtual;
        Property Alias : AnsiString Read GetAlias Write SetAlias;
      {$ENDREGION}

       {:O método **@name** deve ser implementado na classe que implementa a
         edição da classe TUiDmxScroller.
       }
       procedure SetActive(aActive : Boolean);virtual;

       {$REGION --> Propriedade FldRadioButtonsAdicionados}
         {: Usado para evitar que RadiosButton sejam adicionados mais de uma vês em
            radiosgroups diferentes.
            - Mais informações veja campos FldRadioGrous.
         }
         function getFldRadioButtonsAdicionados:TStringList;

         property FldRadioButtonsAdicionados:TStringList read GetFldRadioButtonsAdicionados;

       {$ENDREGION --> Propriedade FldRadioButtonsAdicionados}

        procedure ShowControlState;Virtual;

        {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
           - **NOTA**
              - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
        }
        procedure Scroll_it_inview(AControl: pDmxFieldRec);Virtual;overload;

        {: O método **@name** é executado antes de executar getTemplate em SetActiveTarget.}
        procedure DoBeforeSetActiveTarget;Virtual;

        {: O método **@name** calcula a largura média do caractere só funciona bem
           para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
        function GetWidthChar():integer;virtual;Overload;

        function GetHeightChar():integer;virtual;Overload;

        {: O método **@name** calcula a largura média do caractere só funciona bem
           para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
        function TextWidthChar(AFont: TPersistent): Integer;virtual;overload;

        function TextHeightChar(AFont: TPersistent): Byte;virtual;overload;

        {: O método **@name** calcula a haltura média do caractere só funciona bem
           para as fontes Courie new ou Dejavu Sans Mono tamanho 12 }
        function TextHeightChar: Byte;virtual;overload;

//        procedure DestroyStruct; Virtual;  não precisa porque essa é uma caracteristica de dmxscroller.
        procedure LockUpdates;virtual;
        procedure UnlockUpdate;virtual;
        procedure UpdateBuffers_Controls;Virtual;

        {: O método **@name** refresh repinta os campo se foi auterado. }
        procedure Refresh;Virtual;
        procedure RefreshInternal;VIRTUAL;

        {: O método **@name** altera a fonte e o tamanho do controle passado por **ctrl** e de seus filhos.}
        procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String;aSize:integer);virtual;overload;

        {: O método **@name** altera a fonte do controle passado por **ctrl** e de seus filhos.}
        procedure ModifyFontsAll(ctrl_WinControl: TComponent;aFontName:String);Virtual;overload;

        {: O método **@name** Verifica se o componente fornecido possui uma relação
           db e se o conteúdo foi alterado.
        }
        function isValueDbChanged(Sender: TComponent): Boolean;Virtual;

        {: O método @name Executa o browser padrão do sistema operacional.

           - Exemplo:

             ```pascal

               program Project1;
                uses
                  Interfaces,
                  mi_rtl_ui_methods;
               begin

                TUiDmxScroller_ViewMethods.ShowHtml('https://wiki.freepascal.org/Webbrowser');

               end.
             ```
        }
        Procedure ShowHtml(URL:string);Virtual;

        {: O método **@name** inicia a documentação resumida do campo. aFldNum }
        Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;Virtual;overload;

        {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
        Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);Virtual;overload;

        {: O Método **@name** cria o formulário LCL baseado na lista de campos PDmxScroller. }
        procedure CreateForm();Virtual;
        procedure DestroyForm();Virtual;

        {: O método **@name** Trava a edição do formulário}
        Procedure SetLocked(aLocked:Boolean);virtual;

        {: O Método **@name** deve ser implementado na visão para que selecione
           o primeiro campo que pode ser editado do formulário.
        }
        Procedure Select_First_Field_Normal; virtual;

        {: O método **@name** deve ser implementado na visão para que selecione
           o registro que sefisfaça o valor digitado em inputBox do campo corrente.

           - O InputBox deve conter no label o nome do campo corrente;
        }
        function Locate(aField:pDmxFieldRec): TMI_MsgBox.TModalResult;Virtual;

        {O método **@name** é usuado para criar formulários clientes baseados em
         templates da aplicação destino.
        }
        procedure BuildCustomerFormFromTemplate;Virtual;
    end;

    {: Usado para criar modelos de formulários dinamicamente usando como parâmetro
    listas de PSItems.}
    TOnGetTemplate = function (aNext: PSItem) : PSItem of Object unimplemented;

    {: O tipo @name é usado para criar modelos de formulários dinamicamente usando o método add

       - **EXEMPLO**

         ```pascal

           Procedure AddTemplate(const aUiDmxScroller:TUiDmxScroller);
           begin
             with aUiDmxScroller do
             begin
               add('~EXEMPLO DE TEMPLATE~');
               add('');
               add('~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS');
               add('~Alfanumérico maiúscula e minuscula com 30 posições:~');
               add('~~\ssssssssssssssssssssssssssssssssssssss');
               add('~Alfanumérico com a primeira letra maiúscula:~\Sssssssssssssss');
               add('~Valor double.......:~\RRR,RRR.RR');
               add('~Valor SmalInt......:~\II,III');
               add('~Valor Byte.........:~\BBB');
               add('~Valor SmallWord....:~\WW,WWW');
               add('~Sexo...............:~'+ CreateEnumField(TRUE, accNormal, 0,
                                             NewSItem(' indefinido ',
                                             NewSItem(' Masculino',
                                             NewSItem(' Feminino',
                                                     nil)))));
               add('~Estado Civil              ~\KA Indefinido  '+chFN+'Sexo');
               add('~~\X Casado?                \KA Masculino    ');
               add('~~\X Pretende se divorciar? \KA Feminino     ');
               add('~~\X Tens filhos?          ');
               add('');
             end;
           end;

           procedure TForm1.DmxScroller_Form1AddTemplate(const aUiDmxScroller: TUiDmxScroller);
           begin
             AddTemplate(aUiDmxScroller);
           end;

         ```
    }
    TOnAddTemplate = Procedure(const aUiDmxScroller:TUiDmxScroller) of Object unimplemented;

    {$REGION '<-- declaração do record TDmxFieldRec'}
      { TFldEnum_Lookup }
      {: A classe **@name** é usada para implementar campo ComboBox
         quando TDmxScroller estiver TDataSource <> nil porque o Lazarus
         espera em campos ComboBox um string e não o índice da lista de strings.}
      TFldEnum_Lookup = class(TComponent)
        {$REGION Property DmxFieldRec }
          private _DmxFieldRec : pDmxFieldRec;
          private Procedure SeTDmxFieldRec(aDmxFieldRec:pDmxFieldRec);

          {: A propriedade **@name** contém o campo comboBox se ser editado }
          public property DmxFieldRec : pDmxFieldRec read _DmxFieldRec Write SeTDmxFieldRec;

        {$ENDREGION Property DmxFieldRec }

        {: O atributo **@name** contém o arquivo em memória das opções do campo
           ComboBox sendo editado.}
        public BufDataSet : TBufDataSet;

        {: O atributo **@name** é a fonte de dados associado a TFldEnum_Lookup.BufDataSet
           do campo sendo editado.}
        public DataSource : TDataSource;

        {: O atributo **@name** contém o nome do campo chave da tabela associada.}
        public KeyField   : AnsiString;

        {: O atributo **@name** contém o nome do campo da tabela associada a ser visualizado.}
        public ListField  : AnsiString;

        {: O método **@name** retorna o dataset associado ao campo corrente }
        protected function GetBufDataSet:TBufDataSet;

        {: O constructor **@name** cria os campos TBufDataSet e TDataSource do campo TFldEnum_Lookup}
        public constructor create(aDmxFieldRec : pDmxFieldRec);overload;

        {: O destructor **@name** destrói os campos TBufDataSet e TDataSource do campo TFldEnum_Lookup}
        public destructor destroy;override;
      end;

      {: O tipo **@name** é usado para fazer pesquisa genérica no banco de dados
         quando a  tecla F7 é pressionada.}
      TEndProc = Procedure(Const AOwner:TUiDmxScroller; Const ADmxFieldRec:PDmxFieldRec);

      { TDmxFieldRec }
      {: O registro **@name** é usado para guardar as informações passadas
         pelos Templates das strings.

        - **REFERÊNCIA**
          - [Estrutura record e object]https://wiki.freepascal.org/Record

        - A aparência padrão dessas visualizações geralmente é orientada por
          coluna/linha, com exceção de exibições do tipo formulário e campos
          únicos.
        - Você declara uma estrutura de registro para o procedimento de
          inicialização do **tvDMX** em um modelo string – que também determina
          o formato de exibição. (Você verá mais tarde como o **tvDMX** pode
          ser usado para trabalhar com formulários ou editores de campo.)

        - **EXEMPLO**

          - O Template '\ sssssssss`sssssssssss \ iiii \ rrr.rr' representa o
            registro:
            - **CÓDIGO PASCAL**

                ```pascal

                   type

                     TRecord = Record
                                 nome : String [20];
                                 Ano  : Integer;
                                 Valor : Real;
                               end;
               ```

            - **NOTA:**
              - A letra ( **s** ) minúsculo aceita qualquer número e letras
                maiúsculas e minúsculas;

              - A letra ( **i** ) representa um número inteiro com 2 bytes
                com edição em 4 posições (0 a 9999);

              - A letra ( **r** ) representa um número real com 8 bytes com
                edição em 5 posições (0 a 999.99)

              - O símbolo ( **`** ) crase é usado para informar que a parte do
                texto depois deste sinal deve ser omitida da visão.

              - A símbolo ( **' \ '** ) barra invertida deve ser usada como
                delimitador de campo e é exibida como um espaço em branco.

              - O símbolo ( **~** ) til deve ser usado para separar rótulos
                dos campos de dados.

        - **ATENÇÃO**
           - O registro **@name** não pode ser **class** e nem conter **métodos virtuais**, porque este
             registro e alocado com as funções **new** e **dispose**.

           - Campos que podem ser publicados para uso em javascript.
             - Alias
             - AliasList
             - FieldName
             - Template_org
             - Mask
             - access
             - ShownWid
             - TypeCode
             - KeyField
             - ListField  : AnsiString;
             - ListComboBox  : PSItem;
             - ListComboBox_Default : Longint;
             - Default
      }
      TDmxFieldRec = Record //Esta estrutura não pode ser object pq não funciona.
         {: O campo **@name** é usado para associar label ao corrente campo.

            - **NOTA**
              - Esse campo foi necessário para implementar campos do tipo boolean [X]
                por que o mesmo sempre vem associado a um rótulos amigável e o controle
                checkbox precisa dele.

            - **EXEMPLO**
              - Template de um botão checkbox:

                ```pascal

                   Resourcestring
                     tmp_Aceita = '\X Aceita o contrato +ChFN+'Aceita_contrato'+CharHint+'Aceita os termos do contrato?';
                ```

         }
         Public Alias : AnsiString;
         {: O campo **@name** é usado para registrar as opções possívesivel para
            o campo.

            - **NOTAS**
              - Este campo deve ser criado em DataField.AddFileds() e destruido
                em dispose() quando o campo for:
                - FldRadioGroup;

              - Os Campos FldRadioGroup conté um alias do campo onde este alias é
                adicionado ao campo no qual o alias pertence.

              - **EXEMPLO**
                - Template de um botão radioButton:

                  ```pascal

                     Resourcestring

                       ^A~~\Ka Indefinido ^Bsexo^N+'O campo sexo é necessário para....';
                       ^A~~\Ka Masculino   ^Bsexo
                       ^A~~\Ka Feminino   ^Bsexo
                  ```

         }
         Public AliasList : TStringList;

         {: O função **@name** retorna o tipo da mascara contida em template_org;
         }
         public function Mask :TDates.TMask;

         {: O campo **@name** guarda o componente corrente que está editando esse campo.}
         public LinkEdit :  TComponent;

         {$REGION 'Construção Propriedade FieldName'}
           private  _FieldName : AnsiString;
           private procedure SetFieldName(aFieldName : AnsiString);
           {: O campo **@name** guarda o nome do campo e deve ser inicializado
              em CreateStruct}
           public property FieldName : AnsiString  read _FieldName write SetFieldName;
         {$ENDREGION 'Construção Propriedade FieldName'}

         {: O campo **@name** guarda o modelo original do Template e deve ser inicializado em
            CreateStruct}
         public Template_org : AnsiString;

         {: O campo **@name**  aponta para o próximo campo }
         public Next          :  pDmxFieldRec;

         {: O campo **@name** é usado para referenciar-se a si mesmo.}
         public RSelf         :  pDmxFieldRec;

         {: O campo **@name**  aponta para o campo anterior
         }
         public Prev          :  pDmxFieldRec;

         {: O campo **@name** é usado para read-only, hidden, skip, accSpecX
         }
         public access        :  byte;

         {: O campo **@name** Número do campo, varia de 1 a totalFields (Se zero
           (0) é porque trata-se um rótulos)
         }
         public Fieldnum      :  Integer;

         {: O campo **@name** contém o número do controle}
         public ScreenTab     :  integer;

         {: O campo **@name** informa a largura do campo}
         public ColumnWid     :  byte;
         {: O campo **@name** informa o número de caracteres que serpa visualizado}
         public ShownWid      :  byte;

         {: O campo **@name** é usado para o tipo do código 's', 'r', etc.}
         public TypeCode      :  AnsiChar;

         {A o campo **@name** é iniciado quando este registro
          estiver sendo usado por componentes herdado de TUiDmxScroller que
          precisem acessar banco de dados com TDataSet.
         }
         Public FldEnum_Lookup:TFldEnum_Lookup;

         {:  If the Field is numeric, fill in with '#0' if it's alphanumeric, fill in with ' '}
         public FillValue     :  AnsiChar;

         public UpperLimit    :  byte;         //:< maximum value limit
         public ShowZeroes    :  boolean;      //:< display zero values
         public TrueLen       :  byte;         //:< unformatted text length
         public Parenthesis   :  boolean;      //:< '('/')' AnsiCharacters
         public Decimals      :  byte;         //:< decimal point or cluster value
         public FieldSize     :  integer;      //:< sizeof (datatype)
         public
         public DataTab       :  integer;      //:< position in record
         public Template      :  ptString;     //:< Field Template

         {$REGION ' ---> Property DataSource : TDataSource '}
            {: A propriedade **@name** permite que controles da **LCL** (Lazarus Componentes Library)
                possam usar os dados do componente **TDmxScroller**.

                - **NOTA**
                  - Essa integração permite que **TDmxScroller** utilize todos os componentes de banco
                    de dados do Free Pascal.
            }
           public DataSource : TDataSource;
         {$ENDREGION ' <--- Property DataSource : TDataSource '}

         {: O atributo **@name** contém o nome do campo chave da tabela associada
            a ListComboBox.
         }
         public KeyField   : AnsiString;

         {: O atributo **@name** contém o nome do campo da tabela associada a ser visualizado a ListComboBox.}
         public ListField  : AnsiString;

         {: O atributo **@name** contém uma lista de opções possíveis para o campo.

            - Nota:
              - Após caractere **CharListComboBox** contém um ponteiro para uma
                lista de opções do mesmo tipo de campo.
                - Exemplo:
                  ```pascal

                     Const
                        '~Dia de vencimento:~\Ssssss'+ChFN+'Dia'+CreateOptions(accNormal, 1,
                           NewSItem('Dia 10',
                           NewSItem('Dia 15',
                           NewSItem('Dia 20',
                           NewSItem('Dia 25',
                                    nil)))));
                  ```
         }
         Public ListComboBox  : PSItem;

         {: O Atributo **@name*** é usado guardar o valor padrão
            para a lista do BomboBox ou LookupBox

            - Exemplo para selecionar "Dia 20" da lista.
              - O número **2** representa  o terceiro item da lista.
              ```pascal

                 Const
                    '~Vencimento:~\Ssssss'+ChFN+'Dia'+CreateOptions(accNormal, 2,
                       NewSItem('Dia 10',
                       NewSItem('Dia 15',
                       NewSItem('Dia 20',
                       NewSItem('Dia 25',
                                nil)))));
              ```
         }
         public ListComboBox_Default : Longint;

         {: O Atributo **@name*** é usado guardar o valor padrão de campos e é
            setado usando o caractere charDefaut = chDf+'Digite o seu nome?'

            - Exemplo de como editar um campo onde o que fazer está em seu conteúdo.

              ```pascal

                 Const
                    '\Sssssssssssssssssssssssssss'+ChFN+'nome'+chDf+'Digite o seu nome?'
              ```
         }
         public Default : String;

         {$Region ID_Dynamic}
           Private _ID_Dynamic  : AnsiString; // Usado para gerar paginas html dinamicamente
           Public Property ID_Dynamic : AnsiString Read _ID_Dynamic Write _ID_Dynamic;
         {$EndRegion ID_Dynamic}

         {$Region owner}
           private _owner_UiDmxScroller :  TUiDmxScroller;
           private Procedure SetOwner(a_owner:TUiDmxScroller);
           public property owner_UiDmxScroller :  TUiDmxScroller read _owner_UiDmxScroller write SetOwner;
         {$EndRegion owner}

         Public Function GetOwner: TUiDmxScroller;

         {: O campo **@name** é inicializado no interpretador de Template quando
            o caractere **CharExecAction** é encontrado.

            - **EXEMPLO DE USO DE AÇÕES NO TEMPLATE**
               1. Se o atributo **Fieldnum** do campo for diferente de zero,
                  então o **rótulo** do botão associado a ação será o caracteres 🔍
                  e a ação pode atualizar o buffer do campo.
                  - No exemplo a seguir a função CreateExecAction retorna a string
                    **chFN+aFieldName+'~ 🔍~'+ChEA+(aFieldName+'.'+aExecAction)**.
                  - O interpretador de Template atualiza a string LinkExecAction caso o
                    o ponto seja encontrado no ExecAction do Label.

                    ```pascal

                       Result := NewSItem('~Cliente:~'+'\LLLLL'+
                                           CreateExecAction('Cliente',Pesquisa.Name),nil);

                    ```

               2. Se o atributo **Fieldnum** do campo for igual a zero,
                  então a rótulo do botão será o rótulo do campo.
                  - No exemplo a seguir um rótulo de novo cliente (icons  🆕) e
                    um botão ok (icons 🆗)

                    ```pascal

                      NewSItem('~ 🆕 &Novo cliente:~'+CharExecAction+Action_Novo.name+
                               '~   ~~ 🆗 ~'+CharExecAction+Action_Ok.name)

                    ```
         }
         Public ExecAction : AnsiString;

         {: O atributo **@name** é atualizado com o ponteiro do campo passado
            por **execAction**.

            - O Interpretador de Template deve pegar o campo usando a função
              FieldByName(aFieldName passado em execAction), quando execAction
              tiver um ponto antes do nome da ação.
              - Ex: **(aFieldName.aExecAction)**.

            ```pascal

               Result := NewSItem('~Cliente:~'+'\LLLLL'+CreateExecAction('Cliente',Pesquisa.Name),nil);

            ```
         }
         public LinkExecAction : pDmxFieldRec;

         {: O campo **@name** indica que este campo não deve ser visualizado,
            usado nos campos tipo senha}
         public CharShowPassword   :  AnsiChar;
         public var _Mask : TDates.TMask;

         {: O campo **@name** se true os campos Strings passa para o próximo
            campo quando o cursor estiver na ultima posição e um novo caractere
            for digitado.
         }
         public QuitFieldAltomatic : Boolean;

         {: O campo **@name** contém a posição do curso quando este campo estiver
            sendo editado.
         }
         Public CurPos : integer;

         {: O campo **@name** posição do início da seleção quando este campo
            estiver sendo editado.
         }
         public SelStart        : Integer;

         {: O campo **@name** contém a posição do fim da seleção quando este campo
            estiver sendo editado.
         }
         public SelEnd          : Integer;

         {$REGION 'Construção Propriedade FieldAltered'}
           private public _FieldAltered   : Boolean;
           private function GetFieldAltered:Boolean;

           {: A propriedade **@name** indica que o campo foi alterado e deve ser
              atualizado na visão caso a tabela esteja em modo de edição.
           }
           public property FieldAltered : Boolean read GetFieldAltered write _FieldAltered;
         {$ENDREGION 'Construção Propriedade FieldAltered'}

         {: O campo **@name** contém a documentação resumida do registro.
         }
         public HelpCtx_Hint : AnsiString;

         {: O campo **@name** contém o por que preciso deste campo?
         }
         public HelpCtx_Porque    : AnsiString;

         {: O campo **@name** contém o texto indicando onde esse campo será usado?
         }
         public HelpCtx_Onde      : AnsiString;

         //public HelpCtx_Como      : AnsiString; //:< Como esse campo pe usado?
         //public HelpCtx_Quais     : AnsiString; //:< Quais locais onde esse campo será usado?
         //public HelpCtx_Historico : AnsiString; //:< Histórico do projeto.

         {$REGION 'Construção Propriedade OkSpc'}
           {: Salva o valor de _OkSpc antes de setar com aOkSpc}
           public  _OkSpcAnt  : Boolean;
           Private _OkSpc  : Boolean;
           Private procedure SetOkSpc(aOkSpc  : Boolean);
           public Property OkSpc : Boolean read _OkSpc write SetOkSpc;
         {$ENDREGION 'Construção Propriedade OkSpc'}

         {$REGION 'Construção Propriedade OkMask'}
           Private _OkMask  : Boolean;
           function getOkMask: Boolean;
           procedure SetokMask(AValue: Boolean);
           {: O método **@name** é usado para habilitar ou não em GetString
           a mascara em campos numéricos.}
           public Property OkMask : Boolean read getOkMask write SetokMask;
         {$ENDREGION 'Construção Propriedade OkMask'}

         public Function GetAsStringFromBuffer(aWorkingData : pointer):AnsiString;
         function RemoveMaskNumber(S: AnsiString): AnsiString;
         function RemoveMask(S: AnsiString): AnsiString;
         Function AddMask(S: AnsiString;DisplayText: Boolean):Ansistring;

         {$REGION 'Construção do propriedade AsString'}
           public Procedure SetAsString(S:AnsiString);
           public Function GetAsString:AnsiString;
           Public Property AsString : AnsiString read GetAsString write SetAsString;
         {$ENDREGION 'Construção do propriedade AsString'}

         {$REGION 'Construção da propriedade Variante'}
           Private Function GetValue:Variant;
           Private Procedure SetValue(aValue:Variant);
           Public Property Value : Variant Read GetValue write SetValue;
         {$ENDREGION 'Construção da propriedade Variante'}

        //        public function IsButton:Boolean;
         Public Function IsInputText:Boolean;
         public function SItemsLen(S: PSItem) : SmallInt;
         public function MaxItemStrLen(AItems: PSItem) : integer;
         Public Function GetMaxLength():integer;
         public function IsStaticText:Boolean;
         public function IsInputRadio:Boolean;
//           public function IsInputDbRadio:Boolean;
         public function IsInputCheckbox:Boolean;
         public function isInputPassword:Boolean;
         public function IsInputHidden:Boolean;

         {: O objeto filho que implementar um ISelect deve anular e retornar
           a interface ISelect;}
         public function IsSelect:Boolean;

         {: Usado quando trata-se de campos enumerados em memória ou em arquivos.}
         public function IsComboBox:Boolean;

         Public function FirstField : pDmxFieldRec;
         Public function LastField  : pDmxFieldRec;
         Public function NextField  : pDmxFieldRec;
         Public function PrevField  : pDmxFieldRec;

         //Public Function SelectFirstField  : pDmxFieldRec;
         //Public Function SelectLastField  : pDmxFieldRec;

    //         private Var _reintrance_Select:boolean;
         Public Procedure Select;

         //=============================================================================================================
         {$Region '//*** propriedade Cluster e seus métodos usados para as Interfaces IInputRadio e IInputCheckBox ***'}
         //=============================================================================================================

             Public Function GetCount_Cluster:Integer;

             //Construção da propriedade IInputRadio.Value
             Public Function GetValue_Cluster(aItem: Integer):AnsiString;//=string value passed to form processing application
             Public Procedure SetValue_Cluster(aItem:Integer;wValue:AnsiString);

            //Construção da propriedade IInputRadio.Checked
             Public  Function GetChecked_Cluster( aItem: Integer):Boolean;       {property Checked Read GetChecked}
             Public  Procedure SetChecked_Cluster( aItem : Integer;aValue:Boolean); {property Checked Write SetChecked}

        {$EndRegion '//*** Construção da propriedade Cluster e seus métodos usados para IInputRadio e IInputCheckBox ***'}
         //=============================================================================================================

         //=============================================================================================================
         {$Region '//*** interface IInputRadio ***'}
         //=============================================================================================================
            //Construção da propriedade Count do IInputRadio
             Public Function GetCount_InputRadio:Integer;

             //Construção da propriedade IInputRadio.Value
             Public Function GetValue_InputRadio(aItem: Integer):AnsiString;//=string value passed to form processing application
             Public Procedure SetValue_InputRadio(aItem:Integer;aValue:AnsiString);

            //Construção da propriedade IInputRadio.Checked
             Public  Function GetChecked_InputRadio( aItem: Integer):Boolean;       {property Checked Read GetChecked}
             Public  Procedure SetChecked_InputRadio( aItem : Integer;aValue:Boolean); {property Checked Write SetChecked}

             //Nota: Retorna o numero do item Selecionado
             Public Function get_Item_Focused_InputRadio:Longint;

         {$EndRegion '//*** Implementação da interface IInputRadio ***'}
         //=============================================================================================================

         //=============================================================================================================
         {$Region '//***  INTERFACE IInputCheckbox ***' }
         //=============================================================================================================

             {: Construção da propriedade Count
                - Objetivo: Retorna o numero de items da lista onde os itens devem ser acessados com index 0 a count-1
             }
             Public Function GetCount_InputCheckbox:Integer;

             {: Construção da propriedade Value

                - Objetivo: Ler o label associado a opção ou trocar seu valor.

                - Sintaxe: Setando = Value[1] = 'Sim'; Value[2] = 'Nao'; Value[1] = 'Yes'
                           Lendo   = If LowerCase(Value[1]) = 'SIM' Then;
             }
             Public Function GetValue_InputCheckbox(aItem: Integer):AnsiString;
             Public Procedure SetValue_InputCheckbox(aItem: Integer;aValue:AnsiString);

             {: Construção da propriedade Checked - Sintaxe: 1 = If Checked[1] then; 2 = Checked[1] := True.

                - Objetivo: Selecionar um item da lista de opções ou checar se a opção está selecionada
             }
             Public Function GetChecked_InputCheckbox( aItem: Integer):Boolean;
             Public Procedure SetChecked_InputCheckbox( aItem : Integer;aValue:Boolean);

         //=============================================================================================================
         {$EndRegion '//***  IMPLEMENTAÇÃO DATA INTERFACE IInputCheckbox ***' }
         //=============================================================================================================

         {: Construção da propriedade Count de campos enumerados
            - Objetivo: Retorna o numero de items da lista onde os itens devem ser acessados com index 0 a count-1
         }
         Public Function GetCount_Select:Variant;

         {: Número de Linhas a ser mostrada no box. Usado em campos enumerados.}
         Public Function GetSize_Select():Variant;//=n specifies the number of options to display

         {: Construção da propriedade Value
            - Objetivo: Ler o label associado a opção ou trocar seu valor.

            - Sintaxe: Setando = Value[1] = 'Sim'; Value[2] = 'Nao'; Value[1] = 'Yes'
                       Lendo   = If LowerCase(Value[1]) = 'SIM' Then;
         }
         Public Function GetValue_Select(aItem: Integer):AnsiString;

         Public Procedure SetValue_Select(aItem: Integer;aValue:AnsiString);

         {: Construção da propriedade Checked - Sintaxe: 1 = If Checked[1] then; 2 = Checked[1] := True.

            - Objetivo: Selecionar um item da lista de opções ou checar se a opção está selecionada
         }
         Public Function GetChecked_Select( aItem: Integer):Boolean;

         Public Procedure SetChecked_Select( aItem : Integer;aValue:Boolean);

         {: O método **@name** retorna true se o campo é numérico e false se alfanumérico}
         Public Function IsNumber:Boolean;
         Public Function IsNumberReal:Boolean;
         Public Function IsNumberInteger:Boolean;
         Public Function IsNumberString:Boolean;
         public function IsBoolean: Boolean;
         Public function IsData: Boolean;
//           Public function IsHora: Boolean;

         //Número da Linha inicial
         Private _FldOrigin_Y : Integer      ;
         Private Function GetFldOrigin_Y:Integer;
         Public Property FldOrigin_Y:Integer Read GetFldOrigin_Y Write _FldOrigin_Y;

         //Construção da propriedade Origin
         Private Function GetFldOrigin: TPoint;
         Public Property FldOrigin  : TPoint read getFldOrigin;

         //Public Function GetLeft :Integer;
         //Public Function GetTop :Integer;
         //Public Function GetWidth :Integer;
         //Public Function GetHeight :Integer;

         public Function SetAccess(aaccess :  byte):Byte; //Seta access e retorna conteúdo anterior


         {$REGION ' ---> Property reintrance_OnEnter : Boolean '}

           strict Private Var _reintrance_OnEnter : Boolean ;
           strict Private Function  Getreintrance_OnEnter : Boolean;
           strict Private Procedure Setreintrance_OnEnter (areintrance_OnEnter : Boolean );
           Public

           {: A propriedade **@name** usado para evitar reentrância do evento DoOnEnter()
           }
           property  reintrance_OnEnter: Boolean Read Getreintrance_OnEnter   Write  Setreintrance_OnEnter;
         {$ENDREGION}

         {$REGION ' ---> Property reintrance_OnExit : Boolean '}
           strict Private Var _reintrance_OnExit : Boolean ;
           strict Private Function  Getreintrance_OnExit : Boolean;
           strict Private Procedure Setreintrance_OnExit (areintrance_OnExit : Boolean );

           {: A propriedade **@name** é usado para evitar reentrância do evento DoOnExit()
           }
           Public property  reintrance_OnExit: Boolean Read Getreintrance_OnExit   Write  Setreintrance_OnExit;
         {$ENDREGION}


         {:O método **@name** é executado toda vez antes do controle ler do
            buffer do campo.

           - **Descrição**
             - O método `DoOnEnter` é chamado quando o campo associado à instância
               de `TDmxFieldRec` recebe foco. Ele assegura que o campo seja registrado
               como o campo atual e atualizado adequadamente dentro do `owner_UiDmxScroller`.
               Além disso, ele executa os eventos de entrada de campo e cálculo de campo,
               se definidos, e também atualiza os buffers se o campo foi alterado.

           - **Parâmetros Locais**
             - `reintrance_DmxFieldRec_OnEnter`: Variável booleana para evitar
               reentrância no método, garantindo que a lógica seja executada
               apenas uma vez por chamada.

           - **Fluxo de Execução**
             1. Verifica se `reintrance_DmxFieldRec_OnEnter` está desativada e
                se `owner_UiDmxScroller` está atribuído.
              2. Define `reintrance_DmxFieldRec_OnEnter` como `true` para evitar
                 reentrância.
              3. Chama os métodos `SetCurrentField` e `Scroll_it_inview` no
                 `owner_UiDmxScroller` para atualizar o campo atual e garantir
                 que ele esteja visível na interface.
              4. Executa o evento `onEnterField` se ele estiver atribuído e o
                 número do campo (`Fieldnum`) for diferente de zero.
              5. Executa o evento `OnCalcField` se ele estiver atribuído e o
                 número do campo (`Fieldnum`) for diferente de zero.
              6. Se o campo tiver sido alterado (`FieldAltered`), chama os métodos
                 `PutBuffers` e `UpdateBuffers` no `owner_UiDmxScroller` para
                 atualizar o estado dos buffers.
              7. No bloco `finally`, redefine `reintrance_DmxFieldRec_OnEnter`
                 para `false`.

           - **Ver Também**
             - `TDmxScroller.SetCurrentField`
             - `TDmxScroller.Scroll_it_inview`
             - `TDmxScroller.onEnterField`
             - `TDmxScroller.OnCalcField`
             - `TDmxScroller.PutBuffers`
             - `TDmxScroller.UpdateBuffers`
         }
         Public procedure DoOnEnter(Sender: TObject);

         {:O método **@name** é executado toda vez antes do controle gravar no buffer do campo.

           - **Descrição**
             - O método `DoOnExit` é executado quando o campo associado à instância
               de `TDmxFieldRec` perde o foco. Ele garante que os eventos e cálculos
               relacionados à saída do campo sejam processados e que os buffers
               sejam atualizados se o campo foi alterado.

           - **Parâmetros Locais**
             - `reintrance_DmxFieldRec_OnExit`: Variável booleana para evitar
                reentrância no método, assegurando que o processamento de saída
                ocorra apenas uma vez por chamada.

           - **Fluxo de Execução**
             1. Verifica se `reintrance_DmxFieldRec_OnExit` está desativada e se
                `owner_UiDmxScroller` está atribuído.
             2. Define `reintrance_DmxFieldRec_OnExit` como `true` para evitar
                reentrância.
             3. Executa o evento `onExitField` se ele estiver atribuído e o
                número do campo (`Fieldnum`) for diferente de zero.
             4. Executa o evento `OnCalcField` se ele estiver atribuído e o
                número do campo for diferente de zero.
             5. Se o número do campo for diferente de zero e o campo tiver sido
                alterado (`FieldAltered`), executa o evento `OnChangeField`
                (caso atribuído) e chama `DoChangeField`.
             6. Chama o método `DoCalcFields` para recalcular os campos, se necessário.
             7. Se o campo foi alterado, chama os métodos `PutBuffers`, `UpdateCommands`
                e `UpdateBuffers` para atualizar os buffers e comandos do scroller.
             8. No bloco `finally`, redefine `reintrance_DmxFieldRec_OnExit` para `false`.

           - **Ver Também**
             - `TDmxScroller.onExitField`
             - `TDmxScroller.OnCalcField`
             - `TDmxScroller.OnChangeField`
             - `TDmxScroller.DoChangeField`
             - `TDmxScroller.DoCalcFields`
             - `TDmxScroller.PutBuffers`
             - `TDmxScroller.UpdateCommands`
             - `TDmxScroller.UpdateBuffers`
         }
         Public procedure DoOnExit(Sender: TObject);

         {: O atributo **@name** é usado nos métodos **TUiDmxScroller_sql.CreateTables** e
            **TUiDmxScroller_sql.CreateBufDataset_FieldDefs** para integração do componente
            **TDmxScroller**  com o componente TSqlDbConnector.
         }
         public ProviderFlags : TUiTypes.TMiProviderFlags;

         {: O atributo **@name** é usado para criar chave estrangeira e os relacionamentos}
         public ForeignKey : TuiTypes.TForeignKey;

         {: O atributo **@name** contém uma string com o nome da tabela estrangeira e a lista de campos relacionados

            - **EXEMPLO**
              - CIDADES,ESTADO;CIDADE
                - CIDADES = tabela estrangeira
                - ESTADO = Estado da cidade.
                - CIDADE = Cidade do estado.

         }
         public KeyForeign : AnsiString;

         {:O método **@name** copia o conteúdo de TDataField para self

           - **Descrição**:
             - O método `CopyFrom` copia o valor de um campo de dados (`TField`)
               para a instância atual de `TDmxFieldRec`. Dependendo do tipo de
               dado, ele formata o valor adequadamente antes de atribuí-lo ao
               campo local `Value`.

           - **Parâmetros Locais**:
             - **aDataField**: `TField`
               - Campo de dados de onde o valor será copiado.
             - **wDefaultFormatSettings**: `TFormatSettings`
               - Armazena as configurações de formato padrão para datas e
                 números, ajustadas temporariamente durante a execução.
             - **s**: `AnsiString`
               - Variável temporária que armazena o valor do campo em formato
                 string.
             - **v**: `Variant`
               - Variável que pode armazenar diferentes tipos de dados.

           - **Fluxo de Execução**:
             1. **Verificação de Dados:**
                - Se o campo atual (`IsData`) for um campo de data:
                  - Ajusta as configurações de formato de acordo com a máscara (`Mask`).
                  - Copia o valor de `aDataField` para a variável `s`.
                  - Se `s` não for uma string vazia, atribui `s` ao campo `Value`.
                    Caso contrário, se o campo for numérico (`IsNumber`) ou de dados
                    (`IsData`), atribui `0`; caso contrário, atribui uma string
                    vazia (`''`).
                  - As configurações de formato são restauradas após o processamento.

             2. **Outro Tipo de Dado:**
                - Se o campo não for de dados (`IsData` é `False`):
                  - Se o campo for booleano (`IsBoolean`), atribui o valor booleano do campo de dados (`aDataField.AsBoolean`).
                  - Caso contrário, copia o valor diretamente de `aDataField`.

           - **Ver Também**:
             - `TField`
             - `TFormatSettings`
             - `TDates.SetDefaultFormatSettings`
         }
         public Procedure CopyFrom(aDataField:TField);

         {: O atributo **@name** copia o conteúdo de self para TDataField.
         }
         public Procedure CopyTo(aDataField:TField);

      end;

    {$ENDREGION '<-- declaração do record TDmxFieldRec'}

    {$REGION '<-- declaração do tipo de eventos'}

      {: O tipo **@name** é usado para implementar evento onEnter da classe TUiDmxScroller
      }
      TOnEnter = Procedure(aDmxScroller:TUiDmxScroller) of Object unimplemented;

      {: O tipo **@name** é usado para implementar evento onExit da classe TUiDmxScroller
      }
      TOnExit = Procedure(aDmxScroller:TUiDmxScroller) of Object unimplemented;

      {: O tipo **@name** é usado para implementar evento onNewRecord da classe TUiDmxScroller
      }
      TOnNewRecord = Procedure(aDmxScroller:TUiDmxScroller) of Object unimplemented;

      {: O tipo **@name** é usado para implementar evento OnCloseQuery da classe TUiDmxScroller

         - **NOTA*
           - Este evento é disparado antes de desativar a classe **TUiDmxScroller**.
             - Obs: Se o parâmetro **CanClose** for **false**, então a classe **TUiDmxScroller** não é desativado.

      }
      TOnCloseQuery = Procedure(aDmxScroller:TUiDmxScroller; var CanClose:boolean) of Object unimplemented;

      {: O tipo **@name** é usado no evento OnEnterField e disparado em TDmxFieldRec.DoOnEnter()}
      TOnEnterField = Procedure(aField:pDmxFieldRec) of Object unimplemented;

      {: O tipo **@name** é usado no evento OnExitField}
      TOnExitField = Procedure(aField:pDmxFieldRec) of Object  unimplemented;

      {: O tipo **@name** é usado no evento para calcular um campo, é executado
         em TDmxFieldRec.DoOnEnter() e TDmxFieldRec.DoOnExit()}
      TOnCalcField = Procedure(aField:pDmxFieldRec) of Object unimplemented;

      {: O tipo **@name** é usado para fazer calculos quando um valor campo é alterado.

         - PARÂMETROS:
           - aUiDmxScroller : Classi que edita o campo;
           - Previous_value : Valor do campo antes da auteração
           - Current_value  : Valor do campo atual.
      }
      TOnChangeField = Procedure(aField:pDmxFieldRec) of Object unimplemented;

      {: O tipo **@name** é usado para criar o evento OnBeforeInsert e disparado no método TUiDmxScroller.AddRec}
      TOnBeforeInsert = function(const aUiDmxScroller:TUiDmxScroller):boolean of Object unimplemented;

      {: O tipo **@name** é usado para criar o evento OnAfterInsert e disparado no método TUiDmxScroller.AddRec}
      TOnAfterInsert = function(const aUiDmxScroller:TUiDmxScroller):boolean of Object unimplemented;

      {: O tipo **@name** é usado para criar o evento OnBeforeUpdate e disparado no método TUiDmxScroller.PutRec}
      TOnBeforeUpdate = function(const aUiDmxScroller:TUiDmxScroller):boolean of Object unimplemented;

      {: O tipo **@name** é usado para criar o evento OnAfterUpdate e disparado no método TUiDmxScroller.PutRec}
      TOnAfterUpdate = function(const aUiDmxScroller:TUiDmxScroller):boolean of Object unimplemented;


      {: O tipo **@name** é usado para criar o evento OnBeforeDelete e disparado no método TUiDmxScroller.PutRec}
      TOnBeforeDelete = function(const aUiDmxScroller:TUiDmxScroller):boolean of Object unimplemented;

      {: O tipo **@name** é usado para criar o evento OnAfterDelete e disparado no método TUiDmxScroller.PutRec}
      TOnAfterDelete = function(const aUiDmxScroller:TUiDmxScroller):boolean of Object unimplemented;

      {: O tipo **@name** é usado para fazer calculos é executado ao entrar no registro e ao sair do registro}
      TOnCalcFields  = Procedure(const aUiDmxScroller:TUiDmxScroller) of Object unimplemented;

      {:O tipo enumerado **@name** é usado nas requisições httl do cliente.

        - **Notas**
          - Usado para classificar eventos do mesmo tipo de parâmetro no caso o
            cliente só precisa de o nome do campo para localizar o evento na lista
            de eventos.
      }
      TEn_OnEvent_DmxFieldRec = (EnOnEnterField,EnOnExitField,EnOnCalcField,EnOnChangeField );
    {$ENDREGION '<-- declaração do tipo de eventos'}

    {$REGION '<-- Implementação de TBufDataset'}

      {: A classe **@name** implementado porque o tipo TDataPacketFormat do freepascal
         não contém o tipo dfjson
      }
      TMiDataPacketFormat = (dfBinary,dfXML,dfXMLUTF8,dfAny,dfDefault,dfJSon);

      { TMiBufDataset }
      {: A classe **@name** usado para editar um buffer local salvando os
         dados no formato json.
      }
      TMiBufDataset = class(BufDataset.TBufDataset)
        Private _FileName : AnsiString;
        private _UiDmxScroller : TUiDmxScroller;
        Public property UiDmxScroller : TUiDmxScroller Read _UiDmxScroller;

        {$REGION ' Implementação da exportação e importação de arquivo di=o buffer'}

         {: O método **@name** salva os dados do BufDataset nos formatos dfBinary,
            dfXML,dfXMLUTF8,dfAny,dfJSon

            - **NOTA**
              - O que está funcionando é o formato json, os outros formatos uso o
                método savetofile do bufDataSet e funcionou uma vez e outras não.
         }
         Public Procedure SaveToFile(aFileName:AnsiString;aMiDataPacketFormat:TMiDataPacketFormat);Overload;

         {: O método **@name** salva os dados do BufDataset nos formatos dfDefault
         }
         Public Procedure SaveToFile();Overload;

         Public procedure LoadFromFile(aFileName: AnsiString;aMiDataPacketFormat: TMiDataPacketFormat);overload;
         Public procedure LoadFromFile();overload;

        {$ENDREGION ' Implementação da exportação e importação de arquivo di=o buffer'}

        procedure ApplyUpdates; virtual; overload;
      end;
    {$ENDREGION '<-- Implementação de TBufDataset'}

    { TDataFields }
    {: A class **@name** contém os ponteiros para os campos onde o parâmetro
       apDmxFieldRec.FieldNum seja diferente de zero.

       - **Motivo**:
         - Otimizar a pesquisa e agrupar todos os tamplates pertencentes ao
           mesmo campo usados nos controles TRadioButton.
       - **Local onde deve ser iniciado**
         - TUiDmxScroller.Create
           - DataFields : TDataFields;
         - O método TUiDmxScroller.CreateStructur deve adicionar o ponteiro Rex
           quando o número e o nome do campo for definido.

     }
     TDataFields = class(TMiStringList)
       public constructor Create;
      { the virtual procedures must be in THAT order }
       public destructor Destroy;override;
       Function AddKey(WKey:String;apDmxFieldRec:pDmxFieldRec):Boolean; overload;
       protected Procedure AddFields(apDmxFieldRec:pDmxFieldRec);
       Function getRec(aIndex:Longint):pDmxFieldRec;overload;
       Function getRec():pDmxFieldRec;overload;
     end;

    { TFields }
    {: A class **@name** contém a lista de todos os PdmxFieldRec contido no template.

       - **NOTAS*
         - O templates é composto de rótulos que devem ser representados pelos
           controles TLabel, botões de ações que deve ser representados por
           TActionIten, campos de banco de dados que deve ser representados por:
           Tdbedit, TdbChekBox, TdbRadioButon, TdbComboBox e caso o campo não
           exista no banco de dados então o mesmo deve ser representado por:
           Tedit, TChekBox, TRadioButon, TComboBox.
         - Caso uma TDataSource aponte para um Tbufdataset então somentes os
           controles data-ware estarão na lista e caso o DataSource aponte para
           um banco de dados externo então os campos que não existirem no banco
           serão editados pelos controles: Tedit, TChekBox, TRadioButon, TComboBox.
         -
    }
    TFields = class(TFPList)
      protected Procedure AddFields(apDmxFieldRec:pDmxFieldRec);
    end;

    {TUiDmxScroller}
    {: A classe **@name** tem como objetivo criar um formulário baseado em
       uma lista do tipo ShortString.

       - **NOTAS**
         - O método createStruct criar uma lista de campo tipo TDmxFieldRec com
           todas as informações necessárias para criar uma tabela ou um formulário.

         - O formulário é criado com apena uma linha.

       - **EXEMPLO**:
         - Template := '~Nome~\SSSSSSSSSSSSSSSSSSSS^Bnome ~Idade:~\BB^Bidade'
           - A classe cria a lista de campos:
             - Label1   : Nome
             - Field1   : campo ShortString com 20 posições maiúsculas
               - ^Bnome : A sequência após ^B contém o nome do campo
             - Label2   : Idade
             - Field2   : Campo byte com duas posições
               - ^Bidade: A sequência após ^B contém o nome do campo
             -
    }
    TUiDmxScroller = class(TUiMethods)
      type TDates = mi.rtl.objects.Methods.dates.TDates;
      procedure HandleEvent(var Event: TUiMethods.TEvent); override;

      {: O evento DoBeforeSetActiveTarget deve inicializar o atributo **@name**
         com o atributo owner caso  **@name** seja nil.

         - **ATENÇÂO**:
           - O atributo **@name** é o grupo no qual o formuláro será inserido.
           - Exemplo caso a aplicação sejá para desktop LCL:

             ```pascal

                 procedure TDmxScroller_Form_Lcl.BeforeSetActiveTarget;
                 begin
                   if not Assigned(ParentLCL) and (Owner is TScrollingWinControl)
                   then ParentLCL := Owner as TScrollingWinControl;

                   _Parent := ParentLCL;
                 end;
             ```
      }
    private
      private _Parent: TComponent;
      function GetParent: TComponent;
      procedure SetParent(AValue: TComponent);
      public property Parent: TComponent read GetParent write SetParent;


      {: O atributo **@name** salva todos os rótulos e campos da lista de
         Templates.

         - **MOTIVO**
           - A classe mãe TUiDmxScroller mãe da classe TDmxScroller_Form cria
             Template de apenas uma linha, a lista **@name** salva todas
             as linhas para geração de um Template do tipo formulário.
      }
      public  DMXFields : TFPList; //public

      {: O atributo **@name** contém uma lista pDmxFieldRec cujo
         **Fieldnum<>0**.

         - Essa lista é atualizada em createStruct
      }
      public Fields : TFields;

      {: O atributo **@name** salva somente os campos de dados cujo o campo filednum<>0}
      public DataFields : TDataFields;

      {$REGION ' ---> Métodos para controle de ações'}
        {$Region ' ---> Property Mi_ActionList'}
          {: O atributo **@name** deve ser iniciado no DataModule que usar esta classe}
          private Var _Mi_ActionList : TActionList;
          Private function Get_Mi_ActionList: TActionList;
          private Procedure Set_Mi_ActionList(a_Mi_ActionList:TActionList);
//          published property Mi_ActionList
          public property Mi_ActionList:TActionList read Get_Mi_ActionList write Set_Mi_ActionList;
        {$EndRegion ' ---> Property Mi_ActionList'}

        {: O Método **@name** retorna a ação associada a aName se existir}
        Public function GetAction(aName:AnsiString):TAction;

        {: O método **@name** habilita e desabila o botão aName}
        public Procedure SetStateAction(aName:AnsiString;aEnable:Boolean);

        {: O método **@name** retorna a propriedade Taction.enable}
        public Function getStateAction(aName:AnsiString):Boolean;

        {: O método **@name** retorna **true** se todos os comandos passados por
             aCommands estiverem desativados e retorna **false** se pelo menos um estiver
             ativado.

             - EXEMPLO

               ```pascal

                  if CommandsDisabled('novo','grava')
                  Then WriteLn('Os comandos novo e grava estão desabilitados');

               ```
        }
        public function CommandsDisabled(aCommands : array of ansistring): Boolean;

        {: O método **@name** retorna **true** se todos os comandos passados por
             aCommands estiverem ativados e retorna **false** se pelo menos um estiver
             desativado

             - EXEMPLO

               ```pascal

                  if CommandsEnabled('novo','grava')
                  Then WriteLn('Os comandos novo e grava estão ativados');

               ```
          }
        public function CommandsEnabled(aCommands : array of ansistring): Boolean;

        {: O método **@name** ativa todos os todos os comandos passados por aCommands.

             - EXEMPLO

               ```pascal

                  DisableCommands('novo','grava');
                  WriteLn('Os comandos novo e grava estão ativados');

               ```
        }
        Public procedure EnableCommands(aCommands: Array of AnsiString);

        {: O método **@name** desativa todos os todos os comandos passados por aCommands.

             - EXEMPLO

               ```pascal

                  DisableCommands('novo','grava');
                  WriteLn('Os comandos novo e grava estão desativados');

               ```
        }
        public procedure DisableCommands(aCommands: Array of AnsiString);

        {: O método **@name** habilita ou desabilita os botões de ações baseado
           no estado do dataset.
        }
        protected Procedure UpdateCommands;

        {: O método **@name** retorna um template para criação dos botões aCmNewRecord,
           aCmUpdateRecord,aCmLocate,aCmDeleteRecord,aCmCancel.
        }
        public class function GetTemplate_CRUD_Buttons(aCmNewRecord,aCmUpdateRecord,
                                                       aCmLocate,aCmDeleteRecord,aCmCancel:string):string;Virtual;overload;

        {: O método **@name** retorna um template para criação dos botões CmNewRecord,
           CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel.
        }
        public class function GetTemplate_CRUD_Buttons():string;overload;

        {: O método **@name** retorna um template para criação dos botões aCmGoBof,
           aCmNextRecord,aCmPrevRecord,aCmGoEof,aCmRefresh.
        }
        public class function GetTemplate_DbNavigator_Buttons(aCmGoBof,aCmNextRecord,
                                                              aCmPrevRecord,aCmGoEof,aCmRefresh:string):string;Virtual;overload;

        {: O método **@name** retorna um template para criação dos botões CmGoBof,
           CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh.
        }
        public class function GetTemplate_DbNavigator_Buttons():string;overload;

      {$ENDREGION ' ---> Métodos para controle de ações'}

      {: O método **@name** inicia a documentação resumida do campo. aFldNum }
      Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;virtual;overload;

        {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
      Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);virtual;overload;

      {: O método **@name** executa system.new cujo objetivo é controlar a memória
         alocada para que o método dispose possar de desalocar o que foi alocado.
      }
      private Procedure New(Var apDmxFieldRec: pDmxFieldRec);

      {: O método **@name** executa system.dispose cujo objetivo é controlar a memória
         alocada por new.
      }
      private Procedure Dispose(Var apDmxFieldRec: pDmxFieldRec);

      {:O atributo **@name** salva o limite inferior e superior da janela no qual
        foi criado os componentes dos formulários
      }
      public Limit : TPoint;

      {:O atributo **@name** indica que a classe voi criada.
      }
      Public CreateValid : boolean ;

      {:O atributo **@name** é um ponteiro para o buffer do registro}
      protected WorkingData   : pointer;

      {:O atributo **@name** é um ponteiro para o buffer do registro anterior}
      protected WorkingDataOld   : pointer;

      {$Region Implementação para salva o buffer para o caso de retornar ao estado anterior }
        Private wWorkingData     : pointer;
        private wWorkingDataOld  : pointer;

        Procedure SavewWorkingData;
        Procedure RestorewWorkingData;
        Procedure DestroywWorkingData;

      {$EndRegion Implementação para salva o buffer para o caso de retornar ao estado anterior }


      {:O atributo **@name** é o tamanho do registro apontado por WorkingData. }
      protected DataBlockSize : longint;

      {:O atributo **@name** contém o número da linha corrente}
      Public ActualRecordNum : longint;

      {: O atributo **@name** contém o primeiro campo da lista encandeada}
      Public DMXField1     : pDmxFieldRec;

      {: O atributo **@name** contém o canto a esqueda do campo atual.}
      private LeftField    : pDmxFieldRec;

      {: O atributo **@name** contém o total de campos da lista apontada por DMXField1}
      Public TotalFields   : integer;

      {: O atributo **@name** contém  o tamanho do buffer calculado por CreateStruct}
      Public RecordSize    : integer;

      {: O atributo **@name** contém o ponteiro do buffer do corrente campo calculado pela propriedade CurrentField}
      Public FieldData       : pointer;

      {$REGION ' ---> property CurrentRecord'}
        Private CurrentRecordOld : Longint;
        Private _CurrentRecord : Longint;
        Protected Procedure SetCurrentRecord (aCurrentRecord : Longint );Virtual;
         {: A propriedade **@name** salva o número do campo selecionado.}
        public property CurrentRecord : Longint read _CurrentRecord write SetCurrentRecord;
      {$ENDREGION ' ---> property CurrentRecord'}

      {: O atributo **@name** deve ser iniciado quando este controle for incluído em um TScrollingWinControl.
         em um controle gráfico.
         - **EXEMPLO**
           - WidthChar  := ((Owner as TScrollingWinControl).Canvas.TextWidth(UiDmxScroller.CharAlfanumeric)
                                div Length(UiDmxScroller.CharAlfanumeric));
      }
      public WidthChar :byte;

      {: O atributo **@name** deve ser iniciado quando este controle for incluído
         em um TScrollingWinControl.
         - **EXEMPLO**
           - HeightChar := (Owner as TScrollingWinControl).Canvas.TextHeight(CharAlfanumeric)+2;
      }
      public HeightChar :byte; //


      {: O atributo **@name** indica se algum campo da chave  foi alterado é setado em changeMade}
      protected KeyAltered    : Boolean ;

      {: O atributo **@name** contém a lista de campos que pertence a chave primária
         - **EXEMPLOS**:
           - **Chave simples**:
             - 'Matricula'.

           - **Chave composta**:
             - 'Estado,Cidade'.

         - **NOTA**
           - Se pos(';',@name) <> 0 indica que a chave é composta.
      }
      public keysPrimaryKeyComposite : AnsiString;

      protected flagPrimaryKey_AutoIncrement:Boolean;

      protected procedure ShowControlState;Virtual;abstract;

      {$REGION ' ---> Property Strings : TMiStringList '}

         private _Strings : TMiStringList;

         Private Function GetStrings:TMiStringList;
         Private Procedure SetStrings(a_Strings : TMiStringList);
         {: A propriedade **@name** o Strings é usada para editar o
            Template em tempo de projeto.
         }
         public property Strings : TMiStringList Read GetStrings   Write  SetStrings;

      {$ENDREGION ' <--- Property Strings : TMiStringList '}

      {$REGION ' ---> Property TableName : String '}

         private _TableName : String;

         {: O método **@name** é criado para criticar se o nome digitado é valido para uma tabela.}
         private procedure SetTableName(aTableName : String);

         {: A propriedade **@name** contém o nome da tabela ou consulta no banco de dados.

            - **NOTA**
              -  A propriedade **@name** é usado no método **SetSqlBufDataset**
                 para criação da propriedade **TCustomSQLQuery.SQL** e no método **AlterTable**
                 para criação da tabela ou consulta no banco de dados.
         }
         public property TableName : String Read _TableName   Write  SetTableName;
      {$ENDREGION ' <--- Property TableName : String '}

      {: O método **@name** atualiza o buffer dos controles associados ao componente.}
      public Procedure UpdateBuffers;Virtual;abstract;

      {$Region '---> Construção da propriedade Appending <---'}
        Private  _Appending        : Boolean; {}
        protected Function GetAppending:Boolean;VIRTUAL;
        protected Procedure SetAppending(aAppending:Boolean);VIRTUAL;

        {: A propriedade **@name** é usada para saber se está editando um novo registro ou não

           - **NOTA**
             - TRUE  = Indica que um novo registro esta sendo editado.
             - False = Indica que um registro existente está sendo editado ou visualizado.
             - Obs: Deve ser atualizado na visão caso a tabela está em edição.
        }
        public Property Appending : Boolean read GetAppending write SetAppending;

      {$EndRegion '---> Construção da propriedade Appending <---'}

//        Function SetDoOnCalcFields(Const WDoOnCalcFieldsEnable:Boolean):Boolean;

      protected Function SetOnCalcRecord(Const WOnCalcRecordEnable:Boolean):Boolean;

      {$REGION '--> propriedade RecordSelected'}

            Private var _RecordSelected  : boolean;
            protected Function GetRecordSelected : boolean;Virtual;

            protected Procedure SetRecordSelected(a_RecordSelected  : boolean);Virtual;
            protected property RecordSelected  : boolean read GetRecordSelected  Write SetRecordSelected default false;

      {$ENDREGION '--> propriedade RecordSelected'}

      {: O método **@name** seta os atributos indicativos de que o objeto foi alterado ou não.}
      procedure ChangeMadeOnOff(const aValue:Boolean);

      {$REGION '--> atributo Status'}

        {: O método **@name** seta o bit passado no parâmetro aState e retorna o estado anterior
           do mapa de bits passado por aState}
        public Function SetState(Const AState: Int64; Const Enable: boolean):Boolean;virtual;

        {: O Método **@name** recebe um mapa de bits e retorna:
           - false : Se o bite estiver desligado;
           - true ; Se o bit estiver ligado}
        public function GetState(Const AState: Int64): Boolean;Virtual;

        {: A propriedade **@name** usado para indicar o modo atual da class.

           - **MODOS**
             - Mb_St_Active = Mb_Bit21;
               - 0= Método CreateStructur não executado  e por isso não pode ser editado;
               - 1= Método CreateStructur foi executado e pode ser editado
               - NOTA:
                 - Esse bit deve ser setado em:
                   - CreateStructur indicando que o Template foi criado está pronta para ser editado.

             - Mb_St_Edit = Mb_Bit22;
               - 0 = Classe não está no modo de edição;
               - 1 = Classe está no modo de edição
               - NOTA:
                 - Esse bit deve ser setado em:
                   - OnEnter : O bit 22 é ligado informando que o formulário está sendo editado.
                   - onExit; : O bit 22 é desligado informando que o formulário não está sendo editado.

               - Obs: Deve ser setado em DoOnEdit;

             - Mb_St_Creating_Template  = Mb_Bit32;
               - 0=Nao esta criando Template;
               - 1=Esta criando o Template
               - **NOTA**
                 - Após o Template ser criado o tipo de acesso dos campos invisíveis não devem ser trocados.
                 - Motivo: Quando um campo é invisível o designer para mostrar o mesmo é ignorado
                   e caso o mesmo torne-se visível ele ficará sem identificação do que se trata.
        }
        private Status : Int64;
      {$ENDREGION '<-- atributo Status'}

      {: O método **@name** retorna o campo passado por aName. }
      public function FieldByName(aName:String):PDmxFieldRec;

      public function FieldByNumber(aFieldNum:Integer):PDmxFieldRec;

      {: O método **@name** copia o buffer do registro anterior para o buffer do registro atual
      }
      public  function CancelBuffers: Boolean;

      {: O método **@name** copia o buffer do registro atual para o buffer do registro
         anterior.

         - **OBSERVAÇÃO:**
           - O método **@name** deve ser anulado para ler o buffer dos campos dos arquivos
             associados   a classe **TUiDmxScroller**  para o buffer dos campos da classe
             **TUiDmxScroller**
      }
      protected function GetBuffers:Boolean;Virtual;

      {: O método **@name** deve ser anulado para grava o buffer dos campos da
         classe **TUiDmxScroller** para o buffer dos campos dos arquivos
         associados a classe **TUiDmxScroller**}
      protected function PutBuffers:Boolean;Virtual;//abstract;

      {$REGION '--> Property onCloseQuery'}
        protected _OnCloseQuery : TOnCloseQuery;

        {: O evento **@name** é disparado toda vez que o TUiDmxScroller é desativado.

        - **NOTA*
          - Este evento é disparado antes de desativar a classe **TUiDmxScroller**.
            - Obs: Se o parâmetro **CanClose** for **false**, então o formulário não é desativado.
        }
        public Property onCloseQuery : TOnCloseQuery Read _OnCloseQuery write _onCloseQuery;

        public Procedure DoOnCloseQuery(aDmxScroller:TUiDmxScroller ; var CanClose:boolean );overload;
        public Procedure DoOnCloseQuery(var CanClose:boolean );overload;


      {$ENDREGION '<-- Property onCloseQuery'}

      public function IsEmpty:Boolean;

      {$REGION '--> Property onEnter'}
        protected _OnEnter : TOnEnter;

        {: O evento **@name** é disparado toda vez que o TUiDmxScroller ativado.}
        public Property onEnter : TOnEnter Read _OnEnter write _onEnter;

        {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
           - **NOTA**
              - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
        }
        public procedure Scroll_it_inview(AControl: pDmxFieldRec);virtual;abstract;

        {: O método **@name** Executa o evento onEnter se o mesmo estiver assinalado. }
        protected Procedure DoOnEnter(aDmxScroller:TUiDmxScroller);Virtual;overload;
        public Procedure DoOnEnter();Virtual;overload;
      {$ENDREGION '<-- Property onEnter'}

      {$REGION '--> Property onExit'}
        protected _OnExit : TOnExit;

        {: O evento **@name** é disparado toda vez que o TUiDmxScroller é destivado.}
        public Property onExit : TOnExit Read _OnExit write _onExit;
        protected Procedure DoOnExit(aDmxScroller:TUiDmxScroller);overload;
        public Procedure DoOnExit();overload;
      {$ENDREGION '<-- Property onExit'}

      {$REGION '--> Property EnterField'}
        protected _OnEnterField : TOnEnterField;

        {: O evento **@name** é disparado toda vez que o controle corrente recebe o foco.}
        public Property onEnterField : TOnEnterField Read _OnEnterField write _onEnterField;
      {$ENDREGION '<-- Property EnterField'}

      {$REGION '--> Property ExitField'}
        protected _OnExitField : TOnExitField;
        {: O evento **@name** é disparado toda vez que o controle corrente perde o foco.}
        public Property onExitField : TOnExitField Read _OnExitField write _onExitField;
      {$ENDREGION '<-- Property ExitField'}

      {$REGION '--> Property CalcField'}
        protected _OnCalcField : TOnCalcField;

        {: O tipo **@name** é usado no evento para calcular um campo e é executado
           em TDmxFieldRec.DoOnEnter() e TDmxFieldRec.DoOnExit()}
        public Property onCalcField : TOnCalcField Read _OnCalcField write _onCalcField;

      {$ENDREGION '<-- Property CalcField'}

      {: Executado antes de construir o componente}
      public procedure BeforeDestruction;override;

      {: Constrói o componente}
      public constructor Create(aOwner:TComponent);Override;

      {: Destrói o componente}
      public destructor destroy;override;

      {: A procedure **@name** é executado para construir a lista apontada por
         DMXField1 baseado no Template do tipo TString.

         - **NOTA**
           - O parâmetro aTemplate é um string com 255 caracteres, porém o mesmo
             pode ser encandeado usando a função CreateAppendFields.

           - A função CreateAppendFields retorna a constante **fldAPPEND** mais
             o endereço da string a ser concatenada.

             - **EXEMPLO**

               ```pascal
                  Var
                    S1,s2,Template : TString;
                  begin
                    S1 := '~Nome do Aluno....:~\ssssssssssssssssssssssssssssssssss';
                    s2 := '~Endereço do aluno:~\sssssssssssssssssssssssss';
                    Template := S1+CreateAppendFields(s2);
                  end;
               ```
      }
      protected procedure CreateStruct(var ATemplate : TString);virtual;overload;

      {: A procedure **@name** é executado para construir a lista apontada por
         DMXField1 baseado na lista PSItem.

         - **NOTA**
           - O parâmetro aTemplate é uma lista PSitem.
           - A função CreateTSItemFields retorna uma lista de PSItem.
             - **EXEMPLO**

               ```pascal
                  Var
                    Template : PSItem;
                  begin
                    Template := CreateTSItemFields(
                                          NewSItem('cccccccccccccccccccccccccccccccccccccccccccccccccc',
                                          NewSItem('cccccccccccccccccccccccccccccccccccccccccccccccccc',
                                          NewSItem('cccccccccccccccccccccccccccccccccccccccccccccccccc',
                                          NewSItem('cccccccccccccccccccccccccccccccccccccccccccccccccc',
                                          NewSItem('cccccccccccccccccccccccccccccccccccccccccccccccccc',nil))))))
                  end;
               ```
      }
      protected procedure CreateStruct(var ATemplate : PSItem);virtual;overload;

      {: A procedure **@name** interpreta o Template obtido em getTemplate e cria a lista
         de **pDmxFieldRec** associada ao Template.

         - **Nota**
           - O Template pode ser obtido pela propriedade Template se Template<> ''
            ou retornado pelo evento onGetTemplate.
      }
      protected procedure CreateStruct();virtual;overload;

      {: A procedure **@name**  destrói as lista criada por CreateStruct acima.}
      protected procedure DestroyStruct;virtual;

      {: O método **@name** é usado para criar os campos de **BufDataset**

         - Dica

           ```pascal
              if GetDataSet.DefaultFields
              Then WriteLn('Os campos foram criados baseado nos metadados do banco de dados')
              else WriteLn('Os campos foram criados em tempo de designer ou tempo de execução.');
           ```
      }
      protected Procedure CreateBufDataset_FieldDefs;virtual;

      {: A procedure **@name** é usada para alocar (RecordSize) memória para o buffer (WorkingData)
        do registro calculado por createStruct}
      Protected procedure CreateData;  Virtual;

      {: A procedure **@name** é usada para desalocar memória do buffer do registro criado por CreateData}
      protected procedure DestroyData;virtual;

      {: A função **@name** retorna o atributo WorkingData }
      Public Function GetRecordData : Pointer;virtual ;

//        public procedure SetWorkingData(var aWorkingData  ; aDataBlockSize : longint ); Virtual;
      protected Procedure SetLimit(X, Y: Integer);virtual;

      {$REGION ' ---> Property onGetTemplate : TGetTemplate '}
         {: O Atributo **@name** um ponteiro para uma função do tipo TOnGetTemplate}
         private _onGetTemplate : TOnGetTemplate;

         {: O evento **@name** substitui o método getTemplate caso OnGetTemplate<>nil}
         public property  onGetTemplate : TonGetTemplate Read _onGetTemplate   Write  _onGetTemplate;

         {: O método **@name** é usado para atualizar o atributo _onGetTemplate com o
            modelo informado pelo usuário caso o onGetTemplate seja nil.

            - **NOTA**
              1. O Evento _onGetTemplate só é iniciado em tempo de execução por
                isso o formulário não pode ser criado em tempo de projeto
                usando o evento **onGetTemplate**.
              2. As strings do formulário também pode ser desenhado usando o evento
                OnAddTemplate.
              3. O evento OnGetTemplate tem prioridade em relação ao evento OnAddTemplate;
         }
         protected function GetTemplate(aNext: PSItem) : PSItem;overload;virtual;abstract;

      {$ENDREGION ' <--- Property onGetTemplate : TGetTemplate '}

      {$REGION ' ---> Property onAddTemplate : TAddTemplate '}
         {: O Atributo **@name** é um ponteiro para o método TonAddTemplate.}
         private _onAddTemplate : TonAddTemplate;

         {A propriedade **@name** permite adicionar linhas a propriedade strings usando o método TUiDmxScroller.Add  }
         Public property onAddTemplate: TonAddTemplate read _onAddTemplate write _onAddTemplate;

         {: O método **@name** Criar um formulário baseado em _Strings.

            - **Objetivo**
              - Criar formulário baseado em recursos tipo maricarai em arquivo.
              - Nome do arquivo: TableName.template

            - **NOTAS**
              - Se _Strings.Count > 0 então gera o template e retorna true;
              - Se _Strings.Count = 0 retorna false.

         }
         public function DoAddTemplate:Boolean;virtual;Abstract;
      {$ENDREGION ' <--- Property onAddTemplate : TAddTemplate '}

      {$REGION --> Propriedade Active}

        {: O atributo **@name** é usado para criar a propriedade active do componente

           - NOTAS
             - O componente só pode estar ativo se o GetTemplate <> nil .
             - O método **CreateFormLCL** só pode ser executado uma vêz.
             - Caso o active esteja **true** e o usuário seta para false o controle
               Owner deve ficar invisível.
        }
        protected var _Active : Boolean;

        {: A procedure **@name** seta a propriedade active  e criar um formulário
           LCL ou HTML dependendo do tipo de aplicação
        }
        protected procedure SetActive(aActive : Boolean);virtual;

        published property Active : Boolean Read _Active Write SetActive;
      {$ENDREGION --> Propriedade Active}

      {$REGION --> Propriedade CurrentField}
          {: O atributo protected **@name** contem os dados da propriedade CurrentField.}
          protected _CurrentField  : pDmxFieldRec;


          {: O atributo **@name** salva o currentefield anterior ao atual.

             - **ATENÇÃO**
               - Necessário caso se deseja fazer alguma crítica com os dados do buffer
                 do corrente campo focado ao pressionar um botão de ação.
          }
          public    CurrentField_old : pDmxFieldRec;

          {: O Método **@name** Set o currenteField com aCurrentField}
          protected Procedure SetCurrentField(aCurrentField : pDmxFieldRec);

          {: A propriedade **@name** contém um ponteiro para o campo selecionado }
          public property CurrentField : pDmxFieldRec  read _CurrentField write SetCurrentField;

          {: A atributo **@name** contém um ponteiro para o campo selecionado
             e que FieldNum seja diferente de zero.
          }
          public protected CurrentField_focused  : pDmxFieldRec;
      {$ENDREGION --> Propriedade CurrentField}

      {: A função **@name** salva a string S no currentField

         - **PARÂMETROS**
           - OkSpc : campo lógico e se **true** salva o campo preenchendo
             com espaço para completar a máscara.
           - S        : String do tipo ShortString com conteúdo do campo.
      }
      public Function PutString(Const OkSpc:Boolean;Const S:tString) : SmallInt;virtual;overload;

      {: O método **@name** salva um string no campo passado por aFieldName.}
      public function PutString(Const aFieldName:tString;S : ShortString):SmallInt;virtual;overload;

      {: O método **@name** retorna um string do campo passado por aFieldName. }
      public function  GetString(const aFieldName: tString):AnsiString;virtual;overload;

      {: A função **@name** retorna a string com o valor do currentField

         - **PARÂMETROS**
           - OkSpc : campo lógico e se **true** retorna o campo preenchendo com espaço para completar a máscara.
      }
      public Function GetString(Const OkSpc:Boolean) : TString;virtual;overload;

      {: A função **@name** retorna a string com o valor do currentField sem preencher com espaço para completar a máscara.}
      public Function GetString : TString;virtual;overload;

      {: A função **@name** salva a string **S** no currentField usando **okspc** = false;

         - **PARÂMETROS**
           - S  : String do tipo ShortString com conteúdo do campo.
      }
      public function PutString(const S : ShortString):SmallInt;virtual;overload;

      {$REGION --> Propriedade AlignmentLabels}
        private _AlignmentLabels : TAlignment;
        private procedure SetAlignmentLabels(aAlignmentLabels : TAlignment);
        {: A propriedade **@name** contém a propriedade taLeftJustify, taRightJustify,
           taCenter indicando que o rótulos dos campos devem ser alinhados a esquerda,
           a direita ou ao centro.

           - **NOTA**
             - Quando todas as letras são maiúsculas e o alinhamento é a direta
               é necessário colocar espaços em branco a direta para compensar o
               tamanho, do contrário o TLabel omite o inicio do label porque o
               texto fica maior que o a largura do label.
        }
        public property AlignmentLabels : TAlignment read _AlignmentLabels write SetAlignmentLabels;
      {$REGION --> Propriedade AlignmentLabels}

      {: O método **@name** receber a máscara do DmxScroller e  retorna a mascara  do componente LCL.

         - **PARÂMETROS**
           - **aTemplate** :
             - *S* = Indica que a posição é do tipo ShortString e só aceita caractere maiúsculo.
               - Exemplo: \SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

             - *s* = Indica que a posição é do tipo ShortString e só aceita caractere maiusculos e minusculos.
               - Exemplo: \ssssssssssssssssssssssssssssssssssssss

             - *s* = Indica que a posição é do tipo ShortString e só aceita caracteres númericos.
               - Exemplo: '\(##) # ####-####'

             - C = Indica que a posição é do tipo AnsiString e só aceita caractere
               maiúsculo.
               - Exemplo: \CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

             - *c* = Indica que a posição é do tipo ansistring e aceita caractere
               maiusculos e minusculos.
               - Exemplo: \cccccccccccccccccccccccccccccccccccccc

             - *0* = Indica que a posição é do tipo ansistring e aceita caracteres númericos.
               - Exemplo: \(00) 0 0000-0000' //85 9 9702 4498

             - *B* = Indica que a posição é do tipo byte o máximo de B que pode ter
               é 3. O valor não pode ser maior que 255.
               - Exemplo: \BBB

             - *J* = Indica que a posição é do tipo shortint o número shotint so pode
               ter número entre -128 to 127
               - Exemplo: \JJJ

             - *W* = Indica que a posição é do tipo SmallWord (2 bytes) e só pode
               ter número entre 0 a 65.535
               - Exemplo: \WWWWW

             - *I* = Indica que a posição é do tipo inteiro longo (4 bytes) e só pode
               ter número entre -4.294.967.295 a  4.294.967.295
               - Exemplo: \IIIII

             - *L* = Indica que a posição é do tipo inteiro longo (4 bytes) e só pode
               ter número entre -4.294.967.295 a  4.294.967.295
               - Exemplo: \LLLLLL

             - *R* = Indica que a posição é do tipo real (8 bytes) e pode
               ter número fracionários.
               - Exemplo: \RRR,RRRR,RR

             - *r* = Indica que a posição é do tipo real positivo (8 bytes) e pode
               ter número fracionários.
               - Exemplo: \rrr,rrr.rr

             - *O* = Indica que a posição é do tipo real (4 bytes) e pode
               ter número fracionários.
               - Exemplo: \OOO,OOO.OO

             - *o* = Indica que a posição é do tipo real positivo (4 bytes) e pode
               ter número fracionários.
               - Exemplo: \ooo,ooo.oo

             - *P*  = Indica que a posição é do tipo real (4 bytes) e pode
               ter número fracionários e armazena. Seu valor é dividido por 100 e
               ao gravar e ao ler é mutiplicado por 100 usado em número percentuais.
               Obs: Pode se negativo.
               - Exemplo: \PPP.PP

             - *p*  = Indica que a posição é do tipo real positivo (4 bytes) e pode
               ter número fracionários e armazena. Seu valor é dividido por 100 e
               ao gravar e ao ler é mutiplicado por 100 usado em número percentuais.
               Obs: Não pode se negativo.
               - Exemplo: \PPP.PP

             - *E*  = Indica que a posição é do tipo extended (10 bytes) e pode
               ter números fracionários.
               - Exemplo: \EEE,EEE,EEE.EE

             - *X* = Indica que a posição é do tipo boolean (1 bytes) e só pode
               ter os números 0 ou 1;
               - Exemplo: \X

           - *Size_TypeFld*
             - Retorno o tipo de dados da mascara;

           - *aLength_Buffer*
             - Retorno o tamanho do tipo de dados da mascara;

           - *aOkMask*
             - Retorna **true** se tiver mascara e **false** caso contrário;

         - *RESULT*
           - Caracter Descrição da mascara da LCL
             - ! Espaços em branco não aparecerão
             - > Todos os caracteres seguintes serão maiúsculos até que apareça o caracter
             - < Todos os caracteres seguintes serão minúsculos até que apareça o caracter
             - \ Indica um caracter literal
             - l (L minusculo) Somente caracter alfabético
             - L Obrigatoriamente um caracter alfabético (A-Z, a-z)
             - a Somente caracter alfanumérico
             - A Obrigatoriamente caractere alfanumérico ( A-Z, a-z, 0-9)
             - 9 Somente caracter numérico
             - 0 Obrigatoriamente caracter numérico
             - c permite um caracter
             - C Obrigatoriamente um caracter
             - # Permite um caracter numérico ou sinal de mais ou de menos, mas não os requer.
             - : Separador de horas, minutos e segundos
             - / Separador de dias, meses e anos
             - NOTAS:
               - A máscara basicamente consiste de três campos, separados por ponto e vírgula.
                 - A primeira parte é a máscara propriamente dita.
                 - A segunda parte determina se os caracteres fixos devem ser ou não salvos com a máscara (ex: /, -, (, ...).
                 - A terceira parte da máscara representa o caracter em branco, podendo ser substituído por outro (ex: _, @, ...).
               - Caracteres especiais utilizados com a máscara:
                 - ! Faz com que a digitação da máscara fique parada no primeiro caracter, fazendo com que os caracteres digitados que se movam. Ex: !;0;_
                 - > Todos os caracteres alfabéticos digitados após este símbolo serão convertidos para maiúsculos. Ex: >aaa;0;_
                 - < Todos os caracteres alfabéticos digitados após este símbolo serão convertidos para minúsculos. Ex: <aaa;0;_
                 - <> Anula o uso dos caracteres > e <. Ex: >aaa<>aaa;0;_
                 - \ Utilizado para marcar determinado caractere não especial como fixo, não podendo sobrescrevê-lo. Ex: !\(999\)000-0000;0;_
                 - L Caracteres alfabéticos (A-Z, a-z.) de preenchimento obrigatório. Ex: LLL;1;_
                 - l (Letra ele minúscula) Caracteres alfabéticos (A-Z, a-z.) de preenchimento opcional. Ex: lll;1;_
                 - A Caracteres alfanuméricos (A-Z, a-z, 0-9) de preenchimento obrigatório. Ex: AAA;1;_
                 - a Caracteres alfanuméricos (A-Z, a-z, 0-9) de preenchimento opcional. Ex: aaa;1;_
                 - C Exige preenchimento obrigatório com qualquer caractere para a posição. Ex: CCC;1;_
                 - c Permite qualquer caractere para a posição de preenchimento opcional. Ex: ccc;1;_
                 - 0 Caracteres numéricos (0-9) de preenchimento obrigatório. Ex: 000;1;_
                 - 9 Caracteres numéricos (0-9) de preenchimento opcional. Ex: 999;1;_
                 - # Caracteres numéricos (0-9) e os sinais de - ou + de preenchimento opcional. Ex: ###;1;_
                 - : Utilizado como separador de horas, minutos e segundos. Ex: !00:00:00;1;_
                 - / Utilizado como separador de dia, mês e ano. Ex: !99/99/9999;1;_
                 - ; Separa os três campos da máscara.
                 - _ Caractere usado normalmente nas posições do campo ainda não preenchidas.

                 - Campom númerico
                   - #####,##;1;_
                   - O 1 Indica para salvar a mascara no resultado.
                   - O caractere _ indica que deve ser digitado 1 caractere.
                   - #####,##;0;_
                     - O 0 Indica para não salvar a máscara no resultado.

         - **EXEMPLO DE FORMATO FLOAT**

           ```pascal
              Const
                NrFormat=9;
                FormatStrings : Array[1..NrFormat] of string = (
                      '',
                      '0',
                      '0.00',
                      '#.##',
                      '#,##0.00',
                      '#,##0.00;(#,##0.00)',
                      '#,##0.00;;Zero',
                      '0.000E+00',
                      '#.###E-0');

                      '999999999,99;0; ';
                      '###,###,###,##0.00';

           ```
      }
      public  Function Get_MaskEdit_LCL(aTemplate : AnsiString;
                                        aSpaceChar :AnsiChar;
                                        out Size_TypeFld,
                                            aLength_Buffer : SmallWord;
                                        out aOkMask : Boolean) : AnsiString;overload;

      {: O método **@name** receber a máscara do Dmx e  retorna a mascara  do componente LCL.

         - **PARÂMETROS**
      }
      public Function Get_MaskEdit_LCL(aTemplate : AnsiString;
                                        aSpaceChar:Ansichar;
                                        //Se o campo tem mascara retorna true e false caso contrário
                                        out aOkMask : Boolean) : AnsiString;overload;

      {: O Método **@name** retorna um valor o parâmetro aValue formatado deacordo
         o parâmetro mask com formato da IDL LCL.

         - NOTA:
           - aDirecao
             - True : aValue será formatado da esquerda para direita;
             - false: aValue será formatado da direita para esquerda;
      }
      public function FormatMaskEdit_LCL( aValue, Mask: string;aDirecao:Boolean): string;

      {$REGION ' ---> Property BufDataset : TBufDataset '}
        protected var _BufDataset_created:Boolean;
        private var _BufDataset : TMiBufDataset;

        {: O método **@name** destrói _BufDataSet se _BufDataSet.owner=Self ao
           desativar o formulário           }
        private Procedure SetBufDataset(aBufDataset : TMiBufDataset);

        {: O método **@name** retorna DataSource.DataSet caso o mesmo
           seja diferente de nil ou cria _BufDataset com os dados do formulário
           caso DataSource.DataSet = nil;
        }
        private function GetBufDataset : TMiBufDataset;

        {: A propriedade **@name** é usada com objetivo de integração dos dados
           do formulário TDmxScroller e os controle que forem baseados em TDataSet.
        }
        public property BufDataset : TMiBufDataset read GetBufDataset write SetBufDataset;
      {$ENDREGION ' ---> Property BufDataset : TBufDataset '}

      {$REGION ' ---> Property DataSource : TDataSource '}
         protected _DataSource : TDataSource;
         Protected function GetDataSource : TDataSource;
         Protected Procedure SetDataSource(aDataSource : TDataSource);

         {: A propriedade **@name** permite que controles da **LCL** (Lazarus Componentes Library)
            possam usar os dados do componente **TDmxScroller**.

            - **NOTA**
              - Essa integração permite que **TDmxScroller** utilize todos os componentes de banco
                de dados do Free Pascal.
         }
         public property DataSource : TDataSource Read GetDataSource   Write  SetDataSource;
      {$ENDREGION ' <--- Property DataSource : TDataSource '}

      {: O atributo **@name** retorna true se o buffer apontado por PAnt for igual ao buffer apontado por PAtu. }
      public Function IfEqual(Const Ofset_Inicial:Word;Const PAnt,PAtu : Pointer; Const Len:Word):Boolean;

      {: O método **@name** retorna true se o registro atual for diferente do registro anterior}
      public function RecordAltered : Boolean ;

      {: A classe método **@name** é usado para adicionar a chamada de um procedimento quando a tecla F7
         é pressionada;
      }
      public class function CreateExecAction(Const aFieldName:AnsiString;const aExecAction: AnsiString) : AnsiString;

      public procedure add(aTemplate:AnsiString); overload;
//      public procedure add(aTemplate:Array of char); overload;

      {$REGION 'Construção Propriedade Locked'}
        private public _Locked   : Boolean;
        protected Procedure SetLocked(aLocked:Boolean);Virtual;

        {: A propriedade **@name** deve ser redefinida na interface filha desta
           classe para travar o formulário se aLocked = true e destravar se
           aLocked = false;
        }
        public property Locked : Boolean read _Locked write SetLocked;
      {$ENDREGION 'Construção Propriedade Locked'}

      {: O método **@name** atualiza o buffer com o array aArgs

         - Exemplo de como alterar o primeiro registro com a sequencia [josé Carlos, 15]:

           ```pascal

             if FirstRec Then
             begin
               edit;
               SetArgs(['José Carlos',15]);
               UpdateRec;
             end;
           ```
      }
      public Procedure SetArgs(aArgs: array of const);virtual;

      {$REGION 'Propety JSonObject'}
        Protected Procedure Set_JSONObject(aJSONObject: TJSONObject);virtual;
        Protected function Get_JSONObject: TJSONObject;Virtual;
        Public property JSONObject: TJSONObject read Get_JSONObject write Set_JSONObject;
      {$ENDREGION 'Propety JSonObject'}

      {$REGION ' Implementação Método de atualização no banco de dados'}

        {$REGION '--> propriedade DoOnNewRecord_FillChar'}
            Private _DoOnNewRecord_FillChar : Boolean;
            Private Procedure  SetDoOnNewRecord_FillChar(Const a_DoOnNewRecord_FillChar : Boolean);
            public Property DoOnNewRecord_FillChar : Boolean Read _DoOnNewRecord_FillChar Write SetDoOnNewRecord_FillChar default True ;
        {$ENDREGION '--> propriedade DoOnNewRecord_FillChar'}

        {$REGION '--> propriedade OnNewRecord'}

              Private var _OnNewRecord  : TOnNewRecord;

              {: A propriedade **@name** é executada em DoOnNewRecord se a mesma for assinalada.}
              Public property OnNewRecord  : TOnNewRecord read _OnNewRecord  Write _OnNewRecord;

         {$ENDREGION '--> propriedade OnNewRecord'}

         {:O método **@name** deve ser implamentado na unit que implementar o
            desenho do formulário
         }
         protected Procedure Select_First_Field_Normal; virtual;abstract;

         {:O método **@name** é usado para inicializa os parâmetros de um novo
           registro.

           - **Descrição**
             - O método `DoOnNewRecord` é responsável por iniciar a criação de um
               novo registro no dataset associado ao componente. Ele executa uma
               série de operações para configurar o estado da aplicação como
               "appending", preencher campos com valores padrão e atualizar o buffer
               de dados.

           - **Parâmetros Locais**
             - **WState_Mb_St_Focused** (`Boolean`): Guarda o estado anterior do foco
               no componente para restaurá-lo após a inserção.
             - **wOnCalcRecordEnable** (`Boolean`): Armazena o estado da habilitação
               de cálculos de registros, desativado temporariamente.
             - **p** (`TDataSetNotifyEvent`): Ponteiro para o evento `OnNewRecord`
               do dataset, se atribuído.
             - **wCurrentField** (`PDmxFieldRec`): Campo atualmente em foco.
             - **i** (`Integer`): Usado para iterar sobre os campos do dataset.
             - **s** (`String`): Usado para armazenar temporariamente valores padrão
               dos campos.

           - **Fluxo de Execução**
             1. Verifica se o dataset está ativo com `isDataSetActive`.
             2. Se ativo:
                - Marca o estado como "Appending" para indicar a inserção de um
                  novo registro.
                - Define valores padrão para os campos do novo registro.
                - Notifica os manipuladores de evento, se existentes.
                - Atualiza o buffer de dados e os comandos associados ao dataset.
             3. Após a inserção, restaura o estado anterior, como foco e habilitação
                de cálculos.

           - **Exceções**
             - **Exception**:
               - Lança uma exceção se houver algum erro durante o
                 processo de inserção de um novo registro.

           - **Ver Também**
             - `OnNewRecord`: Evento chamado ao criar um novo registro.
         }
         public Procedure DoOnNewRecord;overload;Virtual;

         {: O método **@name** inicia uma transação se puder.

            - **RESULT**
              - True
                - Se a transação atual for false;
              - false
                - Se a transação atual for true;

              - **Objetivo:
                - Permitir que após o processamento, só executar commit ou rollback
                  se StartTransaction tenha retornado true;

              - EXEMPLO DE USO

                ```pascal

                   Function AddRec:Boolean;
                   Var
                     Finalize : boolean;
                   begin
                     try /Exepet

                       Finalize := StartTransaction;

                       AddRec;

                       if Finalize
                       then Commit

                     Except
                       On E : Exception do
                       begin
                         if finalize
                         then Rollback;

                         Raise TException.Create(Self,$I %CURRENTROUTINE%,E.Message);
                       end;
                   end;

                ```

         }
         protected function StartTransaction:Boolean;override; Overload;

         {: O método **@name** confirme a transação no banco de dados}
         protected function COMMIT:Boolean;override;Overload;

         //private var Ok_Rollback : Boolean;
         {: O método **@name** anula a transação do banco de dados}

         protected procedure Rollback(afinalize: Boolean; aMsg: AnsiString; aWorkingData:Pointer);overload;

         {$REGION ' ---> Property CurrentBookmark : TBookMark '}
             private _CurrentBookmark_old : TBookMark;
             private _CurrentBookmark     : TBookMark;

             {: O método **@name** é criado para posicionar o registro em
                TDataSource.Datase apontado por aCurrentBookmark.}
             private procedure SetCurrentBookmark(aCurrentBookmark : TBookMark);

             {: A propriedade **@name** retorna o registro corrente de TDataSource.Datase.

                - NOTA
                  - Faz a mesma função de gerRec;
             }
             public property CurrentBookmark : TBookMark Read _CurrentBookmark   Write  SetCurrentBookmark;
          {$ENDREGION ' <--- Property CurrentBookmark : TBookMark '}

         {: O método **@name** retorna true se ativo e existe datasource com dataset ativo. }
         public function isDataSetActive:Boolean;

         public function GetDataSet:TDataSet;
         public function GetDataSet_Status:String;

         {: O método **@name** Executa SetState para hablitar e desabilita comandos
            para estar sincronizado com getdataset
         }
         public Procedure UpdateState;

         {: O método **@name** comunica-se com o DataSource.DataSet.Append}
         protected Procedure DataSet_Append;

         {: O método **@name** comunica-se com o DataSource.DataSet.post}
         protected Procedure DataSet_post;

         {: O método **@name** comunica-se com o DataSource.DataSet.delete}
         Protected Procedure DataSet_Delete;

         {: O método **@name** comunica-se com o DataSource.DataSet.edit}
         Protected Procedure DataSet_Edit;

         {: O método **@name** localiza o registro baseada nos valores (KeyValues)
            dos campos passados por KeyFields.

            - **RETORNA**
              - True : Se localizou;
              - False : Não localizou.
         }
         public function Locate(const KeyFields: string; const KeyValues: Variant; Options: TLocateOptions) : boolean; virtual;overload;

         {: O método **@name** executa o método TMi_rtl.Locate(const aField:pDmxFieldRec)
            onde aField é o campo corrente do formulário em edição.

            - **RETORNA**
              - True : Se localizou;
              - False : Não localizou.
         }
         Public function Locate(): TMi_MsgBox.TModalResult;Virtual; Overload;Abstract;

         {: O método **@name** comunica-se com o DataSource.DataSet.BookMarkValid}
         Protected Function DataSet_BookmarkValid(aBookMark:TBookMark):Boolean;

         {: O método **@name** comunica-se com o DataSource.DataSet.Cancel}
         Protected procedure DataSet_Cancel;

         {: O método **@name** Exeuta DataSource.DataSet.Refresh porém antes desativa e ativa.}
         Protected Procedure DataSet_Refresh;

         {: O método **@name** comunica-se com o DataSource.DataSet.ApplyUpdates}
         Protected procedure DataSet_ApplyUpdates;

         {: O método **@name** colocará o conjunto de dados no modo de edição:

            - NOTAS:
              - O conteúdo do registro atual poderá então ser alterado.
              - Esta ação irá chamar os eventos TDataset.BeforeEdit e TDataset.AfterEdit.
              - Se o conjunto de dados já estiver em modo de inserção ou edição, nada
                acontecerá (os eventos também não serão acionados).
              - Se o conjunto de dados estiver vazio, esta ação executará TDataset.Append .
         }
         public procedure Edit;

         {$REGION ' ---> Property Bof: Boolean '}
//           Private var _Bof : Boolean;

           {: O método **@name** retorna  DataSource.dataSet.bof

              - **RETORNA**
                - True: se posicionado no primeiro registro;
                - False: Não está no primeiro registro.
           }
//           procedure SetBof(AValue: Boolean);
           protected Function GetBof: Boolean;overload;virtual;
           public Property Bof: Boolean read GetBof;// write SetBof;
         {$ENDREGION ' ---> Property Bof: Boolean '}

         {$REGION ' ---> Property Eof: Boolean '}
//            Private Var _Eof :Boolean;

            {: O método **@name** retorna  DataSource.dataSet.eof

               - **RETORNA**
                 - True: se posicionado no último registro;
                 - False: Não está no último registro.
            }
//            procedure SetEof(AValue: Boolean);
            Protected Function GetEof: Boolean;overload;virtual;
            public Property Eof: Boolean read GetEof;// Write SetEof;
         {$ENDREGION ' ---> Property Eof: Boolean '}

         {: O método **@name** posiciona o cursor no primeiro registro de DataSource.dataSet

             - **RETORNA**
               - True: se posicionado no primeiro registro;
               - False: Chamada ao método FirstRec estando no primeiro registro.
          }
         Public Function FirstRec: Boolean;overload;virtual;

         {:O método **@name** é responsável por mover o cursor do dataset para o
           próximo registro, caso o dataset esteja ativo e não tenha alcançado o
           final dos registros (`EOF`). Se houver um próximo registro, ele retorna
           `True` e chama os eventos correspondentes para atualizar o estado da
           interface. Caso contrário, retorna `False` e mantém o estado do dataset.

           - **Parâmetros Locais**
             - **`ds: TDataSet`**: Objeto do tipo `TDataSet` que faz referência
                ao dataset utilizado no método.

           - **Fluxo de Execução**
             1. **Verificação de Atividade do Dataset**:
                - O método primeiro verifica se o dataset está ativo usando
                  `isDataSetActive`. Se não estiver ativo, o método retorna `False`.

             2. **Manipulação de Registros**:
                - Se o dataset está ativo, o método obtém o dataset com `GetDataSet`,
                  chama o evento `DoOnExit` e tenta mover para o próximo registro
                  com `ds.Next`.
                - Se não for o final do dataset (`EOF`), ele chama `GetRec` para
                  atualizar os dados com o registro atual usando o `Bookmark` do
                  dataset.
               - Se o `EOF` for alcançado, ele retorna `False`.

             3. **Tratamento de Exceções**:
                - Se ocorrer qualquer exceção durante a movimentação entre os registros,
                  uma mensagem de erro é exibida com `ShowMessage(E.Message)`, e o
                  método retorna `False`.

             4. **Eventos Finais**:
                - Após o processamento, o evento `DoOnEnter` é chamado. Caso o
                  `EOF` seja atingido, o método chama `ds.Last` para garantir
                  que o estado final do dataset seja correto, já que o evento
                  `DoOnEnter` pode alterar o ponteiro `EOF`.
                - Finalmente, o método chama `UpdateCommands` para atualizar os
                  comandos da interface.

             - **Exceções**
               - O método captura exceções do tipo `Exception`, exibindo a mensagem
                 de erro ao usuário com `ShowMessage`.

           - **Retorno**
             - **`True`**: Se houver sucesso ao mover para o próximo registro e atualizar o estado da interface.
             - **`False`**: Se o dataset estiver no final (`EOF`), inativo ou ocorrer alguma exceção.

           - **Ver Também**
             - `DoOnExit`
             - `DoOnEnter`
             - `GetRec`
             - `UpdateCommands`
         }
         Public Function  NextRec: Boolean;overload;virtual;

         {: O método **@name** posiciona o cursor no registro anteror de DataSource.dataSet

            - **RETORNA**
              - True se posicionau no registro anterior;
              - False se atingir o bof (inicio do arquivo)
         }
         Public Function PrevRec: Boolean;overload;virtual;

         {: O método **@name** posiciona o cursor no último registro do DataSource.dataSet

            - **RETORNA**
              - True: se posicionado no último registro;
              - False: Chamada ao método LastRec estando no último registro.
         }
         Public Function LastRec: Boolean;overload;virtual;

         {: O Método **@name** deve apagar o buffer e coloca a tabela no modo
            Browser
         }
         Public Procedure Cancel;

         {: O método **@name** posiciona ler o registro atual do DataSource.dataSet}
         protected procedure RefreshInternal;VIRTUAL;

         public procedure Refresh;VIRTUAL;

  //         public Function DoAddRec:Boolean;virtual;//abstract;

         {$Region onBeforeInsert}
            Private _onBeforeInsert  :TOnBeforeInsert;
            Public Property onBeforeInsert:TOnBeforeInsert  Read _OnBeforeInsert Write _OnBeforeInsert;
            Protected Function DoBeforeInsert:Boolean; Virtual;//Chamdo na inclusao depois de SetTransaction
         {$EndRegion onBeforeInsert}

         {$Region onAfterInsert}
            Private _onAfterInsert  :TonAfterInsert;
            Public Property onAfterInsert:TonAfterInsert  Read _onAfterInsert Write _onAfterInsert;
            Protected Function DoAfterInsert:Boolean; Virtual;//Chamdo na inclusao depois de SetTransaction
         {$EndRegion onBeforeInsert}

         {$Region onBeforeUpdate}
            Private _onBeforeUpdate  :TOnBeforeUpdate;
            Public Property onBeforeUpdate:TOnBeforeUpdate  Read _OnBeforeUpdate Write _OnBeforeUpdate;
            Protected Function DoBeforeUpdate:Boolean; Virtual;//Chamdo na inclusao depois de SetTransaction
         {$EndRegion onBeforeUpdate}

         {$Region onAfterUpdate}
            Private _onAfterUpdate  :TonAfterUpdate;
            Public Property onAfterUpdate:TonAfterUpdate  Read _onAfterUpdate Write _onAfterUpdate;
            Protected Function DoAfterUpdate:Boolean; Virtual;//Chamdo na inclusao depois de SetTransaction
         {$EndRegion onBeforeUpdate}

         {$Region onBeforeDelete}
            Private _onBeforeDelete  :TOnBeforeDelete;
            Public Property onBeforeDelete:TOnBeforeDelete  Read _OnBeforeDelete Write _OnBeforeDelete;
            Protected Function DoBeforeDelete:Boolean; Virtual;//Chamdo na inclusao depois de SetTransaction
         {$EndRegion onBeforeDelete}

         {$Region onAfterDelete}
            Private _onAfterDelete  :TonAfterDelete;
            Public Property onAfterDelete:TonAfterDelete  Read _onAfterDelete Write _onAfterDelete;
            Protected Function DoAfterDelete:Boolean; Virtual;//Chamdo na inclusao depois de SetTransaction
         {$EndRegion onAfterDelete}

         {: O método **@name** entra e sai em todos os campos para que os mesmos
            executem seus eventos assinalados e é executado em DoCalcFields sem parâmetros.

            - **NOTA**
              - O Buffer deve ser WorkingData ou WorkingDataold.
         }
         Protected Procedure DoCalcFields(aWorkingData : Pointer) ;overload; Virtual;//Chamdo ao entrar no registro e ao sai do do registro

         {$Region OnCalcFields}
            Private _OnCalcFields  :TOnCalcFields;
            Public Property OnCalcFields:TOnCalcFields  Read _OnCalcFields Write _OnCalcFields;
            Protected Procedure DoCalcFields;overload; Virtual;//Chamdo ao entrar no registro e ao sai do do registro
         {$EndRegion onCalcFields}

         {$Region OnChangeField}
            Private _OnChangeField  :TOnChangeField;
            Public Property OnChangeField:TOnChangeField  Read _OnChangeField Write _OnChangeField;
            Public Procedure DoChangeField(aField: pDmxFieldRec); Virtual;//Chamdo ao entrar no registro e ao sai do doregistro
         {$EndRegion onChangeField}

         {: O método **@name** é usado em AddRec e PutRec para o caso de exceção retornar o valor anterior do registro}
//         private wJSONObject: TJSONObject;

         {: O método **@name** adiciona o buffer DataSource.dataSet n arquivo.

            - **RETORNA**
              - True: Se sucesso;
              - False: Se fracasso.
         }
         Public Function AddRec:Boolean ;Virtual;

         {: O método **@name** ler do arquivo o registro apontado pelo buffer DataSource.dataSet.
            - **RETORNA**
              - True: Se sucesso;
              - False: Se fracasso.
         }
         Public Function GetRec(aBookmark : TBookMark):Boolean ;Virtual;

         {: O método **@name** exclui o registro apontado pelo buffer DataSource.dataSet no arquivo.

            - **RETORNA**
              - True: Se sucesso;
              - False: Se fracasso.
         }
         Public Function DeleteRec:Boolean ;Virtual;

         {:O método **@name** retorna uma string com os nomes dos campos separados
            por virculas e em Values retorna os valores do campos;

            - EXEMPLO
              - Campo chaves: 'data;id'
         }
         public function getFieldsKeys(out Values:Variant):AnsiString;overload;
         {:O método **@name** retorna um `TJSONObject` contendo os nomes dos
           campos chave e seus respectivos valores do `DataSet`. Caso o `DataSet`
           esteja vazio ou inativo, retorna um objeto JSON vazio.

           - **Descrição**
             - O método `getFieldsKeysAsJson` percorre os campos do `DataSet` e,
               para cada campo marcado como chave (`pfInKey`), adiciona o nome do
               campo e o seu valor ao objeto JSON retornado. O valor é obtido
               através da propriedade `AsVariant`, que garante compatibilidade com
               diferentes tipos de dados.

           - **Parâmetros Locais**
             - `F`: `TField` - Representa o campo atual do `DataSet` durante a iteração.
             - `i`: `Integer` - Índice usado para iterar sobre os campos do `DataSet`.
             - `ds`: `TDataSet` - Conjunto de dados do qual os campos e valores serão extraídos.
             - `Result`: `TJSONObject` - Objeto JSON que armazena os pares campo-valor.

           - **Fluxo de Execução**
             1. O método cria uma instância de `TJSONObject`.
             2. Se o `DataSet` estiver vazio ou inativo, o método retorna o objeto JSON vazio.
             3. Se o `DataSet` estiver ativo:
                - Itera pelos campos do `DataSet`.
                - Para cada campo marcado com `pfInKey`, verifica se o valor não é nulo.
                - Adiciona o campo e seu valor ao `TJSONObject`.
             4. Retorna o objeto JSON preenchido.

           - **Exceções**
            - **Memória**:
              - Lembre-se de liberar o objeto JSON após o uso para evitar vazamento
                de memória.

           - **Exemplo de Uso**

              ```pascal
                   var
                     jsonResult: TJSONObject;
                 begin
                   jsonResult := getFieldsKeysAsJson;
                   try
                     ShowMessage(jsonResult.AsJSON);  // Exibe o JSON gerado como string.
                   finally
                     jsonResult.Free;  // Libera o objeto JSON da memória.
                   end;
                 end;
              ```
         }
         public function getFieldsKeysAsJson: TJSONObject;

         {: O método **@name** grava o buffer no registro apontado CuurentBookmark
            do DataSource.dataSet no arquivo.

            - **RETORNA**
              - True: Se sucesso;
              - False: Se fracasso.
         }
         Public Function PutRec:Boolean;Virtual;

         {: O método **@name** grava o buffer no registro apontado CuurentBookmark
            do DataSource.dataSet no arquivo.

            - NOTAS
              - Se appending = true executar o método addRec;
              - Se Appening = false  executa o método PutRec;

            - **RETORNA**
              - True: Se sucesso;
              - False: Se fracasso.
         }
         Public Function UpdateRec: Boolean; Virtual;

         {: O método **@name** retorna a número da sequência do próximo registro.

            - **PARAMETROS**
              - SequenceName
                - O nome da sequência no banco de dados;
              - IncrementBy
                - Número que deve ser acrescentado na sequência
         }
         public function GetNextValue(const SequenceName: string; IncrementBy: integer): Int64;

         {: O método **@name** retorna o maximo do campo ID da tabela dm_table

            - EXMPLO DE USO:

               ´´´pascal
                   procedure TForm_Operadores.Button1Click(Sender: TObject);
                     Var
                       Id : string;
                   begin
                     id := Operadores.MaxPKey('dm_table','id');
                     Tmi_rtl.ShowMessage('Próxímo número = '+id+1);
                   end;

                ```
            - REFERÊNCIA:

              - ATENÇÂO:
                - [Geração automática de instruções SQL de atualização](https://www.freepascal.org/docs-html/fcl/sqldb/updatesqls.html)
                - [aprenda-programar-funcao-para-retornar](https://infocotidiano.com.br/2016/09/aprenda-programar-funcao-para-retornar.html)
                - [postgresql-max-function](https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-max-function/)

         }
         public function MaxPKey(aTabela, aID: String): LongInt;overload;

         {: O método **@name** retorna o número de registros da coluna 'ID'
         }
         public Function MaxPKey: LongInt;Virtual;overload;

         {: O método **@name** retorna o valor máximo da coluna 'ID' se a tabela
            for TSQLQuery e DataSet.RecNo caso contrário.
         }
         public function GetRecNo: LongInt; virtual;

      {$ENDREGION ' Implementação Método de atualização no banco de dados'}



       {: O método **@anme** deve ser anulado para destruir as referências
         a classe TDmxScroller_Form se **_DmxScroller_Form** for <> nil }
       //public procedure destroyRef_DmxScroller_Form;Virtual;

       {$REGION ' Implementação dos comandos EnableControls e DisableControls'}
         {: O método **@name** habilitas os controles visuais do dataset}
         public procedure EnableControls;

         {: O método **@name** desabilita os controles visuais do dataset}
         public procedure DisableControls;

         {: O método **@name** retorna true se os contoles estã habilitados
            e retorna false se não tiver habilitado
         }
         public function  ControlsDisabled: Boolean;

       {$ENDREGION ' Implementação dos comandos EnableControls e DisableControls'}


       {$REGION --> ShouldSaveTemplate}
         protected var _ShouldSaveTemplate : Boolean;

         {: A propriedade **@name** é usada método **CreateStruct** com objetivo
            de salvar o **template_org**.

            - **NOTAS**
              - Condição para que o método **SaveTemplate** seja executado:
                - A propriedade **@name** deve ser igua **true**;
                - O Nome da propriedade **TableName** deve ser diferente de vazio;
         }
         public property ShouldSaveTemplate : Boolean Read _ShouldSaveTemplate Write _ShouldSaveTemplate;
       {$ENDREGION --> Propriedade SaveTemplate}

       {: O método **@name** salva o parâmetro **aTemplate_org** no arquivo **aFileName**
          se o arquivo **aFileName** não existir.

          - **PARÂMETROS**
            - aFileName
              - Nome do arquivo;
            - aTemplate_org
              - String com o template

          - **NOTA**
            - o Método **CreateStruct** reconhece somente os rótulos e os campos
              da mesma linha. É necessário ser redefinido em mi_rtl_ui_mxscroller_form
              para salve todas as linhas.
       }
       function SaveTemplate(aFileName:AnsiString;adataformat:AnsiString):Boolean;Virtual;

       {$REGION ' ---> Propriedade MiDataPacketFormat_Default'}
         private _MiDataPacketFormat_Default :TMiDataPacketFormat;
         Procedure SetTMiDataPacketFormat(aMiDataPacketFormat:TMiDataPacketFormat);
         {: O propriedade **@name** usado para dar opção do usuário informar o tipo
            de arquivo a ser salvo por BufDataSet.
         }
         Published property MiDataPacketFormat_Default:TMiDataPacketFormat read _MiDataPacketFormat_Default
                                                                           write SetTMiDataPacketFormat;
       {$ENDREGION ' ---> Propriedade MiDataPacketFormat_Default'}

       {$REGION ' ---> Propriedade Modified '}
         private function GetModified: Boolean;
         {: O propriedade **@name** se retorna **true** indica que pelo menos um
            campo foi alterado no dataset.
         }
         Public property Modified :Boolean read GetModified ;
       {$ENDREGION ' ---> Propriedade Modified '}

       {$REGION ' ---> Propriedade CanModify '}
         Private function GetCanModify: Boolean;
         {: O propriedade **@name** se retorna **true** indica que pelo menos um
            campo foi alterado no dataset.
         }
         Public property CanModify :Boolean read GetCanModify ;
       {$ENDREGION ' ---> Propriedade CanModify '}

       {: O método **@name** procura todos os campos fldRadioGroup e atualiza o campo
          AliasList  a alias.
       }
       procedure UpdateDataField_AliasList;
    end;






  function Message(Receiver: TObjectsMethods; What, Command: Word;InfoPtr: Pointer): Pointer;



implementation
    {%CLASSGROUP 'System.Classes.TPersistent'}

    var
      valuekey : string = '';    //Usado só para teste

    {: O tipo **@name** usado no interpretador de Template para identificar um
       item do cluster}
    type TClusterTemp = Record
                           fnum    :  byte;//:< número do bit
                           value   :  byte;//:< Valor do bit

                                                 //   0123456789012345
                           ofs     :  SmallWord; //:< 0000000000000000 16 bits
                        end;
    {: O tipo **@name** usado pelo interpretador de Template para identificar o
       campo cluster}
    type TClusterTemps =  array [0..127] of TClusterTemp;
    var ClusterTemps : TClusterTemps;

    function Message(Receiver: TObjectsMethods; What, Command: Word;   InfoPtr: Pointer): Pointer;
      var
        Event: TEvent;
    begin
      if Receiver <> nil
      then begin
              Event.What    := What;
              Event.Command := Command;
              Event.InfoPtr := InfoPtr;
              Event.Module  := 0;
              Event.StrModule := '';
              event.StrCommand := '';

              Receiver.HandleEvent(Event);

              if Event.What = TObjectsMethods.evNothing
              then Result := Event.InfoPtr
              Else Result := nil;
           end
      else Result := nil;
    end;

    { TFldEnum_Lookup }

    procedure TFldEnum_Lookup.SeTDmxFieldRec(aDmxFieldRec : pDmxFieldRec);
    begin
      if _DmxFieldRec<>nil
      then begin
             FreeAndNil(DataSource);
             FreeAndNil(BufDataSet);
           end;
      _DmxFieldRec := aDmxFieldRec;
    end;

    function TFldEnum_Lookup.GetBufDataSet:TBufDataSet;
      var
        DS : TBufDataSet;

      Procedure AddRecs;
        var
          I : Longint;
          p : PSItem;
      begin

        with DmxFieldRec^ do
          If TypeCode = TUiDmxScroller.fldENUM
          Then Begin
                  p:= PSItem(Template);
               End
          else raise TException.Create(self,{$I %CURRENTROUTINE%},'O campo precisa ser enumerado.');

        i := 0;
        While (p <> nil) do
        begin
          If (p^.Value <> nil)
          Then with DS do
               begin
                 Append;
                 FieldByName(KeyField).AsLongint:= i;
                 FieldByName(ListField).AsString:= p^.Value^;
                 Post;
               end;
          p := p^.Next;
          inc(i);
        end;
      end;

    begin
      //Criar o DataSet
      DS := TBufDataSet.Create(Self);
      with DS do
      begin
        FieldDefs.Add(KeyField,ftLargeint,sizeof(DmxFieldRec.FieldSize));
        FieldDefs.Add(ListField,ftString,DmxFieldRec.TrueLen);
        CreateDataset;
        AddRecs;
      end;
      result := ds;
   end;

   constructor TFldEnum_Lookup.create(aDmxFieldRec: pDmxFieldRec);
    begin
      inherited create(nil);
      DmxFieldRec := aDmxFieldRec;
      if DmxFieldRec <> nil
      Then Begin
             KeyField   := aDmxFieldRec^.KeyField;
             ListField  := aDmxFieldRec^.ListField;
             DataSource  := DmxFieldRec.DataSource;
             if (DataSource = nil) and (KeyField<>'') and (ListField<>'')
             then begin
                    DataSource := TDataSource.Create(Self);
                    DataSource.DataSet := GetBufDataSet;
                  end;
           end;
    end;

    destructor TFldEnum_Lookup.destroy;
    begin
      FreeAndNil(BufDataSet);
      FreeAndNil(DataSource);
      inherited destroy;
    end;

//    uses  mi_ui_scrollbox_LCL;

    { TUiDmxScroller_Atributos }


  //======================================================
  {$REGION '---> TDmxFieldRec' }

    function TDmxFieldRec.Mask: TDates.TMask;
      var
        ws:string;
    begin
      if (length(Template_org)>2) and (TypeCode in [TConsts.FldDateTime])
      then begin
             ws := Copy(Template_org,2,Length(Template_org)-1);
             if ws<>''
             Then result := TDates.MaskDateTime_to_Mask(ws)
             else Result := TDates.TMask.Mask_Invalid ;
           end
      else Result := TDates.TMask.Mask_Invalid ;
    end;

    procedure TDmxFieldRec.SetFieldName(aFieldName: AnsiString);
    begin
      with TUiDmxScroller do
      _FieldName :=  Lowercase(GetNameValid(delspace(aFieldName)));
      if Alias = ''
      Then Alias := aFieldName;
    end;

    procedure TDmxFieldRec.SetOwner(a_owner: TUiDmxScroller);
    begin
      if Assigned(a_owner)
      Then _owner_UiDmxScroller := a_owner
      else _owner_UiDmxScroller := nil;
    end;

    function TDmxFieldRec.GetOwner: TUiDmxScroller;
    begin
      result := owner_UiDmxScroller;
    end;

    function TDmxFieldRec.GetFieldAltered: Boolean;
      var
        wCurrentField : pDmxFieldRec;
    Begin
      if Not _FieldAltered
      then begin
             if (owner_UiDmxScroller<>nil) and (owner_UiDmxScroller.WorkingDataOld<>nil)
             Then begin
                    try
                      wCurrentField := owner_UiDmxScroller.CurrentField;
                      owner_UiDmxScroller.SetCurrentField(RSelf);
                      result := GetAsString <> GetAsStringFromBuffer(owner_UiDmxScroller.WorkingDataOld)
                    Finally
                      owner_UiDmxScroller.SetCurrentField(wCurrentField);
                    End;
                  end
             else Result := False;
           End
      else Result := _FieldAltered;
    End;

    procedure TDmxFieldRec.SetOkSpc(aOkSpc: Boolean);
    begin
      _OkSpcAnt := _OkSpc;
      _OkSpc := aOkSpc;
    end;

    function TDmxFieldRec.getOkMask: Boolean;
    begin
      Result := _okMask;
    end;

    procedure TDmxFieldRec.SetokMask(AValue: Boolean);
    begin
      if _OkMask<>AValue
      then _okMask:= AValue;
    end;

    //function TDmxFieldRec.StrNumberValid(S: AnsiString): AnsiString;
    //begin
    //  With owner_UiDmxScroller do
    //  begin
    //    Result  := DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
    //    if (pos(showDecimalSeparator  ,Result)<>0) and (showDecimalSeparator <>DecimalSeparator )
    //    then begin
    //           Result := Change_AnsiChar(s,showDecimalSeparator ,DecimalSeparator );
    //         end;
    //  end;
    //end;

          //function TDmxFieldRec.StrNumberValid(S: AnsiString): AnsiString;
          //begin
          //  With owner_UiDmxScroller do
          //  begin
          //    Result  := DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
          //    //if (pos(showDecimalSeparator  ,Result)<>0) and (showDecimalSeparator <>DecimalSeparator )
          //    //then begin
          //    //       Result := Change_AnsiChar(s,showDecimalSeparator ,DecimalSeparator );
          //    //     end;
          //  end;
          //end;

    function TDmxFieldRec.RemoveMaskNumber(S: AnsiString): AnsiString;
    begin
      If Assigned(owner_UiDmxScroller)
      Then begin
              if IsNumber
              then begin
                     result := trim(s);
                     //Excluir máscara porque Text não aceita números formatados
                     result := owner_UiDmxScroller.DeleteMask(S,['0'..'9','-','+',owner_UiDmxScroller.showDecimalSeparator ]);
                     if pos(owner_UiDmxScroller.showDecimalSeparator  ,result)<>0
                     then begin
                            result := owner_UiDmxScroller.Change_AnsiChar(result,owner_UiDmxScroller.showDecimalSeparator ,DefaultFormatSettings.DecimalSeparator );
                          end;
                   end
              else Raise TException.Create(TStrError.ErrorMessage5('mi.rtl',
                                                                   'mi_rtl_ui_DmxScrooler',
                                                                   'TDmxFieldRec',
                                                                   {$I %CURRENTROUTINE%},
                                                                   'Chamada inválida ao método.'));
           end
      else Raise TException.Create(TStrError.ErrorMessage5('mi.rtl',
                                                           'mi_rtl_ui_DmxScrooler',
                                                           {$I %CURRENTROUTINE%},
                                                           'RemoveMaskNumber','Chamada inválida ao método.'));
    end;

    function TDmxFieldRec.RemoveMask(S: AnsiString): AnsiString;
      //var
      //  s_mask: Ansistring;
      //  OkMask_temp :Boolean;
    begin
      If Assigned(owner_UiDmxScroller)
      Then begin
             if IsNumber
             then begin
                    result := RemoveMaskNumber(s)
                  end
                  else if IsData
                       then begin
                              result := owner_UiDmxScroller.DeleteMask(S,['0'..'9']);
                              //while Pos(' ',s) <> 0
                              //do DELETE(s,Pos(' ',s),1);
                              //
                              //while Pos('/',s) <> 0
                              //do DELETE(s,Pos('/',s),1);
                              //
                              //while Pos(':',s) <> 0
                              //do DELETE(s,Pos(':',s),1);
                              //
                              //while Pos('-',s) <> 0
                              //do DELETE(s,Pos(':',s),1);
                              //Result := s;
                            end
                       else begin
                              if IsNumberString
                              Then result := owner_UiDmxScroller.DeleteMask(S,Template_org)
                              else result := s;
                            end;
           end
      else Raise TException.Create(TStrError.ErrorMessage5('mi.rtl',
                                                           'mi_rtl_ui_DmxScrooler',
                                                           'TDmxFieldRec',
                                                           {$I %CURRENTROUTINE%},
                                                           'Chamada inválida ao método.'));
    end;

    function TDmxFieldRec.AddMask(S: AnsiString; DisplayText: Boolean  ): Ansistring;
      var
        s_mask: Ansistring;
        OkMask_temp :Boolean;
    begin
      If Assigned(owner_UiDmxScroller)
      Then begin
             if DisplayText
             then begin
                    if Not IsData
                    Then begin
                           if IsNumber
                           then begin
                                  if IsNumberReal
                                  then begin
                                         if s<>''
                                         then Result := owner_UiDmxScroller.NumToStr(Template_org,s,TypeCode,false)
                                         else Result := '';
                                       end
                                  else begin
                                         if S<>''
                                         then Result := owner_UiDmxScroller.NumToStr(Template_org,S,TypeCode,false)
                                         else Result := '';
                                       end;
                                end
                           else begin
                                  s_mask := owner_UiDmxScroller.Get_MaskEdit_LCL(Template_org,owner_UiDmxScroller.SpaceChar,OkMask_temp);
                                  if s<>''
                                  Then Result := owner_UiDmxScroller.FormatMaskEdit_LCL(s,s_mask,true)
                                  else Result := '';
                                end;
                         end
                    else Result := s;
                  end
             else Result := s;
           end;
    end;

    procedure TDmxFieldRec.SetAsString(S: AnsiString);
      //Obs PutString só é válido se usado com buffer
      //     original do arquivo e não do Template
      //   ATENÇÃO:
      //     Se houver erro de conversão PutString retorna a posição do error
      //     Executa o evento OnExit visto que pode ser feito um processamento de saída
      //     antes de gravar no registro.

        Var
          pv : pointer;
          P      : PValue;
          Err    : Integer;
          I,Len  : Word;
          V:Variant;
          Index: Integer;
      Begin
        If Assigned(owner_UiDmxScroller) Then
        begin

          Err := 0;
          owner_UiDmxScroller.TaStatus := 0;

          If Assigned(owner_UiDmxScroller.GetRecordData) Then
          Begin
            Pv := owner_UiDmxScroller.GetRecordData;
            Pv := Pv+DataTab;
            p := pv;
            If P <> nil
            Then With owner_UiDmxScroller,TDates do
                 Begin
                   Case TypeCode of
                      fldStr,
                      fldStrAlfa ,
                      fldStrNumber
                        : Begin
                            //if OkMask
                            //Then
                            s := RemoveMask(s);
                            s := trim(s);
                            If FieldSize <= 255 Then
                            Begin
                              If OkSpc
                              Then P^.asString := Spc(S,FieldSize)//-1
                              Else Begin
                                     If Length(S) < FieldSize
                                     Then P^.asString := S
                                     else P^.asString := Copy(S,1,FieldSize);//-1
                                   end;
                              s := P^.asString ;
                            End;
                          End;

                      FldDateTime
                        : begin
                            try
                              s := TDates.FormatMask(s,mask);
                              if TDates.DateTimeValid(s)
                              Then begin
                                     P^.asDateTime := TDates.StrToDateTime(s,Mask,true);
                                     if P^.asDateTime<>0
                                     Then s := TDates.DateTimeToStr(P^.asDateTime,Mask,true);
                                   end
                              else P^.asDateTime := 0;

                            Except
                              P^.asDateTime := 0;
                              TaStatus := Formato_numerico_invalido_ou_incompativel;
                           end;
                          end;


                      fldLHora,
                      fld_LHora
                        : begin
                            P^.asString := S;
                          end;

                      fldAnsiChar,
                      fldAnsiCharAlfa,
                      fldAnsiCharNumPositive,
                      fldAnsiCharNum
                        : Begin
                            Len := Length(s);
                            If Len <= FieldSize
                            Then Begin
                                   If Len > 0
                                   Then Move(s[1],P^,Len);
                                   If Len < FieldSize
                                   Then For I := len+1 to  len+1 + (FieldSize-(len+1))
                                        do TArrayAnsiChar(Pointer(P)^)[i-1] := FillValue;
                                 end
                            else Move(s[1],P^,FieldSize)
                          End;

                      fldENUM ,
                      fldENUM_db,
                      fldLongInt
                        : Begin
                            P^.asLongint := Longint(CheckRanger(s,High(Longint),Low(Longint),err));
                          end;

                      FldBoolean : begin
                                     if Lowcase(s)='false'
                                     then P^.asByte := 0
                                     else P^.asByte := 1;
                                   end;

                      fldByte : P^.asByte := Byte(CheckRanger(s,High(byte),Low(byte),err));

                      fldShortInt
                        : Begin
                            P^.asSHORTINT := SHORTINT(CheckRanger(s,High(SHORTINT),Low(SHORTINT),err));
                           end;

                      fldSmallWord
                        : Begin
                            P^.asSmallWord := SmallWord(CheckRanger(s,High(SmallWord),Low(SmallWord),err));
                           end;

                      FldRadioButton
                        : Begin
                            if Assigned(AliasList)
                            Then begin
                                   Index:=AliasList.IndexOf(s);
                                   if Index>=0
                                   Then P^.asByte := byte(Index);
                                 end;
                          end;

                      fldSmallInt
                        : Begin
                            P^.asSmallInt := SmallInt(CheckRanger(s,High(SmallInt),Low(SmallInt),err));
                          end;

                      fldDouble,
                      fldDoublePositive
                        : Begin
                            s := TObjectsMethods.DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
                            if not TryStrToFloat(S,P^.asRealNum,DefaultFormatSettings)
                            then P^.asRealNum := 0;
                          end;

                      fldReal4,
                      fldReal4Positivo
                        : Begin
                            s := TObjectsMethods.DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
                            if not TryStrToFloat(S,P^.asReal,DefaultFormatSettings)
                            then P^.asReal := 0;
                          end;

                      fldReal4P,
                      fldReal4PPositivo
                        : Begin
                            s := TObjectsMethods.DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
                            if not TryStrToFloat(S,P^.asReal,DefaultFormatSettings)
                            then P^.asReal := 0;

                            P^.asReal := P^.asReal/100;
                          End;

                      fldExtended
                        : begin
                            s := TObjectsMethods.DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
                            if not TryStrToFloat(S,P^.asExtended,DefaultFormatSettings)
                            then P^.asExtended := 0;
                          end;

                      fldHexValue : Begin end;
                      fldBLOb     : Begin end;
                  End;

                  If TaStatus <>0
                  Then Begin
                         Raise TException.Create({$I %CURRENTROUTINE%},'Erro em SettString campo: '+FieldName+' Valor: '+S);
                       end
                  else owner_UiDmxScroller.ChangeMadeOnOff(true);
                 End;
          end;
        end;
      End;

    function TDmxFieldRec.GetAsString: AnsiString;
      var
         wCurrentField : PDmxFieldRec;
    begin
      if Assigned(owner_UiDmxScroller)
      then begin
             try
               wCurrentField := owner_UiDmxScroller.CurrentField;
               owner_UiDmxScroller.SetCurrentField(RSelf);

               if (owner_UiDmxScroller.GetRecordData<>nil)
               then result := GetAsStringFromBuffer(owner_UiDmxScroller.GetRecordData)
               else Result := '';

             finally
               owner_UiDmxScroller.SetCurrentField(wCurrentField);
             end;
           end
      else result := '';
    End;

    function TDmxFieldRec.GetAsStringFromBuffer(aWorkingData: pointer): AnsiString;
    Var
      pv   : Pointer;
      P    : PValue;
      wS,s,s1 : tString;

      R32  : TUiDmxScroller.real;
      OkMask_temp:Boolean;
      len :integer;
    Begin
      if aWorkingData<>nil
      then Begin
            pv := aWorkingData;
            Pv := Pv+DataTab;
            p := pv;
            with TUiDmxScroller do
            Case TypeCode of
                 fldStr,
                 fldStrAlfa      ,
                 fldStrNumber   : Begin
                                 if okMask
                                 then begin
                                       s1 := owner_UiDmxScroller.Get_MaskEdit_LCL(Template_org,SpaceChar,OkMask_temp);
                                       result := owner_UiDmxScroller.FormatMaskEdit_LCL(P^.AsString,s1,true );
                                      end
                                 else begin
                                        result:=P^.AsString;
                                        If OkSpc
                                        Then Result := Spc(result,FieldSize-1) //-1
                                        Else Begin
                                               len := Length(result);
                                               If Length(result) > FieldSize
                                               then Result := Spc(result,FieldSize-1);
                                              End;
                                      end;
                               End;

                 FldDateTime   : begin
                                   if P^.asDateTime <> 0
                                   Then begin
                                           if length(Template_org)>2
                                           then begin
                                                 //if P^.asDateTime<>0
                                                 //Then s := SysUtils.DateTimeToStr(P^.asDateTime);

                                                  s:= Tdates.DateTimeToStr(P^.asDateTime,mask,true);
                                                  Result := s;
                                                  //ws := Copy(Template_org,2,Length(Template_org)-1);
                                                  //s:= Tdates.DateTimeToStr(P^.asDateTime,Tdates.MaskDateTime_to_Mask(ws));
                                                  //Result := Tdates.DateTimeToStr(P^.asDateTime,Tdates.MaskDateTime_to_Mask(ws))
                                                end
                                           else Raise TException.create({$I %CURRENTROUTINE%},'Template inválido!');

                                           //if not okMask
                                           //then result := DeleteMask(result,['0'..'9',' ']);
                                        end
                                   else Result := '';
                                 end;

                 fldAnsiChar,
                 fldAnsiCharAlfa,
                 fldAnsiCharNumPositive,
                 fldAnsiCharNum : Begin
                                    If FieldSize <= 255 Then
                                    Begin
                                      Move(P^,ws[1],FieldSize) ;
                                      ws[0] := AnsiChar(FieldSize);
                                    end
                                    Else Begin
                                           Move(P^,ws[1],255) ;
                                           ws[0] := AnsiChar(255);
                                         End;
                                    Result := ws;
                                  End;

                 fldENUM,
                 fldENum_db: begin
                               If (Not OkSpc) and (P^.asLongint = 0)
                               Then Result := '0'
                               else Begin
                                       if OkMask
                                       Then Result := NumToStr('LLLLLL',P^.asLONGINT,TypeCode,OkSpc)
                                       else Result := IntToStr(P^.asLONGINT);//IStr(P^.asLONGINT ,ConstStr(Length('LLLLLL'),'L'));
                                     end;
                             end;


                 fldLongInt  : Begin
                                 If (Not OkSpc) and (P^.asLongint = 0)
                                 Then Result := '0'
                                 else Begin
                                        if OkMask
                                        Then Result := NumToStr(Template_org,P^.asLONGINT,TypeCode,OkSpc)
                                        else Result := StrNum(Template_org,P^.asLONGINT,TypeCode,OkSpc);
                                      end;
                               end;

                 fldByte     : begin
                                 If (Not OkSpc) and (P^.asByte= 0)
                                 Then Result := '0'
                                 else Begin
                                        if OkMask
                                        Then Result := NumToStr(Template_org,P^.AsByte,TypeCode,OkSpc)
                                        else Result := StrNum(Template_org,P^.AsByte,TypeCode,OkSpc);
                                      end;
                               end;

                 fldShortInt : Begin
                                 If (Not OkSpc) and (P^.asShortInt = 0)
                                 Then Result := '0'
                                 else Begin
                                        if OkMask
                                        Then Result := NumToStr(Template_org,P^.asSHORTINT,TypeCode,OkSpc)
                                        else Result := StrNum(Template_org,P^.asSHORTINT,TypeCode,OkSpc);
                                      end;
                               end;

                 FldRadioButton :  begin
                                     if Assigned(AliasList)
                                     Then begin
                                            Result := AliasList.ValueFromIndex[P^.asByte];
                                          end;
                                   end;

                 fldSmallWord : Begin
                                  If (Not OkSpc) and (P^.AsSmallWord = 0)
                                  Then Result := '0'
                                  else Begin
                                         if OkMask
                                         Then Result := NumToStr(Template_org,P^.AsSmallWord,TypeCode,OkSpc)
                                         else Result := StrNum(Template_org,P^.AsSmallWord,TypeCode,OkSpc);
                                       end;
                                end;

                 fldSmallInt : Begin
                                 If (Not OkSpc) and (P^.asSmallInt = 0)
                                 Then Result := '0'
                                 else Begin
                                        if OkMask
                                        Then Result := NumToStr(Template_org,P^.AsSmallInt,TypeCode,OkSpc)
                                        else Result := StrNum(Template_org,P^.AsSmallInt,TypeCode,OkSpc);
                                      end;
                               end;

                 fldDouble,
                 fldDoublePositive : begin
                                         If (Not OkSpc) and (P^.asRealNum= 0)
                                         Then Result := '0'
                                         else begin
                                                if OkMask
                                                then Result := NumToStr(Template_org,P^.AsRealNum,TypeCode,OkSpc)
                                                else Result := StrNum(Template_org,P^.AsRealNum,TypeCode,OkSpc);
                                              end;
                                       end;
                 fldExtended           : begin
                                         If (Not OkSpc) and (P^.asExtended= 0)
                                         Then Result := '0'
                                       else begin
                                              if OkMask
                                              then Result := NumToStr(Template_org,P^.AsExtended,TypeCode,OkSpc)
                                              else Result := StrNum(Template_org,P^.AsExtended,TypeCode,OkSpc);
                                            end;
                                     end;


                 fldReal4,
                 fldReal4Positivo: begin
                                 If (Not OkSpc) and (P^.asReal= 0)
                                 Then Result := '0'
                                 else
                                 begin
                                   if OkMask
                                   then Result := NumToStr(Template_org,P^.AsReal,TypeCode,OkSpc)
                                   else Result := StrNum(Template_org,P^.AsReal,TypeCode,OkSpc);
                                 end;
                               end;

                 fldReal4P,
                 fldReal4PPositivo:
                               begin
                                 If (Not OkSpc) and (P^.asReal = 0)
                                 Then Result := '0'
                                 else Begin
                                        r32 := P^.AsReal*100;
                                        if OkMask
                                        then Result := NumToStr(Template_org,R32,TypeCode,OkSpc)
                                        else Result := StrNum(Template_org,P^.AsReal,TypeCode,OkSpc);
                                      end;
                               end;

                 FldBoolean  : begin
                                 //result := IntToStr(P^.asByte);
                                 if P^.asByte=0
                                 then result := 'false'
                                 else result := 'true';
                                end;
                 fldHexValue : Result := '' ;
                 fldBLOb     : Result := '' ;
            End; //Case
           End;//If
    end;

    function TDmxFieldRec.GetValue: Variant;
    begin
      Result := GetAsString;
    end;

    procedure TDmxFieldRec.SetValue(aValue: Variant);
    begin
      SetAsString(aValue);
    end;

    function TDmxFieldRec.IsInputText: Boolean;
    begin
      with owner_UiDmxScroller do
      Result :=  TypeCode in [fldStr,
                              fldStrNumber,
                              fldStrAlfa,
                              fldAnsiChar,
                              fldAnsiCharAlfa,
                              fldAnsiCharNumPositive,
                              fldAnsiCharNum,
                              fldByte,
                              fldShortInt,
                              fldSmallWord,
                              fldSmallInt,
                              fldLongInt,
                              fldDouble,
                              fldReal4,
                              fldReal4P,
                              fldReal4Positivo,
                              fldReal4PPositivo,
                              fldDoublePositive,
                              FldExtended,
                              fldHexValue,
                              FldDateTime,
                              fldLHora,
                              fld_LHora,
                              fldBLOb
                              ];

    end;

    function TDmxFieldRec.SItemsLen(S: PSItem): SmallInt;
       var  Len : integer;
    begin
       Len := 0;
       While (S <> nil) do
       begin
         If (S^.Value <> nil)
         then Inc(Len, length(S^.Value^));
         S := S^.Next;
       end;
       SItemsLen := Len;
     end;

    function TDmxFieldRec.MaxItemStrLen(AItems: PSItem): integer;
     //Retorna o tamanho da maior length(AItems^.Value^)

      var  len : integer;
    begin
      len := 0;
      While (AItems <> nil) do
      begin
        If (AItems^.Value <> nil)
        Then If (length(AItems^.Value^) > len)
             then len := length(AItems^.Value^);

        AItems := AItems^.Next;
      end;
      MaxItemStrLen := len;
    end;

    function TDmxFieldRec.GetMaxLength: integer;
    //=n specifies the maximum number of AnsiCharacters

        function  SItemsLenString(Const aStr: tString) : SmallInt;
          var S : PSItem;
        begin
          with owner_UiDmxScroller do
          If aStr[1] <> fldSItems Then
            Result := Length(aStr)
          Else
          Begin
            Move(aStr[2],S,Sizeof(PSItem));
            Result := SItemsLen(S);
          End;
        end;

      Var
        //ColumnWid,
        j  : Integer;
        P  : PSItem;
    Begin
      with owner_UiDmxScroller do
      If TypeCode in [FldRadioButton]
      Then Begin
             Result := 0;
             For j := 1 to Length(Template^) do
               If Not (Template^[j] in Delimiters) Then
                 //Inc(Result);
                 Result := Result + 1;
           End
      Else If TypeCode in [fldENUM,fldENUM_db]
           Then Begin {Calcula o }
                  Move(Template^[2],P,Sizeof(Pointer));
                  Result := MaxItemStrLen(P);
                End
           else If Template^[1] = fldSItems
                Then Begin
                       Result := SItemsLenString(Template^);
                     end
                Else Begin
                       ColumnWid := Pos(fldCONTRACTION,Template^);
                       Result := Length(Template^);
//                       Result := Length(AnsiString_to_USASCII(Template_org));
                       If ColumnWid <> 0
                       Then //Dec(Result );
                            Result := Result -1;
                     end;
    end;

    function TDmxFieldRec.IsStaticText: Boolean;
    begin
      Result := (FieldSize = 0) or
                ((Not IsInputText) and
                (Not IsInputRadio) and
//                (Not IsInputDbRadio) and
                (Not IsInputCheckbox) and
                (Not IsComboBox))
    end;

    function TDmxFieldRec.IsInputRadio: Boolean;
    Begin
      with owner_UiDmxScroller do
        Result := TypeCode in [FldRadioButton];
    End;

    //function TDmxFieldRec.IsInputDbRadio: Boolean;
    //begin
    //  with owner_UiDmxScroller do
    //    Result := TypeCode in [FldDbRadioButton];
    //end;

    function TDmxFieldRec.IsInputCheckbox: Boolean;
    Begin
      with owner_UiDmxScroller do
        Result := TypeCode = FldBoolean;
    end;

    function TDmxFieldRec.isInputPassword: Boolean;
    Begin
      Result := IsInputText and (CharShowPassword = ^W);   //<Se "CharShowPassword" = ^W então em FieldText imprime "CharShowPasswordAnsiChar" por tratar-se de uma senha
    end;

    function TDmxFieldRec.IsInputHidden: Boolean;
    Begin
      with owner_UiDmxScroller do
        Result := IsInputText and ((access and accHidden)<>0);
    end;

    function TDmxFieldRec.IsSelect: Boolean; //< O objeto filho que implementar um ISelect deve anular e retornar a interface ISelect;
    Begin
      Result := IsComboBox;
    end;

    function TDmxFieldRec.IsComboBox: Boolean;//< Usado quando trata-se de campos enumerados.
    Begin
      with owner_UiDmxScroller do
        Result := TypeCode in [fldENum,fldENum_db];   {< ^E; enumerated Field }
    end;

    function TDmxFieldRec.FirstField: pDmxFieldRec;
    Begin
      //If owner <> nil
      //Then  Result := owner.FirstField
      //Else Result := nil;
    end;

    function TDmxFieldRec.LastField: pDmxFieldRec;
    begin
      //If owner <> nil
      //Then  Result := owner.LastField
      //Else Result := nil;
    end;

    function TDmxFieldRec.NextField: pDmxFieldRec;
    begin
       Result := Next;
    end;

    function TDmxFieldRec.PrevField: pDmxFieldRec;
    begin
      Result := Prev;
    end;

    //function TDmxFieldRec.SelectFirstField: pDmxFieldRec;
    //begin
    //  //If owner <> nil
    //  //Then  Result := owner.SelectFirstField
    //  //Else Result := nil;
    //end;
    //
    //function TDmxFieldRec.SelectLastField: pDmxFieldRec;
    //begin
    //  //If owner <> nil
    //  //Then  Result := owner.SelectLastField
    //  //Else Result := nil;
    //end;

    procedure TDmxFieldRec.Select;
    begin
      //if (Not _reintrance_Select) and (TDmxEditor(owner).RecordSelected)
      //then try
      //       _reintrance_Select := true;
      //
      //        If owner <> nil
      //        Then  Begin
      //                TDmxEditor(owner).Select(Fieldnum);
      //                if (Link_IInputText<>nil) and (not reintrance_OnEnter) and (not reintrance_OnExit) and (Self.Fieldnum<>0)
      //                then Link_IInputText.select();
      //              end;
      //    finally
      //      _reintrance_Select := False;
      //    end;
    end;

    function TDmxFieldRec.GetCount_Cluster: Integer;
    begin

    end;

    function TDmxFieldRec.GetValue_Cluster(aItem: Integer): AnsiString;
    begin

    end;

    procedure TDmxFieldRec.SetValue_Cluster(aItem: Integer; wValue: AnsiString);
    begin

    end;

    function TDmxFieldRec.GetChecked_Cluster(aItem: Integer): Boolean;
    begin

    end;

    procedure TDmxFieldRec.SetChecked_Cluster(aItem: Integer; aValue: Boolean);
    begin

    end;

    function TDmxFieldRec.GetCount_InputRadio: Integer;
    begin

    end;

    function TDmxFieldRec.GetValue_InputRadio(aItem: Integer): AnsiString;
    begin

    end;

    procedure TDmxFieldRec.SetValue_InputRadio(aItem: Integer;
      aValue: AnsiString);
    begin

    end;

    function TDmxFieldRec.GetChecked_InputRadio(aItem: Integer): Boolean;
    begin

    end;

    procedure TDmxFieldRec.SetChecked_InputRadio(aItem: Integer; aValue: Boolean);
    begin

    end;

    function TDmxFieldRec.get_Item_Focused_InputRadio: Longint;
    begin

    end;

    function TDmxFieldRec.GetCount_InputCheckbox: Integer;
    begin

    end;

    function TDmxFieldRec.GetValue_InputCheckbox(aItem: Integer): AnsiString;
    begin

    end;

    procedure TDmxFieldRec.SetValue_InputCheckbox(aItem: Integer;aValue: AnsiString);
    begin

    end;

    function TDmxFieldRec.GetChecked_InputCheckbox(aItem: Integer): Boolean;
    begin

    end;

    procedure TDmxFieldRec.SetChecked_InputCheckbox(aItem: Integer;aValue: Boolean);
    begin

    end;

    function TDmxFieldRec.GetCount_Select: Variant;
    begin

    end;

    function TDmxFieldRec.GetSize_Select: Variant;
    begin

    end;

    function TDmxFieldRec.GetValue_Select(aItem: Integer): AnsiString;
    begin

    end;

    procedure TDmxFieldRec.SetValue_Select(aItem: Integer; aValue: AnsiString);
    begin

    end;

    function TDmxFieldRec.GetChecked_Select(aItem: Integer): Boolean;
    begin

    end;

    procedure TDmxFieldRec.SetChecked_Select(aItem: Integer; aValue: Boolean);
        Var
          P : PSItem;
    Begin
      with owner_UiDmxScroller do
        Case TypeCode of
          FLdEnum,
          FLdEnum_db: Begin
                        SetValue(aItem);
                      End;
          Else  Begin
                  Raise TException.Create({$I %CURRENTROUTINE%},'Tipo desconhecido');
                End;
        end;//case
    end;

    function TDmxFieldRec.IsNumber: Boolean;
    Begin
      if Assigned(owner_UiDmxScroller)
      then begin
             Result := IsNumberInteger or IsNumberReal;
           end
      else Result :=  false;
    end;

    function TDmxFieldRec.IsNumberReal: Boolean;
    begin
      with owner_UiDmxScroller do
        Result := TypeCode in [fldDouble,fldExtended,fldReal4,fldReal4P,fldReal4Positivo,fldReal4PPositivo];
    end;

    function TDmxFieldRec.IsNumberInteger: Boolean;
    begin
      with owner_UiDmxScroller do
        Result := TypeCode in [fldByte,fldShortInt,fldSmallWord,
                               fldSmallInt,fldLongInt,fldHexValue,fldENUM,FLdEnum_db];
    end;

    function TDmxFieldRec.IsNumberString: Boolean;
    begin
      with owner_UiDmxScroller do
         Result := TypeCode in [fldStrNumber];
    end;

    function TDmxFieldRec.IsBoolean: Boolean;
    begin
      with owner_UiDmxScroller do
         Result := TypeCode in [fldBoolean];
    end;

    function TDmxFieldRec.IsData: Boolean;
    begin
      with owner_UiDmxScroller do
         Result := TypeCode in [FldDateTime];
    end;

    //function TDmxFieldRec.IsHora: Boolean;
    //begin
    //  with owner_UiDmxScroller do
    //     Result := TypeCode in [fld_LHora,fldLHora];
    //end;

    function TDmxFieldRec.GetFldOrigin_Y: Integer;
    begin
      if _FldOrigin_Y < 0
      then Result := owner_UiDmxScroller.currentRecord
      else Result := _FldOrigin_Y;
    end;

    function TDmxFieldRec.GetFldOrigin: TPoint;

    begin
      Result.X := ScreenTab;
      Result.Y := FldOrigin_Y;
    end;

    {function TDmxFieldRec.GetLeft: Integer;
    //begin
    //  Result := Self.FldOrigin.X;
    //end;
    //
    //function TDmxFieldRec.GetTop: Integer;
    //begin
    //  //if LinkEdit is TControl
    //  //Then result := (LinkEdit as TControl).top
    //  //else result := 0;
    //end;
    //
    //function TDmxFieldRec.GetWidth: Integer;
    //begin
    //  //if LinkEdit is TControl
    //  //Then result := (LinkEdit as TControl).Width
    //  //else result := 0;
    //end;
    //
    //function TDmxFieldRec.GetHeight: Integer;
    //begin
    //  //if LinkEdit is TControl
    //  //Then result := (LinkEdit as TControl).Height
    //  //else result := 0;
    //end;
    }

    function TDmxFieldRec.SetAccess(aaccess: byte): Byte;
    begin
      result := access;
      if aAccess <> 0
      Then access := access or aaccess
      else access := 0;
    end;


    function TDmxFieldRec.Getreintrance_OnEnter: Boolean;
    begin
      Result := _reintrance_OnEnter;
    end;

    procedure TDmxFieldRec.Setreintrance_OnEnter(areintrance_OnEnter: Boolean);
    begin
      _reintrance_OnEnter := areintrance_OnEnter;
    end;

    function TDmxFieldRec.Getreintrance_OnExit: Boolean;
    begin
      Result := _reintrance_OnExit
    end;

    procedure TDmxFieldRec.Setreintrance_OnExit(areintrance_OnExit: Boolean);
    begin
      _reintrance_OnExit := areintrance_OnExit
    end;

     var
       reintrance_DmxFieldRec_OnEnter :boolean = false;
    procedure TDmxFieldRec.DoOnEnter(Sender: TObject);
    begin
      if (Not reintrance_DmxFieldRec_OnEnter)and Assigned(owner_UiDmxScroller)
      then try
             reintrance_DmxFieldRec_OnEnter := true;
             owner_UiDmxScroller.SetCurrentField(RSelf);
             owner_UiDmxScroller.Scroll_it_inview(RSelf);
             if Assigned(owner_UiDmxScroller.onEnterField) and (Fieldnum<>0)
             then begin
                    owner_UiDmxScroller.onEnterField(RSelf);
                  end;
             if Assigned(owner_UiDmxScroller.OnCalcField) and (Fieldnum<>0)
             then begin
                    owner_UiDmxScroller.OnCalcField(RSelf);
                  end;
             if FieldAltered
             then begin
                    owner_UiDmxScroller.PutBuffers;
                    owner_UiDmxScroller.UpdateBuffers;
                  end;
           finally
             reintrance_DmxFieldRec_OnEnter := False;
           end;
    end;

    var
      reintrance_DmxFieldRec_OnExit :boolean = false;
    procedure TDmxFieldRec.DoOnExit(Sender: TObject);
    begin
      if (not reintrance_DmxFieldRec_OnExit)  and Assigned(owner_UiDmxScroller)
      Then try
             reintrance_DmxFieldRec_OnExit := true;
             if Assigned(owner_UiDmxScroller.onExitField) and (Fieldnum<>0)
             then owner_UiDmxScroller.onExitField(RSelf);

             if Assigned(owner_UiDmxScroller.OnCalcField) and (Fieldnum<>0)
             then begin
                    owner_UiDmxScroller.OnCalcField(RSelf);
                  end;

             if (Fieldnum<>0) and FieldAltered
             then begin
                    if Assigned(owner_UiDmxScroller.OnChangeField)
                    Then owner_UiDmxScroller.DoChangeField(RSelf);

                    owner_UiDmxScroller.DoCalcFields;
                  end;

             if FieldAltered
             then begin
                    owner_UiDmxScroller.PutBuffers;
                    owner_UiDmxScroller.UpdateCommands;
                    owner_UiDmxScroller.UpdateBuffers;
                 end;
          finally
            reintrance_DmxFieldRec_OnExit := False;
          end;
    end;

    procedure TDmxFieldRec.CopyFrom(aDataField: TField);
      var
        wDefaultFormatSettings :  TFormatSettings;
        //aMask : Tdates.TMask;
        s : AnsiString;
        v : Variant;
    begin
       if IsData
       then begin
              try
                wDefaultFormatSettings := TDates.SetDefaultFormatSettings(Mask,true);
                s := aDataField.value;
                if s<>''
                Then Value := s
                else if IsNumber or IsData
                     Then Value := 0
                     else Value := '';
                 //Value := aDataField.value;

              finally
                DefaultFormatSettings := wDefaultFormatSettings;
              end;
            end
       else begin
              if not aDataField.IsNull
              then begin
                     if IsBoolean
                     then Value := aDataField.AsBoolean
                     else Value := aDataField.Value;
                     //s:= value;
                   end
              else begin
                     // Atribuir um valor padrão quando for nulo
                     if IsBoolean
                     then Value := False
                     else Value := '';  // ou outro valor padrão
                     //s:= value;
                   end;
            end;
    end;

    procedure TDmxFieldRec.CopyTo(aDataField: TField);
      var
        waccess : Byte;
        wOkMask,wReadOnly,wVisible : Boolean;
        wDefaultFormatSettings :  TFormatSettings;
        s : AnsiString;
    begin
      if aDataField.fieldName<>fieldName
      Then begin
             writeln('Raise TException.Create  (',{$I %CURRENTROUTINE%});  exit;
             //Raise TException.Create({$I %CURRENTROUTINE%},'Campo destino não pode ser nil!');
           end;
      try
        wReadOnly  := aDataField.ReadOnly;
        wVisible   := aDataField.Visible;
        aDataField.ReadOnly := false;
        aDataField.Visible  := true;
        wOkMask := OkMask;
        OkMask :=  false;
        waccess := SetAccess(AccNormal);
        wDefaultFormatSettings := TDates.SetDefaultFormatSettings(Mask,true);

        if not Assigned(aDataField)
        Then begin
               writeln('Raise TException.Create(',{$I %CURRENTROUTINE%});   exit;
  //           Raise TException.Create({$I %CURRENTROUTINE%},'Campo destino não pode ser nil!');
             end;

        If (not aDataField.dataSet.CanModify) or
           (Not aDataField.CanModify) or
           (Not (aDataField.dataset.State in [dsInsert,dsEdit]))
        Then begin
                writeln('Raise TException.Create(',{$I %CURRENTROUTINE%});    exit;
               //Raise TException.Create({$I %CURRENTROUTINE%},'DataSet não está no modo DsEdit ou DsInsert, por isso não pode ser atualizado.');
             end;

        if aDataField.DataType in [ftDate,ftTime,ftDateTime]
        then begin
               if not IsData
               Then begin
                      writeln('Raise TException.Create(',{$I %CURRENTROUTINE%});    exit;
                      //Raise TException.Create({$I %CURRENTROUTINE%},'Algo errado tipos inválidos!');

                    end;
               s := Value;
               if s<>''
               Then aDataField.Value := s
               else if IsNumber or IsData
                    Then aDataField.Value := 0
                    else aDataField.Value := '';
             end
        else begin
                if OkMask and (owner_UiDmxScroller.SaveMaskChar='0')
                Then begin
                       s := self.AddMask(Value,true);
                       aDataField.AsAnsiString := s;
//s := aDataField.AsAnsiString;
                     end
                else begin
//s := aDataField.AsAnsiString;

                       if IsBoolean
                       then aDataField.AsBoolean := Value
                       else aDataField.Value     := Value;
                       //s:= aDataField.AsAnsiString;
                       //aDataField.AsAnsiString := Value
                     end;
             end;

      finally
        DefaultFormatSettings := wDefaultFormatSettings;
        aDataField.ReadOnly := wReadOnly;
        aDataField.Visible  := wVisible;
        OkMask := wOkMask;
        SetAccess(waccess);
      end;
    end;

    //=====================================================================

    { TBufDataset }
    {$REGION ' Implementação da exportação e importação de arquivo di=o buffer'}

      procedure TMiBufDataSet.SaveToFile(aFileName: AnsiString;aMiDataPacketFormat: TMiDataPacketFormat);
        Var
          //WBookMark : TBookMark;
          FileText : TextFile;
          Err:Integer;
          S : String;

        Procedure SaveToJson_Appending();
          var
            wJSO : TJSONObject;
        begin
          With _UiDmxScroller do
          try
            If Not FileExists(_FileName)
            then begin
                   {$I-}system.Rewrite(FileText);{$I+}
                   Err:=IoResult;
                   If Err<>0
                   Then Raise TException.Create(self,{$I %CURRENTROUTINE%},Err);
                 end
            else begin
                   {$I-} system.Append(FileText);{$I+}
                   err := IOResult;
                   // Verifica se houve erro ao abrir o arquivo
                   if err <> 0
                   then Raise TException.Create(self,{$I %CURRENTROUTINE%},_FileName,'',Err);
                 end;

                 //Adiciona no fim do arquivo
                 try
                   wJSO := JSONObject;
//                   s := wJSO.AsJSON;
                   writeLn(FileText,wJSO.AsJSON);
                 finally
                   FreeAndNil(wJSO);
                 end;

          finally
            CloseFile(FileText);
          end;
        end;

        Procedure SaveToJson();
          Var
            wBookmark : TBookMark;
            wState:Boolean;
            ds :TdataSet;
            wJSO : TJSONObject;
            OkSalvou :Boolean =false;
        begin
          AssignFile(FileText,_FileName);
          with _UiDmxScroller do
            if _Appending
            Then begin
                   SaveToJson_Appending();
                   exit;
                 end;

          with _UiDmxScroller do
          try
            ds := GetDataSet;
            wBookmark := CurrentBookmark;

            if FileExists(_FileName)
            then begin
                   err := DeleteFile(_FileName);
                   if err<>0
                   Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não posso excluir o arquivo: ',_FileName,err);
                 end;

            {$I-}system.Rewrite(FileText);{$I+}
            Err:=IoResult;
            If Err<>0
            Then Raise TException.Create(self,{$I %CURRENTROUTINE%},Err);

            WState := SetState(Mb_St_Creating,true );

            //Adiciona todos os registros do buffer
            if FirstRec
            Then While not eof do
                 begin
                   try
                     wJSO := JSONObject;
//                     s := wJSO.AsJSON;
                     writeLn(FileText,wJSO.AsJSON);
                     OkSalvou:= true;
                   finally
                     FreeAndNil(wJSO);
                   end;
                   NextRec;
                 end;

          finally
            CloseFile(FileText);


            if OkSalvou and (not IsEmpty) and ( Not _Appending)
            Then begin
                   GetRec(wBookmark);
                 end
            else begin
                   if FileSize(_FileName)=0
                   Then begin
                          DeleteFile(_FileName);
                          ds.Active:=false;
                          ds.Active:=true;
                       end;
                 end;

            SetState(Mb_St_Creating,WState);

            If not (ds.State in dsEditModes)
            Then edit;
          end;

        end;

        Var
          WState : Boolean;
      begin
        with _UiDmxScroller do
        try
          if Application.GetTypeApplication = Application.TEnumApplication.EnApp_LCL_Http_Client
          Then exit;

          CheckBrowseMode;
          wState := GetState(Mb_St_Creating);
          if GetState(Mb_St_ControlsEnabled)
          Then DisableControls;

          Case aMiDataPacketFormat of
            dfJSon    : SaveToJson();
            dfXML     : BufDataset.SaveToFile(_FileName,TDataPacketFormat.dfXML);
            dfBinary  : BufDataset.SaveToFile(_FileName,TDataPacketFormat.dfBinary);
            dfXMLUTF8 : BufDataset.SaveToFile(_FileName,TDataPacketFormat.dfXMLUTF8);
            dfAny     : BufDataset.SaveToFile(_FileName,TDataPacketFormat.dfAny);
            dfDefault : BufDataset.SaveToFile(_FileName,TDataPacketFormat.dfDefault);
          end;

        finally
          SetState(Mb_St_Creating,wState);
          if not GetState(Mb_St_ControlsEnabled)
          Then EnableControls;
        end;

      end;

      procedure TMiBufDataSet.SaveToFile();
      begin
        With _UiDmxScroller do
        if Assigned(_BufDataset) and (_FileName<>'')
        Then begin
                SaveToFile(_FileName,MiDataPacketFormat_Default);
             end;
      end;

      procedure TMiBufDataSet.LoadFromFile(aFileName: AnsiString;aMiDataPacketFormat: TMiDataPacketFormat);

        Procedure LoadFromFileJson();
          var
            aJSONObject: TJSONObject;
          var
            err,nr : Integer;
            FileText: TextFile;
            Line: string;
        begin
          // Verifique se o arquivo existe
          if not FileExists(_FileName) then
          begin
//            WriteLn('Erro: O arquivo ', FileName, ' não existe.');
            Exit;
          end;

          AssignFile(FileText, _FileName);
          {$I-} // Desabilita a verificação de erros de E/S
          Reset(FileText);
          {$I+} // Reabilita a verificação de erros de E/S
          err := IOResult;
          // Verifica se houve erro ao abrir o arquivo
          if err <> 0 then
          begin
            Raise TException.Create(self,'LoadFromFile().LoadFromFileJson()',_FileName,'',Err);
          end;

          with _UiDmxScroller do
          try
            nr := 0;
            while not system.Eof(FileText) do
            begin
              {$I-}
              ReadLn(FileText, Line);
              {$I+}
              // Verifica se houve erro ao ler a linha
              err := IOResult;
              if err <> 0 then
              begin
                Raise TException.Create(self,'LoadFromFile().LoadFromFileJson()',_FileName,'',Err);
              end;

              if Line <> '' then
              begin
                DoOnNewRecord;
                // Converte o texto JSON para um objeto TJSONObject
                try
                  aJSONObject := TJSONObject(GetJSON(Line));
                  JSONObject := aJSONObject;
                  If not AddRec
                  Then Raise TException.Create(self,'LoadFromFile().LoadFromFileJson()',_FileName,'',Err);
                  inc(nr);
                finally
                  Freeandnil(aJSONObject);
                end;

              end;
            end;
            FirstRec;
          finally
            CloseFile(FileText);
          end;

        end;


        Var
          WState : Boolean;
      begin
        with _UiDmxScroller do
        try
          CheckBrowseMode;
          wState := GetState(Mb_St_Creating);
          if GetState(Mb_St_ControlsEnabled)
          Then DisableControls;

          Case aMiDataPacketFormat of
            dfJSon    : LoadFromFileJson();
            dfBinary  : BufDataset.LoadFromFile(_FileName,TDataPacketFormat.dfBinary);
            dfXML     : BufDataset.LoadFromFile(_FileName,TDataPacketFormat.dfXML);
            dfXMLUTF8 : BufDataset.LoadFromFile(_FileName,TDataPacketFormat.dfXMLUTF8);
            dfAny     : BufDataset.LoadFromFile(_FileName,TDataPacketFormat.dfAny);
            dfDefault : BufDataset.LoadFromFile(_FileName,TDataPacketFormat.dfDefault);
          end;

        finally
          SetState(Mb_St_Creating,wState);
          if not GetState(Mb_St_ControlsEnabled)
          Then EnableControls;
        end;
      end;

      procedure TMiBufDataSet.LoadFromFile();
      begin
        with _UiDmxScroller do
        if Assigned(_BufDataset) and (_FileName<>'')
        Then begin
               if FileExists(_FileName)
               Then begin
                      LoadFromFile(_FileName,MiDataPacketFormat_Default);
                    end;
            end;
      end;


    {$ENDREGION ' Implementação da exportação e importação de arquivo di=o buffer'}


    procedure TMiBufDataset.ApplyUpdates;
    begin
      with _UiDmxScroller do
        If (not getState(Mb_St_Creating))
        Then SaveToFile();
    end;

    { TFields }

    constructor TDataFields.Create;
    begin
      inherited Create(5,true); {:< - Se True insere em ordem alfabética}
      Duplicates:= dupError;  //Não aceita duplicados
      OkDestroy_Object := false;
    end;

    destructor TDataFields.Destroy;
    begin
      inherited Destroy;
    end;

    function TDataFields.AddKey(WKey: String; apDmxFieldRec: pDmxFieldRec): Boolean;
    Begin
      Try
        Result := true;
        AddObject(UpperCase(WKey),TObject(apDmxFieldRec));
      except
        Result := false;
      end;
    end;

    procedure TDataFields.AddFields(apDmxFieldRec: pDmxFieldRec);
      var
        s:String;
        fn : Integer;
    begin
      with apDmxFieldRec^ do
      if Fieldnum>=0
      Then begin
             s  := FieldName;
             fn := FieldNum;
             if (s<>'') and ( Not FindKey(s))
             Then begin
                     If not AddKey(FieldName,apDmxFieldRec)
                     Then Raise TException.Create(self,{$I %CURRENTROUTINE%},
                         'O campo '+FieldName+' está em duplicidade!');

                     if (TypeCode in [owner_UiDmxScroller.fldRadioButton])
                     Then begin
                            AliasList := TStringList.Create;
                            AliasList.Sorted := false; //Quando sorted = false não pode usar o medido find
                          end;
                  end;
           end;
    end;

    function TDataFields.getRec(aIndex:Longint): pDmxFieldRec;
    begin
      if (aIndex >=0 ) and (aIndex <= Count-1)
      then begin
             Index_Currente := aIndex;
             Nr := PtrInt(Objects[Index_Currente]);
             result := pDmxFieldRec(Nr);
           end
      else Result := nil;
    end;

    function TDataFields.getRec(): pDmxFieldRec;
    begin
      result := getRec(Index_Currente);
    end;

    procedure TFields.AddFields(apDmxFieldRec: pDmxFieldRec);
    begin
      Add(apDmxFieldRec);
    end;

  {$ENDREGION '<--- TDmxFieldRec' }
  //======================================================

  //======================================================
  {$Region 'TUiDmxScroller'}

    constructor TUiDmxScroller.Create(aOwner: TComponent);
    begin
      inherited Create(aowner);
      DefaultFormatSettings := FormatBr;
      _Active := false;
      SetState(Mb_St_Active,false);
      AlignmentLabels:= taLeftJustify;// taCenter;taRightJustify;
      keysPrimaryKeyComposite := '';
      flagPrimaryKey_AutoIncrement := false;
      _Strings := TMiStringList.Create;
      DoOnNewRecord_FillChar := true;
      //wJSONObject := nil;
      DataFields := TDataFields.Create;
      wWorkingData    := nil;
      wWorkingDataOld := nil;
    end;

    destructor TUiDmxScroller.destroy;
    begin
      BeforeDestruction;

      if active
      then Active:=false;

      if Assigned(DataFields)
      then FreeAndNil(DataFields);

      if Assigned(Fields)
      then FreeAndNil(Fields);

      if Assigned(_Strings)
      Then FreeAndNil(_Strings);

      if (_DataSource <>nil) and (_DataSource.Owner = self)
       then FreeandNil(_DataSource) ;

      if Assigned(_BufDataset) and (_BufDataset.Owner = self)
      then FreeandNil(_BufDataset) ;

      //if Assigned(wJSONObject)
      //Then FreeandNil(wJSONObject);

      inherited destroy;
    end;

    function TUiDmxScroller.SetHelpCtx_Hint(aFldNum: Integer;a_HelpCtx_Hint: AnsiString): pDmxFieldRec;
    begin
      Result := FieldByNumber(aFldNum);
      if result <> nil
      then result^.HelpCtx_Hint := a_HelpCtx_Hint;
    end;

    procedure TUiDmxScroller.SetHelpCtx_Hint(apDmxFieldRec: pDmxFieldRec;a_HelpCtx_Hint: AnsiString);
    begin
      if apDmxFieldRec<>nil
      Then apDmxFieldRec.HelpCtx_Hint:=a_HelpCtx_Hint;
    end;

    procedure TUiDmxScroller.New(var apDmxFieldRec: pDmxFieldRec);
    begin
      system.new(apDmxFieldRec);
      Fields.AddFields(apDmxFieldRec);
//      writeLn('New(apDmxFieldRec) = ',MemSize(apDmxFieldRec),' bytes');  imprime 280 bytes
    end;

    procedure TUiDmxScroller.Dispose(var apDmxFieldRec: pDmxFieldRec);
      Var
        c : TComponentState;
    begin
      if Fields.IndexOf(apDmxFieldRec)>=0
      then begin
             if not Assigned(apDmxFieldRec)
             then Raise TException.Create(self,{$I %CURRENTROUTINE%},ParametroInvalido);

             Fields.Delete(Fields.IndexOf(apDmxFieldRec));

             if Assigned(apDmxFieldRec^.FldEnum_Lookup)
             then FreeAndNil(apDmxFieldRec^.FldEnum_Lookup);

             if Assigned(apDmxFieldRec^.AliasList)
             Then FreeAndNil(apDmxFieldRec^.AliasList) ;

             System.Dispose(apDmxFieldRec);
             apDmxFieldRec := nil;
           end;
    end;

    procedure TUiDmxScroller.SavewWorkingData;
    begin
      wWorkingData    := CGetMem(WorkingData,RecordSize);
      wWorkingDataOld := CGetMem(WorkingDataOld,RecordSize);
    end;

    procedure TUiDmxScroller.RestorewWorkingData;
    begin
      Move(wWorkingData^,WorkingData^,RecordSize);
      Move(wWorkingDataOld^,WorkingDataOld^,RecordSize);
    end;

    procedure TUiDmxScroller.DestroywWorkingData;
    begin
      FFreeMem(wWorkingData,RecordSize);
      FFreeMem(wWorkingDataOld,RecordSize);
    end;

    procedure TUiDmxScroller.SetCurrentRecord( aCurrentRecord: Longint);
    begin
      if _CurrentRecord <> aCurrentRecord
      then begin
            _CurrentRecord := aCurrentRecord;
           end;
    end;

    function TUiDmxScroller.GetStrings: TMiStringList;
    begin
      if Not Assigned(_Strings)
      then _Strings := TMiStringList.Create;
      Result := _Strings
    end;

    procedure TUiDmxScroller.SetStrings(a_Strings: TMiStringList);
    begin
      if (_Strings <> a_Strings) then
        _Strings.Assign(a_Strings);
    end;

    procedure TUiDmxScroller.SetTableName(aTableName: String);
    begin
      _TableName := aTableName;
    end;

    function TUiDmxScroller.GetAppending: Boolean;
    Begin
      Result := _Appending;
      if result and isDataSetActive
      then begin
             if not (GetDataSet.State in [DsInsert] )
             Then begin
                    writeln('Raise TException.Create(',{$I %CURRENTROUTINE%});exit;
                    //raise TException.Create(self,{$I %CURRENTROUTINE%},'Appending = true e DsInsert=false!');
                  end;

           end;
    End;

    procedure TUiDmxScroller.SetAppending(aAppending: Boolean);
    Begin
      _Appending := aAppending;
      if _Appending
      Then SetState(Mb_St_Insert,true)
      else SetState(Mb_St_Insert,false);
    end;

    function TUiDmxScroller.SetOnCalcRecord(const WOnCalcRecordEnable: Boolean): Boolean;
    Begin
      Result := GetState(Mb_OnCalcRecord);
      SetState(Mb_OnCalcRecord,WOnCalcRecordEnable);
    End;

    procedure TUiDmxScroller.SetRecordSelected(a_RecordSelected: boolean);
    Begin
      if a_RecordSelected
      then BEGIN
             if Self.Appending
             then begin
                    if CurrentRecord <>0
                    then begin
                           raise TException.Create(self,{$I %CURRENTROUTINE%},
                           'Antes de selecionar o registro é necessário executar o método DoOnNewRecord()!');
                         end;
                   end
              else begin
                     if not DataSource.DataSet.BookmarkValid(CurrentBookmark)
                     then a_RecordSelected := false;
                   end;

           END;
      _RecordSelected := a_RecordSelected;
      if  _RecordSelected
      Then DoCalcFields;
    End;

    procedure TUiDmxScroller.SetDoOnNewRecord_FillChar(   const a_DoOnNewRecord_FillChar: Boolean);
    Begin
      _DoOnNewRecord_FillChar := a_DoOnNewRecord_FillChar;
      If _DoOnNewRecord_FillChar
      Then Begin
             CurrentRecord    := 0;
             System.FillChar(WorkingData^,RecordSize,0);
             System.FillChar(WorkingDataOld^,RecordSize,0);
             GetBuffers;
           End;
    End;

    var
      reintrance_ChangeMadeOnOff:Boolean = false;
    procedure TUiDmxScroller.ChangeMadeOnOff(const aValue: Boolean);
    Begin
      if not reintrance_ChangeMadeOnOff
      then Begin
             reintrance_ChangeMadeOnOff := true;
             if aValue and RecordAltered
             then begin
                    KeyAltered := aValue;
                    UpdateCommands;
                  end
             else KeyAltered := aValue;
             reintrance_ChangeMadeOnOff := false;
           end;
    End;

    function TUiDmxScroller.GetRecordSelected: boolean;
    Begin
      result := _RecordSelected;
      if result
      Then begin
            if appending
            then begin
                   Result := (Self.CurrentRecord = 0) and
                             (CurrentRecord=CurrentRecordOld);
                 end
            else begin
                   Result := //(Self.CurrentRecord <> 0) and
                             (CurrentRecord=CurrentRecordOld) and
                              DataSource.DataSet.BookmarkValid(CurrentBookmark);

                 end;
          end;
    end;

    procedure TUiDmxScroller.DoOnNewRecord;
      Var
        WState_Mb_St_Focused : Boolean;
        wOnCalcRecordEnable: Boolean;
        p :TDataSetNotifyEvent;
        wCurrentField:PDmxFieldRec;
        I :integer;
        s : string;
        //ws : TDmxStr_id;
    Begin
      if isDataSetActive
      then begin
             Try //Except
               Try //Finally
                 Appending         := true; //Indica que se trata de um nove registro
                 CurrentRecord    := 0;
                 CurrentRecordOld := CurrentRecord;
                 Locked:=false;
                 If DoOnNewRecord_FillChar
                 Then System.FillChar(WorkingData^,RecordSize,0);
                 Move(WorkingData^,WorkingDataOld^,RecordSize);
                 wOnCalcRecordEnable := SetOnCalcRecord(False);
                 WState_Mb_St_Focused    := SetState(Mb_St_Focused,False);

                 try
                   wCurrentField := CurrentField;
                   DataSet_Append;
                   RecordSelected   := true;

                   // Seta os campos defaults
                   for i := 0 to DMXFields.Count-1 do
                   begin
                     CurrentField := DMXFields[i];
                     while (CurrentField) <> nil do
                     begin
                       if CurrentField.Fieldnum<>0
                       Then begin
                              if CurrentField^.TypeCode in [fldENUM,fldENum_db]
                              Then s := IntToStr(CurrentField^.ListComboBox_Default)
                              else begin
                                     s := CurrentField^.Default;
                                   end;

                              if s<>''
                              Then CurrentField^.value := s;
                            end;
                       if CurrentField <> nil
                       Then CurrentField := CurrentField^.Next;
                     end;
                   end;

                 finally
                   CurrentField := wCurrentField;
                 end;

                 Move(WorkingData^,WorkingDataOld^,RecordSize);

                 if Assigned(OnNewRecord)
                 then begin
                        OnNewRecord(Self);
                        Move(WorkingData^,WorkingDataOld^,RecordSize);
//                        DataSet_Append;
                        PutBuffers; //Transfere as alteração para o dataset
                        p :=  DataSource.DataSet.OnNewRecord;
                        if Assigned(p)
                        then begin
                               p(DataSource.DataSet);
                             end;
                      end
                 else begin
//                        DataSet_Append;
                        PutBuffers; //Transfere as alteração para o dataset
                      end;
                 UpdateBuffers;
                 UpdateCommands;
               Finally
                 SetState(Mb_St_Focused,WState_Mb_St_Focused);
                 SetOnCalcRecord(wOnCalcRecordEnable);
                 Self.ChangeMadeOnOff(False);
                 if Assigned(Parent)
                 Then begin
                        if (Fields.Count>0)
                        then Select_First_Field_Normal;
                      end;
               End;


             Except
               On E : Exception do
               begin
                 ShowMessage(E.Message);
                 Self.RecordSelected := False;
                 SetState(Mb_St_Insert,false);
                 Locked:=true;
               end;
             end;
           end;
    End;

    function TUiDmxScroller.StartTransaction: Boolean;
    begin
      If Not _BufDataset_created
      Then Result :=inherited StartTransaction
      else Result := true;
    end;

    function TUiDmxScroller.COMMIT: Boolean;
    begin
      DataSet_ApplyUpdates;
      Result:=inherited COMMIT;
    end;

    procedure TUiDmxScroller.Rollback(afinalize: Boolean; aMsg: AnsiString; aWorkingData:Pointer);
      Var
        wAppending : Boolean;
        ds : TDataSet;
    begin
      if afinalize
      then begin
             ds := GetDataSet;
             wAppending := Appending;
             DataSet_Cancel;
             if aMsg<>''
             Then ShowMessage(aMsg);

             inherited Rollback;

             if (not isDataSetActive)
             Then ds.active := true;

             Refresh;
             if wAppending
             then DoOnNewRecord;

             if Assigned(aWorkingData)
             then begin
                    RestorewWorkingData;
                    DestroywWorkingData;

                    If Not (ds.State in [DsEdit,DsInsert])
                    Then edit;
                    PutBuffers;
                  end;
           end;

      // Se ouver exceção é necessário desalocar wJSONObject salvo antes da exceção
      //If Assigned(wJSONObject)
      //Then FreeAndNil(wJSONObject);
    end;

    function TUiDmxScroller.SetState(const AState: Int64; const Enable: boolean      ): Boolean;
      var s: string;
    Begin
      If State and aState <> 0
      Then Result := True
      Else Result := false;

      if Enable
      then begin
             State := State or AState;
             if active and ((State and (Mb_St_Edit+Mb_St_Insert+Mb_St_Browse))<>0) and isDataSetActive
             Then UpdateCommands;
           end
      else Begin
             State := State and not AState;
             if active and ((State and (Mb_St_Edit+Mb_St_Insert+Mb_St_Browse))<>0) and isDataSetActive
             Then UpdateCommands;
           end;
    End;

    function TUiDmxScroller.GetState(const AState: Int64): Boolean;
    Begin
      If State and aState <> 0
      Then Result := True
      Else Result := false;
    End;

    function TUiDmxScroller.FieldByName(aName: String): PDmxFieldRec;
      Var
        i : Integer;
        fld:PDmxFieldRec;
    begin
      result:=nil;
      for i := 0 to Fields.Count-1 do
      begin
        fld := Fields[i];
        if Assigned(fld) and  (CompareText(fld^.FieldName,aName)=0)
        then begin
               Result := fld;
               exit;
             end;
      end;
    end;

    function TUiDmxScroller.FieldByNumber(aFieldNum: Integer): PDmxFieldRec;
    Var
      i : Integer;
      fld : PDmxFieldRec;
    begin
      result := nil;
      for i := 0 to Fields.Count-1 do
      begin
        fld := Fields[i];
        if fld^.Fieldnum = AFieldNum
        then begin
               result := fld;
               exit;
             end;
      end;
    end;

    function TUiDmxScroller.CancelBuffers: Boolean;
    begin
      result := true;
      //Cancela as alterações do registro atual;
      system.Move(WorkingDataOld^,WorkingData^, RecordSize);
     // UpdateBuffers;
     PutBuffers;
      ChangeMadeOnOff(False);
    end;

    function TUiDmxScroller.GetBuffers: Boolean;
    begin
      result := true;

      //Salva o registro atual para o registro anterior;
      if Assigned(WorkingData) and Assigned(WorkingDataOld)
      then system.Move(WorkingData^,WorkingDataOld^, RecordSize);

      ChangeMadeOnOff(False);
    end;

    function TUiDmxScroller.PutBuffers: Boolean;
    begin
      result := true;
    end;

    procedure TUiDmxScroller.DoOnCloseQuery(aDmxScroller: TUiDmxScroller; var CanClose: boolean);
    Begin
      if Assigned(OnCloseQuery)
      then OnCloseQuery(aDmxScroller,CanClose)
      else CanClose := true;
    End;

    procedure TUiDmxScroller.DoOnCloseQuery(var CanClose: boolean);
    Begin
      DoOnCloseQuery (Self,CanClose);
    End;

    function TUiDmxScroller.IsEmpty: Boolean;
      Var
        r:Longint;
    begin
      if isDataSetActive
      Then begin
         //    r:= GetDataSet.RecordCount;
             result :=  GetDataSet.IsEmpty;
             if Result
             Then begin
                    //Eof := False;
                    //Bof := False;
                  end;
           end
      else Result := false;
    end;

    procedure TUiDmxScroller.DoOnEnter(aDmxScroller: TUiDmxScroller);
      var
        ds : TDataSet = nil;
    begin
      ds := GetDataSet;
      if Not isDataSetActive
      then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Dataset não está ativo!');
      If IsEmpty
      Then DoOnNewRecord
      else begin
             if (Not Appending)  and (not RecordSelected)
             Then begin
                    if DataSet_BookmarkValid(ds.GetBookmark)
                    Then begin
                           if not GetRec(ds.GetBookmark)
                           Then Locked:=true
                         end;
                  end;
           end;
      if Assigned(onEnter)
      then begin
             if GetBuffers
             then begin
                    UpdateBuffers;
                    if RecordSelected
                    then begin
                           If Not (ds.State in [DsEdit,dsInsert])
                           Then edit;
                           OnEnter(Self) ;
                         end;
                 end;
           End
      Else GetBuffers;
      if RecordAltered
      Then begin
             GetBuffers;
             ChangeMadeOnOff(true)
           end
      else ChangeMadeOnOff(false);

      _RecordSelected := true;
      If Not (ds.State in [DsEdit,dsInsert])
      Then edit;
      //UpdateCommands;
    end;

    procedure TUiDmxScroller.DoOnEnter();
    begin
      DoOnEnter(self);
    end;

    procedure TUiDmxScroller.DoOnExit(aDmxScroller: TUiDmxScroller);
    begin
      if RecordSelected
      Then begin
              DoCalcFields;
              if Assigned(onExit)
              then begin
                     OnExit(Self) ;
                   End;
              _RecordSelected := false;
           end;
    end;

    procedure TUiDmxScroller.DoOnExit();
    begin
      DoOnExit(self);
    end;

    procedure TUiDmxScroller.BeforeDestruction;
    begin
      inherited BeforeDestruction;
    end;

    procedure TUiDmxScroller.SetCurrentField(aCurrentField: pDmxFieldRec);
    begin
      CurrentField_old := _CurrentField;
      if Assigned(aCurrentField) and (aCurrentField.Fieldnum<>0)
      Then begin
              _CurrentField    := aCurrentField;
              CurrentField_focused := _CurrentField;
             FieldData := WorkingData;
             FieldData := FieldData + _CurrentField.DataTab;
           end
      else _CurrentField := aCurrentField;
    end;

    procedure TUiDmxScroller.CreateStruct(var ATemplate: TString);
        var
          SameFieldNum  : boolean;
          WasSameNum    : boolean;
          NoFieldNum    : boolean;
          NoFieldAdv    : boolean;
          AllZeroes     : boolean;
          C             : AnsiChar;
          DoDecimal     : integer;
          Rex,X         : pDmxFieldRec;
          WFieldName    : tString;
          DmxStr_ID     : TDmxStr_ID;
          _templx       :  tString;
          _templx_Org   :  AnsiString;


      Procedure SetFlags(aFlag:Boolean);
      begin
        SameFieldNum := aFlag;
        WasSameNum   := aFlag;
        NoFieldNum   := aFlag;
        NoFieldAdv   := aFlag;
      end;

      {$REGION 'templx'}
        //Objetivo desta função é salva o Template original.

        function templx(Const Ch,ch_Org:tString) : AnsiString;Overload;
            Begin
              if Ch=''
              then Begin
                     _templx := '';
                     _templx_Org := '';
                   End
              Else Begin
                     _templx := _templx + ch;
                     _templx_Org := _templx_Org + ch_Org;
                   End;

              Result := _templx;
            End;

        function templx(Const Ch:tString) : AnsiString;Overload;
        Begin
          Result := templx(ch,'');
        End;

        function templx : AnsiString;Overload;
            Begin
              Result := _templx;
            End;

      {$ENDREGION}

      procedure NewRecord;
      begin
        If not CreateValid
        then Exit;

        With TUiMethods,Rex^ do
        begin
          If DoDecimal > 0
          then Rex.Decimals := pred(DoDecimal);

          DoDecimal := 0;
          If (FieldSize= 0)
          then access := access or accSkip
          else begin
                 If not NoFieldAdv
                 then begin
                        If SameFieldNum  and (not NoFieldNum)
                        then Begin
                               Fieldnum := succ(TotalFields);
                               {Se não existir nome do campo no Template, então devo criar um.
                                formato:
                                   Para o campo 1 nome do campo = Field1,
                                   Para o campo 2 nome do campo = filed2
                                   .............
                                   Para o campo n nome do campo = filedn
                               }

                               if WFieldName = ''
                               then WFieldName := Format('Field%d',[Fieldnum]);

                               FieldName := WFieldName; //ITMS
                               DataFields.AddFields(Rex);

                             end
                             else If (access and accHidden = 0) or WasSameNum
                                  then begin
                                          Inc(TotalFields);
                                          Fieldnum := TotalFields;

                                          if (WFieldName = '') and (Fieldnum<>0 )
                                          then WFieldName := Format('Field%d',[Fieldnum]);

                                          FieldName := WFieldName; //ITMS
                                          if FieldName<>''
                                          Then DataFields.AddFields(Rex);
                                       end;

                        DataTab    := RecordSize;
                        RecordSize := RecordSize + FieldSize;

                      end;
                 end;
          ScreenTab  := Limit.X;

          If (TypeCode = FldBoolean) and (TrueLen = 0)
          then ShowZeroes := FALSE;

          If TypeCode in [fldENUM,FLdEnum_db]
          then ColumnWid := TrueLen
          else begin
                 If (ColumnWid = 0)
                 then ColumnWid := length(AnsiString_to_USASCII(templx));

                 If (length(templx) > 0) or (Template <> nil)
                 then begin
                        Template     := NewStr(templx);
                        Template_org := _templx_Org; //ITMS
                      end
                 else begin
                        If (TypeCode <> #0) and (access and accHidden = 0)
                        then Inc(Limit.X);
                      end;
               end;

          If (ShownWid = 0)
          then ShownWid := ColumnWid;

          If access and accHidden = 0
          then Limit.X := Limit.X + ShownWid;

        end;

        templx('');

        {$REGION '---> Aloca o próximo registro'}
          New(Rex.Next);
          //Fields.Add(Rex);
          X       := Rex;
          x.RSelf := Rex;
          Rex     := Rex.Next;
          //Zera o novo registro
          FillChar(Rex^, sizeof(Rex^), 0);
          Rex.Prev := X;
          Rex.Next := nil;

          Rex.ShowZeroes := AllZeroes;

          WFieldName := ''; //< NortSoft
          Rex.Owner_UiDmxScroller := Self; // NortSoft

          Rex.ProviderFlags := [pfInUpdate,pfInWhere];
          Rex.ID_Dynamic := Alias+'_'+CreateGUID;
          Rex.QuitFieldAltomatic := QuitFieldAltomatic_Default;

        {$ENDREGION}


        //WasSameNum := FALSE;
        //NoFieldNum := FALSE;
        //NoFieldAdv := FALSE;
        SetFlags(false);
      end; {<procedure NewRecord;}

      {: O método **@name** tranfere as informações da string dataformat para
         a lista encadea cujo o primeiro elemento é: DMXField1
      }
      procedure TranslateStruct(dataformat: ptString);
        var
          df   : ptString;
          i,j  : integer;
          Flag : byte;
          TS   : PSItem;
          temp1,
          temp2: TDmxStr_ID;//String[30];
          LenDataformat : integer;


        function GetFieldName:AnsiString;
          begin
            result := '';
            if CharFieldName <> dataformat^[i]
            then exit;

            Inc(i);
            While (not (dataformat^[i] in Delimiters))
                  and (i <= length(dataformat^))
            do begin
                 Result := Result + dataformat^[i];
                 Inc(i);
               end;
          End;

        function GetExecAction:AnsiString;
          var
            s,aFieldName : Ansistring;

        begin
          result := '';
          aFieldName := '';
          Inc(i);

          s:= Copy(dataformat^,i,length(dataformat^));

          if (Pos('.',s)<> 0)
          then begin //Inicia LinkExecAction
                 While (dataformat^[i] in ['_','a'..'z','A'..'Z','0'..'9']) and
                        (dataformat^[i] <> '.')
                        and (not (dataformat^[i] in Delimiters))
                        and (i <= length(dataformat^))
                 do
                 begin
                   aFieldName := aFieldName + dataformat^[i];
                   Inc(i);
                 end;

                 With Rex^ do
                  LinkExecAction := FieldByName(aFieldName);
                 Inc(i);
               end;

          While (i <= length(dataformat^)) and
                (dataformat^[i] in ['_','a'..'z','A'..'Z','0'..'9'])
                and (not (dataformat^[i] in Delimiters))
          do begin
               Result := Result + dataformat^[i];
               Inc(i);
             end;
        End;

        function Get_Alias:AnsiString;
        begin
          result := '';
          Inc(i);
          While (not (dataformat^[i] in Delimiters))
                and (i <= length(dataformat^))
          do begin
                Result := Result + dataformat^[i];
                Inc(i);
             end;
        end;

        function GetFormatoDateTime: AnsiString;
        begin
          result := '';
          Inc(i);
          While (i <= length(dataformat^))
                and (dataformat^[i] in ['d','m','y','h','n','s','z','/','-',' ',':']) //Cara
          do begin
                Result := Result + dataformat^[i];
                Inc(i);
             end;
        end;

        Procedure GetHints;
        begin
          if dataformat^[i] <> CharHint
          then exit;
          inc(i);
          if dataformat^[i] in ['0','1']
          then begin
                 case dataformat^[i] of
                   '0' : begin //Porque
                           While (not (dataformat^[i] in Delimiters)) and (i <= LenDataformat) do
                           begin
                             inc(i);
                             Rex^.HelpCtx_Porque := Rex^.HelpCtx_Porque+ dataformat^[i];
                           end;
//                           writeLn(Rex^.HelpCtx_Porque);
                         end;
                   '1' : begin //Onde
                           While (not (dataformat^[i] in Delimiters)) and (i <= LenDataformat) do
                           begin
                             inc(i);
                             Rex^.HelpCtx_Onde := Rex^.HelpCtx_Onde+ dataformat^[i];
                           end;
//                           writeLn(Rex^.HelpCtx_Onde);
                         end;
                 end;
               end
          else begin //hint
                  While (not (dataformat^[i] in Delimiters)) and (i <= LenDataformat) do
                  begin
                    Rex^.HelpCtx_hint := Rex^.HelpCtx_hint+ dataformat^[i];
                    inc(i);
                  end;
                 // writeLn(Rex^.HelpCtx_hint);
               end;

        end;

        Procedure GetDefault;
        begin
          if dataformat^[i] <> CharDefault
          then exit;

          inc(i);
          While (not (dataformat^[i] in Delimiters)) and (i <= LenDataformat) do
          begin
            Rex^.Default := Rex^.Default+ dataformat^[i];
            inc(i);
          end;
        end;

      begin
        setFlags(false);
        DoDecimal    := 0;
        i            := 1;

        LenDataformat := length(dataformat^);
//        LenDataformat := length(AnsiString_to_USASCII(dataformat^));

        if ShouldSaveTemplate and (TableName<>'')
        Then SaveTemplate(TableName+'.lfm_mi',dataformat^);

        While (i <= LenDataformat) do
        begin
          C := upcase(dataformat^[i]);
          with TUiMethods do
          Case C of
            //ChTest : begin //Usado para saber se o código é válido.
            //           writeLn(ord(chTest));
            //         end;
            CharDefault : begin
                            GetDefault;
                            continue;
                          end;
            FldBoolean :  With Rex^ do
                          begin
                            alias := 'FldBoolean';
                            templx(#0,dataformat^[i]);
                            If upcase(C) <> fldShortInt
                            then C := upcase(C);

                            TypeCode  := dataformat^[i];
                            Inc(TrueLen);
                            FieldSize := sizeof(BYTE);
                            FillValue := #0;
                            Alias := Get_Alias;
                            Rex.ShownWid := + Rex.ShownWid + Length(alias);
                            getHints;
                            continue;
                          end;

            FldRadioButton : //With Rex^ do
                             begin
                                Rex^.TypeCode  := dataformat^[i];
                                Rex^.FieldSize := Sizeof(byte);

                                Inc(i);
                                j := ord(dataformat^[i]);
                                If (ClusterTemps[j].fnum = 0)
                                then begin
                                       ClusterTemps[j].fnum := succ(TotalFields);
                                       ClusterTemps[j].ofs  := RecordSize;
                                     end
                                else begin
                                       Inc(ClusterTemps[j].value);
                                       Rex^.Fieldnum := ClusterTemps[j].fnum;
                                       Rex^.Decimals := ClusterTemps[j].value;
                                       Rex^.DataTab  := ClusterTemps[j].ofs;
                                       //NoFieldNum    := TRUE;
                                       //NoFieldAdv    := TRUE;
                                       //SameFieldNum  := true;
                                       SetFlags(true);
                                     end;
                                Rex^.Fieldnum := ClusterTemps[j].fnum;

                                templx(#0,dataformat^[i]);
                                Inc(Rex^.TrueLen);
                                Rex^.Alias := Get_Alias;
                                Rex^.ShownWid := + Rex^.ShownWid + Length(Rex^.alias);
                                GetHints;
                                continue;
                             end;
            fldStr,
            fldStrNumber       : With Rex^ do
                              begin
                                templx(#0,dataformat^[i]);
                                TypeCode := dataformat^[i];
                                Inc(TrueLen);
                                If FieldSize > 0
                                then Inc(FieldSize)
                                else begin
                                       FieldSize :=  2;
                                       FillValue := ' ';
                                     end;
                              end;

            CharListComboBox  : Begin //O campo corrente possue uma lista de opções.
                                  Move(dataformat^[succ(i)], TS, sizeof(TS));
                                  rex^.ListComboBox := TS;
                                  Inc(i,sizeof(TS));
                                  //GetHints;
                                  //continue;
                                end;

            fldAnsiChar,
            fldAnsiCharAlfa,
            fldAnsiCharNum,
            fldAnsiCharNumPositive  :
                              With Rex^ do
                              begin
                                If (DoDecimal > 0)
                                then begin
                                       //templx    := templx + #1;
                                       templx(#1,dataformat^[i]);
                                       Inc(DoDecimal);
                                     end
                                else templx(#0,dataformat^[i]);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                Inc(FieldSize);
                                FillValue := ' ';
                              end;

            fldByte,
            fldShortInt   :  With Rex^ do
                              Begin
                                templx(#0,dataformat^[i]);

                                If upcase(C) <> fldShortInt
                                then C := upcase(C);

                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);

                                FieldSize := sizeof(BYTE);
                                FillValue := #0;

                              end;

            {< 'Z' }
            fldZEROMOD   :    With Rex^ do
                              begin
                                If (TypeCode = #0) or (TypeCode = fldDouble)
                                then Inc(FieldSize);

                                templx(#1,dataformat^[i]);
                                Inc(TrueLen);

                                If DoDecimal > 0
                                then Inc(DoDecimal);
                              end;


            fldSmallWord :    With Rex^ do
                              begin
                                templx(#0,dataformat^[i]);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                FieldSize := sizeof(SmallWord);
                                FillValue := #0;
                              end;

            FldSmallInt  :  With Rex^ do
                              begin
                                templx(#0,dataformat^[i]);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                FieldSize := sizeof(SmallInt);
                                FillValue := #0;
                              end;


            fldLongInt  : With Rex^ do
                          begin
                            templx(#0,dataformat^[i]);
                            TypeCode  := dataformat^[i];
                            Inc(TrueLen);
                            FieldSize := sizeof(LONGINT);
                            FillValue := #0;
                          end;

            FldDateTime : With Rex^ do
                          begin
                            templx(#0,dataformat^[i]);
                            TypeCode  := dataformat^[i];
                            FieldSize := sizeof(TDateTime);
                            FillValue := #0;
                            //Identifica o tipo de formato de dados do template.
                            //
                            temp1 := GetFormatoDateTime;
                            temp2 := temp1;
                            Inc(TrueLen,length(temp1));
                            FillChar(temp1[1],length(temp1),#0);
                            templx(temp1,temp2);
                            continue;
                          end;


            fldHexValue :     With Rex^ do
                              begin
                                templx(#0,dataformat^[i]);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                FieldSize := succ(TrueLen) shr 1;
                                FillValue := #0;
                              end;

            fldDouble,
            fldDoublePositive: With Rex^ do
                                  begin
                                    templx(#0,dataformat^[i]);
                                    TypeCode  := dataformat^[i];
                                    Inc(TrueLen);
                                    FieldSize := sizeof(TRealNum);
                                    FillValue := #0;
                                    If DoDecimal > 0
                                    then Inc(DoDecimal);
                                  end;

            fldExtended : With Rex^ do
                          begin
                            templx(#0,dataformat^[i]);
                            TypeCode  := dataformat^[i];
                            Inc(TrueLen);
                            FieldSize := sizeof(Extended);
                            FillValue := #0;
                            If DoDecimal > 0
                            then Inc(DoDecimal);
                          end;
            fldReal4,
            fldReal4Positivo,
            fldReal4P,
            fldReal4PPositivo
                        : With Rex^ do
                          begin
                            templx(#0,dataformat^[i]);
                            TypeCode  := dataformat^[i];
                            Inc(TrueLen);
                            FieldSize := sizeof(real);
                            FillValue := #0;
                            If DoDecimal > 0
                            then Inc(DoDecimal);
                          end;

            fldENum :
            begin

              If (templx <> '')
              then NewRecord;
              if dataformat^[i] = fldENUM
              Then begin
                     DmxStr_ID := Copy(dataformat^,i,EnumField_ofs.Default+sizeof(TEnumField.Default));
                     Rex^.DataSource := nil;
                     Rex^.KeyField   := 'id';
                     Rex^.ListField  := 'descricao';
                   end
              else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada ao método CreateStruct inválida.');

              Inc(i, Length(DmxStr_ID));
              Move(DmxStr_ID[EnumField_ofs.Items],Rex^.Template,sizeof(Rex^.Template));

              Rex^.TypeCode  := fldENUM;
              if Assigned(Rex^.Template)
              then Rex^.TrueLen := MaxItemStrLen(PSItem(Rex^.Template));

              Rex.FieldSize := sizeof(Longint);
              Rex^.FillValue  := #0;

              If DmxStr_ID[EnumField_ofs.ShowZ]  = '0' //NortSoft Free Vision
              Then Rex^.ShowZeroes      := false
              else Rex^.ShowZeroes      := True;

              Rex^.access               := byte(DmxStr_ID[EnumField_ofs.AccMode]);
              move(DmxStr_ID[EnumField_ofs.Default],Rex^.ListComboBox_Default,Sizeof(TEnumField.Default));

              WFieldName := '';

              //Procura o nome do campo enumerado.

              for j := i to length(dataformat^) do
              begin
                inc(i);
                case dataformat^[j] of
                  CharFieldName : begin //Achou nome do campo.
                                  i := j;
                                  WFieldName := trim(GetFieldName);
                                  break //Sai do laço for j
                                End;
                end;
              end;
              GetHints;
              Rex^.FldEnum_Lookup := TFldEnum_Lookup.create(Rex);

              if Rex^.template_org = ''
              then Rex^.template_org := 'LLLLLL';

              NewRecord;
              continue;
            end;

            fldENUM_Db: begin

                          If (templx <> '')
                          then NewRecord;
                          if dataformat^[i] = fldENUM_db
                          Then begin
                            DmxStr_ID := Copy(dataformat^,i,EnumField_ofs.ListField+sizeof(TEnumField.ListField));
                            move(DmxStr_ID[EnumField_ofs.DataSource],Rex^.DataSource,Sizeof(TEnumField.DataSource));
                            move(DmxStr_ID[EnumField_ofs.KeyField],Rex^.KeyField,Sizeof(TEnumField.KeyField));
                            move(DmxStr_ID[EnumField_ofs.ListField],Rex^.ListField,Sizeof(TEnumField.ListField));
                          end
                          else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada ao método CreateStruct inválida.');


                          Inc(i, Length(DmxStr_ID));
                          Move(DmxStr_ID[EnumField_ofs.Items],Rex^.Template,sizeof(Rex^.Template));

                          Rex^.TypeCode  := fldENUM_db;
                          if Assigned(Rex^.Template)
                          then Rex^.TrueLen := MaxItemStrLen(PSItem(Rex^.Template));

                          Rex.FieldSize := sizeof(Longint);
                          Rex^.FillValue  := #0;

                          If DmxStr_ID[EnumField_ofs.ShowZ]  = '0' //NortSoft Free Vision
                          Then Rex^.ShowZeroes      := false
                          else Rex^.ShowZeroes      := True;

                          Rex^.access               := byte(DmxStr_ID[EnumField_ofs.AccMode]);
                          move(DmxStr_ID[EnumField_ofs.Default],Rex^.ListComboBox_Default,Sizeof(TEnumField.Default));

                          WFieldName := '';

                          //Procura o nome do campo enumerado.

                          for j := i to length(dataformat^) do
                          begin
                            inc(i);
                            case dataformat^[j] of
                              CharFieldName : begin //Achou nome do campo.
                                              i := j;
                                              WFieldName := trim(GetFieldName);
                                              break //Sai do laço for j
                                            End;
                            end;
                          end;
                          GetHints;

                          if (DataSource<>nil)
                          then begin
                                 Rex^.FldEnum_Lookup := TFldEnum_Lookup.create(Rex);
                               end;

                          NewRecord;
                          continue;
                        end;

            fldBLOB  :        begin
                                If (templx <> '')
                                then NewRecord;

                                Rex.TypeCode    := fldBLOB;
                                Move(dataformat^[i+1] , Rex.FieldSize, sizeof(Rex.FieldSize));
                                {$IFDEF CPU32}
                                  Rex.access    := byte(dataformat^[i+6]) or accHidden;
                                  Rex.FillValue := dataformat^[i+7];
                                {$ENDIF}
                                {$IFDEF CPU64}
                                  Rex.access    := byte(dataformat^[i+6+4]) or accHidden;
                                  Rex.FillValue := dataformat^[i+7+4];
                                {$ENDIF}

                                Inc(i, sizeof(TDmxStr_ID) - 2);

                                NewRecord;
                              end;


            fldAPPEND  :      begin
                                If (templx <> '')
                                then NewRecord;

                                Move(dataformat^[succ(i)], df, sizeof(df));
                                TranslateStruct(df);
                                Inc(i, sizeof(TDmxStr_ID) - 2);
                              end;

            { NortSoft
                Informa o nome do campo no Template
                Sintaxe: ~Nome do produto: ~ SSSSSSSSSSSSSSSS^BNome_do_Produto+#0
                Nota:
                  O nome do campo é passado após ^B e o mesmo não pode conter espaço em branco.
            }
            CharFieldName : Begin
                              WFieldName := trim(GetFieldName);
                              continue;
                            end;

            CharShowPassword : begin {<NortSoft}
                                 Rex^.CharShowPassword := dataformat^[i];
                               end;

            fldSItems    :    begin
                                If (templx <> '')
                                then NewRecord;

                                Move(dataformat^[succ(i)], TS, sizeof(TS));

                                While (TS <> nil) do
                                begin
                                    If (TS.Value <> nil)
                                    then TranslateStruct(TS.Value);
                                    TS := TS.Next;
                                end;

//                                Inc(i, sizeof(TDmxStr_ID) - 2);
                                Inc(i, 9-1);
                              end;

            ThousandSeparator : begin
                                  With Rex^ do
                                    if TObjectsMethods.IsNumber(TypeCode)
                                    then templx(ShowThousandSeparator,ShowThousandSeparator)
                                    else templx(dataformat^[i],dataformat^[i]);
                                end;

            CloseParenthesis,{')'}
            DecimalSeparator //'.'
                            :
                              With Rex^ do
                              begin
                                if (c = CloseParenthesis) or (Not TObjectsMethods.IsNumber(TypeCode))
                                Then templx(C,dataformat^[i])
                                else templx(ShowDecimalSeparator,ShowDecimalSeparator);

                                If (upcase(Rex.TypeCode) = fldDouble)
                                then begin
                                       If (C = CloseParenthesis {')'})
                                          then Inc(TrueLen);  {<?????}

                                       Inc(FieldSize);
                                     end;

                                If (C = DecimalSeparator)
                                then begin
                                       If (upcase(TypeCode) = fldDouble) or
                                          (upcase(TypeCode) = fldDouble) or
                                          (upcase(TypeCode) = fldExtended) or
                                          (upcase(TypeCode) = fldReal4) or
                                          (upcase(TypeCode) = fldReal4P) or
                                          (upcase(TypeCode) = fldReal4Positivo) or
                                          (upcase(TypeCode) = fldReal4PPositivo)
                                       then DoDecimal := 1;
                                     end
                                else Parenthesis := TRUE;
                              end;

            CharExecAction :  begin
                                with Rex^ do
                                  ExecAction := GetExecAction;
                                continue;
                              end;

            {'~'}
            CharDelimiter_3 : begin

                                If (templx <> '')
                                then NewRecord;
                                Rex^.alias := '~';
                                C := ' ';

                                templx(C,dataformat^[i]);

                                Inc(i);
                                While (dataformat^[i] <> CharDelimiter_3{'~'}) and (i < LenDataformat) do
                                begin
                                  C := dataformat^[i];

                                  If C = AnsiChar(accNormal)
                                  then C := ' ';

                                  //If C = #1 then C := #2;
                                  If C = AnsiChar(accReadOnly)
                                  then C := AnsiChar(accHidden);


                                  templx(C,dataformat^[i]);
                                  Inc(i);
                                  //if ord(c) <=127
                                  //then Inc(i)
                                  //else i := i+2;
                                end;
                                C := ' ';

                                templx(C,dataformat^[i]);

                                //==========================================================================================================
                                {$REGION ' ---> Tarefa: Permitir que o label torne-se invisível'}
                                //==========================================================================================================

                                if (length(dataformat^) > i)
                                   and (
                                          (dataformat^[i+1] = CharAccHidden) {^H}
                                          //or  (dataformat^[i+1] = AnsiChar(accHidden))
                                       )
                                then begin
                                       if Rex<>nil
                                       Then begin
                                              Rex.access    := Rex.access or accHidden;
                                            end;
                                     end;

                                {$ENDREGION}
                                //==========================================================================================================


                              end;

            CharDelimiter_0,  {#0}
            CharDelimiter_1{'\'} :
                              begin
                                If (templx <> '')
                                then NewRecord;


                                If C <> CharDelimiter_0{#0}
                                then begin
                                       //If C = '|'
                                       //then C := '|'else
                                       If C = CharDelimiter_1{'\'}
                                       then C := ' ';

                                       Rex.access    := Rex.access or accDelimiter;
                                       Rex.TypeCode  := C;
                                       NewRecord;
                                     end;
                              end;

            {^A}
            CharAllZeroes   : begin
                                AllZeroes       := not AllZeroes;
                                Rex^.ShowZeroes := AllZeroes;
                                Rex.Alias:='CharAllZeroes';

                              end;

            CharAccHidden {^H}  : Begin
                                    Rex^.SetAccess(accHidden);
                                   End;

            {^P}
            CharProviderFlag  : begin
                                  With Rex^ do
                                  begin
                                    FieldName := WFieldName;
                                    inc(i);
                                    //val(dataformat^[i],flag,err);
                                    flag := StrToInt(dataformat^[i]);
                                    case flag  of
                                      0 : begin
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfInUpdate];
                                          End;
                                      1 : Begin
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfInWhere];
                                          End;

                                      2 : Begin
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfInKey];
                                          End;

                                      3 : Begin
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfHidden];
                                          End;

                                      4 : Begin
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfRefreshOnInsert];
                                          End;

                                      5 : Begin
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfRefreshOnUpdate];
                                          End;

                                      6 : Begin //Chave primária
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfInKeyPrimary,pfInKey];

                                            if keysPrimaryKeyComposite = ''
                                            then keysPrimaryKeyComposite := FieldName
                                            else keysPrimaryKeyComposite := keysPrimaryKeyComposite + ';'+FieldName;
                                          End;

                                      7 : Begin //Chave primária auto incremental
                                            Rex^.ProviderFlags := Rex^.ProviderFlags + [pfInKeyPrimary,pfInKey,pfInAutoIncrement];
                                            keysPrimaryKeyComposite := FieldName;
                                            flagPrimaryKey_AutoIncrement := true;
                                          End;

                                    End;


                                  End;
                                 end;

            {^F}
            CharForeignKey  : begin
                                With Rex^ do
                                begin
                                  FieldName := WFieldName;
                                  inc(i);
                                  //val(dataformat^[i],flag,err);
                                  flag := StrToInt(dataformat^[i]);

                                  KeyForeign := '';
                                  //Seleciona os parâmetros de CharForeignKey
                                  While (not (dataformat^[i] in Delimiters)) and (i < LenDataformat) do
                                  begin
                                    inc(i);
                                    KeyForeign := KeyForeign+ dataformat^[i];
                                  end;

                                  case flag  of
                                    0 : begin
                                          Rex^.ForeignKey := Fk_No_Action;
                                        End;

                                    1 : Begin
                                          Rex^.ForeignKey := Fk_Restrict;
                                        End;

                                    2 : Begin
                                          Rex^.ForeignKey := Fk_Cascade;
                                        End;

                                    3 : Begin
                                          Rex^.ForeignKey := Fk_Set_Null;
                                        End;

                                    4 : Begin
                                          Rex^.ForeignKey := Fk_Set_Default;
                                        End;

                                  End;


                                End;

                             end;

            //^P      :       With Rex^ do
            //                  begin
            //                    Inc(i);
            //                    RecordSize := RecordSize + shortint(dataformat^[i]);
            //                  end;

            {^R}
            CharAccReadOnly : Begin
                                Rex^.SetAccess(accReadOnly);
//                                With Rex^ do access := access or accReadOnly;
                              end;
            {^S}
            CharAccSkip:     Begin
                               Rex^.SetAccess(accSkip);
//                                With Rex^ do access := access or accSkip;
                              end;

            {^U}
            CharUpperlimit    : With Rex^ do
                                begin
                                  Inc(i);
                                  UpperLimit := byte(dataformat^[i]);
                                end;


            {^V}
            CharFillvalue   : With Rex^ do
                              begin
                                Inc(i);
                                FillValue := dataformat^[i];
                              end;

            CharShowzeroes{^Z}  : Rex^.ShowZeroes := TRUE;

            fldCONTRACTION:   With Rex^
                                do ShownWid := length(AnsiString_to_USASCII(templx));

            CharHint   : begin
                           GetHints;
                           Continue;
                         end;
            else begin
                   templx(dataformat^[i],dataformat^[i]);
                 end;
          end;  {< case of C }

          Inc(i);
        end; {<While (i <= length(dataformat^)) do}

//        writeln(' ');
      end; {<procedure TranslateStruct(dataformat: ptString);}

      var wState : Boolean;
    begin
      If (@ATemplate = nil)
      then Exit;

      try
        wState := SetState(Mb_St_Creating_Template,true);
        AllZeroes      := FALSE;
        templx('');
        New(Rex);
        FillChar(Rex^, sizeof(Rex^), 0);
        Rex.Next       := nil;
        Rex.Prev       := nil;
        Rex.ShowZeroes := AllZeroes;
        X              := nil;
        If DMXField1 = nil
        then DMXField1 := Rex
        else begin
               X := DMXField1;
               While X.Next <> nil do X := X.Next;
               X.Next := Rex;
               Rex.Prev := X;
             end;
        TranslateStruct(@ATemplate);
//      SameFieldNum := FALSE;
        If templx <> ''
        then NewRecord;
        If (Rex = DMXField1)
        then DMXField1 := nil;
        Dispose(Rex);
        If (X <> nil)
        then X.Next := nil;
        If DMXField1 <> nil
        then DMXField1.Prev := X;
      Finally
        SetState(Mb_St_Creating_Template,wState);
      End;
    end;

    procedure TUiDmxScroller.CreateStruct(var ATemplate: PSItem);
      Var s :TString;
    begin
      Move(ATemplate, s[1],sizeof(ATemplate));
      s[0] := chr(sizeof(ATemplate));
      CreateStruct(s);
    end;

    procedure TUiDmxScroller.CreateStruct;
      Var L : Longint;
          Template : PSItem;
      var wState : Boolean;
    begin
      if not GetState(Mb_St_Creating)
      then raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada ao método CreateStruct inválida.');

      try
        wState := SetState(Mb_St_Creating_Template,true);
        Template := GetTemplate(nil);
        if Template<> nil
        then begin
               Fields := TFields.Create;
               FillChar(ClusterTemps, sizeof(ClusterTemps), 0);
               CreateValid   := TRUE;
               Limit.X       := 0;
               CreateStruct(Template);
               If (RecordSize > 0)
               then begin
                      CreateData;
                      L := RecordSize;
                      L := DataBlockSize div L;
                      SetLimit(Limit.X, L);
                    end;
               LeftField := DMXField1;
               DisposeSItems(Template);

               if (DataSource<>nil) and  (DataSource.DataSet=nil)
               then DataSource.DataSet := BufDataset;

             end;

      finally
        SetState(Mb_St_Creating_Template,wState);
      end;
    end;

    procedure TUiDmxScroller.DestroyStruct;
       var  P : pDmxFieldRec;
    begin
      Try
        While (DMXField1 <> nil) do
        begin
          If DMXField1.Template <> nil
          then begin
                 If upcase(DMXField1.TypeCode) in [fldENum,fldENum_db,fldSItems] //<NortSoft
                 then Begin
                         DisposeSItems(PSItem(DMXField1.Template ));
                         PSItem(DMXField1.Template ) := nil;
                      End
                 else DisposeStr(DMXField1.Template);
               end;
          P := DMXField1.Next;
          Dispose(DMXField1);
          DMXField1 := P;
        end;

      Finally
        LeftField     := nil;
        DMXField1     := nil;//<  Caso ocorra um excessao a destruir estrutura
      End;
    end;

    procedure TUiDmxScroller.CreateBufDataset_FieldDefs;
    begin
      {abstract}
    end;

    procedure TUiDmxScroller.CreateData;
    begin
      if not GetState(Mb_St_Creating)
      then raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada ao método CreateData inválida.');

      if (RecordSize > 0) and (WorkingData=nil)
      then begin
             FGetMem(WorkingData,RecordSize);
             FGetMem(WorkingDataOld,RecordSize);
//             writeLn('New(WorkingData) = ',MemSize(WorkingData),' bytes'); // esse tamanho depende di tamanho do registro
             CreateBufDataset_FieldDefs;
           end;
    end;

    procedure TUiDmxScroller.DestroyData;
    begin
      If (WorkingData <> nil) and (RecordSize > 0)
      then begin
             fFreeMem(WorkingData, RecordSize);
             fFreeMem(WorkingDataOld, RecordSize);
             WorkingDataOld:= nil;
             WorkingData := nil;

             DataBlockSize := 0;
             RecordSize  := 0;;
             FieldData := nil;

             CurrentField:= nil;
             CurrentField  :=nil;
             CurrentRecord := 0;
             FieldData     := nil;
             Limit.X := 0;
             DataBlockSize := 0;
             RecordSize := 0;
             freeandnil(Fields);

             if Assigned(_BufDataset) and (_BufDataset.Owner = self)
             then FreeandNil(_BufDataset) ;

             if (_DataSource <>nil) and (_DataSource.Owner = self)
             then FreeandNil(_DataSource) ;

           end;
      _Strings.Clear;
    end;

    function TUiDmxScroller.GetRecordData: Pointer;
    begin
      Result := WorkingData;
    end;

    procedure TUiDmxScroller.SetLimit(X, Y: Integer);
    begin
      Limit.X := X;
      Limit.Y := Y;
    end;

    //function TUiDmxScroller.GetTemplate(aNext: PSItem): PSItem;
    //begin
    //  result := nil;
    //end;

    procedure TUiDmxScroller.SetActive(aActive: Boolean);
    begin
      _Active := aActive;
      if _active
      then SetState(Mb_St_Active,true)
      else SetState(Mb_St_Active,false);
    end;

    function TUiDmxScroller.PutString(const OkSpc: Boolean; const S: tString): SmallInt;
    Begin
      TaStatus := 0;
      If CurrentField <> nil
      Then begin
             With CurrentField^ do
             Try
               CurrentField^.OkSpc := OkSpc;
               SetAsString(S);
             Finally
               CurrentField^.OkSpc := CurrentField^._OkSpcAnt;
             End;
      end
      else raise TException.Create(self,{$I %CURRENTROUTINE%},ParametroInvalido);
      result := TaStatus ;
    End;

    function TUiDmxScroller.PutString(const aFieldName: tString; S: ShortString): SmallInt;
      Var
        I : SmallInt;
        w_CurrentField,W_FieldData : Pointer;
    Begin
      result := 0;
      Try
        w_CurrentField := CurrentField;
        W_FieldData    := FieldData;

        For i := 0 to pred(Fields.Count) do
        Begin
          CurrentField := Fields[i];
          While (CurrentField <> nil) do
          Begin
            If (CurrentField.Fieldnum > 0) and (CurrentField.FieldName = aFieldName)
            Then  Begin
                    FieldData := GetRecordData;
                    FieldData := FieldData+CurrentField^.DataTab;
                    PutString(S);
                    exit;
                  end;
            CurrentField := CurrentField^.Next;
          End;
        End;

      Finally
        CurrentField := w_CurrentField;
        FieldData    := W_FieldData;
      end;
    End;

    function TUiDmxScroller.GetString(const aFieldName: tString): AnsiString;
      Var
        I : SmallInt;
        w_CurrentField,W_FieldData : Pointer;
    Begin
      Try
        w_CurrentField := CurrentField;
        W_FieldData    := FieldData;

        For i := 0 to pred(Fields.Count) do
        Begin
          CurrentField := Fields[i];
          While (CurrentField <> nil) do
          Begin
            If (CurrentField.Fieldnum > 0) and (CurrentField.FieldName = aFieldName)
            Then  Begin
                    FieldData := GetRecordData;
                    FieldData := FieldData+CurrentField^.DataTab;
                    Result    := GetString;
                    exit;
                  end;
            CurrentField := CurrentField^.Next;
          End;
        End;

      Finally
        CurrentField := w_CurrentField;
        FieldData    := W_FieldData;
      end;
    End;

    function TUiDmxScroller.GetString(const OkSpc: Boolean): TString;
    begin
      TaStatus := 0;
      If CurrentField <> nil
      Then begin
             With CurrentField^ do
             Try
               CurrentField^.OkSpc := OkSpc;
               result := AsString;
             Finally
               CurrentField^.OkSpc := CurrentField^._OkSpcAnt;
             End;
      end
      else raise TException.Create(self,{$I %CURRENTROUTINE%},ParametroInvalido);
    end;

    function TUiDmxScroller.GetString: TString;
    begin
      result := getString(false);
    end;

    function TUiDmxScroller.PutString(const S: ShortString): SmallInt;
    Begin
      Result := PutString(False,S);
    end;

    procedure TUiDmxScroller.SetAlignmentLabels(aAlignmentLabels: TAlignment);
    begin
      _AlignmentLabels := aAlignmentLabels;
    end;

    function TUiDmxScroller.Get_MaskEdit_LCL(aTemplate: AnsiString;
                                             aSpaceChar: AnsiChar;
                                             out Size_TypeFld,
                                                 aLength_Buffer: SmallWord;
                                             out aOkMask: Boolean): AnsiString;
      //Help lazarus
      // FormtFloat: http://www2.pelotas.ifsul.edu.br/npeil/funformatfloat.htm
      //https://wiki.freepascal.org/TMaskEdit
      // Documentação em: https://wiki.freepascal.org/TMaskEdit
      //O EditMask consiste em 3 campos, cada um separado pelo caractere MaskFieldSeparator
      //(por padrão um ponto e vírgula (';')).
      //    Campo          Tipo	       Significado	                                           Obrigatório
      //1 = Máscara real   string      O padrão real ao qual o texto deve se ajustar	           Sim
      //2 = MáscaraSalvar  Caracteres  Controla se a propriedade Text contém os literais
      //                               na máscara real. Um valor diferente de '0' significa
      //                               que literais serão incluídos.	                           Não
      //3 = EspaçoChar	    Caracteres O caractere mostrado no TMaskEdit quando deixado em branco. Não
      //                               O padrão é '_'

      Var
        I : Byte;
        aTypeFld    : AnsiChar;
        OKSeparador : boolean = false;
        s           : AnsiString;

    Begin
      result := '';
      aOkMask := false;
//      OKSeparador := false;
      aLength_Buffer := 0;
      aTypeFld    := TypeFld(aTemplate,Size_TypeFld);
      If aTypeFld  in [FldDateTime]
      Then  Begin
              aOkMask := true;
              s :=TDates.MaskDateTime_to_MaskEdit(copy(aTemplate,2,length(aTemplate)-1));
              if s<>''
              Then begin
                     Result := '!'+s+';1;'+aSpaceChar;
                   end
              else raise TException.create(self,{$I %CURRENTROUTINE%},'Mascara datetime inválida!');;
              aLength_Buffer := Length(aTemplate);
              exit;
            end
      Else
      For i := 1 to length(aTemplate) do
      Begin
        case aTemplate[i] of
          fldStr          ,//    'S';  // string Field
          fldAnsiChar         ://    'C';  // AnsiCharacter Field
           Begin
             aOkMask := true;
             Result := Result + '>c';
  //           oKMaiuscula := true;
             aLength_Buffer := aLength_Buffer + 1;
           End;

          fldAnsiCharAlfa,   //  'c';  // AnsiCharacter Field
          fldStrAlfa       : //  's'   // Minusculo e maiusculo
          begin
             Result := Result + '<c';
             aLength_Buffer := aLength_Buffer + 1;
          end;

          'z',
          fldZEROMOD      ,//   'Z';  { zero modifier }
          fldHexValue     ,//   'H';  { hexadecimal numeric entry }
          fldStrNumber       ,//   '#';  { numeric string Field }
          fldAnsiCharNumPositive  ,//   '0';  { numeric AnsiCharacter Field }
          fldAnsiCharNum      ,//   'N';  { dbase formatted numeric Field }
          fldByte         ,//   'B';  { número byte sizeof = 1}
          fldShortInt     ,//   'J';  { número shortint sizeof = 1}
          fldSmallWord    ,//   'W';  { número SmallWord sizeof = 2 aceita só positivos}
          fldSmallInt     ,//   'I';  { número SmallInt sizeof = 2 aceita só positivos e negativos}
          fldLongInt      ://   'L';  { número longint aceita positivos e negativos}
          Begin
            aOkMask := true;
            Result := Result + '#'; //0..9, + ,  -
            aLength_Buffer := aLength_Buffer + 1;
          end;

          fldExtended        ,// 'E'; {Número real com sizeof = 10 bytes. Aceita positivos e negativos}

          fldReal4           ,// 'O'; {Número Real sizeof = 4 Byte. Aceita positivos e negativos }
          fldReal4Positivo   ,// 'o'; {Número Real sizeof = 4 Byte. Aceita só positivos}

          fldReal4P          ,// 'P'; {Número Real sizeof = 4 Byte. Ao entrar no campo o mesmo é por 100 e ao sair o mesmo é dividido por 100 aceita positivos e negativos}
          fldReal4PPositivo  ,// 'p'; {Número Real sizeof = 4 Ao entrar no campo o mesmo é por 100 e ao sair o mesmo é dividido por 100 aceita positivos e negativos}

          fldDouble         ,// 'R'; {Número real sizeof = 8 positivos e negativos}
          fldDoublePositive:// 'r'; {Número real sizeof = 8 positivo  }

          Begin
            Result := Result + '#';
            aLength_Buffer := aLength_Buffer + 1;
          end;

          FldRadioButton,      //  'k'; tipo de dado e string.
          fldENUM,             //  { enumerated Field com dados em memória}
          fldENUM_db         : //  { enumerated Field com acesso tabela relacionada }
          Begin
            Result := Result + '9';
            aLength_Buffer := aLength_Buffer + 1;
          end;


          fldLHora           ,// #2 ;  { #2 = Longint;Guarda a hora compactada  ##:##:##}
          fld_LHora          :// 'h';  { h = Longint;Guarda a hora compactada   hh:hh:hh}
          Begin
            Result := Result + '0';
            aLength_Buffer := aLength_Buffer + 1;
          end;

          ' '  : Result := Result + aSpaceChar;//'_';
          '~'  : begin end;


          Else If IsNumberReal(aTypeFld)
               Then Begin
                      If aTemplate[i] in [DecimalSeparator ,ThousandSeparator]
                      Then Result := Result + aTemplate[i];
                      OKSeparador := true;

  {Caso coloque os caracteres abaixo na mascara o Delphi não reconhecerá como número.
                      If (aTypeFld in [fldExtended,fldReal4,fldReal4P,fldDouble,fldDoublePositive,fldReal4Positivo,fldReal4PPositivo])
                          and (aTemplate[i] in [' ','%','$'])
                      Then Result := Result + aTemplate[i];
  }
                    end
               Else begin
                      if not aOkMask
                      then aOkMask := true;
                      OKSeparador := true;

                      if not (aTemplate[i] in [' '])
                      then Result := Result + aTemplate[i];
                    end;

          //FldBoolean          =   'X';  { boolean value Field }
          //fldBLOb             =   ^M;   { unformatted data Field }
          //FldOperador = #3; { #3 = Byte indica que o campo  um operador matemático}
          //FldMemo  = 'M';
          //CharShowPassword  = ^W;  { Usado para omitir da os caracteres que estão sendo digitados em qualquer tipo de campo}
          //CharExecAction   = ^T;  { O Ponteiro para um procedimento}
          //fldCONTRACTION      =   '`';  { limit of visible text }
          //fldAPPEND           =   ^G;   { append from pointer }
          //fldSItems           =   ^I;   { link to chain of TSItem Templates }
          //fldXSPACES          =   ' ';  { spaces --extended code follows <Esc> }
          //fldXTABTO           =   ^I;   { tab    --extended code follows <Esc> }
          //fldXFieldNUM        =   ^F;   { fnum   --extended code follows <Esc> }
          //

        end;
      end;

  //    If oKMaiuscula
  //    Then Result := '>'+Result;


      If IsNumber(aTypeFld)
      Then begin
             //Comentei essa linha abaixo pq o result só deve ser usado como FormatDisplay e não como editMask

             //if pos(ShowDecimalSeparator ,Result)<>0
             //then begin
             //       Result := copy(Result,1,pos(ShowDecimalSeparator ,Result)-2)+
             //                 Change_AnsiChar(Copy(Result,pos(ShowDecimalSeparator ,Result)-1,length(result)),'#','9');
             //
             //     end
             //else begin
             //       Result[length(Result)] := '0' ;
             //     end;
//             result := Result+
//                     ';'+
////                     SaveMaskChar+
//                     '0'+ // O= não salva a mascara no resultado
////                     '1'+ //1= salvar a mascara no resultado.
//                     ';'+aSpaceChar; // Escreva o caractere _ ao inves de brancos.
           end
      Else begin
             if aOkMask
             then begin
                    if IsNumber(aTypeFld)
                    then begin
                           Result[length(Result)] := '0' ;
                         end;
                    Result := Result+
                     ';'+
                     SaveMaskChar+
                     ';'+aSpaceChar; // Escreva o caractere _ ao inves de brancos.
                  end
             else Result := '';
           end;
    end;

    function TUiDmxScroller.Get_MaskEdit_LCL(aTemplate: AnsiString;aSpaceChar:Ansichar;out aOkMask: Boolean): AnsiString;

       Var Size_TypeFld,
           aLength_Buffer : SmallWord;
    begin
      result := Get_MaskEdit_LCL(aTemplate,aSpaceChar,Size_TypeFld, aLength_Buffer,aOkMask);
    end;

    //function TUiDmxScroller.FormatMaskEdit_LCL(aValue, Mask: string;    aDirecao: Boolean): string;
    //
    //  function ExtractEditMask(const Mask: string): string;
    //  var
    //    Parts: TArray<string>;
    //  begin
    //    Parts := Mask.Split([';']);
    //    if Length(Parts) > 0 then
    //      Result := Parts[0]
    //    else
    //      Result := Mask;
    //  end;
    //
    //var
    //  i, j: Integer;
    //  EditMask, ResultBuffer: string;
    //begin
    //  EditMask := ExtractEditMask(Mask);
    //  ResultBuffer := '';
    //  j := 1;
    //  for i := 1 to Length(EditMask) do
    //  begin
    //    if EditMask[i] in ['9', '#','c','C','a','A','l','L','d','m','n','y'] then
    //    begin
    //      // Insere o próximo dígito do valor
    //      if j <= Length(aValue) then
    //      begin
    //        ResultBuffer := ResultBuffer + aValue[j];
    //        Inc(j);
    //      end
    //      else
    //      begin
    //        ResultBuffer := ResultBuffer + '_';
    //      end;
    //    end
    //    else if EditMask[i] in ['!','<','>','\'] then
    //    begin
    //      Continue;
    //    end
    //    else
    //    begin
    //      // Caracter literal da máscara
    //      ResultBuffer := ResultBuffer + EditMask[i];
    //    end;
    //  end;
    //  Result := ResultBuffer;
    //end;

    function TUiDmxScroller.FormatMaskEdit_LCL(aValue, Mask: string;    aDirecao: Boolean): string;

      function ExtractEditMask(const Mask: string): string;
      var
        Parts: TArray<string>;
      begin
        Parts := Mask.Split([';']);
        if Length(Parts) > 0 then
          Result := Parts[0]
        else
          Result := Mask;
      end;

        var
          EditMask, ResultBuffer: string;

      procedure Insert_left_to_right;
        var
          i :Integer;
          j: Integer;
      begin
         j := 1;
        for i := 1 to Length(EditMask) do
        begin
          if EditMask[i] in ['9', '#','c','C','a','A','l','L','d','m','n','y'] then
          begin
            // Insere o próximo dígito do valor
            if j <= Length(aValue) then
            begin
              ResultBuffer := ResultBuffer + aValue[j];
              Inc(j);
            end
            else
            begin
              ResultBuffer := ResultBuffer + '_';
            end;
          end
          else if EditMask[i] in ['!','<','>','\']
               then begin
                      Continue;
                    end
               else begin
                        // Caracter literal da máscara
                        ResultBuffer := ResultBuffer + EditMask[i];
                      end;
        end;
      end;

      procedure Insert_right_to_left;
        var
          i :Integer;
          j: Integer;
      begin
        j := Length(EditMask);
        for i := Length(EditMask) downto 1 do
        begin
          if EditMask[i] in ['9', '#','c','C','a','A','l','L','d','m','n','y'] then
          begin
            // Insere o próximo dígito do valor
            if j <= Length(aValue) then
            begin
              ResultBuffer := aValue[j]+ResultBuffer;
              inc(j);
            end
            else
            begin
              ResultBuffer := '_'+ResultBuffer;
            end;
          end
          else if EditMask[i] in ['!','<','>','\']
               then begin
                      Continue;
                    end
               else begin
                        // Caracter literal da máscara
                        ResultBuffer := ResultBuffer + EditMask[i];
                      end;
        end;
      end;


    begin
      EditMask := ExtractEditMask(Mask);
      ResultBuffer := '';

      if aDirecao
      then Insert_left_to_right
      else Insert_right_to_left;

      Result := ResultBuffer;
    end;

    procedure TUiDmxScroller.SetBufDataset(aBufDataset: TMiBufDataset);
    begin
      if _BufDataset = aBufDataset
      then exit;
      _BufDataset := aBufDataset;
      if (DataSource<>nil) and (DataSource.DataSet = nil) and Assigned(_BufDataset)
      then DataSource.DataSet := _BufDataset;

      if Active
      then if Assigned(DataSource) and
              Assigned(DataSource.DataSet) and
              (Not GetState(MB_Destroying))
           then begin
                  DataSource.DataSet.Active:=true;
                end;
    end;

    function TUiDmxScroller.GetBufDataset: TMiBufDataset;

      procedure CreateBufDataset_FieldDefs;

         procedure SetAtributosDosFields;
            Var
              F : TField;
              i,j : Integer;

         begin
           if Assigned(_BufDataset) //and (_BufDataset.State in [dsInactive])
           Then Begin
                  j := -1;
                  for i := 0 to Fields.Count-1 do
                  begin
                    SetCurrentField(Fields[i]);
                    if Assigned(CurrentField)
                       and (CurrentField^.Fieldnum<>0)
                       and (j < (_BufDataset.Fields.Count-1))
                    Then
                    with CurrentField^ do
                    begin
                      inc(j);
                      {$REGION 'Atualizar a propriedade ProviderFlags baseado tipo de acesso' }
                        f := _BufDataset.Fields[j];
                        if ((access and accHidden  ) <> 0) or
                           ((access and accReadOnly) <> 0) or
                           ((access and accSkip    ) <> 0)
                        then begin
                               f.ProviderFlags := f.ProviderFlags - [db.pfInUpdate];
                             End;

                        if ((access and accHidden  ) <> 0)
                        then begin
                               f.ProviderFlags := f.ProviderFlags + [db.pfHidden];
                             End;
                      {$ENDREGION '<--' }

                      {$REGION 'Atualizar a propriedade ProviderFlags baseado no campo TDmxFieldRec.ProviderFlags' }
                        if  (TMiProviderFlag.pfInUpdate in ProviderFlags)
                        then f.ProviderFlags := f.ProviderFlags + [db.pfInUpdate];

                        if  (TMiProviderFlag.pfInWhere in ProviderFlags)
                        then f.ProviderFlags := f.ProviderFlags + [db.pfInWhere];

                        if  (TMiProviderFlag.pfInKey in ProviderFlags)
                        then f.ProviderFlags := f.ProviderFlags + [db.pfInKey];

                        if  (TMiProviderFlag.pfHidden in ProviderFlags)
                        then f.ProviderFlags := f.ProviderFlags + [db.pfHidden];

                        if  (TMiProviderFlag.pfRefreshOnInsert in ProviderFlags)
                        then f.ProviderFlags := f.ProviderFlags + [db.pfRefreshOnInsert];

                        if  (TMiProviderFlag.pfRefreshOnUpdate in ProviderFlags)
                        then f.ProviderFlags := f.ProviderFlags + [db.pfRefreshOnUpdate];

                     {$ENDREGION '<--' }


                     //if (access and accReadOnly) <> 0
                     //then begin
                     //       f.ReadOnly:= true;
                     //     End;

                     if (access and accSkip) <> 0
                     then begin
                            f.ReadOnly:= true;
                          End;
                    end;
                  End;
                End;
         End;

         Var
           i : Integer;
      begin
        if Assigned(_BufDataset)
           and (_BufDataset.State in [dsInactive])
        then begin
               _BufDataset.Clear;
               for i := 0 to Fields.Count-1 do
               begin
                 SetCurrentField(Fields[i]);

                 if (CurrentField^.Fieldnum<>0) Then
                 with CurrentField^ do
                 begin
                    if (Fieldnum<>0) and (FieldName= '')
                    then begin
                           if not (TypeCode in [FldRadioButton])
                           then begin
                                  FieldName := 'Field'+IntToStr(Fieldnum);
                                  DataFields.AddFields(CurrentField);
                                end

                           {Os campos RadioButton tem nome duplicado
                           por isso o nome só está no primeiro da lista.}
                           else Continue;
                         end;

                    if TypeCode in CTypeString+CTypeAnsiChar then
                    begin
                     //O campo deve ter o tamanho da mascara +1 porque dbedit vai precisar para display
                      _BufDataset.FieldDefs.Add(FieldName,ftString,Length(Template_org)+1);
                    end
                    else
                    if CurrentField^.TypeCode = fldBLOb then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftBlob,FieldSize);
                    end
                    else
                    if CurrentField^.TypeCode = FldMemo then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftMemo,FieldSize);
                    end
                    else
                    if CurrentField^.TypeCode = FldBoolean then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftBoolean);
                    end
                    else
                    if CurrentField^.TypeCode = FldRadioButton then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftString,CurrentField^.ShownWid);
                    end
                    else
                    if TypeCode in CTypeInteger then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftInteger);
                    end
                    else
                    if TypeCode in CTypeReal then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftFloat);
                    end
                    else
                    if TypeCode in CTypeHour then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftTime,FieldSize);
                    end
                    else
                    if TypeCode in CTypeDate then
                    begin
                      //Os tipos são iguais: ftDate =  ftTime = ftDateTime = doublhe,

                      case CurrentField^.Mask of
                        TMask.Mask_yy_mm_dd,
                        TMask.Mask_yyyy_mm_dd,
                        TMask.Mask_dd_mm_yy,
                        TMask.Mask_dd_mm_yyyy : _BufDataset.FieldDefs.Add(FieldName,ftDate);

                        TMask.Mask_hh_nn ,
                        TMask.Mask_hh_nn_ss,
                        TMask.Mask_hh_nn_ss_zzz : _BufDataset.FieldDefs.Add(FieldName,ftTime);

                        TMask.Mask_dd_mm_yyyy_hh_nn,
                        TMask.Mask_dd_mm_yyyy_hh_nn_ss,
                        TMask.Mask_dd_mm_yy_hh_nn,
                        TMask.Mask_dd_mm_yy_hh_nn_ss
                        : _BufDataset.FieldDefs.Add(FieldName,ftDateTime);

                        else Raise TException.Create(Self,{$I %CURRENTROUTINE%},ParametroInvalido);
                      end;
                    end
                    else
                    if TypeCode in CTypeBlob then
                    begin
                      if TypeCode = FldMemo
                      Then _BufDataset.FieldDefs.Add(FieldName,ftMemo) //Binary text data (no size)
                      else _BufDataset.FieldDefs.Add(FieldName,ftBlob);// Binary data value (no type, no size)
                    end;
                 end;
               end;

               if _BufDataset.FieldDefs.Count > 0
               then begin
                     _BufDataset.CreateDataset;
                     SetAtributosDosFields;
                    end;
             end;

      End;

      Procedure CreateBufDataSet;
      Begin
        if _BufDataset=nil
        then begin
               _BufDataset_created:= true;
               _BufDataset := TMiBufDataset.Create(Self);
               _BufDataset._UiDmxScroller := self;

               if TableName<>''
               Then begin
                      _BufDataset.Name:=TableName;
                      //MiDataPacketFormat_Default := dfAny;
                      //MiDataPacketFormat_Default := dfXML;
                      MiDataPacketFormat_Default := dfJSon;
                    end;

               CreateBufDataset_FieldDefs;
             end;
      end;

      Procedure CreateDataSource;
      begin
        if _DataSource= nil
        Then begin
               CreateBufDataSet;
               _DataSource := TDataSource.Create(Self);
               _DataSource.DataSet := _BufDataset;
             end;
      end;

    begin
      //Cria datasource ou bufDataSet caso sejam nulos.
      if DataSource= nil
      Then CreateDataSource
      else if (Not Assigned(_BufDataset)) and (Not Assigned(DataSource.DataSet))
           then CreateBufDataSet;

      if DataSource.DataSet = nil
      Then DataSource.DataSet := _BufDataset;

      if DataSource.DataSet is TBufDataset
      then result := DataSource.DataSet as TMiBufDataset
      else Result := nil;
    end;

    function TUiDmxScroller.GetDataSource: TDataSource;
    begin
      Result :=_DataSource;
    end;

    procedure TUiDmxScroller.SetDataSource(aDataSource: TDataSource);
    begin
      if _DataSource<>aDataSource
      Then _DataSource := aDataSource;
    end;

    function TUiDmxScroller.IfEqual(const Ofset_Inicial: Word; const PAnt,
      PAtu: Pointer; const Len: Word): Boolean;
    {
      Compara 2 registro e retorna True se os seus conteudos forem iguais
      e False se forem diferentes.
    }
      Type
        TBytes = Array[1..1024*1024] of byte;
        PByte = ^TBytes;
       Var
         i  : Word;
    Begin
      if (PAnt = nil) or (PAtu = nil) //or (Self.NrCurrent=0)
      then BEGIN
             //Pode ser nil caso, todos os números de campos ormulários sejão iguais a zero.
             //Isso ocorre quando não tem entrada de dados no formulário
             RESULT := FALSE;
          end;

      Result := True;
      For i := Ofset_Inicial to Len do
        if PByte(PAnt)^[i] <> PByte(PAtu)^[i] Then
        Begin
          Result := False;
          Break;
        End;
    End;

    function TUiDmxScroller.RecordAltered: Boolean;
    begin
      if Assigned(WorkingData) and Assigned(WorkingDataOld)
      Then result := not IfEqual(1,WorkingData,WorkingDataOld,RecordSize)
      else result := false;
    end;

    class function TUiDmxScroller.CreateExecAction(
      const aFieldName: AnsiString; const aExecAction: AnsiString): AnsiString;
    begin
      result := chFN+getNameValid(aFieldName)+'~'+CharLupa_Left+'~'+ChEA+(getNameValid(aFieldName)+'.'+aExecAction);
    end;

    procedure TUiDmxScroller.add(aTemplate: AnsiString);
    begin
      if aTemplate=''
      Then aTemplate := '~~'
      else aTemplate := StringReplace(atemplate,'"','~', [rfReplaceAll]);

      aTemplate  := CharAllZeroes + aTemplate ;
      _Strings.Add(aTemplate);
//      _Strings.Insert(_Strings.count,aTemplate);
    end;

    procedure TUiDmxScroller.SetLocked(aLocked: Boolean);
    begin
      _Locked := aLocked;
      if Locked
      then DisableCommands([])
      else EnableCommands([]);
    end;

    procedure TUiDmxScroller.SetArgs(aArgs: array of const);
       procedure displayFiels;
          var
            fld : PDmxFieldRec;
            i,j : integer;
            s :AnsiString;
       begin
         for i := 0 to Fields.Count-1 do
         begin
          fld := FieldByNumber(i);
          if fld<> nil
          Then begin
                 if fld^.FieldName<>''
                 Then s := fld^.FieldName+' '+fld^.template^
                 else s := fld^.Alias+' '+IntToStr(fld^.Fieldnum);
               end;

         end;
       end;
       var
         fld : PDmxFieldRec;
         i,j : integer;
         s :AnsiString;

     begin
       If High(aArgs)<0 then  exit;
       j := 0;
       for i := 0 to Fields.Count-1 do
       begin
        fld := FieldByNumber(i);
        if fld<> nil
        Then begin
                s   := fld^.FieldName;
                if s<>''
                then begin
                       CurrentField := fld;
                       case aArgs[j].vtype of
                          vtInteger:        CurrentField.Value := aArgs[j].VInteger;
                          vtBoolean:        CurrentField.Value := aArgs[j].VBoolean;
                          vtChar:           CurrentField.Value := aArgs[j].VChar;
                          vtExtended:       CurrentField.Value := aArgs[j].VExtended^;
                          vtString:         CurrentField.Value := aArgs[j].VString^;
                          vtPChar:          CurrentField.Value := aArgs[j].VPChar;
                          vtObject:         CurrentField.Value := aArgs[j].VObject.ClassName;
                          vtAnsiString:     CurrentField.Value := aArgs[j].VAnsiString;
                          vtCurrency:       CurrentField.Value := aArgs[j].VCurrency^;
                          vtVariant:        CurrentField.Value := aArgs[j].VVariant^;
                          vtWideString:     CurrentField.Value := aArgs[j].VWideString;
                          vtInt64:          CurrentField.Value := aArgs[j].VInt64^;
                          vtUnicodeString:  CurrentField.Value := aArgs[j].VUnicodeString;


                         //vtinteger    : CurrentField.Value := aArgs[j].vinteger;
                         //vtboolean    : CurrentField.Value := aArgs[j].vboolean;
                         //vtchar       : CurrentField.Value := aArgs[j].vchar;
                         //vtextended   : CurrentField.Value := aArgs[j].VExtended^;
                         //vtString     : CurrentField.Value := aArgs[j].VString^;
                         //vtPChar      : CurrentField.Value := aArgs[j].VPChar;
                         //vtObject     : CurrentField.Value := aArgs[j].VObject.Classname;
                         //vtClass      : CurrentField.Value := aArgs[j].VClass.Classname;
                         //vtAnsiString : begin
                         //                 s:=AnsiString(aArgs[j].VAnsiString);
                         //                 CurrentField.AsString := AnsiString(aArgs[j].VAnsiString);
                         //               end

                         else           CurrentField.Value := '';
                       end;
                       inc(j);
                     end;
             end;
       end;
       //Refresh;
     end;

    procedure TUiDmxScroller.Set_JSONObject(aJSONObject: TJSONObject);
      var
        fld     : PDmxFieldRec;
        i       : Integer;
        fldName,s,v : string;
        OkAlterou :Boolean = false;
    begin
      if Assigned(aJSONObject)
      then begin
             for i := 0 to aJSONObject.Count-1 do
             begin
               fldName := aJSONObject.Names[i];
               fld     := FieldByName(fldName);
               if Assigned(fld)
               then begin
                      s := aJSONObject.strings[fld^.FieldName];
                      V := fld^.AsString;
                      if s<>V
                      Then begin
                             fld^.AsString := s;
                             OkAlterou := true;
                          end;
                    end;
             end;
             //DoCalcFields;
             //PutBuffers;

             if OkAlterou
             Then begin
                    DoCalcFields;
                    PutBuffers;
                 end;
           end;
    end;

    function TUiDmxScroller.Get_JSONObject: TJSONObject;
        // Doc: https://wiki.freepascal.org/fcl-json

        { program testJson;


              uses fpjson;

              var
                O : TJSONObject;
                A : TJSONArray;
              begin
                WriteLn('Teste TJSONObject:');
                O:=TJSONObject.Create(['a',1,'b','two','three',
                                       TJSONObject.Create(['x',10,'y',20])
                                      ]
                                     );
                Writeln (O.FormatJSon);
                Writeln (O.FormatJSon([foDonotQuoteMembers,foUseTabChar],1));
                Writeln (O.FormatJSon([foSingleLineObject,foUseTabChar],1));
                Writeln (O.asJSON);

                WriteLn('Teste: TJSONArray.Create(');
                A:=TJSONArray.Create([1,2,'a',TJSONObject.Create(['x',10,'y',20])]);

                WriteLn('Teste: A.FormatJSon');
                Writeln (A.FormatJSon());
                WriteLn('Teste: (A.FormatJSON([foSinglelineArray],2));');
                Writeln (A.FormatJSON([foSinglelineArray],2));

                WriteLn('Teste: A.FormatJSON([foSinglelineArray,foSingleLineObject],2));');
                Writeln (A.FormatJSON([foSinglelineArray,foSingleLineObject],2));

                WriteLn('Teste: A.asJSON);');
                Writeln (A.asJSON);
              end.
            }

        { Procedure DoTestObject;

          Var
            J : TJSONObject;
            I : Char;
            k : Integer;

          begin
            Writeln('Objeto JSON com elementos: a=0,b=1,c=2,d=3');
            J:=TJSONObject.Create(['a',0,'b',1,'c',2,'d',3]);
            Write('Obtenha nomes de elementos com a propriedade de array Names[]: ');
            For K:=0 to J.Count-1 do
              begin
              Write(J.Names[k]);
              If K<J.Count-1 then
                Write(', ');
              end;
            Writeln;

            Write('Acesso através da propriedade do array Elements[] (padrão): ');
            For I:='a' to 'd' do
              begin
              Write(i,' : ',J[I].AsString);
              If I<'d' then
                Write(', ');
              end;
            Writeln;

            Write('Acesso através da propriedade do array Nulls[]: ');
            For I:='a' to 'd' do
              begin
              Write(i,' : ',J.Nulls[I]);
              If I<'d' then
                Write(', ');
              end;
            Writeln;

            Write('Acesso através da propriedade do array Booleans[]:');
            For I:='a' to 'd' do
              begin
              Write(i,' : ',J.Booleans[I]);
              If I<'d' then
                Write(', ');
              end;
            Writeln;

            Write('Acesso através da propriedade do array Integers[]: ');
            For I:='a' to 'd' do
              begin
              Write(i,' : ',J.Integers[I]);
              If I<'d' then
                Write(', ');
              end;
            Writeln;

            Write('Acesso através da propriedade do array Floats[]: ');
            For I:='a' to 'd' do
              begin
              Write(i,' : ',J.Floats[I]:5:2);
              If I<'d' then
                Write(', ');
              end;
            Writeln;

            Write('Acesso através da propriedade do array Strings[]: ');
            For I:='a' to 'd' do
              begin
              Write(i,' : ',J.Strings[I]);
              If I<'d' then
                Write(', ');
              end;
            Writeln;
            FreeAndNil(J);
            WriteLn;
            writeln;
            Writeln('Crie com 3 TJSONObjects vazios no construtor de array');
            Write('Acesso através da propriedade do array Objects[]: ');

            J:=TJSONObject.Create(['a',TJSOnObject.Create,'b',TJSOnObject.Create,'c',TJSOnObject.Create]);
            For I:='a' to 'c' do
              begin
              Write(i,' : ');
              DumpJSONData(J.Objects[i],False);
              If I<'c' then
                Write(', ');
              end;
            Writeln;
            FreeAndNil(J);

            Writeln('Crie com 3 TJSONArrays vazios no construtor de array');
            Write('Acesso através da propriedade do array Arrays[]: ');
            J:=TJSONObject.Create(['a',TJSONArray.Create,'b',TJSONArray.Create,'c',TJSONArray.Create]);
            For I:='a' to 'c' do
              begin
              Write(i,' : ');
              DumpJSONData(J.Arrays[I],False);
              If I<'c' then
                Write(', ');
              end;
            Writeln;
            FreeAndNil(J);


            Writeln('Crie um objeto vazio. Adicione elementos com o método Add() sobrecarregado');
            J:=TJSONObject.Create;
            J.Add('a'); // Null
            J.Add('b',True);
            J.Add('c',False);
            J.Add('d',123);
            J.Add('e',2.34);
            J.Add('f','A string');
            J.Add('g',TJSONArray.Create);
            J.Add('h',TJSOnObject.Create);
            DumpJSONData(J);
            FreeAndNil(J);
          end;
      }

      var
        fld : PDmxFieldRec;
          i : Integer;
          s : AnsiString;

    begin
      if isDataSetActive and Assigned(Fields)
      then begin
              //if Assigned(WJSONObject)
              //Then FreeAndNil(WJSONObject);
              GetBuffers;
              Result := TJSONObject.Create;
              for i := 0 to Fields.Count-1 do
              begin
                fld := Fields[i];
                if  Assigned(fld) and
                   (fld^.Fieldnum<>0) and
                   (fld^.FieldName<>'')
                then begin
                       s := fld^.AsString;
                       if fld.IsBoolean
                       Then begin
                              if Lowcase(s)='false'
                              Then Result.add(fld^.FieldName,false)
                              else Result.add(fld^.FieldName,true)
                           end
                       else Result.add(fld^.FieldName,s);
                     end;
              end;
           end
      else result := nil;
    end;

    procedure TUiDmxScroller.HandleEvent(var Event: TUiMethods.TEvent);
    begin
      inherited HandleEvent(Event);
    end;

    procedure TUiDmxScroller.SetParent(AValue: TComponent);
    begin
      if _Parent=AValue then Exit;
      _Parent:=AValue;
    end;

    function TUiDmxScroller.GetParent: TComponent;
    begin
      result := _Parent;
    end;

    procedure TUiDmxScroller.Set_Mi_ActionList(a_Mi_ActionList: TActionList);
    begin
      if _Mi_ActionList<>a_Mi_ActionList
      Then _Mi_ActionList := a_Mi_ActionList;
      if Assigned(_Mi_ActionList)
      Then EnableCommands([]);
    end;

    function TUiDmxScroller.Get_Mi_ActionList: TActionList;
    begin
      result := _Mi_ActionList
    end;

    {$REGION ' Implementação dos botões de ações'}
      function TUiDmxScroller.GetAction(aName: AnsiString): TAction;
        Var
          acList :TContainedAction;
      begin
        if Assigned(Mi_ActionList)
        then begin
               acList :=  Mi_ActionList.ActionByName(aName);
               if Assigned(acList)
               Then begin
                      if acList is TAction
                      then result := (acList as TAction);
                    end
               else Result := nil;
             end
        else Result := nil;
      end;

      procedure TUiDmxScroller.SetStateAction(aName: AnsiString; aEnable: Boolean);
         Var
           action :TAction;
      begin
        action := GetAction(aName);
        if Assigned(action)
        then action.Enabled := aEnable;
      end;

      function TUiDmxScroller.getStateAction(aName: AnsiString): Boolean;
        Var
          action :TAction;
      begin
        action := GetAction(aName);
        if Assigned(action)
        then result := action.Enabled
        else result := true;
      end;

      function TUiDmxScroller.CommandsEnabled(aCommands: array of ansistring): Boolean;

          var
           i :Integer;
      begin
        if not Assigned(Mi_ActionList)
        then begin
               result := true; exit;
             end;

        for i := 0 to high(aCommands) do
        begin
          if not getStateAction(aCommands[i])
          then begin
                 result := false;
                 exit;
               end;
        end;
        result := true;
      end;

      function TUiDmxScroller.CommandsDisabled(aCommands: array of ansistring): Boolean;
        var
          i :Integer;
      begin
        if not Assigned(Mi_ActionList)
        then begin
               result := false; exit;
             end;

        for i := 0 to high(aCommands) do
        begin
          if getStateAction(aCommands[i])
          then begin
                 result := false;
                 exit;
               end;
        end;
      end;

      procedure TUiDmxScroller.EnableCommands(aCommands: array of AnsiString);
          var
           i,n :Integer;
          Var
            acList :TContainedAction;

      begin
        if Assigned(Mi_ActionList)
        then begin
               if high(aCommands)=-1 //Habilita todos
               then begin
                      n:= Mi_ActionList.ActionCount;
                      For i := 0 to n-1 do
                      begin
                        acList :=  Mi_ActionList.Actions[i];
                        if acList is TAction
                        then (acList as TAction).Enabled:=true;
                      end;
                      exit;
                    end;

               for i := 0 to high(aCommands) do
               begin
                 SetStateAction(aCommands[i],true);
               end;
             end;
      end;

      procedure TUiDmxScroller.DisableCommands(aCommands: array of AnsiString);
          var
           i,N :Integer;
          Var
            acList :TContainedAction;
      begin
        if Assigned(Mi_ActionList)
        then begin
               if high(aCommands)=-1 //Desabilita todos
               then begin
                      N := Mi_ActionList.ActionCount;
                      For i := 0 to N-1 do
                      begin
                        acList :=  Mi_ActionList.Actions[i];
                        if acList is TAction
                        then (acList as TAction).Enabled:=false;
                      end;
                      exit;
                    end;

               for i := 0 to high(aCommands) do
               begin
                 SetStateAction(aCommands[i],false);
               end;
             end;
      end;

      procedure TUiDmxScroller.UpdateCommands;
      begin
        if isDataSetActive
        Then begin
               if (State and Mb_St_Insert<>0)
               Then begin
                      //SetState(Mb_St_Insert+Mb_St_Edit+Mb_St_Browse,false);
                      DisableCommands([]);
                      if RecordAltered
                      Then EnableCommands([CmUpdateRecord,CmCancel])
                      else EnableCommands([CmRefresh,CmLocate]) ;
                    end
               else if ((State and Mb_St_Edit)<>0)
                    then begin
                           if ((not Bof) and
                              (not Eof)) or (RecordAltered)
                           then begin
                                  if RecordAltered
                                  then begin
                                         DisableCommands([]);
                                         EnableCommands([CmUpdateRecord,CmCancel]);
                                       end
                                  else begin
                                         DisableCommands([]);
                                         EnableCommands([CmNewRecord,
                                                         CmDeleteRecord,
                                                         CmGoBof  ,
                                                         CmNextRecord ,
                                                         CmPrevRecord ,
                                                         CmGoEof  ,
                                                         CmLocate,
                                                         CmRefresh]);
                                         //Desabilita os botões primeiro ou útilmo
                                         if Bof
                                         Then DisableCommands([CmGoBof])
                                         else if Eof
                                              Then DisableCommands([CmGoEof]);
                                       end;
                                end
                           else begin
                                  if not _Appending
                                  then begin
                                         EnableCommands([]);
                                         DisableCommands([CmUpdateRecord,CmCancel]);
                                       end;

                                   if eof
                                   Then begin
                                          DisableCommands([CmNextRecord,CmGoEof]);
                                        end
                                   else if bof
                                        then DisableCommands([CmPrevRecord,CmGoBof]);

                                end;
                         end
                         else begin
                                if not _Appending and (not RecordAltered)
                                then begin
                                       EnableCommands([]);
                                       DisableCommands([CmUpdateRecord,CmCancel]);
                                     end;
                              end;
             end;

      end;

      class function TUiDmxScroller.GetTemplate_CRUD_Buttons(aCmNewRecord,
                                                           aCmUpdateRecord,
                                                           aCmLocate,
                                                           aCmDeleteRecord,
                                                           aCmCancel: string): string;
      begin
        result := '';
        if aCmNewRecord<>''
        Then result := result + '~➕ &Novo     ~'+ChEA+aCmNewRecord;
        if aCmUpdateRecord<>'' //Pode adicionar ou gravar o atual;
        Then result := result + '~✔️ &Gravar   ~'+ChEA+aCmUpdateRecord;
        if aCmLocate<>''
        Then result := result + '~🔍 &Pesquisar~'+ChEA+aCmLocate;
        if aCmDeleteRecord<>''
        Then result := result + '~➖ &Excluir  ~'+ChEA+aCmDeleteRecord;
        if aCmCancel<>''
        Then result := result + '~❌ &Cancelar ~'+ChEA+aCmCancel;
      end;

      class function TUiDmxScroller.GetTemplate_CRUD_Buttons(): string;
      begin
        result := GetTemplate_CRUD_Buttons(CmNewRecord,CmUpdateRecord,CmLocate,CmDeleteRecord,CmCancel);
      end;

      class function TUiDmxScroller.GetTemplate_DbNavigator_Buttons
      (aCmGoBof, aCmNextRecord, aCmPrevRecord,
      aCmGoEof, aCmRefresh: string): string;
      begin
        result := '~⬅️ P&rimeiro ~'+ChEA+aCmGoBof      +
                  '~➡️ Pró&ximo  ~'+ChEA+aCmNextRecord +
                  '~⬅️ &Anterior ~'+ChEA+aCmPrevRecord +
                  '~➡️ Ú&ltimo   ~'+ChEA+aCmGoEof      +
                  '~🔄 A&tualizar~'+ChEA+aCmRefresh;
      end;

      class function TUiDmxScroller.GetTemplate_DbNavigator_Buttons(): string;
      begin
        result := GetTemplate_DbNavigator_Buttons(CmGoBof,CmNextRecord,CmPrevRecord,CmGoEof,CmRefresh);
      end;

    {$ENDREGION ' Implementação dos botões de ações'}

    {$REGION ' Implementação Método de atualização no banco de dados'}

      function TUiDmxScroller.GetDataSet: TDataSet;
      begin
        if Assigned(WorkingData)
        then begin
               if Assigned(DataSource) and
                  Assigned(DataSource.DataSet)
               then Result := DataSource.DataSet
               else Result := BufDataset;
             end
        else Result := nil;
      end;

      function TUiDmxScroller.GetDataSet_Status: String;
        Var
          ds : TDataSet;
      begin
        ds := GetDataSet;
        If RecordAltered
        Then Result := 'Registro alterado'
        else Result := '';

        If Appending
        Then Result := Result + ' ; DoOnNewRecord=true'
        else Result := Result + ' ; DoOnNewRecord=false';

        if ds.State in [DsInsert]
        then Result := Result + ' ; DsInsert';

        if GetState(mb_st_Insert)
        Then Result := Result + ' ; mb_st_Insert';

        if ds.State in [DsEdit]
        then Result := Result + ' ; DsEdit';

        if GetState(mb_st_edit)
        Then Result := Result + ' ; mb_st_edit';

        if ds.State in [dsBrowse]
        then Result := Result + ' ; dsBrowse';

        if GetState(Mb_St_Browse)
        Then Result := Result + '; Mb_St_Browse';

      end;

      function TUiDmxScroller.isDataSetActive:Boolean;
      begin
        if Assigned(WorkingData) and (not GetState(MB_Destroying) )
        then Result := GetDataSet.Active
        else Result := false;
      end;

      procedure TUiDmxScroller.UpdateState;
        var
          ds : TdataSet;
      begin
        ds := GetDataSet;
        if ds.State in [DsInsert]
        then begin
               if not GetState(Mb_St_Insert)
               then SetState(Mb_St_Insert,true);

               if GetState(Mb_St_Edit)
               then SetState(Mb_St_Edit,false);

               if GetState(Mb_St_Browse)
               then SetState(Mb_St_Browse,false);
             end
        else if ds.State in [DsEdit]
             then begin
                    if not GetState(Mb_St_Edit)
                    then SetState(Mb_St_Edit,true);

                    if GetState(Mb_St_Insert)
                    then SetState(Mb_St_Insert,false);

                    if GetState(Mb_St_Browse)
                    then SetState(Mb_St_Browse,false);
                   end
             else if ds.State in [dsBrowse]
                  then begin
                         if not GetState(Mb_St_Browse)
                         then SetState(Mb_St_Browse,true);

                         if GetState(Mb_St_Insert)
                         then SetState(Mb_St_Insert,false);

                         if GetState(Mb_St_Edit)
                         then SetState(Mb_St_Edit,false);


                     end


      end;

      procedure TUiDmxScroller.DataSet_Append;
        var
          ds : TDataSet;
      begin
        if isDataSetActive
        then begin
               ds := GetDataSet;
               if not _Appending
               then TException.Create(self,'DataSet_Append','O método deve ser chamado quando tiver no modo appendig!');
               if not (ds.State in [DsInsert])
               then begin
                      ds.Append;//Insert;
                       UpdateState;
                    end
               else UpdateState;
               DoCalcFields;
             end
        else TException.Create(self,'DataSet_Append','Chamada inválida ao método!');
      end;

      procedure TUiDmxScroller.DataSet_post;
        var
          ds : TdataSet;
      begin
        ds := GetDataSet;
        if isDataSetActive
        then with ds do
             begin
               if Appending
               then begin
                      if not (State in [dsInsert])
                      Then raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
                    end
               else begin
                      if not (State in [dsEdit])
                      Then raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
                    end;
               if State in dsEditModes
               then begin
                      Post;
                    end;
               UpdateState;
             end
        else raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
      end;

      procedure TUiDmxScroller.DataSet_Delete;
      begin
        if isDataSetActive
        then begin
               if RecordAltered
               then raise TException.Create(self,{$I %CURRENTROUTINE%},'Não pode excluir um registro alterado!');

               If Not RecordSelected
               then raise TException.Create(self,{$I %CURRENTROUTINE%},'Não pode excluir um registro não selecionado!');
               GetDataSet.Delete;
             end;
//        else TException.Create(self,'DataSet_Delete','Chamada inválida ao método!');
      end;

      procedure TUiDmxScroller.DataSet_Edit;
        var
          ds : TDataSet;
      begin
        if isDataSetActive and (Not Appending)
        then begin
               ds := GetDataSet;
              if Not (ds.State in [DsEdit])
              Then begin
                     ds.Edit;
                     UpdateState;
                   end
              else UpdateState;
              DoCalcFields;
              UpdateCommands;
             end
        else raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
      end;

      function TUiDmxScroller.Locate(const KeyFields: string;const KeyValues: Variant; Options: TLocateOptions): boolean;
        var
          ds : TdataSet;
          wBookmark :TBookmark;
      begin
        if (KeyFields='')
        then begin
               result := false;
               exit;
             end;
        try
          wBookmark := CurrentBookmark;
          ds := GetDataSet;
          DisableControls;
          DoonExit(self);
          If Appending
          Then Appending := false;

          if isDataSetActive and  (KeyFields<>'')
          then begin
                 try
                   if Not _BufDataset_created
                   Then begin //Refresca o banco de dados;
                          DataSet_Refresh;
                        end;
                   Result := ds.Locate(KeyFields,KeyValues,Options)
                 Except
                    Result := false;
                 end;

                 if Result
                 Then result := GetRec(ds.Bookmark)
                 else GetRec(wBookmark);
               end
          else result := false;

        finally
          EnableControls;
          DoOnEnter(self);
        end;
      end;

      function TUiDmxScroller.DataSet_BookmarkValid(aBookMark: TBookMark): Boolean;
      begin
         if isDataSetActive
        then begin
               result := GetDataSet.BookmarkValid(aBookMark);
             end
        else raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
      end;

      procedure TUiDmxScroller.DataSet_Cancel;
        var
          ds : TdataSet;
      begin
        if isDataSetActive
        then begin
               ds := GetDataSet;
               ds.Cancel;
               if ds.State in [DsInsert]
               then SetState(Mb_St_Insert,true)
               else SetState(Mb_St_Insert,False);

               if ds.State in [DsEdit]
               then SetState(Mb_St_Edit,true)
               else SetState(Mb_St_Edit,False);

               if ds.State in [dsBrowse]
               then SetState(Mb_St_Browse,true)
               else SetState(Mb_St_Browse,False);
             end
        else raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');
      end;

      procedure TUiDmxScroller.DataSet_Refresh;
        var
          ds : TDataSet;
      begin
        if isDataSetActive and (not _BufDataset_created)
        then begin
               ds := GetDataSet;
               ds.active := false;
               ds.active := true;
               //O motivo que desativei é porque não tava dando certo.
               //if ds is TSQLQuery
               //Then
               //ds.Refresh;
             end;
      end;

      procedure TUiDmxScroller.DataSet_ApplyUpdates;
        var
          ds : TDataSet;
      begin
        if isDataSetActive
        then begin
               ds := GetDataSet;
               if ds is TSQLQuery
               Then (ds as TSQLQuery).ApplyUpdates
               else BufDataset.ApplyUpdates;
             end;
      end;

      {: O método **@name** Coloca o buffer em modo de edição para gravar no dataset.}
      procedure TUiDmxScroller.Edit;
        var ds : TDataSet;
      begin
        ds := GetDataSet;
        if isDataSetActive and (ds.State in [dsBrowse])
        then begin
               if Appending
               Then begin
                      DataSet_Append;
                      _CurrentBookmark := ds.Bookmark;
                      CurrentRecordOld     := CurrentRecord;
                    end
               else begin
                      _CurrentBookmark := ds.Bookmark;
                      CurrentRecordOld := CurrentRecord;
                      DataSet_Edit;
                    end;
               RecordSelected := true;

             end;
      end;

      function TUiDmxScroller.getFieldsKeys(out Values: Variant): AnsiString;
        Var
          F : TField;
          i : Integer;
          S: TStringList;

          ar : Array of Variant;
          str:string;
          ds : TdataSet;
      begin
        valuekey := '';
        //if Appending
        //Then raise TException.Create(self,{$I %CURRENTROUTINE%},'Não existe campo chave no modo appending!');
        ds := GetDataSet;
        result := '';
        Values := Null;

        if IsEmpty //or (not DataSet_BookmarkValid(CurrentBookmark))
        then exit;
        s :=  TStringList.Create;
        try
          if isDataSetActive  //and DataSet_BookmarkValid(CurrentBookmark)
          Then begin
                 // Pega o nome de campos e valores
                 for i := 0 to ds.Fields.Count-1 do
                 begin
                    f := ds.Fields[i];

                    if {db.UsePrimaryKeyAsKey and}
                       (db.pfInKey in F.ProviderFlags)
                    then begin
                           result := result + f.FieldName+';';
                           str := f.Value;
                           if str<>''
                           Then s.Add(str);
                         end;
                 end;

                 // remove a vírgula do último caractere.
                 system.delete(result, length(result),1);

                 // Copia s para Values
                 if s.Count > 0
                 Then begin
                         setLength(ar, s.Count);
                         for i := 0 to s.Count-1 do
                         begin
                           str := s.Strings[i];
                           ar[i] := str;
                           valuekey := valuekey +','+str;
                         end;
                         values := ar;
                      end
                 else begin
                        result := '';
                      end;
               end;
        finally
          FreeAndNil(s);
        end;
      end;

      function TUiDmxScroller.getFieldsKeysAsJson: TJSONObject;
        var
          F: TField;
          i: Integer;
          ds: TDataSet;
      begin
        Result := TJSONObject.Create;

        ds := GetDataSet;

        if IsEmpty then
          exit(Result); // Retorna um objeto vazio se o dataset estiver vazio.

        if isDataSetActive then
        begin
          // Itera sobre os campos do dataset.
          for i := 0 to ds.Fields.Count - 1 do
          begin
            F := ds.Fields[i];

            if (db.pfInKey in F.ProviderFlags) then
            begin
              // Adiciona o campo e seu valor no objeto JSON.
              if not F.IsNull then
                Result.Add(F.FieldName, F.AsVariant);  // Usa AsVariant para garantir compatibilidade com diferentes tipos.
            end;
          end;
        end;
      end;


      function TUiDmxScroller.AddRec: Boolean;
        Var
          Finalize : boolean;
          CurrenteKeyValue : variant;
          CurrentKeyPrimary : AnsiString;
          ds : TDataSet;

      begin
        if isDataSetActive
        then begin
               try
                 //{$IFOPT D+}
                 //   if (TableName<>'')
                 //      and (Not ControlsDisabled)
                 //      and (MessageBox('Confirma adição do registro?') <> MI_MsgBox.MrOk)
                 //   Then begin
                 //          result := false;
                 //          Cancel;
                 //          exit;
                 //        end;
                 //{$ENDIF}

                 if not RecordAltered
                 then begin
                        result := false;
                        exit;
                      end;

                 if Application.GetTypeApplication <> Application.TEnumApplication.EnApp_LCL_Http_Client
                 Then begin //Ignorei o  teste na aplicação cliente pq na primeiro consulta o botão está destivado
                        if Not CommandsEnabled(['CmUpdateRecord'])
                        then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não posso adicionar um registro quando o botão CmUpdateRecord está desativado!');
                      end;


                 if not Appending
                 Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');

                 if Not RecordSelected
                 Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada inválida ao método!');

               except
                 result := false;
                 exit;
               end;

               ds := GetDataSet;
               try //except
                 try //except
                   SavewWorkingData;
                   Finalize := StartTransaction;
                   if Appending
                   then begin
                          if PutBuffers
                          then begin
                                 if (not DoBeforeInsert)
                                 Then Raise TException.Create(Self,{$I %CURRENTROUTINE%},'O método DoBeforeInsert retornou false!. Não posso adicionar o registro.');
                                 DataSet_post;
                                 CurrentKeyPrimary := getFieldsKeys(CurrenteKeyValue);
                                 //S := CurrentKeyPrimary;
                                 if not DoAfterInsert
                                 Then raise  TException.Create(Self,
                                                          {$I %CURRENTROUTINE%},
                                                          'O método DoAfterInsert retornou false!. Não posso adicionar o registro.');

                               end
                          else Raise  TException.Create(Self,{$I %CURRENTROUTINE%},'O método PutBuffer retornou false!. Não posso gravar.');
                          result := true;
                        End
                   else Begin
                          result := false;
                          raise  TException.Create(Self,{$I %CURRENTROUTINE%},Attempt_to_insert_record_without_is_selected);
                        end;

                   if Finalize
                   then Commit;
                   Appending:=false;

                   if (not ds.active)
                   Then begin
                          if ds is TSQLQuery
                          Then (ds as TSQLQuery).active := true
                          else Raise TException.create(self,{$I %CURRENTROUTINE%},'Dataset associado ao datasource não pe TSQLQuery!');
                          if CurrentKeyPrimary<>''
                          then begin
                                 if not Locate(CurrentKeyPrimary,CurrenteKeyValue,[loCaseInsensitive])  //loPartialKey
                                 then Raise TException.create(self,{$I %CURRENTROUTINE%},'Chave atual não localizada.')
                                 else Result := GetRec(ds.Bookmark);
                                end
                          else Result := GetRec(ds.Bookmark);
                        end;

                   //if Assigned(wJSONObject)
                   //Then FreeandNil(wJSONObject);

                 Except
                    On E : EDatabaseError do
                    begin
                      Rollback(Finalize,E.Message,wWorkingData);
                      Result := false;
                    end;

                    On E : Exception do
                    begin
                      Rollback(Finalize,E.Message,wWorkingData);
                      Result := false;
                    end;

                    On E : TException do
                    begin
                      Rollback(Finalize,'',wWorkingData);
                      Result := false;
                    end;
                 end; //Except
                 DoOnEnter(self);
                 UpdateCommands;
               Except
                  result := false;
               end;
             end
        else result := false;
      end;

      function TUiDmxScroller.DeleteRec: Boolean;
        Var
          Finalize : boolean;
          CurrenteKeyValue : variant;
          CurrentKeyPrimary : AnsiString = '';
          ds : TDataSet;

          CurrentBookMark : TBookMark;
          CurrentBookMarkAtual : TBookMark;
      begin
        if isDataSetActive
        then begin
               try
                 //{$IFOPT D+}
                 //    if (TableName<>'') and (Not ControlsDisabled) and (MessageBox('Confirma exclusão do registro?') <> MI_MsgBox.MrOk)
                 //    Then begin
                 //           result := false;
                 //           cancel;
                 //           exit;
                 //         end;
                 //
                 //{$ENDIF}


                 if Not CommandsEnabled(['CmDeleteRecord'])
                 then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não posso deletar um registro quando o botão CmDeleteRecord está desativado!');

                 if Appending
                 Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não pode deletar um registro estando no modo de inclusão de registro!');

                 ds := GetDataSet;
                 try
                   if Not RecordSelected
                   Then DoOnEnter(self);
                   if (Not RecordAltered)
                   then begin
                          try
                            Finalize := StartTransaction;
                            if PutBuffers
                            then begin
                                   if (not DoBeforeDelete)
                                   Then Raise TException.Create(Self,{$I %CURRENTROUTINE%},'O método DoBeforeDelete retornou false!. Não posso adicionar o registro.');
                                   CurrentKeyPrimary := getFieldsKeys(CurrenteKeyValue);
                                   CurrentBookMarkAtual   := ds.Bookmark;
                                   DataSet_Delete;
                                   if not DoAfterDelete
                                   Then raise  TException.Create(Self,
                                                            {$I %CURRENTROUTINE%},
                                                            'O método DoAfterDelete retornou false!. Não posso adicionar o registro.');

                                 end
                            else Raise TException.Create(Self,{$I %CURRENTROUTINE%},'Algo errado ao atualizar buffer do registro!');
                            Result := true;

                            CurrentBookMark := ds.Bookmark;
                            if (CurrentBookMark<>CurrentBookMarkAtual) and (not IsEmpty)
                            Then begin
                                   CurrentKeyPrimary := getFieldsKeys(CurrenteKeyValue);
                                 end
                            else CurrentKeyPrimary := '';
                            if Finalize
                            then Commit;

                          Except
                             On E : EDatabaseError do
                             begin
                               Rollback(Finalize,E.Message,nil);
                               Result := false;
                             end;
                             On E : Exception do
                             begin
                               Rollback(Finalize,E.Message,nil);
                               Result := false;
                             end;
                             On E : TException do
                             begin
                               Rollback(Finalize,'',nil);
                               Result := false;
                             end;
                          end;
                          if (not isDataSetActive)
                          Then begin
                                 ds.active := true;
                               end;

                          if (CurrentKeyPrimary<>'') and (not IsEmpty)
                          then begin
                                  if not ds.Locate(CurrentKeyPrimary,CurrenteKeyValue,[loPartialKey])  //loCaseInsensitive
                                  then Result := GetRec(CurrentBookMark);
                                  Refresh;
                               end
                          else begin
                                 If (not IsEmpty) and (Not appending)
                                 Then begin
                                        if not NextRec
                                        then PrevRec;
                                               Refresh;
                                      end
                                 else DoOnNewRecord;
                               end;

                        end
                   else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não pode deletar um registro auterado|. Atualize primeiro.');

                 finally
                   DoOnEnter(self);
                 end;
               Except
                 result := false;
               end;
             end
        else result := false;
      end;

      function TUiDmxScroller.PutRec: Boolean;
        Var
          Finalize : boolean;
          CurrenteKeyValue : variant;
          CurrentKeyPrimary : AnsiString = '';
          ds : TDataSet = nil;
      begin
        if isDataSetActive
        then begin
               //{$IFOPT D+}
               //   if (TableName<>'') and (Not ControlsDisabled) and   (MessageBox('Confirma gravação do registro?') <> MI_MsgBox.MrOk)
               //   Then begin
               //          result := false;
               //          Cancel;
               //          exit;
               //        end;
               //{$ENDIF}

               ds := GetDataSet;
               if RecordSelected and RecordAltered
               Then begin
                      try
                        if Not CommandsEnabled(['CmUpdateRecord'])
                        then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não posso gravar um registro quando o botão CmUpdateRecord está desativado!')
                        else if Appending
                             Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não pode gravar um registro estando no modo de inclusão de registro!')
                             else If Not (ds.State in [DsEdit])
                                  Then Raise TException.Create(self,{$I %CURRENTROUTINE%},'Não pode executar o método sem antes executar o método Edit!');
                        try
                          SavewWorkingData;
                          Finalize := StartTransaction;
                          if PutBuffers
                          then begin
                                 if (not DoBeforeUpdate)
                                 Then Raise TException.Create(Self,{$I %CURRENTROUTINE%},'O método DoBeforeUpdate retornou false!. Não posso gravar o registro.');
                                 if PutBuffers
                                 then begin
                                        DataSet_post;
                                        CurrentKeyPrimary := getFieldsKeys(CurrenteKeyValue);
                                        if (not DoAfterUpdate)
                                        Then Raise TException.Create(Self,{$I %CURRENTROUTINE%},'O método DoBeforeUpdate retornou false!. Não posso gravar o registro.');
                                      end
                                 else Raise TException.Create(Self,{$I %CURRENTROUTINE%},'O método PutBuffer retornou false!. Não posso gravar o registro.');
                               end
                          else Raise TException.Create(Self,{$I %CURRENTROUTINE%},'O método PutBuffer retornou false!. Não posso gravar o registro.');
                          if Finalize
                          then Commit;
                          Result := true;
                        Except
                           On E : EDatabaseError do
                           begin
                             Rollback(Finalize,E.Message,wWorkingData);
                             Result := false;
                           end;

                           On E : Exception do
                           begin
                             Rollback(Finalize,E.Message,wWorkingData);
                             Result := false;
                           end;

                           On E : TException do
                           begin
                             Rollback(Finalize,'',wWorkingData);
                             Result := false;
                           end;
                        end;

                      except
                        result := false;
                      end;

                      if (not ds.Active)
                      Then begin
                             ds.active := true;
                             if CurrentKeyPrimary <> ''
                             then begin
                                    if not ds.Locate(CurrentKeyPrimary,CurrenteKeyValue,[loCaseInsensitive])  //loPartialKey
                                    then Raise TException.create(self,{$I %CURRENTROUTINE%},'Chave atual não localizada.');
                                  end;
                          end;
                      ChangeMadeOnOff(false);
                    end
               Else Result := False;
             end
        else result := false;
      end;

      function TUiDmxScroller.UpdateRec: Boolean;
      begin
        if isDataSetActive and RecordAltered
        then begin
                if Appending
                Then Result := AddRec
                else Result := PutRec;
             end
        else result := false;
      end;

      function TUiDmxScroller.GetNextValue(const SequenceName: string;   IncrementBy: integer): Int64;
         var
           ds : TDataSet;
      begin
        ds := GetDataSet;
        if isDataSetActive and ( ds is TSQLQuery)
        then begin
               with ( ds as TSQLQuery) do
               begin
                 if (DataBase is TSQLConnection)
                 Then Result := (DataBase as TSQLConnection).GetNextValue(SequenceName,IncrementBy)
                 else Result := -1;
               end;
             end
             else Result := -1;
      end;

      function TUiDmxScroller.MaxPKey(aTabela, aID: String):LongInt;
        var
          wSQL,s : String; //Salva a sql.ext atual;
        var
          ds : TDataSet;

      begin
        ds := GetDataSet;
        if isDataSetActive and
           ( ds is TSQLQuery) and
           Assigned(( ds as TSQLQuery).FieldByName(aID))
        then begin
              with ( ds as TSQLQuery)  do
              try

                wSQL := sql.Text;
                Active:=false;
                sql.Clear; // limpa Query
                SQL.Add('SELECT MAX('+aID+') as vr_max_id FROM '+aTabela);// escreve nova query com parâmetros recebido da função
                s := SQL.text;
                Active:=true;
                case Fields[0].DataType of
                  ftSmallint,
                  ftLargeint,
                  ftWord,
                  ftInteger: Result := Fields[0].AsInteger; // se o campo AI for SmallInt, Word ou Integer
                  else raise TException.Create(self,{$I %CURRENTROUTINE%},'Tipo de campo no banco de dados não é inteiro');
                end;

              finally
                Active:=false;
                sql.Clear; // limpa Query
                sql.Text := WSQL;
                Active:=true;
              end;
        end
        else Result := -1;
      end;

      function TUiDmxScroller.MaxPKey: LongInt;
        var
          s :String;
          fld:PDmxFieldRec;
      begin
        fld := FieldByName('ID');
        if Assigned(fld) and
           (fld^.Fieldnum<>0) and
           (CompareText(fld^.FieldName,'ID')=0)
        then result := MaxPKey(TableName,'ID')
        else Result := -1;
      end;

      function TUiDmxScroller.GetRecNo: LongInt;
        var
          ds : TDataSet;
      begin
        ds := GetDataSet;
        if isDataSetActive and (ds is TSQLQuery )
        Then begin
//              result := MaxPKey Essa função está gerando erro dizendo que o campo id não existe.
              result := GetNextValue(TableName+'_id_seq',0);
             end
        else begin
               if ds.IsSequenced
               Then result := ds.RecordCount+1
               else result :=  -1;
             end;
      end;

      function TUiDmxScroller.GetBof: Boolean;
      begin
        if isDataSetActive
//        Then result := _Bof
        Then result := DataSource.DataSet.BOF
        else result := true; // //Retorna true indicando que está no Bof.
      end;

      //procedure TUiDmxScroller.SetBof(AValue: Boolean);
      //begin
      //  if AValue<>_Bof
      //  Then _Bof := aValue;
      //end;

      //procedure TUiDmxScroller.SetEof(AValue: Boolean);
      //begin
      //  if AValue<>_Eof
      //  Then _Eof := aValue;
      //end;

      function TUiDmxScroller.FirstRec: Boolean;
        Var
          ds : TDataSet;
       begin
        if isDataSetActive
        then begin
               try
                 ds:= GetDataSet;
                 DoOnExit(self);
                 try
                   if IsEmpty
                   Then begin
                          Result := false;
                          exit;
                        end
                   else if Appending
                        Then Appending := false;

                   If not ds.Bof
                   Then begin
                          ds.First;
                          Result := GetRec(ds.Bookmark);
                          ds.First;//Motivo: Quando leio o primeiro o bof := false;
                        end
                   else begin
                          ds.First;
                          Result := GetRec(ds.Bookmark); //Garantir que está no primeiro
                          Result := false;
                        end;


                 Except
                    on E: Exception do
                    begin
                      ShowMessage(E.Message);  // Log de erro
                      Result := false;
                    end;
                 end;

               finally
                 if Not Result
                 Then begin
                        DoOnEnter(self);
                        Ds.First; //Mantém o ponteiro em bof.
                      end
                 else DoOnEnter(self);

                 UpdateCommands;
               end;
        end
        else result := false;
      end;

      function TUiDmxScroller.NextRec: Boolean;
        Var
          ds: TdataSet;
      begin
        if isDataSetActive
        then begin
               try
                 ds := GetDataSet;
                 DoOnExit(self);
                 try
                   if (Not ds.Eof)
                   then begin
                          //Bof := false;
                          ds.Next;
                          //eof := ds.Eof; //Motivo: GetRec faz: _Eof := false;
                          if Not Eof
                          then Result := GetRec(ds.Bookmark)
                          else Result := false;
                        end
                   else begin
                          Ds.Last;
                          Result := GetRec(ds.Bookmark);
                          Result := false;
                        end;

                 except
                    on E: Exception do
                    begin
                      //ShowMessage(E.Message);  // Log de erro
                      Result := false;
                    end;

                 end;

               finally
                 if Not Result
                 Then begin
                        DoOnEnter(self);
                        ds.Last; //Necessário porque Evento DoOnEnter altera ponteiro eof
                      end
                 else DoOnEnter(self);
                 UpdateCommands;
               end;
             end
        else Result := false;
      end;

      function TUiDmxScroller.PrevRec: Boolean;
        var
          ds : TDataSet;
      begin
        if isDataSetActive
        then begin
               ds := GetDataSet;
               DoOnExit(self);
               try
                 if (Not ds.bof ) and
                    (Not ds.IsUniDirectional)
                 then begin
                        ds.Prior;
                        if not Bof
                        Then Result := GetRec(ds.Bookmark)
                        else Result := false;
                       end
                 else begin
                        Ds.First;
                        Result := GetRec(ds.Bookmark);
                        Result := false;
                      end;
               except
                 result := false;
               end;

               If Not Result
               Then begin
                      DoOnEnter(self);
                      Ds.First; // Mantém o curso no primeiro pq o OnEnter pode mudar
                    end
               else DoOnEnter(self);

               UpdateCommands;
             end
        else result := false;
      end;

      function TUiDmxScroller.LastRec: Boolean;
         var
           ds : TDataSet;
      begin
        if isDataSetActive
        then begin
               try
                 ds := GetDataSet;
                 DoOnExit(self);
                 try
                   if IsEmpty
                   Then begin
                          Result := false;
                          exit;
                        end
                   else if Appending
                        Then Appending := false;

                   if not ds.Eof
                   Then begin
                          ds.Last;
                          Result := GetRec(ds.Bookmark);
                        end
                   Else begin
                          ds.Last;
                          Result := GetRec(ds.Bookmark);
                          Result := false;
                        end;

                 except
                   result := false;
                 end;

               finally
                 if not Result
                 Then begin
                        DoOnEnter(self);
//                        ds.Last;//Se lastRec for igual a false é porque está no utimo.
                      end
                 else DoOnEnter(self);

                 UpdateCommands;
               end;
        end
        Else result := false;
      end;

      function TUiDmxScroller.GetEof: Boolean;
      begin
        if isDataSetActive
        then result := DataSource.DataSet.Eof
        else result := true; //Retorna true indicando que está no Eof.
      end;

      procedure TUiDmxScroller.SetCurrentBookmark(aCurrentBookmark: TBookMark);
        Var
          ds : TdataSet;
      begin
        if isDataSetActive
        then begin
               ds:= GetDataSet;
               if not (ds.State in [dsInsert])
               Then begin
                       if ds.BookmarkValid(aCurrentBookmark)
                       Then begin
                              _CurrentBookmark_old  := _CurrentBookmark;
                              _CurrentBookmark := aCurrentBookmark;
                              ds.Bookmark := _CurrentBookmark;
                            end
                       else begin
                              writeln('Raise TException.Create(self,',{$I %CURRENTROUTINE%} );
                              //Raise TException.Create(self,{$I %CURRENTROUTINE%},'Bookmark inválido!');
                            end;
                    end;
//               else Raise TException.Create(self,{$I %CURRENTROUTINE%},'Chamada o método inválida!');
             end;
      end;

      function TUiDmxScroller.GetRec(aBookmark : TBookMark): Boolean;
      begin
        if isDataSetActive
        then begin
               if Appending
               Then raise TException.Create(self,{$I %CURRENTROUTINE%},'Não posso executar o método no modo appendind!');

               if DataSet_BookmarkValid(aBookmark)
               Then begin
                      try
                        CurrentBookmark := aBookmark;
                        if GetBuffers
                        then begin
                               RecordSelected:=true;
                               Result := true;
                             end
                        else begin
                               result := false;
                               RecordSelected:=false;
                             end;

                      Except
                         On E : Exception do
                         begin
                            raise TException.Create(self,{$I %CURRENTROUTINE%},E.Message);
                         end;
                      end;
                    end;
             //  else raise TException.Create(self,{$I %CURRENTROUTINE%},'Bookmark inválido!');
             end
        else result := false;
      end;

      procedure TUiDmxScroller.Cancel;
      begin
        if isDataSetActive
        then begin
                if Appending
                Then begin
                       CancelBuffers;
                       DataSet_Cancel;
                       DoOnNewRecord;
                     end
                else begin
                       CancelBuffers;
                       DataSet_Cancel;
                       GetRec(GetDataSet.Bookmark);
                     end;
                ChangeMadeOnOff(false);
                RefreshInternal;
              end;
      end;

       var
        reintrance_Refresh_Internal : Boolean = false;
      procedure TUiDmxScroller.RefreshInternal;
        Var
          CurrenteKeyValue : variant;
          CurrentKeyPrimary : AnsiString;
          ds : TdataSet;
      begin
        if (not reintrance_Refresh_Internal) and isDataSetActive
            and (Not GetState(Mb_St_Creating )) and (not ControlsDisabled)
        Then Try
               ds := GetDataSet;
               reintrance_Refresh_Internal := true;
               if (not Appending) and GetRecordSelected
               then begin
                      CurrentKeyPrimary := getFieldsKeys(CurrenteKeyValue) ;
                      if (CurrentKeyPrimary <> '') and
                          (not VarIsEmpty(CurrenteKeyValue))
                      Then begin
                             ok := ds.Locate(CurrentKeyPrimary,CurrenteKeyValue,[loCaseInsensitive]);  //loPartialKey
                             if ok
                             then ok := GetRec(ds.Bookmark);
                             if ok
                             then _CurrentBookmark := ds.Bookmark
                             else begin
                                    ok := NextRec;
                                    if not ok
                                    Then begin
                                           ok := PrevRec;
                                           if ok
                                           then _CurrentBookmark := ds.Bookmark;
                                        end;
                                  end;
                             if ok
                             then ok := ds.BookmarkValid(_CurrentBookmark);

                             if ok
                             then ok := GetRec(CurrentBookmark);

                           end
                      else begin
                             ok := GetRec(ds.Bookmark);
                           end;
                    end
               else begin
                      ok := false;
                    end;

             finally
               UpdateCommands;
               reintrance_Refresh_Internal := False;
             end;
      end;

      var
        reintrance_Refresh : Boolean = false;
      procedure TUiDmxScroller.Refresh;
        Var
          CurrenteKeyValue : variant;
          CurrentKeyPrimary : AnsiString;
          ds : TDataSet;
      begin
        if (not reintrance_Refresh) and (not ControlsDisabled)
        Then try
               ds := GetDataSet;
               reintrance_Refresh := true;

               if isDataSetActive
               Then begin

                      If Appending
                      Then begin
                             DataSet_Cancel;
                             Appending := false;
                          end;

                      CurrentKeyPrimary := getFieldsKeys(CurrenteKeyValue);
                      If Not _BufDataset_created
                      Then begin
                             ds.Active:=false;
                             ds.Active:=true;
                           end;

                      if Not Appending
                      then begin
                             if CurrentKeyPrimary <> ''
                             Then begin
                                    ok := ds.Locate(CurrentKeyPrimary,CurrenteKeyValue,[loCaseInsensitive]);  //loPartialKey
                                    if not ok
                                    then begin
                                           ok := NextRec;
                                           if not ok
                                           Then ok := PrevRec;
                                         end
                                    else ok := GetRec(ds.Bookmark);
                                 end
                            else begin
                                   if DataSet_BookmarkValid(ds.Bookmark)
                                   Then ok := GetRec(ds.Bookmark)
                                   else ok := false;
                                 end;
                          end
                      else ok := true;
                    end
               else ok := true;

             finally
               edit;//Caso não coloque em modo edit após refrescar os dados o próximo acesso gera exceção.
               reintrance_Refresh := false;
             end;
      end;

      function TUiDmxScroller.DoBeforeInsert: Boolean;
        var
          F : pDmxFieldRec;
          OkPutBuffer:Boolean = false;
          s : AnsiString;
      begin
        if Application.GetTypeApplication <> Application.TEnumApplication.EnApp_LCL_Http_Client
        Then begin
                f := FieldByName('ID');
                if Assigned(f)
                Then begin
                       //s := f.Value;
                       //s := IntToStr(GetRecNo);
                       f.Value := GetRecNo;
                       OkPutBuffer:=true;
                     end;
             end;

        if Assigned(onBeforeInsert)
        then begin
              Result := onBeforeInsert(self);
              If result
              Then OkPutBuffer:=true;
             end
        else Result := true;

        if OkPutBuffer
        Then PutBuffers;
      end;

      function TUiDmxScroller.DoAfterInsert: Boolean;
      begin
        if Assigned(onAfterInsert)
        then begin
              Result := onAfterInsert(self);
              if result
              Then PutBuffers;
             end
        else Result := true;
      end;

      function TUiDmxScroller.DoBeforeUpdate: Boolean;
      begin
        if Assigned(onBeforeUpdate)
        then begin
              result := onBeforeUpdate(self);
              if result
              Then PutBuffers;
             end
        else result := true;
      end;

      function TUiDmxScroller.DoAfterUpdate: Boolean;
      begin
        if Assigned(onAfterUpdate)
        then begin
              result := onAfterUpdate(self);
              if result
              Then PutBuffers;
             end
        else result := true;
        UpdateCommands;
      end;

      function TUiDmxScroller.DoBeforeDelete: Boolean;
      begin
        if Assigned(onBeforeDelete)
        then begin
              result := onBeforeDelete(self);
             end
        else result := true;
      end;

      function TUiDmxScroller.DoAfterDelete: Boolean;
      begin
        if Assigned(onAfterDelete)
        then begin
              result := onAfterDelete(self);
             end
        else result := true;
      end;

      var reintrance_DoCalcFields_all : Boolean = false;
      procedure TUiDmxScroller.DoCalcFields(aWorkingData: Pointer);
        var
          wWorkingData    : pointer;
          wWorkingDataOld : pointer;
          I : Integer;
          wCurrentField : pDmxFieldRec;
          nr : PtrInt;
          wControlsDisabled : Boolean;
      begin
        if isDataSetActive and
           (not reintrance_DoCalcFields_all) and
           (Not GetState(Mb_St_Creating)) //and
//           (GetDataSet.State in [Ds])
        then try
               wControlsDisabled := ControlsDisabled;
               if not wControlsDisabled
               Then DisableControls;

               reintrance_DoCalcFields_all := true;
               wWorkingData   := WorkingData;
               wWorkingDataOld:= WorkingDataOld;

               WorkingData := aWorkingData;
               wCurrentField := CurrentField;

               //for nr := DataFields.Count-1 downto 0 do
               //begin
               //  SetCurrentField(DataFields.GetRec(nr));
               //  //Entra entra e sai de cada campo
               //  CurrentField.DoOnEnter(self);
               //  CurrentField.DoOnExit(self);
               //end;

             finally
               WorkingData   := wWorkingData;
               WorkingDataOld:= wWorkingDataOld;
               reintrance_DoCalcFields_all:=false;
               if not wControlsDisabled
               Then EnableControls;
               SetCurrentField(wCurrentField);
             end;
      end;

      procedure TUiDmxScroller.DoCalcFields;
      begin
        DoCalcFields(WorkingData);
        if Assigned(onCalcFields)
        then onCalcFields(self);

      end;

      procedure TUiDmxScroller.DoChangeField(aField: pDmxFieldRec);
      begin
        if aField.FieldAltered  and Assigned(onChangeField)
        then onChangeField(aField);
      end;

    {$ENDREGION ' Implementação Método de atualização no banco de dados'}

    {$REGION ' Implementação dos comandos EnableControls e DisableControls'}

      procedure TUiDmxScroller.EnableControls;
      begin
        if isDataSetActive
        Then GetDataSet.EnableControls;
        Locked:=false;
        SetState(Mb_St_ControlsEnabled,true);
      end;

      procedure TUiDmxScroller.DisableControls;
      begin
        if isDataSetActive
        Then GetDataSet.DisableControls;
        Locked:=true;
        SetState(Mb_St_ControlsEnabled,false);
      end;

      function TUiDmxScroller.ControlsDisabled: Boolean;
      begin
        if Assigned(Parent)
        Then begin
                if GetState(Mb_St_ControlsEnabled)
                Then Result := False
                else Result := true;
             end
        else Result := true;
      end;

      function TUiDmxScroller.SaveTemplate(aFileName: AnsiString;adataformat: AnsiString): Boolean;

        Function Decodifica_caractere_de_controle:AnsiString;
           Var
             i: Integer;
        begin
          Result := '';
          if Length(adataformat) > 0
          Then For i := 1 to Length(adataformat) do
               begin
                 case adataformat[i] of
                 ^A : result := result + '^A';
                 ^B : result := result + '^B';
                 ^C : result := result + '^C';
                 ^D : result := result + '^D';
                 ^E : result := result + '^E';
                 ^F : result := result + '^F';
                 ^G : result := result + '^G';
                 ^H : result := result + '^H';
                 ^I : result := result + '^I';
                 //^J : result := result + '^J';
                 ^K : result := result + '^K';
                 ^L : result := result + '^L';
                 //^M : result := result + '^M';
                 ^N : result := result + '^N';
                 ^O : result := result + '^O';
                 ^P : result := result + '^P';
                 ^Q : result := result + '^Q'; //Livre
                 ^R : result := result + '^R';
                 ^S : result := result + '^S';
                 ^T : result := result + '^T';
                 ^U : result := result + '^U';
                 ^V : result := result + '^V';
                 ^W : result := result + '^W';
                 ^X : result := result + '^X';
                 ^Y : result := result + '^Y';
                 ^Z : result := result + '^Z';

                 else result := result + adataformat[i];
               end;
             end;
        end;

        Var
          f : TextFile;
          err:Integer;
          s : ansiString;
      begin
        s := ExpandFileName(aFileName);
        if Not FileExists(s)
        Then begin
               AssignFile(f,s);
               try
                 {$i+}Rewrite(f);{$i-}
                 err := IoResult;
                 if Err = 0
                 Then begin
                        {$i+}WriteLn(f,Decodifica_caractere_de_controle);{$i-}
                        err := IoResult;
                        if Err<>0
                        Then Raise TException.Create(self,{$I %CURRENTROUTINE%},s,'',err);
                      end
                 else Raise TException.Create(self,{$I %CURRENTROUTINE%},s,'',err);

                 {$i+}close(f);{$i-}
                 err := IoResult;
                 if Err<>0
                 Then Raise TException.Create(self,{$I %CURRENTROUTINE%},s,'',err);

              except
                 On E : Exception do
                 begin
                   ShowMessage(e.Message);
                 end;
              end;

              if Err = 0
              Then Result := true
              else Result := false;
             end
        else Result := false;
      end;

      procedure TUiDmxScroller.SetTMiDataPacketFormat(aMiDataPacketFormat: TMiDataPacketFormat);
        Var
          ds : TMiBufDataset;
      begin
        if _BufDataset_created
        Then ds := GetDataSet as TMiBufDataset
        else exit;

        if _MiDataPacketFormat_Default = aMiDataPacketFormat
        Then exit;
        _MiDataPacketFormat_Default := aMiDataPacketFormat;

        Case _MiDataPacketFormat_Default of
           dfBinary : ds._FileName := TableName+'.bds';
           dfXML    : ds._FileName := TableName+'.xml';
           dfXMLUTF8: ds._FileName := TableName+'.xml';
           dfAny    : ds._FileName := TableName+'.xml';
           dfDefault: ds._FileName := TableName+'.xml';
           dfJSon   : ds._FileName := TableName+'.json';
        end;
      end;

    {$ENDREGION ' Implementação dos comandos EnableControls e DisableControls'}


    function TUiDmxScroller.GetModified: Boolean;
      Var
        i : Integer;
        fld : PDmxFieldRec;
    begin
      for i := 0 to Fields.Count-1 do
      begin
        fld := Fields[i];
        if fld^.Fieldnum <>0
        then begin
               If fld.FieldAltered
               Then begin
                      Result := true;
                      exit;
                    end;
             end;
      end;
      result := false;
    end;

    function TUiDmxScroller.GetCanModify: Boolean;
    begin
      result :=  isDataSetActive and (GetDataSet.CanModify);
    end;

    procedure TUiDmxScroller.UpdateDataField_AliasList;
     var
       I : Integer;
       DmxFieldRec : pDmxFieldRec;
       s:String;
    begin
      ok := DataFields.ClearKey;
      while ok do
      begin
         DmxFieldRec := DataFields.getRec;
         If DmxFieldRec.TypeCode in [FldRadioButton]
         Then for i := 0 to Fields.Count-1 do
              begin //Atualiza AliasList
                 if Assigned(PDmxFieldRec(Fields[i])) and
                    (PDmxFieldRec(Fields[i]).Fieldnum<>0) and
                    (PDmxFieldRec(Fields[i]).Fieldnum=DmxFieldRec.Fieldnum)
                Then begin
                       s := trim(PDmxFieldRec(Fields[i]).Alias);
                       if (s<>'') and Assigned(DmxFieldRec^.AliasList)
                       Then begin
                              DmxFieldRec^.AliasList.Add(s);
                            end;
                     end;
              end;
         ok := DataFields.NextKey;
      end;
    end;


  {$EndRegion 'TUiDmxScroller'}


  //======================================================

initialization

  //with TDates do
  //  SetDefaultFormatSettings(TMask.Mask_dd_mm_yyyy);
  //
end.
