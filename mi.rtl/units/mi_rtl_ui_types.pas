unit mi_rtl_ui_types;
{:< A unit **@name** implementa a classe TUiTypes.

  - **VERSÃO**
    - Alpha - 0.8.0

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi_ui_types.pas">mi_ui_types.pas</a>)


    - **HISTÓRICO**
      - Criado por: Paulo Sérgio da Silva Pacheco paulosspacheco@@yahoo.com.br) ✅

      - **2022-03-16**
        - **19:49**
          - Criar o tipo TStrSQL com objetivo de criar sql para qualquer banco
            de dados conhecido pelo sistema. ✅
}

  {$IFDEF FPC}
    {$MODE Delphi} {$H+}
  {$ENDIF}

interface

uses
  Classes, SysUtils,db
  ,mi.rtl.types
  ,mi.rtl.Consts
  ,mi.rtl.files
  ,mi.rtl.objects.consts.mi_msgbox
  ,mi.rtl.Objects.Methods
  ,mi.rtl.objects.Methods.dates
  ,mi.rtl.Objects.Methods.ParamExecucao.Application
  ,mi.rtl.Objects.Methods.Exception
  //,mi.rtl.Objects.Methods.Ui.Interfaces

  ,mi.rtl.Objectss  ;

  type
    {: A class **@name** concentra todos os tipo do pacote mi.ui.
    }
    TUiTypes = class(TObjectss)
      {: O tipo **@name** é usado quando se precisa de procedures anônimas sem parâmetros }
      public type TipoProc   = Procedure;
      {: O tipo **@name** é usado para acessar o dados do registro quando se sabe o tipo}
      public type PValue = ^TValue;
           TValue =
           Record
             case byte of
             1: (AsPointer  : Pointer);
             2: (asLongint  : Longint);
             3: (asPLongint : PLongint);
             4: (asWord     : Word);
             5: (asPWord    : PWord);
             6: (asSmallInt  : SmallInt);
             7: (asPSmallInt : PSmallInt);
             8: (asByte     : Byte);
             9: (asPByte    : PByte);
            10: (asAnsiChar     : AnsiChar   );
            11: (asPAnsiChar    : PAnsiChar   );
            12: (AsString  : tString   );
            13: (AsPString : PtString  );
            14: (AsStr255  : TStr255);{<Obs. para acessar a string referencia-se por InfoStr}
            15: (AsPStr255 : ^TStr255);
            16: (AsArrayAnsiChar512  : Array[1..512] of AnsiChar);
            17: (AsArrayByte     : Array[1..512] of Byte);
            18: (AsArraySmallInt  : Array[1..256] of SmallInt);
            19: (AsArrayLongint  : Array[1..128] of Longint);
            20: (AsArrayPointer  : Array[1..128] of Pointer);
            21: (AsArrayPAnsiChar    : Array[1..  2] of array[0..255] of AnsiChar);
            22: (AsReal          : Real);
            23: (AsPReal         : PReal);
            24: (AsDouble        : Double);
            25: (AsPDouble       : PDouble);
            26: (AsRealNum       : TRealNum);
            27: (AsPRealNum      : PRealNum);
            28: (AsExtended      : Extended);
            29: (AsPExtended     : PExtended);
            30: (asDate          : TypeData);
            31: (asPDate         : PTypeData);
            32: (asSHORTINT  : SHORTINT);
            33: (asPSHORTINT : PSHORTINT);

            34: (asCluster  : TCluster);
            35: (asPCluster : PCluster);

            36: (asBOOLEAN  : BOOLEAN);
            37: (asPBOOLEAN : PBOOLEAN);
            38: (asSmallWord : SmallWord);
           End;

      {$ifdef CPU32}
        public type DmxIDstr =  string[8+3];           {< contracted Template string }
      {$ENDIF}
      {$ifdef CPU64}
        public type DmxIDstr =  string[8+4+3];           {< contracted Template string }
      {$ENDIF}

      {: O tipo **@name** é usado por TViRect para indicar o sentido do cálculo do novo retângulo }
      public type TDirection = (North,   //:< Nort = Acima da origem
                                South,   //:< Sul = Abaixo da origem
                                West,    //:< oeste A esquerda da origem
                                East,    //:< Leste = A direita da origem
                                CenterX, //:< Centro de  X da origem
                                CenterY, //:< Centro de  Y da origem
                                CenterXY //:< Centro de  XY da origem
                                );

      {: O tipo **@name é usado para salvar o lado que gerou overflow }
      public type TOverflow =
                  Record
                    XA_Min, {:< Coordenada  X do contato superior esquerdo.  }
                    YA_Min, {:< Coordenada  Y do contato superior esquerdo.  }
                    XB_Max, {:< Coordenada  X do contato inferior direito.  }
                    YB_Max  {:< Coordenada  Y do contato inferior direito.  }
                    : Boolean;
                  end;

      {: O tipo **@name é usado é usado para calcular os retângulos vizinhos do retângulado atual}
      public Type PViRect    = ^TViRect;

        {: O objeto **@name** é usado para calcular as coordendas geógraficas semelhante ao java.

           - **EXEMPLO DE USO**
             -
        }

        {: O registro **@name** usado para calcular retângulo baseado em uma origem e seu visinho na direção de TDirection

           - **NOTA**
             - Exemplo de uso está na unit : mi.rtl.objects.methods.ui.Dmxscroller.test;
             - O Exemplo foi criado para executar modo console.
             - Para testar no modo console veja o projeto rtl/TestTviRect
        }
        TViRect  = record//Object(Trect)  //Retirei Object do turbo pascal porque o lazarus não depura.
          Public
             { A = Ponto inferior esquerdo do retângulo}
             A : TPoint;

             { A = Ponto superior direito do retângulo}
             B : TPoint;

          {: R_new.A deve ser maior ou igual R_New_Limit.A e R_new.B deve ser menor ou igual
             R_New_Limit.B}
          Public R_New_Limits : TRect;

          {: O quadro **@name** guarda o retângulo vizinho do novo retângulo a ser gerado}
          Public R_Neighbor  : TRect;

          {: O retângulo **@name** contém o novo retângulo calculado por GetRec}
          Public R_New       : TRect;

          Public Overflow       : Boolean; //:< Se alguma as coordenadas for negativa overflow=true
          Public ROverflow      : TOverflow; //:< Inform o lado que gerou overflow
          Public AddCol_overfow : Boolean; //:< True = Adiciona uma nova linha ao encontrar overflow.
          Public AddRow_overfow : Boolean; //:< True = Adiciona uma nova coluna ao encontrar overflow.

          {: A procedure **@name** inicia o ponto A e Ponto B com os parâmetros passado}
          Public PROCEDURE Assign (XA, YA, XB, YB: Integer);

          {: A procedure **@name** copia o retângulo passodo por R para os pontos A e B}
          Public PROCEDURE Copy ( R: TRect);

          {: A procedure **@name** inicia os limites da janela na qual os retângulo serão calculados}
          Public PROCEDURE AssignLimits(XA_Min, YA_Min, XB_Max, YB_Max: Integer);

          Public Procedure Adjust_if_not_valid(MinX,MinY:Int64; Var aRect: TRect);

          {: A função **@name** receber o retando em aR_Neighbor e retorna em aR_New um retângulo
             a direta ou a esquerda ou acima ou abaixo de aR_Neighbor.}
          Public Function GetRect_Relative(
                           /// Origem
                           aR_Neighbor : TRect;  {<Vizinho}

                           aPerc_point_A : Byte;
                           adirection_point_A:Tdirection;

                           aPerc_point_B : Byte;
                           adirection_point_B: Tdirection;

                           ///Destino
                           Var
                             aR_New : TRect {<Retorna o Ponto calculado}
                         ):Boolean;

          {: A função **@name** calcula um novo retângulo de largura aWidth e altura aHeight
             vizinho nas quatro direções da origem aR_Neighbor}
          Public Function GetRect_Absolute(aR_Neighbor : TRect;  //Vizinho = Origem
                                            aWidth,
                                            aHeight: Integer;
                                            adirection:Tdirection;
                                            Var aR_New : TRect //Retorna o Ponto calculado
                                          ):Boolean;Overload;

          Public Function GetRect_Absolute(//aR_Neighbor : TRect;  //Vizinho = Origem
                                            aWidth,
                                            aHeight: Integer;
                                            adirection:Tdirection;
                                            Var aR_New : TRect //Retorna o Ponto calculado
                                          ):Boolean;Overload;

           {: A função **@name** calcula um retângula a direita do corrente, se passar
              do limite direito adiciona uma nova linha.}
           Public Function GetRect_AddCol(//aR_Neighbor : TRect;  //Vizinho = Origem
                                          aWidth,
                                          aHeight: Integer;
                                          Var aR_New : TRect //:< Retorna o Ponto calculado
                                          ):Boolean;

           {: A função **@name** calcula um retângula a abaixo do corrente e se passar do limite
              Limit.B.Y adiciona uma nova Coluna.}
           Public Function GetRect_AddRow(//aR_Neighbor : TRect;  //Vizinho = Origem
                                          aWidth,
                                          aHeight: Integer;
                                          Var aR_New : TRect //:< Retorna o Ponto calculado
                                        ):Boolean;

           Public Procedure Set_Max_Ax_e_Max_BY(Max_X,Max_Y:Int64);

           {: O método **@name** move o retangulo para o pornto x,y}
           Public procedure MoveTo(X, Y: Integer);

           {: O método **@name** move o retangula para as direções passada por adirection}
           Public Procedure MoveTo_Direction(adirection : Tdirection;
                                             aOwner     : TRect {:< Retorna o Ponto calculado }
                                            ); Overload;

           {: A procedure **@name** ajusta o retângulo filho dentro do retângulo limites
              levando em consideracao as coordenadas geográficas.}
           Public Procedure MoveTo_Direction(adirection : Tdirection); Overload;

           {: A procedure **@name** retorna o ponto calculado }
           Public Procedure GetRect(Var aR_New : TRect);
          end;

        {: Usado por TDmxScroller_sql para criar consulta sql no banco de dados

           - **REFERÊNCIA**
             - [Ótimo exemplo de uso das contantes abaixo](https://www.devmedia.com.br/providerflags-no-delphi-atualizando-dados-de-uma-unica-tabela/26689)
        }
        type TMiProviderFlag = (pfInUpdate, {:< Usado por SqlDbConnector : As alterações no campo devem ser propagadas para o banco de dados..}
                                pfInWhere,{:< Usado por SqlDbConnector : O campo deve ser usado na cláusula WHERE de uma instrução de atualização no caso de upWhereChanged.}

                                pfInKey, {:< Usado por SqlDbConnector : Indica se o campo é parte da Chave Primária.
                                             - Campo é um campo chave e usado na cláusula WHERE de uma instrução de atualização.}

                                pfHidden,{: Usado por SqlDbConnector : Indica se o campo será oculto para os Clientes.}

                                pfRefreshOnInsert,{:< Usado por SqlDbConnector : O valor deste campo deve ser atualizado após a inserção.}
                                pfRefreshOnUpdate, {:< Usado por SqlDbConnector : O valor deste campo deve ser atualizado após a atualização.}
                                pfInKeyPrimary, {:< Usado por TDmxScroller_sql : Campo é um campo chave primária e usado na cláusula WHERE de uma instrução de atualização.}
                                pfInAutoIncrement{:< Usado por TDmxScroller_sql : Campo é um campo autoincremental e usado em uma instrução de atualização.}
                                );

        {: O tipo **@name** é usado pelo componente TDataSet para gerar instruções sql de acesso ao banco de dados.
           - **REFERÊNCIA**:
             - [providerflags atualizando dados de uma única tabela](https://www.devmedia.com.br/providerflags-no-delphi-atualizando-dados-de-uma-unica-tabela/26689)
        }
        type TMiProviderFlags = Set of TMiProviderFlag;

        //{: O tipo **@name** define os tipos de relacionamentos possíveis entre tabelas
        //
        //   - **REFERÊNCIA**:
        //     - [postgresql-foreign-key](https://www.postgresqltutorial.com/postgresql-foreign-key/)
        //     - [Introdução à restrição de chave estrangeira do PostgreSQL](https://www.postgresqltutorial.com/postgresql-foreign-key/)
        //}
        //type TForeignKey = (ForeignKeyUm_Um_true,   {:< UmParaUm - Impor_Integridade_Referencial=True
        //                                              - OnDelete e onUpDate ação cascade
        //                                            }
        //                    ForeignKeyUm_Um_false, {:< - UmParaUm - Searc Se Impor_Integridade_Referencial=False}
        //
        //                    ForeignKeyUm_N_true, {:< - UmParaN  - Impor_Integridade_Referencial=True}
        //                    ForeignKeyUm_N_false, {:< - UmParaN  - Impor_Integridade_Referencial=False }
        //
        //                    ForeignKeyN_Um_true, {:< - NParaUm, - Find  Se Impor_Integridade_Referencial=True}
        //                    ForeignKeyN_Um_false, {:< - NParaUm - Searc Se Impor_Integridade_Referencial=False}
        //
        //                    ForeignKeyN_N_true, {:< - NParaN  - Impor_Integridade_Referencial=True}
        //                    ForeignKeyN_N_false {:< - NParaN  - Impor_Integridade_Referencial=False}
        //                    );
        //

        {: O tipo **@name** é usado para criar integridade referêncial.

           - **REFERÊNCIA**
             - [sql-createtable](https://www.postgresql.org/docs/11/sql-createtable.html)
             - [postgresql-foreign-key](https://www.postgresqltutorial.com/postgresql-foreign-key/)
             - [Introdução à restrição de chave estrangeira do PostgreSQL](https://www.postgresqltutorial.com/postgresql-foreign-key/)


           - **OBSERVAÇÕES**
             - As ações de **@name** são combinadas com o comando On Delete e On Update.
               - Exemplo:
                 - Fk_action_No_Action = ON DELETE NO ACTION ON UPDATE NO ACTION
                 - Fk_action_Restrict = ON DELETE RESTRICT ON UPDATE RESTRICT
                 - Fk_Action_Cascade = ON DELETE CASCADE ON UPDATE CASCADE
                 - Fk_Action_Set_Null = ON DELETE SET NULL ON UPDATE SET NULL
                 - Fk_Action_Set_Default = ON DELETE SET DEFAULT ON UPDATE SET DEFAULT

             - Se as colunas referenciadas forem alteradas com frequência, pode ser aconselhável
               adicionar um índice às colunas de referência para que as ações referenciais
               associadas à restrição de chave estrangeira possam ser executadas com mais eficiência.
        }
        type TForeignKey =
              (Fk_No_Action,{:< Produz um erro indicando que a exclusão ou atualização criaria
                                       uma violação de restrição de chave estrangeira.
                                       Se a restrição for adiada, esse erro será produzido no
                                       momento da verificação da restrição se ainda existirem linhas de referência.
                                       Esta é a ação padrão.}

               Fk_Restrict,{:< Produz um erro indicando que a exclusão ou atualização criaria
                                      uma violação de restrição de chave estrangeira. Isso é o
                                      mesmo que, **NO ACTION** exceto que o cheque não é adiável.}

               Fk_Cascade, {:< Exclua todas as linhas que fazem referência à linha excluída
                                      ou atualize os valores das colunas de referência para os novos
                                      valores das colunas referenciadas, respectivamente.
                                  }

               Fk_Set_Null, {:<  Defina a(s) coluna(s) de referência como nula.}

               Fk_Set_Default {:< Defina a(s) coluna(s) de referência para seus valores
                                         padrão. (Deve haver uma linha na tabela referenciada que
                                         corresponda aos valores padrão, se eles não forem nulos,
                                         ou a operação falhará.}
              );


        Type
          PRCommand = ^TRCommand;
          TRCommand = Record
                         StrCommand : AnsiString;
                         Name     : AnsiString;
                         Param    : AnsiString;
                         KeyCode  : SmallWord;
                         HelpCtx_Hint : AnsiString;
                         AHelpCtx     : SmallWord;
                         State        : Byte;    {<1=Command Desabilitada; 0 = Command abilitada }
                         Mb_Bits      : Longint; {<Mapa de Bits deste comando}
                         Flags_Buttons : Byte; {<BfNormal.. etc. The following button flags are defined:}
                      End;

          TIRCommands = 0..255;
          PRCommands = ^TRCommands;
          TRCommands = Array[TIRCommands] of TRCommand;


        {: O record **@name** é usado para padronizar os comandos sql independente do banco de dados.

           - Os geradores de código não usa string diretamente e sim a variável que contém o comando,
             isso é necessário porque os bancos de dados não são padronizados.

             - Exemplo:
               - Comando para criar um campo Integer com 4 bytes com chave primária e autoincremental:
                 - SqLite = Integer PRIMARY KEY AUTOINCREMENT
                 - PostgreSQL = SERIAL PRIMARY KEY

           - **REFERẼNCIA**
             - [Planilha com sintaxe dos banco de dados aceitos](https://docs.google.com/spreadsheets/d/16jchX4-1KfGUn7c0Qp_GD7YVEbZ0Yh49OjkKYXo0WCE/edit#gid=0)
        }
        Type TStrSQL = Record
                          {: O campo **@name** é usado no SqLite após a declaração de criação da tabela indicando que deve considerar os tipos de dados }
                          strictt  : AnsiString;
                          {: O comando **@name** Cria tabela no bancod e dados.
                             - **REFERÊNCIA**
                               - [sql-createtable](https://www.postgresql.org/docs/11/sql-createtable.html)
                          }
                          Create : AnsiString;
                          table  : AnsiString; //:< Clausula Table. Padrão

                          if_not_exists : AnsiString; //:< Clausula indicando que não faça nada caso o nome seguinte exista no banco de dados.

                          not_null      : AnsiString; //:< restrição indicando que não pode conter valor nulo.
                          default       : Ansistring; //:< Valor padrão para a coluna.

                          {: O comando **@name** é usado para criar tabela}
                          CreateTable   : Ansistring;
                          CreateTable_AddColString : AnsiString; //:< Adiciona um coluna tipo string na clausula Create Table
                          CreateTable_AddColNumber : AnsiString; //:< Adiciona um coluna tipo número na clausula Create Table

                          AlterTable_AddColString : AnsiString; //:< Adiciona um coluna tipo string na clausula Alter Table
                          AlterTable_AddColNumber : AnsiString; //:< Adiciona um coluna tipo número na clausula Alter Table

                          Select: AnsiString; //:< Clausula Select - Padrão
                          From  : AnsiString; //:< Clausula from - Padrão
                          PrimaryKey          : AnsiString; //:< Chave primária número usada com a clausula AutoIncrement.
                          PrimaryKeyComposite : AnsiString; //:< Chave primária composta usada em create Table.
                          PrimaryKeyCompositeAlterTable : AnsiString; //:< Chave primária composta usada em Alter Table

                          Unique : AnsiString; //:< Essa clausula cria um índice com chave única e composta ou não.

                          AutoIncrement : AnsiString; //:< Indica que a coluna é numérica e que a sequência é criada automaticamente.
                          Longint_PrimaryKey_AutoIncrement : AnsiString; //: < Indica que a coluna é numérica longint, é chave primária e que a sequência é criada automaticamente.
                          byte          : AnsiString; //:< Acoluna é do tipo byte. ( 1 posição)
                          SmallInt      : AnsiString; //:< Acoluna é do tipo smallint. ( 2 posições)
                          Longint       : AnsiString; //:< Acoluna é do tipo longint. ( 4 posições)
                          Real4         : AnsiString; //: A coluna é do tipo single
                          Real8         : AnsiString; //: A coluna é do tipo double
                          char          : AnsiString; //:< Acoluna é do tipo char. ( 1 posição)
                          Ansi_String   : AnsiString; //:< Tipo string de tamanho fixo.
                          Array_Char    : AnsiString; //:< Tipo array de char de tamanho fixo preenchido com espaço em branco.
                          memo          : AnsiString; //:< Tipo de campo memo no banco de dados

                          ForeignKey    : AnsiString; //:< Expressão para criar restrição de chave estrangeira ou seja relacionamentos.
                          ForeignKey_SetNull    : AnsiString; //:< Caso o registro da tabela pai seja excluído o campo da tabela filha torna-se o valor nulo.
                          ForeignKey_SetDefault : AnsiString; //:< Caso o registro da tabela pai seja excluído o campo da tabela filha torna-se o padrão para o campo.
                          ForeignKey_Restrict   : AnsiString; //:< Não permite incluir um registro na filha se o mesmo não existir na tabela pai.
                          ForeignKey_NoAction   : AnsiString; //:< Não faz nada
                          ForeignKey_Cascade    : AnsiString; //:< Caso um registro da tabela pai seja excluído então deleta todos os registro da tabela filha.

                       end;

      end;

implementation

{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{$Region '---> TViRect <---' }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

    procedure TUiTypes.TViRect.Assign(XA, YA, XB, YB: Integer);
    begin
      A.X := XA;                                         { Hold A.X value }
      A.Y := YA;                                         { Hold A.Y value }
      B.X := XB;                                         { Hold B.X value }
      B.Y := YB;                                         { Hold B.Y value }
    end;

    procedure TUiTypes.TViRect.AssignLimits(XA_Min, YA_Min, XB_Max, YB_Max: Integer);
    Begin
      R_New_Limits.A.X := XA_Min;
      R_New_Limits.A.Y := YA_Min;

      R_New_Limits.B.X := XB_Max;
      R_New_Limits.B.Y := YB_Max;

      AddCol_overfow := true;
      AddRow_overfow := true;
    End;

    procedure TUiTypes.TViRect.Copy(R: TRect);
    begin
      A := R.A;                                          { Copy point a }
      B := R.B;                                          { Copy point b }
    end;

    procedure TUiTypes.TViRect.Adjust_if_not_valid(MinX, MinY: Int64;var aRect: TRect);
     {Ajusta aRect se o retângulo não obdecer os tamanhos passados por MinX,MinY }
    Begin
      With aRect do
        If (B.Y - A.Y) < MinY
        Then B.Y := A.Y+MinY;

      With aRect do
        If (B.X - A.X) < MinX
        Then B.X := A.X+MinX;
    end;

    procedure TUiTypes.TViRect.Set_Max_Ax_e_Max_BY(Max_X, Max_Y: Int64);
    Begin
      If (B.X - A.X) > Max_X Then B.X := A.X + Max_X;
      If (B.Y - A.Y) > Max_Y Then B.Y := A.Y + Max_Y;
    End;

    function TUiTypes.TViRect.GetRect_Relative(aR_Neighbor: TRect;
                                                             aPerc_point_A: Byte;
                                                             adirection_point_A: Tdirection;
                                                             aPerc_point_B: Byte;
                                                             adirection_point_B:
                                                             Tdirection;
                                                             var aR_New: TRect  ): Boolean;

        Procedure Create_Point_A(X,Y:Int64);
        Begin
          R_New.A.X := X;
          R_New.A.Y := Y;

          if R_New_Limits.Empty
          then Begin
                  If Not Overflow
                  Then Overflow := (R_New.A.X<0) or
                                   (R_New.A.Y<0) or
                                   (R_New.A.X> A.X) or
                                   (R_New.A.Y> A.Y);
          End;
        end;

        Procedure Create_Point_B(X,Y:Int64);
        Begin
          R_New.B.X := X;
          R_New.B.Y := Y;
          if R_New_Limits.Empty
          then Begin
                  If Not Overflow
                  Then Overflow := (R_New.B.X<0) or
                                   (R_New.B.Y<0) or
                                   (R_New.B.X> B.X) or
                                   (R_New.B.Y> B.Y);
               End;
        end;

        Procedure Calc_point_A_North;{<Norte}
        Begin
          Create_Point_A(R_Neighbor.A.X,R_Neighbor.A.Y{<-1});
        end;

        Procedure Calc_point_A_South;{<Sul}
        Begin
          Create_Point_A(R_Neighbor.A.X,R_Neighbor.B.Y{<+1});
        end;

        Procedure Calc_point_A_West; {<Oeste}
        Begin
          Create_Point_A(R_Neighbor.A.X{<-1},R_Neighbor.A.Y);
        end;

        Procedure Calc_point_A_East;{<Leste}
        Begin
          Create_Point_A(R_Neighbor.B.X{<+1},R_Neighbor.A.Y);
        end;

    Var
      r     : Double;
    Begin
       Try
         Try
           Fillchar(ROverflow,sizeof(ROverflow),0);
           Overflow := false;

           R_Neighbor := aR_Neighbor;{<Vizinho}
           R_New      := aR_New;    {<Inicializa R_new com endereco no buffer a ser retornado}
           Case aDirection_point_A of
             North : Begin {$Region ' ---> North  <---'}
                       Calc_point_A_North;
                       Case aDirection_point_B of
                         North ,
                         South : Raise TException.Create(ParametroInvalido);

                         East  : Create_point_B(Integer(R_New.A.X + Round(( (B.X           - R_New.A.X) *
                                                                                    (aPerc_point_B / 100) )
                                                                                  )
                                                                         ),
                                                Integer(R_New.A.Y - Round(((R_New.A.Y - A.Y)*(aPerc_point_A/100)))));

                         West  : Create_point_B(R_New.A.X - Round(((R_New.A.X - A.X )      *(aPerc_point_B/100))),
                                                R_New.A.Y - Round(((R_New.A.Y - A.Y)       *(aPerc_point_A/100))));
                       end;
                     end; {$EndRegion ' ---> North  <---'}

             South : Begin {$Region ' ---> South <---'}
                       Calc_point_A_South;
                       Case aDirection_point_B of
                         North ,
                         South : Raise TException.Create(ParametroInvalido);
                         East  : Begin
                                   r := aPerc_point_B / 100; {<Nao tem sentido mais aqui em tempo de debug esta dando GPF

                                   P1 := Round(R_New.A.X      + (B.X - R_New.A.X     ) * r);
                                   r := aPerc_point_A / 100;
                                   p2 := ROUND(R_Neighbor.B.Y + (B.Y - R_Neighbor.B.Y) * R);}

                                   Create_point_B(Integer(R_New.A.X      + Round((B.X - R_New.A.X     ) * (aPerc_point_B/100))),
                                                  Integer(R_Neighbor.B.Y + Round((B.Y - R_Neighbor.B.Y) * (aPerc_point_A/100))));
                                 End;

                         West  : Create_point_B(Integer(R_New.A.X    - Round((R_Neighbor.A.X - A.X ) * (aPerc_point_B/100))),
                                                Integer(R_Neighbor.B.Y + Round((B.Y - R_Neighbor.B.Y ) * (aPerc_point_A/100))));
                       end;
                     end; {$EndRegion ' ---> South <---'}

             East  : Begin {$Region ' ---> East <---'}
                       Calc_point_A_East;
                       Case aDirection_point_B of
                         North : Create_point_B(R_New.A.X + Round((B.X - R_New.A.X)*(aPerc_point_A/100)),
                                              R_New.A.Y - Round((R_New.A.Y - A.Y)*(aPerc_point_B/100)));

                         South : Create_point_B(R_New.A.X + Round((B.X - R_New.A.X)*(aPerc_point_A/100)),
                                              R_New.A.Y + Round((B.Y - R_New.A.Y)*(aPerc_point_B/100)));
                         East,
                         West : Raise TException.Create(ParametroInvalido);
                       end;
                     end;  {$EndRegion ' ---> East <---'}

             West  : Begin {$Region ' ---> West <---'}
                         Begin
                           Raise TException.Create(ParametroInvalido);
                         End;
                       Calc_point_A_West;
                       Case aDirection_point_B of
                         North : Create_point_B(R_New.A.X - Round((R_New.A.X - A.X)*(aPerc_point_A/100)),
                                              R_New.A.Y - Round((R_New.A.Y - A.Y)*(aPerc_point_B/100)));

                         South : Create_point_B(R_New.A.X - Round((R_New.A.X - A.X       )*(aPerc_point_A/100)),
                                              R_New.A.Y + Round((B.Y        - R_New.A.Y)*(aPerc_point_B/100)));
                         East,
                         West : Begin
                                   Raise TException.Create(ParametroInvalido);
                                End;
                       end; {$EndRegion ' ---> West <---'}
                     end;
           end;

         Except
            EInvalidOp.Create('Parametro inválido em: TUiTypes.TViRect.GetRect_Relative');
         end;

       Finally
         Adjust_if_not_valid(3,2,R_New);
         GetRect_Relative := Overflow;
         aR_New      := R_New;
       End;
    end;

     /// Calculo um novo bound de largura aWidth e altura aHeight viznho nas quatro direções da origem aR_Neighbor
    function TUiTypes.TViRect.GetRect_Absolute(aR_Neighbor: TRect; aWidth,aHeight: Integer; adirection: Tdirection; var aR_New: TRect): Boolean;

        Procedure Create_Point_A(X,Y:Int64);
        Begin
          R_New.A.X := X;
          R_New.A.Y := Y;

          If Not Overflow
          Then Begin

                 if R_New_Limits.Empty
                 then Begin
                        ROverflow.XA_Min := R_New.A.X < 0;
                        ROverflow.YA_Min := R_New.A.Y < 0;
                      End
                 Else Begin
                        ROverflow.XA_Min := R_New.A.X < Self.R_New_Limits.A.X;
                        ROverflow.YA_Min := R_New.A.Y < Self.R_New_Limits.A.Y;
                      End;

                  Overflow := ROverflow.XA_Min or ROverflow.YA_Min;
               End;
        end;

        Procedure Create_Point_B(X,Y:Int64);
        Begin
          R_New.B.X := X;
          R_New.B.Y := Y;

          If Not Overflow
          Then Begin

                 if R_New_Limits.Empty
                 then Begin
                        ROverflow.XB_Max := R_New.B.X < 0;
                        ROverflow.YB_Max := R_New.B.Y < 0;
                      End
                 Else Begin
                        ROverflow.XB_Max := R_New.B.X > Self.R_New_Limits.B.X;
                        ROverflow.YB_Max := R_New.B.Y > Self.R_New_Limits.B.Y;
                      End;

                  Overflow := ROverflow.XB_Max or ROverflow.YB_Max;
               End;
        end;

    Begin
      Fillchar(ROverflow,sizeof(ROverflow),0);
      Overflow := false;
      R_Neighbor := aR_Neighbor;//Vizinho
      R_New      := R_Neighbor;    //Inicializa R_new com endereco no buffer a ser retornado
      Case aDirection of
         North : Begin {$Region ' ---> North  <---'}

                   Create_Point_A(R_Neighbor.A.X , R_Neighbor.A.Y- aHeight);
                   Create_point_B(R_New.A.X+aWidth-1,R_New.A.Y + aHeight-1);

                 end;  {$EndRegion ' ---> North  <---'}

         South : Begin {$Region ' ---> South <---'}
                   Create_Point_A(R_Neighbor.A.X,R_Neighbor.B.Y+1);
                   Create_point_B(R_New.A.X+aWidth-1,R_New.A.Y + aHeight-1);
                   {$EndRegion ' ---> South <---'}
                 end;

         East  : Begin {$Region ' ---> East <---'}
                   Create_Point_A(R_Neighbor.B.X+1,R_Neighbor.A.Y);
                   Create_point_B(R_New.A.X+aWidth-1,R_New.A.Y + aHeight-1);
                 end;  {$EndRegion ' ---> East <---'}

         West  : Begin {$Region ' ---> West <---'}
                   Create_Point_A(R_Neighbor.A.X-aWidth,R_Neighbor.A.Y);
                   Create_point_B(R_New.A.X+aWidth-1,R_New.A.Y + aHeight-1);
                 end; {$EndRegion ' ---> West <---'}

       end;
       Result := Overflow;
       aR_New      := R_New;
    End;

    function TUiTypes.TViRect.GetRect_Absolute(aWidth, aHeight: Integer;adirection: Tdirection; var aR_New: TRect): Boolean;
      Var
        aR_Neighbor : TRect;
    Begin
      aR_Neighbor.A := A;
      aR_Neighbor.B := B;
      Result := GetRect_Absolute(aR_Neighbor,aWidth,aHeight,adirection,aR_New);
    End;

     /// Calcula um retangula a direita do corrente e se passar do limite direito adiciona uma nova linha.
    function TUiTypes.TViRect.GetRect_AddCol(aWidth, aHeight: Integer;var aR_New: TRect): Boolean;
      Var
        aR_Neighbor : TRect;
    Begin
      aR_Neighbor.A := A;
      aR_Neighbor.B := B;
      Result := GetRect_Absolute(aR_Neighbor,aWidth,aHeight,East,aR_New);
      if Result
         and AddCol_overfow //True = Adiciona uma nova linha ao encontrar overflow.
      Then Begin
              //Calcula o ponto em overfloa como o primeiro ponto abaixo de RectNew corrente
               aR_New.A.X := R_New_Limits.A.X;
               aR_New.A.Y := aR_New.B.Y  + 1;

               aR_New.B.X := aR_New.A.X + aWidth - 1;
               aR_New.B.Y := aR_New.A.Y + aHeight -1;
             End;

      Copy(aR_New);
    End;

    /// Calcula um retangula a abaixo do corrente e se passar do limite Limit.B.Y adiciona uma nova Coluna.
    function TUiTypes.TViRect.GetRect_AddRow(aWidth, aHeight: Integer;var aR_New: TRect): Boolean;
      Var
        aR_Neighbor : TRect;
        ch:char;
    Begin
      aR_Neighbor.A := A;
      aR_Neighbor.B := B;

      Result := GetRect_Absolute(aR_Neighbor,aWidth,aHeight,South,aR_New);
      if Result
         And AddRow_overfow //True = Adiciona uma nova coluna ao encontrar overflow.
      Then Begin
              //Calcula o ponto em overfloa como o primeiro ponto ao lado RectNew corrente e primera linha.

               aR_New.A.X := aR_Neighbor.A.X+aWidth;
               aR_New.A.Y :=  + 1;

               aR_New.B.X := aR_New.A.X + aWidth - 1;
               aR_New.B.Y := aR_New.A.Y + aHeight -1;

                //gotoxy(aR_New.A.X,aR_New.A.Y);write('whereX: ',whereX,' whereY: ',wherey);
                //gotoxy(aR_New.B.X,aR_New.B.Y);write('whereX: ',whereX,' whereY: ',wherey);
                //ch := readkey;
           End;
      Copy(aR_New);
    End;

    procedure TUiTypes.TViRect.MoveTo(X, Y: Integer);
    begin
      Assign(X, Y, X + (B.X-A.X), Y + (B.Y-A.Y));
    end;

    procedure TUiTypes.TViRect.MoveTo_Direction(adirection: Tdirection; aOwner: TRect);

         {***
           Ajusta o retângulo filho dentro do retângulo aOwner levando em
           consideracao as coordenadas geograficas.
         ***}

        {*****************************************

             Exemplos do uso deste metodo:

        *****************************************}

        { *** Centraliza no centro de Y ***
                RViDlg.MoveTo_Direction(CenterY,aOwner);}

        { *** Centraliza no centro de X ***
                RViDlg.MoveTo_Direction(CenterX,aOwner);}

        { *** Centraliza no centro de X e no Centro de Y ***
                RViDlg.MoveTo_Direction(CenterXY,aOwner);}

        { *** Move para o canto Superior esquerdo ***
                 RViDlg.MoveTo_Direction(North,aOwner);
                 RViDlg.MoveTo_Direction(West,aOwner);}

        { *** Move para o canto Inferior esquerdo ***
                 RViDlg.MoveTo_Direction(South,aOwner);
                 RViDlg.MoveTo_Direction(West,aOwner);}

        { *** Move para o canto Superior direito ***
                 RViDlg.MoveTo_Direction(East,aOwner);
                 RViDlg.MoveTo_Direction(North,aOwner);}

        { *** Move para o canto Inferior Direito ***
                 RViDlg.MoveTo_Direction(East,aOwner);
                 RViDlg.MoveTo_Direction(South,aOwner);}


    Begin
      Case aDirection of
        CenterX : MoveTo(((aOwner.B.X - aOwner.A.X)-(B.X-A.X) ) DIV 2,A.Y);
        CenterY : MoveTo(A.X,((aOwner.B.Y - aOwner.A.Y)-(B.Y - A.Y)) DIV 2);
        CenterXY: Begin
                    MoveTo_Direction(CenterX,aOwner);
                    MoveTo_Direction(CenterY,aOwner);
                  end;
        North   : MoveTo(A.X,aOwner.A.X);
        South   : MoveTo(A.X,(aOwner.B.Y -(B.Y-A.Y)));
        East    : MoveTo(aOwner.B.X -(B.X-A.X),A.Y);
        West    : MoveTo(aOwner.A.Y,A.Y);
      end;
    End;

    procedure TUiTypes.TViRect.MoveTo_Direction(adirection: Tdirection);
    Begin
      MoveTo_Direction(adirection ,R_New_Limits);
    end;

    procedure TUiTypes.TViRect.GetRect(var aR_New: TRect); {<Retorna o Ponto calculado }
    Begin
      aR_New.Assign(A.X,A.Y,B.X,B.Y);
    end;

{$EndRegion '---> TViRect <---' }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

{$REGION 'Rotina para teste da classe TViRect'

{$ENDREGION}


end.

