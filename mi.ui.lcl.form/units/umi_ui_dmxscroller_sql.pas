Unit mi_ui_Dmxscroller_sql;
{:< A unit **@name** implementa a classe TUiDmxScroller_sql.

  - **VERSÃO**
    - Alpha - 0.9.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi_ui_Dmxscroller_sql.pas">mi_ui_Dmxscroller_sql.pas</a>)

    - **PENDÊNCIAS**
      -  T12 Falta implementar chave estrangeira em createTable;
      -  T12 Em TUiDmxScroller_sql.DoOnNewRecord; está executando o método (CustomBufDataset as TSQLQuery).Append;
          antes do componenente TUiDmxScroller_sql está visível e isto está gerando exceção.

      - T12 ANÁLISE
        - [Estudar os procedimentos armazenados](https://www.w3schools.com/sql/sql_stored_procedures.asp)
        - [Estudar as restrições SQL](https://www.w3schools.com/sql/sql_constraints.asp)

        - Como saber se um campo é uma chave que liga outra tabela?
          - [SQL FOREIGN KEY Constraint](https://www.w3schools.com/sql/sql_foreignkey.asp)

            ```pascal

              /*Não, podemos permitir que os registros das pessoas que possuim camisetas
                lavando sejam apagados, para garantir a integridade da informação.
                Para isso devemos utilizar o as chaves estrangeiras que acusarão
                um erro quando tentarmos deletar uma pessoa que possuir camisetas.
                Veja em código:
              */

              CREATE TABLE Pessoa(
                  IdPessoa INT NOT NULL PRIMARY KEY IDENTITY(1,1),
                  Nome VARCHAR(20) NOT NULL
              )

              CREATE TABLE Camiseta(
                  IdCamiseta INT NOT NULL PRIMARY KEY IDENTITY(1,1),
                  Descrição VARCHAR(20) NOT NULL,
                  IdPessoa INT NOT NULL
                  CONSTRAINT FK_Camiseta_Pessoa FOREIGN  KEY(IdPessoa) REFERENCES Pessoa(IdPessoa)
              )

              INSERT INTO Pessoa VALUES ('HeyJoe')
              INSERT INTO Pessoa VALUES ('Caique')


              INSERT INTO Camiseta VALUES ('Azul', 1)
              INSERT INTO Camiseta VALUES ('Amarela', 1)
              INSERT INTO Camiseta VALUES ('Preta', 2)

              SELECT * FROM Pessoa, Camiseta WHERE Pessoa.IdPessoa = Camiseta.IdPessoa


            ```

        - Como saber o tipo de relacionamento que os campos de outra tabela tem com a tabela atual?

      - T12 A opção CreateTable está dando mensagem de erro quando a coluna já existe.
            - Encontrar uma forma de não gerar exceção ou ignorar as exceções nesta rotina.

      - T12 Em TUiDmxScroller_sql.AlterTable checar:
        - T12 Criar código para todos os tipos reconhecidos por marIcaraí.

        - T12 Debugar para saber se está tudo funcionando.

        - T12 Permitir adicionar uma nova coluna mesmo que a tabela já exista.

      - T12 Em SetTableName(aTableName:String) criticar o nome aTableName é um nome válido para a tabela.


    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br) ✅

      - **2022-03-13**
        - **09:00**
          - T12 Implementar a criação de código SQL baseado nos dados de TUiDmxScroller.
            - **ANÁLISE:**
              - Onde pegar o nome da tabela ou consulta? ✅
                - TUiDmxScroller.CustomBufDataset.FileName;

              - Onde pegar o nome dos campos da tabela CustomBufDataset.Filename? ✅
                - A lista de campos encontra-se em : TUiDmxScroller_Atributos.Fields : TFPList;

              - Como saber se TUiDmxScroller é uma tabela ou a uma consulta?
                - Se todos os TUiDmxScroller_Atributos.Fields[].FieldName não contém '|'
                  é porque é FileName é uma tabela. ✅

                - Se pelo menos um TUiDmxScroller_Atributos.Fields[].FieldName contém '|'
                  é porque é FileName é uma consulta envolvendo mais de uma tabela. ✅

              - Como saber se uma tabela ou consulta existe do banco de dados?
                - O SQL do **postegres** e do **sqlite3** tem a clausula **IN NOT EXISTS**
                  no comando CREATE TABLE:
                  - EXEMPLO:

                    ```pascal
                        CREATE TABLE IF NOT EXISTS TEST01 ();  ✅
                    ```

            - **REFERÊNCIAS**
              - [SQL:2016](https://en.wikipedia.org/wiki/SQL:2016)
                - (PostgresSQL aceita 160 das 169 especificação 2016)(https://www.postgresql.org/docs/12/features.html)
                - [Comparativo entre os bancos de dados x conformidade SQL](https://en.wikipedia.org/wiki/SQL_compliance)
                - [Clientes de bancos de dados opensource](https://medevel.com/17-sql-client-open-source/)
                - [Instalei programa cliente SQL DBeaver](https://dbeaver.io/)
                  - Obs: Não deu certo. Ele é escrito em java e não funcionou o básico.
                - [sqlite create database if not exists](https://www.codegrepper.com/code-examples/sql/sqlite+create+database+if+not+exists)



      - **2022-03-14**
        - **08:22**
          - T12 Criar a unit mi_ui_Dmxscroller_sql.pas com a classe **TUiDmxScroller_sql**
            com objetivo de concentrar a integração do TDmxScroller com o componente
            **TSQLQuery** ✅

        - **20:00**
          - T12 Na Construção de TFields atualizar a propriedade **TField.ProviderFlags**
            com o tipo de acesso definido em TDmxFieldRec.Access ✅

        - **21:12**
          - T12 Criar propriedade **TableName** ✅

        - **21:27**
           - T12 Criar Function SetSqlCustomBufDataset:Boolean;Virtual;
             -  CustomBufDataset.SQL := **SELECT * FROM X ** onde X será definido pela
                propriedade **TableName**   ✅

      - **2022-03-15**
        - **09:11**
          - Depurar o que fiz ontem para fazer funciona a atualização do
            banco de dados SQL.  ✅

        - **11:36**
            - Criar método TUiDmxScroller_sql.AlterTable : Boolean;  ✅

        - **14:38**
          - T12 Atualizar TSQLQury.TFields.ProviderFlags com TUiDmxScroller.MiProviderFlags ✅

      - **2022-03-16**
        - **16:23**
          - T12 Em TUiDmxScroller_sql.CreateCustomBufDataset_FieldDefs, atualizar
            **TField.ProviderFlags** com os dados do campo **TDmxFieldRec.ProviderFlags**. ✅

        - **16:54**
          - Em TUiDmxScroller_sql.AlterTable usar os flags TDmxFieldRec.ProviderFlags
            para criação da tabela. ✅

      - **2022-03-17**
        - **10:48**
          - T12 Os flags indicando que se trata de chave primária não está sendo atualizado
            em createStructor, por isso não está criando a chave primária.  ✅

      - **2022-03-18**
        - **10:40**
          - T12 Ao criar uma tabela SQL em **AlterTable** adicionar colunas ao invés
            de criar a tabela toda.  ✅
            - **Motivo**:
                - Permitir que o banco de dados fique compatível com o Template.
                - Alterar um coluna de forma automática não é bom, porque o que está feito
                  gera dependências que produzirão erros ao fazer essas alterações.


      - **2022-03-21**
        - **08:57**
          - T12 Criar function SQL_AddkeysPrimaryKeyComposite(I : Integer):Boolean;  ✅
            - Esta função adiciona chave primária composta na tabela.
            - **REFERÊNCIA**
              - [Como adiconar chave primaria usando a expressão ALTER TABLE](https://www.techonthenet.com/postgresql/primary_keys.php#:~:text=In%20PostgreSQL%2C%20a%20primary%20key%20is%20created%20using%20either%20a,or%20drop%20a%20primary%20key.)

        - **15:40**
          - T12 Em AlterTable criar a restrição  de chave estrangeira no TDmxScroller_sql.  ✅
            - Nome da função: function AddKeyForeigns(I : Integer):Boolean;

      - **2022-03-22**
        - **09:00**
          - T12 Documentar as units TuiTypes e TUIConsts.  ✅

        - **10:00**
          - T12 Criar os relacionamentos entre tabelas (restrições entre tabelas)  ✅

        - **14:14**
          - T12 Depurar os relacionamentos entre tabelas.  ✅


        - **18:47**
          - O Componente CustomBufDataset não está entrando no modo edit.  ✅
            - O problema estava nos eventos TScrollBoxDMX.DoOnEnter e TScrollBoxDMX.DoOnExit;]

      - **2022-03-22**
        - **20:27**
          - T12 Analisar como criar os comandos CmIncluir, cmAlterar, cmExcluir, cmConsulta para a tabela TDmxScroller
            - Criar os comandos:  ✅
              - Public Procedure DoOnNewRecord;overload;override; //Usado para inicializa os parametros de um novo registro
              - Public Procedure PutRec;Override;//Grava o buffer no arquivo memo
              - Public Procedure GetRec;Override;//O primeiro registro esta gravado em Value
              - Public Function DeleteRec:Boolean;Override;
              - Function UpdateRec: Boolean;Override;
              - Function UpdateRec_if_RecordAltered:Boolean;Override;
              - Function PrevRec : Boolean;overload;override;
              - Function NextRec : Boolean;overload;override;

      - **2022-03-23**
        - Criar método Public Function AddRec:Boolean;Override;  ✅
          - Para que DoAddrec possa adicionar o registro é necessário que o registro esteja selecionando, ou seja no modo edit.
          - Obs: Está com problema.

      - **2022-03-25**
        - [Estudar página sobre o banco de dados firebird](https://wiki.freepascal.org/Firebird#Creating_objects_programmatically)  ✅

      - **2022-03-28**
        - Em TUiDmxScroller_sql.DoOnNewRecord; está executando o método (CustomBufDataset as TSQLQuery).Append;
          antes do componenente TUiDmxScroller_sql está visível e isto está gerando exceção.
        -

      - **2022-03-30**
          - Implementar a conexão com o banco de dados usando o componente Mi_Application.

      - **2022-04-14**
        - Debugar o método **TUiDmxScroller_sql.AlterTable**.

      - **2022-04-15**
        - O método **TUiDmxScroller_sql.AlterTable** precisa reconhecer a sintaxe do banco
          de dados selecionado.
          - O postgresSQL sintaxe:
            - CREATE TABLE [IF NOT EXISTS] table_name (
                 column1 datatype(length) column_contraint,
                 column2 datatype(length) column_contraint,
                 column3 datatype(length) column_contraint,
                 table_constraints
               );

            - **REFERÊNCIA**
              - [postgresql-create-table](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table/)

          - O sqLite3 sintaxe:
            - CREATE TABLE [IF NOT EXISTS] [schema_name].table_name (
      	    column_1 data_type PRIMARY KEY,
       	    column_2 data_type NOT NULL,
      	    column_3 data_type DEFAULT 0,table_constraints) [WITHOUT ROWID];

            - **REFERÊNCIA:**
              - [sqlite-create-table](https://www.sqlitetutorial.net/sqlite-create-table/)
}

//==============================================================
{$REGION ' Trabalhos do dia.'}
  {

  - **2022-04-18**
    - T12 O SqLite não permite criar uma tabela sem pelo menos 1 campo, por isso devo
      implementar em create tabela a adição do  campo de chave primária ou
      campo de chave única ou o primeiro campo da tabela.
      - T12 - Criar método **TUiDmxScroller_sql.CreateTables**.

    - Desativar por enquanto o método **TUiDmxScroller_sql.AlterTables**.

  }

{$ENDREGION 'Trabalhos do dia'}
//==============================================================

{$mode Delphi}

Interface

Uses
  Classes, SysUtils,BufDataset,db,SqlDb,mi.rtl.Types,mi_ui_types,mi_ui_consts,mi_ui_Dmxscroller
  ,uMi_ui_custom_application;

TYPE

  { TDmxScroller_sql_Atributos }
  {: A class **@name** contém os atributos da class TDmxScroller_sql}
  TDmxScroller_sql_Atributos = class(TUiDmxScroller)

    {: O atributo pública **@name** é definida em **CreateCustomBufDataset_FieldDefs** que
       é executado em **TDmxScroller.CreateData** baseado na estrutura do Template passado por GetTemplate.

       - **NOTA**
         - O atributo **@name** deve ser passado por **DataSource.DataSet**.

         - Em **CreateCustomBufDataset_FieldDefs** é criado os campo da propriedade **@name** se a propriedade
           (DataSource<>nil) e (DataSource.DataSet <> nil).

         - Se a propriedade DataSource.DataSet = nil então a propriedade **CustomBufDataset=nil**

         - O método **CreateCustomBufDataset_FieldDefs** reconhece duas possibilidade para os descendentes
           de CustomBufDataset quais sejam:
            1. [TBufDataset](https://www.freepascal.org/docs-html/fcl/bufdataset/tbufdataset.html)
            2. [TCustomSQLQuery](https://www.freepascal.org/docs-html/fcl/sqldb/tcustomsqlquery.html)
               - Preciso das propriedades de acesso a banco de dados SQL.
               - O evento OnGetTemplate deve setar as propriedades customizadas de **TCustomSQLQuery**.

       - **REFERẼNCIA**:
         - [tcustombufdataset](https://www.freepascal.org/daily/packages/fcl-db/bufdataset/tcustombufdataset-14.html)
         - [tcustomsqlquery](https://www.freepascal.org/docs-html/fcl/sqldb/tcustomsqlquery.html)

         - [TCustomBufDataset](https://www.freepascal.org/docs-html/fcl/bufdataset/tcustombufdataset.html);
         - [TBufDataSet](https://wiki.freepascal.org/How_to_write_in-memory_database_applications_in_Lazarus/FPC#TBufDataSet)
         - [tstatementtype.html](https://www.freepascal.org/docs-html/fcl/sqltypes/tstatementtype.html)
         - [tsqlquery](https://www.freepascal.org/docs-html/fcl/sqldb/tsqlquery.html)
         - [tdatasetstate](https://www.freepascal.org/docs-html/fcl/db/tdatasetstate.html)
         - [How_to_connect_to_a_database_server](https://wiki.freepascal.org/SqlDBHowto#How_to_connect_to_a_database_server.3F)
         - [Example:_reading_data_from_a_table](https://wiki.freepascal.org/SqlDBHowto#Example:_reading_data_from_a_table)
         - [How_to_execute_direct_queries.2Fmake_a_table](https://wiki.freepascal.org/SqlDBHowto#How_to_execute_direct_queries.2Fmake_a_table.3F)
         - [How_to_read_data_from_a_table](https://wiki.freepascal.org/SqlDBHowto#How_to_read_data_from_a_table.3F)
         - [Why_does_TSQLQuery.RecordCount_always_return](https://wiki.freepascal.org/SqlDBHowto#Why_does_TSQLQuery.RecordCount_always_return_10.3F)
         - [Como usar SQLDb no Lazarus](https://wiki.freepascal.org/SqlDBHowto#Lazarus)
         - [Trabalhando com tabelas relacionadas](https://wiki.freepascal.org/MasterDetail)
         - [How_to_change_data_in_a_table](https://wiki.freepascal.org/SqlDBHowto#How_to_change_data_in_a_table.3F)
         - [How_does_SqlDB_send_the_changes_to_the_database_server](https://wiki.freepascal.org/SqlDBHowto#How_does_SqlDB_send_the_changes_to_the_database_server.3F)
         - [How_to_handle_Errors](https://wiki.freepascal.org/SqlDBHowto#How_to_handle_Errors)
         - [How_to_execute_a_query_using_TSQLQuery](https://wiki.freepascal.org/SqlDBHowto#How_to_execute_a_query_using_TSQLQuery.3F)
         - [How_to_use_parameters_in_a_query](https://wiki.freepascal.org/SqlDBHowto#How_to_use_parameters_in_a_query.3F)
         - [Select_query](https://wiki.freepascal.org/SqlDBHowto#Select_query)
         - [Exemplo de SQLQuery com parãmetros](https://wiki.freepascal.org/SqlDBHowto#Example)
         - [Troubleshooting:_TSQLConnection_logging](https://wiki.freepascal.org/SqlDBHowto#Troubleshooting:_TSQLConnection_logging)
           - [Exemplo de log](https://wiki.freepascal.org/SqlDBHowto#FPC_.28or:_the_manual_way.29)



    }
    public CustomBufDataset : TCustomBufDataset;
//    public SQLQuery         : TSQLQuery;

  end;

  { TUiDmxScroller_sql }
  {: A classe **@name** implementa o acesso ao banco de dados usando o atributo
     **CustomBufDataset**

     - **NOTA**
       - O atributo **CustomBufDataset** pode ser **TBufDataset** não conectado
       a banco de dados sql e **TCustomSQLQuery** conectado ao banco de dados SQL.

     - **REFERÊNCIA**
       - [Working_With_TSQLQuery](https://wiki.freepascal.org/Working_With_TSQLQuery)
       - [Parameters_in_TSQLQuery](https://wiki.freepascal.org/Working_With_TSQLQuery#Parameters_in_TSQLQuery.SQL)
       - [sql-basico](https://www.devmedia.com.br/sql-basico/28877)
  }
  TUiDmxScroller_sql = class(TDmxScroller_sql_Atributos)

    {: O método **@name** retorna **ch** e **s** se **s**<>''}
    private function ValidStr(ch,s:AnsiString):AnsiString;

     protected procedure SetDataBase;

    {: Constrói o componente}
    public constructor Create(aOwner:TComponent);Override;


    {$REGION ' ---> Property DataSource : TDataSource '}

       protected _DataSource : TDataSource;

       {: A propriedade **@name** permite que controles da **LCL** (Lazarus Componenents Library)
          possam usar os dados do componenente **TDmxScroller**.

          - **NOTA**
            - Essa integração permite que **TDmxScroller** utilize todos os componentes de banco
              de dados do Free Pascal.
       }
       published property DataSource : TDataSource Read _DataSource   Write  _DataSource;
    {$ENDREGION ' <--- Property DataSource : TDataSource '}

    {: O método **@name** retorna a lista de campos pertencentes a chave composta primária.
    }
    public function GetkeysPrimaryComposite(I : Integer):AnsiString;

    {: A função **@name** retorna a chave primária composta ou não na tabela.

        - **Como TSQLQuery trata os campos de chave primária**
          - Ao atualizar registros, TSQLQuery precisa saber quais campos
            compõem a chave primária que pode ser usada para atualizar o registro
            e quais campos devem ser atualizados: com base nessas informações, ele constrói
            um comando SQL UPDATE, INSERT ou DELETE.

          - A construção da instrução SQL é controlada pela propriedade UsePrimaryKeyAsKey
            e pelas propriedades ProviderFlags .

          - A propriedade Providerflags é um conjunto de 3 sinalizadores:
            - pfInkey : O campo faz parte da chave primária
            - pfInWhere : O campo deve ser utilizado na cláusula WHERE das instruções SQL.
            - pfInUpdate : Atualizações ou inserções devem incluir este campo. Por padrão,
              ProviderFlags consiste apenas em pfInUpdate .

            - **NOTA*
              - Se sua tabela tiver uma chave primária (conforme descrito acima),
                você só precisará definir a propriedade **UsePrimaryKeyAsKey** como True e tudo
                será feito para você. Isso definirá o sinalizador pfInKey para os campos
                de chave primária.

        - **REFERÊNCIA**
          - [Working With TSQLQuery e Primary_key_Fields](https://wiki.freepascal.org/Working_With_TSQLQuery#Primary_key_Fields)

    }
    public function GetKeysPrimary:AnsiString;

    {: A função **@name** cria a tabela se a mesma não existir
    }
    public Function CreateTable: Boolean;

    {: O método **@name** cria a tabela ou consulta **TableName** no banco de dados caso a propriedade **TableName**
       não existe no banco de dados e **TableName** seja diferente de vazio.

       - O método **TUiDmxScroller_sql.AlterTable** precisa reconhecer a sintaxe do banco
         de dados selecionado.
         - O postgresSQL sintaxe:
           - CREATE TABLE [IF NOT EXISTS] table_name (
                column1 datatype(length) column_contraint,
                column2 datatype(length) column_contraint,
                column3 datatype(length) column_contraint,
                table_constraints
              );

           - **REFERÊNCIA**
             - [postgresql-create-table](https://www.postgresqltutorial.com/postgresql-tutorial/postgresql-create-table/)

         - O sqLite3 sintaxe:
           - CREATE TABLE [IF NOT EXISTS] [schema_name].table_name (
   	    column_1 data_type PRIMARY KEY,
      	    column_2 data_type NOT NULL,
   	    column_3 data_type DEFAULT 0,table_constraints) [WITHOUT ROWID];

           - **REFERÊNCIA:**
             - [lang_createtable.html](https://www.sqlite.org/lang_createtable.html)
             - [sqlite-create-table](https://www.sqlitetutorial.net/sqlite-create-table/)
             - [lang_createtable.html](https://www.sqlite.org/lang_createtable.html)

       - **NOTAS**
         - As tabelas só são criadas automaticamente caso a constante AlterTableQL = true.
         - Ao adiciona uma coluna que já exista no banco de dados o sistema trata a exceção
           e tenta adicionar a próxima coluna. Motivo: Poder expandir a tabela dinâmicamente.

         - O comportamento do Banco de dados SqLite ao criar uma tabela é diferente do postgres.
           - O sqLite não permite criar tabela vazia.

    }
    public  Function AlterTable : Boolean;Virtual;

    {: O método **@name** inicializa as propriedades SQLs de CustomBufDataset

       - **PROPRIEDADES OBRIGATÓRIAS SEREM INICIALIZADAS:**
         - CustomBufDataset.SQL;

       - **PROPRIEDADES OPCIONAIS SEREM INICIALIZADAS:**
         - CustomBufDataset.InsertSQL;
         - CustomBufDataset.UpdataSQL;
         - CustomBufDataset.DeleteSQL;
         - CustomBufDataset.RefreshSQL;

       - **GERAÇÃO AUTOMÁTICA DE INSTRUÇÃO SQL DE ATUALIZAÇÃO**
         - O **SqlDb** (mais em particular, **TSQLQuery** ) pode gerar automaticamente instruções
           de atualização para os dados que busca. Para isso, ele irá varrer a instrução
           propriedade **CustomBufDataset.SQL** e determinar a tabela principal na consulta:
           esta é a **primeira tabela** encontrada na parte **FROM** da instrução **SELECT** .
           - Exemplo:

             ```pascal

                SELECT * FROM ALUNOS

             ```

             - Alunos será a tabela selecionada para uso dos campos de [TField](https://www.freepascal.org/docs-html/fcl/db/tField.html).

         - Para operações **INSERT** e **UPDATE**, a propriedade instrução SQL gerada
           inserirá e atualizará todos os campos que possuim **pfInUpdate** em sua
           propriedade **TField.ProviderFlags**.
           - Os campos somente leitura não serão adicionados à instrução SQL.
           - Os campos que são NULL não serão adicionados a uma consulta de inserção, o que significa
             que o servidor de banco de dados inserirá o que estiver na cláusula DEFAULT da definição
             de campo correspondente.

         - O campos de chave primária
           - Ao atualizar registros, **TSQLQuery** precisa saber quais campos compõem a
             chave primária que pode ser usada para atualizar o registro e quais campos
             devem ser atualizados: com base nessas informações, ele constrói os comandos
             **SQL UPDATE, INSERT ou DELETE**.

           - A construção da instrução **SQL** é controlada pela propriedade **UsePrimaryKeyAsKey**
             e pelas propriedades **ProviderFlags**.

           - A propriedade TField.ProviderFlag é um conjunto de 6 sinalizadores:
             - **pfInUpdate** : As alterações no campo devem ser propagadas para o banco de dados..

             - **pfInWhere** : O campo deve ser usado na cláusula WHERE de uma instrução de
                               atualização no caso de upWhereChanged.

             - **pfInKey** : Campo é um campo chave e usado na cláusula WHERE de uma instrução de atualização.

             - **pfHidden**          : O valor deste campo deve ser atualizado após a inserção.
             - **pfRefreshOnInsert** : O valor deste campo deve ser atualizado após a inserção.

             - **pfRefreshOnUpdate** : O valor deste campo deve ser atualizado após a atualização.



       - **REFERẼNCIAS**
         - [TSQLQuery Introdução](https://wiki.freepascal.org/Working_With_TSQLQuery#General)
         - [TSQLQuery exemplos](https://wiki.freepascal.org/TSQLQuery)
         - https://www.freepascal.org/docs-html/fcl/sqldb/tsqlquery.html
         - [Trabalhando com TSQLQuery ](https://wiki.freepascal.org/Working_With_TSQLQuery);
         - [updatesqls.html](https://www.freepascal.org/docs-html/fcl/sqldb/updatesqls.html);


    }
    public  Function SetSqlCustomBufDataset:Boolean;Virtual;


    {: O método **@name** é usado para criar os campos de **CustomBufDataset**}
    public  Procedure CreateCustomBufDataset_FieldDefs;override;


    {: O método **@name** retorna uma lista de **PSItem** (Lista de strings) com o modelo
       usado para criar a tela.

       - **NOTA**
         - O Evento onGetTemplate só é iniciado em tempo de execução, por
           isso o formulário não pode ser criado em tempo de desenho do aplicativo.
         - Caso o evento onGetTemplate seja nil, então não posso ativar a tela.
         - Esse método pode ser anulado, caso se queira ignorar o evento onGetTemplate
           e definir o Template em uma método pai herdado desta classe.
    }
    public  function GetTemplate(aNext: PSItem) : PSItem;overload;override;

    {: O método **@name** ler o buffer dos campos dos arquivos associados a classe
       **TUiDmxScroller_sql**  para o buffer dos campos da classe **TUiDmxScroller**}
    public  function GetBuffers:Boolean;Override;

    {: O método **@name** grava o buffer dos campos da classe **TUiDmxScroller_sql** para
       o buffer dos campos dos arquivos associados a classe **TUiDmxScroller_sql**}
    public  function PutBuffers:Boolean; override;

    public  procedure SetActiveLCL(aActive: Boolean);override;

    {: O método **@name** seleciona o registro para adição de um novo registro
       - NOTA
         - Está gerando exceção.?????
    }
    public Procedure DoOnNewRecord;Override;

    {: O método **@name** adicione o registro editado no banco de dados.
       = **OBSERVAÇÂO**
         - O método **@name** só funciona se o registro atender as seguintes condições:
           - appending =true;
           - Mb_St_Insert habilidado
           - CustomBufDataset <> nil
           - CustomBufDataset.Active = true;

       - **REFERÊNCIA**
         - [tsqlquery.options](https://www.freepascal.org/docs-html/fcl/sqldb/tsqlquery.options.html)
    }
    public Function DoAddRec:Boolean;override;

  End;

Implementation

{: O método **@name** retorna ch e s se s<>''}
function TUiDmxScroller_sql.ValidStr(ch, s: AnsiString): AnsiString;
begin
  if  s = ''
  then Result := ''
  else Result := ch+' '+s;
end;

procedure TUiDmxScroller_sql.SetDataBase;
Begin
  if not (DataSource.DataSet.State in [dsInactive])
  then raise TException.Create(Self,'SetDataBase',ParametroInvalido);

  if (DataSource.DataSet is TBufDataset)
  then CustomBufDataset := (DataSource.DataSet as TBufDataset) //Não conectado a banco de dados sql.
  else if (DataSource.DataSet is TSQLQuery)
       then begin
              if (tableName <> '')
              then begin
                     CustomBufDataset                              := (DataSource.DataSet as TSQLQuery);
                     if not Assigned((DataSource.DataSet as TSQLQuery).DataBase)
                     then (DataSource.DataSet as TSQLQuery).DataBase    := Mi_ui_custom_application.SQLConnector;

                     if not Assigned((DataSource.DataSet as TSQLQuery).SQLTransaction)
                     then (DataSource.DataSet as TSQLQuery).SQLTransaction := Mi_ui_custom_application.SQLTransaction;
                   End
              else CustomBufDataset := nil;
            End
       else CustomBufDataset := nil;
End;

function TUiDmxScroller_sql.SetSqlCustomBufDataset: Boolean;
Begin
  if (CustomBufDataset is TSQLQuery)
  Then begin
         if not (CustomBufDataset as TSQLQuery).active
         then begin
                if (trim((CustomBufDataset as TSQLQuery).SQL.Text) = '')
                    and
                (trim(TableName) <>'')
                then begin
                       (CustomBufDataset as TSQLQuery).active := false;
                       (CustomBufDataset as TSQLQuery).SQL.Text := 'SELECT * FROM '+TableName;
                       (CustomBufDataset as TSQLQuery).open;
                     end
                else Result := false;
              end
         else Result := true;
       end
  else Result := false;
End;

constructor TUiDmxScroller_sql.Create(aOwner: TComponent);
Begin
  Inherited Create ( aOwner ) ;
End;


function TUiDmxScroller_sql.GetkeysPrimaryComposite(I : Integer):AnsiString;
  Var
    P    : PDmxFieldRec;

BEGIN
 result := '';
 p := Fields[i];
 with P^ do
 begin
   //Adicona a restrição de chave primária não incremental com a instrução alter table;
   if (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
       and (not flagPrimaryKey_AutoIncrement)
       and (keysPrimaryKeyComposite<>'')
   then begin
          result := keysPrimaryKeyComposite;

          //Ao torna vazio a lista, evita que essa restrição seja adicionada novamente.
          keysPrimaryKeyComposite := '';
        End;
 End;
END;

{: A função **@name** adiciona chave primária composta ou não na tabela
}
function TUiDmxScroller_sql.GetKeysPrimary:AnsiString;
  Var
    i : Integer;
    s : AnsiString;
begin
  result := '';
  { Adiciona as chaves primárias compostas ou não}
  if (not flagPrimaryKey_AutoIncrement) and (keysPrimaryKeyComposite<>'')
  then begin
         for i := 0 to Fields.Count -1 do
         begin
           s := GetkeysPrimaryComposite(i);
           if s <> ''
           then begin
                  if result <> ''
                  Then Result := result +','+ S
                  else Result :=  S;
               end;

           if keysPrimaryKeyComposite = ''
           then break;
         end;
       end;

  if result <> ''
  Then begin
         result := Format(strSql^.PrimaryKeyComposite,[result]);
         (CustomBufDataset as TSQLQuery).UsePrimaryKeyAsKey := true
       end
  else (CustomBufDataset as TSQLQuery).UsePrimaryKeyAsKey := false;


//    case Mi_ui_Custom_Application.ConnectorType of
//      PostgresSQL : begin
//                     result := Format(strSql^.PrimaryKeyComposite,[s]);
//                    end;
//      SqLite3     : begin
////                      result := Format(strSql^.Unique,[s]);
//                      result := Format(strSql^.PrimaryKeyComposite,[s]);
//                    end;
//      else raise TException.Create(ParametroInvalido);
//    end;

end;


{: A função **@name** cria a tabela se a mesma não existir
}
function TUiDmxScroller_sql.CreateTable: Boolean;

  function GetColunas:AnsiString;
    Var
      P    : PDmxFieldRec;

    {: A função **@name** adiciona campos na tabela se o mesmo não existir;
    }
    function GetColuna(I : Integer):AnsiString;
    begin
      p := Fields[i];
      with P^ do
      begin
        if (TypeCode in CTypeString)
        then begin
               if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
               Then result  := Format(StrSQL.CreateTable_AddColString,[FieldName,StrSQL.Ansi_String,FieldSize,StrSQL.Not_null])
               else result  := Format(StrSQL.CreateTable_AddColString,[FieldName,StrSQL.Ansi_String,FieldSize,'']);
             End
        else if (TypeCode in CTypeAnsiChar)
             then Begin
                    if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                    Then result := Format(StrSQL.CreateTable_AddColString,[FieldName,StrSQL.Array_char,FieldSize,StrSQL.Not_null])
                    else result := Format(StrSQL.CreateTable_AddColString,[FieldName,StrSQL.Array_char,FieldSize,'']);
                  End
             else if TypeCode in CTypeInteger
                  then begin
                         if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                         then begin
                                if flagPrimaryKey_AutoIncrement
                                then result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.Longint_PrimaryKey_AutoIncrement])
                                else begin
                                       result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,'int',StrSQL.Not_null]);
                                     end;
                              end
                         else begin
                                case TypeCode of
                                  fldBYTE     : BEGIN
                                                  if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                                                  Then result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.Byte])+StrSQL.Not_null
                                                  else result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.Byte]);
                                                END;
                                  fldSmallInt : BEGIN
                                                  if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                                                  Then result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.SmallInt])+StrSQL.Not_null
                                                  else result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.SmallInt]);
                                                END;
                                  fldLONGINT  : BEGIN
                                                  if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                                                  Then result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.LongInt])+StrSQL.Not_null
                                                  else result := Format(StrSQL.CreateTable_AddColNumber,[FieldName,StrSQL.LongInt]);
                                                END;
                                end;
                              end;
                      end
                  else ;//falta muitos tipos
      End;
    End;

   Var
     i : Integer;
     s : AnsiString;
  begin
    result := '';
    //Adiciona os campo da tabela e chave primária autoincremental
    for i := 0 to Fields.Count -1 do
    begin
      s := GetColuna(i);
      if i < Fields.Count -1
      then Result := Result + s +','
      else Result := Result + s;
    end;
  end;

  function GetKeyForeigns:AnsiString;
  begin
     Result := '';
  end;

  Var
    wSQL,s :  String;
begin
  try //Except
    try
      wSQL := (CustomBufDataset as TSQLQuery).SQL.text;

      Mi_ui_custom_application.SQLTransaction.Commit;
      Mi_ui_custom_application.SQLTransaction.StartTransaction;

      with StrSQL^ do
      begin
       s := Format(CreateTable ,[TableName,GetColunas, ValidStr(',',GetKeysPrimary),ValidStr(',',GetKeyForeigns) ]);
       (CustomBufDataset as TSQLQuery).SQL.text := s;
      end;

      LogError((CustomBufDataset as TSQLQuery).SQL.text);

      (CustomBufDataset as TSQLQuery).Prepare ;
      (CustomBufDataset as TSQLQuery).ExecSQL;

      Mi_ui_custom_application.SQLTransaction.Commit;

      Result := true;

    finally
      (CustomBufDataset as TSQLQuery).SQL.text := wSQL;
    end;

  Except;
     Result := false;
     Mi_ui_custom_application.SQLTransaction.Rollback;
  End;

End;

function TUiDmxScroller_sql.AlterTable: Boolean;
  Var
    wSQL,s :  String;
    P    : PDmxFieldRec;

  {: A função **@name** adiciona campos na tabela se o mesmo não existir;
  }
  function SQL_AddColunas(I : Integer):Boolean;

  begin
    try
      Mi_ui_custom_application.SQLTransaction.Commit;
      Mi_ui_custom_application.SQLTransaction.StartTransaction;

      p := Fields[i];
      with P^ do
      begin
        if (TypeCode in CTypeString)
        then begin
               if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
               Then s  := Format(StrSQL.AlterTable_AddColString,[TableName,FieldName,StrSQL.Ansi_String,FieldSize,StrSQL.Not_null])+';'
               else s  := Format(StrSQL.AlterTable_AddColString,[TableName,FieldName,StrSQL.Ansi_String,FieldSize,''])+';'
             End
        else if (TypeCode in CTypeAnsiChar)
             then Begin
                    if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                    Then s := Format(StrSQL.AlterTable_AddColString,[TableName,FieldName,StrSQL.Array_char,FieldSize,StrSQL.Not_null])+';'
                    else s := Format(StrSQL.AlterTable_AddColString,[TableName,FieldName,StrSQL.Array_char,FieldSize,''])+';';
                  End
             else if TypeCode in CTypeInteger
                  then begin
                         if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                         then begin
                                if flagPrimaryKey_AutoIncrement
                                then s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.Longint_PrimaryKey_AutoIncrement])+';'
                                else begin
                                       s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,'int',StrSQL.Not_null])+';'
                                     end;
                              end
                         else begin
                                case TypeCode of
                                  fldBYTE     : BEGIN
                                                  if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                                                  Then s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.Byte])+StrSQL.Not_null+';'
                                                  else s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.Byte])+';';
                                                END;
                                  fldSmallInt : BEGIN
                                                  if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                                                  Then s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.SmallInt])+StrSQL.Not_null+';'
                                                  else s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.SmallInt])+';';
                                                END;
                                  fldLONGINT  : BEGIN
                                                  if  (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
                                                  Then s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.LongInt])+StrSQL.Not_null+';'
                                                  else s := Format(StrSQL. AlterTable_AddColNumber,[TableName,FieldName,StrSQL.LongInt])+';';
                                                END;
                                end;
                              end;
                      end
                  else ;//falta muitos tipos
      End;

      (CustomBufDataset as TSQLQuery).SQL.text := s;
      (CustomBufDataset as TSQLQuery).Prepare;
      (CustomBufDataset as TSQLQuery).ExecSQL;
      Mi_ui_custom_application.SQLTransaction.Commit;

      Result := true;

    Except;
       Result := false;
       Mi_ui_custom_application.SQLTransaction.Rollback;
    End;

  End;

  {: A função **@name** adiciona chave primária composta ou não na tabela
  }
  function SQL_AddkeysPrimaryKeyComposite(I : Integer):Boolean;
  BEGIN
    try
      Mi_ui_custom_application.SQLTransaction.Commit;
      Mi_ui_custom_application.SQLTransaction.StartTransaction;

      p := Fields[i];
      with P^ do
      begin
        //Adicona a restrição de chave primária não incremental com a instrução alter table;
        if (TMiProviderFlag.pfInKeyPrimary in ProviderFlags)
            and (not flagPrimaryKey_AutoIncrement)
            and (keysPrimaryKeyComposite<>'')
        then begin
               (CustomBufDataset as TSQLQuery).SQL.text := Format(StrSQL.PrimaryKeyCompositeAlterTable,[TableName,TableName,keysPrimaryKeyComposite] )+' ;';

               //Ao torna vazio a lista, evita que essa restrição seja adicionada novamente.
               keysPrimaryKeyComposite := '';
             End;
      End;

      Mi_ui_custom_application.SQLTransaction.Commit;

      Result := true;

    Except;
       Result := false;
       Mi_ui_custom_application.SQLTransaction.Rollback;
    End;

  END;

  {: Adiciona chave estrangeira}
  function SQL_AddKeyForeigns(I : Integer):Boolean;
    Var
      TablePai : AnsiString;
  begin
    p := Fields[i];
    with P^ do
    if KeyForeign<>'' Then
    begin
      try
        Mi_ui_custom_application.SQLTransaction.Commit;
        Mi_ui_custom_application.SQLTransaction.StartTransaction;

          // ForeignKey : 'ALTER TABLE %s ADD CONSTRAINT fk_%s FOREIGN KEY (%s) REFERENCES %s(%s)';';
          TablePai := copy(KeyForeign,1,pos('.',KeyForeign)-1);
          system.Delete(KeyForeign,1,pos('.',KeyForeign));

          case P^.ForeignKey of
            Fk_No_Action :
              begin
                (CustomBufDataset as TSQLQuery).SQL.text :=
                Format(StrSQL.ForeignKey,[TableName,TaBleName,KeyForeign,TablePai,KeyForeign,StrSQL.ForeignKey_NoAction] )+' ;';
              End;

            Fk_Restrict :
              begin
                (CustomBufDataset as TSQLQuery).SQL.text :=
                Format(StrSQL.ForeignKey,[TableName,TaBleName,KeyForeign,TablePai,KeyForeign,StrSQL.ForeignKey_Restrict] )+' ;';
              End;
             Fk_Cascade :
              begin
                (CustomBufDataset as TSQLQuery).SQL.text :=
                Format(StrSQL.ForeignKey,[TableName,TaBleName,KeyForeign,TablePai,KeyForeign,StrSQL.ForeignKey_Cascade] )+' ;';
              End;
             Fk_Set_Null :
               begin
                 (CustomBufDataset as TSQLQuery).SQL.text :=
                 Format(StrSQL.ForeignKey,[TableName,TaBleName,KeyForeign,TablePai,KeyForeign,StrSQL.ForeignKey_SetNull] )+' ;';
               End;
             Fk_Set_Default :
               begin
                 (CustomBufDataset as TSQLQuery).SQL.text :=
                 Format(StrSQL.ForeignKey,[TableName,TaBleName,KeyForeign,TablePai,KeyForeign,StrSQL.ForeignKey_SetDefault] )+' ;';
               End;

          End;

        (CustomBufDataset as TSQLQuery).Prepare;
        (CustomBufDataset as TSQLQuery).ExecSQL;
        Mi_ui_custom_application.SQLTransaction.Commit;

        Result := true;

      Except;
         Result := false;
         Mi_ui_custom_application.SQLTransaction.Rollback;
      End;
    End
    else Result := False;

  End;

  var
    i     : integer;

Begin
  Result := false;
  if (tableName <> '')
     and Assigned(CustomBufDataset)
     and Assigned((CustomBufDataset as TSQLQuery).DataBase)
     and Assigned(Mi_ui_custom_application.SQLConnector)
     and Assigned(Mi_ui_custom_application.SQLTransaction)
  then begin
         if not OkAlterTableSQL
         then begin
                result := true;
                exit;
              End;
         try
           //O_gerente_de_transacoes_esta_inativo

           wSql := (CustomBufDataset as TSQLQuery).SQL.text;

           if (CustomBufDataset as TSQLQuery).DataBase.Connected and CreateTable
           then Begin
                  //Adiciona os campo da tabela e chave primária autoincremental
                  for i := 0 to Fields.Count -1 do
                  begin
                    SQL_AddColunas(i);
                  end;

                  //{ Adiciona as chaves primárias compostas}
                  //if (not flagPrimaryKey_AutoIncrement) and (keysPrimaryKeyComposite<>'')
                  //then for i := 0 to Fields.Count -1 do
                  //     begin
                  //       SQL_AddkeysPrimaryKeyComposite(i);
                  //       if keysPrimaryKeyComposite = ''
                  //       then break;
                  //     end;

                  { Adiciona as restrições de chaves estrangeiras}
                  for i := 0 to Fields.Count -1 do
                  begin
                    SQL_AddKeyForeigns(i);
                  end;

                End
           else Result := false;

         Finally
           (CustomBufDataset as TSQLQuery).SQL.text := wSQL;
         End;

       End;
End;

procedure TUiDmxScroller_sql.CreateCustomBufDataset_FieldDefs;

   procedure SetAtributosDosFields;
      Var
        F : TField;
        i : Integer;

   begin
     if Assigned(CustomBufDataset) and (CustomBufDataset.State in [dsInactive])
     Then Begin
             for i := 0 to Fields.Count-1 do
             begin
                SetCurrentField(Fields[i]);

                with CurrentField^ do
                begin
                 {$REGION 'Atualizar a propriedade ProviderFlags baseado tipo de acesso' }
                   f := CustomBufDataset.Fields[i];
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
  if Assigned(CustomBufDataset)
     and (CustomBufDataset.State in [dsInactive])
  then begin
//          CustomBufDataset.DisableControls;
          CustomBufDataset.Clear;
          for i := 0 to Fields.Count-1 do
          begin
            SetCurrentField(Fields[i]);

            with CurrentField^ do
            begin
              if (Fieldnum<>0) and (FieldName= '')
              then FieldName := 'Field'+IntToStr(Fieldnum);

              if TypeCode in CTypeString then
              begin
                CustomBufDataset.FieldDefs.Add(FieldName,ftString,FieldSize);
              end
              else
              if CurrentField^.TypeCode in CTypeAnsiChar then
              begin
                CustomBufDataset.FieldDefs.Add(FieldName,ftFixedChar,FieldSize);
              end
              else
              if TypeCode in CTypeInteger then
              begin
                CustomBufDataset.FieldDefs.Add(FieldName,ftInteger);
              end
              else
              if TypeCode in CTypeReal then
              begin
                CustomBufDataset.FieldDefs.Add(FieldName,ftFloat);
              end
              else
              if TypeCode in CTypeHour then
              begin
                CustomBufDataset.FieldDefs.Add(FieldName,ftTime,FieldSize);
              end
              else
              if TypeCode in CTypeDate then
              begin
                CustomBufDataset.FieldDefs.Add(FieldName,ftDate);
              end
              else
              if TypeCode in CTypeBlob then
              begin
                if TypeCode = FldMemo
                Then CustomBufDataset.FieldDefs.Add(FieldName,ftMemo) //Binary text data (no size)
                else CustomBufDataset.FieldDefs.Add(FieldName,ftBlob);// Binary data value (no type, no size)
              end;
            end;

          end;

          if CustomBufDataset is TBufDataset
          then begin //Cria tabela em memória.
                 CustomBufDataset.CreateDataset;
               End
          else if SetSqlCustomBufDataset
               Then begin
                      if CreateTable
                      then begin
                             CustomBufDataset.CreateDataset;
                             SetAtributosDosFields;
                           End
                      else CustomBufDataset := nil;
                    end
               else CustomBufDataset := nil;
  End;
End;

function TUiDmxScroller_sql.GetTemplate(aNext: PSItem): PSItem;
begin
  if Assigned(onGetTemplate)
  then begin
         if Assigned(DataSource)
            and Assigned(DataSource.DataSet)
         then begin
                SetDataBase;
              end
         else CustomBufDataset := nil;

         //Executa o evento definido em tempo de desenho.
         result := onGetTemplate(aNext)

        End
  else result := aNext;
end;

function TUiDmxScroller_sql.GetBuffers: Boolean;
  Var
    wCurrentField : pDmxFieldRec;
    S : String;


  Var
    i : Integer;

begin
  if getState(Mb_St_Edit or Mb_St_Insert)
     and Assigned(CustomBufDataset)
     and CustomBufDataset.Active
  then begin
         Try
           wCurrentField := CurrentField;

           if not (CustomBufDataset.State in [dsEdit,dsInsert])
           then begin
                   //if CustomBufDataset is TSQLQuery
                   //then (CustomBufDataset as TSQLQuery).Edit
                   //else
                  CustomBufDataset.Edit;
                end;

           for i := 0 to Fields.Count-1 do
           begin
             SetCurrentField(Fields[i]);
             s := CustomBufDataset.Fields[i].AsString;
             if CurrentField.IsNumber
             then begin
                    //Incluir máscara
                    if pos(DecPt ,s)<>0
                    then begin
                           s := Change_AnsiChar(s,DecPt,showDecPt);
                         end;
                 end;
             CurrentField.AsString:= s;
           end;
           result := true;
         Finally
           SetCurrentField(wCurrentField);
         end;
      end;
  result := inherited GetBuffers;
end;

function TUiDmxScroller_sql.PutBuffers: Boolean;
  var
    S             : AnsiString;
    wCurrentField : pDmxFieldRec;
    wReadOnly : Boolean;

  Procedure  Put(i:Integer);
  begin
    s := CurrentField.AsString;
    if CurrentField.IsNumber
    then begin
           //Excluir máscara
           s := DeleteMask(S,['0'..'9','-','+',showDecPt]);
           if pos(showDecPt ,s)<>0
           then begin
                  s := Change_AnsiChar(s,showDecPt,DecPt);
                end;
        end;

    wReadOnly := CustomBufDataset.Fields[i].ReadOnly;
    CustomBufDataset.Fields[i].ReadOnly := false;
    CustomBufDataset.Fields[i].AsString := s;
    CustomBufDataset.Fields[i].ReadOnly := wReadOnly;
  end;

Var
  i  : Integer;

begin
  result := false;
  if getState(Mb_St_Edit or Mb_St_Insert)
     and Assigned(CustomBufDataset)
     and CustomBufDataset.Active
  then Try
         wCurrentField := CurrentField;
         if not (CustomBufDataset.State in [dsEdit,dsInsert])
         then CustomBufDataset.Edit;

         for i := 0 to Fields.Count-1 do
         begin
           SetCurrentField(Fields[i]);
           put(i);
         end;

         result := true;
       Finally
         SetCurrentField(wCurrentField);
       end;
end;

procedure TUiDmxScroller_sql.SetActiveLCL(aActive: Boolean);
Begin
  Inherited SetActiveLCL ( aActive ) ;
  if active then
  begin
    if Assigned(CustomBufDataset) and (CustomBufDataset is TSQLQuery)
    then begin
           (CustomBufDataset as TSQLQuery).UpdateMode:= upWhereAll ;
         End;

    DoOnNewRecord;
    if Assigned(onEnter)
    then begin
           OnEnter(Self);
           GetBuffers;
         End;
  End;

End;

procedure TUiDmxScroller_sql.DoOnNewRecord;
begin
  inherited DoOnNewRecord;

  if GetState(Mb_St_Insert) then
   if appending then
     if Assigned(CustomBufDataset)
     then begin
            if CustomBufDataset.Active
               and (not CustomBufDataset.ReadOnly)
            then begin
                   CustomBufDataset.append;
                   // Transfere os dados default de Self para CustomBufDataset)
                   PutBuffers;
                 End
            else Begin
                   SetState(Mb_St_Insert,false);
                   appending := false;
                 End;
               ShowControlState;
       //      Refresh;
          End;
End;

function TUiDmxScroller_sql.DoAddRec: Boolean;

begin
  if GetState(Mb_St_Insert) and appending
  then begin
         try
           if Assigned(CustomBufDataset) and (CustomBufDataset is TSQLQuery)
           then begin
                  if CustomBufDataset.State in [dsInsert]
                  then begin
                         if (CustomBufDataset as TSQLQuery).SQLTransaction.Active
                         then Begin

                                if PutBuffers
                                then begin
                                       (CustomBufDataset as TSQLQuery).Post;
//                                       (CustomBufDataset as TSQLQuery).ApplyUpdates;
//                                       (CustomBufDataset as TSQLQuery).SQLTransaction.Commit;
                                     end
                                else Raise TException.Create(Self,'DoAddRec',TableName,'','O Método PutBuffer retornou false!. Não posso gravar.');
                             end;
                       End
                  else Raise TException.Create(Self,'DoAddRec',TableName,'','O estado do atual da classe não está no modo insert!');
                End
           else begin
                   if CustomBufDataset.State in [dsInsert]
                   then CustomBufDataset.Post
                   else Raise TException.Create(Self,'DoAddRec',TableName,'','O estado do atual da classe não está no modo insert!');
                End;

           result := true;

         Except;
           result := false;
         End;
       End
  else Begin
         result := false;
         Raise TException.Create(Self,
                                 'DoOnNewRecord',
                                  Attempt_to_insert_record_without_is_selected);

       end;

end;


End.

