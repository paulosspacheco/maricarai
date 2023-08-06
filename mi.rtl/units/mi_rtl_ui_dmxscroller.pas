unit mi_rtl_ui_Dmxscroller;
{TODO -oOwnerName -cCategoryName: Todo_text}
{DONE -oOwnerName -cCategoryName: Todo_text}
//#todo -oOwnerName -cCategoryName: Todo_text
{#done -oOwnerName -cCategoryName: Todo_text}

  {:< A unit **@name** implementa a classe TUiDmxScroller e registro TDmxFieldRec.

    - **ORIGEM DESTA IDEIA**:
      - Este projeto foi criado baseado na ideia do projeto:
        - [TvDmx](https://www.pcorner.com/list/PASCAL/TVDMX.ZIP/INFO)

    - **VERSÃO**
      - Alpha - Alpha - 0.8.0

    - **HISTÓRICO**
      - @html(<a href="../units/mi_rtl_ui_dmxscroller_historico.html">./mi_rtl_ui_dmxscroller_historico.html </a>)   
   
    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi_rtl_ui_dmxscroller.pas">mi_rtl_ui_DmxScroller.pas</a>)


    - **PENDÊNCIAS**

       - T12 Quando uma linha em um label tem muitos caracteres de 2 bytes os últimos não são interpretados.

       - T12 Implementar o campo FldLink. (Esse campo executa um ação usando controle TStaticText.

       - T12 O controle TComboBox da LCL alterar o tamanho da fonte courie New caso o tema do
         sistema mude.
         - Pesquisar sobre o assunto.

       - T12 No método SetString em caso de erro de gera exceção informando valor máximo
         do campo  e não o valor digitado.

       - T12 Implementar o evento OnChange em todos os controles, visto que o mesmo
         é mais fácil criar lógica de negócios visto que o mesmo só é executado
         se o campo for modificado.

       - T12 Implementar a possibilidade das fontes do label ser personalizada
             baseado em um estilo que pode ser uma variável global.

         -  Suponha que ^Z = <h1> Título e ^D = <B> de negrito então o sistema
            informa a TDmxFieldRec.Style = nome do estilo onde nome do estilo = 'Font = FonteX; Size= XX; etc..  '

            - Exemplo:

             ~^ZCADASTRO DE ALUNOS~

             ~^DÑome do Aluno:~\ssssssssss


      - T12 Na construção do formulário LCL setar o campo PDmxFieldRec.LinkEdit;

      - T12 Implementar o método: function FieldByNum(aFieldnum:Integer):PDmxFieldRec;

      - T12 Implementar a edição **FldBoolean**.
        - Os campo Boolean deve ser editados como uma campo enumerado onde:
          - 0 - False; não
          - 1 = True;  sim

      - T12 O campo fld_LHora não inicializado antes de compactar a hora.

      - T12 Quando o usuário teclar tab para passar o campo e o campo seguinte não
            estiver visível o sistema deve passar a página do  controle parent.

      - T12 Implementar a edição de campo **FldMemo**.

      - T!2 Implementar a campo **fldBLOb**;

      - t12 Implementar a edição de **fldHexValue**.
        - O campo Hexadecimal deve ser campo longint mais a edição é uma string comum . FldStr


      - T12 Implementar a propriedade  AlignmentLabels := taCenter;
                                       AlignmentLabels := taLeftJustify;
                                       AlignmentLabels := taRightJustify ;

      - T12 Implementar  a execução do evento do tipo CharExecProc quando a tecla F7
            é pressionada.

      - T12 Criar opção para gerar cliente HTML a partir de TDmxScroller
        - Referência: [Componente que espoe dados para o browser](https://wiki.freepascal.org/SqlDbRestBridge#Purpose)

      - T12 O grupo TMi_RadioGroup_Lcl não é selecionado com a tecla na tecla **TAB**
        - Quando os botões TRadioButton estão dentro do TRadioGroup  a propriedade
          TRadioGroup.TabStop não funciona.

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
        - T12 O campo FldCheckBox não está funcionando o flag charHint  ✅️.

        - T12 Implementar o controle ChatHint no Template para seja possível passar
              um documento markdown pelo Template; ✅️.

        - T12 Ao executar o evento OnExit é necessário o redraw em de todos os campo caso
              haja alteração ao retorna da chamada. ✅️.

        - T12 O componente TMi_ui_Button_lcl não está na lista dos campos 
              selecionados na tecla tab. ✅
        - T12 Os campos FldEnum não estão mostrando o help.  ✅

        - T12 Criar a propriedade Locked;  ✅

        - T12 No pacote mi.rtl.ui, transferir toda dependência do pacote LCL para o pacote mi.rtl.form.
}


{$REGION ' Trabalhos do dia.'}
{# HISTÓRICO

  - **2023-04-03**
    - **16:20**
      - Todas a unit Mi.rtl.ui devem ficar dentro do pacote mi.rtl   ✅
      - Toda a referência da LCL dentro do pacote mi.rtl.ui devem ser transferias para mi.rtl .
        Motivo: Criar Mi.rtl.web. ✅


}


{$ENDREGION 'Trabalhos do dia'}



{$mode Delphi}

interface

uses
  Classes, SysUtils
  //, dialogs
//  ,controls
//  ,forms
  //,ActnList
  ,db,BufDataset,SqlDb
  ,mi.rtl.Objects.Consts.Mi_MsgBox
  ,mi.rtl.objects.Methods.dates
  ,mi_rtl_ui_Types
  ,mi.rtl.Consts
  ,mi_rtl_ui_methods;


  type PSItem =  TUiMethods.PSItem;
  type tString =  TUiMethods.tString;
  type ptString = TUiMethods.Ptstring;
  type TDates = TUiMethods.TDates;
  type PValue = TUiMethods.PValue;
  type TValue = TUiMethods.TValue;
//  type PAction = ^TAction;


  const AccNormal  = TUiMethods.AccNormal;
  const LF        = TConsts.LF;

  type
    { TUiDmxScroller }
    TUiDmxScroller = class;

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
               add('~Valor Smallword....:~\WW,WWW');
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
        {: O tipo **@name** aponta para o campo do tipo TDmxFieldRec }
        pDmxFieldRec = ^TDmxFieldRec;

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
        }      
        TDmxFieldRec = Record //Esta estrutura não pode ser object pq não funciona.

           {: Componente corrente que está editando esse campo.}
           public LinkEdit      :  TComponent;

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
           public Next          :  pDmxFieldRec; //:< Próximo campo
           public RSelf         :  pDmxFieldRec; //:< Usado para referenciar-se a si mesmo.
           public Prev          :  pDmxFieldRec; //:< Campo anterior
           public access        :  byte;         //:< read-only, hidden, skip, accSpecX
           public Fieldnum      :  Integer;      //:< Número do campo, varia de 1 a totalFields (Se zero (0) é porque trata-se um rótulos)
           public ScreenTab     :  integer;      //:< Override column num.
           public ColumnWid     :  byte;         //:< width of Field column
           public ShownWid      :  byte;         //:< visible width of column
           public TypeCode      :  AnsiChar;     //:< 's', 'r', etc.

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
           public DataTab       :  integer;      //:< position in record
           public Template      :  ptString;     //:< Field Template

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

           {$Region ID_Dynamic}
             Private _ID_Dynamic  : AnsiString; // Usado para gerar paginas html dinamicamente
             Public Property ID_Dynamic : AnsiString Read _ID_Dynamic Write _ID_Dynamic;
           {$EndRegion ID_Dynamic}

           {$Region owner}
             private _owner :  TUiDmxScroller;
             private Procedure Set_owner(a_owner:TUiDmxScroller);
             public property owner :  TUiDmxScroller read _owner write Set_owner;
           {$EndRegion owner}

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

                         Result := NewSItem('~Cliente:~'+'\LLLLL'+CreateExecAction('Cliente',Pesquisa.Name),nil);

                      ```
                      
                 2. Se o atributo **Fieldnum** do campo for igual a zero,
                    então a rótulo do botão será o rótulo do campo.
                    - No exemplo a seguir um rótulo de novo cliente (icons  🆕) e um botão ok (icons 🆗) 

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
           public CharShowPassword   :  AnsiChar;   //<Se "CharShowPassword" = ^W então em FieldText imprime "CharShowPasswordAnsiChar" por tratar-se de uma senha


         //public DmxFieldRec_IE : TDmxFieldRec_IE;//< Campo de um formulário HTML associado a TDmxFieldRec.
           public _DateMask : TDates.TDateMask;{<NortSoft}
           public _HourMask : TDates.THourMask;{<NortSoft}
           public QuitFieldAltomatic : Boolean; {<NortSoft: Se true os campos Strings passa para o próximo campo quando o cursor estiver na ultima posição e um novo caractere for digitado}

           {: Posição do curso quando este campo estiver sendo editado.}
           Public CurPos          : integer;

           {: Posição do início da seleção quando este campo estiver sendo editado.}
           public SelStart        : Integer;

           {: Posição do fim da seleção quando este campo estiver sendo editado.}
           public SelEnd          : Integer;

           {$REGION 'Construção Propriedade FieldAltered'}
             private public _FieldAltered   : Boolean;
             private function GetFieldAltered:Boolean;

             {: A propriedade **@name** Indica que o campo foi alterado.
                Deve ser atualizado na visão caso a tabela esteja em modo de edição.
             }
             public property FieldAltered : Boolean read GetFieldAltered write _FieldAltered;
           {$ENDREGION 'Construção Propriedade FieldAltered'}

          {: O campo **@name** contém a documentação resumida do registro.  }
           public HelpCtx_Hint : AnsiString;

           public HelpCtx_Porque    : AnsiString; //:< Por que preciso deste campo?
           public HelpCtx_Onde      : AnsiString; //:< Onde esse campo será usado?
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
             {: O método **@name** é usado para habilitar ou não em GetString
             a mascara em campos numéricos.}
             public Property OkMask : Boolean read _OkMask write _okMask;
           {$ENDREGION 'Construção Propriedade OkMask'}

           public function StrNumberValid(S: AnsiString):AnsiString;

           public Function GetAsStringFromBuffer(aWorkingData : pointer):AnsiString;

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
           public function IsInputDbRadio:Boolean;
           public function IsInputCheckbox:Boolean;
           public function isInputPassword:Boolean;
           public function IsInputHidden:Boolean;

           {: O objeto filho que implementar um ISelect deve anular e retornar
             a interface ISelect;}
           public function IsSelect:Boolean;

           {: Usado quando trata-se de campos enumerados.}
           public function IsComboBox:Boolean;

           Public function FirstField : pDmxFieldRec;
           Public function LastField  : pDmxFieldRec;
           Public function NextField  : pDmxFieldRec;
           Public function PrevField  : pDmxFieldRec;
           Public Function SelectFirstField  : pDmxFieldRec;
           Public Function SelectLastField  : pDmxFieldRec;
      //         private Var _Vidis_Select:boolean;
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

           Public function IsData: Boolean;
           Public function IsHora: Boolean;


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
           public function Valid(Command: Word): Boolean;

           {$REGION ' ---> Property vidis_OnEnter : Boolean '}

             strict Private Var _vidis_OnEnter : Boolean ;
             strict Private Function  Getvidis_OnEnter : Boolean;
             strict Private Procedure Setvidis_OnEnter (avidis_OnEnter : Boolean );
             Public

             {: A propriedade **@name** usado para evitar reentrância do evento DoOnEnter()
             }
             property  vidis_OnEnter: Boolean Read Getvidis_OnEnter   Write  Setvidis_OnEnter;
           {$ENDREGION}

           {$REGION ' ---> Property vidis_OnExit : Boolean '}
             strict Private Var _vidis_OnExit : Boolean ;
             strict Private Function  Getvidis_OnExit : Boolean;
             strict Private Procedure Setvidis_OnExit (avidis_OnExit : Boolean );

             {: A propriedade **@name** é usado para evitar reentrância do evento DoOnExit()
             }
             Public property  vidis_OnExit: Boolean Read Getvidis_OnExit   Write  Setvidis_OnExit;
           {$ENDREGION}

           {: O método **@name** é executado toda vez antes do controle ler do buffer do campo.
              - Se o TUiDmxScroller.OnEnterField tiver assinalado o método **@name** o executa.
           }
           Public procedure DoOnEnter(Sender: TObject);

           {: O método **@name** é executado toda vez antes do controle gravar no buffer do campo.
              - Se o TUiDmxScroller.OnExitField tiver assinalado o método **@name** o executa.
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
      end;

    {$ENDREGION '<-- declaração do record TDmxFieldRec'}

    {$REGION '<-- declaração do tipo de eventos'}

      {: O tipo **@name** é usado para implementar evento onEnter da classe TUiDmxScroller }
      TOnEnter = Procedure(aDmxScroller:TUiDmxScroller) of Object;

      {: O tipo **@name** é usado para implementar evento onExit da classe TUiDmxScroller }
      TOnExit = Procedure(aDmxScroller:TUiDmxScroller) of Object;

      {: O tipo **@name** é usado para implementar evento onNewRecord da classe TUiDmxScroller }
      TOnNewRecord = Procedure(aDmxScroller:TUiDmxScroller) of Object;

      {: O tipo **@name** é usado para implementar evento OnCloseQuery da classe TUiDmxScroller

         - **NOTA*
           - Este evento é disparado antes de desativar a classe **TUiDmxScroller**.
             - Obs: Se o parâmetro **CanClose** for **false**, então a classe **TUiDmxScroller** não é desativado.

      }
      TOnCloseQuery = Procedure(aDmxScroller:TUiDmxScroller; var CanClose:boolean) of Object;

      {: O tipo **@name** é usado no evento OnEnterField}
      TOnEnterField = Procedure(aField:pDmxFieldRec) of Object;

      {: O tipo **@name** é usado no evento OnExitField}
      TOnExitField = Procedure(aField:pDmxFieldRec) of Object;

    {$ENDREGION '<-- declaração do tipo de eventos'}

    {TUiDmxScroller}
    {: A classe **@name** tem como objetivo criar um formulário baseado em
       uma lista do tipo ShortString.

       - **NOTAS**
         - O método createStruct criar uma lista de campo tipo TDmxFieldRec com
           todas as informações necessárias para criar uma tabela ou um formulário.

         - O formulário é criado com apena uma linha.

       - **EXEMPLO**:
         - Template := '~Nome~\SSSSSSSSSSSSSSSSSSSS ~Idade:~\BB'
           - A classe cria a lista de campos:
             - Label1: Nome
             - Field1: campo ShortString com 20 posições maiúsculas
             - Label2: Idade
             - Field2: Campo byte com duas posições
    }
    TUiDmxScroller = class(TUiMethods)

        {: O método **@name** inicia a documentação resumida do campo. aFldNum }
        Public Function SetHelpCtx_Hint(aFldNum:Integer;a_HelpCtx_Hint:AnsiString):pDmxFieldRec;virtual;overload;

          {: O método **@name** inicia a documentação resumida do campo passado em :apDmxFieldRec}
        Public Procedure SetHelpCtx_Hint(apDmxFieldRec:pDmxFieldRec;a_HelpCtx_Hint:AnsiString);virtual;overload;

        {: O atributo **@name** contém uma lista pDmxFieldRec cujo
           **Fieldnum<>0**.

           - Essa lista é atualizada em createStruct
        }
        public Fields : TFPList;

        {: Como redefinir o dispose, redefini também o new, para manter um padrão.}
        private Procedure New(Var apDmxFieldRec: pDmxFieldRec);

        {: Necessário para desalocar alguns campos que system.dispose não
           desaloca.}
        private Procedure Dispose(Var apDmxFieldRec: pDmxFieldRec);

        public Limit : TPoint;
        Public CreateValid : boolean ; //:< Deve ser true ao criar a classe

        protected WorkingData   : pointer;
        protected WorkingDataOld   : pointer; //Buffer com os dados anterior

        protected DataBlockSize : longint;

        Public ActualRecordNum : longint;

        {: O atributo **@name** contém o primeiro campo da lista encandeada}
        Public DMXField1     : pDmxFieldRec;
        private LeftField    : pDmxFieldRec;

        {: O atributo **@name** contém o total de campos da lista apontada por DMXField1}
        Public TotalFields   : integer;

        {: O atributo **@name** contém  o tamanho do buffer calculado por CreateStruct}
        Public RecordSize    : integer;

        {: O atributo **@name** contém o ponteiro do buffer do corrente campo calculado pela propriedade CurrentField}
        Public FieldData       : pointer;

        Public RecordData      : pointer;

        Private CurrentRecordOld : Longint;
        Private _CurrentRecord : Longint;
        Protected Procedure SetCurrentRecord (aCurrentRecord : Longint );Virtual;
        public property CurrentRecord : Longint read _CurrentRecord write SetCurrentRecord;

        private _AlignmentLabels : TAlignment;

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
             - Se pos(',',@name) <> 0 indica que a chave é composta.
        }
        protected keysPrimaryKeyComposite : AnsiString;

        protected flagPrimaryKey_AutoIncrement:Boolean;

        protected procedure ShowControlState;Virtual;//abstract;

        {$REGION ' ---> Property Strings : TMiStringList '}

           private _Strings : TMiStringList;

           Private Function GetStrings:TMiStringList;
           Private Procedure SetStrings(a_Strings : TMiStringList);
           {: A propriedade **@name** o Strings é usada para editar o
              Template em tempo de projeto.
           }
           published property Strings : TMiStringList Read GetStrings   Write  SetStrings;

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

        public Procedure UpdateBuffers;Virtual;//abstract;

        public procedure Refresh;VIRTUAL;//abstract;

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

        {$REGION '--> propriedade DoOnNewRecord_FillChar'}
          Private _DoOnNewRecord_FillChar : Boolean;
          Private Procedure  SetDoOnNewRecord_FillChar(Const a_DoOnNewRecord_FillChar : Boolean);
          public Property DoOnNewRecord_FillChar : Boolean Read _DoOnNewRecord_FillChar Write SetDoOnNewRecord_FillChar default True;
        {$ENDREGION '--> propriedade DoOnNewRecord_FillChar'}

        {$REGION '--> propriedade RecordSelected'}

              Private var _RecordSelected  : boolean;
              protected Function GetRecordSelected : boolean;Virtual;

              protected Procedure SetRecordSelected(a_RecordSelected  : boolean);Virtual;
              protected property RecordSelected  : boolean read GetRecordSelected  Write SetRecordSelected default false;

        {$ENDREGION '--> propriedade RecordSelected'}

        {: O método **@name** seta os atributos indicativos de que o objeto foi alterado ou não.}
        procedure ChangeMadeOnOff(const aValue:Boolean);

        {$REGION '--> propriedade OnNewRecord'}

            Private var _OnNewRecord  : TOnNewRecord;

            {: A propriedade **@name** é executada em DoOnNewRecord se a mesma for assinalada.}
            Public property OnNewRecord  : TOnNewRecord read _OnNewRecord  Write _OnNewRecord;

        {$ENDREGION '--> propriedade OnNewRecord'}

        {: O método **@name** é usado para inicializa os parâmetros de um novo registro }
        public Procedure DoOnNewRecord;overload;Virtual;

        {$REGION '--> atributo Status'}

          {: O método **@name** seta o bit passado no parâmetro aState e retorna o estado anterior
             do mapa de bits passado por aState}
          protected Function SetState(Const AState: Int64; Const Enable: boolean):Boolean;virtual;

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

        {: O método **@name** copia o buffer do registro atual para o buffer do registro anterior

           - **OBSERVAÇÃO:**
             - O método **@name** deve ser anulado para ler o buffer dos campos dos arquivos associados
           a classe **TUiDmxScroller**  para o buffer dos campos da classe **TUiDmxScroller**
        }
        protected function GetBuffers:Boolean;Virtual;

        {: O método **@name** deve ser anulado para grava o buffer dos campos da classe **TUiDmxScroller** para
           o buffer dos campos dos arquivos associados a classe **TUiDmxScroller**}
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

        {$REGION '--> Property onEnter'}
          protected _OnEnter : TOnEnter;

          {: O evento **@name** é disparado toda vez que o TUiDmxScroller ativado.}
          public Property onEnter : TOnEnter Read _OnEnter write _onEnter;

          {: O método **@name** é usado para da o scroller na janela onde esse componente for inserido.
             - **NOTA**
                - A LCL não rola a tela com a tecla tab e o controle não estiver visível.
          }
          public procedure Scroll_it_inview(AControl: pDmxFieldRec);virtual;

          {: O método **@name** Executa o evento onEnter se o mesmo estiver assinalado. }
          public Procedure DoOnEnter(aDmxScroller:TUiDmxScroller);Virtual;
        {$ENDREGION '<-- Property onEnter'}

        {$REGION '--> Property onExit'}
          protected _OnExit : TOnExit;

          {: O evento **@name** é disparado toda vez que o TUiDmxScroller é destivado.}
          public Property onExit : TOnExit Read _OnExit write _onExit;
          public Procedure DoOnExit(aDmxScroller:TUiDmxScroller);
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

        {: O método **@name** é usado para criar os campos de **BufDataset**}
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
           protected function GetTemplate(aNext: PSItem) : PSItem;overload;virtual;//abstract;

        {$ENDREGION ' <--- Property onGetTemplate : TGetTemplate '}

        {$REGION ' ---> Property onAddTemplate : TAddTemplate '}
           {: O Atributo **@name** é um ponteiro para o método TonAddTemplate.}
           private _onAddTemplate : TonAddTemplate;

           {A propriedade **@name** permite adicionar linhas a propriedade strings usando o método TUiDmxScroller.Add  }
           Public property onAddTemplate: TonAddTemplate read _onAddTemplate write _onAddTemplate;
        {$ENDREGION ' <--- Property onAddTemplate : TAddTemplate '}


        {$REGION --> Propriedade Active}

          {: O atributo **name** é usado para criar a propriedade active do componente

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

          public property Active : Boolean Read _Active Write SetActive;
        {$ENDREGION --> Propriedade Active}

        {$REGION --> Propriedade CurrentField}
            protected _CurrentField  : pDmxFieldRec;
            protected Procedure SetCurrentField(aCurrentField : pDmxFieldRec);
            {: A propriedade **@name** contem um ponteiro para o campo selecionado }
            public property CurrentField : pDmxFieldRec  read _CurrentField write SetCurrentField;
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

        {: A função **@name** retorna a string com o valor do currentField sem preencher com espaço para completar a máscara.
        }
        public Function GetString : TString;virtual;overload;

        {: A função **@name** salva a string **S** no currentField usando **okspc** = false;

           - **PARÂMETROS**
             - S  : String do tipo ShortString com conteúdo do campo.
        }
        public function PutString(const S : ShortString):SmallInt;virtual;overload;

        public property AlignmentLabels : TAlignment read _AlignmentLabels write _AlignmentLabels;

        {: O método **@name** receber a máscara do DmxScroller e  retorna a mascara  do componente LCL.

           - **Nota**
             - Em **Size_TypeFld** retorno o tamanho do tipo de dados da mascara;
             - Em **OkMask** retorna **true** se tiver mascara e **false** caso contrário
        }
        public  Function Get_MaskEdit_LCL(aTemplate : ShortString;
                                          out Size_TypeFld,
                                              aLength_Buffer : SmallWord;
                                          out OkMask : Boolean) : AnsiString;overload;

        {: O método **@name** receber a máscara do Dmx e  retorna a mascara  do componente LCL.}                                          
        public  Function Get_MaskEdit_LCL(aTemplate : ShortString;
                                          //Se o campo tem mascara retorna true e false caso contrário
                                          out OkMask : Boolean) : AnsiString;overload;

        public Function DoAddRec:Boolean;virtual;//abstract;

        {$REGION ' ---> Property BufDataset : TBufDataset '}
          protected _BufDataset : TBufDataset;

          {: O método **@name** destrói _BufDataSet se _BufDataSet.owner=Self ao
             desativar o formulário           }
          private Procedure SetBufDataset(aBufDataset : TBufDataset);


          {: O método **@name** retorna DataSource.DataSet caso o mesmo
             seja diferente de nil ou cria _BufDataset com os dados do formulário
             caso DataSource.DataSet = nil;
          }
          private function GetBufDataset : TBufDataset;

          {: A propriedade **@name** é usada com objetivo de integração dos dados
             do formulário TVDmx e os controle decentes de TDataSet.
         }
          protected property BufDataset : TBufDataset read GetBufDataset write SetBufDataset;
        {$ENDREGION ' ---> Property BufDataset : TBufDataset '}

        {$REGION ' ---> Property DataSource : TDataSource '}

           protected _DataSource : TDataSource;

           {: A propriedade **@name** permite que controles da **LCL** (Lazarus Componentes Library)
              possam usar os dados do componente **TDmxScroller**.

              - **NOTA**
                - Essa integração permite que **TDmxScroller** utilize todos os componentes de banco
                  de dados do Free Pascal.
           }
           public property DataSource : TDataSource Read _DataSource   Write  _DataSource;
        {$ENDREGION ' <--- Property DataSource : TDataSource '}

        {: O atributo **@name** retorna true se o buffer apontado por PAnt for igual ao buffer apontado por PAtu. }
        public Function IfEqual(Const Ofset_Inicial:Word;Const PAnt,PAtu : Pointer; Const Len:Word):Boolean;

        {: O método **@name** retorna true se o registro atual for diferente do registro anterior}
        public function RecordAltered : Boolean ;

        {: A classe método **@name** é usado para adicionar a chamada de um procedimento quando a tecla F7
           é pressionada;
        }
        public class function CreateExecAction(Const aFieldName:AnsiString;const aExecAction: AnsiString) : AnsiString;

        public procedure add(aTemplate:AnsiString);

        {$REGION 'Construção Propriedade Locked'}
          private public _Locked   : Boolean;
          protected Procedure SetLocked(aLocked:Boolean);Virtual;
          {: A propriedade **@name** deve ser redefinida na interface filha desta
             classe para travar o formulário se aLocked = true e destravar se
             aLocked = false;
          }
          public property Locked : Boolean read _Locked write SetLocked;
        {$ENDREGION 'Construção Propriedade Locked'}



    end;

  type SmallWord  = TUiDmxScroller.SmallWord;




implementation

    {: O tipo **@name** usado no interpretador de Template para identificar um
       item do cluster}
    type TClusterTemp = Record
                           fnum    :  byte;//:< número do bit
                           value   :  byte;//:< Valor do bit

                                                 //   0123456789012345
                           ofs     :  Smallword; //:< 0000000000000000 16 bits
                        end;
    {: O tipo **@name** usado pelo interpretador de Template para identificar o
       campo cluster}
    type TClusterTemps =  array [0..127] of TClusterTemp;
    var ClusterTemps : TClusterTemps;

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

    constructor TFldEnum_Lookup.create(aDmxFieldRec: pDmxFieldRec);

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
          else raise Exception.Create('O campo precisa ser enumerado.');

        i := 0;
        While (p <> nil) do
        begin
          If (p^.Value <> nil)
          Then with BufDataSet do
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
      inherited create(nil);
      DmxFieldRec := aDmxFieldRec;
      if DmxFieldRec <> nil
      Then Begin
             KeyField   := 'id';
             ListField  := 'descricao';

             //Criar o DataSet
             BufDataSet := TBufDataSet.Create(Self);
             with BufDataSet do
             begin
               FieldDefs.Add(KeyField,ftLargeint,sizeof(DmxFieldRec.FieldSize));
               FieldDefs.Add(ListField,ftString,DmxFieldRec.TrueLen);
               CreateDataset;
               AddRecs;
             end;
             DataSource := TDataSource.Create(Self);
             DataSource.DataSet := BufDataSet;
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
    end;

    procedure TUiDmxScroller.Dispose(var apDmxFieldRec: pDmxFieldRec);
      Var
        c : TComponentState;
    begin
      if Fields.IndexOf(apDmxFieldRec)>=0
      then begin
             if not Assigned(apDmxFieldRec)
             then Raise TException.Create(ParametroInvalido);

             Fields.Delete(Fields.IndexOf(apDmxFieldRec));

             if Assigned(apDmxFieldRec^.FldEnum_Lookup)
             then FreeAndNil(apDmxFieldRec^.FldEnum_Lookup);

             //try //Desativei porque está gerando exceção no formulário InpuBox. checar depois
             //
             //  if Assigned(apDmxFieldRec^.LinkEdit)
             //  then begin
             //         c:= apDmxFieldRec^.LinkEdit.ComponentState;
             //         if (csDesigning in C)
             //         Then
             //          //ShowMessage(apDmxFieldRec^.LinkEdit.name+' - if (csDesigning in apDmxFieldRec.LinkEdit.ComponentState)');
             //          FreeAndNIl(apDmxFieldRec^.LinkEdit);
             //        end;
             //except
             //end;

             System.Dispose(apDmxFieldRec);
           end;
    end;

    procedure TUiDmxScroller.SetCurrentRecord( aCurrentRecord: Longint);
    begin
      if _CurrentRecord <> aCurrentRecord
      then begin
            //OnExitRecord
            _CurrentRecord := aCurrentRecord;
            //OnEnterRecord;
           end;
    end;

  //======================================================
  {$REGION '---> TDmxFieldRec' }

    procedure TDmxFieldRec.SetFieldName(aFieldName: AnsiString);
    begin
      _FieldName :=  Lowercase(TUiDmxScroller.GetNameValid(aFieldName));
      if Alias = ''
      Then Alias := aFieldName;
    end;

    procedure TDmxFieldRec.Set_owner(a_owner: TUiDmxScroller);
    begin
      _owner := a_owner;
    end;

    function TDmxFieldRec.GetFieldAltered: Boolean;
      var
        wCurrentField : pDmxFieldRec;
    Begin
      if Not _FieldAltered
      then begin
             if (owner<>nil) and (owner.WorkingDataOld<>nil)
             Then begin
                    try
                      wCurrentField := owner.CurrentField;
                      owner.SetCurrentField(RSelf);
                      result := GetAsString <> GetAsStringFromBuffer(owner.WorkingDataOld)
                    Finally
                      owner.SetCurrentField(wCurrentField);
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

    function TDmxFieldRec.StrNumberValid(S: AnsiString): AnsiString;
    begin
      With owner do
      begin
        Result  := DeleteMask(S,['0'..'9','-','+',showDecPt]);
        if (pos(showDecPt ,Result)<>0) and (showDecPt<>DecPt)
        then begin
               Result := Change_AnsiChar(s,showDecPt,DecPt);
             end;
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
        NumInt : Longint;
        I,Len  : Word;
        n1,n2,n3 : Int64;

       Var
         ws,Aux : AnsiString;
         aData  : TDates.TypeData;
         LData,LHora : Longint;

      Begin
        Err := 0;
        with owner do
          TaStatus := 0;

        If (owner <> nil) and (owner.GetRecordData<>nil)
        Then
        Begin
          Pv := owner.GetRecordData;
          Pv := Pv+DataTab;
          p := pv;

          If P <> nil
          Then With owner,TDates do
               Begin
                 if TypeCode = fldSTRNUM
                 then begin {REGION '---> Crítica para gerar exceção caso a data ou hora sejam inválidos.'
                                Necessário porque tvDmx pode ler uma data como string para converter
                                depois. }
                         case TypeFld(Template_org) of
                              FldData     : Begin //Obs: S=Ano+Mes+Dia
                                              aData := StrToDate(s,_DateMask)^;
                                            End;

                              fldLData    : Begin //Guarda a data compactada
                                               LData := PackDate(S,_DateMask,LData);
                                            End;

                              FldDateTimeDos : Begin
                                                  Aux := '';
                                                  ws := S;

                                                  //Retira todos os caracteres não válidos
                                                  for I := 1 to Length(wS) do
                                                    if wS[i] in ['0'..'9']
                                                    then Aux := Aux + wS[i];

                                                  if Length(Aux) = length('DDMMAAAAHHMMSS')
                                                  then LData :=   StrToDateTimeDos(Aux,DateMask_DDMMAAAAHHMMSS)
                                                  Else
                                                  if Length(Aux) = length('DDMMAAHHMMSS')
                                                  Then LData :=   StrToDateTimeDos(Aux,DateMask_DDMMAAHHMMSS)
                                                  Else
                                                  if Length(Aux) = length('DDMMAAHHMM')
                                                  Then LData :=   StrToDateTimeDos(Aux,DateMask_DDMMAAHHMM)
                                                  Else Raise TException.Create(ErroFormatoInvalido);
                                               End;

                              fldLHora,
                              fld_LHora
                                  : Begin // Guarda a hora compactada
                                      Lhora :=   PackHour(S,_HourMask,Lhora);
                                    End;
                         end; //case
                      end;
                    {ENDREGION}

                 Case TypeCode of
                    fldSTR,
                    fldSTR_Minuscula ,
                    fldSTRNUM,
                    FldDbRadioButton
                                : Begin
                                    s := trim(s);
                                    If FieldSize <= 255 Then
                                    Begin
                                      If OkSpc
                                      Then P^.asString := Spc(S,FieldSize-1)
                                      Else Begin
                                             If Length(S) < FieldSize
                                             Then P^.asString := S
                                             else P^.asString := Copy(S,1,FieldSize-1);
                                           end;
                                    End;
                                  End;

                    FldData     ,
                    fldLData    ,
                    FldDateTimeDos    : begin
                                          P^.asString := S;
                                        end;

                    fldLHora,
                    fld_LHora         : begin
                                          P^.asString := S;
                                        end;

                    fldAnsiChar,
                    FldAnsiChar_Minuscula,
                    fldAnsiCharNUM,
                    fldAnsiCharVAL  : Begin
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
                    fldLONGINT  : Begin
                                    P^.asLongint := Longint(CheckRanger(s,High(Longint),Low(Longint),err));
                                  end;

                    FldBoolean,
                    fldBYTE     : Begin
                                    P^.asByte := Byte(CheckRanger(s,High(byte),Low(byte),err));
                                  end;

                    fldSHORTINT : Begin
                                    P^.asSHORTINT := SHORTINT(CheckRanger(s,High(SHORTINT),Low(SHORTINT),err));
                                   end;

                    fldSmallWORD: Begin
                                    P^.asSmallWord := SmallWORD(CheckRanger(s,High(SmallWord),Low(SmallWord),err));
                                   end;

                    FldRadioButton: Begin
                                      P^.asCluster := TCluster(CheckRanger(s,High(TCluster),Low(TCluster),err));
                                    end;

                    fldSmallInt : Begin
                                    P^.asSmallInt := SmallInt(CheckRanger(s,High(SmallInt),Low(SmallInt),err));
                                  end;

                    fldRealNum,
                    fldRealNum_Positivo
                                : Begin
                                    s := StrNumberValid(s);
                                    If S<>''
                                    Then Val(S,P^.asRealNum,err)
                                    Else P^.asRealNum:= 0;

                                    If err <> 0
                                    Then TaStatus := Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo
                                  end;

                    fldReal4    : Begin
                                    s := StrNumberValid(s);
                                    If S<>''
                                    Then Val(S,P^.asReal,err)
                                    Else P^.asReal := 0;

                                    If err <> 0
                                    Then TaStatus := Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo
                                  end;

                    fldReal4P   : Begin
                                    s := StrNumberValid(s);
                                    If S<>''
                                    Then Val(S,P^.asReal,err)
                                    Else P^.asReal := 0;

                                    If err <> 0
                                    Then TaStatus := Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo
                                    else P^.asReal:= P^.asReal/100;
                                  End;

                    fldExtended : begin
                                    s := StrNumberValid(s);
                                    If S<>''
                                    Then Val(S,P^.asExtended,err)
                                    Else P^.asExtended:= 0;

                                    If err <> 0
                                    Then TaStatus := Tipo_em_memoria_incompativel_com_o_tipo_do_campo_no_arquivo

                                  end;

                    fldHexValue : Begin end;
                    fldBLOb     : Begin end;
                End;

                If TaStatus <>0
                Then Begin
                       //abort;
                       showMessage('Erro em SettString campo: '+FieldName+' Valor: '+S);
//                        Raise TException.Create('Erro em SettString campo: '+FieldName+' Valor: '+S);

                     end;
               End;
        end;
      End;

    function TDmxFieldRec.GetAsString: AnsiString;
      var
         wCurrentField : PDmxFieldRec;
    begin
      if Assigned(owner)
      then begin
             try
               wCurrentField := owner.CurrentField;
               owner.SetCurrentField(RSelf);

               if (owner.GetRecordData<>nil)
               then result := GetAsStringFromBuffer(owner.GetRecordData)
               else Result := '';

             finally
               owner.SetCurrentField(wCurrentField);
             end;
           end
      else result := '';
    End;

    function TDmxFieldRec.GetAsStringFromBuffer(aWorkingData: pointer): AnsiString;
    Var
      pv : Pointer;
      P    : PValue;
      S    : tString;
      R32  : single;
    Begin
//      If (owner <> nil) and (owner.GetRecordData<>nil) Then
      if aWorkingData<>nil
      then
          Begin

              //Pv := owner.GetRecordData;
              pv := aWorkingData;
              Pv := Pv+DataTab;
              p := pv;

               with TUiDmxScroller do
              Case TypeCode of
                   fldSTR,
                   fldSTR_Minuscula      ,
                   fldSTRNUM,
                   FldDbRadioButton
                               : Begin
                                   If OkSpc
                                   Then Result := Spc(P^.AsString,FieldSize-1)
                                   Else Begin
                                          If Length(P^.AsString) < FieldSize
                                          Then Result := P^.AsString
                                          Else Result := Spc(P^.AsString,FieldSize-1);
                                         End
                                 End;

                   FldData     ,
                   fldLData    ,
                   fldLHora,
                   FldDateTimeDos    : begin
                                         Result := P^.AsString;
                                       end;

                   fldAnsiChar,
                   FldAnsiChar_Minuscula,
                   fldAnsiCharNUM,
                   fldAnsiCharVAL : Begin
                                      If FieldSize <= 255 Then
                                      Begin
                                        Move(P^,S[1],FieldSize) ;
                                        S[0] := AnsiChar(FieldSize);
                                      end
                                      Else Begin
                                             Move(P^,S[1],255) ;
                                             S[0] := AnsiChar(255);
                                           End;
                                      Result := S;
                                    End;
                   fldENUM,
                   fldLONGINT  : Begin
                                   If (Not OkSpc) and (P^.asLongint = 0)
                                   Then Result := '0'
                                   else Begin
                                          if OkMask
                                          Then Result := NumToStr(Template_org,P^.asLONGINT,TypeCode,OkSpc)
                                          else Result := IStr(P^.asLONGINT ,ConstStr(Length(Template^),'L'));
                                        end;
                                 end;                  

                   fldBYTE     : begin
                                   If (Not OkSpc) and (P^.asByte= 0)
                                   Then Result := '0'
                                   else Begin
                                          Result := NumToStr(Template_org,P^.AsByte,TypeCode,OkSpc) //IStr(P^.asByte,ConstStr(Length(Template_org),'B'))
                                        end;
                                 end;

                   fldSHORTINT : Begin
                                   If (Not OkSpc) and (P^.asShortInt = 0)
                                   Then Result := '0'
                                   else Begin
                                          Result := NumToStr(Template_org,P^.asSHORTINT,TypeCode,OkSpc)//IStr(P^.asSHORTINT,ConstStr(Length(Template_org),'J'))
                                        end;
                                 end;


                   FldRadioButton : Result := IStr(P^.asCluster,ConstStr(Length('WWWWW'),'W'));

                   FldSmallWord : Begin
                                    If (Not OkSpc) and (P^.AsSmallWord = 0)
                                    Then Result := '0'
                                    else Begin
                                           Result := NumToStr(Template_org,P^.AsSmallWord,TypeCode,OkSpc)
                                         end;
                                  end;

                   fldSmallInt : Begin
                                   If (Not OkSpc) and (P^.asSmallInt = 0)
                                   Then Result := '0'
                                   else Begin
                                           Result := NumToStr(Template_org,P^.AsSmallInt,TypeCode,OkSpc)
                                        end;
                                 end;

                   fldRealNum,
                   fldRealNum_Positivo : begin
                                           If (Not OkSpc) and (P^.asRealNum= 0)
                                           Then Result := '0'
                                           else begin
                                                  Result := NumToStr(Template_org,P^.AsRealNum,TypeCode,OkSpc);
                                                end;
                                         end;
                 fldExtended           : begin
                                           If (Not OkSpc) and (P^.asExtended= 0)
                                           Then Result := '0'
                                         else begin
                                                Result := NumToStr(Template_org,P^.AsExtended,TypeCode,OkSpc);
                                              end;
                                       end;


                   fldReal4    : begin
                                   If (Not OkSpc) and (P^.asReal= 0)
                                   Then Result := '0'
                                   else Result := NumToStr(Template_org,P^.AsReal,TypeCode,OkSpc);
                                 end;

                   fldReal4P   : begin
                                   If (Not OkSpc) and (P^.asReal = 0)
                                   Then Result := '0'
                                   else Begin
                                          r32 := P^.AsReal*100;
                                          Result := NumToStr(Template_org,R32,TypeCode,OkSpc)
                                        end;
                                 end;

                   FldBoolean  : Result := IntToStr(P^.AsByte);
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
      with owner do
      Result :=  TypeCode in [fldSTR,
                              fldSTRNUM,
                              fldSTR_Minuscula,
                              fldAnsiChar,
                              fldAnsiChar_Minuscula,
                              fldAnsiCharNUM,
                              fldAnsiCharVAL,
                              fldBYTE,
                              fldSHORTINT,
                              fldSmallWORD,
                              fldSmallInt,
                              fldLONGINT,
                              fldRealNum,
                              fldRealNum_Positivo,
                              FldExtended,
                              fldHexValue,
                              fldData,
                              fld_LData,
                              fldLData,
                              fldLHora,
                              fld_LHora,
                              FldDateTimeDos,
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

        function  SItemsLenString(Const Str: tString) : SmallInt;
          var S : PSItem;
        begin
          with owner do
          If Str[1] <> fldSItems Then
            Result := Length(Str)
          Else
          Begin
            Move(Str[2],S,Sizeof(PSItem));
            Result := SItemsLen(S);
          End;
        end;

      Var
        //ColumnWid,
        j  : Integer;
        P  : PSItem;
    Begin
      with owner do
      If TypeCode in [FldRadioButton,FldDbRadioButton]
      Then Begin
             Result := 0;
             For j := 1 to Length(Template^) do
               If Not (Template^[j] in Delimiters) Then
                 //Inc(Result);
                 Result := Result + 1;
           End
      Else If TypeCode = fldENUM
           Then Begin {Calcula o }
                  Move(Template^[2],P,Sizeof(Pointer));
                  Result := MaxItemStrLen(P);
                End
           else If Template^[1] = fldSItems
                Then Begin
                       Result := SItemsLenString(Template^);
                     end
                Else Begin
                       ColumnWid := Pos('`',Template^);
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
                (Not IsInputDbRadio) and
                (Not IsInputCheckbox) and
                (Not IsComboBox))
    end;

    function TDmxFieldRec.IsInputRadio: Boolean;
    Begin
      with owner do
        Result := TypeCode in [FldRadioButton];
    End;

    function TDmxFieldRec.IsInputDbRadio: Boolean;
    begin
      with owner do
        Result := TypeCode in [FldDbRadioButton];
    end;

    function TDmxFieldRec.IsInputCheckbox: Boolean;
    Begin
      with owner do
        Result := TypeCode = FldBoolean;
    end;

    function TDmxFieldRec.isInputPassword: Boolean;
    Begin
      Result := IsInputText and (CharShowPassword = ^W);   //<Se "CharShowPassword" = ^W então em FieldText imprime "CharShowPasswordAnsiChar" por tratar-se de uma senha
    end;

    function TDmxFieldRec.IsInputHidden: Boolean;
    Begin
      with owner do
        Result := IsInputText and ((access and accHidden)<>0);
    end;

    function TDmxFieldRec.IsSelect: Boolean; //< O objeto filho que implementar um ISelect deve anular e retornar a interface ISelect;
    Begin
      Result := IsComboBox;
    end;

    function TDmxFieldRec.IsComboBox: Boolean;//< Usado quando trata-se de campos enumerados.
    Begin
      with owner do
        Result := TypeCode = fldENUM;   {< ^E; enumerated Field }
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

        function TDmxFieldRec.SelectFirstField: pDmxFieldRec;
    begin
      //If owner <> nil
      //Then  Result := owner.SelectFirstField
      //Else Result := nil;
    end;

    function TDmxFieldRec.SelectLastField: pDmxFieldRec;
    begin
      //If owner <> nil
      //Then  Result := owner.SelectLastField
      //Else Result := nil;
    end;

    procedure TDmxFieldRec.Select;
    begin
      //if (Not _Vidis_Select) and (TDmxEditor(owner).RecordSelected)
      //then try
      //       _Vidis_Select := true;
      //
      //        If owner <> nil
      //        Then  Begin
      //                TDmxEditor(owner).Select(Fieldnum);
      //                if (Link_IInputText<>nil) and (not vidis_OnEnter) and (not vidis_OnExit) and (Self.Fieldnum<>0)
      //                then Link_IInputText.select();
      //              end;
      //    finally
      //      _Vidis_Select := False;
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
      with owner do
        Case TypeCode of
          FLdEnum : Begin
                      SetValue(aItem);
                    End;
          Else  Begin
                  Raise TException.Create('Tipo desconhecido');
                End;
        end;//case
    end;

    function TDmxFieldRec.IsNumber: Boolean;
    Begin
      with owner do
        Result := TypeCode in [fldBYTE,fldSHORTINT,fldSmallWORD,fldSmallInt,fldLONGINT,fldRealNum,fldExtended,fldHexValue,fldENUM];//fldSTRNUM,fldAnsiCharNUM,fldAnsiCharVAL,
    end;

    function TDmxFieldRec.IsNumberReal: Boolean;
    begin
      with owner do
        Result := TypeCode in [fldRealNum,fldExtended];
    end;

    function TDmxFieldRec.IsNumberInteger: Boolean;
    begin
      with owner do
        Result := TypeCode in [fldBYTE,fldSHORTINT,fldSmallWORD,fldSmallInt,fldLONGINT,fldHexValue,fldENUM];
    end;

    function TDmxFieldRec.IsData: Boolean;
    begin
      with owner do
         Result := TypeCode in [fldData,fldLData,fld_LData,fldDateTimeDos];
    end;

    function TDmxFieldRec.IsHora: Boolean;
    begin
      with owner do
         Result := TypeCode in [fld_LHora,fldLHora];
    end;


    function TDmxFieldRec.GetFldOrigin_Y: Integer;
    begin
      if _FldOrigin_Y < 0
      then Result := owner.currentRecord
      else Result := _FldOrigin_Y;
    end;

    function TDmxFieldRec.GetFldOrigin: TPoint;
    begin
      Result.X := ScreenTab;
      Result.Y := FldOrigin_Y;
    end;

    //function TDmxFieldRec.GetLeft: Integer;
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

    function TDmxFieldRec.SetAccess(aaccess: byte): Byte;
    begin
      result := access;
      if aAccess <> 0
      Then access := access or aaccess
      else access := 0;
    end;

    function TDmxFieldRec.Valid(Command: Word): Boolean;
    begin

    end;

    function TDmxFieldRec.Getvidis_OnEnter: Boolean;
    begin
      Result := _vidis_OnEnter;
    end;

    procedure TDmxFieldRec.Setvidis_OnEnter(avidis_OnEnter: Boolean);
    begin
      _vidis_OnEnter := aVidis_OnEnter;
    end;

    function TDmxFieldRec.Getvidis_OnExit: Boolean;
    begin
      Result := _vidis_OnExit
    end;

    procedure TDmxFieldRec.Setvidis_OnExit(avidis_OnExit: Boolean);
    begin
      _vidis_OnExit := aVidis_OnExit
    end;

    procedure TDmxFieldRec.DoOnEnter(Sender: TObject);
    begin
      if Assigned(owner)
      then begin
             owner.SetCurrentField(RSelf);
             owner.Scroll_it_inview(RSelf);
             if Assigned(owner.onEnterField) and (Fieldnum<>0)
             then begin
                    owner.onEnterField(RSelf);
                  end;
           end;
    end;

    procedure TDmxFieldRec.DoOnExit(Sender: TObject);
    begin
      if Assigned(owner)
      Then begin
             if Assigned(owner.onExitField) and (Fieldnum<>0)
             then owner.onExitField(RSelf);
             if FieldAltered
             then owner.UpdateBuffers;
          end;
    end;

  {$ENDREGION '<--- TDmxFieldRec' }
  //======================================================

  //======================================================
  {$Region 'TUiDmxScroller'}

    constructor TUiDmxScroller.Create(aOwner: TComponent);
    begin
      inherited Create(aowner);
      keysPrimaryKeyComposite := '';
      flagPrimaryKey_AutoIncrement := false;
      _Strings := TMiStringList.Create;

      if (not Assigned(onGetTemplate)) and
         (not Assigned(onAddTemplate))
      then
      with Strings do
      begin
        //add(^A+'~EXEMPLO DE TEMPLATE~');
        //add('');
        //add('~Alfanumérico maiúscula com 15 posições:~\SSSSSSSSSSSSSSS');
        //add('~Alfanumérico maiúscula e minuscula com 30 posições:~');
        //add('~~\ssssssssssssssssssssssssssssssssssssss');
        //add('~Alfanumérico com a primeira letra maiúscula:~\Sssssssssssssss');
        //add('~Valor double.......:~\RRR,RRR.RR');
        //add('~Valor SmalInt......:~\II,III');
        //add('~Valor Byte.........:~\BBB');
        //add('~Valor Smallword....:~\WW,WWW');
      end;

    end;

    destructor TUiDmxScroller.destroy;
    begin
      if active
      then Active:=false;

        if not getState(Mb_St_Active)
      then FreeAndNil(Fields);
      if _Strings <> nil
      Then FreeAndNil(_Strings);

      inherited destroy;
    end;

    procedure TUiDmxScroller.ShowControlState;
    begin

    end;

    function TUiDmxScroller.GetStrings: TMiStringList;
    begin
      if _Strings = nil
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

    procedure TUiDmxScroller.UpdateBuffers;
    begin

    end;

    procedure TUiDmxScroller.Refresh;
    begin

    end;

    function TUiDmxScroller.GetAppending: Boolean;
    Begin
      Result := _Appending;
    End;

    procedure TUiDmxScroller.SetAppending(aAppending: Boolean);
    Begin
      _Appending := aAppending;
    end;

    function TUiDmxScroller.SetOnCalcRecord(const WOnCalcRecordEnable: Boolean): Boolean;
    Begin
      Result := GetState(Mb_OnCalcRecord);
      SetState(Mb_OnCalcRecord,WOnCalcRecordEnable);
//      SetDoOnCalcFields(OnCalcRecordEnable)
    End;

    procedure TUiDmxScroller.SetRecordSelected(a_RecordSelected: boolean);
    Begin
      if a_RecordSelected
      then BEGIN
              if Self.Appending
              then begin
                     if CurrentRecord <>0
                     then begin
                            MessageBox('Antes de selecionar o registro é necessário executar o método DoOnNewRecord()!');
                          end;
                    end;
           END;
      _RecordSelected := a_RecordSelected;
    End;

    procedure TUiDmxScroller.SetDoOnNewRecord_FillChar(   const a_DoOnNewRecord_FillChar: Boolean);
    Begin
      _DoOnNewRecord_FillChar := a_DoOnNewRecord_FillChar;
      If _DoOnNewRecord_FillChar
      Then Begin
             CurrentRecord    := 0;
             System.FillChar(WorkingData^,RecordSize,0);
             System.FillChar(WorkingDataOld^,RecordSize,0);
           End;
    End;

    procedure TUiDmxScroller.ChangeMadeOnOff(const aValue: Boolean);
    Begin
      Locked  := aValue;
//      RecordAltered := aValue;
      KeyAltered    := aValue;
    { Não posso alterar as variáveis abaixo porque SetupRecord chama ChangeMadeOnOff(false;
      RecordSelected := false;
      FieldSelected  := false;
    }
    End;

    function TUiDmxScroller.GetRecordSelected: boolean;
    Begin
      result := _RecordSelected;
      if result
      Then begin
            if appending
            then begin
                   Result := (Self.CurrentRecord = 0) and (CurrentRecord=CurrentRecordOld);
                 end
            else begin
                   if ((state and Mb_St_AddRec) = 0) //Não está adicionando registro.
                   then Result := (Self.CurrentRecord <> 0) and (CurrentRecord=CurrentRecordOld)
                   Else Begin
                          // OBS1
                          //  Quando se está adicionando registro o
                          //  registro anterior é diferente do registro atual
                          //  ate que o método salvaRegAnterior seja executado.

                          //OBS2
                          //  Quando Self é ViRecord nrCurrent é 0 (zero) por isso preciso ignorar
                          //  o teste (Self.CurrentRecord <> 0) and (CurrentRecord=CurrentRecordOld)
                          Result := true;
                        End;
                 end;
          end;
    end;

    procedure TUiDmxScroller.DoOnNewRecord;
      Var
        WState_SfFocused : Boolean;
        wOnCalcRecordEnable: Boolean;

    Begin
      Try
        Try
          Appending           := true; {Indica que se trata de um nove registro}
  //        Refresh;

          wOnCalcRecordEnable := SetOnCalcRecord(False);
          WState_SfFocused    := SetState(SfFocused,False);

          If DoOnNewRecord_FillChar
          Then Begin
                 CurrentRecord := 0;
                 System.FillChar(WorkingData^,RecordSize,0);
               End
          Else Begin
                 CurrentRecord    := 0;
               End;

          Self.RecordSelected := true;
          SetState(Mb_St_Insert,true);
          CurrentRecordOld := CurrentRecord;
          if Assigned(OnNewRecord)
          then OnNewRecord(Self);

          Move(WorkingData^,WorkingDataOld^,RecordSize);

        Finally
          SetState(SfFocused,WState_SfFocused);
          SetOnCalcRecord(wOnCalcRecordEnable);
          Self.ChangeMadeOnOff(False);

          //if (Fields.Count>0) and (Self.ViewOwner=nil)
          //then Set_First_Field_Normal;

        End;


      Except
        Self.RecordSelected := False;
        SetState(Mb_St_Insert,false);
        Raise TException.Create(Self,
                                'DoOnNewRecord',
                                 Erro_Excecao_inesperada);
      end;
    End;

    function TUiDmxScroller.SetState(const AState: Int64; const Enable: boolean      ): Boolean;
    Begin
      If State and aState <> 0
      Then Result := True
      Else Result := false;

      if Enable
      then begin
             State := State or AState;
           end
      else Begin
             State := State and not AState;
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
    begin
      for i := 0 to Fields.Count-1 do
      begin
        result := Fields[i];

        if LowerCase(result.FieldName) = LowerCase(aName)
        then exit;

      end;
    end;

    function TUiDmxScroller.FieldByNumber(aFieldNum: Integer): PDmxFieldRec;
    Var
      i : Integer;
    begin
      for i := 0 to Fields.Count-1 do
      begin
        result := Fields[i];
        if result.Fieldnum = AFieldNum
        then exit;
      end;
    end;

    function TUiDmxScroller.CancelBuffers: Boolean;
    begin
      result := true;
      //Cancela as alterações do registro atual;
      system.Move(WorkingDataOld^,WorkingData^, RecordSize);
      UpdateBuffers;
    end;

    function TUiDmxScroller.GetBuffers: Boolean;
    begin
      result := true;
      //Salva o registro atual para o registro anterior;
      system.Move(WorkingData^,WorkingDataOld^, RecordSize);
    end;

    function TUiDmxScroller.PutBuffers: Boolean;
    begin
      result := true;
    end;

    //function TUiDmxScroller.PutBuffers: Boolean;
    //begin
    //  abstracts;
    //end;

    procedure TUiDmxScroller.DoOnCloseQuery(aDmxScroller: TUiDmxScroller; var CanClose: boolean);
    Begin
      if Assigned(OnCloseQuery)
      then OnCloseQuery(aDmxScroller,CanClose);
    End;

    procedure TUiDmxScroller.DoOnCloseQuery(var CanClose: boolean);
    Begin
      DoOnCloseQuery (Self,CanClose);
    End;

    procedure TUiDmxScroller.Scroll_it_inview(AControl: pDmxFieldRec);
    begin

    end;

    procedure TUiDmxScroller.DoOnEnter(aDmxScroller: TUiDmxScroller);
    begin
      SetState(Mb_St_Edit,true);
      if Assigned(onEnter)
      then begin
             if GetBuffers
             then begin
                    OnEnter(Self) ;
                    if RecordAltered
                    then begin
                          Refresh;
                         end;
                 end;
           End
      else GetBuffers;
    end;

    procedure TUiDmxScroller.DoOnExit(aDmxScroller: TUiDmxScroller);
    begin
      //if not GetState(Mb_St_Edit)
      //Then raise TException.Create(Self,'DoOnExit',ParametroInvalido);

      if Assigned(onExit)
      then begin
             if PutBuffers
             Then OnExit(Self) ;
           End
      else PutBuffers;
      SetState(Mb_St_Edit,False);
    end;

    //procedure TUiDmxScroller.SetParentLCL(aParentLCL: TScrollingWinControl);
    //begin
    //  _ParentLCL := aParentLCL;
    //
    //  if Assigned(_ParentLCL) and ((_ParentLCL as TScrollingWinControl).Caption = '')
    //  then (_ParentLCL as TScrollingWinControl).Caption:= Alias;
    //
    //  if _ParentLCL is TMi_ScrollBox_LCL
    //  then Begin
    //         (_ParentLCL as TMi_ScrollBox_LCL).UiDmxScroller := Self;
    //       end;
    //end;

    //procedure TUiDmxScroller.SetParentLCL(aParentLCL: TScrollingWinControl);
    //begin
    //  _ParentLCL := aParentLCL;
    //
    //  if Assigned(_ParentLCL) and ((_ParentLCL as TScrollingWinControl).Caption = '')
    //  then (_ParentLCL as TScrollingWinControl).Caption:= Alias;
    //
    //  //if _ParentLCL is TMi_ScrollBox_LCL
    //  //then Begin
    //  //       (_ParentLCL as TMi_ScrollBox_LCL).UiDmxScroller := Self;
    //  //     end;
    //end;

    procedure TUiDmxScroller.BeforeDestruction;
    begin
      inherited BeforeDestruction;
    end;


    procedure TUiDmxScroller.SetCurrentField(aCurrentField: pDmxFieldRec);
    begin
      _CurrentField := aCurrentField;
      if (_CurrentField <> nil) and (_CurrentField.Fieldnum<>0)
      then begin
             FieldData := WorkingData;
             FieldData := FieldData + _CurrentField.DataTab;
           end;
    end;

    //procedure TUiDmxScroller.CreateFormLCL(aOwner: TScrollingWinControl);
    //begin
    //  abstracts;
    //end;

    procedure TUiDmxScroller.SetActive(aActive: Boolean);
    begin
      abstracts;
    end;

    //procedure TUiDmxScroller.SetActiveLCL(aActive: Boolean);
    //begin
    //  if active
    //  then Raise TException.Create(ParametroInvalido);
    //
    //  if not Assigned(ParentLCL) and (Owner is TScrollingWinControl)
    //  then ParentLCL := Owner as TScrollingWinControl;
    //
    //  if aActive and Assigned(onGetTemplate) and Assigned(ParentLCL)
    //  then begin
    //         SetState(Mb_St_Creating,true);
    //         CreateStruct;
    //         CreateFormLCL(ParentLCL);
    //         _Active := aActive;
    //
    //         SetState(Mb_St_Active,true);
    //         SetState(Mb_St_Creating,False);
    //       end;
    //
    //end;


    procedure TUiDmxScroller.CreateStruct(var ATemplate: TString);
      var
        SameFieldNum  :  boolean;
        WasSameNum    :  boolean;
        NoFieldNum    :  boolean;
        NoFieldAdv    :  boolean;
        AllZeroes     :  boolean;
        C             :  AnsiChar;
        DoDecimal     :  integer;
        Rex,X         :  pDmxFieldRec;
        WFieldName    :  tString; //<NortSoft

      {$REGION 'templx'}
        _templx     :  tString;
        _templx_Org :  AnsiString;

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
                 then begin {$REGION '--->'}
                        If not NoFieldNum
                        then If SameFieldNum
                             then Begin {$REGION '--->'}
                                    Fieldnum := succ(TotalFields);
                                    {Se não existir nome do campo no Template, então devo criar um.
                                     formato:
                                        Para o campo 1 nome do campo = Field1,
                                        Para o campo 2 nome do campo - filed2
                                        .............
                                        Para o campo n nome do campo = filedn
                                    }

                                    if WFieldName = ''
                                    then WFieldName := Format('Field%d',[Fieldnum]);

                                    FieldName := WFieldName; //ITMS

                                  {$ENDREGION}
                                  end
                             else If (access and accHidden = 0) or WasSameNum
                                  then begin
                                          Inc(TotalFields);
                                          Fieldnum := TotalFields;

                                          if WFieldName = ''
                                          then WFieldName := Format('Field%d',[Fieldnum]);

                                          FieldName := WFieldName; //ITMS
                                       end;

                        DataTab    := RecordSize;
                        RecordSize := RecordSize + FieldSize;
                        {$ENDREGION '<--'}
                      end;
                 end;
          ScreenTab  := Limit.X;

          If (TypeCode = FldBoolean) and (TrueLen = 0)
          then ShowZeroes := FALSE;

          If (upcase(TypeCode) = fldENUM)
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
          Fields.Add(Rex);
          X   := Rex;
          x.RSelf := Rex;
          Rex := Rex.Next;
          //Zera o novo registro
          FillChar(Rex^, sizeof(Rex^), 0);
          Rex.Prev := X;
          Rex.Next := nil;

          Rex.ShowZeroes := AllZeroes;

          WFieldName := ''; //< NortSoft
          Rex.Owner := Self; // NortSoft

          Rex.ProviderFlags := [pfInUpdate,pfInWhere];
          Rex.ID_Dynamic := Alias+'_'+CreateGUID;
          Rex.QuitFieldAltomatic := QuitFieldAltomatic_Default;

        {$ENDREGION}


        WasSameNum := FALSE;
        NoFieldNum := FALSE;
        NoFieldAdv := FALSE;
      end; {<procedure NewRecord;}

      procedure TranslateStruct(dataformat: ptString);
        var
          df   : ptString;
          i,j,err  : integer;
          Flag : byte;
          TS   : PSItem;
          s : AnsiString;
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


          While (dataformat^[i] in ['_','a'..'z','A'..'Z','0'..'9'])
                and (not (dataformat^[i] in Delimiters))
                and (i <= length(dataformat^))
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
                           writeLn(Rex^.HelpCtx_Porque);
                         end;
                   '1' : begin //Onde
                           While (not (dataformat^[i] in Delimiters)) and (i <= LenDataformat) do
                           begin
                             inc(i);
                             Rex^.HelpCtx_Onde := Rex^.HelpCtx_Onde+ dataformat^[i];
                           end;
                           writeLn(Rex^.HelpCtx_Onde);
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

      begin
        SameFieldNum := FALSE;
        WasSameNum   := FALSE;
        NoFieldNum   := FALSE;
        NoFieldAdv   := FALSE;
        DoDecimal    := 0;
        i            := 1;

        LenDataformat := length(dataformat^);
//        LenDataformat := length(AnsiString_to_USASCII(dataformat^));
        While (i <= LenDataformat) do
        begin
          C := upcase(dataformat^[i]);

          with TUiMethods do
          Case C of
            FldBoolean :  With Rex^ do
                          begin
                            alias := 'FldBoolean';
                            templx(#0,dataformat^[i]);
                            If upcase(C) <> fldSHORTINT
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
                                if dataformat^[i] = FldRadioButton
                                then Rex^.FieldSize := SizeOffldCluster
                                else Rex^.FieldSize := SizeOffldDbCluster;

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
                                       NoFieldNum := TRUE;
                                       NoFieldAdv := TRUE;
                                     end;
                                Rex^.Fieldnum := ClusterTemps[j].fnum;

                                templx(#0,dataformat^[i]);
                                Inc(Rex^.TrueLen);
                                Rex^.Alias := Get_Alias;
                                Rex^.ShownWid := + Rex^.ShownWid + Length(Rex^.alias);
                                GetHints;
                                continue;
                             end;
            fldSTR,
            fldSTRNUM       : With Rex^ do
                              begin
                                //templx   := templx + #0;
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

                                  {$IFDEF CPU32} {$Region cpu32}
                                    Move(dataformat^[succ(i)], TS, sizeof(TS));
                                    rex^.ListComboBox := TS;
                                    Rex^.ListComboBox_Default := longint(dataformat^[i+9-4]);
                                    Inc(i,13-4);
                                  {$ENDIF} {$EndRegion cpu32}

                                  {$IFDEF CPU64} {$Region cpu64}
                                    Move(dataformat^[succ(i)], TS, sizeof(TS));
                                    rex^.ListComboBox := TS;
                                    Rex^.ListComboBox_Default := longint(dataformat^[i+9]);
                                    Inc(i,13);
                                    GetHints;
                                    continue;
                                  {$ENDIF} {$EndRegion cpu64}
                                end;

            fldAnsiChar,
            fldAnsiChar_Minuscula,
            fldAnsiCharVAL,
            fldAnsiCharNUM  : With Rex^ do
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

            fldBYTE,
            fldSHORTINT   :  With Rex^ do
                              Begin

                                templx(#0,dataformat^[i]);
                                If upcase(C) <> fldSHORTINT then
                                C := upcase(C);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                FieldSize := sizeof(BYTE);
                                FillValue := #0;
                              end;

            {< 'Z' }
            fldZEROMOD   :    With Rex^ do
                              begin
                                If (TypeCode = #0) or (TypeCode = fldAnsiCharVAL)
                                then Inc(FieldSize);

                                templx(#1,dataformat^[i]);
                                Inc(TrueLen);

                                If DoDecimal > 0
                                then Inc(DoDecimal);
                              end;


            FldSmallWord :    With Rex^ do
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


            fldLONGINT  :     With Rex^ do
                              begin
                                templx(#0,dataformat^[i]);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                FieldSize := sizeof(LONGINT);
                                FillValue := #0;
                              end;

            fldHexValue :     With Rex^ do
                              begin
                                templx(#0,dataformat^[i]);
                                TypeCode  := dataformat^[i];
                                Inc(TrueLen);
                                FieldSize := succ(TrueLen) shr 1;
                                FillValue := #0;
                              end;

            fldRealNum  : With Rex^ do
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

            fldENUM   :       begin
                                If (templx <> '')
                                then NewRecord;

                                Move(dataformat^[succ(i)],Rex^.Template,sizeof(Rex^.Template));

                                Rex.TypeCode  := fldENUM;
                                Rex.TrueLen   := MaxItemStrLen(PSItem(Rex^.Template));

                                Rex.FieldSize := sizeof(Longint);
                                Rex^.FillValue  := #0;

                                {$IFDEF CPU32} {$Region IFDEF CPU32}
                                   If dataformat^[i+5]  = '0' //NortSoft Free Vision
                                   Then Rex.ShowZeroes := false
                                   else Rex.ShowZeroes := True;

                                   Rex.access     := byte(dataformat^[i+6]);
                                   Rex^.ListComboBox_Default := Longint(dataformat^[i+7]);
                                {$ENDIF} {$EndRegion IFDEF CPU32}

                                {$IFDEF CPU64} {$Region IFDEF CPU64}

                                   If dataformat^[i+9]  = '0' //NortSoft Free Vision
                                   Then Rex^.ShowZeroes := false
                                   else Rex^.ShowZeroes := True;
                                   Rex^.access     := byte(dataformat^[i+10]);
                                   Rex^.ListComboBox_Default := Longint(dataformat^[i+11]);
                                {$ENDIF} {$EndRegion IFDEF CPU64}

                                //Inc(i, sizeof(DmxIDstr) - 2-3);
                                Inc(i, 15);

                                //Procura o nome do campo enumerado.
                                for j := i to length(dataformat^) do
                                begin
                                  case dataformat^[j] of
                                    CharFieldName : begin //Achou nome do campo.
                                                    i := j;
                                                    WFieldName := trim(GetFieldName);
                                                    break //Sai do laço for j
                                                  End;
                                  end;
                                end;

                                if (DataSource<>nil)
                                then begin
                                       Rex^.FldEnum_Lookup := TFldEnum_Lookup.create(Rex);
                                     end;
                                GetHints;
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

                                Inc(i, sizeof(DmxIDstr) - 2);

                                NewRecord;
                              end;


            fldAPPEND  :      begin
                                If (templx <> '')
                                then NewRecord;

                                Move(dataformat^[succ(i)], df, sizeof(df));
                                TranslateStruct(df);
                                Inc(i, sizeof(DmxIDstr) - 2);
                              end;

            { NortSoft
                Informa o nome do campo no Template
                Sintaxe: ~Nome do produto: ~ SSSSSSSSSSSSSSSS^BNome_do_Produto+#0
                Nota:
                  O nome do campo é passado após ^B e o mesmo não pode conter espaço em branco.
            }
            CharFieldName :   Begin
                              WFieldName := trim(GetFieldName);
                              continue;
                            end;

            CharShowPassword :  begin {<NortSoft}
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

//                                Inc(i, sizeof(DmxIDstr) - 2);
                                Inc(i, 9-1);
                              end;

            CloseParenthesis,{')'}
            '.'{DecPt} :      With Rex^ do
                              begin

                                templx(C,dataformat^[i]);
                                If (upcase(Rex.TypeCode) = fldAnsiCharVAL)
                                then begin
                                       If (C = CloseParenthesis {')'})
                                          then Inc(TrueLen);  {<?????}

                                       Inc(FieldSize);
                                     end;

                                If (C = DecPt{'.'})
                                then begin
                                       If (upcase(TypeCode) = fldRealNum) or
                                          (upcase(TypeCode) = fldAnsiCharVAL) or
                                          (upcase(TypeCode) = fldExtended)
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

            CharDelimiter_0{#0},
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

{$REGION '--> comentado'}
            //^C              : begin Desativado do original
            //                    Inc(i);
            //                    Rex.access := Rex.access or ord(dataformat^[i]);
            //                  end;

            //^D    :           begin
            //                    If (templx <> '')
            //                    then NewRecord;
            //
            //                    Inc(i);
            //                    C := dataformat^[i];
            //                    Rex.access    := Rex.access or accDelimiter;
            //                    Rex.TypeCode  := C;
            //                    NewRecord;
            //                  end;

            //^F :              begin
            //                    If (i < length(dataformat^)) and (dataformat^[i+1] = ^F)
            //                    then begin
            //                           NoFieldNum := TRUE;
            //                           Inc(i);
            //                         end
            //                    else begin
            //                           WasSameNum     := SameFieldNum;
            //                           SameFieldNum := not SameFieldNum;
            //                         end;
            //                  end;
{$ENDREGION '<--'}

            CharAccHidden {^H}  : Begin
                                    Rex^.SetAccess(accHidden);
//                                     With Rex^ do access := access or accHidden;
                                   End;

            {^P}
            CharProviderFlag  : begin
                                  With Rex^ do
                                  begin
                                    FieldName := WFieldName;
                                    inc(i);
                                    val(dataformat^[i],flag,err);
                                    if err <> 0
                                    then Raise TException.Create(ParametroInvalido);

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
                                            else keysPrimaryKeyComposite := keysPrimaryKeyComposite + ','+FieldName;
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
                                  val(dataformat^[i],flag,err);
                                  if err <> 0
                                  then Raise TException.Create(ParametroInvalido);

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

      end; {<procedure TranslateStruct(dataformat: ptString);}

    begin

      If (@ATemplate = nil)
      then Exit;

      try
        SetState(Mb_St_Creating_Template,true);

        AllZeroes      := FALSE;

        templx('');
        New(Rex);
        Fields.Add(Rex);

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
        SameFieldNum := FALSE;

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
        SetState(Mb_St_Creating_Template,false);
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
    begin
      if not GetState(Mb_St_Creating)
      then raise TException.Create('Chamada ao método CreateStruct inválida.');

      Template := GetTemplate(nil);
      if Template<> nil
      then begin
             Fields := TFPList.Create;
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
                 {  original
                 If (upcase(DMXField1.TypeCode) = fldENUM)
                 then DmxGizMa.DisposeSItems(PSItem(DMXField1.Template ))
                 else DisposeStr(DMXField1.Template);}

                 If upcase(DMXField1.TypeCode) in [fldENUM,fldSItems] //<NortSoft
                 then Begin
                         DisposeSItems(PSItem(DMXField1.Template ));
                         PSItem(DMXField1.Template ) := nil;
                      End
                 else DisposeStr(DMXField1.Template);
               end;

          P := DMXField1.Next;
//          with Fields do
//           if IndexOf(DMXField1)>=0
//           then begin
//                  Delete(IndexOf(DMXField1));
//
//                  if DMXField1.LinkEdit <> nil
//                  then begin
//                         if (csDesigning in DMXField1.LinkEdit.ComponentState)
//                         then begin
////                                ShowMessage('if (csDesigning in DMXField1.LinkEdit.ComponentState)');
//                                FreeAndNil(DMXField1.LinkEdit);
//                              end;
//                       end;
//
//                  system.Dispose(DMXField1);
//                end;
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
      then raise TException.Create('Chamada ao método CreateData inválida.');

      if (RecordSize > 0) and (WorkingData=nil)
      then begin
             FGetMem(WorkingData,RecordSize);
             FGetMem(WorkingDataOld,RecordSize);
             CreateBufDataset_FieldDefs;
           end;
    end;

    procedure TUiDmxScroller.DestroyData;
    begin
      If (WorkingData <> nil) and (RecordSize > 0)
      then begin
             fFreeMem(WorkingData, RecordSize);
             fFreeMem(WorkingDataOld, RecordSize);
             //WorkingData := nil;

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
           end;
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


    function TUiDmxScroller.GetTemplate(aNext: PSItem): PSItem;
    begin
      result := nil;
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
      else raise TException.Create(ParametroInvalido);
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
      else raise TException.Create(ParametroInvalido);
    end;

    function TUiDmxScroller.GetString: TString;
    begin
      result := getString(false);
    end;

    function TUiDmxScroller.PutString(const S: ShortString): SmallInt;
    Begin
      Result := PutString(False,S);
    end;

    function TUiDmxScroller.Get_MaskEdit_LCL(aTemplate: ShortString;out Size_TypeFld, aLength_Buffer: SmallWord; out OkMask: Boolean
      ): AnsiString;
      //Help lazarus
      // FormtFloat: http://www2.pelotas.ifsul.edu.br/npeil/funformatfloat.htm
      //https://wiki.freepascal.org/TMaskEdit


      {Caracter Descrição da mascara da LCL
        ! Espaços em branco não aparecerão
        > Todos os caracteres seguintes serão maiúsculos até que apareça o caracter
        < Todos os caracteres seguintes serão minúsculos até que apareça o caracter
        \ Indica um caracter literal
        l (L minusculo) Somente caracter alfabético
        L Obrigatoriamente um caracter alfabético (A-Z, a-z)
        a Somente caracter alfanumérico
        A Obrigatoriamente caractere alfanumérico ( A-Z, a-z, 0-9)
        9 Somente caracter numérico
        0 Obrigatoriamente caracter numérico
        c permite um caracter
        C Obrigatoriamente um caracter
        # Permite um caracter numérico ou sinal de mais ou de menos, mas não os requer.
        : Separador de horas, minutos e segundos
        / Separador de dias, meses e anos
        }

        {
        A máscara basicamente consiste de três campos, separados por ponto e vírgula.
        A primeira parte é a máscara propriamente dita.
        A segunda parte determina se os caracteres fixos devem ser ou não salvos com a máscara (ex: /, -, (, ...).
        A terceira parte da máscara representa o caracter em branco, podendo ser substituído por outro (ex: _, @, ...).

        Caracteres especiais utilizados com a máscara:

        ! Faz com que a digitação da máscara fique parada no primeiro caracter, fazendo com que os caracteres digitados que se movam. Ex: !;0;_

        > Todos os caracteres alfabéticos digitados após este símbolo serão convertidos para maiúsculos. Ex: >aaa;0;_

        < Todos os caracteres alfabéticos digitados após este símbolo serão convertidos para minúsculos. Ex: <aaa;0;_

        <> Anula o uso dos caracteres > e <. Ex: >aaa<>aaa;0;_

        \ Utilizado para marcar determinado caractere não especial como fixo, não podendo sobrescrevê-lo. Ex: !\(999\)000-0000;0;_

        L Caracteres alfabéticos (A-Z, a-z.) de preenchimento obrigatório. Ex: LLL;1;_

        l (Letra ele minúscula) Caracteres alfabéticos (A-Z, a-z.) de preenchimento opcional. Ex: lll;1;_

        A Caracteres alfanuméricos (A-Z, a-z, 0-9) de preenchimento obrigatório. Ex: AAA;1;_

        a Caracteres alfanuméricos (A-Z, a-z, 0-9) de preenchimento opcional. Ex: aaa;1;_

        C Exige preenchimento obrigatório com qualquer caractere para a posição. Ex: CCC;1;_

        c Permite qualquer caractere para a posição de preenchimento opcional. Ex: ccc;1;_

        0 Caracteres numéricos (0-9) de preenchimento obrigatório. Ex: 000;1;_

        9 Caracteres numéricos (0-9) de preenchimento opcional. Ex: 999;1;_

        # Caracteres numéricos (0-9) e os sinais de - ou + de preenchimento opcional. Ex: ###;1;_

        : Utilizado como separador de horas, minutos e segundos. Ex: !00:00:00;1;_

        / Utilizado como separador de dia, mês e ano. Ex: !99/99/9999;1;_

        ; Separa os três campos da máscara.

        _ Caractere usado normalmente nas posições do campo ainda não preenchidas.

        Nota:
         - Campom númerico
           - #####,##;1;_
             - O 1 Indica para salvar a mascara no resultado.
             - O caractere _ indica que deve ser digitado 1 caractere.
           - #####,##;0;_
             - O 0 Indica para não salvar a máscara no resultado.
        }


        Var
          I : Byte;
    //      OKMaiuscula: Boolean;
          aTypeFld    : AnsiChar;
          OKSeparador:boolean;
    Begin
      Result := '';
      OkMask := false;
      OKSeparador := false;
      aLength_Buffer := 0;
  //    OKMaiuscula := false;
      aTypeFld    := TypeFld(aTemplate,Size_TypeFld);
      If aTypeFld  in [FldData,fldLData,fld_LData]
      Then  Begin
              OkMask := true;
              Result  := '99/99/00;0;_';
              aLength_Buffer := 6;
              exit;
            end
      Else
      If aTypeFld in [fldLHora,fld_LHora]
      Then  Begin
              OkMask := true;
              Result  := '!90:00;0;_';
              aLength_Buffer := 6;
              exit;
            end
      Else
      For i := 1 to length(aTemplate) do
      Begin
        case aTemplate[i] of
          fldSTR          ,//    'S';  { string Field }
          fldAnsiChar         ://    'C';  { AnsiCharacter Field }
           Begin
             OkMask := true;
             Result := Result + '>c';
  //           oKMaiuscula := true;
             aLength_Buffer := aLength_Buffer + 1;
           End;

          fldAnsiChar_Minuscula,   //  'c';  // AnsiCharacter Field
          fldSTR_Minuscula       : //  's'   // Minusculo e maiusculo
          begin
             Result := Result + '<c';
             aLength_Buffer := aLength_Buffer + 1;
          end;

          'z',
          fldZEROMOD      ,//   'Z';  { zero modifier }
          fldHexValue     ,//   'H';  { hexadecimal numeric entry }
          fldSTRNUM       ,//   '#';  { numeric string Field }
          fldAnsiCharNUM      ,//   '0';  { numeric AnsiCharacter Field }
          fldAnsiCharVAL      ,//   'N';  { dbase formatted numeric Field }
          fldBYTE         ,//   'B';  { byte Field }
          fldSHORTINT     ,//   'J';  { shortint Field }
          fldSmallWORD    ,//   'W';  { word Field NortSoft}
          fldSmallInt     ,//   'I';  { integer Field NortSoft}
          fldLONGINT      ://   'L';  { longint Field }
          Begin
            OkMask := true;
            Result := Result + '#'; //0..9, + ,  -
            aLength_Buffer := aLength_Buffer + 1;
          end;

          fldExtended     ,//  'E';  {Real 10 bytes}
          fldReal4        ,//  'O';  { Real 4 Byte positivos e negativos }
          fldReal4P       ,//  'P';  { P = Real de mostrado x por 100 positivos e negativos}
          fldRealNum      ://  'R';  { real number Field  (uses TRealNum) }
          Begin
            Result := Result + '#';
            aLength_Buffer := aLength_Buffer + 1;
          end;

          fldRealNum_Positivo, // 'r';  { real number Field positive (uses TRealNum) }
          fldReal4Positivo   , // 'o';  { Real 4 Byte positivos}
          fldReal4PPositivo  : // 'p';  { P = Real de mostrado x por 100 positivos}
          Begin
            Result := Result + '#';
            aLength_Buffer := aLength_Buffer + 1;
          End;



          FldRadioButton      ,//  'k';  {FldRadioButton Campo Bit onde apenas 1 bit pode estar setado               }
          fldENUM             ://  ^E;   { enumerated Field }
          Begin
            Result := Result + '9';
            aLength_Buffer := aLength_Buffer + 1;
          end;

          fldData             ,//'D';  { D = TipoData DD/DD/DD}
          fldLData            ,//#1  ;  { #1 = Longint;Guarda a data compactada '##/##/##'}
          fld_LData           ://'d' ;  { d = Longint;Guarda a data compactada 'dd/dd/dd'}
          Begin
            // foi lido acima
          end;

          fldLHora           ,// #2 ;  { #2 = Longint;Guarda a hora compactada  ##:##:##}
          fld_LHora          :// 'h';  { h = Longint;Guarda a hora compactada   hh:hh:hh}
          Begin
            Result := Result + '0';
            aLength_Buffer := aLength_Buffer + 1;
          end;

          ' '  : Result := Result + '_';
          '~'  : begin end;


          Else If IsNumber_Real(aTypeFld)
               Then Begin
                      If aTemplate[i] in [DecPt,Comma]
                      Then Result := Result + aTemplate[i];
                      OKSeparador := true;

  {Caso coloque os caracteres abaixo na mascara o delphi não reconhecerá como número.
                      If (aTypeFld in [fldExtended,fldReal4,fldReal4P,fldRealNum,fldRealNum_Positivo,fldReal4Positivo,fldReal4PPositivo])
                          and (aTemplate[i] in [' ','%','$'])
                      Then Result := Result + aTemplate[i];
  }
                    end
               Else begin
                      if not OkMask
                      then OkMask := true;
                      OKSeparador := true;

                      if not (aTemplate[i] in [' '])
                      then Result := Result + aTemplate[i];
                    end;
  (*
          FldBoolean          =   'X';  { boolean value Field }
          fldBLOb             =   ^M;   { unformatted data Field }
          FldOperador = #3; { #3 = Byte indica que o campo  um operador matemático}
          FldMemo  = 'M';
          CharShowPassword  = ^W;  { Usado para omitir da os caracteres que estão sendo digitados em qualquer tipo de campo}
          CharExecAction   = ^T;  { O Ponteiro para um procedimento}
          fldCONTRACTION      =   '`';  { limit of visible text }
          fldAPPEND           =   ^G;   { append from pointer }
          fldSItems           =   ^I;   { link to chain of TSItem Templates }
          fldXSPACES          =   ' ';  { spaces --extended code follows <Esc> }
          fldXTABTO           =   ^I;   { tab    --extended code follows <Esc> }
          fldXFieldNUM        =   ^F;   { fnum   --extended code follows <Esc> }
  *)

        end;
      end;

  //    If oKMaiuscula
  //    Then Result := '>'+Result;


      If IsNumber_Real(aTypeFld) //or IsNumber_Integer(aTypeFld)
      Then begin
             if pos(DecPt,Result)<>0
             then begin
                    Result := copy(Result,1,pos(DecPt,Result)-2)+
                              Change_AnsiChar(Copy(Result,pos(DecPt,Result)-1,length(result)),'#','0');
                  end
             else begin
                    Result[length(Result)] := '0' ;
                  end;
             result := Result+
                     ';'+
                     '0'+ // O 1 Indica para salvar a mascara no resultado.
                     ';_' // Escreva o caractere _ ao inves de brancos.
           end
      Else begin
             if OkMask
             then begin
                    if IsNumber(aTypeFld)
                    then begin
                           Result[length(Result)] := '0' ;
                         end;
                    Result := Result+
                     ';'+
                     '1'+  // O 0 indica para não retorna a mascara junto com o campo
                     ';_' // Escreva o caractere _ ao inves de brancos.
                  end
             else Result := '';
           end;
    end;

    function TUiDmxScroller.Get_MaskEdit_LCL(aTemplate: ShortString;out OkMask: Boolean): AnsiString;

       Var Size_TypeFld,
           aLength_Buffer : SmallWord;
    begin
      result := Get_MaskEdit_LCL(aTemplate,Size_TypeFld, aLength_Buffer,OkMask);
    end;

    function TUiDmxScroller.DoAddRec: Boolean;
    begin
      Result := false;
    end;

    procedure TUiDmxScroller.SetBufDataset(aBufDataset: TBufDataset);
    begin
      if (DataSource<>nil) and (DataSource.DataSet =_BufDataset)
      then DataSource.DataSet := nil ;

      if (_BufDataset<>nil) and (_BufDataset.Owner=Self)
      then begin
             _BufDataset.free;
           end;

      _BufDataset := aBufDataset;
      if (DataSource<>nil) and (DataSource.DataSet = nil)
      then DataSource.DataSet := _BufDataset;
    end;


    function TUiDmxScroller.GetBufDataset: TBufDataset;

      procedure CreateBufDataset_FieldDefs;

         procedure SetAtributosDosFields;
            Var
              F : TField;
              i : Integer;

         begin
           if Assigned(_BufDataset) and (_BufDataset.State in [dsInactive])
           Then Begin
                   for i := 0 to Fields.Count-1 do
                   begin
                      SetCurrentField(Fields[i]);

                      with CurrentField^ do
                      begin
                       {$REGION 'Atualizar a propriedade ProviderFlags baseado tipo de acesso' }
                         f := _BufDataset.Fields[i];
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

                  with CurrentField^ do
                  begin
                    if (Fieldnum<>0) and (FieldName= '')
                    then begin
                           if not (TypeCode in [FldRadioButton,FldDbRadioButton])
                           then FieldName := 'Field'+IntToStr(Fieldnum)
                           {Os campos RadioButton tem nome duplicado
                           por isso o nome só está no primeiro da lista.}
                           else Continue;
                         end;

                    if TypeCode in CTypeString then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftString,FieldSize);
                    end
                    else
                    if CurrentField^.TypeCode in CTypeAnsiChar then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftFixedChar,FieldSize);
                    end
                    else
                    if CurrentField^.TypeCode = FldBoolean then
                    begin
                      _BufDataset.FieldDefs.Add(FieldName,ftBoolean);
                    end
                    else
                    if CurrentField^.TypeCode = FldDbRadioButton then
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
                      _BufDataset.FieldDefs.Add(FieldName,ftDate);
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

                _BufDataset.CreateDataset;
                SetAtributosDosFields;
             end;

      End;

      Procedure CreateBufDataSet;
      Begin
        if _BufDataset=nil
        then begin
                _BufDataset := TBufDataset.Create(Self);
                CreateBufDataset_FieldDefs;
                if TableName<>''
                Then _BufDataset.Name:=TableName;
             end;
      end;

      Procedure CreateDataSource;
      begin
        if DataSource= nil
        Then begin
               CreateBufDataSet;
               DataSource := TDataSource.Create(Self);
               DataSource.DataSet := _BufDataset;
             end;
      end;

    begin
      //if (DataSource <> nil) and (DataSource.DataSet <> nil)
      //then begin
      //       result := DataSource.DataSet;
      //       exit;
      //     end;

      //Cria datasource ou bufDataSet caso sejam nulos.
      if DataSource= nil
      Then CreateDataSource
      else if _BufDataset=nil
          then CreateBufDataSet;

      if DataSource.DataSet = nil
      Then DataSource.DataSet := _BufDataset;

      if DataSource.DataSet is TBufDataset
      then result := DataSource.DataSet as TBufDataset
      else Result := nil;
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
      then  Raise TException.Create(Self,'IfEqual',ParametroInvalido);

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
      result := not IfEqual(1,WorkingData,WorkingDataOld,RecordSize);
    end;

    class function TUiDmxScroller.CreateExecAction(
      const aFieldName: AnsiString; const aExecAction: AnsiString): AnsiString;
    begin
      result := chFN+getNameValid(aFieldName)+'~'+CharLupa_Left+'~'+ChEA+(getNameValid(aFieldName)+'.'+aExecAction);
    end;

    procedure TUiDmxScroller.add(aTemplate: AnsiString);
    begin
      if aTemplate=''
      Then aTemplate := '~~';
      _Strings.Insert(_Strings.count,aTemplate);
    end;

    procedure TUiDmxScroller.SetLocked(aLocked: Boolean);
    begin

    end;


  {$EndRegion 'TUiDmxScroller'}
  //======================================================

end.

{: Propriedade Template

   - CONCEITOS tvDMX
     - O modelo de formatação de dados
       A aparência padrão dessas visualizações geralmente é orientada por coluna/linha,
       com exceção de exibições do tipo formulário e campos únicos. Você declara um
       estrutura de registro para o procedimento de inicialização DMX em um modelo
       string --que também determina o formato de exibição. (Você verá mais tarde
       como o tvDMX pode ser usado para trabalhar com formulários ou editores de campo.)

     - Um Record de String [20], Integer e Real pode usar este formato:
       - ' sssssssssssssssssssss | iii |($rrr,rrr.rr)'

     - E isso apresentaria um registro desta forma:
                | Ace Exchange Network | 154 | $ 12.056,55 |
                | CommCheck, Inc.      | -28 |($ 725,00)   |

      A string do modelo neste exemplo estava inteiramente em letras minúsculas. Se em
      maiúsculas, os campos AnsiCharacter seriam inseridos em maiúsculas e
      campos numéricos seriam restritos a valores positivos.

      O TIPO de dados de cada campo é determinado pelos AnsiCharacters no
      corda. Todos os tipos de dados Pascal primários são suportados: BOOLEAN, BYTE,
      SHORTINT, Integer, LONGINT, WORD, String, AnsiChar, matrizes de AnsiChar e
      Real. O programador só precisa alterar essa string de modelo quando
      alterando a estrutura de dados. (Os códigos de modelo estão listados no
      página de referência.)

      Você pode alternar para reais ÚNICOS, DUPLOS ou ESTENDIDOS alterando TYPE
      TRealNum em RSET.PAS.


      Uma barra invertida ('\') pode ser usada como delimitador de campo e é exibida como
      um espaço AnsiCharacter. (Outros delimitadores também podem ser criados --por favor
      consulte o código de controle ^D.)

      O til ('~') AnsiCharacter pode ser usado para ativar o processamento de formato e
      fora. Isso torna possível separar os literais de texto do formato
      e códigos de controle:

          ' ~Nome:~ sssssssssssssssssssss\ ~SSN:~ ###-##-#### '

      Isso é exibido como:
          ' Nome: Abigail Adams SSN: 012-34-5678 '

      Campos de string agora podem ser abreviados com o '`' AnsiCharacter (o
      apóstrofo para trás) para que as cordas longas não ocupem tanto espaço
      a tela. Durante a edição, os usuários podem rolar dentro do campo.

      Exemplo:
          ' ssssssssssssssssssss` vlw,www'

      Isso será exibido assim:
          ' Negócios Internacionais>| 1.024'

      O '>' seria na verdade uma seta AnsiCharacter.


}


//procedure TForm1.FormCreate(Sender: TObject);
//  Var f : TField;
//begin
//  with BufDataset1 do
//  begin
//    FieldDefs.Add('id',ftInteger);
//    FieldDefs.Add('nome',ftString,50);
//    CreateDataSet;
//  end;
//
//  if BufDataset1.Active
//  Then with BufDataset1 do
//       begin
//         Edit;
//         f := FieldByName('id');
//         if f <> nil
//         then f.AsInteger := 1;
//
//         f := FieldByName('nome');
//         if f <> nil
//         then f.AsString := 'Paulo';
//         Append;
//
//         SaveToFile('Test');
//       end;
//end;
