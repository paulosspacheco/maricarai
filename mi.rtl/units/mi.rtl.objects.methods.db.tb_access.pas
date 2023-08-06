(****************************************************************)
(*                     DATABASE TOOLBOX 4.0                     *)
(*     Copyright (c) 1984, 87 by Borland International, Inc.    *)
(*                                                              *)
(*                     TURBO ACCESS UNIT                        *)
(*                                                              *)
(*    Toolbox of low-level Turbo Access routines.  This unit is *)
(*    required by all Turbo Access programs.  Run TABuild to    *)
(*    configure this unit for your particular database.         *)
(*  dica Arvore B: https://www.youtube.com/watch?v=5mC6TmviBPE  *)
(*  dica Arvore B+: https://www.youtube.com/watch?v=x-NNKmdHm94 *)
(*  dica arvore B+: https://www.youtube.com/watch?v=o35vXlToB9M *)
(****************************************************************)
{$H-}
{$DEFINE TaDebug}
{$DEFINE Generic}

unit mi.rtl.Objects.Methods.Db.Tb_Access;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface
  Uses
     classes
     ,SysUtils
     ,Dos
     ,crt

     ,strings
     ,Memory
       ,mi.rtl.types
       ,mi.rtl.objects.consts.MI_MsgBox
       , mi.rtl.Consts.StrError
       ,mi.rtl.files
       ,mi.rtl.objects.Methods.Exception
       ,mi.rtl.objects.methods.StreamBase.Stream
       ,mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.BufferMemory
       ,mi.rtl.objects.methods.Collection.FilesStreams
       ,mi.rtl.objects.methods.Collection
       ,mi.rtl.objects.methods.Collection.SortedCollection
       ,mi.rtl.objects.methods.Collection.SortedCollection.StringCollection.CollectionString
       ,mi.rtl.objects.methods.StreamBase.Stream.FileStream
       ,mi.rtl.objects.Methods.dates
       ,mi.rtl.objects.Methods.System
     ;

      {TTransIsolation tipo = (tiDirtyRead ,
                                tiReadCommitted ,
                                tiRepeatableRead );

          TransIsolation propriedade: TTransIsolation ;

          Descrição:
            Utilização TransIsolation para especificar o nível de isolamento de transação para as transações
            de banco de dados.  nível de isolamento de transação como uma transação determina interage com
            outras operações simultâneas quando trabalham com as mesmas tabelas , e quanto uma transação
            vê o trabalho realizado por outras transações.

            TransIsolation pode ser qualquer um dos três valores resumidos na tabela a seguir :
            nível de isolamento Significado

            tiDirtyRead - Permite a leitura de alterações não autorizadas feitas ao banco de dados de outras
                          transações  simultâneas.  alterações não são permanentes, e pode ser
                          revertida ( desfeita) a qualquer momento.
                          A este nível �, pelo menos uma operação isolada dos efeitos de outras operações.

            tiReadCommitted - Permite a leitura de comprometidos (permanente ), as alterações feitas no banco
                              de dados de outras transações simultâneas. Este é o valor padrão da propriedade
                              TransIsolation .

            tiRepeatableRead - Permite uma leitura única, uma vez do banco de dados . A transação não pode ver
                              quaisquer alterações posteriores feitas por outras transações simultâneas.
                              Isso garante nível de isolamento , uma vez que uma transação l� um registro ,
                              a sua visão de que o registro não muda a menos que ele faz uma modificação
                              no registro próprio.   A este nível , uma transação � a mais isolada de outras
                              transações.

      }


  //***********************************************************************************************************************
  {$REGION '---> TAREFAS PENDENTES DA UNIT.'}


  {$ENDREGION}
  //***********************************************************************************************************************



  {: A classe **@name** é usada para declarar todos os types da classe **TTb_Access**  }
  TYPE
    TTb_Access_types =
    Class(TObjectsSystem)
      type TErroDOS = Record
                         Status : Byte;       {Erro retornado por IoResult}
                      End;
      type PErroDOS = ^TErroDOS;
      type T_TTransaction = (Tra_Nul,Tra_AddRec,Tra_PutRec,Tra_DeleteRec);
      Type FileAsciiZ = array[1..255] of AnsiChar;
      Type FileName   = PathStr {[66]} ;

      {: Usado para arquivos Relationships}
      Type TypeHeaderRecordMaster= Record
                                     NRecProxLivre       : Longint; {:< Número do próximo registro no arquivo master}
                                     StatusSeFoiAlterado : Byte;    {:< Indica se o registro foi alteradoem memória }
                                     NumDeItems          : SmallWord; {:< Número de itens deste registro master}
                                     NRecProxItem        : Longint; {:< número do proximo item no arquivo de itens }
                                   End;

      {: Usado para arquivos Relationships}
      type TypeHeaderRecordItem = Record
                                    NRecProxLivre       : Longint; {:< Número do próximo registro no arquivo master}
                                    StatusSeFoiAlterado : Byte;
                                    NRecMaster          ,         {:< Número do registro do corpo do item}
                                    NRecItem            ,         {:< Número deste item no arquivo. Usado em PutForm}
                                    NRecProxItem        : Longint;{:< Número do próximo item}
                                    NumSequencial       : SmallWord; {:< Sequencial do item}
                                  End;

      {: Os 5 primeiros bytes do registro é guardar o número do pŕoximo registro livre}
      type TypeHeaderRecord = record
                                case SmallInt Of
                                  0 : (NRecAnt : Longint            );
                                  1 : (Buffer  : Array[1..5] of byte);
                                End;

      {: O tipo **@name** é usado para indicar a ultima operação do registro.

         - **NOTA**
           - 1 = inclusão S ou N
           - 2 = Alteração S ou N
           - 3 = Exclusão S ou N
      }
      type TipoUltOperacaoNoArquivo = String[3];

      {: Usado no início de cada registro por isso o registro deve herdar  }
      type TypeHeaderRecordNovo = record
                                    ProxLivre                : TypeHeaderRecord;
                                    UltOperacaoNoArquivo     : TipoUltOperacaoNoArquivo;
                                    Time                     : Longint; {:< Data e hora em que o lançamento foi alterado ou incluído }
                                    Usuario                  : SmallInt; {:< Número do usuário que gerou este lançamento}
                                  End;

      {: Usado p/ guarda o header logo que abrir o arquivo para evitar que em ambiente de rede o header fique maluco
      }
      type TsImagemHeader = Record
                              FirstFree: Longint;  {:< Primeiro registro livre        }
                              NumberFree: Longint; {:< Número de registros livres     }
                              RR {Int1} : Longint; {:< Número do registro RAIZ da árvore B+ dos índices }
                              ItemSize  : SmallWord; {:< Tamanho do registro            }
                              NumberKey  : Longint; {:< Número de chaves no índice     }
                            End;

      type TaKeyStr  =  TString;//string[MaxKeyLen];

      type TaItem    =  record
                          DataRef,
                          PageRef : Longint;
                          Key     : TaKeyStr;
                        end;

      const maxKeyLen       =  254  ; {:< Tamanho máximo da Chave}
      const pageSize        =  510 {16} ; {:< Número máximo de chaves permitido em uma página  }
      const order           =  255 { 8} ; {:< Número mínimo de chaves permitido em uma página  }
      const maxHeight       =  4   {60} ; {:< Número máximo de níveis na árvore B+             }

      type TItemArray  = array[1..PageSize] of TaItem;
      type TaPage      = record
                           Reservado   : TypeHeaderRecord; {PauloSSPacheco}
                           ItemsOnPage : 0..PageSize;
                           BckwPageRef : Longint;
                           ItemArray   : TItemArray ;
                         end;

      {: Obs: Se transformar este registro em objeto deve alterar tudo que se refere a dataFile
      }
      type DataFile  =
           record
             Tipo  : AnsiChar;{ D=Dados. Indica ao CloseFilesOpens que se trata de um arquivo de Dados }
             F     : TStream; //TFileStream;_TStream;{TFile;}
                                {Obs:
                                 O flush do windows Nao funciona em ambiente de rede por isso implementei o meu.
                                 O Campo FileRec(F).UserData[1] esta sendo usado para controlar se o registro foi modificado.

                                 FileRec(F).UserData[1] = 1 -> FlushDosFile fecha e abre o Arquivo.
                                 FileRec(F).UserData[1] = 0 -> Desconsidera FlushDosFile.

                                 Obs:
                                   Esta variável e atualizada em:
                                     _PutRec      ->  FileRec(F).UserData[1] = 1 indicando que o arquivo foi alterado.
                                     FlushDOSFile ->  FileRec(F).UserData[1] = 0 indicando que o arquivo Nao foi alterado.

                               ---------------------------
                               Obs:
                                 O Campo FileRec(F).UserData[2] esta sendo usado para salva o FileMode da abertura do arquivo.

                                 Em Reset devo atualizar FileRec(F).UserData[2] := FileMode


                               ---------------------------
                               Obs:
                                 O Campo FileRec(F).UserData[3] esta sendo usado para salva o numero de registros travado.
                              }


             FirstFree,            { Primeiro registro Livre        }
             NumberFree,           { Numero de registros livres     }
             RR {Int1}       : Longint; { Numero do registro RAIZ da árvore B+ dos índices }

             ItemSize   : SmallWord;    { Tamanho do registro            }
             NumberKey  : Longint; { Numero de chaves no Indice     }
             NumRec     : Longint; { Numero de registros no arquivo }
             IH         : TsImagemHeader;
                          { Obs. Finalidade de operação em rede local.
                               Guarda o header assim que abre o arquivo;
                            para verificar no fechamento ou nas rotinas
                            de flush se o usuário atual alterou o arquivo.
                               Caso tenha alterado e o header tenha se
                            modificado então os ponteiros dos arquivos
                            Nao apontar�o para a realidade.}

             FileModeDenyALL, {Modo como o arquivo foi aberto}
             Exclusivo   : Boolean;   {True = Uso exclusivo; false = Nao exclusivo}
             OkAddRecFirstFree   : Boolean       ; {True  = O procedimento AddRec aproveita o espaço dos
                                                            registros deletados.
                                                    False = O procedimento AddRec Não aproveita o espaço
                                                            dos registros deletados.
                                                            ou melhor o novo registro e adicionado no final do arquivo.
                                                   }
{                 ColRecsLocks  : TCollRecsLocks;} {Objects.TCollection;} {Coleção de registros travado}
{                 MRT           : PRRecsLocks;  }
             ErroDos        : TErroDOS;       {Registro com as ultima mensagens de erros fornecido pelo DOS}
             OkTemporario   : Boolean;   {True = Este é um arquivo temporário Nao deve entrar na transação}
             ok_Set_Transaction : Boolean;

             Filename       : PathStr;
             OkDeveIndexar : Boolean; // Se true a rotina de reindex All � acionada apos apertura da tabela

             //Ok_FlushDOSFile    : Boolean;

           end;
      type PDataFile = ^DataFile;

      Type TaPagePtr =  TaPage;
      Type TaSearchStep = record
                             PageRef,
                             ItemArrIndex : Longint;
                           end;

      Type TaPath =  array[1..MaxHeight] of TaSearchStep;

      Type IndexFile = record
      {                 Tipo          : AnsiChar;} { I=Indice. Indica ao CloseFilesOpens que se trata de um arquivo de índice }
                         DataF         : DataFile; { Arquivo com as páginas das chaves                                        }
                         NomeArqDados  : PathStr;  {Nome do arquivo de dados dono deste indice                                }

                         AllowDuplKeys : Boolean;  {False = permite chave duplicada;
                                                    True Nao permite
                                                   }
                                                   { 0 = Chave única; <> 0 Chave duplicada                                    }
                         KeyL          : byte;     { Tamanho da Chave                                                         }
                         {RR,}                     {Numero da página que contem a primeira chave}
                         PP            : Longint;  {Indica a página corrente}
                         Path          : TaPath;
                         OkDeveIndexar : Boolean;
                         OrderByDesc   : Boolean; {True = Ordem Decrescente; False = Ordem Crescente}
                         okBof_Ix,
                         OkEof_Ix :Boolean;
                         TaFindKey_pages_Reads:Longint; //Total de páginas lidas em taFindKey
                         NextKey_pages_Reads:Longint; //Total de páginas lidas em NexKey
                         PrevKey_pages_Reads:Longint; //Total de páginas lidas em NexKey
                       end;
      Type PIndexFile = ^IndexFile;
      Type IndexFilePtr = ^IndexFile;

      Type TaStackRec = record
                          Page      : TaPage;
                          IndexFPtr : IndexFilePtr;
                          PageRef   : Longint;
                          Updated   : Boolean;
                        end;

      {  TaStackRecPtr = ^TaStackRec;}

      {:< Tamanho maximo do registro.}
      const maxDataRecSize  = High (SmallWord)-1 {65000} ;

      {: Tipo registro do arquivo de transação}
      Type TaRecordBuffer = record
                              case SmallInt of
                                0 : (Page      : TaStackRec);
                                1 : (R         : array[1..MaxDataRecSize] of Byte);
                                2 : (I         : Longint);
                                3 : (Reservado : TypeHeaderRecord)
                            end;
      Type TaRecordBufPtr = ^TaRecordBuffer;

      type ProcPtr = ^byte;

      Type TaArrayPtr   =  TArrayPtr;//array[1..MaxArrayPtr      ] of Pointer;


    end;

  {: A classe **@name** é usada para declarar todas as constantes da classe **TTb_Access**  }
  TYPE
    TTb_Access_consts =
    Class(TTb_Access_types)
      Const ErroDOS : TErroDOS = (Status: 0);

//      const BlockSize_DatF : Longint = 512*8; {4096}
//      const BlockSize_IdxF : Longint = 512*32;{16384}

      {    PathDbTra            : PathStr = '';}{Diretório do arquivo de transação}
      const FileName_Transaction : PathStr = '';
      const ok_Debug_Transaction : Boolean = False {True};

      const OkTransaction        : Boolean = True; {:< False = desabilita transação                               }

      {: A Constante **@name** é usado para habilitar aproveitamento do espaço deletado.

         - **NOTA**
           - True  = O procedimento AddRec aproveita o espaço dos registros deletados.
           - False = O procedimento AddRec Não aproveita o espaço dos registros deletados.
                     ou melhor o novo registro e adicionado no final do arquivo.
      }
      const OkAddRecFirstFree   : Boolean = True;

      {: Máximo de arquivo que o DOS pode abrir sem a chamada da Interrupção No. $67 }
      const MaxFilesOpens : Byte = 20;

      {: 16K de Memória fica livre em setBufIndex}
      const MemoriaLivreEmTaPageStack = 64 {16}*1024;


      const MsgOkDuplicidade : Boolean = True; {:< Indica se deve dar mensagem de chave em duplicidade}
      const Neterr           : SmallInt =  0 ;  {:< Indica se houve erro na rede }

      const MaxFiles         : Byte = 254;

      const OkTestaAberturaDeArquivo : Boolean = true;

      const MaxPageEmMemoria = 20; {:< 10 ficou mais lento do que 20; 100 ficou mais lento do que 20}

      const MinPageEmMemoria =   3; {:< Usado no Buffer dos índice}

      {  ItemOverhead = 9;} { SizeOf(TaItem) - MaxKeyLen }
      {  PageOverhead = 5;} { SizeOf(TaPage.ItemsOnPage) + SizeOf(TaPage.BckwPageRef) }

      const NoDuplicates = 0;
      const Duplicates = 1;

      {: A constante **#name** é usado para guardar o número de chaves do Indice}
      const FileHeaderSize   = sizeof(TsImagemHeader);
      const MinDataRecSize   = FileHeaderSize;
      Const ItemOverhead = {9;}  SizeOf(TaItem) - Sizeof(TaKeyStr  {=TaItem.Key}) + 1;
      Const PageOverhead = {5;}  SizeOf(TaPage) - SizeOf(TItemArray {=TaPage.ItemArray}); {   K := (KeyLen + ItemOverHead) * PageSize + PageOverhead;}
      Const TaRecBuf  : TaRecordBufPtr     = nil;


      {Extecos usadas pelo banco de dados:}

      Const Const_Ext_Tabela           = '.Tb'; {<  Tabela}
      Const Const_Ext_Indice_da_tebela = '.Ix';

      Const Const_Ext_Tabela_com_a_copia_da_versao_anterior_da_tabela = '.Tb_'; {<  Tabela com a copia da versao anterior da tabela. }

      Const Const_Ext_Tabela_de_objetos_vinculados_a_tabela = '.TbO';
      Const Const_Ext_Tabela_com_os_registro_duplicados     = '.Tb1';

      Const Const_Ext_Tebela_com_as_Tabelas          = '.TbT';
      Const Const_Ext_Indice_da_Tabela_das_tabelas   = '.IxT';

      Const Const_Ext_Tabela_com_os_Indices       = '.TbI';
      Const Const_Ext_Indice_da_tebala_de_Indices = '.IxI';

      Const Const_Ext_Tabela_com_os_Relationships        = '.TbR';
      Const Const_Ext_Indice_da_tebala_dos_Relationships = '.IxR';

      Const Const_Ext_Tabela_com_todos_os_campos_de_todas_as_tabelas = '.TbC';
      Const Const_Ext_Indice_da_tabela_com_todos_os_campos           = '.IxC';

      Const Const_Ext_Tabela_de_Parametros           =  '.TbP';

      Const Const_Ext_Tabela_de_Usuarios            = '.TbU';
      Const Const_Ext_Indice_da_Tabela_de_Usuarios  ='.IxU';

      Const Const_Ext_Backup_da_Tabela              = '.TbK';

        {Extencoes conhecidas de outros banco de dados}

        {ACCESS}
      Const Const_Ext_Banco_de_dados_Access             = '.Mdb';
      Const Const_Ext_Banco_de_dados_Access_Secundario  = '.ldb';

      {  Interbase}
      Const Const_Ext_Banco_de_dados_Interbase             = '.GDB';

      {Paradox}
      Const Const_Ext_Tabela_Paradox                       = '.Db';
      Const Const_Ext_Tabela_Paradox_Px                    = '.Px';
      Const Const_Ext_Tabela_Paradox_Yx                    = '.Yx';

      {DBF}
      Const Const_Ext_Tabela_DBF                           = '.DBF';
      Const Const_Ext_Tabela_DBF_Ndx                       = '.Ndx';
      Const Const_Ext_Tabela_DBF_Idx                       = '.Idx';

      {Word}
      Const Const_Ext_Tabela_Word                          = '.Doc';

      {Excel}
      Const Const_Ext_Tabela_Excel                         = '.Xls';


        {Observacao esta faltando varios outros tipos conhecidos}
      Const  Const_Ext_Array : Array[1..24] of string[4] = (
                                Const_Ext_Tabela,
                                Const_Ext_Indice_da_tebela,

                                Const_Ext_Tabela_com_a_copia_da_versao_anterior_da_tabela,

                                Const_Ext_Tabela_de_objetos_vinculados_a_tabela,
                                Const_Ext_Tabela_com_os_registro_duplicados,

                                Const_Ext_Tebela_com_as_Tabelas,
                                Const_Ext_Indice_da_Tabela_das_tabelas,

                                Const_Ext_Tabela_com_os_Indices,
                                Const_Ext_Indice_da_tebala_de_Indices,

                                Const_Ext_Tabela_com_os_Relationships,
                                Const_Ext_Indice_da_tebala_dos_Relationships,

                                Const_Ext_Tabela_com_todos_os_campos_de_todas_as_tabelas,
                                Const_Ext_Indice_da_tabela_com_todos_os_campos,

                                Const_Ext_Tabela_de_Parametros,

                                Const_Ext_Tabela_de_Usuarios,
                                Const_Ext_Indice_da_Tabela_de_Usuarios,

                                Const_Ext_Backup_da_Tabela,

                                Const_Ext_Banco_de_dados_Access,
                                Const_Ext_Banco_de_dados_Access_Secundario,

                                Const_Ext_Tabela_DBF,
                                Const_Ext_Tabela_DBF_Ndx,
                                Const_Ext_Tabela_DBF_Idx,

                                Const_Ext_Tabela_Word,
                                Const_Ext_Tabela_Excel
                                );
  end;

  {: A classe **@name** é usada para acessar arquivos em disco **TTb_Access**  }
  type TDataFile = Class(TTb_Access_consts)
                      Public DataFile : ^DataFile;
                      Public Ok_CloseDataFile : Boolean;
                      public Constructor Create(const aDataFile : DataFile;Const aOk_CloseDataFile:Boolean);virtual;
                      public Destructor Destroy;Override;
                      public procedure SetDataFile(const aDataFile : DataFile;Const aOk_CloseDataFile : Boolean);
                    End;


  TYPE TTb_Access =
    Class(TTb_Access_consts)
      public class Procedure Create;
      public class Procedure Destroy; // Essa classe é inicializada em Tb__Access

      public class function FExisteCodigo (Var IxF:IndexFile; Const Codigo:tString):Boolean;


      public class Procedure CreateTAccess;
      public class Procedure DestroyTAccess;


      public class function EscrevaTurboError(DatF   : DataFile;Const NR : Longint;Error:SmallWord):Boolean;
      public class function TAIOCheck(VAR DatF : DataFile;Const R : LONGINT):Boolean;

      public class function SincronizaPosChave(Var datFIx:IndexFile;Const NrCurrent:Longint; KeyCurrent : TaKeyStr):Boolean;

//      public class function GoBof(var DatF : DataFile;Const R : Longint;var Buffer ):boolean;
//      public class function GoEof(var DatF : DataFile;Const R : Longint;var Buffer ):boolean;

      public class function GetRec(var DatF : DataFile;Const R : Longint;var Buffer ):Boolean;overload;

      public class function GetRecBlock(VAR DatF   : DataFile; Const R : LONGINT; delta:Word;Var BlocksRead:Word ;VAR Buffer  ):Boolean;

      public class function PutRec(var DatF : DataFile;Const R : Longint;var Buffer;Const Transaction_Current : T_TTransaction):Boolean;overload;
      public class function PutRec(var DatF : DataFile;Const R : Longint;var Buffer  ):Boolean;overload;


      public class function MakeFile(var DatF : DataFile;Const FName : FileName;Const RecLen : SmallWord):Integer;overload;



      public class function FDelStrBrancos(S:tString):tString;


      private class function GetTempDir(Const env:tString;Var path:PathStr):SmallInt;

      public class function FileNameTemp_Ext(const aPath:PathStr;Var NomeArqTemp : PathStr;const Extencao : PathStr):Boolean;overload; { Cria arquivo temporário }
      public class function FileNameTemp_Ext(Var NomeArqTemp : PathStr;const Extencao : PathStr):Boolean;Overload;
      public class function FileNameTemp(const Extencao : PathStr):PathStr; { Cria arquivo temporário }

      public class function FileName_Seq(Const aName:PathStr;Const aExt : PathStr):PathStr;
      public class function IsPortLocal(WPort: TTb_Access.tString):Boolean;
      public class function DelFile( Const Nome : NameStr):Boolean;
      public class function SetOkAddRecFirstFree(Const aOkAddRecFirstFree: Boolean):Boolean;
      public class function TestaSePodeAbrirArquivo(Const FName  : PathStr): Byte;
      public class function FileShared(Const FName  : PathStr) : Boolean;

      public class function FTrocaExtencao(Const NomeArq:NameStr; Extencao:PathStr) : PathStr;
      public class function Ren(NomeFonte,NomeDestino: PathStr) : Boolean;


      {: A class método **@name** retorna true se o Tamanho do registro em arquivo é maior que o tamanho do buffer do registro em Memória.
      }
      public class function OkRecSizeMismatch(Const FName  : FileName;Const RecLenBufferRecord : SmallWord):Boolean;


      public class function ModifyStructurFile(Const FName:FileName;Const RecLenDest : SmallWord ):Boolean;virtual; abstract;
      public class function OpenFile(var DatF:DataFile;
                                     Const FName : FileName;
                                     Const RecLen:SmallWord):Integer;

      public class function ReadHeader(VAR DatF   : DataFile):Boolean;
      public class function PutFileHeader(VAR DatF : DataFile):Boolean;
      public class function NaoMuDOuHeader(VAR DatF : DataFile) : BOOLEAN;
      public class function MudouHeaderEmMemoria(VAR DatF : DataFile) : BOOLEAN;

      public class function aCloseFile(VAR DatF : DataFile):boolean;
      public class function CloseFile(VAR DatF : DataFile):boolean;Overload;
      public class function CloseFile(VAR DatF : DataFile;OkCondicional:Boolean):boolean;Overload;

      public class function FlushFile(VAR DatF : DataFile):Boolean;overload;

      public class function TraveRegistro(VAR  DatF : DataFile; Const R : LONGINT):Boolean;
      public class function DestraveRegistro(Var  DatF : DataFile;Const R : Longint):Boolean;
      public class function TraveHeader(VAR DatF : DataFile):Boolean;
      public class function DestraveHeader(VAR DatF : DataFile):Boolean;
      public class function IoResult(Var DatF : DataFile) : Integer;overload;

      public class function FileSize(VAR DatF : DataFile):Longint;Overload;

      public class Procedure NewRec(VAR DatF  : DataFile;VAR R     : LONGINT  );
      public class function AddRec(var DatF : DataFile;var R  : Longint;var Buffer ):Boolean;overload;

      public class function DeleteRecord(VAR DatF : DataFile;Const R : LONGINT; Var Buffer ):Boolean;overload;
      public class function DeleteRec   (var DatF : DataFile;Const R : Longint):Boolean;overload;

      public class function FileLen(VAR DatF : DataFile) : LONGINT;overload;

      public class function UsedRecs(VAR DatF : DataFile) : LONGINT; Overload;
      public class function UsedRecs(VAR DatF : DataFile;OK_GetHeader : Boolean) : LONGINT;Overload;

      public class function UsedRecs(Var IxF  :IndexFile;OK_GetHeaderDoIndice : Boolean) : LONGINT;Overload;
      public class function UsedRecs(Var IxF  :IndexFile) : LONGINT;Overload;

      public class function UsedRecs(Const FileName:PathStr) : Longint;Overload;


      public class Procedure TaPack(VAR Page : TaPage;Const KeyL : BYTE);
      public class Procedure TaUnpack(VAR Page : TaPage; Const     KeyL : BYTE);

      public class function Multiplo_Mais_proximo_de_N(Const K,N:Longint): Longint;

      public class function MakeIndex(var IxF : IndexFile;Const FName : FileName;Const KeyLen,S : byte):Integer;overload;

      public class function OpenIndex(var   IxF : IndexFile;Const FName : FileName;Const KeyLen,S : byte):Integer;overload;

      public class Procedure LeiaHeaderDoIndice( VAR IxF       : IndexFile);

      public class function aCloseIndex(VAR IxF : IndexFile):Boolean;overload;
      public class function CloseIndex (VAR IxF : IndexFile):boolean;Overload;
      public class function CloseIndex (VAR IxF : IndexFile;OkCondicional:Boolean):boolean;Overload;


      public class function FlushIndex(VAR IxF       : IndexFile):boolean;overload;

      public class function EraseFile (VAR DatF : DataFile):boolean;overload;

      public class function EraseIndex(VAR IxF : IndexFile):boolean;overload;

      public class function TaGetPage(VAR IxF  : IndexFile;Const R     : LONGINT;VAR PgPtr : TaPagePtr):boolean;//
      public class Procedure TaNewPage(VAR IxF  : IndexFile; VAR R     : LONGINT; VAR PgPtr : TaPagePtr);

      public class Procedure TaDeletePage(var IxF : IndexFile; VAR R     : LONGINT; VAR PgPtr : TaPagePtr);

      public class Procedure ClearKey(VAR IxF : IndexFile);overload;
      public class function NextKey(VAR IxF : IndexFile; VAR DataRecNum : LONGINT; VAR ProcKey ):Boolean;overload;
      public class function PrevKey(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey ):Boolean;overload;
      public class Procedure TaXKey(VAR K:TaKeyStr; Const KeyL : BYTE);
      public class function TaCompKeys(Const K1 ,K2; DR1,DR2 : LONGINT; Const Dup : BOOLEAN ) : Shortint;

      public class function TaFindKey(VAR IxF       : IndexFile;VAR DataRecNum : LONGINT;VAR ProcKey ):boolean;

      public class function FindKey(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;overload;
      public class function FindKeyTop(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;overload;

      public class function SearchKey(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey:TaKeyStr):Boolean;overload;
      public class function SearchKeyTop(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey:TaKeyStr;Const Okequal : Boolean):Boolean;overload;


      public class Procedure TaUpdatePage(VAR IxF  : IndexFile;
                                          VAR R     : LONGINT;
                                          VAR PgPtr : TaPagePtr;
                                          Const Transaction_Current : T_TTransaction);overload;

      //=====================================================================================================
      {$Region 'Local> Rotinas locais de AddKey publicadas para implementação de Inline <Local'}
      //=====================================================================================================

        public class Procedure AddKey_Search_Insert(
                          var IxF : IndexFile;
                          Var PrPgRef1 : LONGINT;
                          VAR PrPgRef2,c : LONGINT;

                          VAR PagePtr1,PagePtr2  : TaPagePtr;
                          VAR ProcItem1, ProcItem2 : TaItem;
                          vAR PassUp, okAddKey  : BOOLEAN;
                          Const ProcKey    : TaKeyStr;
                          Const DataRecNum : Longint;
                          VAR K,L     : SmallInt;
                          Var R : SmallInt
                         );

        public class Procedure AddKey_Search_Init_ProcItem1(Const ProcKey    : TaKeyStr;
                                               Const DataRecNum : Longint;
                                               vAR PassUp : BOOLEAN; VAR ProcItem1 : TaItem);

        public class Procedure AddKey_Search(var IxF : IndexFile;
                         PrPgRef1 : LONGINT;
                         VAR PrPgRef2,c : LONGINT;

                         VAR PagePtr1,PagePtr2  : TaPagePtr;
                         VAR ProcItem1, ProcItem2 : TaItem;
                         vAR PassUp, okAddKey  : BOOLEAN;
                         Const ProcKey    : TaKeyStr;
                         Const DataRecNum : Longint;
                         VAR K,L     : SmallInt
                         );

        public class function AddKey(var IxF : IndexFile; Const DataRecNum : Longint; Const ProcKey    : TaKeyStr):Boolean;overload;

      //=====================================================================================================
      {$EndRegion 'Local> Rotinas locais de AddKey publicadas para implementação de Inline <Local'}
      //=====================================================================================================

      public class function DeleteKey(var IxF : IndexFile;Const DataRecNum : Longint;var ProcKey:TaKeyStr ):Boolean;OVERLOAD;

      {public class function PTaPageStk : TaPageStackPtr;}

      public class function FGetHeaderDataFile(Const FileName: PathStr;Var Header : TsImagemHeader;Var aFileSize : Longint):Boolean;

      public class function FTamRegDataFile(Const FileName: PathStr):SmallWord;

      public class function NewFileName(FileName,Extencao:PathStr):PathStr;

      public class function FTb(Const FileName:PathStr):PathStr;
      public class function FObj(Const FileName:PathStr):PathStr;
      public class function FIx(Const FileName:PathStr):PathStr;
      public class function FDup(Const FileName:PathStr):PathStr;

      private class function WriteHeaderMakeFile(VAR DatF   : DataFile):boolean;

      public class Procedure AssignDataFile (Var DatF :DataFile;
                                              Const aFileName:PathStr;
                                              aBaseSize,
                                              aRecSize:SmallWord;

                                              aF :TStream;//_TStream;
                                              WTipo  : AnsiChar {'D = File; I : Index'}

                                              );Overload;

      public class Procedure AssignDataFile (Var DatF :DataFile;
                                             Const aFileName:PathStr;
                                             aBaseSize,
                                             aRecSize:SmallWord);Overload;

      public class Procedure AssignIndexFile(Var IxF            : IndexFile;
                                             Const aFileName    : PathStr;
                                             aBaseSize,
                                             aRecSize           : SmallWord);Overload;

      public class function UpperCase(str:AnsiString):AnsiString;
      public class function FMinuscula(str:AnsiString):AnsiString;

      public class function Int2str(Const L : LongInt) : TTb_Access.tString;
      public class procedure Beep;

      public class function spc(Const campo:AnsiString;Const tam :Longint):AnsiString;


      {public class function Set_FileModeDenyALL(Const ModoDoArquivo : Boolean):Boolean;}

      public class function SetOkTransaction(Const aOkTransaction : BOOLEAN):BOOLEAN; {Habilita o controle de transações}

      public class function StartTransaction(Const aDelta : SmallWord):Integer; Overload;
      public class function StartTransaction(Const DatF : DataFile ; Var aok_Set_Transaction : Boolean): Integer;Overload;

      public class function COMMIT:Boolean;Overload;
      public class function COMMIT(Const Wok_Set_Transaction : Boolean):Boolean;Overload;

      public class Procedure Rollback;

      public class function SetTransaction(const OnOff:Boolean;
                              Var WOK : Boolean // False =
                              ):Boolean;Overload; // Retorna true se sucesso e false se houve fracasso na chamada

      public class function SetTransaction(const OnOff:Boolean;
                              Var WOK,
                              { Retorna true se a transacao foi inicializada e false caso contrario
                               usado para executar rollback ou commite se o processo criou a trasacao}
                             Wok_Set_Transaction:Boolean):Boolean;Overload;

      public class function GetFileName_Transaction(): tString;
      public class function Assign_Transaction(Const aFileName : PathStr):SmallWord;


      public class function TransactionPendant_Error:Boolean;
      public class function TransactionPendant:Boolean;
      public class Procedure Truncate(Var DatF: DataFile;NR : LongInt);{Trunca o arquivo no registro NR}
      public class Procedure CopyFrom(Font_DatF: DataFile ;Var Dest_DatF: DataFile); Overload;
      public class Procedure CopyFrom(Font_IxF : IndexFile ;Var Dest_IxF : IndexFile);Overload;
    end;

  {: - FilesOpens é uma coleção que mantém todos os arquivos abertos até o momento
       com objetivo de  fecha-los nos casos exceção.
  }
  Type TFilesOpens = Class(TSortedCollection)
                       Public okFlushAllFiles : Boolean;{True = habilita FlushAllFiles}
                       Public constructor Create;
                       Public destructor destroy;override;
                       Public function Compare(Key1, Key2: Pointer): Sw_Integer; Override;
                       Public Function Set_OkFlushAllFiles(wOkFlushAllFiles:boolean):Boolean;
                       Public Procedure ListaTabelas;
                       Public procedure Insert(Item: Pointer); Override;
                       Public procedure FreeItem(Item: Pointer); Override;
                       Public Function FOkCodigo (NomeIxF:PathStr;Const Codigo:tString):Boolean;
                       Public Procedure FlushIndexs;
                       Public Procedure FlushAllFiles;
                       Public Function OpenAllFiles:Boolean;
                       Public Function CloseAllFiles:Boolean;

                       Public Procedure EstatisticasDosArquivosAbertos;
                       Public Procedure SaveCurrentState;
                       Public Procedure RestoreCurrentState;
                       Public Function MaxTamReg:SmallWord;
                     End;
Var
  FilesOpens   : TFilesOpens = nil;


{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}

Implementation

// uses    App;

{class function TTb_access. DataFile.Get_F : _TStream;
Begin
  Result := _F;
end;}

class procedure TTb_access.Truncate(Var DatF: DataFile;NR : LongInt);{Trunca o arquivo no registro NR}
Begin
  If Not Is_TFileOpen(DatF.F)
  Then Begin
         TaStatus := ErroArquivoFechado;
         Abort;
       End;
  DatF.F.Truncate(Nr);
end;

class procedure TTb_access.CopyFrom(Font_DatF: DataFile ;Var Dest_DatF: DataFile); Overload;
Begin
  Try
    If Not Is_TFileOpen(Dest_DatF.F)
    Then Begin
           TaStatus := ErroArquivoFechado;
           Abort;
         End;

    If Not Is_TFileOpen(Font_DatF.F)
    Then Begin
           TaStatus := ErroArquivoFechado;
           Abort;
         End;

    Dest_DatF.F.CopyFrom(Font_DatF.F);

    If TaStatus = 0
    Then ReadHeader(Dest_DatF);

    If TaStatus <> 0
    Then Abort;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Raise TException.Create7('',
                            'Tb_Access.Pas',
                            'TTb_access',
                            'CopyFrom',
                            Dest_DatF.FileName,
                            '',
                            TaStatus);
  end;
end;

class procedure TTb_access. CopyFrom(Font_IxF : IndexFile ;Var Dest_IxF : IndexFile);Overload;
Begin

  CopyFrom(Font_IxF.DataF,Dest_IxF.DataF);
  LeiaHeaderDoIndice(Dest_IxF);
  If TaStatus <> 0
  Then   Raise TException.Create7('',
                            'Tb_Access.Pas',
                            '',
                            'CopyFrom(Var S: TStream,'+Dest_IxF.DataF.FileName+')',
                            '',
                            '',
                             TaStatus);

end;

{$Region 'TDataFile '}
  Constructor TDataFile.Create(const aDataFile : DataFile;Const aOk_CloseDataFile:Boolean);
  Begin
    inherited Create(nil);
    SetDataFile(aDataFile,aOk_CloseDataFile);
  End;

  Destructor TDataFile.Destroy;
  Begin
    If Ok_CloseDataFile and (DataFile<>nil)
    Then Begin
           Dispose(DataFile);
           DataFile := nil;
         end;

    Inherited Destroy;
  end;

  procedure TDataFile.SetDataFile(Const aDataFile : DataFile;Const aOk_CloseDataFile : Boolean);
Begin
  If Ok_CloseDataFile and (DataFile<>nil)
  Then Begin
         Discard(TObject(DataFile.f));
         Dispose(DataFile);
         DataFile := nil;
       end;

  Ok_CloseDataFile := aOk_CloseDataFile;

  If Ok_CloseDataFile
  Then Begin
          New(DataFile);
          DataFile^ := aDataFile;
       End
  Else DataFile := @aDataFile;

End;
{$EndRegion }

{$I mi.rtl.objects.methods.db.tb_access.transaction_inc.pas} // Implementation TTransaction
{$I mi.rtl.objects.methods.db.tb_access.filesOpens_inc.pas}  // Implementation TFilesOpens

class function TTb_access. SetOkTransaction(Const aOkTransaction: Boolean):Boolean;
Begin
  if aOkTransaction = False Then
  Begin
    If (Not OkCreateTransaction) and (Transaction<>nil) and (not ok_Set_Transaction)
    Then Begin
           If Transaction.TransactionPendant=0
           Then Transaction.Rollback
           else Begin
                  Transaction.DatF.Close;
                  ok := true ;
                end;

           If Not ok
           Then Begin
                  result := ok;
                  exit;
                 end;
         End;
  End;

  result := OkTransaction;
  OkTransaction := aOkTransaction;
End;


class function TTb_access. StartTransaction(Const aDelta : SmallWord):Integer;
  Var
    Wok : Boolean;
Begin
  Wok := ok;

  If OkTransaction and (Transaction<>nil)
  Then StartTransaction := Transaction.StartTransaction(aDelta)
  else StartTransaction := O_gerente_de_transacoes_esta_inativo;

  ok := wok;


End;

class function TTb_access. StartTransaction(Const DatF : DataFile ; Var aok_Set_Transaction : Boolean): Integer;
Begin
  aok_Set_Transaction := ok_Set_Transaction;
{  If (Not OkCreateTransaction) and (Transaction<>nil) and (not ok_Set_Transaction)
  Then Begin
         If Transaction.TransactionPendant=0
         Then TaStatus := Transaction.Rollback
         else TaStatus := 0;
         If TaStatus <> 0 Then Abort;
       End; }

  If OkTransaction and (Not OkCreateTransaction)  and  (not ok_Set_Transaction) and (Not DatF.okTemporario) And (Transaction<>nil)
  Then Result := Transaction.StartTransaction(1)
  else Result := 0;

end;

class function TTb_access. COMMIT:Boolean;
Begin
  If OkTransaction and (Transaction<>nil)
  Then Result := Transaction.COMMIT
  Else Result := true;
End;

class function TTb_access. COMMIT(Const Wok_Set_Transaction : Boolean):Boolean;Overload;
Begin
  If OkTransaction and (Not Wok_Set_Transaction) And ok_Set_Transaction and  (Transaction<>nil)
  Then Begin
         If TaStatus = 0
         Then Result := Transaction.COMMIT
         Else Result := Transaction.Rollback=0;
       end
  Else Result := true;
End;


class procedure TTb_access. Rollback;
Begin
  If OkTransaction and (Transaction<>nil) Then
  Begin
    If (ok_Set_Transaction) and (Transaction.DatF.Handle<>HANDLE_INVALID) Then
      Transaction.Rollback;
{    else Begin
           TaStatus := Objeto_Nao_Inicializado;
           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                   'Tb_Access.Pas',
                                   'Rollback',
                                   TaSTatus);

         End;}
  End;
End;
{class function TTb_access. ok_Set_Transaction:Boolean;
Begin
  If (Transaction<>nil) Then
    ok_Set_Transaction := Transaction.ok_Set_Transaction
  else
    ok_Set_Transaction := false;
End;}

class function TTb_access. SetTransaction(const OnOff:Boolean;
                        Var WOK,
                        { Retorna true se a transacao foi inicializada e false caso contrario
                         usado para executar rollback ou commite se o processo criou a trasacao}
                       Wok_Set_Transaction:Boolean):Boolean;Overload;
{Var
  WWok : Boolean;}
Begin
{  WWok := ok;}  {Salva a variável ok para que ele nao seja trocado com a chamada desta funcao}
  If OnOff
  Then Begin
         If (OkTransaction) and  (Not ok_Set_Transaction)
         Then Begin
                wOK := StartTransaction(1)=0;
                Wok_Set_Transaction := WOK;
              End
         else BEGIN
                Wok_Set_Transaction := False;
                WOK := ok_Set_Transaction or (Not OkTransaction);
              END;
       End
  Else Begin
         If Wok_Set_Transaction
         Then Begin
                If Wok
                Then Wok := Commit
                Else Begin
                       Rollback;
{                       If (NrCurrent = NrCurrentAnt) and (Not AppendIng) And (NrCurrent>0)
                       Then FindKeyAtual;}
                     end;
                MessageError; {Se alguma mensagem de error tiver pendente imprimirar aqui}
              End;

       End;
  Result := wok;
End;

class function TTb_access. SetTransaction(const OnOff:Boolean;
                        Var WOK : Boolean // False =
                        ):Boolean; // Retorna true se sucesso e false se houve fracasso na chamada
  Var
    Result_Set_Transaction : Boolean;
Begin
  Result := SetTransaction(OnOff,WOK,Result_Set_Transaction);
End;

class function TTb_access. Assign_Transaction(Const aFileName : PathStr):SmallWord;
Begin
  If (Transaction<>nil) Then
    Assign_Transaction := Transaction.AssignFile(aFileName)
  Else
    Assign_Transaction := Objeto_Nao_Inicializado;
End;

class function TTb_access. GetFileName_Transaction(): tString;
Begin
  Result := Transaction.DatF.FileName;
end;

class function TTb_access. TransactionPendant_Error:Boolean;
Begin
  If (Transaction<>nil)
  Then with Transaction do
       Begin
         If TransactionPendant = 0
         Then Result := DatF.GetSize=0
         Else Result := false;
         Transaction.DatF.Close;
       End
  Else Result := false;
End;

class function TTb_access. TransactionPendant:Boolean;
Begin
  If (Transaction<>nil)
  Then Begin
         TransactionPendant := Transaction.TransactionPendant=0;
         Transaction.DatF.Close;
       End
  Else TransactionPendant := False;
End;


class function TTb_access. WriteHeaderMakeFile(VAR DatF   : DataFile):boolean;
BEGIN
  WITH DatF DO
  BEGIN
    MOVE(DatF.FirstFree,TaRecBuf^,FileHeaderSize);
    MOVE(DatF.FirstFree,IH.FirstFree,FileHeaderSize);

    Ok := PutRec(DatF,0,TaRecBuf^,Tra_AddRec);

    DatF.NumRec := 1; {NumRec=1 ao criar o arquivo pela primeira vez}
    Result := ok;
  END;

END; { WriteHeaderMakeFile }


class procedure TTb_access.AssignDataFile (Var DatF :DataFile;
                                            Const aFileName:PathStr;
                                                  aBaseSize,
                                                  aRecSize:SmallWord;
                                                  aF :TStream;
                                                  WTipo  : AnsiChar {'D = File; I : Index'}
                                            );Overload;
Begin
  {Discard(TObject(DatF.F));} {Se datF Tiver assinalado ele desaloca o arquivo. Somente precaução}
  If Is_TFileOpen(DatF.F)
  Then CloseFile(DatF);

  DatF.FileName          := ExpandFileName(LowerCase(ExtractFileName(aFileName)));
  DatF.Tipo              := UpCase(WTipo); { D=dados. Indica ao CloseFilesOpens que se trata de um arquivo de dados }
  If Not (DatF.Tipo in ['I','D'])
  THEN DatF.Tipo := 'D';

  If DatF.Tipo = 'I'
  Then aBaseSize := Sizeof(TsImagemHeader);

  DatF.FirstFree         := -1;
  DatF.ItemSize          := aRecSize;

  DatF.OkAddRecFirstFree := OkAddRecFirstFree;
  DatF.FileModeDenyALL   := FileModeDenyALL;
  DatF.NumberKey         := 0;
  DatF.RR                := 0;

  If aF = nil
  Then Begin
         If ((aFileName = '') or ((ShareMode and (FmMemory or FmMemory_Temp))<>0)) or DatF.OkTemporario
         Then Begin
                DatF.F := TBufferMemory.Create(aBaseSize,aRecSize);
                WriteHeaderMakeFile(DatF);
              End
         Else DatF.F := TFileStream.Create('',FileMode,aRecSize,aBaseSize,aRecSize);

       End
  Else DatF.F            := aF;

  DatF.F.FileName        := ExpandFileName(LowerCase(ExtractFileName(aFileName)));

//  If DatF.OkTemporario
//  Then DatF.F.ShareMode := FILE_ATTRIBUTE_TEMPORARY;

End;

class procedure TTb_access. AssignDataFile(Var DatF :DataFile;Const aFileName:PathStr;aBaseSize,aRecSize:SmallWord);
Begin
  AssignDataFile(DatF,aFileName,aBaseSize,aRecSize,nil,'D');
end;

class procedure TTb_access. AssignIndexFile(Var IxF :IndexFile;Const aFileName:PathStr;aBaseSize,aRecSize:SmallWord);
Begin
  AssignDataFile(IxF.DataF,aFileName,aBaseSize,aRecSize,nil,'I');
  IxF.DataF.OkAddRecFirstFree := false;//Não aproveita espaço de registro deletado.
  IxF.PP         := 0;
{  IxF.Tipo       := 'I';} { I=Indice. Indica ao CloseFilesOpens que se trata de um arquivo de indice }
{  IxF.DataF.Tipo := 'I';}
end;


class function TTb_access.IoResult(Var DatF : DataFile) : Integer;
Begin
  result := inherited IoResult;
  DatF.ErroDos := ErroDos;
End;

{@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@}

class function TTb_access. FTb(Const FileName:PathStr):PathStr;
Begin
//  If Pos('.',FileName) = 0
  If ExtractFileExt(FileName) = ''
  Then FTb := FileName+'.Tb'
  Else FTb := FileName;
End;
class function TTb_access. FObj(Const FileName:PathStr):PathStr;
Begin
  If ExtractFileExt(FileName) = ''
  Then FObj := FileName+'.TbO' {Tabelas de objetos vinculados a tabela m�e}
  Else FObj := FileName;
End;

class function TTb_access. FIx(Const FileName:PathStr):PathStr;
Begin
  If ExtractFileExt(FileName) = ''
  Then FIx := FileName+'.Ix'
  Else FIx := FileName;

End;
class function TTb_access. FDup(Const FileName:PathStr):PathStr;
Begin
  If ExtractFileExt(FileName) = ''
  Then FDup := FileName+'.TbD'
  Else FDup := Copy(FileName,1,Pos('.',FileName))+'TbD';
End;

class function TTb_access.FGetHeaderDataFile(Const FileName: PathStr;
                           Var Header : TsImagemHeader;
                           Var aFileSize : Longint):Boolean;
Var
  F : File;
Begin
  If FileExists(FTb(FileName)) Then
  Begin
    AssignFile(F,FTb(FileName));
    If FileSize(FileName) = 0
    Then Begin
           aFileSize := 0;
           FillChar(Header,sizeof(Header),0);
           Result    := false;
           exit;
         end;

{    If Systemm.FileSize(FileName) = 0
    Then Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'Tb_Access.Pas',
                                'FGetHeaderDataFile(' + FileName+ ')'
                                ,
                                'Tamanho do arquivo igual a zero.');}

    Reset(F,MinDataRecSize,FileMode);
    IF TaStatus=0 THEN
    Begin
      BlocksRead := BLOCKREAD(F,Header,1);
      FGetHeaderDataFile := (TaStatus = 0 ) and (BlocksRead=1);

      If (TaStatus = 0 ) and (BlocksRead=1) and (Header.ItemSize>0)
      Then aFileSize := System.FileSize(f)*MinDataRecSize Div Header.ItemSize
      else aFileSize := -1;
      Close(F);
    End
    else FGetHeaderDataFile := false;
  End
  else FGetHeaderDataFile := false;

End;

class function TTb_access. FTamRegDataFile(Const FileName: PathStr):SmallWord;
  Var
    Header : TsImagemHeader;
    aFileSize : Longint;
Begin


  If FGetHeaderDataFile(FileName,Header,aFileSize) Then
    FTamRegDataFile := Header.ItemSize
  else
    FTamRegDataFile := 0;


end;

class function TTb_access. UsedRecs(Const FileName:PathStr) : Longint;
  Var
    Header : TsImagemHeader;
    aFileSize : Longint;
Begin

  If FGetHeaderDataFile(FileName,Header,aFileSize)
  Then Result := aFileSize - Header.NumberFree - 1
  else Result := -1;;

End;


class function TTb_access. UsedRecs(Var IxF  :IndexFile;OK_GetHeaderDoIndice : Boolean) : LONGINT;Overload;
Begin
  Try

    If OK_GetHeaderDoIndice and Is_TFileOpen(IxF.DataF.F)
    Then LeiaHeaderDoIndice(IxF)
    Else TaStatus := 0;

  Finally
    If TaStatus = 0
    Then Result := IxF.DataF.NumberKey
    Else Result := 0;


  End;
end;

class function TTb_access. UsedRecs(Var IxF  :IndexFile) : LONGINT;Overload;
Begin
  Result := UsedRecs(IxF,true);
end;


class function TTb_access. NewFileName(FileName,Extencao:PathStr):PathStr;
Begin

{  While Pos(' ',FileName) <> 0
  do Delete(FileName,Pos(' ',FileName),1);}

  NewFileName:= Copy(FileName,1,Pos('.',FileName)) + Extencao;


End;

class function TTb_access. Int2str(Const L : LongInt) : tString;
{ Converts an SmallInt to a tString for use with OutText, OutTextXY }
var
  S : tString;
begin
  Str(L:0, S);
  Int2Str := S;
end; { Int2Str }


class procedure TTb_access. Beep;
begin
  Sound(300);
  Delay(50);
  NoSound;
end; { Beep }

{class procedure TTb_access. clreoln(i,j,tamanho : byte );
Var WindMinAux,WindMaxAux : SmallWord;
begin
  WindMinAux := WindMin;WindMaxAux := WindMax;
  Window(1,1,80,25);
  gotoxy(j,i); write('': tamanho);
  Window(Lo(WindMinAux)+1,Hi(WindMinAux)+1,Lo(WindMaxAux)+1,Hi(WindMaxAux)+1);
end;}

class function TTb_access.EscrevaTurboError(DatF : DataFile;Const NR : Longint;Error:SmallWord):Boolean;
  Var
    StrError  : tString;
    Msg     : tString;
    MsgError,aMsgError : PSItem;
    Wnr,SeqNrTravados,aFileName,
    wIsFileOpen,
    WFileSize,
    wDatF_NumRec    : tString;

  var
    Wok : Boolean;
    WTaStatus : Integer;
    wItemSize : AnsiString;

Begin

  Try
    WTaStatus := TaStatus;
    Wok := ok;
    Result := False; {Indica que houver um erro e que o sistema Nao deve preocesseguir}

    If (Error> 0) And (Error<=255)
    Then Msg := ^C+'O SISTEMA OPERACIONAL Não responde com o servi�o solicitado.'
    else Msg := ^C+'Aplicação com problemas. Acione o suporte ao produto.';

    StrError              := TStrError.ErrorMessage(Error);
    aFileName             := DatF.Filename;
    wItemSize             := IntToStr(DatF.ItemSize);

    SeqNrTravados         := '' {FilesOpens.StrRecsLocks(aFileName)};

    wNr                   := Int2Str(Nr);
    IoResult(DatF); {Inicializa InOutRes}
    If Is_TFileOpen(DatF.F) Then
    Begin
      wIsFileOpen := 'Aberto';
      WFileSize     := Int2Str(FileSize(DatF));
      wDatF_NumRec :=  Int2Str(DatF.NumRec);
    end
    else
    Begin
      wIsFileOpen  := 'Fechado';
      WFileSize    := '';
      wDatF_NumRec := '';
    end;

    MsgError := NewSItem(' ',
                NewSItem(Msg,
                NewSItem(' ',
                NewSItem('ERROR '+Int2Str(Error)+' :',
                NewSItem('  '+StrError,
                NewSItem(' ',
                NewSItem('ARQUIVO.......: '+aFileName,
                NewSItem('  Status......: '+wIsFileOpen,
                NewSItem('  FileSize(F).: '+WFileSize,
                NewSItem('  ItemSize....: '+wItemSize,
                NewSItem('  DatF.NumRec.: '+wDatF_NumRec,
                NewSItem('  Nr. corrente: '+wNr,
                NewSItem('  Nr. travados: '+SeqNrTravados,
                NewSItem(' ',
                NewSItem('ARQUIVOS EM USO: '+IStr(FilesOpens.Count,'BBB'),
                NewSItem('PRÓXIMO HANDLE.: '+IStr(FPrimeiroHandleLivre,'BBB'),
                NewSItem(' ',

                NewSItem('Não posso continuar o processamento.',
                NewSItem(' ',NIL

                )))))))))))))))))));

//    EscreveErroEmFerr;
        Push_MsgErro('------------------------------------------------------------');
        Push_MsgErro('Tb_Access.EscrevaTurboError');
        Push_MsgErro('------------------------------------------------------------');

        aMsgError := MsgError;
        While (aMsgError <> nil) and (aMsgError^.Value<>nil) do
        Begin
          Push_MsgErro(aMsgError^.Value^);
          aMsgError := aMsgError^.Next;
        End;
        Push_MsgErro('------------------------------------------------------------');
  Finally
    ok := wok;
    TaStatus := wTaStatus;
  End;
End;

class function TTb_access. TAIOCheck(VAR DatF : DataFile;Const R : LONGINT):Boolean;
BEGIN
  IF (TaStatus <> 0) or (Not Is_TFileOpen(DatF.F)) THEN
  Begin
    DatF.ErroDos := ErroDos; {Salva as informacoes do ultimo erro}
    Result := EscrevaTurboError(DatF,R,TaStatus);
  End
  Else Result := true;
END; { TAIOCheck }


class function TTb_access. spc(Const campo:AnsiString;Const tam :Longint):AnsiString;
begin
  {Result := '';}
  if Length(campo) < tam
  then Result := Campo + ConstStr(tam-Length(campo),' ')
  else Result := Copy(Campo,1,Tam);
end;

//class procedure TTb_access. EscrevaRP(Const LinMsg,colMsg:SmallInt;Const Str:tString);
//Begin
//  GotoXy(colMsg,LinMsg);Write(Spc(Str,length(Str)));
//end;

(*class procedure TTb_access. Erase(var F);
{$I-}  deu problemas por isso comentei???
Begin
  Ok := IoResult=0;
  Erase(F);
  Ok := IoResult=0;
End;*)


class function TTb_access. SincronizaPosChave(Var datFIx:IndexFile;Const NrCurrent:Longint; KeyCurrent : TaKeyStr):Boolean;
  {
    Com a chave anterior e o numero do registro anterior esta rotina
    Posiciona o ponteiro do indice exatamente onde estava antes

    Obs. Esta rotina e necess�ria quando se precisa voltar a posição anterior
        nos casos de índices que permite chaves repetidas.
  }
Var
  WNrCurrent  : Longint;
  wKeyCurrent : TaKeyStr;
Begin
  KeyCurrent  := AnsiUpperCase(RemoveAccents(KeyCurrent));
  wKeyCurrent := KeyCurrent;
  FindKey(datFIx ,WNrCurrent,KeyCurrent);
  If ok Then
  If (Not datFIx.AllowDuplKeys) And (NrCurrent <> WNrCurrent)
  Then Repeat //Sicroniza a posição da chave
         ok := NextKey (datFIx ,WNrCurrent,KeyCurrent);
         Ok := ok and (WKeyCurrent = AnsiUpperCase(RemoveAccents(KeyCurrent)));

       Until (NrCurrent=WNrCurrent) or Not ok;
  Result := ok;
End;

class function TTb_access. UpperCase(str:AnsiString):AnsiString;
var
  i : Integer;
begin
  Result := AnsiUpperCase(Str);
end;

class function TTb_access. FMinuscula(str:AnsiString):AnsiString;
var
  i:Integer;
  S : tString;
begin
  if str <> ''
  Then Begin
        {Mantém a primeira letra em Maiuscula}
        S := AnsiUpperCase(copy(Str,1,1));
        if length(str)>1
        then Begin
              Result := Copy(str,2,length(str)-1);
              Result := s + AnsiLowerCase(Result);
             end
        Else Result := s;
       End
  Else Result := '';
end;

{class function TTb_access. FMinuscula(str:AnsiString):AnsiString;
var
  i:Integer;
begin
  if str <> '' Then
  Begin
    //Mantem a primeira letra em Min�scula
    If (Byte(Str[1]) > 96) And (Byte(Str[1]) <= 123) Then
      str[1] := AnsiChar(Byte(str[1])-32);

    for i:= 2 to Length(str) do
      If Byte(str[i]) in [65..90] then
        str[i] := AnsiChar(Byte(str[i])+32);
  End;
  FMinuscula := str;
end;}


class function TTb_access. FExisteCodigo (Var IxF:IndexFile;Const Codigo:tString):Boolean;
Var NRec    : Longint;
    WCodigo : tString;
Begin
  If Is_TFileOpen(IxF.dataF.F) Then
  Begin
    WCodigo := UpperCase(Codigo);
    SearchKey(IxF,NRec,WCodigo);
    FExisteCodigo := ok And (Codigo=Copy(WCodigo,1,Byte(Codigo[0])));
  End
  Else
    FExisteCodigo := False;

End;

class function TTb_access.GetRec(var DatF : DataFile;Const R : Longint;var Buffer ):Boolean;
BEGIN
  Try {Finally}
    If DatF.F <> nil
    Then begin
           ok := DatF.F.GetRec(R,Buffer)=0
    end
    Else Begin
           TaStatus := ErroArquivoFechado;
           Raise TException.Create7('',
                        'Tb_Access.Pas',
                        'TTb_access',
                        'GetRec',
                        DatF.Filename,
                        '',
                        TaStatus);
         End;

  Finally
    Result := ok;
  end;
END; { GetRec }

class function TTb_access.GetRecBlock(VAR DatF   : DataFile; Const R : LONGINT; delta:Word;Var BlocksRead:Word ;VAR Buffer  ):Boolean;
BEGIN
  Try {Finally}
    BlocksRead :=  DatF.F.BLOCKREAD(R,Buffer,Delta);
    Ok := (TaStatus = 0 ) and (BlocksRead=Delta);
    if Not ok
    then begin
           Raise TException.Create7('',
                        'Tb_Access.Pas',
                        'TTb_access',
                        'GetRecBlock',
                        DatF.Filename,
                        '',
                        TaStatus);
         end;

  Finally
    Result := ok;
  End;

END; { GetRec }

class function TTb_access.PutRec(var DatF : DataFile;Const R : Longint;var Buffer;Const Transaction_Current : T_TTransaction):Boolean;
  Var
    aTempoDeTentativas : Longint;
    ClockBegin         : DWord;
//    _Progress1Passo    : TProgressDlg_If;
    Wok_Set_Transaction : Boolean;

BEGIN
  Try {Except}
    Try {Finally}
      SetTransaction(true,OK,Wok_Set_Transaction);
      If ok And OkTransaction and (Transaction<>nil) and (Not OkCreateTransaction)
      Then Begin
             If  ok_Set_Transaction and (Not DatF.OkTemporario)
             Then Begin
                    If (Transaction_Current <>  Tra_AddRec) {(R < FileSize(DatF)) and ok}
                    Then Begin {esta alterando o arquivo}
                           ok := GetRec(DatF,R,Transaction.RecordBufPtr^);
                           If ok
                           Then ok := Transaction.DbTra_AddRec(DatF,R,Transaction.RecordBufPtr^,Transaction_Current);
                           If Not ok
                           Then Begin
                                  PutRec := ok;
                                  Raise TException.Create7('',
                                                            'Tb_Access.Pas',
                                                            'TTb_access',
                                                            'PutRec',
                                                            DatF.Filename,
                                                            '',
                                                            TaStatus);
//                                  Abort;
                                End;
                         end
                    else Begin {Esta expandindo o arquivo}
                           If ok
                           Then ok := Transaction.DbTra_AddRec(DatF,R,Buffer,Transaction_Current);

                           If Not ok
                           Then Begin
                                  PutRec := ok;
                                  Raise TException.Create7('',
                                                            'Tb_Access.Pas',
                                                            'TTb_access',
                                                            'PutRec',
                                                            DatF.Filename,
                                                            '',
                                                            TaStatus);
//                                  Abort;
                                End;
                         End;
                  End;
           End;

      If ok
      Then Begin
             Ok := DatF.F.PutRec(R,Buffer) = 0;
             IF Not ok
             THEN Raise TException.Create7('',
                                           'Tb_Access.Pas',
                                           'TTb_access',
                                           'PutRec',
                                           DatF.Filename,
                                           '',
                                           TaStatus);
             //Abort;
           End;

  Finally
    Result := ok;
{$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função _PutRec().'}
  { DONE 1 -oVersão.9.36.26.3013>Classe.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
   � PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função _PutRec().
       � CAUSA:
           � As vezes um índice fica Inconsistente.
       � SOLUÇÃO:
           � Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
  }
     SetTransaction(False,Result,Wok_Set_Transaction);
  End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create7('',
                            'Tb_Access.Pas',
                            'TTb_access',
                            '_PutRec',
                            DatF.Filename,
                            '',
                            TaStatus);

  end;

{$ENDREGION}
//==========================================================================================================




END; { _PutRec }

class function TTb_access. PutRec(var DatF : DataFile;Const R : Longint;var Buffer  ):Boolean;
Begin
  Result := PutRec(DatF,R,Buffer,Tra_PutRec);
  IF Result and FlushBuffer
  THEN Result := FlushFile(DatF);
End;


class function TTb_access. MakeFile(var DatF : DataFile;Const FName : FileName;Const RecLen : SmallWord):Integer;
  Var
    Wok_Set_Transaction : Boolean;
BEGIN
  try //Except
    Try //Finally
      TaStatus := 0;
//      SetTransaction(true,OK,Wok_Set_Transaction);  Não posso colocar makefile pq a transação Não controle arquivos deletados.
      If (Not Is_TFileOpen(DatF.F)) //and ok
      Then Begin
              AssignDataFile(DatF,FName,RecLen,RecLen);

              //fmOpenReadWrite,fmShareCompat or fmShareDenyNone
              DatF.F.Rewrite(fmOpenReadWrite,fmShareCompat or fmShareDenyNone);

              TaStatus := DatF.F.ErrorInfo;
              ok := TaStatus = 0;


              IF TaStatus <>0
              THEN BEGIN
                     TaIOcheck(DatF,0);
                     Discard(TObject(DatF.F));
                     //abort;
                     Raise TException.Create7('',
                                           'Tb_Access.Pas',
                                           'TTb_access',
                                           'MakeFile',
                                           DatF.Filename,
                                           '',
                                           TaStatus);
                   End;

              IF RecLen > MaxDataRecSize
              THEN Begin
                     TaStatus := REC_TOO_LARGE;

                     TAIOCheck(DatF, 0);
                     Discard(TObject(DatF.F));
                     //abort;
                     Raise TException.Create7('',
                                           'Tb_Access.Pas',
                                           'TTb_access',
                                           'MakeFile',
                                           DatF.Filename,
                                           '',
                                           TaStatus);
                   End;

              IF RecLen < MinDataRecSize
              THEN Begin
                     TaStatus := REC_TOO_SMALL;

                     TAIOCheck(DatF, 0);
                     Discard(TObject(DatF.F));
                     //Abort;
                     Raise TException.Create7('',
                                           'Tb_Access.Pas',
                                           'TTb_access',
                                           'MakeFile',
                                           DatF.Filename,
                                           '',
                                           TaStatus);
                   End;

              FilesOpens.Insert(@DatF);
              ok := WriteHeaderMakeFile(DatF);

              If Not ok
              Then //Abort;
                    Raise TException.Create7('',
                                                 'Tb_Access.Pas',
                                                 'TTb_access',
                                                 'MakeFile',
                                                 DatF.Filename,
                                                 '',
                                                 TaStatus);
           End
      Else Begin
             If TaStatus = 0
             Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;


             TAIOCheck(DatF, 0);
             //abort;
             Raise TException.Create7('',
                                           'Tb_Access.Pas',
                                           'TTb_access',
                                           'MakeFile',
                                           DatF.Filename,
                                           '',
                                           TaStatus);
           End;

    Finally
      If TaStatus <> 0
      Then  Mi_MsgBox.MessageBox(TStrError.ErrorMessage7('',
                                                        'Tb_Access',
                                                        'TTb_access',
                                                        'MakeFile',
                                                        FName,
                                                        '',
                                                       TaStatus));
      Result := TaStatus;
      Ok := Result = 0;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeFile().'}
    { DONE 1 -oVersão.9.36.26.3013>Classe.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.

    - PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeFile().
        - CAUSA:
          - As vezes um índice fica Inconsistente.

        -  SOLUÇÃO:
           - Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//        SetTransaction(False,OK,Wok_Set_Transaction);
      End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create7('',
                            'Tb_Access.Pas',
                             'TTb_access',
                             'MakeFile',
                             FName,
                             '',
                             TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { MakeFile }



class function TTb_access. FDelStrBrancos(S:tString):tString;
Begin
  While (Pos(' ',S) <> 0) and (S<>'') Do
    Delete(S,Pos(' ',S),1);
  FDelStrBrancos := S;
End;




{: Retorna o codigo do error se houver
}
class function TTb_access.GetTempDir(Const env:tString;Var path:PathStr):SmallInt;
   var Dir: DirStr;
   var Name: NameStr;
   var Ext: ExtStr;
Begin
  taStatus := 0;
  FSplit(ParamStr(0),Dir,Name,Ext);
  Path := GetEnv(env);
  Path := FExpand(Path)+PathDelim+Name+PathDelim;
  ok   := DirectoryExists(Path);
  IF Not ok
  Then Begin
         {Path := 'c:\temp';}
         ok := CreateDir(Path);
       end;
  Result := taStatus;
end;

{: Cria arquivo temporário }
class function TTb_access.FileNameTemp_Ext(const aPath:PathStr;
                                           Var NomeArqTemp : PathStr;
                                           const Extencao : PathStr):Boolean;overload;
{$I-}
 // Esta função tempo como finalidade: Criar arquivo com nome sugerido pelo DOS
  Var
    dir    : PathStr;
Begin
  Delay(100); //Dar um tempo para que gere nomes diferentes
  if aPath<>''
  then dir := aPath
  Else Begin
         {$IFDEF WINDOWS}
            If GetTempDir('Temp',dir)<>0
            Then Raise TException.Create7('',
                                          'Tb_Access.Pas',
                                          'TTb_access',
                                          'FileNameTemp_Ext',
                                          dir,
                                          '',
                                          TaStatus);
         {$ELSE}
           If GetTempDir('HOME',dir)<>0
           Then Raise TException.Create7('',
                                         'Tb_Access.Pas',
                                         'TTb_access',
                                         'FileNameTemp_Ext',
                                         dir,
                                         '',
                                         TaStatus);

         {$ENDIF}
      End;

  NomeArqTemp := GetTempFileName(dir);
  Ok := TaStatus = 0;
  If ok
  Then Begin
         If Extencao <> ''
         Then Begin
                NomeArqTemp := UpperCase(FTrocaExtencao(NomeArqTemp,Extencao));
              end;
       End;
  Result := Ok;
End;

{ Cria arquivo temporário }
class function TTb_access.FileNameTemp_Ext(Var NomeArqTemp : PathStr;const Extencao : PathStr):Boolean;overload;
Begin
  Result :=  FileNameTemp_Ext('',NomeArqTemp,Extencao);
End;

class function TTb_access. FileNameTemp(const Extencao : PathStr):PathStr; { Cria arquivo temporario }
Begin
  If Not FileNameTemp_Ext(Result,Extencao)
  Then Result := '';
end;


class function TTb_access. IsPortLocal(WPort : tString):Boolean;
Begin
  WPort := UpperCase(wPort);
  Result := (wPort = 'PRN') or
            (wPort = 'LPT1') or
            (wPort = 'LPT2') or
            (wPort = 'LPT3') or
            (wPort = 'LPT4') or
            (wPort = 'COM1') or
            (wPort = 'COM2') or
            (wPort = 'COM3') or
            (wPort = 'COM4');
end;

class function TTb_access. DelFile( Const Nome : NameStr):Boolean;
{Se o arquivo Não existe delFile deve retornar verdadeiro}
  Var StrError:tString;
begin
  If IsPortLocal(nome)
  Then Begin
         TaStatus := 0;
         Ok := TaStatus = 0;
         Result := ok;
         exit;
       end;

  If  FileExists(Nome)
  Then Begin
         TaStatus := DeleteFile(Nome);
         If TaStatus<> 0 Then
         Begin
           Ok := false;
           Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'DelFile',
                                   nome,
                                   '',
                                   TaStatus);

         End;
         Ok := TaStatus = 0;
       End
  Else Ok := True;

  Result := ok;
 End;


class function TTb_access. FileName_Seq(Const aName:NameStr;Const aExt : ExtStr):PathStr;
  {
    Recebe:
      aName : Nome de um arquivo valido.
      aExt  : deve ter no máximo 2 caracter identificando o tipo de arquivo

    Retorna:
      Nome de um arquivo com a extensão 001,002 ... 999
      desde que Não existe no disco.
  }

  Var
    Dir  : DirStr;
    Name : NameStr;
    Ext  : ExtStr;
    i    : integer;
    Template : tString;
    Max  : integer;
Begin
  Template := ConstStr(3-length(aExt),'I');
  case length(Template) of
    3 : Max := 999;
    2 : Max := 99;
    1 : Max := 9;
    else Begin
           Tastatus  := ParametroInvalido;
           Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'FileName_Seq',
                                   aName,
                                   '',
                                   TaStatus);
         End;
  end;
  TaStatus := 0;

  FSplit(FExpand(aName),Dir,Name,Ext);
  i := 0;

  While i <= Max do
  Begin
    If Not FileExists(dir+Name+'.'+aExt+IStr(I,Template))
    Then Begin
           TaStatus := 0;
           FileName_Seq := dir+Name+'.'+aExt+ IStr(I,Template);
           exit;
         end;
    inc(i)
  end;

  Raise TException.Create7('',
                           'Tb_Access.Pas',
                           'TTb_access',
                           'FileName_Seq',
                           aName,
                           '',
                           'Não posso criar nome do arquivo '+dir+Name+'.'+aExt+ IStr(I,Template)+
                           ' por que todos os nome já foram gerados e estão no disco!.');

  TaStatus     := 2;
  FileName_Seq := '';
end;



class function TTb_access. SetOkAddRecFirstFree(Const aOkAddRecFirstFree: Boolean):Boolean;
Begin
  SetOkAddRecFirstFree := OkAddRecFirstFree;
  OkAddRecFirstFree    := aOkAddRecFirstFree;
End;


class function TTb_access. TestaSePodeAbrirArquivo(Const FName  : PathStr): Byte;
{$F+}
{Retorna
   0 se o arquivo existe e Não foi aberto no modo exclusivo
   TaStatus se o arquivo existe e Não pode ser aberto.
}
  Var
    F : file of Byte;
Begin
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TestaSePodeAbrirArquivo',ListaDeChamadas);{$ENDIF}
  If FileExists(FName) Then
  Begin
    AssignFile(F,FName);
    If System.IoResult <> 0 Then;
    {$I-} System.Reset(F); {$I+}

    If (IoResult = 0) Then
    Begin
      {$I-} System.Close(f);{$I+}
      If System.IoResult <> 0 Then;
    End;
  End;

  TestaSePodeAbrirArquivo := TaStatus;


End;

class function TTb_access. FileShared(Const FName  : PathStr) : Boolean;
Begin
  TaStatus := TestaSePodeAbrirArquivo(FName);
  If TaStatus In [0,ArquivoNaoEncontrado2,ArquivoNaoEncontrado18] Then
  Begin
    ok := True; // Sem erro ou o arquivo Não existe portanto pode ser criado
  End
  Else
  If TaStatus in [AcessoNegado5,
                  AcessoNegado32,
                  ErroViolacaoDeLacre{,
                  ErroFaltaHardware}]
  Then
  Begin
    Ok := False;  // Acesso negado ao arquivo
  End
  Else
  Begin
    with Mi_MsgBox do
      MessageBox(TStrError.ErrorMessage7('','Tb_Access','TTb_access','FileShared',Fname,'',TaStatus));

    Ok := false;
  End;
  FileShared := Ok ;

End;

class function TTb_access.FileSize(VAR DatF : DataFile):Longint;
Begin
  If (DatF.F <> nil) and DatF.F.IsFileOpen
  Then Result := DatF.F.FileSize
  Else Result := 0;
End;



class function TTb_access. FTrocaExtencao(Const NomeArq:NameStr; Extencao:PathStr) : PathStr;
  {g:\GCIC.Tb\estoque\inclient}
Var
  Dir           : DirStr;
  Name          : NameStr;
  Ext           : ExtStr;
Begin
  While Pos('.',Extencao) <> 0
  do delete(extencao,Pos('.',Extencao),1);

  If Extencao <> ''
  Then Begin
         FSplit(NomeArq,Dir,name,Ext);
         Result := Dir+name+'.'+Extencao;
       End
  Else Result := NomeArq;
End;

class function TTb_access.Ren(NomeFonte,NomeDestino: PathStr) : Boolean;
{ Renomeia Arquivos }
var
  F : file;
begin
  Try
    Ok := False;

//    {$IFDEF TaDebug} Application.Push_MsgErro('Tb_Access.pas',ListaDeChamadas);{$ENDIF}

{    While Pos(' ',NomeFonte) <> 0
    do Delete(NomeFonte,Pos(' ',NomeFonte),1);

    While Pos(' ',NomeDestino) <> 0
    do Delete(NomeDestino,Pos(' ',NomeDestino),1);}


    If UpperCase(NomeFonte) = UpperCase(NomeDestino)
    Then Begin
           Raise TException.Create7('',
                                'Tb_Access.Pas',
                                 'TTb_access',
                                 'Ren',
                                   'Fonte='+NomeFonte+' ,Destino='+NomeDestino,
                                   '',
                                   'Não posso renomear, porque o arquivo "fonte" igual ao "destino"!.');
         end;

    If Not FileExists(NomeFonte)
    Then Raise TException.Create7('',
                                'Tb_Access.Pas',
                                 'TTb_access',
                                 'Ren',
                                 'Fonte='+NomeFonte+' ,Destino='+NomeDestino,
                                 '',
                                 'Nao posso renomear, porque o arquivo de origem Não existe!.')
    Else
    If FileExists(NomeDestino)
    then Raise TException.Create7('',
                                'Tb_Access.Pas',
                                 'TTb_access',
                                 'Ren',
                                 'Fonte='+NomeFonte+' ,Destino='+NomeDestino,
                                 '',
                                 'Nao posso renomear, porque o arquivo destino já existe!.')
    Else
    Begin
      ok :=  RenameFile (NomeFonte,NomeDestino);

      If Not Ok
      then Raise TException.Create7('',
                                'Tb_Access.Pas',
                                 'TTb_access',
                                 'Ren',
                                 'Fonte='+NomeFonte+' ,Destino='+NomeDestino,
                                 '',
                                 TaStatus);
    End;

  Finally
    Result := Ok;

  End;
end;

/// <since>
///   . OkItemSize
///   . Retorna true se o Tamanho do registro em arquivo > tamanho do buffer do registro em Memória.
/// </since>
class function TTb_access. OkRecSizeMismatch(Const FName  : FileName;Const RecLenBufferRecord : SmallWord):Boolean;
Begin
  Result :=   FTamRegDataFile(FName) > RecLenBufferRecord;
End;


class function TTb_access. OpenFile(var DatF     : DataFile;
                                    Const FName  : FileName;
                                    Const RecLen : SmallWord):Integer;
    Var    Wok_Set_Transaction : Boolean;

BEGIN
  try //Except
    Try {Finally}

//      SetTransaction(true,OK,Wok_Set_Transaction); Não posso inicializa transação aqui porque esta rotina e chamada por rollback. Transferido para TOpenFile
      If (Not Is_TFileOpen(DatF.F)) //and ok
      Then BEGIN
             If (RecLen > FileSize(FName)) and ( FileSize(FName)>0)
             Then Begin
                    ModifyStructurFile(FName,RecLen);
                    AssignDataFile(DatF,FName,RecLen,RecLen,nil,DatF.Tipo);
                    DatF.OkDeveIndexar := true;
                  end
             Else AssignDataFile(DatF,FName,RecLen,RecLen,nil,DatF.Tipo);


             DatF.f.Reset(FileMode,shareMode);
             ok := TaStatus = 0;

             IF TaStatus<>0
             THEN BEGIN
                     TaIOcheck(DatF,0);
                     Discard(TObject(DatF.F));
                     Abort;
                   END;

             IF RecLen > MaxDataRecSize
             THEN Begin
                     TaStatus := REC_TOO_LARGE;
                     Discard(TObject(DatF.F));
                     Abort;
                  End;

             IF RecLen < MinDataRecSize
             THEN Begin
                     TaStatus := REC_TOO_SMALL;
                     Discard(TObject(DatF.F));
                     Abort;
                  End;
             FilesOpens.Insert(@DatF);

             Repeat
                CtrlSleep(0);
                ok := ReadHeader(DatF);

                If (Not ok) And (TaStatus=0)
                Then TaStatus := ErroDeLeituraEmDisco;


                If ok Then
                Begin
                  ok := RecLen = DatF.ItemSize;
                  If Not ok Then
                  Begin
                    If RecLen < DatF.ItemSize
                    Then Begin
                           TaStatus := RecSizeMismatch;
                           TAIOCheck(DatF, 0);
                           Discard(TObject(DatF.F));

                           Raise TException.Create7('',
                                                    'Tb_Access.Pas',
                                                    'TTb_access',
                                                    'OpenFile',
                                                    DatF.FileName,
                                                    '',
                                                    TaStatus);
                         End
                    Else If (DatF.ItemSize >= MinDataRecSize) and
                            (DatF.ItemSize <= MaxDataRecSize)
                         Then Begin { Ajusta o tamanho do arquivo }
                                CloseFile(DatF);
                                {So tem sentido ser o novo registro for maior que o anterior }
                                If ModifyStructurFile(FName,RecLen)
                                Then Begin
                                       DatF.OkDeveIndexar := true;
                                       TaStatus := OpenFile(DatF,FName,RecLen);
                                       If TaStatus<>0
                                       Then Begin
                                              TAIOCheck(DatF, 0);
                                              Abort;
                                            End;
                                     End
                                Else Begin
                                       TAIOCheck(DatF, 0);
                                       Abort;
                                     end;
                              End
                         else Begin
                                TaStatus := Estrutura_da_tabela_esta_danificada;
                                TAIOCheck(DatF, 0);
                                Discard(TObject(DatF.F));
                                Abort;
                              End;
                  End;
                End
                Else
                BEGIN
                  TAIOCheck(DatF, 0);
                  ok := false;
                END;
              until ok;
           END
      ELSE Begin
             If TaStatus = 0
             Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
             Abort;
           End;

    Finally
      Result := TaStatus;
      ok := Result = 0;

      If TaStatus <>0
      Then  Raise TException.Create7('',
                                     'Tb_Access.Pas',
                                     'TTb_access',
                                     'OpenFile',
                                     DatF.FileName,
                                     '',
                                     TaStatus);
    End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'OpenFile',
                             DatF.FileName,
                             '',
                             TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { OpenFile }

class function TTb_access. ReadHeader(VAR DatF   : DataFile):Boolean;
BEGIN
  WITH DatF DO
  BEGIN
    Ok := GetRec(DatF,0,TaRecBuf^);
    If ok
    Then Begin
           MOVE(TaRecBuf^,DatF.FirstFree,FileHeaderSize);
           WITH DatF DO MOVE(DatF.FirstFree,IH.FirstFree,FileHeaderSize);
         End;
    DatF.NumRec := DatF.f.FileSize;
  END;
  ReadHeader := ok;
END; { ReadHeader }

class function TTb_access. PutFileHeader(VAR DatF : DataFile):Boolean;
BEGIN
  Try
    If (DatF.F<>nil)
    Then Begin
           MOVE(DatF.FirstFree,TaRecBuf^,FileHeaderSize);
           MOVE(DatF.FirstFree,DatF.IH.FirstFree,FileHeaderSize);
           ok := PutRec(DatF,0,TaRecBuf^,Tra_PutRec);
         End
    Else If TaStatus = 0
         Then TaStatus := ErroArquivoFechado;

  Finally
    Result := TaStatus = 0;
  End;
END; { PutFileHeader }

class function TTb_access. NaoMudouHeader(VAR DatF : DataFile) : BOOLEAN;
VAR DF : DataFile;
BEGIN
  With DatF do
  Begin
    GetRec(DatF,0,TaRecBuf^);
  End;

  MOVE(TaRecBuf^,DF.FirstFree,FileHeaderSize);
  NaoMuDOuHeader  := (Df.FirstFree  = DatF.FirstFree ) And
                     (Df.NumberFree = DatF.NumberFree) And
                     (Df.RR{Int1 }      = DatF.RR{Int1}      ) And
                     (Df.ItemSize   = DatF.ItemSize  );
END;

class function TTb_access. MudouHeaderEmMemoria(VAR DatF : DataFile) : BOOLEAN;
BEGIN
  MuDOuHeaderEmMemoria := Not (
                             (DatF.IH.FirstFree  = DatF.FirstFree ) And
                             (DatF.IH.NumberFree = DatF.NumberFree) And
                             (DatF.IH.RR{Int1}       = DatF.RR{Int1}      ) And
                             (DatF.IH.ItemSize   = DatF.ItemSize  ) And
                             (DatF.IH.NumberKey  = DatF.NumberKey )
                             );
END;

class function TTb_access. aCloseFile(VAR DatF : DataFile):boolean;
BEGIN
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.aCloseFile',ListaDeChamadas);{$ENDIF}
    TaStatus := 0;
    If (DatF.F <> nil) and DatF.F.IsFileOpen Then
    BEGIN

      IF MudouHeaderEmMemoria(DatF)
      THEN ok := PutFileHeader(DatF)
      Else ok := true;

      If ok Then
      Begin
        Discard(TObject(DatF.F));
      End;
    END
    Else ok := true;

  Finally
    aCloseFile := ok;

  End;
END; { CloseFile }



class function TTb_access. CloseFile(VAR DatF : DataFile;OkCondicional:Boolean):boolean;Overload;

   function _CloseFile:Boolean;
   Begin
     If (FilesOpens <> nil) And (FilesOpens.IndexOf(@DatF) <> -1)
     Then Begin
             FilesOpens.Free(@DatF);
             Result := ok;
           end
     Else Result := aCloseFile(DatF);
   end;

BEGIN
  Try
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.CloseFile',ListaDeChamadas); {$ENDIF}
    TaStatus := 0;
    If Is_TFileOpen(DatF.F)
    Then Begin
           If OkCondicional
           Then Begin
                  If DatF.F.GetDriveType <> dt_Memory_Stream
                  Then Result := _CloseFile;
                End
           Else Result := _CloseFile;
         End
    Else Result := true;

  Finally


  End;
END; { CloseFile }

class function TTb_access.CloseFile(VAR DatF : DataFile):boolean;
Begin
  CloseFile(DatF,False) ;
  result := ok;
end;

class function TTb_access. FlushFile(VAR DatF : DataFile):Boolean;
  var
    Wok : Boolean;  {O flush na deve alterar o fluxo normal visto que ele s� avisa DOS que descarregue os buffers}
BEGIN
  Try
    Wok := ok;
    TaStatus := 0;
    If Is_TFileOpen(DatF.F) Then
    Begin
      IF MudouHeaderEmMemoria(DatF)
      THEN Begin
             Result := PutFileHeader(DatF);
             If Not Result Then exit;
      end
      else Result := true;
      If Result  {and (FlushBuffer or Not DatF.FileModeDenyALL)}
      Then Begin
             DatF.F.Flush;
             Result := TaStatus = 0;
           end;
    End
    else Begin
           TaStatus := ErroArquivoFechado;
           Result := False;
           Raise TException.Create7('',
                         'Tb_Access.Pas',
                         'TTb_access',
                         'FlushFile',
                         DatF.FileName,
                         '',
                         TaStatus);
         End;

 Finally
   ok := Wok;
 end;
END; { FlushFile }


class function TTb_access. TraveRegistro(VAR  DatF : DataFile; Const R : LONGINT):Boolean;
  {: A trave de um registro em particular só tem sentido caso o sistema não
     esteja dentro de uma transação.}
Var
  ok                 : Boolean;
BEGIN
  Result := true;
  //Try
  //  If (Not DatF.FileModeDenyALL) and (not ok_Set_Transaction)
  //  Then Begin
  //         Ok := DatF.F.Lock(R,1);
  //       End
  //  Else Ok := True;
  //
  //Finally
  //  Result := ok;
  //End;
END;

class function TTb_access. DestraveRegistro(Var  DatF : DataFile;Const R : Longint):Boolean;
  {: A trave de um registro em particular só tem sentido caso o sistema não
     esteja dentro de uma transação.}

Var
  ok : Boolean;
Begin
  Result := true;
//  Try
////    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.DestraveRegistro',ListaDeChamadas);{$ENDIF}
//    If (Not DatF.FileModeDenyALL) and (not ok_Set_Transaction)
//    Then ok := DatF.F.UnLock(R,1)
//    Else Ok := True;
//  Finally
//    DestraveRegistro := ok;
//
//  End;
End;

class function TTb_access. TraveHeader(VAR DatF : DataFile):Boolean;
  {: A trave de um registro em particular só tem sentido caso o sistema não
     esteja dentro de uma transação.}

BEGIN
  result := true;
  //IF (NOT DatF.FileModeDenyALL) and (not ok_Set_Transaction)
  //THEN Ok := DatF.F.Lock(0,1)
  //Else Ok := True;
  //TraveHeader := ok;
END;

class function TTb_access. DestraveHeader(VAR DatF : DataFile):Boolean;
  {: A trave de um registro em particular só tem sentido caso o sistema não
     esteja dentro de uma transação.}

BEGIN
  result := true;
  //IF (NOT DatF.FileModeDenyALL) and (not ok_Set_Transaction)
  //THEN Result := DatF.F.UnLock(0,1)
  //Else Result := True;

END;


class procedure TTb_access. NewRec(VAR DatF  : DataFile;VAR R     : LONGINT  );
BEGIN

  IF (DatF.FirstFree = -1) or
     (DatF.FirstFree = 0) or
     (not DatF.OkAddRecFirstFree)
  THEN
  BEGIN //Adiciona no final do arquivo
    IF DatF.FirstFree = 0 THEN
       DatF.FirstFree := -1; { Obs. Eu }

{     DatF.NumRec := FileSize(DatF); Esta instrução gera error 202 = starck overflow}
     R := DatF.NumRec;
     Inc(DatF.NumRec);

{    R := FileSize(DatF.f);
    DatF.NumRec := R+1;}
  END
  ELSE BEGIN
     R := DatF.FirstFree;
     GetRec(DatF,R,TaRecBuf^);
     DatF.FirstFree := TaRecBuf^.I;
     Dec(DatF.NumberFree);
  END;
END; { NewRec }

class function TTb_access. AddRec(var DatF : DataFile;var R  : Longint;var Buffer ):Boolean;
  VAR
    Wok_Set_Transaction : Boolean;
BEGIN
  try //Except
    Try
  //    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.AddRec',ListaDeChamadas); {$ENDIF}

  {    If OkTransaction and (Transaction<>nil) and (not ok_Set_Transaction) Then
      Begin
        If Transaction.TransactionPendant=0
        Then Transaction.Rollback
        else Begin
               Transaction.DatF.Close;
               ok := true;
             end;

        If Not ok
        Then Begin
               AddRec := ok;
               exit;
             end;
      End;}
      SetTransaction(true,OK,Wok_Set_Transaction);
      if ok
      then begin
              IF (NOT DatF.FileModeDenyALL)
              THEN BEGIN
                     IF NOT DatF.Exclusivo
                     THEN ok := TraveHeader(DatF)
                     Else ok := true;
                     If ok Then ok := ReadHeader(DatF);
              END else ok := true;

              If ok
              Then Begin
                     NewRec(DatF,R);
                     IF (NOT DatF.FileModeDenyALL)
                     THEN BEGIN
                            LONGINT(Buffer) := 0;
                            If (R = fileSize(DatF)) and ok
                            Then ok := PutRec(DatF,R,Buffer,Tra_AddRec)
                            else If ok
                                 Then ok := PutRec(DatF,R,Buffer,Tra_PutRec);
                            If ok
                            Then ok := PutFileHeader(DatF);

                            IF ok and FlushBuffer
                            THEN ok := FlushFile(DatF);


                            IF ok and NOT DatF.Exclusivo
                            THEN ok := DestraveHeader(DatF);
                          END
                     ELSE Begin
                            LONGINT(Buffer) := 0;

                            If (R = fileSize(DatF)) and ok
                            Then ok := PutRec(DatF,R,Buffer,Tra_AddRec)
                            else If ok
                                 Then ok := PutRec(DatF,R,Buffer,Tra_PutRec);

                            IF ok and FlushBuffer
                            THEN ok := FlushFile(DatF);
                          End;
                   End;
      end;

    Finally
      Result := ok;
      SetTransaction(False,OK,Wok_Set_Transaction);
    End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create7('',
                         'Tb_Access.Pas',
                         'TTb_access',
                         'AddRec',
                          DatF.FileName,
                          format('%d',[R]),
                         TaStatus);
  end;

END; { AddRec }


class function TTb_access.DeleteRecord(VAR  DatF : DataFile; Const  R : LONGINT; Var Buffer ):Boolean;
  VAR
    FirstFreeAux : LONGINT;
    Wok_Set_Transaction : Boolean;
BEGIN
  Try//Except
    Try //Finally
      SetTransaction(true,OK,Wok_Set_Transaction);
      if Ok
      then Begin
              IF (NOT DatF.FileModeDenyALL) THEN
              BEGIN
                IF NOT DatF.Exclusivo THEN
                  ok := TraveHeader(DatF)
                Else
                  ok := true;
                If ok Then
                  ok := ReadHeader(DatF);

                If ok and (Longint(Buffer) = 0) Then
                Begin
                  FirstFreeAux         := DatF.FirstFree;
                  DatF.FirstFree       := R;
                  Inc(DatF.NumberFree);
                  Longint(Buffer):= FirstFreeAux;
                  ok := PutRec(DatF,R,Buffer,Tra_DeleteRec);
                  If ok Then
                    ok := PutFileHeader(DatF);
                End
                Else
                  If (Longint(Buffer) <> 0) Then
                  Begin
                    IF NOT DatF.Exclusivo THEN
                    DestraveHeader(DatF);

                    TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
                    Ok := false;
                    Raise TException.Create7('',
                                             'Tb_Access.Pas',
                                             'TTb_access',
                                             'DeleteRecord',
                                              DatF.FileName,
                                              Format('%d',[R]),
                                             TaStatus);

                  End;

                IF NOT DatF.Exclusivo THEN
                  DestraveHeader(DatF);
              END
              ELSE
              BEGIN
                If Longint(Buffer) = 0 Then
                Begin
                  FirstFreeAux    := DatF.FirstFree;
                  DatF.FirstFree  := R;
                  Inc(DatF.NumberFree);
                  Longint(Buffer) := FirstFreeAux;
                  ok := PutRec(DatF,R,Buffer,Tra_DeleteRec);
                End
                Else
                Begin
                  TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
//                  Application.Mi_MsgBox.MessageBox(StrMessageBox('LibAccess','DeleteRecord',DatF.F.FileName,TaStatus));
                  Ok := false;
                  Raise TException.Create7('',
                                           'Tb_Access.Pas',
                                           'TTb_access',
                                           'DeleteRecord',
                                            DatF.FileName,
                                            Format('%d',[R]),
                                           TaStatus);

                End;
              END;
      End;

  Finally
    IF ok and FlushBuffer
    THEN ok := FlushFile(DatF);
    Result := ok;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteRecord().'}
    { DONE 1 -oVersão.9.36.26.3013>Classe.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     - PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função DeleteRecord().
         - CAUSA:
             - As vezes um índice fica Inconsistente.
         - SOLUÇÃO:
             - Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
       SetTransaction(False,OK,Wok_Set_Transaction);
     End;

  Except
    If Wok_Set_Transaction
    Then Rollback;

    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'DeleteRecord',
                              DatF.FileName,
                              Format('%d',[R]),
                             TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================
END; { DeleteRec }


class function TTb_access.DeleteRec(var DatF : DataFile;Const R: Longint):Boolean;
  VAR
    FirstFreeAux : LONGINT;
    Wok_Set_Transaction : Boolean;
BEGIN
  Try//Except
    Try //Finally
      SetTransaction(true,OK,Wok_Set_Transaction);
      if Ok
      then Begin
              IF (NOT DatF.FileModeDenyALL)
              THEN BEGIN
                      IF NOT DatF.Exclusivo
                      THEN ok := TraveHeader(DatF)
                      Else Ok := true;

                      If ok Then ok := ReadHeader(DatF);
                      If ok Then ok := GetRec(DatF,R,TaRecBuf^); {Salva o antigo}

                      If ok and (TaRecBuf^.I = 0)
                      Then Begin
                              FirstFreeAux         := DatF.FirstFree;
                              DatF.FirstFree       := R;
                              Inc(DatF.NumberFree);
                              TaRecBuf^.I          := FirstFreeAux;
                              ok := PutRec(DatF,R,TaRecBuf^,Tra_DeleteRec);
                              If Ok Then ok := PutFileHeader(DatF);
                           End
                      else If ok and (TaRecBuf^.I <> 0)
                           Then Begin
                                  IF NOT DatF.Exclusivo
                                  THEN DestraveHeader(DatF);

                                  TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
                                  Ok := false;
                                End;

                      IF NOT DatF.Exclusivo
                      THEN DestraveHeader(DatF);
                   END
              ELSE BEGIN
                      ok := GetRec(DatF,R,TaRecBuf^); {Salva o antigo}
                      If ok and (TaRecBuf^.I = 0)
                      Then Begin
                              FirstFreeAux    := DatF.FirstFree;
                              DatF.FirstFree  := R;
                              Inc(DatF.NumberFree);
                              TaRecBuf^.I     := FirstFreeAux;
                              ok := PutRec(DatF,R,TaRecBuf^,Tra_DeleteRec);
                           End
                      else If ok and (TaRecBuf^.I <> 0)
                           Then Begin
                                  TaStatus := Erro_Tentativa_de_excluir_um_registro_excluido;
                                  Ok := false;
                                End;
                   END;
           end;

    Finally
      IF ok and FlushBuffer
      THEN ok := FlushFile(DatF);
      Result := ok;
      SetTransaction(False,OK,Wok_Set_Transaction);
    End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'DeleteRec',
                              DatF.FileName,
                              Format('%d',[R]),
                             TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { DeleteRec }

class function TTb_access.FileLen(VAR DatF : DataFile) : LONGINT;
BEGIN
  IF NOT  DatF.FileModeDenyALL THEN
    ok := ReadHeader(DatF)
  Else ok := true;

  If ok Then
    result := DatF.NumRec
  Else result := 0;
END;


class function TTb_access. UsedRecs(VAR DatF : DataFile;OK_GetHeader : Boolean) : LONGINT;
BEGIN
  IF OK_GetHeader
  THEN  ok := ReadHeader(DatF)
  Else  ok := true;

  If ok
  Then Result := {DatF.F.FileSize}DatF.NumRec - DatF.NumberFree - 1
  Else Result  := 0;
END; { UsedRecs }

class function TTb_access. UsedRecs(VAR DatF : DataFile) : LONGINT;
BEGIN
  IF DatF.FileModeDenyALL
  THEN  Result := UsedRecs(DatF,False)
  Else  Result := UsedRecs(DatF,True)
END; { UsedRecs }


Type
  PageBlock = array[0..High(Longint {SmallInt})-1] OF BYTE;

class procedure TTb_access. TaPack(VAR Page : TaPage;
                 Const
                    KeyL : BYTE);
{Se o tamanho da chave (KeyL) FOR <> DO TamMaxChave entao ???}
VAR
  I : SmallWord;
  P : ^PageBlock;

BEGIN
  P := @Page;
  IF KeyL <> MaxKeyLen THEN
    FOR I := 1 TO PageSize DO
      MOVE(Page.ItemArray[I],
           P^[(I - 1) * (KeyL + ItemOverHead) + PageOverHead],
           KeyL + ItemOverHead);
END; { TaPack }

class procedure TTb_access. TaUnpack(VAR Page : TaPage; Const     KeyL : BYTE);
{Se o tamanho da chave (KeyL) FOR <> DO TamMaxChave entao ???}
VAR
  I : SmallWord;
  P : ^PageBlock;
BEGIN
  P := @Page;
  IF KeyL <> MaxKeyLen THEN
    FOR I := PageSize DOwnTO 1 DO
      MOVE(P^[(I - 1) * (KeyL + ItemOverHead) + PageOverhead],
           Page.ItemArray[I],
           KeyL + ItemOverHead);
END; { TaUnpack }


class function TTb_access. Multiplo_Mais_proximo_de_N(Const K,N:Longint): Longint;
{Devolve o maior multiplo de N de K }
Var i,
    Wk : Longint;
Begin
  I := 0; WK := 0;
  Repeat
//    SysCtrlSleep(0);
   If ((K+i) Mod N) = 0 Then
      Wk := K+i;
    Inc(i);
  Until Wk <> 0;

  If Wk <=  Sizeof(TaStackRec)
  Then Multiplo_Mais_proximo_de_N := Wk
  Else Multiplo_Mais_proximo_de_N := K;
End;

class function TTb_access. MakeIndex(var IxF : IndexFile;Const FName : FileName;Const KeyLen,S : byte):Integer;

  VAR
    K : SmallWord;
    Wok_Set_Transaction : Boolean;

BEGIN
  Try //Except
    Try
//      SetTransaction(true,OK,Wok_Set_Transaction); //Não posso colocar MakeIndex na transação porque a transação Não controla arquivos deletados.
      If  Not Is_TFileOpen(IxF.DataF.F) //and ok
      Then Begin
             K := (KeyLen + ItemOverHead) * PageSize + PageOverhead;
  {           K := Multiplo_Mais_proximo_de_N(K,BlockSize_DatF);}

             WITH IxF,IxF.DataF DO
             BEGIN
                AssignIndexFile(IxF,FName,Sizeof(TsImagemHeader),K);
                IxF.DataF.F.Rewrite(FileMode,ShareMode);

                IF TaStatus<>0 THEN
                BEGIN
                  TaIOcheck(IxF.DataF,0);
                  Discard(TObject(IxF.DataF.F));
                  Abort;
                END;

                IF KeyLen > MaxKeyLen THEN
                Begin
                  TaStatus := KeyTOoLarge;
                  TAIOcheck(DataF, 0);
                  Discard(TObject(IxF.DataF.F));
                  Abort;
                End;

                FilesOpens.Insert(@IxF);
                WriteHeaderMakeFile(IxF.DataF);
                IxF.AllowDuplKeys := S <> NoDuplicates;
                IxF.KeyL          := KeyLen;
             END;
           End
      Else Begin
             Ok := false;
             If TaStatus=0
             Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
           end;

    Finally
      Result:= TaStatus;
      If Result=0
      Then IxF.OkDeveIndexar  := True;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeIndex().'}
    { DONE 1 -oVersão.9.36.26.3013>Classe.Metodo -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     - PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função MakeIndex().
         - CAUSA:
             - As vezes um índice fica Inconsistente.
         - SOLUÇÃO:
             - Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//       SetTransaction(false,OK,Wok_Set_Transaction);
     End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'MakeIndex',
                              IxF.DataF.FileName,
                              Format('%d',[KeyLen]),
                             TaStatus);

  end;

{$ENDREGION}
//==========================================================================================================

END; { MakeIndex }

class function TTb_access.OpenIndex(var   IxF : IndexFile;Const FName : FileName;Const KeyLen,S : byte):Integer;
  VAR
    K : Word;
    Wok_Set_Transaction : Boolean;

   function Del_Index_e_MakeIndex:Boolean;
   Begin
     Discard(TObject(IxF.DataF.F));
     DeleteFile(FName);
     TaStatus := MakeIndex(IxF,FName,KeyLen,S);
     Result := TaStatus = 0;
   end;

BEGIN
  try //Except
    Try //finally
  //    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.OpenIndex',ListaDeChamadas); {$ENDIF}

//      SetTransaction(true,OK,Wok_Set_Transaction);
      If (Not Is_TFileOpen(IxF.DataF.F)) // and ok
      Then
      BEGIN
        K := (KeyLen + ItemOverHead) * PageSize + PageOverhead;
  {      K := Multiplo_Mais_proximo_de_N(K,BlockSize_DatF);}

  {     If IxF.DataF.OkTemporario
        Then Begin
               AssignIndexFile(IxF,FName,Sizeof(TsImagemHeader),K,FileMode or FmMemory);
               IxF.DataF.F.Reset(FileMode or FmMemory);
             end
        Else}
             Begin
               AssignIndexFile(IxF,FName,Sizeof(TsImagemHeader),K);
               IxF.DataF.F.Reset(FileMode,ShareMode);
             end;
        ok := TaStatus = 0;

        IF TaStatus <> 0 THEN
        BEGIN
          Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'OpenIndex',
                                    FName,
                                    Format('%d',[KeyLen]),
                                   TaStatus);
          Ok := Del_Index_e_MakeIndex;
          Exit;
        END;


        IF ok and (KeyLen > MaxKeyLen) THEN
        Begin
          TaStatus := REC_TOO_LARGE;
          TaIOcheck(IxF.DataF,0);
          Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'OpenIndex',
                                    FName,
                                    Format('%d',[KeyLen]),
                                   TaStatus);
          Ok := Del_Index_e_MakeIndex;
          Exit;
        End;

        {Inicializa a coleção de registros travados}

        Try
          If Ok
          Then ok := ReadHeader(IxF.DataF);
          If (Not ok)
          Then Begin
                 If (TaStatus=0)
                 Then TaStatus := ErroDeLeituraEmDisco;
                 exit;
               End;
        Except
          Ok := Del_Index_e_MakeIndex;
          Exit;
        End;

        IF ok And  (K <> IxF.DataF.ItemSize) THEN
        BEGIN
          TaStatus := KeySizeMismatch;
          TaIOcheck(IxF.DataF,0);
          Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'OpenIndex',
                                    FName,
                                    Format('%d',[KeyLen]),
                                   TaStatus);

          Ok := Del_Index_e_MakeIndex;
          Exit;
        END;

        IxF.AllowDuplKeys := S <> NoDuplicates;
        IxF.KeyL          := KeyLen;
  {      IxF.DataF.RR      := IxF.DataF.RR;}
        IxF.PP            := 0;

      END
      ELSE
      Begin
        If TaStatus=0
        Then TaStatus := ErrorTentativa_de_abrir_um_arquivo_aberto;
        TaIOcheck(IxF.DataF,0);
      End;

    Finally
      If TaStatus = 0
      Then FilesOpens.Insert(@IxF);

      If TaStatus <> 0
      Then Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'OpenIndex',
                                    FName,
                                    Format('%d',[KeyLen]),
                                   TaStatus);
      Result := TaStatus;
      Ok     := TaStatus = 0;

  {$REGION ' ---> 2013/03/21 - Tarefa: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função OpenIndex().'}
    { DONE 1 -oVersão.9.36.26.3013>class function TTb_access..OpenIndex -cMELHORIA DO CÓDIGO :
 2013/03/21. Criado em: 2013/03/21.
     - PROBLEMA: Implementar a chamada a Rollback caso esteja dentro da transação e ocorra erro e a transação tenha sido executada na função OpenIndex().
         - CAUSA:
             - As vezes um índice fica Inconsistente.
         - SOLUÇÃO:
             - Implementar o comando Rollback todas as vezes que o comando StartTransaction for executado.
    }
//        SetTransaction(False,OK,Wok_Set_Transaction);
      End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := TaStatus;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'OpenIndex',
                              IxF.DataF.FileName,
                              Format('%d',[KeyLen]),
                             TaStatus);
  end;

{$ENDREGION}
//==========================================================================================================

END; { OpenIndex }


class procedure TTb_access. LeiaHeaderDoIndice( VAR IxF       : IndexFile);
VAR
  KeyLen,S : BYTE;
BEGIN
//  {$IFDEF TADebug}  Application.Push_MsgErro('Tb_Access.LeiaHeaderDoIndice',ListaDeChamadas);  {$ENDIF}
  FlushIndex(IxF);
  KeyLen := IxF.KeyL;
  IF NOT IxF.AllowDuplKeys
  THEN S := 0
  ELSE s := 1;

  ok := ReadHeader(IxF.DataF);
  If ok Then
  WITH IxF, DataF DO
  BEGIN
    IxF.AllowDuplKeys := S <> NoDuplicates;
    IxF.KeyL := KeyLen;
{    IxF.RR := IxF.DataF.Int1;}
    IxF.PP := 0;
  END;


END;


class function TTb_access. aCloseIndex(VAR IxF : IndexFile):boolean;
BEGIN
  FlushIndex(IxF);
  ok := aCloseFile(Ixf.DataF);
  Result := ok;
END; { CloseIndex }

class function TTb_access.CloseIndex(VAR IxF : IndexFile;OkCondicional:Boolean):boolean;Overload;

  function _CloseIndex:Boolean;
  Begin
    If FilesOpens <> nil
    Then Begin
           If FilesOpens.IndexOf(@IxF) <> -1
           Then FilesOpens.Free(@IxF)
           Else ok := aCloseIndex(IxF);
         End
    Else ok := true;
    Result := ok;
  end;

BEGIN
  TaStatus := 0;
  If Is_TFileOpen(IxF.DataF.F)
  Then Begin
         If OkCondicional
         Then Begin
                If IxF.DataF.F.GetDriveType <> dt_Memory_Stream
                Then Result := _CloseIndex;
              End
         Else Result := _CloseIndex;
       End
  Else Result := true;
END; { CloseIndex }

class function TTb_access. CloseIndex(VAR IxF : IndexFile):boolean;Overload;
Begin
  CloseIndex(IxF,False);
  result := ok;
end;


class function TTb_access. FlushIndex(VAR IxF       : IndexFile):boolean;
BEGIN
  TaStatus := 0;
  Ok       :=  FlushFile(IxF.DataF);
  Result   := ok;
END; { FlushIndex }


class function TTb_access. EraseFile(VAR DatF : DataFile):boolean;
BEGIN
  Try
//    {$IFDEF TADebug}  Application.Push_MsgErro('Tb_Access.EraseFile',ListaDeChamadas);  {$ENDIF}
    CloseFile(DatF); {Fecha o arquivo se tiver aberto}
    Result := DelFile(DatF.Filename);
  Finally

  End;
END; { EraseFile }

class function TTb_access. EraseIndex(VAR IxF : IndexFile):boolean;
BEGIN
//  {$IFDEF TADebug}  Application.Push_MsgErro('Tb_Access.EraseIndex',ListaDeChamadas);  {$ENDIF}

  Result := EraseFile(IxF.DataF);


END; { EraseIndex }


class function TTb_access.TaGetPage(VAR IxF  : IndexFile;
                                    Const
                                        R     : LONGINT;
                                    VAR PgPtr : TaPagePtr):boolean;
BEGIN
  ok := GetRec(IxF.DataF,R,PgPtr);
  if ok
  then begin
         ok := (PgPtr.Reservado.NRecAnt=0); //Existe uma situação em que se ler uma página deletada.
          if not ok
          then begin
                 Raise TException.Create7('',
                                          'Tb_Access.Pas',
                                          'TTb_access',
                                          'TaGetPage',
                                           IxF.DataF.FileName,
                                           '',
                                          'ATENÇÃO: Tem algo errado na estrutura do arquivo de índice porque houve a leitura de página do índice deletada!!!!');

             end;
       end;
  If ok
  Then TaUnpack(PgPtr,IxF.KeyL);
  result := ok;
END; { TaGetPage }

class procedure TTb_access. TaNewPage(VAR IxF  : IndexFile;
                    VAR R     : LONGINT;
                    VAR PgPtr : TaPagePtr);
BEGIN
  PgPtr.Reservado.NRecAnt := 0;
  NewRec(IxF.DataF,R); {Obs. o Novo R esta na Memória ???}
END; { TaNewPage }

class procedure TTb_access. TaUpdatePage(VAR IxF  : IndexFile;
                       VAR R     : LONGINT;
                       VAR PgPtr : TaPagePtr;
                       Const Transaction_Current : T_TTransaction);
BEGIN
//  Try
    TaPack(PgPtr,IxF.KeyL);
    PutRec(IxF.DataF,R,PgPtr,Transaction_Current);
//    If Not ok Then abort;

{  Except
    ok       := false;
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;
    Application.Mi_MsgBox.MessageBox(StrMessageBox(Name_Type_App_MarIcaraiV1,
                             'Tb_Access',
                             'class procedure TTb_access. TaUpdatePage(' + Ixf.DataF.FileName+ ')',TaStatus));
    Abort;
  end;}
END; { TAUpdatePage }


class procedure TTb_access. TaDeletePage(var IxF : IndexFile; VAR R     : LONGINT; VAR PgPtr : TaPagePtr);
BEGIN
    FlushIndex(Ixf);
    If not ok
    Then  Raise TException.Create7('',
                                   'Tb_Access.Pas',
                                   'TTb_access',
                                   'TaDeletePage',
                                    IxF.DataF.FileName,
                                    '',
                                   'Algo errado flushFile retortou false!');

    DeleteRec(IxF.DataF,R);
    If Not ok
    Then abort; //se Não conseguiu deletar então aborta.
END; // TaDeletePage


class procedure TTb_access. ClearKey(VAR IxF : IndexFile);
BEGIN
  IF NOT IxF.DataF.FileModeDenyALL
  THEN LeiaHeaderDoIndice(IxF);
  IxF.PP := 0;
  IxF.OkBof_ix := TRUE;
  IxF.OkEof_ix := false;
END;

class function TTb_access. NextKey(VAR IxF       : IndexFile;
                 VAR DataRecNum : LONGINT;
                 VAR ProcKey                ):Boolean;
VAR
  R      : LONGINT;
  PagPtr : TaPagePtr;
BEGIN
  IxF.NextKey_pages_Reads := 0;
  Try  {Finally}
    IF IxF.PP = 0
    THEN R := IxF.DataF.RR { Inicio do arquivo ( Primeira chave ) }
    ELSE BEGIN
           TaGetPage(IxF,IxF.Path[IxF.PP].PageRef,PagPtr);
           if ok
           then IxF.NextKey_pages_Reads := IxF.NextKey_pages_Reads +1;

           R := PagPtr.ItemArray[IxF.Path[IxF.PP].ItemArrIndex].PageRef;

         END;

    WHILE R <> 0 DO
    BEGIN
      Inc(IxF.PP);
      IxF.Path[IxF.PP].PageRef      := R;
      IxF.Path[IxF.PP].ItemArrIndex := 0;
      TaGetPage(IxF,R,PagPtr);
      if ok
      then IxF.NextKey_pages_Reads := IxF.NextKey_pages_Reads +1;

      R := PagPtr.BckwPageRef;
    END;

    IF IxF.PP <> 0
    THEN BEGIN
           WHILE (IxF.PP > 1 ) and (IxF.Path[IxF.PP].ItemArrIndex = PagPtr.ItemsOnPage) DO
           BEGIN
             IxF.PP := IxF.PP - 1;
             TaGetPage(IxF,IxF.Path[IxF.PP].PageRef,PagPtr);
             if ok
             then IxF.NextKey_pages_Reads := IxF.NextKey_pages_Reads +1;
           END;

      IF IxF.Path[IxF.PP].ItemArrIndex < PagPtr.ItemsOnPage
      THEN BEGIN
             Inc(IxF.Path[IxF.PP].ItemArrIndex);
             WITH PagPtr.ItemArray[IxF.Path[IxF.PP].ItemArrIndex] DO
             BEGIN
               TaKeyStr(ProcKey) := Key;
               DataRecNum        := DataRef;
             END;
           END
      ELSE IxF.PP := 0;
    END;

  Finally
    If ok
    Then OK := IxF.PP <> 0;
    Result := ok;

    IxF.OkEof_ix := not ok;
  End;
END; { NextKey }

class function TTb_access. PrevKey(var IxF : IndexFile;
                  var DataRecNum : Longint;
                  var ProcKey ):Boolean;

VAR
  R      : LONGINT;
  PagPtr : TaPagePtr;

BEGIN
  Try
    WITH IxF DO
    BEGIN
      PrevKey_pages_Reads := 0;
      IF PP = 0 THEN
        R := DataF.RR
      ELSE
        WITH Path[PP] DO
        BEGIN

          TaGetPage(IxF,PageRef,PagPtr);
          if ok
          then PrevKey_pages_Reads := PrevKey_pages_Reads +1;


          ItemArrIndex := ItemArrIndex - 1;
          IF ItemArrIndex = 0
          THEN R := PagPtr.BckwPageRef
          ELSE R := PagPtr.ItemArray[ItemArrIndex].PageRef;
        END;

      WHILE R <> 0 DO
      BEGIN

          TaGetPage(IxF,R,PagPtr);
           if ok
           then PrevKey_pages_Reads := PrevKey_pages_Reads +1;

        Inc(PP);
        WITH Path[PP] DO
        BEGIN
          PageRef := R;
          ItemArrIndex := PagPtr.ItemsOnPage;
        END;
        WITH PagPtr DO
          R := ItemArray[ItemsOnPage].PageRef;
      END;

      IF PP <> 0 THEN
      BEGIN
        WHILE (PP > 1) and (Path[PP].ItemArrIndex = 0) DO
        BEGIN
          PP := PP - 1;

          TaGetPage(IxF,Path[PP].PageRef,PagPtr);
          if ok
          then PrevKey_pages_Reads := PrevKey_pages_Reads +1;

        END;

        IF Path[PP].ItemArrIndex > 0 THEN
          WITH PagPtr.ItemArray[Path[PP].ItemArrIndex] DO
          BEGIN
            TaKeyStr(ProcKey) := Key;
            DataRecNum := DataRef;
          END
        ELSE
          PP := 0;
      END;
      OK := PP <> 0;
    END;

  Finally
    PrevKey := ok;
    IxF.OkBof_ix := not ok;
  end;

END; { PrevKey }

class procedure TTb_access. TaXKey(VAR K:TaKeyStr; Const KeyL : BYTE);
BEGIN
  IF Length(TaKeyStr(K)) > KeyL THEN
    //TaKeyStr(K)[0] := AnsiChar(KeyL);
    k := copy(k,KeyL);

END; {8 TaXKey }


class function TTb_access. TaCompKeys(Const K1 ,K2; DR1,DR2 : LONGINT; Const Dup : BOOLEAN ) : Shortint;
{Rotina tirada da Internet em 29/10/96
 Documento  TI426 - DataBase ToolBox
}
BEGIN
  IF TaKeyStr(K1) = TaKeyStr(K2) THEN
  Begin
    IF Not Dup or (DR1=DR2) THEN
      TaCompKeys := 0
    ELSE
      IF DR1 > DR2 Then
        TaCompKeys := 1
      ELSE
        TaCompKeys := -1
  END
  ELSE
  IF TaKeyStr(K1) > TaKeyStr(K2) THEN
    TaCompKeys := 1
  ELSE
    TaCompKeys := -1;
END;

(*
class function TTb_access. TaCompKeys(VAR K1 ,K2; DR1,DR2 : LONGINT; Dup : BOOLEAN ) : LONGINT;
 {Esta rotina tem problemas com chaves duplicadas.
 Isso acontece com registros acima de 32k}

BEGIN
  IF TaKeyStr(K1) = TaKeyStr(K2) THEN
    IF Dup THEN
      TaCompKeys := DR1 - DR2
    ELSE
      TaCompKeys := 0
  ELSE
  IF TaKeyStr(K1) > TaKeyStr(K2) THEN
    TaCompKeys := 1
  ELSE
    TaCompKeys := -1;
END;
*)

class function TTb_access. TaFindKey(VAR IxF       : IndexFile;
                    VAR DataRecNum : LONGINT;
                    VAR ProcKey                ):boolean;
VAR
  PrPgRef   : LONGINT;
  C         : Shortint;
  K,L,R     : SmallInt;
  PagPtr    : TaPagePtr;
  okFind    : BOOLEAN;
BEGIN
//  {$IFDEF TaDebug}Application.Push_MsgErro('Tb_Access.TaFindKey',ListaDeChamadas);{$ENDIF}
  WITH IxF DO
  BEGIN
    TaFindKey_pages_Reads := 0;
    TaXKey(TaKeyStr(ProcKey),KeyL);
    OKFind := false;
    PP := 0;
    PrPgRef := DataF.RR;

    WHILE (PrPgRef <> 0) and NOT OKFind DO
    BEGIN
      Inc(PP);
      Path[PP].PageRef := PrPgRef;

        TaGetPage(IxF,PrPgRef,PagPtr);
        if ok
        then TaFindKey_pages_Reads := TaFindKey_pages_Reads +1;

      WITH PagPtr DO
      BEGIN
        L := 1;
        R := ItemsOnPage;
        REPEAT
//          SysCtrlSleep(0);
          K := (L + R) div 2;
          C := TaCompKeys(TaKeyStr(ProcKey),
                          ItemArray[K].Key,
                          0,
                          ItemArray[K].DataRef,
                          AllowDuplKeys   );
          IF C <= 0 THEN R := K - 1;
          IF C >= 0 THEN L := K + 1;
        UNTIL R < L;

        IF L - R > 1 THEN
        BEGIN
          DataRecNum := ItemArray[K].DataRef;
          R          := K;
          OKFind     := true;
        END;

        IF R = 0
        THEN PrPgRef := BckwPageRef
        ELSE PrPgRef := ItemArray[R].PageRef;
      END;
      Path[PP].ItemArrIndex := R;
    END;

    IF NOT OKFind and (PP > 0) THEN
    BEGIN
      WHILE (PP > 1) and (Path[PP].ItemArrIndex = 0) DO
        PP := PP - 1;
      IF Path[PP].ItemArrIndex = 0 THEN
        PP := 0;
    END;
  END;

  ok := OKFind;
  TaFindKey := ok;

  IxF.OkBof_ix := false;
  IxF.OkEof_ix := false;


END; { TAFindKey }

class function TTb_access.FindKey(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;
  VAR
    TempKey   : TaKeyStr;
BEGIN
  Try
    taKeyStr(ProcKey) := AnsiUpperCase(String_Asc_gui_to_Asc_Ingles(taKeyStr(ProcKey)));

    IF NOT IxF.DataF.FileModeDenyALL
    THEN LeiaHeaderDoIndice(IxF)
    Else ok := true;

    If ok Then
    Begin
      TaFindKey(IxF,DataRecNum,TaKeyStr(ProcKey));
      IF (NOT OK) and IxF.AllowDuplKeys and (taStatus=0) THEN
      BEGIN
        TempKey := TaKeyStr(ProcKey);
        NextKey(IxF,DataRecNum,TaKeyStr(ProcKey));
        OK := OK and (TaKeyStr(ProcKey) = TempKey);
      END;
    End;

  Finally
    FindKey := ok;

  End;
END; { FindKey }

class function TTb_access. FindKeyTop(var IxF : IndexFile;var DataRecNum : Longint;var ProcKey ):Boolean;
  { Retorna o número do registro da chave da ultima ocorr-ncia repetida
    se o index permite chave duplicada.
  }
Var
  wKeyCurrent : TaKeyStr;
Begin
  taKeyStr(ProcKey) := AnsiUpperCase(String_Asc_gui_to_Asc_Ingles(taKeyStr(ProcKey)));

  Result := FindKey(IxF,DataRecNum,ProcKey);
  If Result and (Not IxF.AllowDuplKeys)
  Then Begin
         wKeyCurrent := TaKeyStr(ProcKey);
         Repeat {Pesquisa o ultimo repetido}
//           SysCtrlSleep(0);
           ok := NextKey(IxF ,DataRecNum,ProcKey);
           If ok
           Then Ok := WKeyCurrent=TaKeyStr(ProcKey);
         Until Not ok;
         Result := PrevKey(IxF ,DataRecNum,ProcKey);
       End;


End;

class function TTb_access. SearchKey(var IxF : IndexFile;
                   var DataRecNum : Longint;
                   var ProcKey:TaKeyStr):Boolean;
   Var
     WBufSize  : Longint;
//==========================================================================================================
{$REGION ' ---> Tarefa: SearchKey Não deve alterar o número do registro nem a chave caso a pesquisa seja false.'}
//==========================================================================================================

  { DONE 1 -oTb_Access.SearchKey -cMELHORIA NO CÓDIGO :
 20111/02/24. Criado em: 2011/02/24.
   - SearchKey Não deve alterar o número do registro nem a chave caso a pesquisa seja false.
  }
   Var
     wDataRecNum : Longint;
     wProcKey    : TaKeyStr;

{$ENDREGION}
//==========================================================================================================

BEGIN
  Try
    ProcKey := AnsiUpperCase(String_Asc_gui_to_Asc_Ingles(ProcKey));

    IF NOT IxF.DataF.FileModeDenyALL
    THEN LeiaHeaderDoIndice(IxF)
    else ok := true;

    If Ok
    Then Begin
           wDataRecNum := 0;
           wProcKey    := ProcKey;

           TaFindKey(IxF,wDataRecNum,wProcKey);

           IF (NOT OK) and (TaStatus=0)
           THEN NextKey(IxF,wDataRecNum,wProcKey);

           if ok
           then Begin
                   DataRecNum := wDataRecNum;
                   ProcKey    := wProcKey;
                End;
         End;
  Finally
    SearchKey := ok;
  End;
END; { SearchKey }


class function TTb_access. SearchKeyTop(var IxF : IndexFile; var DataRecNum : Longint; var ProcKey:TaKeyStr;Const Okequal : Boolean):Boolean;
  { Retorna o número do registro da chave da ultima ocorr-ncia repetida
    se o index permite chave duplicada.
  }
Var
  WProcKey,
  wKeyCurrent : TaKeyStr;
Begin
  ProcKey := AnsiUpperCase(String_Asc_gui_to_Asc_Ingles(ProcKey));

  WProcKey := TaKeyStr(ProcKey);
  Result := SearchKey(IxF,DataRecNum,ProcKey);
  If Result
  Then If Okequal
       Then Result := Copy(TaKeyStr(ProcKey),1,Byte(TaKeyStr(wProcKey)[0])) = wProcKey
       else Result := TaKeyStr(ProcKey)= wProcKey;

  If Result and (Not IxF.AllowDuplKeys)
  Then Begin
         Repeat {Pesquisa o ultimo repetido}
//           SysCtrlSleep(0);
           ok := NextKey(IxF ,DataRecNum,ProcKey);
           If ok
           Then If Okequal
                Then ok := Copy(TaKeyStr(ProcKey),1,Byte(TaKeyStr(wProcKey)[0])) = wProcKey
                Else ok := TaKeyStr(ProcKey) = wProcKey;
         Until Not ok;
         Result := PrevKey(IxF ,DataRecNum,ProcKey);{Posiciona no anterior}
       End;
  ok := Result;
End;

  class procedure TTb_access. AddKey_Search_Insert(
                    var IxF : IndexFile;
                    Var PrPgRef1 : LONGINT;
                    VAR PrPgRef2,c : LONGINT;

                    VAR PagePtr1,PagePtr2  : TaPagePtr;
                    VAR ProcItem1, ProcItem2 : TaItem;
                    vAR PassUp, okAddKey  : BOOLEAN;
                    Const ProcKey    : TaKeyStr;
                    Const DataRecNum : Longint;
                    VAR K,L     : SmallInt;
                    Var R : SmallInt


                   );
    VAR
      i : Longint {SmallInt};
  BEGIN
    TaGetPage(IxF,PrPgRef1,PagePtr1);

    WITH PagePtr1 DO
    BEGIN
      IF ItemsOnPage < PageSize THEN
      BEGIN  {Insere  a chave na página}
        Inc(ItemsOnPage);
        FOR I := ItemsOnPage DOwnTO R + 2 DO
          ItemArray[I] := ItemArray[I - 1]; {Abre a posição para inserção}
        ItemArray[R + 1] := ProcItem1;
        PassUp := false;
      END
      ELSE
      BEGIN {Insere nova página}
        TaNewPage(IxF,PrPgRef2,PagePtr2);
        If Not ok
        Then abort;//exit;

        IF R <= Order
        THEN BEGIN  {Insere a chave abaixo DO orde (Metade) }
                IF R = Order
                THEN ProcItem2 := ProcItem1
                ELSE BEGIN
                       ProcItem2 := ItemArray[Order];
                       FOR I := Order DOwnTO R + 2 DO ItemArray[I] := ItemArray[I - 1];
                       ItemArray[R + 1] := ProcItem1;
                     END;

                FOR I := 1 TO Order DO PagePtr2.ItemArray[I] := ItemArray[I + Order];
              END
        ELSE  BEGIN
                R := R - Order;
                ProcItem2 := ItemArray[Order + 1];
                FOR I := 1 TO R - 1 DO  PagePtr2.ItemArray[I] := ItemArray[I + Order + 1];
                PagePtr2.ItemArray[R] := ProcItem1;
                FOR I := R + 1 TO Order DO PagePtr2.ItemArray[I] := ItemArray[I + Order];
              END;

        ItemsOnPage          := Order;
        PagePtr2.ItemsOnPage := Order;
        PagePtr2.BckwPageRef := ProcItem2.PageRef;
        ProcItem2.PageRef    := PrPgRef2;
        ProcItem1            := ProcItem2;

        TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_AddRec);
      END;
    END;
    TaUpdatePage(IxF,PrPgRef1,PagePtr1,Tra_PutRec);
  END; { Insert }

  class procedure TTb_access. AddKey_Search_Init_ProcItem1(Const ProcKey    : TaKeyStr;
                                         Const DataRecNum : Longint;
                                         vAR PassUp : BOOLEAN; VAR ProcItem1 : TaItem);
  Begin
    PassUp   := true;
    WITH ProcItem1 DO {Atualiza os dados da chave para se inserida em insert}
    BEGIN
      Key      := TaKeyStr(ProcKey);
      DataRef  := DataRecNum;
      PageRef  := 0;
    END;
  end;

class procedure TTb_access. AddKey_Search(var IxF : IndexFile;
                 PrPgRef1 : LONGINT;
                 VAR PrPgRef2,c : LONGINT;

                 VAR PagePtr1,PagePtr2  : TaPagePtr;
                 VAR ProcItem1, ProcItem2 : TaItem;
                 vAR PassUp, okAddKey  : BOOLEAN;
                 Const ProcKey    : TaKeyStr;
                 Const DataRecNum : Longint;
                 VAR K,L     : SmallInt
                 );
VAR
  R : SmallInt;

BEGIN { Search }
  IF PrPgRef1 = 0
  THEN BEGIN {Primeira chave}
//         Init_ProcItem1;
         AddKey_Search_Init_ProcItem1(ProcKey,
                                      DataRecNum,
                                      PassUp,
                                      ProcItem1);
        exit;
       END
  ELSE BEGIN {Nao e a primeira chave}
         TaGetPage(IxF,PrPgRef1,PagePtr1) ;
         WITH PagePtr1 DO
         BEGIN
            L := 1;
            R := ItemsOnPage;
            REPEAT {Pesquisa binaria para encontrar a posição da chave na página}
              K := (L + R) div 2;

              If K > 0 Then {GCICSoft. Quando tem algum problema no disco K fica zero 0 Não sei porque}
              C := TaCompKeys(TaKeyStr(ProcKey),
                              ItemArray[K].Key,
                              DataRecNum,
                              ItemArray[K].DataRef,
                              IxF.AllowDuplKeys   );
              IF C <= 0 THEN R := K - 1;
              IF C >= 0 THEN L := K + 1;
            UNTIL R < L;

            IF L - R > 1
            THEN BEGIN
                   OK := false; //13/02/2008 coloquei porque o original tem
                   okAddKey := false;
                   PassUp := false;
                 END
            ELSE BEGIN
{                     IF R = 0
                   THEN Search(BckwPageRef)
                   ELSE Search(ItemArray[R].PageRef);}

                   IF R = 0
                   THEN begin
                          AddKey_Search( IxF,
                                       BckwPageRef,//PrPgRef1,
                                       PrPgRef2,
                                       c,
                                       PagePtr1,
                                       PagePtr2,
                                       ProcItem1,
                                       ProcItem2,
                                       PassUp,
                                       okAddKey,
                                       ProcKey,
                                       DataRecNum,
                                       K,L);
                        end
                   ELSE Begin
                          AddKey_Search( IxF,
                                       ItemArray[R].PageRef,//PrPgRef1,
                                       PrPgRef2,
                                       c,
                                       PagePtr1,
                                       PagePtr2,
                                       ProcItem1,
                                       ProcItem2,
                                       PassUp,
                                       okAddKey,
                                       ProcKey,
                                       DataRecNum,
                                       K,L);
                        End;

                   If Not ok
                   Then exit;

{                   IF PassUp
                   THEN Insert();} {Insere a primeira chave}

                   IF PassUp
                   THEN AddKey_Search_Insert( IxF,
                                       PrPgRef1,//PrPgRef1,
                                       PrPgRef2,
                                       c,
                                       PagePtr1,
                                       PagePtr2,
                                       ProcItem1,
                                       ProcItem2,
                                       PassUp,
                                       okAddKey,
                                       ProcKey,
                                       DataRecNum,
                                       K,L,R); {Insere a primeira chave}


                   If Not ok Then exit;
                 END;
         END;
       END;

END; { Search }


class function TTb_access. AddKey(var IxF : IndexFile;
                Const DataRecNum : Longint;
                Const ProcKey    : TaKeyStr):Boolean;
VAR
  PrPgRef1,
  PrPgRef2,
  C         : LONGINT;
  {I,}
  K,L     : SmallInt;

  PassUp,
  okAddKey  : BOOLEAN;

  PagePtr1,
  PagePtr2  : TaPagePtr;

  ProcItem1,
  ProcItem2 : TaItem;

  Var
    Wok, Wok_Set_Transaction : Boolean;
BEGIN { AddKey }
  Try //Except
    Try //fINALLY
      SetTransaction(true,OK,Wok_Set_Transaction);
      If ok
      Then Begin
              IF (NOT IxF.DataF.FileModeDenyALL)
              THEN BEGIN
                     TraveHeader(IxF.DataF);
                     If ok Then LeiaHeaderDoIndice(IxF);
                   END
              else ok := true;

              If ok
              Then Begin
                     okAddKey := true;
                     //Search(IxF.DataF.RR);
                     AddKey_Search(IxF,
                                   IxF.DataF.RR,//PrPgRef1,
                                   PrPgRef2,
                                   c,
                                   PagePtr1,
                                   PagePtr2,
                                   ProcItem1,
                                   ProcItem2,
                                   PassUp,
                                   okAddKey,
                                   AnsiUpperCase(String_Asc_gui_to_Asc_Ingles(ProcKey)),
                                   DataRecNum,
                                   K,L );
                     If ok
                     Then Begin
                            IF PassUp
                            THEN BEGIN {Usado quando e a primeira chave na página}
                                   PrPgRef1 := IxF.DataF.RR;
                                   TaNewPage(IxF,IxF.DataF.RR,PagePtr1);
                                   If ok
                                   Then Begin
                                          WITH PagePtr1 DO
                                          BEGIN
                                            ItemsOnPage  := 1;
                                            BckwPageRef  := PrPgRef1;
                                            ItemArray[1] := ProcItem1;
                                          END;
                                          TaUpdatePage(IxF,IxF.DataF.RR,PagePtr1,Tra_AddRec);
                                        End;
                                 END;

                            ok := okAddKey and ok;
                            If ok
                            Then begin
                                   IxF.PP := 0;
                                   Inc(IxF.DataF.NumberKey);
                                 End;
                          End;

                     IF ok
                     THEN BEGIN
                            If  NOT IxF.DataF.FileModeDenyALL
                            Then Begin
                                   FlushIndex(IxF);
                                   DestraveHeader(IxF.DataF);
                                 End
                            Else If IxF.DataF.F.GetDriveType = dt_Memory_Stream Then FlushIndex(IxF);
                          END;

                   End
              else ok := false;
           End
      Else ok := false;

  Finally
    Result := ok;
    SetTransaction(False,OK,Wok_Set_Transaction);
  End;

  Except
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'AddKey',
                             Ixf.DataF.FileName,
                             Format('%d',[ProcKey]),
                             TaStatus);

  end;

