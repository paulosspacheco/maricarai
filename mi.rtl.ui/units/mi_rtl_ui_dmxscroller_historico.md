{
# **HISTÓRICO DA UNIT mi_rtl_ui_DmxScroller**

  - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

  - **2022-02-08 14:15**
    - Data em que essa unit foi criada. ✅️

  - **2022-02-22 10:20**
    - Documentar a unidade. ✅️
    - Criar os métodos TUiDmxScroller.GetString(aOkSpc) e
      TUiDmxScroller.GetString. ✅️
    - Implementado a propriedade Active. ✅️

  - **2022-02-23 14:48**
    - Criar evento TUiDmxScroller.OnEnter(var Buff : Array of byte)**;
      - Analisar como o evento TUiDmxScroller.OnEnter vai interagir com o DataSource. ✅️
      - Criar a propriedade TUiDmxScroller.DataSource para acessar os dados do TDataSet. ✅️

  - **2022-02-24**
    - **02:15**
      - Implementar o evento **TUiDmxScroller.OnEnterField(aField:pDmxFieldRec);** ✅️
      - Implementar o método **TDmxFieldRec.DoOnEnter**;✅️

    - **8:50**
      - Implementar o evento - **TUiDmxScroller.OnExitField(aField:pDmxFieldRec)**.✅️
      - Implementar o método - **TDmxFieldRec.DoOnExit**;✅️

    - **8:50**
      - Testar se a classe TUiDmxScroller funciona em um TDataModule. ✅️
        - Deu erro porque o array TDmxScroller_Form_Atributos.DMXFields apontada
          para outros Templates e havia vazamento de memória. Para resolver
          implementei TDmxScroller_Form_Atributos.DMXFields para ser do tipo TFPList; ✅️

    - **16:00**
      - Criar método TUiDmxScroller.PutString(const aFieldName: tString; S: ShortString) ✅️
      - Criar método TUiDmxScroller.GetString(const aFieldName: tString):String ✅️

    - **19:20**
      - T12 Criar evento **TUiDmxScroller.onEnter(aDmxScroller:TUiDmxScroller)**; ✅️
        - Executar OnEnter quando :
          - Quanto a propriedade Active = true
          - Quando a propriedade Parent recebe o foco.

      - T12 Criar evento **TUiDmxScroller.OnExit(aDmxScroller:TUiDmxScroller)**.✅️
        - Executar OnExit quando :
          - Quanto a propriedade Active = False
          - Quando a propriedade Parent perde o foco.

  - **2022-02-25**
    - **08:30**
      - T12 Análise da implementação dos métodos GetBuffers e  PutBuffers da
        classe TUiDmxScroller. ✅️

    - **9:50**
      - T12 Analisar como o componente TUiDmxScroller vai interagir com os bancos de dados. ✅️
        - Como todos os controles do Lazarus reconhecem o componente TDataSet, então
          o caminho deve ser esse, porém o TDataSet precisa de conexão com um
          banco de dados e o mesmo precisa de um formulário para ler o nome do
          usuário e a senha.
        - Baseado no exposto no item anterior preciso de:
          - Uma propriedade TDataSet.
          - Uma conexão com um banco de dados qualquer.
          - Um cadastro de usuários
            - id - Campo numérico auto incremental
            - Login - Campo alfanumérico 50 posições
            - email - campo alfanumérico com 50 posições
            - Senha - com 25 posições
            - Nome Completo do usuário.

          - Um arquivo de log para controlar o acesso dos usuários.

  - **2022-03-01**
    - **09:06**
      - Implementar SetParentLCL de tal forma que ao setar a **_ParentLCL**  a propriedade
      (_ParentLCL as TScrollBoxDMX).UiDmxScroller seja inicializada com o valor de Self. ✅️

    - **19:56**
      - Análise do componente TDataSet para entender como interagir com o mesmo;
        - **REFERÊNCIA**
          - [TDataSet FreePascal](https://www.freepascal.org/docs-html/fcl/db/tdataset.html)
            - O Componente TClientDataSet do Delphi é o [TBufDataset](https://www.freepascal.org/docs-html/fcl/bufdataset/tbufdataset.html).  ✅️

          - O projeto MarIcaraí for windows tem a classe TMI_DataSet no arquivo Tb_table_DS.pas ✅️

          - O projeto [DBDesigner](https://www.devmedia.com.br/dbdesigner-modelagem-de-dados/6840)
            permite criar modelos de banco de dados e gerar consulta SQL.

          - Lista de vários software de modelagem
            [Alternativas do DB Designer para linux](https://alternativeto.net/software/db-designer/?platform=linux).

          - o [Adminer](https://alternativeto.net/software/adminer/about/) é uma ferramenta de
            modelagem de código aberto. Está disponível no repositório do Linux Mint, porém precisa
            instalar o servidor web e isso dá trabalho e é complicado.

  - **2022-03-02**
    - **08:00**
      - O component [TDBConnectionConfig](https://fossies.org/linux/lazarus/examples/database/tsqlscript/dbconfig.pas)
        é usado para conectar-se ao banco de dados.
        - Exemplo de uso:
          - [Exemplo sqlDbTutorial3](/home/paulosspacheco/Freepascal/lazarus/examples/database/sqldbtutorial3) ✅️

      - Procurar um descendente do TDataSet que tenha a mesma função do TClientDataSet do Delphi.
        - [TBufDataset](https://www.freepascal.org/docs-html/fcl/bufdataset/tbufdataset.html).  ✅️
        - [Como escrever aplicativos de banco de dados na memória no Lazarus](https://wiki.freepascal.org/How_to_write_in-memory_database_applications_in_Lazarus/FPC) ✅️
        -
  - **2022-03-04**
    - **17:15**
      - T12 Criar a propriedade BufDataSet... ✅️

  - **2022-03-05**
    - **08:50**
      - T12 Criar a propriedade BufDataSet para transferir os dados de DmxScroll para os controles da IDE. ✅️

    - **14:42**
      - T12 Implementar o método **TUiDmxScroller.GetBuffers**: ✅️
        - Executar BufDataSet.edit antes de ler o dados do dataSet; ✅️
        - Ler o buffer de **BufDataSet** e atualizar os campo da classe **TUiDmxScroller.Fields** ✅️

      - T12 Implementar o método **TUiDmxScroller.PutBuffers**:
        - Transfere os dados da classe **TUiDmxScroller** para a propriedade **BufDataSet**. ✅️

    - **15:00**
      - O Evento TUiDmxScroller.OnEnter deve executar o método TUiDmxScroller.GetBuffers  ✅️
      - O Evento TUiDmxScroller.OnExit deve executar o método TUiDmxScroller.PutBuffers ✅️

    - **20:00**
      - Criar o atributo Set_BufDataSet_Fields_ReadOnly usado para habilita e desabilitar
        a gravação de dados em **BufDataSet** ✅️

    - **21:22**
      - T12 Criar método FieldByName(aName:String):PDmxFieldRec; ✅️


  - **2022-03-07**
    - **15:19**
        - T12 Pensar como atualizar o buffer de todos os campo alterados quando algum campo é alterado
          nos eventos onExit onEnter dos campos. ✅️

      - **15:19**
        - T12 Criar um buffer para salva o registro atual ao entrar no diálogo. ✅️

  - **2022-03-08**
    - **08:20**
      - T12 O campo TDmxFieldRec.GetFieldAltered retorna true se o buffer
        atual for diferente do buffer anterior. ✅️
        - Obs: O TDmxScroller.CurrentField  deve manter-se inalterado. ✅️

    - **10:10**
      - T12 Criar o campo status em TDmxScroll para indicar o modo atual da class. ✅️
        - status : Longint
          - Mb_St_Active = Mb_Bit21;
             - 0= Método CreateStructur não executado ;
             - 1= Método CreateStructur executado/
             - Obs: Deve ser setado em CreateStructor

          - Mb_St_Edit = Mb_Bit22;
            - 0 = Classe não está no modo de edição;
            - 1 = Classe está no modo de edição
            - Obs: Deve ser setado em DoOnEdit;

      - T12 Criar método SetState  ✅️
      - t12 Criar método GetState  ✅️

      - T12 Em GetBuffers o WorkingData deve ser movido para WorkingDataOld. ✅️

    - **14:40**
      - T12 Corrigir problema com evento onExitField do DmxScroller quando o campo é FldEnum. ✅️
        - O problema estava em TMI_ComboBox_LCL.DoOnExit o mesmo não era executado.

      - T12 Remover dos controles visuais a checagem de TDmxFieldRec.filedAltered. ✅️

      - **15:15**
        - T12 Criar a propriedade Appending   ✅️
        - T12 Criar método DoOnNewRecord ✅️
          - Este método dever se executado em CreateStructur para que o usuário tenha a possibilidade
            de cadastrar os valores default dos campos.

      - **15:15**
        - T12 Criar o evento OnNewRecord  ✅️

  - **2022-03-09**
    - **08:42**
      - T12  Estudar como o componente **TDmxScroller** pode conectar-se ao componente SQLdb. ✅️
        - Solução:
          - Ao invés de usar **TBufDataset**, usar o componente  **TBufDataset**,
            porque é o pai de **TBufDataset** e  pai de **TSQLQuery**. Essa mudança permite
            que se use a opção de gravar em memória ou gravar em todos os bancos de dados
            que o componente TSQLdb reconhece hoje e no futuro.

    - **11:00**
      - T!2 ANáLISE DE COMO USAR OS DOIS COMPONENTES:
        - Trocar o nome do atributo **BufDataset** para **BufDataset**; ✅️
        - Nome do arquivo onde localizar no Template?
          - Ao ler o Template pode-se definir todos os parâmetros de **TCustomSQLQuery** ou **BufDataset**  ✅️
        - Reconhecer duas possibilidade para os descendentes de BufDataset quais sejam:
          1. BufDataset  ✅️
          2. TCustomSQLQuery - Obs: Preciso das propriedades de acesso a banco de dados SQL. ✅️

    - **20:00**
      - T12 Criar conexão com banco de dados usando componente **TCustomSQLQuery**. ✅️

  - **2022-03-13**
    - **08:00**
      - T12 Permitir que o nome do campo contenha | indicando que se trata de **tabela|campo**. ✅️

  - **2022-03-14**
    - **10:00**
      - **ATRIBUTOS TRANSFERIDOS PARA A CLASSE **TUiDmxScroller_sql_atributos**:
        - BufDataset ✅️

      - **PROPRIEDADES TRANSFERIDOS PARA A CLASSE **TUiDmxScroller_sql**:
        - DataSource  ✅️

      - **MÉTODOS TRANSFERIDOS PARA A CLASSE **TUiDmxScroller_sql**:   ✅️
        - getTemplate
        - CreateBufDataset_FieldDefs
        - Set_BufDataset_Fields_ReadOnly
        - GetBuffers
        - PutBuffers
      -

  - **2022-03-14**
    - **10:00**
      - **ATRIBUTOS TRANSFERIDOS PARA A CLASSE **TUiDmxScroller_sql_atributos**:
        - BufDataset   ✅️

      - **PROPRIEDADES TRANSFERIDOS PARA A CLASSE **TUiDmxScroller_sql**:
        - DataSource    ✅️

      - **MÉTODOS TRANSFERIDOS PARA A CLASSE **TUiDmxScroller_sql**: ✅️
        - getTemplate
        - CreateBufDataset_FieldDefs
        - Set_BufDataset_Fields_ReadOnly
        - GetBuffers
        - PutBuffers
      -

  - **2022-03-16**
    - **09:35**
      - Criar o tipo TMiProviderFlags:  ✅️


      - Criar o caractere de controle **CharProviderFlag** para usa-lo no Template:  ✅️
        - O caractere de controle **CharProviderFlag** é usado pelo método **TUiDmxScroller_sql.CreateTables**
          para indicar que o caractere seguinte tem um sinalizador usado para criar tabelas no banco de dados.

          - **SINALIZADORES**
            - 0 = **pfInUpdate** : As alterações no campo devem ser propagadas para o banco de dados..

            - 1 = **pfInWhere** : O campo deve ser usado na cláusula WHERE de uma instrução de
                                  atualização no caso de upWhereChanged.

            - 2 = **pfInKey** : Campo é um campo chave e usado na cláusula WHERE de uma instrução de atualização.

            - 3 = **pfHidden**          : O valor deste campo deve ser atualizado após a inserção.

            - 4 = **pfRefreshOnInsert** : O valor deste campo deve ser atualizado após a inserção.

            - 5 = **pfRefreshOnUpdate** : O valor deste campo deve ser atualizado após a atualização.

            - 6 = **pfInKeyPrimary** : Campo é um campo chave primária e usado na cláusula WHERE de uma instrução de atualização.

            - 7 = **pfInAutoIncrement** : Campo é um campo auto-incremental e usado em uma instrução de atualização.

          - **NOTAS**
            - O campos com access = AccSkip automaticamente o atributo MIProviderFlag terá [pfHidden]
            - O valor defaults de MiProviderFlags := [pfInUpdate,pfInWhere];


        - EXEMPLO DE USO NO TEMPLATE    ✅️

          ```pascal

            Function TDM_Aluno.DmxScroller_Form1GetTemplate ( aNext : PSItem ) : PSItem;
            Begin
              with DmxScroller_Form1 do
              begin
                Result :=
                  NewSItem('~     Matrícula ~\LLLLL'+CharFieldName+'matricula'+CharAccReadOnly+CharPfInKeyPrimaryAutoIncrement,
                  NewSItem('~Nome do aluno: ~\ssssssssssssssssssss`sssssss'+CharFieldName+'Nome'+CharPfInKey,
                  NewSItem('',
                  NewSItem('~     Endereço: ~\ssssssssssssssssssss`sssssssssss'+CharFieldName+'Endereco',
                  NewSItem('~P. Referência: ~\ssssssssssssssssssss`sssss'+CharFieldName+'PontoDeReferencia',
                  NewSItem('~          Cep: ~\##.###-###'+CharFieldName+'cep',
                  NewSItem('~       Estado: ~\SS'+CharFieldName+'Estado'+CharForeignKeyN_Um_false+'Estados,Estado',
                  NewSItem('~       Cidade: ~\ssssssssssssssssssss`sssss'+CharFieldName+'cidade'+CharForeignKeyN_Um_false+'Cidades,Estado;Cidade',

                  NewSItem('',
                  aNext)))))))));
              end;
            end;

          ```

      - Cria o atributo **TDmxFieldRec.ProviderFlags** : TMIProviderFlags para ser usado
        em createTable na criação de tabelas no banco de dados. ✅️

    - **14:38**
      - T12 Atualizar TDmxFieldRec.ProviderFlags quando encontrar ^P na analise do Template. ✅️

  - **2022-03-19**
    - **10:50**
      - T12 Criar a opção de definir a ligação entre tabela onde a relação deve ser declarada após
        o caractere CharForeignKey.
        - Criar campo **TDmxFieldRec.ForeignKeys** ✅️
          -  Em TUiDmxScroller.CreateStruct preencher este campo quando o  caractere **CharForeignKey** for encontrado. ✅️

    - **19:42**
      - Criar campo **TDmxFieldRec.KeyForeign** ✅️
        -  Em TUiDmxScroller.CreateStruct preencher este campo quando o  caractere **CharForeignKey** for encontrado. ✅️


  - **2022-03-21**
    - **09:05**
      - T12 Em CreateTable criar chaves primária composta.  ✅️
        - Exemplo de uso de chave primária composta:
          - O cadastro de cidades precisa de chave composta, porque a mesma cidade
            pode existir em mais de um estado.

        - **ALGORÍTIMO**:
          - Ao adicionar a coluna que tem o flag CharPfInKeyPrimary e tipo de campo
            string é porque existe outros campos que fazem parte da chave primária.

          - Criar TUiDmxScroller.KeysCompositePrimaryKey : String.  ✅️
            - Esse atributo deve ser iniciado em CreateStructur onde:
              - A chave **KeysCompositePrimaryKey** contém uma lista de nome dos campos
                que pertencem a chave e deve ser iniciado ao encontrar o flag CharPfInKeyPrimary.

              - Caso existe mais de uma ocorrência de CharPfInKeyPrimary antão o nome
                do campo deve ser concactenado separado por virgula por exemplo:
                - KeysCompositePrimaryKey = 'Estato,Cidade';  ✅️

              - Condição para keysPrimaryKeyComposite seja chave composta é:
                - pos(',',KeysCompositePrimaryKey) <> 0;

          - Criar TUiDmxScroller.flagPrimaryKey_AutoIncrement:Boolean onde será:  ✅️
            - **true**  : Se for chave numérica autoincremental;
            - **false** : Não é chave numérica autoincremental;

  - **2022-04-28**
   - Criar propriedade DataSource. ️ ✅️

  - **2022-04-06**
    - **14:05**
      - T12 Criar o envento OnCloseQuery   ✅️
        - Este evento deve ser disparado antes de desativar a classe **TUiDmxScroller** e se o
          parâmetro CanClose for false então a classe **TUiDmxScroller** não dever ser desativado.  ✅️

  - **2022-05-18**
    - **10:51**
      - T12 A crase indica a posição do Template onde o mesmo deve ser truncado,
        porém a posição está duas posições a menos comparada aos outros Templates
        quando se cria o formulário em: **TDmxScroller_Form.CreateFormLCL**
        - Ex:
          - '~Aluno  :~\ssssssssss`sssssssss'+lf+
            '~Cidade  :~\sssssssss'+lf+

          - O Template acima a cx de diálogo do Aluno fica menor que a caixa de diálogo cidade.

        - Graças a Deus encontrei o problema:  ✅️
          - O método **TObjectsMethods.StringToSItem()** estava adicionando
            **constStr(NumberCharControl(aStrMsg),' ')** no fim da linha.
            O problema foi resolvido quando troquei ' ' por #0 ..

  - **2022-05-28**
    - **20:00**
      - T12 - Implementar o campo TDmxFieldRec.ExecAction e o método TDmxScroller.CreateExecAction.  ✅

  - **2022-05-30**
    - **17:14**
      - T12 - Criar a propriedade ActionList: TActionList;  ✅

  - **2022-05-31**
    - **15:21**
      - Criar atributo LinkExecAction:pDmxFieldRec;
        - O atributo LinkExecAction deve ser iniciado com o nome do campo passado pelo label.

  - **2022-06-01**
    - **20:10**
      - Implementar o controle TMi_checkbox_LCL em campos boolean; ✅

  - **2022-06-02**
    - 21:13
      - T12 Implementar o campo FldRadioButton.
        - O FldRadioButton no TurboVision era do tipo bits, porém na implementação
          no lazarus ele passou a ser um campo do tipo byte, porque o componente
          TRadioButton retorna o índice da lista passada ao criar o componente.
          - Nota: é possível trocar o tipo FldRadioButton por fldEnum e a informação será
            a mesma.  ✅

        - A LCL tem um controle de nome TRadioGroup que se insere os elementos nele e
          ele se ajusta sozinho. ✅

  - **2022-06-03**
    - 08:55
      - T12 Criar componente TMI_RadioGroup_LCL integrado ao campo PDmxFieldRec. ✅
      - T12 Como evitar que um campo receba o foco quando seu tipo de acesso for accSkip?  ✅
        - Usar propriedade TabStop do controle.  ✅

        - **2022-06-08**
          - 20:30
            - T12 Criar a propriedade Strings:TStringList para armazenar
              Template para que se possa visualizar o formulário em tempo
              de projeto. ✅

        - **2022-06-13**
          - 08:37
            - T12 Criar método add(aTemplate:AnsiString) para adicionar
              um string a coleção de strings; ✅

            - t12 Criar evento OnAddTemplate: ✅

  - **2022-06-15**
    - 10:30
      - T12 Se propriedade TDmxScroller.DataSource.dataSet = nil então criar
        propriedade TDmxScroller.BufDataSet. ✅

      - T12 Criar método TUiDmxScroller.SetBufDataSet para destruir _BufDataSet em
        DestroyStruct. ✅

    - 21:56
      - T12 O tipo de campo FldEnum é do tipo byte e por isso devem ser editados
        com TComboBox.
        - Para manter compatibilidade os campos fldEnum deve ser do tipo longint.
        - Os campos enumerados contém um número de registro que está em outra tabela,
          por isso o controle usado para editá-lo é o TDBLookupComboBox se.  ✅

  - **2022-06-16**
    - 16:30
      - TI2 Mudar o tipo do campo fldENUM de byte para LongInt. ✅

    - 18:25
      - T12 Em TDxmScrollerForm_ds trocar controle ComboBox por DbLookupComboBox
        - T12 Criar type TFldEnum_Lookup
          - BufDataSet : TBufDataSet;
          - DataSource : TDataSource;
          - KeyField   : AnsiString;
          - ListField  : AnsiString;
          - constructor create(aDmxFieldRec: pDmxFieldRec);

  - **2022-06-17**
    - 08:30
      - T12 Em TDxmScrollerForm_ds trocar controle TMi_ComboBox_lcl por TMi_DbLookupComboBox_lcl  ✅
        - T12 Criar type TFldEnum_Lookup
          - BufDataSet : TBufDataSet;
            - Criar definição dos campos;  ✅
            - Adicionar a lista do Template associado a DmxFieldRec.  ✅
          - DataSource : TDataSource;  ✅
          - KeyField   : AnsiString;   ✅
          - ListField  : AnsiString;   ✅
          - constructor create(aDmxFieldRec: pDmxFieldRec);  ✅
          - destructor destroy;override;  ✅

    - 9:40
      - Criar componente TMi_DbLookupComboBox_lcl. ✅
      - T12 Criar o tipo de campo **FldDbRadioButton =  'k'(minúsculo)**. ✅
        - O tipo FldDbRadioButton é um campo tipo String que é representado
          no Template em controle TDbRadioButton.

        - **NOTAS**
          - Um Template pode conter vários campos do tipo DbRadioButton e o mesmo
            é identificado após a sequencia \k? onde ? indica que a informação
            pertence ao campo ?
            - Exemplo:
              - SEXO
                - \ka Masculino
                - \ka Feminino
                - \ka Indefinido

          - Os campos TDbRadioButton possuem o mesmo número de campo e na primeira
           ocorrência contém o nome do campo na lista pDmxFieldRec.

          - O motivo pelo qual **@name** foi criado é que o banco de dados do freepascal
           reconhece esse tipo como string com o nome do caption selecionado.

          - O tamanho da string deve ser o tamanho da maior string da lista de opções.

  - **2022-06-20 e 21**
    - 09:07
      - T12 criar controle **CharListComboBox**. ✅
        - Qualquer tipo pode ter uma lista de opções para o campo onde
          o tipo da lista deve ser compatível com os dados do campo.
          - Ex: Se o campo é byte os valores possíveis deve ser número
                entre 0..255 caso seja diferente SetAsString gera exceção.

        - Em TDmxFieldRec criar os campos:
          - Public **ListComboBox**  : PSItem;
          - public **ListComboBox_Default** : Longint;

        - Após o controle CharListComboBox espera-se um ponteiro para uma pSItem
          e o mesmo deve iniciar TDmxFieldRec.ListComboBox.

        - Ao construir o formulário caso tenha TDmxFieldRec.ListComboBox<>nil
          e o campo for diferente de FldRadioButton, fldEnum, fldBoolean, fldCheckBox
          então o mesmo deve ser editado com o componente Tmi_ui_ComboBox e só
          aceitar o valor que está na lista.

  - **2022-06-22 e 23**
    21:00
      T12 Implementar o método virtual **Scroll_it_inview** com objetivo de permitir
          que o controle visual role a tela caso a ferramenta visual não o faça.
          - Ex: A LCL não dá scroller quando o campo não está visível e recebe o foco.

  - **2022-06-24**
    - 10:13
      - T12 Criar **link** no controle **TDmxScroller**
        - Criar constante FldLink. 
          - Na LCL o controle que melhor representa este campo é **TStaticText**.
    - 14:00
      - Documentar os campos que acessam TDataSet e corrigir falhas que aparecerem no componente.
   
}
