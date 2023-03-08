unit mi_rtl_ui_consts;
{:< A unit **@name** implementa a classe TUiConsts.

    - **VERSÃO**
      - Alpha - 0.5.0.693

    - **CÓDIGO FONTE**:
      - @html(<a href="../units/mi_ui_consts.pas">mi_ui_consts.pas</a>)

    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br)

      - **2022-02-08 14:15**
        - Data em que essa unit foi criada. ✅

      - **2022-06-21**
        - Criar constante **CharAlfanumeric** para usar na rotinas que calculam a altura do caractere.

}

{$mode Delphi}

interface

uses
  Classes, SysUtils
  ,mi_rtl_Ui_Types  ;

  type
    { TUiConsts }
    {: A classe **@name** contém as contantes globais do pacote **mi.ui**}
    TUiConsts = class(TUiTypes )
      public Const CharAlfanumeric = 'abcdefghijlmnopgrstuvxaABCDEFGHIJLMNOPQRSTUVXZ0123456789';//🔍❌
         {Usado para controlar o estado do objeto }
      public const State  : int64 = 0;

      public Const QuitFieldAltomatic_Default : Boolean = false;

      //====================================================================================
      {$REGION '---> Mapa de Bits usados para teste de Bits de uma variável.'}
      //====================================================================================

        {
          Os Bits de variável são setados com operador OR ou + e testados
          com operador AND.

          Exemplo:
            variável State de uma tabela.
              Bit00 = 0 = Arquivo fechado; 1 = Arquivo aberto
              Bit01 = 0 = Compartilhado ;  1 = Nao compartilhado

          HABILITANDO BITS
            Setar State para fechado                     : State := Bit00;
            Setar State para Aberto                      : State := Bit00 + 1;
            Setar State aberto e para Nao compartilhado  : State := Bit00 + 1+
                                                                    Bit01 ;

          DESABILITANDO BITS
            Setar State para Fechado            : State := State - 1;
            Setar State para compartilhado      : State := State - Bit01;

          TESTANDO SE UM BITS ESTA ABILITADO
            Teste se a tabela esta compartilhada: (State And Bit01) <> 0
            Arquivo aberto e nao compartilhado:   (
                                                   (State And Bit00) <> 0 and
                                                   (State And Bit01) <> 0
                                                  )
          TESTANDO SE UM BIT ESTA DESABILITADO
            Testa se a tabela nao compartilhada  (State And Bit01) = 0
            Testa se o arquivo esta fechado:     (State And Bit00) = 0
        }
        Const
                               {64 BITS}
        {              HEX      FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210FEDCBA9876543210}
          Mb_Bit00        =  $0001; //0000000000000000000000000000000000000000000000000000000000000001  0
          Mb_Bit01        =  $0002; //0000000000000000000000000000000000000000000000000000000000000010  1
          Mb_Bit02        =  $0004; //0000000000000000000000000000000000000000000000000000000000000100  2
          Mb_Bit03        =  $0008; //0000000000000000000000000000000000000000000000000000000000001000  3
          Mb_Bit04        =  $0010; //0000000000000000000000000000000000000000000000000000000000010000  4
          Mb_Bit05        =  $0020; //0000000000000000000000000000000000000000000000000000000000100000  5
          Mb_Bit06        =  $0040; //0000000000000000000000000000000000000000000000000000000001000000  6
          Mb_Bit07        =  $0080; //0000000000000000000000000000000000000000000000000000000010000000  7
          Mb_Bit08        =  $0100; //0000000000000000000000000000000000000000000000000000000100000000  8
          Mb_Bit09        =  $0200; //0000000000000000000000000000000000000000000000000000001000000000  9
          Mb_Bit10        =  $0400; //0000000000000000000000000000000000000000000000000000010000000000  A
          Mb_Bit11        =  $0800; //0000000000000000000000000000000000000000000000000000100000000000  B
          Mb_Bit12        =  $1000; //0000000000000000000000000000000000000000000000000001000000000000  C
          Mb_Bit13        =  $2000; //0000000000000000000000000000000000000000000000000010000000000000  D
          Mb_Bit14        =  $4000; //0000000000000000000000000000000000000000000000000100000000000000  E
          Mb_Bit15        =  $8000; //0000000000000000000000000000000000000000000000001000000000000000  F
          Mb_Bit16        = $10000; //0000000000000000000000000000000000000000000000010000000000000000  0
          Mb_Bit17        = $20000; //0000000000000000000000000000000000000000000000100000000000000000  1
          Mb_Bit18        = $40000; //0000000000000000000000000000000000000000000001000000000000000000  2
          Mb_Bit19        = $80000; //0000000000000000000000000000000000000000000010000000000000000000  3
          Mb_Bit20        = $100000;//0000000000000000000000000000000000000000000100000000000000000000  4
          Mb_Bit21 =  $200000;      //0000000000000000000000000000000000000000001000000000000000000000  5
          Mb_Bit22 =  $400000;      //0000000000000000000000000000000000000000010000000000000000000000  6
          Mb_Bit23 =  $800000;      //0000000000000000000000000000000000000000100000000000000000000000  7
          Mb_Bit24 =  $1000000;     //0000000000000000000000000000000000000001000000000000000000000000  8
          Mb_Bit25 =  $2000000;     //0000000000000000000000000000000000000010000000000000000000000000  9
          Mb_Bit26 =  $4000000;     //0000000000000000000000000000000000000100000000000000000000000000  A
          Mb_Bit27 =  $8000000;     //0000000000000000000000000000000000001000000000000000000000000000  B
          Mb_Bit28 =  $10000000;    //0000000000000000000000000000000000010000000000000000000000000000  C
          Mb_Bit29 =  $20000000;    //0000000000000000000000000000000000100000000000000000000000000000  D
          Mb_Bit30 =  $40000000;    //0000000000000000000000000000000001000000000000000000000000000000  E
          Mb_Bit31 =  $80000000;    //0000000000000000000000000000000010000000000000000000000000000000  F
          Mb_Bit32 =  $100000000;   //0000000000000000000000000000000100000000000000000000000000000000  0
          Mb_Bit33 =  $200000000;   //0000000000000000000000000000001000000000000000000000000000000000  1
          Mb_Bit34 =  $400000000;   //0000000000000000000000000000010000000000000000000000000000000000  2
          Mb_Bit35 =  $800000000;   //0000000000000000000000000000100000000000000000000000000000000000  3
          Mb_Bit36 =  $1000000000;  //0000000000000000000000000001000000000000000000000000000000000000  4
          Mb_Bit37 =  $2000000000;  //0000000000000000000000000010000000000000000000000000000000000000  5
          Mb_Bit38 =  $4000000000;  //0000000000000000000000000100000000000000000000000000000000000000  6
          Mb_Bit39 =  $8000000000;  //0000000000000000000000001000000000000000000000000000000000000000  7

        //==========================================================================================================
        {$REGION ' ---> Tarefa: Falta definir os números hexadecimal dos binários abaixo'}
        //==========================================================================================================

          { TODO 4 -oMb_Bit40 -cMELHORIA DO CÓDIGO :
       2011/11/19. Criado em: 2011/11/19. Versão: 9.26.09.1546
         <ul>
           • Falta definir os números hexadecimal dos binários abaixo<BR>
         </ul>
          }
        //???? falta atualizar //???
          Mb_Bit40= $1000000; //0000000000000000000000010000000000000000000000000000000000000000  8
          Mb_Bit41= $2000000; //0000000000000000000000100000000000000000000000000000000000000000  9
          Mb_Bit42= $4000000; //0000000000000000000001000000000000000000000000000000000000000000  A
          Mb_Bit43= $8000000; //0000000000000000000010000000000000000000000000000000000000000000  B
          Mb_Bit44=$10000000; //0000000000000000000100000000000000000000000000000000000000000000  C
          Mb_Bit45=$20000000; //0000000000000000001000000000000000000000000000000000000000000000  D
          Mb_Bit46=$40000000; //0000000000000000010000000000000000000000000000000000000000000000  E
          Mb_Bit47=$80000000; //0000000000000000100000000000000000000000000000000000000000000000  F
          Mb_Bit48  = $10000; //0000000000000001000000000000000000000000000000000000000000000000  0
          Mb_Bit49  = $20000; //0000000000000010000000000000000000000000000000000000000000000000  1
          Mb_Bit50  = $40000; //0000000000000100000000000000000000000000000000000000000000000000  2
          Mb_Bit51  = $80000; //0000000000001000000000000000000000000000000000000000000000000000  3
          Mb_Bit52  =$100000; //0000000000010000000000000000000000000000000000000000000000000000  4
          Mb_Bit53  =$200000; //0000000000100000000000000000000000000000000000000000000000000000  5
          Mb_Bit54  =$400000; //0000000001000000000000000000000000000000000000000000000000000000  6
          Mb_Bit55  =$800000; //0000000010000000000000000000000000000000000000000000000000000000  7
          Mb_Bit56= $1000000; //0000000100000000000000000000000000000000000000000000000000000000  8
          Mb_Bit57= $2000000; //0000001000000000000000000000000000000000000000000000000000000000  9
          Mb_Bit58= $4000000; //0000010000000000000000000000000000000000000000000000000000000000  A
          Mb_Bit59= $8000000; //0000100000000000000000000000000000000000000000000000000000000000  B
          Mb_Bit60=$10000000; //0001000000000000000000000000000000000000000000000000000000000000  C
          Mb_Bit61=$20000000; //0010000000000000000000000000000000000000000000000000000000000000  D
          Mb_Bit62=$40000000; //0100000000000000000000000000000000000000000000000000000000000000  E
          Mb_Bit63=$80000000; //1000000000000000000000000000000000000000000000000000000000000000  F

        {$ENDREGION}
        //==========================================================================================================




      {$ENDREGION}
      //====================================================================================

        { Contantes usadas para setar o estado da visão
        }
        const
          sfVisible     = Mb_Bit01;
          sfCursorVis   = Mb_Bit02;
          sfCursorIns   = Mb_Bit03;
          sfShadow      = Mb_Bit04;
          sfActive      = Mb_Bit05;
          sfSelected    = Mb_Bit06;
          sfFocused     = Mb_Bit07;
          sfDragging    = Mb_Bit08;
          sfDisabled    = Mb_Bit09;
          sfModal       = Mb_Bit10;
          sfDefault     = Mb_Bit11;
          sfExposed     = Mb_Bit12;


      //====================================================================================================
      {$Region '//*** MB_St = Constantes usadas para indicar o estado (State) do objeto  . ***'}
      //====================================================================================================
          Const

          {Obs esta constante usam os bits 16 a 32 por que a visão usa os outros 0 a 15}

            {:0=nao Inicializado ou inicializado        ;
              1=Inicializado    }
            Mb_St_Creating          = Mb_Bit16;

            {: 0=Nao esta criando index;
               1=Esta criando o Index}
            Mb_St_Creating_Index    = Mb_Bit17;

            {: 0=Nao esta esta indexando;
               1=Esta indexando a tabela }
            Mb_St_Indexing           = Mb_Bit18;

            {: 0=Nao esta Criando o Relationship  ;
               1=Criando relacioamento}
            Mb_St_Creating_Relating = Mb_Bit19;

            {: 0=nao esta Relationship;
               1=Relationship}
            Mb_St_Related            = Mb_Bit20;

            {: 0=Tabela Fechada         ;
               1=Tabela aberta      }
            Mb_St_Active             = Mb_Bit21;

            {: 0=Nao esta sendo editada ;
               1=Esta sendo editada.}
            Mb_St_Edit               = Mb_Bit22;

            {:0=Nao esta esta travado para edicao;
              1=Esta esta travado para edicao  }
            Mb_St_Locked             = Mb_Bit23;

            {: 0= A tabela nao esta incluindo registro
               1= A tabela esta incluindo registro}
            Mb_St_AddRec             = Mb_Bit24;

            {: 0= A tabela nao esta atualizando
               1= A tabela esta atualizando }
            Mb_St_UpdateRec         = Mb_Bit25;

            {: 0= A tabela nao esta excluindo registro
               1= A tabela esta excluindo registro}
            Mb_St_DeleteRec          = Mb_Bit26;

            {: 0= A tabela nao esta listando
               1= A tabela esta sendo listada }
            Mb_St_Report             = Mb_Bit27;

            {: Este estado desconcidera os erros nos Relationships.
               - **NOTA**
                 - Só deve ser setado nas visões para mostrar os campos
                 - Relationados se existirem nas tabelas relacionadas.

               - 0= A tabela nao esta sendo sincronizada
               - 1= A tabela esta sendo sincronizada }
            Mb_St_Synchronizing      = Mb_Bit28;

            {: Mb_St_non_critic_if_active_commands  = Não critica se comandos de edição da tabela estão ativos.
             - **Objetivo:**
               - Habilitar ou não as criticas vinculadas ao estado dos comandos de atualização da tabela.

             - **Exemplo:**
                 Para cancelar Nota Fiscal o botão de gravar fica desabilitado e a visão da nota fiscal fica travada,
                 para que o usuário não altere manualmente a nota na opção de cancelamento de notas fiscais.

                 O estado de Mb_St_Active_Command = 1 para que o programa possar cancelar a nota mesmo
                 que o comando de gravação esteja desabilitado.


              - 0 = Critica.     Obs: So atualizar a tabela se o comando de atualização estiver habilitado.
              - 1 = Não critica. Obs: Atualizar a tabela independente do estado comando. Ou melhor desconsiderar se comando esta habilitado ou não.
            }
            Mb_St_non_critic_if_active_commands     = Mb_Bit29;

            {: 0=Nao esta calculando registro ;
               1=Esta calculando registro.}
            Mb_OnCalcRecord                         = Mb_Bit30;

            {: 0=Nao esta destruindo ;
               1=Esta destruindo.}
            MB_Destroying                           = Mb_Bit31;

           {: 0=Nao esta criando Template;
              1=Esta criando o Template

              - **NOTA**
                - Após o Template ser criado o tipo de acesso dos campos invisíveis não devem ser trocados.
                - Motivo: Quando um campo é invisível o designe para mostrar o mesmo é ignorado e caso o mesmo torne-se visível ele ficará sem identificação do que se trata.
            }
            Mb_St_Creating_Template                = Mb_Bit32;


           {: 0=Nao esta conectando o Banco de dados;
              1=Esta conectando banco de dados
              - **Motivo**:
                - A Class TArqParametros é criado automaticamente porém quando está desconectando o mesmo não deve ser criado.
           }
            Mb_St_DB_connecting                = Mb_Bit32;

           {: - 0 = Não está no modo insert.
              - 1 = Está nom modo insert. Este modo e ligado em DoOnNewrecord
           }
           Mb_St_Insert               = Mb_Bit33;

      {$EndRegion '//*** MB_St = Constantes usadas para indicar o estado (State) do objeto  . ***'}
      //====================================================================================================

      //====================================================================================================
      {$Region '//*** Constantes usadas para manipular os comando usando mapas de bits ***'}
        Const
          Mb_Zero        =  0;
          mbDefault      =  Mb_Bit02; { $0004}

        // *** Mb_Cm = Constantes usadas para generalizar os botões de edição das tabelas e botões de navegação.
        Const
          Mb_Cm_Inicial   =  02;
          Mb_Cm_Novo      =  Mb_Bit03; // Inicializar um novo registro para edição
          Mb_Cm_Edita     =  MB_Bit04; // Editar a linha corrente
          Mb_Cm_Alteracao =  Mb_Bit05; // Gravar as alterações
          Mb_Cm_Process   =  MB_Bit06; // Processar tabelas
          Mb_Cm_Exclusao  =  MB_Bit07; // Excluir
          Mb_Cm_Localiza  =  MB_Bit08; // Localizar
          Mb_Cm_FindRec   =  MB_Bit09; // Atualizar
          Mb_Cm_Visualizar=  MB_Bit10; // Visualizar
          Mb_Cm_Print     =  MB_Bit11; // Imprimir
          Mb_Cm_Ok        =  Mb_Bit12; // Ok
          Mb_Cm_Cancel    =  MB_Bit13; // Cancelar uma ação
          Mb_Cm_Sair      =  MB_Bit14; // Sair
          Mb_Cm_Bof       =  Mb_Bit15; // Vai para o inicio do arquivo
          Mb_Cm_Prev      =  Mb_Bit16; // Registro anterior
          Mb_Cm_Next      =  MB_Bit17; // Proximo registro
          Mb_Cm_Eof       =  MB_Bit18; // vai para o fin do arquivo
          mb_Cm_Locate    =  MB_Bit19; // Localizar
          mb_Cm_Find      =  MB_Bit20; // Localizar

          Mb_Cm_Bof_Prev_Next_Eof  = +Mb_Cm_Bof
                                     +Mb_Cm_Prev
                                     +Mb_Cm_Next
                                     +Mb_Cm_Eof
                                     +mb_Cm_Find;

          Mb_Cm_Commands  = +Mb_Cm_Novo
                            +Mb_Cm_Alteracao
                            +Mb_Cm_Exclusao
                            //+Mb_Cm_Process+
                            +Mb_Cm_Localiza
                            +Mb_Cm_Print
                            +Mb_Cm_Visualizar
                            +Mb_Cm_Sair
                            //+Mb_Cm_Cance
                            //+Mb_Cm_FindRec
                            ;

          Mb_Cm_Form_GetFiltro  =  Mb_Cm_Ok
                                  +Mb_Cm_Cancel;

      {$EndRegion '//*** Constantes usadas para manipular os comando usando mapas de bits ***'}
      //====================================================================================================
      // TButton flags

      public const bfNormal    = $00;
      public const bfDefault   = $01;
      public const bfLeftJust  = $02;
      public const bfBroadcast = $04;
      public const bfGrabFocus = $08;

      public
        {$REGION ' Constante StrSQL_postgres'}
          {: O registro **@name** contém os comandos usados no postgreSQL, porém o mesmo pode
             se modificado para outros bancos de dados ao selecionar o banco.

             - Esse registro deve ser modificado no local onde se seleciona o
               banco de dados a ser usado na aplicação.

             - **REFERÊNCIA**
               - [Tutorial completo sobre SQL](https://www.techonthenet.com/postgresql/tutorial_complete.php)
               - [PostgreSQL.DATATYPE-INT](https://www.postgresql.org/docs/11/datatype-numeric.html#DATATYPE-INT)
               - [postgresql-char-varchar-text](https://www.postgresqltutorial.com/postgresql-char-varchar-text/)
               - [alter_table](https://www.techonthenet.com/postgresql/tables/alter_table.php)
               - [Chaves Primárias compostas](https://www.techonthenet.com/postgresql/primary_keys.php#:~:text=In%20PostgreSQL%2C%20a%20primary%20key%20is%20created%20using%20either%20a,or%20drop%20a%20primary%20key.)
               - [Restrições SQL](https://www.w3schools.com/sql/sql_constraints.asp)
               - [PostgreSQL Foreign Key](https://www.postgresqltutorial.com/postgresql-foreign-key/)

               - [Criando visões SQL](https://www.techonthenet.com/postgresql/views.php)
               - [Restrição exclusiva](https://www.techonthenet.com/postgresql/unique.php)
               - [Criando índices](https://www.techonthenet.com/postgresql/indexes.php)
               - [Criar ou revogar privilégios](https://www.techonthenet.com/postgresql/grant_revoke.php)
               - [Criando usuário](https://www.techonthenet.com/postgresql/users/create_user.php)
               - [Alterando senha do usuário](https://www.techonthenet.com/postgresql/change_password.php)
               - [Trocar nome do usuário](https://www.techonthenet.com/postgresql/users/rename_user.php)
               - [Excluir usuários](https://www.techonthenet.com/postgresql/users/drop_user.php)
               - [Localizando Usuário](https://www.techonthenet.com/postgresql/questions/find_users.php)
               - [Encontrar usuário logado](https://www.techonthenet.com/postgresql/questions/find_users_logged_in.php)

          }

        const StrSQL_Postgres : TStrSQL = (
                strictt : '';
                create : ' CREATE ';
                Table  : ' TABLE ';
                If_not_exists : ' IF NOT EXISTS ';
                not_null      :  ' NOT NULL ';
                default   : ' DEFAULT ';   //Valor defaul para a coluna;

                {: O Template **@name** é usado para criar tabela sql

                   - **PARÂMETROS**
                     - %s1 = nome da tabela;
                     - %s2 = Lista de campos da tabela;
                     - %s3 = Restrinção de Chave primária
                     - %s4 = Restrinções de chaves estrangeiras
                }
                CreateTable : ' CREATE TABLE IF NOT EXISTS %s (%s %s %s ) ;';

                {: Template para um campo string no comando Create Table}
                CreateTable_AddColString : ' %s %s(%d) %s  ';

                {: Template para um campo numérico no comando Create Table}
                CreateTable_AddColNumber : '  %s %s %s ';


                {: ALTER TABLE table_name ADD column_name datatype_string FieldSize..
                   - [sql-altertable](https://www.postgresql.org/docs/11/sql-altertable.html)
                }
                AlterTable_AddColString : ' ALTER TABLE %s ADD IF NOT EXISTS %s %s(%d) %s ';

                {: ALTER TABLE table_name ADD column_name datatype
                   - [sql-altertable](https://www.postgresql.org/docs/11/sql-altertable.html)
                }
                AlterTable_AddColNumber : ' ALTER TABLE %s ADD IF NOT EXISTS %s %s ';

                select : ' SELECT ';
                From   : ' FROM ';
                PrimaryKey  : ' PRIMARY KEY ';

                //:< Chave primária composta usada em create Table
                PrimaryKeyComposite : ' PRIMARY KEY(%s) '; //Onde em key(%s) recebe uma lista de campos separado por vírgula. Ex: Estado,Cidade

                {: Chave primária composta usada em Alter Table
                   - A sintaxe para criar uma chave primária usando a instrução
                     ALTER TABLE no PostgreSQL é:

                     - ALTER TABLE table_name ADD CONSTRAINT [ constraint_name ] PRIMARY KEY (index_col1, index_col2, ... index_col_n)
                }
                PrimaryKeyCompositeAlterTable : 'ALTER TABLE %s ADD CONSTRAINT Pk_%s  PRIMARY KEY(%s)';

                Unique : 'UNIQUE(%s)'; //:< O parâmetro %s contém uma lista de campos existente na tabela.

                AutoIncrement : ' SERIAL ';
                Longint_PrimaryKey_AutoIncrement : ' SERIAL PRIMARY KEY ';
                byte     : ' BIGINT ';
                SmallInt : ' SMALLINT ';
                Longint  : ' Integer ';
                Real4    : ' Real ';
                Real8    : ' FLOAT ';
                Ansi_String : ' VARCHAR ';
                Array_Char  : ' CHAR ';
                memo        : ' TEXT ';

                {: A expressão **@name** é usado para definir restrição de chave estrangeira
                   - FK_%s = nome da restrição;
                   - KEY (%s) = Lista de chave estrangeira;
                   - REFERENCES %s = Nome da tabela pai;
                   - (%s) = Lista de chave estrangeira deve o mesmo nome ds campos da tabela pai.
                   - %s = O último campo pode ser ON DELETE OU ON UPDATE com as seguintes ações:
                     - SET NULL
                     - SET DEFAULT
                     - RESTRICT    //Restringir e exclusões em cascata são as duas opções mais comuns. RESTRICTimpede a exclusão de uma linha referenciada.
                     - NO ACTION   //Significa que se alguma linha de referência ainda existir quando a restrição for verificada, um erro será gerado; este é o comportamento padrão se você não especificar nada. (A diferença essencial entre essas duas opções é que NO ACTIONpermite que a verificação seja adiada até mais tarde na transação, enquanto RESTRICTnão permite.)
                     - CASCADE     //especifica que quando uma linha referenciada é excluída, a(s) linha(s) que a referencia(m) também deve(m) ser excluída(s) automaticamente.

                   - **REFERÊNCIA**
                     - [DDL-CONSTRAINTS-FK](https://www.postgresql.org/docs/11/ddl-constraints.html#DDL-CONSTRAINTS-FK)
                     - [Introdução à restrição de chave estrangeira do PostgreSQL](https://www.postgresqltutorial.com/postgresql-foreign-key/)
                }
                ForeignKey : 'ALTER TABLE %s ADD CONSTRAINT fk_%s FOREIGN KEY (%s) REFERENCES %s(%s) %s';

                ForeignKey_SetNull    : 'ON DELETE SET NULL ON UPDATE SET NULL';
                ForeignKey_SetDefault : 'ON DELETE SET DEFAULT ON UPDATE SET DEFAULT';
                ForeignKey_Restrict   : 'ON DELETE RESTRICT ON UPDATE RESTRICT';
                ForeignKey_NoAction   : 'ON DELETE NO ACTION ON UPDATE NO ACTION';
                ForeignKey_Cascade    : 'ON DELETE CASCADE ON UPDATE CASCADE';
          );
        {$ENDREGION}

        {$REGION ' Constante StrSQL_sqlite3'}

          {: A constante **@name** contém os comandos do banco de dados sqlite3

             - **REFERÊNCIA**
               - [www.sqlitetutorial.net/](https://www.sqlitetutorial.net/)
          }
          const StrSQL_sqlite3 : TStrSQL = (
            strictt : ' STRICT ';

            create : ' CREATE ';
            Table  : ' TABLE ';
            If_not_exists : ' IF NOT EXISTS ';

            not_null  :  ' NOT NULL ';  //SqLite3 não permite adicionar coluna com a clausula not null
            default   : ' DEFAULT ';   //Valor defaul para a coluna;

            {: O Template **@name** é usado para criar tabela sql

               - **PARÂMETROS**
                 - %s1 = nome da tabela;
                 - %s2 = Lista de campos da tabela;
                 - %s3 = Restrinção de Chave primária
                 - %s4 = Restrinções de chaves estrangeiras
            }
            CreateTable : ' CREATE TABLE IF NOT EXISTS %s (%s %s %s ) ;';

            {: Template para um campo string no comando Create Table}
            CreateTable_AddColString : ' %s %s(%d) %s  ';

            {: Template para um campo numérico no comando Create Table}
            CreateTable_AddColNumber : '  %s %s %s ';

            {: ALTER TABLE table_name ADD column_name datatype_string FieldSize..
               - [sql-altertable](https://www.postgresql.org/docs/11/sql-altertable.html)
            }
            AlterTable_AddColString : ' ALTER TABLE %s ADD %s %s(%d) %s ';


            {: ALTER TABLE table_name ADD column_name datatype
               - [sql-altertable](https://www.postgresql.org/docs/11/sql-altertable.html)
            }
            AlterTable_AddColNumber : ' ALTER TABLE %s ADD %s %s %s ';

            select : ' SELECT ';
            From   : ' FROM ';
            PrimaryKey  : ' PRIMARY KEY ';

            //:< Chave primária composta usada em create Table
            PrimaryKeyComposite : ' PRIMARY KEY(%s) '; //Onde em key(%s) recebe uma lista de campos separado por vírgula. Ex: Estado,Cidade


            {: Chave primária composta usada em Alter Table
               - A sintaxe para criar uma chave primária usando a instrução
                 ALTER TABLE no PostgreSQL é:

                 - ALTER TABLE table_name ADD CONSTRAINT [ constraint_name ] PRIMARY KEY (index_col1, index_col2, ... index_col_n)
            }
            PrimaryKeyCompositeAlterTable : 'ALTER TABLE %s ADD CONSTRAINT Pk_%s  PRIMARY KEY(%s)';

            Unique : 'UNIQUE(%s)'; //:< O parâmetro %s contém uma lista de campos existente na tabela.

            AutoIncrement : ' SERIAL ';
            Longint_PrimaryKey_AutoIncrement : ' SERIAL PRIMARY KEY ';
            byte     : ' Integer ';
            SmallInt : ' Integer ';
            Longint  : ' Integer ';
            Real4    : ' Real ';
            Real8    : ' Real ';
            Ansi_String : ' TEXT  ';
            Array_Char  : ' TEXT ';
            memo        : ' ANY ';

            {: A expressão **@name** é usado para definir restrição de chave estrangeira
               - FK_%s = nome da restrição;
               - KEY (%s) = Lista de chave estrangeira;
               - REFERENCES %s = Nome da tabela pai;
               - (%s) = Lista de chave estrangeira deve o mesmo nome ds campos da tabela pai.
               - %s = O último campo pode ser ON DELETE OU ON UPDATE com as seguintes ações:
                 - SET NULL
                 - SET DEFAULT
                 - RESTRICT    //Restringir e exclusões em cascata são as duas opções mais comuns. RESTRICTimpede a exclusão de uma linha referenciada.
                 - NO ACTION   //Significa que se alguma linha de referência ainda existir quando a restrição for verificada, um erro será gerado; este é o comportamento padrão se você não especificar nada. (A diferença essencial entre essas duas opções é que NO ACTIONpermite que a verificação seja adiada até mais tarde na transação, enquanto RESTRICTnão permite.)
                 - CASCADE     //especifica que quando uma linha referenciada é excluída, a(s) linha(s) que a referencia(m) também deve(m) ser excluída(s) automaticamente.

               - **REFERÊNCIA**
                 - [DDL-CONSTRAINTS-FK](https://www.postgresql.org/docs/11/ddl-constraints.html#DDL-CONSTRAINTS-FK)
                 - [Introdução à restrição de chave estrangeira do PostgreSQL](https://www.postgresqltutorial.com/postgresql-foreign-key/)
            }
            ForeignKey : 'ALTER TABLE %s ADD CONSTRAINT fk_%s FOREIGN KEY (%s) REFERENCES %s(%s) %s';

            ForeignKey_SetNull    : 'ON DELETE SET NULL ON UPDATE SET NULL';
            ForeignKey_SetDefault : 'ON DELETE SET DEFAULT ON UPDATE SET DEFAULT';
            ForeignKey_Restrict   : 'ON DELETE RESTRICT ON UPDATE RESTRICT';
            ForeignKey_NoAction   : 'ON DELETE NO ACTION ON UPDATE NO ACTION';
            ForeignKey_Cascade    : 'ON DELETE CASCADE ON UPDATE CASCADE';
            );
        {$ENDREGION}


//      const StrSQL : ^TStrSQL = @StrSQL_Postgres;
      const StrSQL : ^TStrSQL = @StrSQL_sqlite3;

      {: O atributo **@name** indica se os botões genéricos devem usar somente
         um icon ou um um texto.

         - **NOTA**
           - Usado em: TUiDmxScroller_Navigator.Create_RCommands_Navigator
      }
      const Ok_Navigator_por_extenco : Boolean = False;


      {: A constante **@name** é usado para criar tabela sql automaticamente caso seja true. }
      public const okCreateTableSQL : Boolean = true;
      public const okAlterTableSQL : Boolean = true;
    end;


implementation

initialization



end.