END; { AddKey }

class function TTb_access.DeleteKey(var IxF : IndexFile;Const DataRecNum : Longint;Var ProcKey:TaKeyStr ):Boolean;
VAR
  PageTooSmall : BOOLEAN;
  PagPtr       : TaPagePtr;
  OkDeleteKey  : BOOLEAN;


  procedure UnderFlow(PrPgRef, PrPgRef2 : LONGINT;R : SmallInt);
  VAR
    I,K,LItem : SmallInt;
    LPageRef  : LONGINT;

    PagPtr,
    PagePtr2,
    L        : TaPagePtr;

  BEGIN
    TaGetPage(IxF,PrPgRef,PagPtr);
    TaGetPage(IxF,PrPgRef2,PagePtr2);

    IF R < PagPtr.ItemsOnPage
    THEN BEGIN
            Inc(R);
            LPageRef := PagPtr.ItemArray[R].PageRef;
            TaGetPage(IxF,LPageRef,L);
            K                                 := (L.ItemsOnPage - Order + 1) div 2;
            PagePtr2.ItemArray[Order]         := PagPtr.ItemArray[R];
            PagePtr2.ItemArray[Order].PageRef := L.BckwPageRef;

            IF K > 0
            THEN BEGIN
                    FOR I := 1 TO K - 1 DO PagePtr2.ItemArray[I + Order] := L.ItemArray[I];
                    PagPtr.ItemArray[R]         := L.ItemArray[K];
                    PagPtr.ItemArray[R].PageRef := LPageRef;
                    L.BckwPageRef               := L.ItemArray[K].PageRef;
                    L.ItemsOnPage               := L.ItemsOnPage - K;

                    FOR I := 1 TO L.ItemsOnPage DO L.ItemArray[I] := L.ItemArray[I + K];

                    PagePtr2.ItemsOnPage := Order - 1 + K;
                    PageTooSmall         := false;
                    TaUpdatePage(IxF,LPageRef,L,Tra_PutRec);
                 END
            ELSE BEGIN
                   FOR I := 1 TO Order
                   DO PagePtr2.ItemArray[I + Order] := L.ItemArray[I];

                   FOR I := R TO PagPtr.ItemsOnPage - 1
                   DO PagPtr.ItemArray[I] := PagPtr.ItemArray[I + 1];

                   PagePtr2.ItemsOnPage := PageSize;
                   PagPtr.ItemsOnPage   := PagPtr.ItemsOnPage - 1;

                   TaDeletePage(IxF,LPageRef,L);
                   PageTooSmall          := PagPtr.ItemsOnPage < Order;
                 END;
            TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_PutRec);
         END
    ELSE BEGIN
           IF R = 1
           THEN LPageRef := PagPtr.BckwPageRef
           ELSE LPageRef := PagPtr.ItemArray[R - 1].PageRef;
           TaGetPage(IxF,LPageRef,L);
           LItem := L.ItemsOnPage + 1;
           K := (LItem - Order) div 2;
           IF K > 0
           THEN BEGIN
                  FOR I := Order - 1 DOwnTO 1
                  DO PagePtr2.ItemArray[I + K] := PagePtr2.ItemArray[I];

                  PagePtr2.ItemArray[K]         := PagPtr.ItemArray[R];
                  PagePtr2.ItemArray[K].PageRef := PagePtr2.BckwPageRef;
                  LItem                         := LItem - K;

                  FOR I := K - 1 DOwnTO 1
                  DO PagePtr2.ItemArray[I] := L.ItemArray[I + LItem];

                  PagePtr2.BckwPageRef        := L.ItemArray[LItem].PageRef;
                  PagPtr.ItemArray[R]         := L.ItemArray[LItem];
                  PagPtr.ItemArray[R].PageRef := PrPgRef2;
                  L.ItemsOnPage               := LItem - 1;
                  PagePtr2.ItemsOnPage        := Order - 1 + K;
                  PageTooSmall                := false;
                  TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_PutRec);
                END
           ELSE BEGIN
                  L.ItemArray[LItem]         := PagPtr.ItemArray[R];
                  L.ItemArray[LItem].PageRef := PagePtr2.BckwPageRef;

                  FOR I := 1 TO Order - 1
                  DO L.ItemArray[I + LItem] := PagePtr2.ItemArray[I];

                  L.ItemsOnPage       := PageSize;
                  PagPtr.ItemsOnPage := PagPtr.ItemsOnPage - 1;

                  TaDeletePage(IxF,PrPgRef2,PagePtr2);
                  PageTooSmall := PagPtr.ItemsOnPage < Order;
                END;
           TaUpdatePage(IxF,LPageRef,L,Tra_PutRec);
         END;

    TaUpdatePage(IxF,PrPgRef,PagPtr,Tra_PutRec);
  END; // UnderFlow

  procedure DelB(PrPgRef : LONGINT);
  VAR
    I,K,L,R    : SmallInt;
    XPageRef,C : LONGINT;
    PagPtr     : TaPagePtr;

    procedure DelA(PrPgRef2 : LONGINT);
    VAR
      C        : SmallInt;
      XPageRef : LONGINT;
      PagePtr2 : TaPagePtr;
    BEGIN
      TaGetPage(IxF,PrPgRef2,PagePtr2);
      WITH PagePtr2 DO
      BEGIN
        XPageRef := ItemArray[ItemsOnPage].PageRef;
        IF XPageRef <> 0
        THEN BEGIN
               C := ItemsOnPage;
               DelA(XPageRef);
               If Not ok Then exit;

               IF PageTooSmall
               THEN  UnderFlow(PrPgRef2,XPageRef,C);
               If Not ok Then exit;
             END
        ELSE BEGIN
               TaGetPage(IxF,PrPgRef,PagPtr);
               ItemArray[ItemsOnPage].PageRef := PagPtr.ItemArray[K].PageRef;
               PagPtr.ItemArray[K]            := ItemArray[ItemsOnPage];
               ItemsOnPage                    := ItemsOnPage - 1;
               PageTooSmall                   := ItemsOnPage < Order;

               TaUpdatePage(IxF,PrPgRef,PagPtr,Tra_PutRec);
               If ok
               Then TaUpdatePage(IxF,PrPgRef2,PagePtr2,Tra_PutRec);

               If Not ok Then exit;
             END;
      END;
    END; { DelA }


  BEGIN { DelB }

    IF PrPgRef = 0
    THEN BEGIN
           OkDeleteKey := false;
           PageTooSmall := false;
         END
    ELSE BEGIN
           TaGetPage(IxF,PrPgRef,PagPtr);
           WITH PagPtr DO
           BEGIN
             L := 1;
             R := ItemsOnPage;
             REPEAT
                K := (L + R) div 2;
                      C := TaCompKeys(ProcKey,
                                ItemArray[K].Key,
                                DataRecNum,
                                                  ItemArray[K].DataRef,
                                IxF.AllowDuplKeys   );
                    IF C <= 0 THEN R := K - 1;
                    IF C >= 0 THEN L := K + 1;
             UNTIL L > R;

             IF R = 0
             THEN XPageRef := BckwPageRef
             ELSE XPageRef := ItemArray[R].PageRef;

             IF L - R > 1
             THEN BEGIN
      {          DataRecNum := ItemArray[K].DataRef; PauloSSPacheco tirou}
                    IF XPageRef = 0
                    THEN BEGIN
                           ItemsOnPage  := ItemsOnPage - 1;
                           PageTooSmall := ItemsOnPage < Order;
                           FOR I := K TO ItemsOnPage DO ItemArray[I] := ItemArray[I + 1];
                           TaUpdatePage(IxF,PrPgRef,PagPtr,Tra_PutRec);
                         END
                    ELSE BEGIN
                           DelA(XPageRef);
                           If Not ok Then exit;
                           IF PageTooSmall
                           THEN UnderFlow(PrPgRef,XPageRef,R);
                           If Not ok Then exit;
                         END;
                  END
             ELSE BEGIN
                    DelB(XPageRef);
                    If Not ok Then exit;
                    IF PageTooSmall
                    THEN UnderFlow(PrPgRef,XPageRef,R);
                    If Not ok Then exit;
                  END;
           END;
         END;
  END; { DelB }

  Var
    Wok , Wok_Set_Transaction : Boolean;
    WIxF_RR : Longint;
BEGIN { DeleteKey }
  try //Except
    Try  //Finally
      ProcKey := AnsiUpperCase(String_Asc_gui_to_Asc_Ingles(ProcKey));

      SetTransaction(true,OK,Wok_Set_Transaction);
      If ok
      Then Begin
              IF NOT IxF.DataF.FileModeDenyALL
              THEN BEGIN
                     TraveHeader(IxF.DataF);
                     LeiaHeaderDOIndice(IxF);
                   END;

              OkDeleteKey := true;
              DelB(IxF.DataF.RR);
              IF ok  and PageTooSmall
              THEN BEGIN
                     TaGetPage(IxF,IxF.DataF.RR,PagPtr);
                     IF PagPtr.ItemsOnPage = 0
                     THEN BEGIN
                            WIxF_RR := IxF.DataF.RR;
                            IxF.DataF.RR := PagPtr.BckwPageRef;
                            TaDeletePage(IxF,WIxF_RR,PagPtr);
                          END;
                   END;
              IxF.PP := 0;
              If ok and OkDeleteKey
              Then Dec(IxF.DataF.NumberKey);

              IF NOT IxF.DataF.FileModeDenyALL
              THEN BEGIN
                     If ok
                     Then ok := FlushIndex(IxF);
                     DestraveHeader(IxF.DataF);
                   END
              Else If IxF.DataF.F.GetDriveType = dt_Memory_Stream Then FlushIndex(IxF);


              ok        := OkDeleteKey and ok;
           End;

    Finally
      Result := ok;
      SetTransaction(False,OK,Wok_Set_Transaction);
    End;

  Except
    Ok := false;
    Result := ok;
    If TaStatus = 0
    Then TaStatus := Erro_Excecao_inesperada;

    Ok := false;
    Result := ok;
    Raise TException.Create7('',
                             'Tb_Access.Pas',
                             'TTb_access',
                             'DeleteKey',
                              IxF.DataF.FileName,
                              ProcKey,
                             TaStatus);
  end;
END; { DeleteKey }


class procedure TTb_access.CreateTAccess;
  { Initialization routine called by the "main class procedure TTb_access." OF this unit. }
  procedure CreatePages;
  { Allocate space FOR the page stack, the page map and the record
    buffer. }
  VAR
{    i    : SmallWord;}
    DatF : DataFile;
  BEGIN
//    {$IFDEF TADebug} Application.Push_MsgErro('Tb_Access.CreateTAccess.CreatePages',ListaDeChamadas);{$ENDIF}
    FilesOpens := TFilesOpens.Create;
    IF FilesOpens<>nil THEN
    BEGIN
      NEW(TaRecBuf);
      IF TaRecBuf = NIL THEN
      Begin
        TaStatus := ErroDeMemoria;
        FillChar(DatF,sizeof(Datf),0);
        TaIOcheck(DatF, 0);
        RunError(TaStatus);
      End;
      FILLChar(TaRecBuf^, SIZEOF(TaRecBuf^), 0);

      Transaction :=  TTransaction.Create('DbTra.Tb');
      IF Transaction = NIL THEN
      Begin
        TaStatus := ErroDeMemoria;
        FillChar(DatF,sizeof(Datf),0);
        TaIOcheck(DatF, 0);
        RunError(TaStatus);
      End;

    END
    ELSE
    Begin
      TaStatus := ErroDeMemoria;
      FillChar(DatF,sizeof(Datf),0);
      TaIOcheck(DatF, 0);
      RunError(TaStatus);
    End;

  END; { CreatePages }

BEGIN { CreateTAccess }
  Ok := true;
  TaStatus := 0;
  CreatePages;
END; { CreateTAccess }

class procedure TTb_access.DestroyTAccess;
BEGIN
  Discard(TObject(FilesOpens));
  If TaRecBuf <> Nil Then
  Begin
    Dispose(TaRecBuf);
    TaRecBuf := Nil;
  End;
  Discard(TObject(Transaction));
END; { DestroyPages }


{Var
  ExitProcAnterior : Pointer;}
class procedure TTb_access. Create;
Begin
  Set_FileModeDenyALL(False);
  CreateTAccess;
End;


class procedure TTb_access.Destroy;
Begin
   DestroyTAccess;
End;

{
  Esta unidade deve ser inicializada em Tb__Access visto que
  ela precisa ser a ultima a ser desalocada porque ela faz o tratamento
  de acesso a dados.

????? no freepascal deve checar se é verdade.

Begin
  Tb_Access.Create;
  ExitProcAnterior  := ExitProc;
  ExitProc          := @Destroy;
}

Initialization

   TTb_Access.create;

Finalization
   TTb_access.Destroy;

end.



