{
=============================================================================
               Criacao de Tipos, Definicao de Variaveis e Constantes Globais
=============================================================================
}
{$H-}
unit Db_Global;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

 {$I z:\TV32\MarIcaraiV1\source\rtl\Platform_inc.pas}

interface

uses Variants,
     Math,
     sysutils,
     dialogs,
     controls,
     grids,
     IniFiles,
     Classes
     ,VpSysLow
     ,VpUsrLow
     ,Objects
     ,DOS
     ,strings
     ,Memory
     ,RSet
     ,use32

     ;

Const
  /// <since>
  ///   . Objetivo: Se true o formulário de entrada de dados insere uma linha em branco automaticamente.
  ///
  /// </since>
  Auto_Add_Line_Default:Boolean = false;

Var
  AnoLimit : Byte = 20;

Type
  PTypeData     = ^TypeData;
  TypeData      = Record dia:byte;mes:Byte;ano : byte; End;

{
• Como é composto o número da versão e seu significado.

  •  O número da versão é composto de 4 número com os seguintes significado:

      1 -O primeiro número da versão é trocado quando a versão muda de plataforma ou ocorra mudanças expressivas.

      2 - O segundo número da versão é trocado toda vêz que é acressentado um novo código ao produto.

      3 - O terceiro número da versão é trocado toda vêz que o produto é disponibilizado ao público em geral .

      4 - O quarto número da versão é trocado toda vêz que for corrigido algum bug ou for feita otimização no código.
}
    Type
       TVersao_do_Sistema =
              Record
              //A Versao_Sistema é trocada quando a versão é lançada no mercado como um produto novo.
                Versao_Sistema       : Byte; Data_Versao_Sistema  : TypeData;

              //A Serie_Versao é trocada quando é acressentado algum recurso novo no produto.
                Serie_Versao       : SmallWord;
                Data_Serie_Versao  : TypeData;

              //A Liberacao_Versao é trocada quando a versão é publicada para o público.
                Liberacao_Versao          : SmallWord;
                Data_Liberacao_Versao     : TypeData;

              //O Numero_Compilacao é trocada a opção buid é executado com objetivo de publicar o produto.
                Numero_Compilacao : SmallWord;
                Data_Numero_Compilacao : TypeData;
              End;


type
  TVarGetDate   = Record Dia,Mes,Ano,DiaDaSemana : Word;  end;
  TVarGetTime   = record Hora,Minuto,Segundo,S100 : Word; end;

Type
  TDateMask = (DateMask_AA_MM_DD,
               DateMask_AAAA_MM_DD,
               DateMask_DD_MM_AA,// DD/MM/AA
               DateMask_DDMMAA, // DDMMAA
               DateMask_DD_MM_AAAA,
               DateMask_MM_AA,
               DateMask_MM_AAAA,
               DateMask_NomeMM_AA,
               DateMask_NomeMM_AAAA,

               DateMask_MM_NomeMM,
               DateMask_MM_NomeMM_AA,
               DateMask_MM_NomeMM_AAAA,
               DateMask_Extenco,

               DateMask_DD_MM_AA_HH_MM_SS,   // DD/MM/AA HH:MM:SS
               DateMask_DDMMAAHHMMSS,        // DDMMAAHHMMSS

               DateMask_DD_MM_AA_HH_MM,      // DD/MM/AA HH:MM
               DateMask_DDMMAAHHMM,          // DDMMAAHHMM

               DateMask_DD_MM_AAAA_HH_MM_SS,  // DD/MM/AAAA HH:MM:SS
               DateMask_DDMMAAAAHHMMSS,       // DD/MM/AAAA HH:MM:SS

               DateMask_AAAAMMDDHHMMSS        // AAAAMMDDHHMMSS

               );

  THourMask = (HourMask_HH_MM ,
               HourMask_HH_MM_SS,
               HourMask_HH_MM_SS_S100);



  TMeses = (MesNulo,
            Janeiro,
            Fevereiro,
            Marco,
            Abril,
            Maio,
            Junho,
            Julho,
            Agosto,
            Setembro,
            Outubro,
            Novembro,
            Dezembro);
Const
  ArrayStrMeses : Array[TMeses] of string =
            ('',
            'Janeiro',
            'Fevereiro',
            'Marco',
            'Abril',
            'Maio',
            'Junho',
            'Julho',
            'Agosto',
            'Setembro',
            'Outubro',
           'Novembro',
           'Dezembro');


Type
  PCluster  = ^TCluster;
  TCluster  =  SmallWord;

TYpe
  TFile_StringGrid = Class ;
  TFile_StringGrid_OnValid = Function(aFile_StringGrid:TFile_StringGrid) : Boolean of object;

  /// <since>
  ///   • Este evento deve ser implementado em um componente com objetivo de copiar a grid passada por aFile_StringGrid1.
  /// </since>
  TFile_StringGrid_OnCopyToSelf = Function (Const aFile_StringGrid1 : TFile_StringGrid) :Boolean;

  /// <since>
  /// Usado especificamente quando a linha zero contem o nome da coluna
  /// e a linha um comtém o formato dos campos.
  /// </since>
  TFile_StringGrid = Class(TControl)
    Public var OnValid : TFile_StringGrid_OnValid;

    Public Var StringGrid : grids.TStringGrid;

    Private var _NrCurrent : Longint;
    public Property NrCurrent : Longint Read _NrCurrent write _NrCurrent;

    Public Constructor Create(aStringGrid : grids.TStringGrid);Virtual;

    Public Function  CellsByFieldName(aFieldName: String;aRow:Longint):AnsiString;Overload;
    Public Function  CellsByFieldName(aFieldName: String):AnsiString;Overload; //;aRow := NrCurrent

    Public Function  FieldName(aCol:Longint):AnsiString; //Retorna o nome do campo da coluna

    Public Function  FieldByName(aFieldName: String):AnsiString;
    Public Procedure SetFieldByName(aFieldName,aValue: String);

    Public Function  FieldByNumber(aCol:Longint):AnsiString;
    Public Procedure SetFieldByNumber(aCol:Longint;aValue: String);overload;


    Public Function Bof:Boolean;
    Public Function Eof:Boolean;
    Public Function GoBof : Boolean ; Virtual;
    Public Function GoEof : Boolean;  Virtual;
    Public function NextRec : boolean;  Virtual;
    Public function PrevRec : boolean;  Virtual;

    Public function Valid : boolean;  Virtual;
  End;  

Type
  TNao_Sim = (NS_Nao,NS_Sim);
  TConvertIdioma =  Function (S: AnsiString): AnsiString; //USada para passar como parametro na conversão de idima de listas d estring.

Const
  ConvertIdioma_Nil : TConvertIdioma = nil;
  LookupEnable_Global : Boolean = False;  //Se True em TRecord.AdFields cria uma tabela e associa aos campos cujo a propriedade Tcampo.LookupCandidate = true.
  Duplicate_TRecord_AddField : Boolean = True;  //Se true permite campos duplicados na consulta em TRecord.AddField().
             
Const
  Max_BY_Dlg_pesquisa : Byte = 18;
  Max_de_anos_disponivel_no_HD = 5;    { Número Maximo de Anos Disponivel no Winchester }

const
  NKey_Global   : Longint = -1; //<  Usado  para totalizar o numero de chaves gera adicionadas em todos os index.
  MemIniFile : TMemIniFile = nil; //<  Variaveris do ambente que é lido na pasta \windows

CONST
  Ok_Modo_relario_de_erros : Boolean = false;//<  Váriável global indicando que esta no modo analise dos erros e o committe deve executar roolback.


  Ok_Create_Shortcut   : Boolean = false; //<  Se true indica que está criando atalho.
                                          //<  Se false indica que não esta criando atalho.
                                          //<  Só que ao retorna false o sistema deve criar o atalho
                                          //<  no desktop do windows.
                                          //<  Units que deve ser implementado: App.TProgram.GetEvent();


  Str_Create_Shortcut  : AnsiString = '';   //<  Se Ok_Create_Shortcut Então Str_Create_Shortcut := Str_Create_Shortcut +Event;
                                            //<  Units que deve ser implementado: App.TProgram.GetEvent();

Type
 TCommandStr = Record
                 Active      : Boolean; {<True = Opcao disponivel; False = Opcoao nao disponivel}
                 Option_Basic: Boolean; {<True = A opcao nao precisa de senha para ser acessada}
                 Modulo      : Byte;
                 Command     : SmallWord;
                 CommandStr  : AnsiString;

               End;

Const
  Senha_NortSoft = '195858';
  NortSoft_Logado : SmallWord = 0; {<0 = Indica uso normal do produto; 1= Indica que a Senha_NortSoft esta logado}

//  Path_Local_Ferr : PathStr = 'C:\';
//  FilialDoUsuarioLogado    : Byte    = 1;    //<  O padrao é a filial 1
//  MatriculaDoUsuarioLogado : SmallInt = 1;   //<  O Padrao e o usuario root.
//  NomeDoUsuarioLogado      : string[35] = 'Root';

threadvar
  CurrentModule                  : SmallWord ;   //<Numero do modulo corrente
  StrCurrentModule               : AnsiString ; //<Nome do modulo corrente atualizando em HandleEvent
  CurrentCommand                 : SmallWord ;  //<Numero do comando atual atualizando em HandleEvent
  StrCurrentCommand              : AnsiString ; //<Nome do comando atual atualizando em HandleEvent
  StrCurrentCommand_Opcao        : AnsiString ; //< AddRec; UpdateRec;DeleteRec;Pesquisar; Visualizar; Imprimir
  StrCurrentCommand_Topic        : AnsiString ; //<Nome do campo
  StrCurrentCommand_HelpCtx_Hint : AnsiString ; //< <Texto com uma preve descrição do objeto corrente atualizado em HandleEvent.
  CommandCurrent                 : SmallWord ; {<Numero do comando atual atualizado em ListeTexto }

const
   Nome_Do_Plug_in_Principal : AnsiString = 'Db_Global';

Type
   //Ações caso o sistema fique ocioso
  TOkProcessingTime_Action = (OkProcessingTime_Action_Abort,
                              OkProcessingTime_Action_Password);

Const
    Delta_Locate      : Longint  = 100;
    Max_LookupCache   : Longint  = 50; //Número máximo de item para que um campo seja colocado no cache em TMI_DataSet.
    OkDeveReindexarDB : Boolean = false; {<True = O sistema deve reindexar todos os arquivos}
    OkDeveRepararDB   : Boolean = false; {<True = O Sistema deve executar a rotina para reparar as consistencias entre tabelas}

// Variaveis usada no controle do acesso a pessoas não altorizada caso o usuario com acesso esqueça um formulário aberto.
   // se Okprocessing = True  = O Sistema esta em loop fazendo um processamento.
    Okprocessing              : Boolean = false;

   // OkprocessingControlTime = true abilita o controle de osiosidade dos dialogos
    OkprocessingControlTime : Boolean = true;

   // TimeOut = Tempo em segundos de onciosidade permitida
    OkOkprocessingTime        : Longint = 5 * 60;  //= 5 minuts
//    OkOkprocessingTime        : Longint = 1 * 10;  //= 5 minuts

//    OkOkprocessingTime        : Longint = 1 * 5;  //= 5 segundos

   //Ação caso o sistema fique ocioso
    OkProcessingTime_Action    : TOkProcessingTime_Action = OkProcessingTime_Action_Password;

   // Tempo ocorrido do ultimo evento
    OkOkprocessingClockBegin  : DWord = 0;


{ ÍÍ Defenicao do objeto campo  ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ }
Type
  Real        = RSet.Real;
  TRealNum    = RSet.TRealNum;
  PRealNum    = RSet.PRealNum;

  TTipo_de_Codigo_Fonte = (TCF_Grafico,TCF_Texto);
  AnsiCharSet       = set of AnsiChar;

//  TCluster = SmallWord;
//  PCluster =^TCluster;

///<property>
///  </property>
_TStr255 = record
    Len       : Byte;{<Numero de caracare de str. Usado para compatibiliza com os strings da linguagem C}
               ArrayAnsiChar : Array[0..255] of AnsiChar;
             end;
  TStr255 = Record {<Usado para chamadas das API do windows }
              Case Integer of
                 0 : (Str : tString);
                 1 : (Str_Win : _TStr255);
            end;

  PValueNum = ^TValueNum;
  TValueNum =
  Record
    case byte of
     1: (AsReal     : Real);
     2: (AsPReal    : PReal);
     3: (AsDouble   : Double);
     4: (AsPDouble  : PDouble);
     5: (AsRealNum  : TRealNum);
     6: (AsPRealNum : PRealNum);
     7: (asLongint  : Longint);
     8: (asPLongint : PLongint);
     9: (asWord     : Word);
    10: (asPWord    : PWord);
    11: (asSmallInt  : SmallInt);
    12: (asPSmallInt : PSmallInt);
    13: (asByte     : Byte);
    14: (asPByte    : PByte);

    15: (asSHORTINT  : SHORTINT);
    16: (asPSHORTINT : PSHORTINT);

    17: (asCluster  : TCluster);
    18: (AsPCluster : PCluster);

    19: (///<property>
      ///  </property>
      ///<property>
      ///  </property>
      asBOOLEAN  : BOOLEAN);
    20: (asPBOOLEAN : PBOOLEAN);
    21: (asSmallWord : SmallWord);
  End;

  TTValue = (AsPointer,
             asLongint,
             asPLongint,
             asWord,
             asPWord,
             asSmallInt,
             asPSmallInt,
             asByte,
             asPByte,
             asAnsiChar,
             asPAnsiChar,
             AsString,
             AsPString,
             AsStr255,
             AsPStr255,
             AsArrayAnsiChar512,
             AsArrayByte,
             AsArraySmallInt,
             AsArrayLongint,
             AsArrayPointer,
             AsArrayPAnsiChar,
             AsReal      ,
             AsPReal     ,
             AsDouble    ,
             AsPDouble   ,
             AsRealNum   ,
             AsPRealNum  ,
             AsExtended  ,
             AsPExtended ,
             asDate      ,
             asPDate     ,
             asSHORTINT  ,
             asPSHORTINT ,
             asCluster   ,
             asPCluster  ,
             asBOOLEAN   ,
             asPBOOLEAN,
             asSmallWord
               );


  PValue = ^TValue;
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



Type
{  PPRNOptPP = ^TPRNOptPP;}
  TPRNOptPP = Record  {< dialog box's data for printer-options }
                Sequencial        : Byte;    {<Numero de impressoras}
                NumeroDeLinhas    : Byte;    {<Numero de linhas por pagina }
                NumeroDeColunas   : SmallInt; {<Numero de colunas por pagina}
//                NumeroDeCaracterePorPolegada : byte; //Tipo TEnum_CPI;
                CPI               : byte; //Tipo TEnum_CPI;
                LPI               : Byte;//Enum_6_LPI

                RetratoOuPaisagem : SmallWord;
                Opcoes            : SmallWord;
                Porta             : SmallWord;   {<0 = PRN; 1 = Arquivo }
                PadraoDosCodigos  : SmallWord;
                NomeDaEmpresa     : String[50{<35}];
                NomeDoSistema     : String[50];
                Cgc               : string[18];{<Cgcccccccccccccccc} {<Obs. variável usado no cabecario dos relatorios}
                InsEstado         : string[18];{<InsEstadoooooooooo}

                Initial_page      : SmallWord;  {<Imprimir a partir de Initial_page}
                Str_Initial_page  : String[30]; {<Intervalo da pagina para imprimir sintaxe do Word
                                                 Exemplo:
                                                   1;3;10-15
                                                   Imprime a 1 e 3 e 10 ate 15}

                Number_Copies     : Byte;  {<Numero de copias}
                Fonts_Size        : Byte;       {<Tamanho da fonte da impressora}

                NomeDaImpressora  : String[100];
                Arquivo           : string[253]; {<Direciona para o arquivo}
                Nome_do_Relatorio : String[80];
                RelativePath      : string[255];
              End;
Var
  PRNOptPP : TPRNOptPP =
  (
                Sequencial        : 0;    {<Numero de impressoras}
                NumeroDeLinhas    : 63;    {<Numero de linhas por pagina }
                NumeroDeColunas   : 133; {<Numero de colunas por pagina}
//                NumeroDeCaracterePorPolegada : 6;
                CPI               : 0; //Tipo TEnum_CPI;
                LPI               : 0;//Enum_6_LPI
                RetratoOuPaisagem : 0;
                Opcoes            : 0;
                Porta             : 0;   {<0 = PRN; 1 = Arquivo }
                PadraoDosCodigos  : 1; //<DrvImp.EnumIC_Epson
                NomeDaEmpresa     : 'ITMS';
                NomeDoSistema     : '/\/\ar/\Icarai';
                Cgc               : ''; {<Obs. variável usado no cabecario dos relatorios}
                InsEstado         : '';{<InsEstadoooooooooo}
                Initial_page      : 1;  {<Imprimir a partir de Initial_page}
                Str_Initial_page  : ''; {<Intervalo da pagina para imprimir sintaxe do Word
                                                 Exemplo:
                                                   1;3;10-15
                                                   Imprime a 1 e 3 e 10 ate 15}

                Number_Copies     : 1;  {<Numero de copias}
                Fonts_Size        : 7;       {<Tamanho da fonte da impressora}

                NomeDaImpressora  : 'Epson';
                Arquivo           : 'MarIcaraiV1.rel'; {<Direciona para o arquivo}
                Nome_do_Relatorio : '';
)
  ;


Const
  IsMonousuario : Boolean = False; {<True = O sistemas esta rodando no modo monousuario}

Type
  TNsStringList = Class(Classes.TStringList)

                    Private _OkDestroy_Object : Boolean;
                    Private _OkInsert : Boolean;


                     protected
//                      function CompareStrings(const S1, S2: String): Integer; override;
                    Public
                     /// <since>
                     ///   • Redefini pq a instancia anterior nao funciona com caractere #254 
                     /// </since>
                     function IndexOf(const S: string): Integer; override;
//                     function IndexOf_AnsiChar(const aChar: AnsiChar): Integer;

                     procedure Delete(Index: Integer); override;
                     Property OkDestroy_Object : Boolean Write _OkDestroy_Object;

                     destructor Destroy; override;

                    Private
                      Index_Currente : Longint; //<  Posição atual no index;
                      _KeyMaster     : String;  //<  Usada criar relacionamento mestre detalhe.
                      Procedure SetKeyMaster(w_KeyMaster : String);

                    Private
                       OkBof,        {<Inicio de arquivo}
                       okEof         : Boolean; {<Fim de arquivo   }

                    public
                       Nr        : Longint; //<  Numero do registro corrente

                       Property KeyMaster : String Read _KeyMaster Write SetKeyMaster;  //<  Usada criar relacionamento mestre detalhe.

                       Function AddKey(WKey:String;wNr:Longint):Boolean;

                       Function FindKey(WKey:String):Boolean;

                       Function SearchKey(WKey:String):Boolean;
                       Function ClearKey: Boolean;//<  Posiciona no inicio do bloco de registro do tipo default
                       Function BofKey : Boolean; //<  Posiciona no inicio do bloco de registro do tipo default
                       Function LastKey: Boolean;//<  Posiciona no fin do bloco de registro do tipo default
                       Function EofKey : Boolean; //<  Posiciona no fin do bloco de registro do tipo default
                       Function NextKey  : Boolean; //<  Posiciona no proximo registro do tipo default
                       Function PrevKey  : Boolean; //<  Posiciona no registro anterior do tipo default

                       Function NewStr(S : String):Boolean;
                       Function Append(S : String):Boolean;

                       procedure AddSItem(P : PSItem;
                                          ConvertIdioma : TConvertIdioma;
                                          OkDisposeSItems:Boolean);Overload; //Adiciona a lista a lista passada por aSItem e desaloca a lista se OkDisposeSItems = true;
                       procedure AddSItem(P : PSItem);Overload;

                  End;
{
Tabela de acentos e caracteres especiais em HTML
"...............&#34;
Á ............. &Aacute;
á ............. &aacute;
Â ............. &Acirc;
â ............. &acirc;
À ............. &Agrave;
à ............. &agrave;
Å ............. &Aring;
å ............. &aring;
Ã ............. &Atilde;
ã ............. &atilde;
Ä ............. &Auml;
ä ............. &auml;
Æ ............. &AElig;
æ ............. &aelig;

É ............. &Eacute;
é ............. &eacute;
Ê ............. &Ecirc;
ê ............. &ecirc;
È ............. &Egrave;
è ............. &egrave;
Ë ............. &Euml;
ë ............. &euml;
Ð ............. &ETH;
ð ............. &eth;

Í ............. &Iacute;
í ............. &iacute;
Î ............. &Icirc;
î ............. &icirc;
Ì ............. &Igrave;
ì ............. &igrave;
Ï ............. &Iuml;
ï ............. &iuml;

Ó ............. &Oacute;
ó ............. &oacute;
Ô ............. &Ocirc;
ô ............. &ocirc;
Ò ............. &Ograve;
ò ............. &ograve;
Ø ............. &Oslash;
ø ............. &oslash;
Õ ............. &Otilde;
õ ............. &otilde;
Ö ............. &Ouml;
ö ............. &ouml;

Ú ............ &Uacute;
ú ............ &uacute;
Û ............ &Ucirc;
û ............ &ucirc;
Ù ............ &Ugrave;
ù ............ &ugrave;
Ü ............ &Uuml;
ü ............ &uuml;

Ç ............ &Ccedil;
ç ............ &ccedil;


Ñ ............ &Ntilde;
ñ ............ &ntilde;


< ............ &lt;
> ............ &gt;
& ............ &amp;
" ............ &quot;
® ............ &reg;
© ............ &copy;


Ý ............ &Yacute;
ý ............ &yacute;


Þ ............ &THORN;
þ ............ &thorn;


ß ............ &szlig;


}
  Const //As 3 constantes abaixo são usadas para identar textos para que o formato seja igual na plataforma console, gui e html.
//     Char_Nivel1 = Ansichar(245);// '§' ; // gui = #§; console = #§; html =  §  <br>

//     Char_Nivel1 = Ansichar(254);        // gui = '•' ; console = #254; html = <font face="Marlett">n</font>   ou &#9689;   <br>
//     Char_Nivel2 = Ansichar(207);//'¤' ; // gui = #207; console = #207; html = <font face="Wingdings">l</font> ou &#9679;         <br>
//     Char_Nivel3 = Ansichar(248);//'°' ; // gui = #248; console = #248; html = <font face="Wingdings">£</font> ou &#9642;         <br>
//     Char_Nivel4 = Ansichar(250);//'·' ; // gui = #250; console = #250; html = <font face="Marlett">h</font>;   Alt 250           <br>

//     Html_Nivel1 = '<font face="Wingdings" size="6">l</font>';//  ou &#9689;
//     Html_Nivel2 = '<font face="Wingdings" size="5">l</font>'; // ou &#9679; 
//     Html_Nivel3 = '<font face="Wingdings" size="4">l</font>'; // ou &#9642;
//     Html_Nivel4 = '<font face="Wingdings" size="2">l</font>'; // Alt 250   

//     Html_Nivel1 = '<font size="6">&#9689;</font>';//  ou &#9689;
//     Html_Nivel2 = '<font size="5">&#9689;</font>'; // ou &#9679; 
//     Html_Nivel3 = '<font size="4">&#9689;</font>'; // ou &#9642;
//     Html_Nivel4 = '<font size="2">&#9689;</font>'; // Alt 250   

//     Html_Nivel1 = '<font size="6">&#9679;</font>';//  ou &#9689;
//     Html_Nivel2 = '<font size="5">&#9679;</font>'; // ou &#9679; 
//     Html_Nivel3 = '<font size="4">&#9679;</font>'; // ou &#9642;
//     Html_Nivel4 = '<font size="2">&#9679;</font>'; // Alt 250   

     Html_Nivel1 = '<font size="6">&#9642;</font>';//  ou &#9689;
     Html_Nivel2 = '<font size="5">&#9642;</font>'; // ou &#9679; 
     Html_Nivel3 = '<font size="4">&#9642;</font>'; // ou &#9642;
     Html_Nivel4 = '<font size="2">&#9642;</font>'; // Alt 250   



     
     Char_Nivel1 = Ansichar(254);        // gui = '•' ; console = #254; html = Html_Nivel1   ou &#9689;   <br>
     Char_Nivel2 = Ansichar(207);//'¤' ; // gui = #207; console = #207; html = Html_Nivel2 ou &#9679;         <br>
     Char_Nivel3 = Ansichar(248);//'°' ; // gui = #248; console = #248; html = Html_Nivel3 ou &#9642;         <br>
     Char_Nivel4 = Ansichar(250);//'·' ; // gui = #250; console = #250; html = Html_Nivel4   Alt 250           <br>



     
                                                                                 
  Type
 {Registro usada na tabela de caracter para conversão das letras acentuadas}
 TReg_Of_Char = Record
                      Asc_Console : Char;
                      Asc_Ingles  : Char;
                      Asc_GUI     : Char;
                      Asc_HTML    : String;
                    end;

 TArray_Of_Char = Array[0..39-1] of TReg_Of_Char;
 Const
   Array_Of_Char : TArray_Of_Char =
   (
//    (Asc_Console : ' ';Asc_Ingles :' ';Asc_GUI :' ';Asc_HTML :'&nbsp;'),   // espaço em branco só em caso especial do contrario o texto fica pre-formatado


    (Asc_Console : ' ';Asc_Ingles :'a';Asc_GUI :'á';Asc_HTML :'&aacute;'), // 00 a Minuscolo com agudo
    (Asc_Console : 'ƒ';Asc_Ingles :'a';Asc_GUI :'â';Asc_HTML :'&acirc;'),  // 01 a Minuscolo com circonflexo
    (Asc_Console : '…';Asc_Ingles :'a';Asc_GUI :'à';Asc_HTML :'&agrave;'), // 02 a Minuscolo com crase
    (Asc_Console : 'Æ';Asc_Ingles :'a';Asc_GUI :'ã';Asc_HTML :'&atilde;'), // 03 a Minuscolo com til
    (Asc_Console : 'µ';Asc_Ingles :'A';Asc_GUI :'Á';Asc_HTML :'&Aacute;'), // 04 A Maiusculo com agudo
    (Asc_Console : '·';Asc_Ingles :'A';Asc_GUI :'À';Asc_HTML :'&Agrave;'), // 05 A Maiusculo com crase
    (Asc_Console : '¶';Asc_Ingles :'A';Asc_GUI :'Â';Asc_HTML  :'&Acirc;'), // 06 A Maiusculo com circonflexo
    (Asc_Console : #199;Asc_Ingles :'A';Asc_GUI :'Ã';Asc_HTML :'&Atilde;'), // 07 A Maiusculo com til
    (Asc_Console : '‡';Asc_Ingles :'c';Asc_GUI :'ç';Asc_HTML :'&ccedil;'), // 08 c cedilha Minuscolo
    (Asc_Console : '€';Asc_Ingles :'C';Asc_GUI :'Ç';Asc_HTML :'&Ccedil;'), // 09 C cedilha maiusculo
    (Asc_Console : '‚';Asc_Ingles :'e';Asc_GUI :'é';Asc_HTML :'&eacute;'), // 10 e Minuscolo com agudo
    (Asc_Console : 'ˆ';Asc_Ingles :'e';Asc_GUI :'ê';Asc_HTML :'ê'),        // 11 e Minuscolo com circonflexo
    (Asc_Console : '';Asc_Ingles :'E';Asc_GUI :'É';Asc_HTML :'&Eacute;'), // 12 E maiusculo com agudo
    (Asc_Console : 'Ò';Asc_Ingles :'E';Asc_GUI :'Ê';Asc_HTML :'&Ecirc;'),  // 13 E maiusculo com circonflexo
    (Asc_Console : '¡';Asc_Ingles :'i';Asc_GUI :'í';Asc_HTML :'&iacute;'), // 14 i Minuscolo com agudo
    (Asc_Console : 'Ö';Asc_Ingles :'I';Asc_GUI :'Í';Asc_HTML :'&Iacute;'), // 15 I maiusculo com agudo
    (Asc_Console : '¢';Asc_Ingles :'o';Asc_GUI :'ó';Asc_HTML :'ó'),        // 16 o Minuscolo com agudo
    (Asc_Console : 'à';Asc_Ingles :'O';Asc_GUI :'Ó';Asc_HTML :'&Oacute;'), // 17 O maiusculo com agudo
    (Asc_Console : 'ä';Asc_Ingles :'o';Asc_GUI :'õ';Asc_HTML :'õ'),        // 18 o Minuscolo com til
    (Asc_Console : 'å';Asc_Ingles :'O';Asc_GUI :'Õ';Asc_HTML :'Õ'),        // 19 O maiusculo com til
    (Asc_Console : '“';Asc_Ingles :'o';Asc_GUI :'ô';Asc_HTML :'ô'),        // 20 o Minuscolo com circonflexo
    (Asc_Console : 'â';Asc_Ingles :'O';Asc_GUI :'Ô';Asc_HTML :'Ô'),        // 21 O maiusculo com circonflexo
    (Asc_Console : '£';Asc_Ingles :'u';Asc_GUI :'ú';Asc_HTML :'ú'),        // 22 u minusculo com agudo
    (Asc_Console : 'é';Asc_Ingles :'U';Asc_GUI :'Ú';Asc_HTML :'&Uacute;'), // 23 U maiusculo com agudo
    (Asc_Console : '';Asc_Ingles :'u';Asc_GUI :'ü';Asc_HTML :'&#252;'),   // 24 u minusculo com trema
    (Asc_Console : 'š';Asc_Ingles :'U';Asc_GUI :'Ü';Asc_HTML :'&#220;'),   // 25 U maiusculo com trema
                                    
    (Asc_Console : #167;Asc_Ingles :'o';Asc_GUI :'º';Asc_HTML     :'º'),    // 26 Simbolo para N º '&167;'
    (Asc_Console : #166;Asc_Ingles :'ª';Asc_GUI :'ª';Asc_HTML   :'ª'),     // 27 letra a SobScrito Sr ª Alt 166
    (Asc_Console : #169;Asc_Ingles :'®';Asc_GUI :'®';Asc_HTML   :'®'),     // 28 Simbola de Marca Registrada ® Alt 169
    (Asc_Console : #174;Asc_Ingles :'«'; Asc_GUI :'«'; Asc_HTML :'«'),    // 29 simbola « = Alt 174                                                                   
    (Asc_Console : #175;Asc_Ingles :'»'; Asc_GUI :'»'; Asc_HTML :'»'),    // 30 simbola « = Alt 175                                                                   
    (Asc_Console : #184;Asc_Ingles :'©'; Asc_GUI :'©'; Asc_HTML :'©'),    // 31 simbola de Copyhight © = Alt 184  
//    (Asc_Console : #207;Asc_Ingles :'¤'; Asc_GUI :'¤'; Asc_HTML :'&#9679;'),    // 32 Simbolo ¤ = Alt 207    
    (Asc_Console : #207;Asc_Ingles :'¤'; Asc_GUI :'¤'; Asc_HTML :Html_Nivel2),    // 32 Simbolo ¤ = Alt 207    
    (Asc_Console : #245;Asc_Ingles :'§'; Asc_GUI :'§'; Asc_HTML :'§'),    // 33 Simbolo de Seção § = Alt 245                                                                             
    (Asc_Console : #246;Asc_Ingles :'÷'; Asc_GUI :'÷'; Asc_HTML :'÷'),    // 34 Simbolo ÷ = Alt 246                                                                                 
    (Asc_Console : #248;Asc_Ingles :'°'; Asc_GUI :'°'; Asc_HTML :Html_Nivel3),    // 35 Simbolo ° = Alt 248                                                                             
    (Asc_Console : #250;Asc_Ingles :'·'; Asc_GUI :'·'; Asc_HTML :Html_Nivel4),    // 36 Simbolo · = Alt 250

  
    
//    (Asc_Console : '"';Asc_Ingles :'"';Asc_GUI :'"';Asc_HTML     :'&quot;'), //37 Simbolo para "  // não posso converter altomáticamente pq " é palavra reservado do código html
    
//    (Asc_Console : #254 ;Asc_Ingles :'•';Asc_GUI :'•';Asc_HTML   :'&#9689;'),      //39  Simbola '•'  = Alt ??? . Não consegui localizar na pesquisa o caractere 
    (Asc_Console : #254 ;Asc_Ingles :'•';Asc_GUI :'•';Asc_HTML   : Html_Nivel1) ,      //39  Simbola '•'  = Alt ??? . Não consegui localizar na pesquisa o caractere     
    
    (Asc_Console : #244;Asc_Ingles :'¶';Asc_GUI :'¶';Asc_HTML   :'¶')      //38  Simbola de Paragrafo = ¶  = Alt 244 . Obs: Preciso encontrar o equivalente no Console.                                     

//    (Asc_Console : #241;Asc_Ingles :'±';Asc_GUI :'±';Asc_HTML   :'±')      //  ±  Alt 241   não deu certo no console

                          
                  

    
//========================================================================================================
{$REGION '--> Não posso usar os caractres abaixo  pq o gerador de manual não encontrará os arquivos com links relativo.'}
//========================================================================================================
{ TODO 4  -oTArray_Of_AnsiChar -cCOMENTARIOS :
 2010/11/18
   • ATENÇÃO: Não posso usar os caractres abaixo  pq do gerador de manual não encontrará os arquivos com links relativo.
   • OBS: Caso o documento seja usado em javascript faz-se necessário converter os caractres " . # para o código HTML
}
{
//    (Asc_Console : '"';Asc_Ingles :'"';Asc_GUI :'"';Asc_HTML :'&#34;'),    //< 26 Aspa
//    (Asc_Console : '#';Asc_Ingles :'#';Asc_GUI :'#';Asc_HTML :'&#35;'),    //< 27 Cancela
//    (Asc_Console : '.';Asc_Ingles :'.';Asc_GUI :'.';Asc_HTML :'&#46;')     //< 28 Ponto
}

{$ENDREGION}
//========================================================================================================

   );

type
 {Registro usada na tabela de caracter para conversão das letras acentuadas}
 TClass_Of_Char = Class(TObject)
                   //Propriedade Asc_Ingles
                   Private _Asc_Ingles  : Char;
                   Public  Property Asc_Ingles  : Char       Read _Asc_Ingles;

                   //Propriedade Asc_Console
                   Private _Asc_Console : Char;
                   Public Property Asc_Console : Char       Read _Asc_Console;

                   //Propriedade Asc_GUI
                   Private _Asc_GUI            : Char;
                   Public Property Asc_GUI     : Char       Read _Asc_GUI;

                   //Propriedade Asc_HTML
                   Private _Asc_HTML    : String;
                   public Property Asc_HTML    : String Read _Asc_HTML;


                   Public Constructor Create(aAsc_Ingles  : Char;
                                        aAsc_Console      : Char;
                                        aAsc_GUI          : Char;
                                        aAsc_HTML         : String);
                 End;
Const
  List_Class_Of_Char     : TNsStringList = nil;
  List_Class_Of_Char_GUI : TNsStringList = nil;

Const
  Tb_Metodo_NewRecord = 'NEWREC';
  Tb_Metodo_AddRec    = 'ADDREC';
  Tb_Metodo_UpDateRec = 'UPDATEREC';
  Tb_Metodo_DeleteRec = 'DELETEREC';
  Tb_Metodo_Next      = 'NEXTREC';
  Tb_Metodo_Prev      = 'PREVREC';
  Tb_Metodo_Find      = 'FINDREC';
  Tb_Metodo_Search    = 'SEARCH';
  Tb_Metodo_Bof       = 'GOBOF';
  Tb_Metodo_Eof       = 'GOEOF';
  Tb_Metodo_AddRec_or_UpDate_REC = 'ADDREC_OR_UPDATE_REC'; //<  Se o evento NEWREC for chamado antes executa ADDREC.
                                                           //<  Se os evento NEXTREC ou PREVREC ou FINDREC ou  SEARCH or GOBOF ou GOEOF
                                                           //<  foi chamado antes e o registro foi alterado entao executa UPDATEREC.


  Tb_Metodo           : TNsStringList = nil;


Type
 TMargins = Record
              Margin_Left       : integer;
              Margin_Right      : integer;
              Margin_Top        : integer;
              Margin_Baseboard  : integer;
            End;

Type
  TAlign = (Align_Original, {<O Texto original}
            Align_Left,Align_Center,Align_Right,Fill_with_spaces);
  TAlinhamento = (Alinhamento_Direita,Alinhamento_Central,Alinhamento_Esquerda,Alinhamento_Justificado);


var
  ok_Set_Transaction   : BOOLEAN = false;

  Font_Default      : tString = 'Courier';
  Font_Size_Default : Byte = 7;
  AnsiChar_Control_Template : AnsiCharSet = [#0..#31,'`',^a..^z,^A..^Z];

  Tipo_de_Codigo_Fonte : TTipo_de_Codigo_Fonte = TCF_Texto;
  Size_Header_Record   : Byte = 5;{<Tamanho do cabecario do registro}
  Size_Header_Table    : Byte = 18;{<Tamanho do cabecario do arquivo Sizeof(TsImagemHeader)}

Const

    { tvDMX Field access attributes }
  { tvDMX Field access attributes }
  accNormal      =  $0; //00000000 - Campo editavel
  accReadOnly    =  $1; //00000001 - Somente para leitura
  accHidden      =  $2; //00000010 - Campo invis=vel
  accSkip        =  $4; //00000100 - Passe para o próximo campo
  accDelimiter   =  $8; //00001000
  accExternal    =  $10;//00010000 - for future use }
  accSpecA       =  $20;//00100000
  accSpecB       =  $40;//01000000
  accSpecC       =  $80;//10000000


  fldStr              =   'S';  //< tString Field maiúscula
  fldStr_Minuscula    =   's';  //< tString Field minusculo
  fldStrNumber           =   '#';  //< numeric tString Field
  fldAnsiChar             =   'C';  {< AnsiCharacter Field }
  fldAnsiChar_Minuscula   =   'c';  {< AnsiCharacter Field }
  fldDoublePositive          =   '0';  {< numeric AnsiCharacter Field }
  fldDouble          =   'N';  {< dbase formatted numeric Field }
  fldByte             =   'B';  {< byte Field }
  fldShortInt         =   'J';  {< shortint Field }
{ fldWORD             =  'W';}  {< word Field }
  fldSmallWord        =   'W';  {< word Field NortSoft}
{ fldInteger          =  'I'; } {< integer Field }
  fldSmallInt         =   'I';  {< integer Field NortSoft}
  fldLongInt          =   'L';  {< longint Field }
  fldDouble          =   'R';  {< real number Field  (uses TRealNum) }
  fldDoublePositive =   'r';  {< real number Field positive (uses TRealNum) }
  fldBoolean          =   'X';  {< boolean value Field }
  fldHexValue         =   'H';  {< hexadecimal numeric entry }
  fldENUM             =   ^E;   {< enumerated Field }
  fldBLOb             =   ^M;   {< unformatted data Field }

{  fldCheckBox,FldRadioButton          =   'K';}  {< 'K'=CheckBox; 'k'=RadioButton }

  fldCheckBox         =   'K';  {<fldCheckBox,FldRadioButton Campo Bit onde varios bits podem estar setado ao mesmo tempo}
  FldRadioButton      =   'k';  {<fldCheckBox,FldRadioButton Campo Bit onde apenas 1 bit pode estar setado               }

  fldZEROMOD          =   'Z';  {< zero modifier }
  fldCONTRACTION      =   '`';  {< limit of visible text }
  fldAPPEND           =   ^G;   {< append from pointer }
  fldSItems           =   ^I;   {< link to chain of TSItem Templates }
  fldXSPACES          =   ' ';  {< spaces --extended code follows <Esc> }
  fldXTABTO           =   ^I;   {< tab    --extended code follows <Esc> }
  fldXFieldNUM        =   ^F;   {< fnum   --extended code follows <Esc> }

  fldExtended       = 'E'; {<Real 10 bytes}
  fldReal6          = 'O';  {< Real 6 Byte positivos e negativos }
  fldReal6Positivo  = 'o';  {< Real 6 Byte positivos}
  fldReal6P         = 'P';  {< P = Real de mostrado x por 100 positivos e negativos}
  fldReal6PPositivo = 'p';  {< P = Real de mostrado x por 100 positivos}

  fldData   = 'D';  {< D = TipoData DD/DD/DD}

  fld_LData = 'd' ;  {< d = Longint;Guarda a data compactada 'dd/dd/dd'}

  fldLData  = #1  ;  {< #1 = Longint;Guarda a data compactada '##/##/##'}
  FldSData  = '##/##/##';

  fldLHora  = #2 ;  {< #2 = Longint;Guarda a hora compactada  ##:##:##}
  FldSHora  = '##:##:##';

  fld_LHora = 'h';  {< h = Longint;Guarda a hora compactada   hh:hh:hh}


  FldOperador = #3; {< #3 = Byte indica que o campo ‚ um operador matemático}

  FldDateTimeDos = #4 ;  {< #4 = Longint;Guarda a data e hora compactada  ##/##/## ##:##:## e o ano não pode ser menor que 1980.}
  FldSDateTimeDos  = '##/##/## ##:##:##';


  CharShowPassword  = ^W;  {< Usado para omitir da os caracteres que estão sendo digitados em qualquer tipo de campo}
  CharExecProc   = ^T;  {< O Ponteiro para um procedimento}


    { the same Date Field with a Day/Month/Year sequence }
    TypeDate = '\ ZB'+^F+^U+AnsiChar(31)+#0+'/'+'ZB'+^U+AnsiChar(12)+#0+'/'+'ZB'+#0+^F;

    _TypeDate = '\ ZB'+^F+^U+AnsiChar(31)+#0+'/'+'ZB'^U+AnsiChar(12)+#0+'/'+'ZB'{+#0}+^F;

    TypeHora = '\ ZB'+^F+^U+AnsiChar(24)+#0+':'+'ZB'^U+AnsiChar(60)+#0+':'+'ZB'^U+AnsiChar(60)+#0+^F;

    FldMemo  = 'M';
    TypeMemo  = '\ZB'+^F+#0'ssssssssss'#0'ZZZZZZZL'#0'ZZZZW'#0'ZZZZW'+#0+^F; {<Usado em conjunto com FldBLob}

(*  TypeMemo representa o registro TCampovariávelEmDisco
    TCampovariávelEmDisco = ^TCampovariávelEmDisco;
    TCampovariávelEmDisco = {<variável usada em campos com tamanho variável}
    Record
      {Os 2 campo a seguir sao definidos no objeto que utiliza-o}
      TipoDoObjeto    : TTCampoObjvariável; {<Memo; Figura; Array etc}
      MaxBytesAlocado : SmallWord;    {<Numero maximo de bytes que o campo pode ter           }

      {Os 2 campos a seguir sao atualizados nas funcoes addRec,DeleteRec}
      NrPrimeiro      : Longint; {<Pointeiro para o primeiro da lista no arquivo vari vel}
      BytesAlocado    : SmallWord;    {<Numero de bytes em uso no objeto                      }
    End;
*)

  CTypeReal =  [fldDouble,fldReal6,fldReal6P,fldDoublePositive,fldExtended];
  CTypeAnsiChar       =  [fldAnsiChar,fldAnsiChar_Minuscula,fldDouble];
  CTypeString     =  [fldStrNumber,fldStr,fldStr_Minuscula];
  CTypeInteger    =  [fldENUM,fldBoolean,fldByte,fldShortInt,fldSmallWord,fldSmallInt,fldLongInt,fldCheckBox,FldRadioButton];
  CTypeDate       =  [fldData,fldLData,fld_LData,FldDateTimeDos];
  CTypeHour       =  [fldLHora,fld_LHora];
  CTypeBlob       =  [FldMemo,fldBLOb];
  CTypeOperator   =  [FldOperador];
  CTypeKnown      : AnsiCharSet = CTypeReal
                                + CTypeAnsiChar
                                + CTypeString
                                + CTypeInteger
                                + CTypeDate
                                + CTypeHour
                                + CTypeBlob
                                + CTypeOperator;


{Type
  ShortString = String;
  SmallInt    = Integer;}{<-32768..32767}


Const
{Extecos usadas pelo banco de dados:}

  Const_Ext_Tabela           = '.Tb'; {<  Tabela}
  Const_Ext_Indice_da_tebela = '.Ix';

  Const_Ext_Tabela_com_a_copia_da_versao_anterior_da_tabela = '.Tb_'; {<  Tabela com a copia da versao anterior da tabela. }

  Const_Ext_Tabela_de_objetos_vinculados_a_tabela = '.TbO';
  Const_Ext_Tabela_com_os_registro_duplicados     = '.Tb1';

  Const_Ext_Tebela_com_as_Tabelas          = '.TbT';
  Const_Ext_Indice_da_Tabela_das_tabelas   = '.IxT';

  Const_Ext_Tabela_com_os_Indices       = '.TbI';
  Const_Ext_Indice_da_tebala_de_Indices = '.IxI';

  Const_Ext_Tabela_com_os_Relationships        = '.TbR';
  Const_Ext_Indice_da_tebala_dos_Relationships = '.IxR';

  Const_Ext_Tabela_com_todos_os_campos_de_todas_as_tabelas = '.TbC';
  Const_Ext_Indice_da_tabela_com_todos_os_campos           = '.IxC';

  Const_Ext_Tabela_de_Parametros           =  '.TbP';

  Const_Ext_Tabela_de_Usuarios            = '.TbU';
  Const_Ext_Indice_da_Tabela_de_Usuarios  ='.IxU';

  Const_Ext_Backup_da_Tabela              = '.TbK';

  {Extencoes conhecidas de outros banco de dados}

  {ACCESS}
  Const_Ext_Banco_de_dados_Access             = '.Mdb';
  Const_Ext_Banco_de_dados_Access_Secundario  = '.ldb';

{  Interbase}
  Const_Ext_Banco_de_dados_Interbase             = '.GDB';

{Paradox}
  Const_Ext_Tabela_Paradox                       = '.Db';
  Const_Ext_Tabela_Paradox_Px                    = '.Px';
  Const_Ext_Tabela_Paradox_Yx                    = '.Yx';

{DBF}
  Const_Ext_Tabela_DBF                           = '.DBF';
  Const_Ext_Tabela_DBF_Ndx                       = '.Ndx';
  Const_Ext_Tabela_DBF_Idx                       = '.Idx';

{Word}
  Const_Ext_Tabela_Word                          = '.Doc';

{Excel}
  Const_Ext_Tabela_Excel                         = '.Xls';


  {Observacao esta faltando varios outros tipos conhecidos}
  Const_Ext_Array : Array[1..24] of string[4] = (
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

{----------------------------------------------}
TYPE
  TSetByte = Set of byte;
  AnsiChar2    = Array[1..2] of AnsiChar;
  AnsiChar4    = Array[1..4] of AnsiChar;
  Str1            = String[1];
  TipoHora       = record
                     H,M,S,S100 : Word;
                   end;
  TipoVarSetLeia  = Record
                      LinHelpLeia       : Byte       ;
                      colHelpLeia       : Byte       ;
                      TituloLeia        : String[40] ;
  End;

  TipoProc   = Procedure;
  TShow_HTML = Function(aURL:AnsiString):system.integer; //<  Retorna 0 se tiver sucesso ou o código do erro se for fracasso

var
  EndProcShiftF9 : TipoProc = Nil ; {<Usado em Vi_Grid_Table e Vi_Forms_Table}
  Show_HTML      : TShow_HTML = nil;


Const
  MaxArrayByte     = 65534;
  MaxArrayPtr      = 65534 div sizeof(Pointer);
  MaxArrayLong     = 65534 div sizeof(Longint);
{type
  TipoOfsSeg = Record Ofs,Seg: SmallWord; End;
  MatrizStr64 = array[1..3] of string[64]; // Usado na ConvValorExt

  PArrayAnsiChar  = ^TArrayAnsiChar;
  TArrayAnsiChar  = Array[0..254] of AnsiChar;

  TArrayOpenAnsiString = Array of AnsiString;
  TArrayOpenVariant    = Array of Variant;
  TArrayOpenByte       = Array of Byte;
  TArrayOpenInteger    = Array of Integer;
  TArrayOpenLongint    = Array of Longint;
  TArrayOpenWord       = Array of Word;
  PArrayByte = ^TArrayByte;
  TArrayByte  = array[0..MaxArrayByte - 1] of Byte;  //Array de Byte

  TAnsiCharArray  =  array[0..65534] of AnsiChar;
  PAnsiCharArray  = ^TAnsiCharArray;

  PArrayInt  = ^TArrayInt;
  TArrayInt   = array[0..High(SmallInt)] of Byte;         //    Array de Inteiros ou SmallWord

  PArrayLong = ^TArrayLong;
  TArrayLong  = array[0..MaxArrayLong-1] of Longint;  //Array de Longint

  PArrayPtr  = ^TArrayPtr;
  TArrayPtr  = array[0..MaxArrayPtr - 1] of Pointer;

  PByte      = ^Byte;
  PSmallInt   = ^SmallInt;
  PLongint   = ^Longint;
  PSmallWord      = ^SmallWord;
  PReal      = ^Real;
  PDouble    = ^Double;
  PExtended  = ^Extended;
}
type
  TipoFuncao = Function : Boolean;{< Usado em GT (Get. defina campos para entrada de dados) }
  TipoTurboError  = FUNCTION (Const ErrorCode : SmallWord) : AnsiString;

{=========================================================================}
var
  TeclaF       : SmallInt = 0;
  EmpresaSelecionada : Byte = 1; {<Usada em ObjInst.Pas}


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
  {$REGION ' ---> Tarefa: Falta defiir os números hexadecimal dos binários abaixo'}
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

//====================================================================================================
{$Region '//*** MB_St = Constantes usadas para indicar o estado (State) do objeto  . ***'}
//====================================================================================================
    Const
    {Obs esta constante usam os bits 16 a 32 por que a visao usa os outros 0 a 15}

    {0=nao Inicializado ou inicializado        ;
     1=Iniciando    }
      Mb_St_Creating          = Mb_Bit16;

    {0=Nao esta criando index;
     1=Esta criando o Index}
      Mb_St_Creating_Index    = Mb_Bit17;

    {0=Nao esta esta indexando; Mb_St_Indexing
     1=Esta indexando a tabela }
      Mb_St_Indexing           = Mb_Bit18;

    {0=Nao esta Criando o Relationship  ;
     1=Criando relacioamento}
      Mb_St_Creating_Relating = Mb_Bit19;

    {0=nao esta Relationship;
     1=Relationship}
      Mb_St_Related            = Mb_Bit20;

    {0=Tabela Fechada         ;
     1=Tabela aberta      }
      Mb_St_Active             = Mb_Bit21;

    {0=Nao esta sendo editada ;
     1=Esta sendo editada.}
      Mb_St_Edit               = Mb_Bit22;

    {0=Nao esta esta travado para edicao;
     1=Esta esta travado para edicao  }
      Mb_St_Locked             = Mb_Bit23;

    { 0= A tabela nao esta incluindo registro
      1= A tabela esta incluindo registro}
      Mb_St_AddRec             = Mb_Bit24;

    {0= A tabela nao esta atualizando
     1= A tabela esta atualizando }
      Mb_St_UpdateRec         = Mb_Bit25;

    {0= A tabela nao esta excluindo registro
     1= A tabela esta excluindo registro}
      Mb_St_DeleteRec          = Mb_Bit26;

    {0= A tabela nao esta listando
     1= A tabela esta sendo listada }
      Mb_St_Report             = Mb_Bit27;

    {Obejtivo:
        Este estado desconcidera os erros nos Relationships.
        So deve ser setado nas visoes para mostrar os campos
        Relationados se existirem nas tabelas relacionadas.

        0= A tabela nao esta sendo sincronizada
        1= A tabela esta sendo sincronizada }
      Mb_St_Synchronizing      = Mb_Bit28;

    { Mb_St_non_critic_if_active_commands  = Não critica se comandos de edição da tabela estão ativos.
      Obejtivo:
        Abilita ou não as criticas vinculadas ao estado dos comandos de atualização da tabela.
        Exemplo:
           Para cancelar Nota Fiscal o botao de gravar fica desabilitado e a visão da nota fiscal fica travada,
           para que o usuario não altere manualmente a nota na opção de cancelamento de notas fiscais.

           O estado de Mb_St_Active_Command = 1 para que o programa possar cancelar a nota mesmo
           que o comando de gravação esteja desabilitado.


        0 = Critica.     Obs: So atualizar a tabela se o comando de atualização estiver abilitado.
        1 = Não critica. Obs: Atualizar a tabela independente do estado comando. Ou melhor desconsiderar se comando esta abilitado ou não.
    }
      Mb_St_non_critic_if_active_commands     = Mb_Bit29;

    {0=Nao esta calculando registro ;
     1=Esta calculando registro.}

      Mb_OnCalcRecord                         = Mb_Bit30;

    {0=Nao esta destruindo ;
    1=Esta destrindo.}
      MB_Destroying                           = Mb_Bit31;


     /// <since>
     ///   0=Nao esta criando Template;
     ///   1=Esta criando o Template
     ///
     ///
     ///   . Após o Template ser criado o tipo de acesso dos campos invisiveis não devem ser trocados.
     ///   . Motivo: Quando um campo é invisível o designer para mostrar o mesmo é ignorado e caso o mesmo torne-se visível ele ficará sem identificação do que se trata.
     /// </since>
      Mb_St_Creating_Template                = Mb_Bit32;


     /// <since>
     ///   0=Nao esta connectando o Banco de dados;
     ///   1=Esta conectando banco de dados
     ///
     ///
     ///   . Usa
     ///   . Motivo: A Class TArqParametros é criado automaticamente porém quando está desconectando o mesmo não deve ser criado.
     /// </since>
//      Mb_St_DB_connecting                = Mb_Bit32;




{$EndRegion '//*** MB_St = Constantes usadas para indicar o estado (State) do objeto  . ***'}
//====================================================================================================

  Enter     = ^M;
  Esc       = #27;
  Tab       = #9;
  ShiftTab  = #0#15;

Var
//  TaStatus  : integer = 0;
  FileModeDenyALL : Boolean = False; {< Indica se o arquivo e exclusivo. Usado em Set_FileModeDenyALL  }
//  OK        : Boolean = True;  {< Usada para salvar temporariamente se uma operacao teve sucesso. }
  OkAbort   : Boolean = False; {< O padrao nao permite abortar o processo}

  NRecAux      : Longint = 0;
  NRec         : Longint = 0;  {< Numero do registro acessado  }

const
  {
    Comando predefinidos.
    Os comandos de usuario cresse de 0 a MaxSmallWord
    Os comandos predefinidos descressem de MaxSmallWord a 0
  }
  CmPredefido                    = MaxSmallWord; {<Inicio dos comandos usado pelas rotinas genericas}
  CmCliente                      = 0;   {<Camando das aplicacoes cliente}
  CmRedirecionaParaImpressora    = CmPredefido -1;
  CmEnterMenuLocal               = CmPredefido -4;
  CmQuitMenuLocal                = CmPredefido -5;
  cmNovaImpressora               = CmPredefido -6;
  cmEditaImpressora              = CmPredefido -7;
  cmApagaImpressora              = CmPredefido -8;
  CmOpcoesI                      = CmPredefido -10;// Incluir opções
  CmOpcoesA                      = CmPredefido -11;// Alterar opções
  CmOpcoesE                      = CmPredefido -12;// Excluir opções

{********************************************************************}
resourcestring //Padrão de código dos recursos é GUI.
//SCmPredefido                    = maxint; {<Inicio dos comandos usado pelas rotinas genericas}
//SCmCliente                      = 0;   {<Camando das aplicacoes cliente}
  SCmRedirecionaParaImpressora    = 'Redireciona para impressora';
  SCmEnterMenuLocal               = 'Entrar no menu local';
  SCmQuitMenuLocal                = 'Sair do menu local';
  ScmNovaImpressora               = 'Incluir impressora no arquivo';
  ScmEditaImpressora              = 'Alterar arquivo de impressora';
  ScmApagaImpressora              = 'Excluir um impressora no arquivo';

  SCmOpcoesI                      = 'Incluir opções';
  SCmOpcoesA                      = 'Alterar opções';
  SCmOpcoesE                      = 'Excluir opções';

CONST
 {Comandos do Banco de dados}
  {O TVision V.20 usa no max 84

   Portanto posso usar de 85 a 100 ou seja 85+15
   Para comandos genericos.
   A documentacao recomenda usar 100 a 255

   Vou reservar para mim 85 a 109 para comandos Genericos que ncessitam ser
   desabilitados.

   A aplicacao usa de 110 a 255. Necessario para que se possa que o
   usuario pai possa desabilitar as opcoes dos filhos.
  }
  {TCmDb}
  CmNulo                =          100 {<84};
  CmDbNextRec           = CmNulo + 01;
  CmDbPrevRec           = CmNulo + 02;
  CmDbNextRecValid      = CmNulo + 03;
  CmDbPrevRecValid      = CmNulo + 04;
  CmDbFindRec           = CmNulo + 05;
  CmDbSearchRec         = CmNulo + 06;
  CmDbGoEof             = CmNulo + 07;
  CmDbGoBof             = CmNulo + 08;
  CmDbLocaliza          = CmNulo + 09; //Não precisa ser desabilitado
  CmNewRecord           = CmNulo + 10;
  CmZeroizeRecord       = CmNulo + 11;
  CmEvaluateRecord      = CmNulo + 12;
  CmEditDlg             = CmNulo + 13;
  cmMyOK                = CmNulo + 14;
  cmMyCancel            = CmNulo + 15;
  cmPrint               = CmNulo + 16;
//  cmHomePage            = CmNulo + 17; O comando CmHomePage nao precisa desabilitar.
  CmImport              = CmNulo + 17;
  CmProcess             = CmNulo + 18;
  CmExecEndProc         = CmNulo + 19; //<  Usando para acessar a pesquisa associado ao campo
  CmExecComboBox        = CmNulo + 20; //<  Usando para acessar a visao associada ao campo. Usado para visualizar CamposEnumerado e lista de forma geral
  CmExecCommand         = CmNulo + 21; //<  O comando vinculado ao campo focado e disparado para apliication.HanleEvent() se

  CmCreate_Shortcut     = CmNulo + 22; //<  Cria um atalho do programa corrente no desktop do windows
                                       //<  e passa como parametro todas as tecla digitada entre o inicio e o fin da criação do atalho.
  CmVisualizar          = CmNulo + 23;
  CmExport_Stru         = CmNulo + 24; //<  Exporta a estrutura das consultas para o arquivo Schema.ini
  CmExport              = CmNulo + 25; //<  Exporta a consulta seleciona para varios formatos de arquivos a serem implementados

  // ...
  CmInt                 = CmNulo + 29;  {<= Limit dos comandos genericos que pode ser desabilitados}

  TCmLivre    = [CmVisualizar..CmInt];
{********************************************************************}

resourcestring //Padrão de código dos recursos é GUI.
  SCmDbNextRec          = 'Próximo registro';
  SCmDbPrevRec          = 'Registro Anterior';
  SCmDbNextRecValid     = 'Próximo registro válido';
  SCmDbPrevRecValid     = 'Registro válido anterior';
  SCmDbFindRec          = 'Atualiza o registro atual';
  SCmDbSearchRec        = 'SCmDbSearchRec';
  SCmDbGoEof            = 'Último registro';
  SCmDbGoBof            = 'Primeiro registro';
  SCmDbLocaliza         = 'Localiza registro';
  SCmNewRecord          = 'Novo registro';
  SCmZeroizeRecord      = 'Apaga o registro atual';
  SCmEvaluateRecord     = 'Grava o registro atual';
  SCmEditDlg            = 'Edita o registro atual';
  ScmMyOK               = 'Ok';
  ScmMyCancel           = 'Cancelar';
  ScmPrint              = 'Imprimir';
  SCmImport             = 'Importar';
  SCmProcess            = 'Processa';
  SCmExecEndProc        = 'SCmExecEndProc';  //<  Usando para acessar a pesquisa associado ao campo
  SCmExecComboBox       = 'SCmExecComboBox'; //<  Usando para acessar a visao associada ao campo. Usado para visualizar CamposEnumerado e lista de forma geral
  SCmExecCommand        = 'SCmExecCommand';  //<  O comando vinculado ao campo focado e disparado para apliication.HanleEvent() se

  SCmCreate_Shortcut    = 'Cria atalho no desktop do windows'; //<  Cria um atalho do programa corrente no desktop do windows
                                                              //<  e passa como parametro todas as tecla digitada entre o inicio e o fin da criação do atalho.
  SCmVisualizar         = 'Visualizar';
  SCmExport_Stru        = 'Exportar estrutura da tabela'; //<  Exporta a estrutura das consultas para o arquivo Schema.ini
  SCmExport             = 'Exporta'; //<  Exporta a consulta seleciona para varios formatos de arquivos a serem implementados


const
  TCmCommands = [CmInt..255];
  TCmDb       = [CmDbNextRec    ,
                 CmDbPrevRec    ,
                 CmDbNextRecValid,
                 CmDbPrevRecValid,
                 CmDbFindRec    ,
                 CmDbSearchRec  ,
                 CmDbGoEof      ,
                 CmDbGoBof      ,
                 CmDbLocaliza
                ];
  TcmDbView    = [cmMyOK                  ,
                  cmMyCancel               ,
                  CmEditDlg                ,
                  CmEvaluateRecord         ,
                  cmZeroizeRecord          ,
                  CmNewRecord,
                  CmProcess,
                  cmPrint,
                  CmExecEndProc,
                  CmExecComboBox
               ];
  TCmOutros        =[cmPrint];
{********************************************************************}
  CmNortSoft           = 50000; {<Camandos comuns que nao podem serem desabilitados}
  CmDbAddRec           = CmNortSoft + 001;
  CmDbDeleteRec        = CmNortSoft + 002;
  CmDbGetRec           = CmNortSoft + 003;
  CmDbPutRec           = CmNortSoft + 004;
  CmDbUpdateRec        = CmNortSoft + 005;
  CmDbSearchTop        = CmNortSoft + 006;
  CmDbSearchKey        = CmNortSoft + 007;
  CmDbUsedRecs_Valid    = CmNortSoft + 008;
  CmOkEscrevaParametrosDosRelatorios = CmNortSoft + 009;
  CmDbSelecionaIndice   = CmNortSoft + 010;
  LivreCmVisualisa      = CmNortSoft + 011;
  CmQuitInterno         = CmNortSoft + 012;
  CmSobre               = CmNortSoft + 013;
  CmDbOnEnter           = CmNortSoft + 014;
  CmDbOnExit            = CmNortSoft + 015;
  cmCores               = CmNortSoft + 016;
  CmF7                  = CmNortSoft + 017;
  CmDbLabel_DoubleClick = CmNortSoft + 018;
  cmDbView_DoubleClick  = CmNortSoft + 019;
  CmDbOrdemCressante    = CmNortSoft + 020;
  CmDbOrdemDecrescente  = CmNortSoft + 021;
  CmDbSelecColunaAtual  = CmNortSoft + 022;
  CmMouseDownmbRightButton = CmNortSoft + 023; {<Gerado quando o botao do lado direito ‚ pressionado}
  CmReindex             = CmNortSoft + 024;
  CmCadastraImpressoraRede  = CmNortSoft + 025;
  CmInfoSystem          = CmNortSoft + 026;{<Lista a rotina com as informacoes tecnicas do sistema}
  cmPrintSemFormatar    = CmNortSoft + 027;{<Lista um arquivo texto sem formatacao de TvDmxReport}
  CmDbDoBeforeInsert      = CmNortSoft + 028;
  CmDbDoBeforePost        = CmNortSoft + 029;
  CmDbDoBeforeDelete      = CmNortSoft + 030;
  CmDbDoAfterInsert       = CmNortSoft + 031;
  CmDbDoAfterPost         = CmNortSoft + 032;
  CmDbDoAfterDelete       = CmNortSoft + 033;
  CmTb_SelectRefCruzadaResume = CmNortSoft + 034;
  CmTb_SelectSelect           = CmNortSoft + 035;
  CmTb_SelectResume           = CmNortSoft + 036;
  CmRegistroValido            = CmNortSoft + 037;
  CmCopyTo                    = CmNortSoft + 038;
  CmCadastraImpressoraLocal   = CmNortSoft + 039;
  CmSetAppending              = CmNortSoft + 040;
  CmStartTransaction          = CmNortSoft + 041;
  CmCommit                    = CmNortSoft + 042;
  CmRollback                  = CmNortSoft + 043;
  CmOnCalcRecord_All          = CmNortSoft + 044; //<  Varre toda a tabela executando o evento OnCalcRecord
  CmTime                      = CmNortSoft + 045; //<  Este comando faz com que o sistema dar um tempo de TimeCmTime.
  cmEditaCores                = CmNortSoft + 046;
  cmSalvaCores                = CmNortSoft + 047;
  cmHomePage                  = CmNortSoft + 048;
  CmDbPack                    = CmNortSoft + 049;

{********************************************************************}
resourcestring //Padrão de código dos recursos é GUI.
  SCmDbAddRec             = 'Adicionar registro';
  SCmDbDeleteRec          = 'Apagar registro selecionado';
  SCmDbGetRec             = 'Ler registro selecionado';
  SCmDbPutRec             = 'Gravar registro selecionado';
  SCmDbUpdateRec          = 'Atualizar registro selecionado caso tenha sido alterado';
  SCmDbSearchTop          = 'Pesquisar primeira ocorrência a partir do topo da tabela';
  SCmDbSearchKey          = 'Pesquisar primeira ocorrência a partir do inicio da tabela';
  SCmDbUsedRecs_Valid     = 'CmDbUsedRecs_Valid';
  SCmOkEscrevaParametrosDosRelatorios = 'Escreva parâmetros dos relatórios';
  SCmDbSelecionaIndice    = 'Selecionar indice';
  SLivreCmVisualisa       = 'CmLivreCmVisualisa';
  SCmQuitInterno          = 'Quit interno';
  SCmSobre                = 'Sobre';
  SCmDbOnEnter            = 'CmDbOnEnter';
  SCmDbOnExit             = 'CmDbOnExit';
  ScmCores                = 'cmCores';
  SCmF7                   = 'Seleciona as opções para o campo selecionado';
  SCmDbLabel_DoubleClick  = 'CmDbLabel_DoubleClick';
  ScmDbView_DoubleClick   = 'cmDbView_DoubleClick';
  SCmDbOrdemCressante     = 'Ordem cressante';
  SCmDbOrdemDecrescente   = 'Ordem decrescente';
  SCmDbSelecColunaAtual   = 'CmDbSelecColunaAtual';
  SCmMouseDownmbRightButton = 'CmMouseDownmbRightButton'; {<Gerado quando o botao do lado direito ‚ pressionado}
  SCmReindex                = 'Cria indices dos arquivos';
  SCmCadastraImpressoraRede  = 'Cadastra impressora da rede';
  SCmInfoSystem            = 'Informações do sistema';{<Lista a rotina com as informacoes tecnicas do sistema}
  ScmPrintSemFormatar      = 'cmPrintSemFormatar';{<Lista um arquivo texto sem formatacao de TvDmxReport}
  SCmDbDoBeforeInsert      = 'CmDbDoBeforeInsert';
  SCmDbDoBeforePost        = 'CmDbDoBeforePost';
  SCmDbDoBeforeDelete      = 'CmDbDoBeforeDelete';
  SCmDbDoAfterInsert       = 'CmDbDoAfterInsert';
  SCmDbDoAfterPost         = 'CmDbDoAfterPost';
  SCmDbDoAfterDelete       = 'CmDbDoAfterDelete';
  SCmTb_SelectRefCruzadaResume = 'CmTb_SelectRefCruzadaResume';
  SCmTb_SelectSelect           = 'CmTb_SelectSelect';
  SCmTb_SelectResume           = 'CmTb_SelectResume';
  SCmRegistroValido            = 'Registro válido';
  SCmCopyTo                    = 'Copiar para';
  SCmCadastraImpressoraLocal   = 'Cadastra impressora local';
  SCmSetAppending              = 'CmSetAppending';
  SCmStartTransaction          = 'Inicia uma transação';
  SCmCommit                    = 'Confirma transação';
  SCmRollback                  = 'CmRollback';
  SCmOnCalcRecord_All          = 'Calcula todos os registros'; //<  Varre toda a tabela executando o evento OnCalcRecord
  SCmTime                      = 'Time'; //<  Este comando faz com que o sistema dar um tempo de TimeCmTime.
  ScmEditaCores                = 'Edita cores';
  ScmSalvaCores                = 'Salva cores';
  ScmHomePage                  = 'Gera documento no formato HTML do formulário atual';
  SCmDbPack                    = 'Pack';



  Type
    TArray_Db_Global = Array[1..14+3] of TCommandStr;
  Const
    Array_Db_Global : TArray_Db_Global =
    (
    (Active:True; Option_Basic:True; Command:CmProcess;CommandStr:'CmProcess'),
    (Active:True; Option_Basic:True; Command:CmSobre;CommandStr:'CmSobre'),
    (Active:True; Option_Basic:True; Command:cmCores;CommandStr:'cmCores'),
    (Active:True; Option_Basic:True; Command:CmReindex;CommandStr:'CmReindex'),
    (Active:True; Option_Basic:True; Command:CmDbLocaliza;CommandStr:'CmDbLocaliza'),
    (Active:True; Option_Basic:True; Command:CmEvaluateRecord;CommandStr:'CmEvaluateRecord'),
    (Active:True; Option_Basic:True; Command:CmNewRecord;CommandStr:'CmNewRecord'),
    (Active:True; Option_Basic:True; Command:CmZeroizeRecord;CommandStr:'CmZeroizeRecord'),
    (Active:True; Option_Basic:True; Command:CmEditDlg;CommandStr:'CmEditDlg'),
    (Active:True; Option_Basic:True; Command:cmPrint;CommandStr:'cmPrint'),
    (Active:True; Option_Basic:false; Command:cmHomePage;CommandStr:'cmHomePage'),
    (Active:True; Option_Basic:false; Command:cmEditaCores;CommandStr:'cmEditaCores'),
    (Active:True; Option_Basic:false; Command:cmSalvaCores;CommandStr:'cmSalvaCores'),
    (Active:True; Option_Basic:true; Command:CmVisualizar;CommandStr:'CmVisualizar'),
    (Active:True; Option_Basic:False; Command:CmExport_Stru;CommandStr:'CmExport_Stru'),
    (Active:True; Option_Basic:False; Command:CmExport;CommandStr:'CmExport'),
    (Active:True; Option_Basic:False; Command:CmImport;CommandStr:'CmImport')
    );
{
  Type
    TArray_Db_Global = Array[1..14] of TCommandStr;
  Const
    Array_Db_Global : TArray_Db_Global =
    (
    (Active:True; Option_Basic:True; Command:CmDbLocaliza;CommandStr:'CmDbLocaliza'),
    (Active:True; Option_Basic:True; Command:CmNewRecord;CommandStr:'CmNewRecord'),
    (Active:True; Option_Basic:True; Command:CmZeroizeRecord;CommandStr:'CmZeroizeRecord'),
    (Active:True; Option_Basic:True; Command:CmEvaluateRecord;CommandStr:'CmEvaluateRecord'),
    (Active:True; Option_Basic:True; Command:CmEditDlg;CommandStr:'CmEditDlg'),
    (Active:True; Option_Basic:True; Command:cmPrint;CommandStr:'cmPrint'),
    (Active:True; Option_Basic:True; Command:cmHomePage;CommandStr:'cmHomePage'),
    (Active:True; Option_Basic:True; Command:CmProcess;CommandStr:'CmProcess'),
    (Active:True; Option_Basic:True; Command:CmOkEscrevaParametrosDosRelatorios;CommandStr:'CmOkEscrevaParametrosDosRelatorios'),
    (Active:True; Option_Basic:True; Command:CmVisualisa;CommandStr:'CmVisualisa'),
    (Active:True; Option_Basic:True; Command:CmSobre;CommandStr:'CmSobre'),
    (Active:True; Option_Basic:True; Command:cmCores;CommandStr:'cmCores'),
    (Active:True; Option_Basic:True; Command:CmReindex;CommandStr:'CmReindex'),
    (Active:True; Option_Basic:True; Command:CmCopyTo;CommandStr:'CmCopyTo')
//    (Active:True; Option_Basic:True;  Command:;CommandStr:''),
    );
}

{
    (Active:True; Option_Basic:True; Command:CmCadastraImpressoraRede;CommandStr:'CmCadastraImpressoraRede'),
    (Active:True; Option_Basic:True; Command:CmCadastraImpressoraLocal;CommandStr:'CmCadastraImpressoraLocal'),
    (Active:True; Option_Basic:True; Command:CmInfoSystem;CommandStr:'CmInfoSystem'),
    (Active:True; Option_Basic:True; Command:cmPrintSemFormatar;CommandStr:'cmPrintSemFormatar'),
    (Active:True; Option_Basic:True; Command:CmF7;CommandStr:'CmF7'),
    (Active:True; Option_Basic:True; Command:CmDbSelecionaIndice ;CommandStr:'CmDbSelecionaIndice'),
    (Active:True; Option_Basic:True; Command:CmDbOrdemCressante;CommandStr:'CmDbOrdemCressante'),
    (Active:True; Option_Basic:True; Command:CmDbOrdemDecrescente;CommandStr:'CmDbOrdemDecrescente'),
    (Active:True; Option_Basic:True; Command:CmDbAddRec;CommandStr:'CmDbAddRec'),
    (Active:True; Option_Basic:True; Command:CmDbDeleteRec;CommandStr:'CmDbDeleteRec'),
    (Active:True; Option_Basic:True; Command:CmDbGetRec;CommandStr:'CmDbGetRec'),
    (Active:True; Option_Basic:True; Command:CmDbPutRec;CommandStr:'CmDbPutRec'),
    (Active:True; Option_Basic:True; Command:CmDbUpdateRec;CommandStr:'CmDbUpdateRec'),
    (Active:True; Option_Basic:True; Command:CmDbSearchTop;CommandStr:'CmDbSearchTop'),
    (Active:True; Option_Basic:True; Command:CmDbSearchKey;CommandStr:'CmDbSearchKey'),
    (Active:True; Option_Basic:True; Command:CmDbUsedRecs_Valid;CommandStr:'CmDbUsedRecs_Valid'),
    (Active:True; Option_Basic:True; Command:CmDbAddRec;CommandStr:'CmDbAddRec'),
    (Active:True; Option_Basic:True; Command:CmDbDeleteRec;CommandStr:'CmDbDeleteRec'),
    (Active:True; Option_Basic:True; Command:CmDbGetRec;CommandStr:'CmDbGetRec'),
    (Active:True; Option_Basic:True; Command:CmDbPutRec;CommandStr:'CmDbPutRec'),
    (Active:True; Option_Basic:True; Command:CmDbUpdateRec;CommandStr:'CmDbUpdateRec'),
    (Active:True; Option_Basic:True; Command:CmDbSearchTop;CommandStr:'CmDbSearchTop'),
    (Active:True; Option_Basic:True; Command:CmDbSearchKey;CommandStr:'CmDbSearchKey'),
    (Active:True; Option_Basic:True; Command:CmDbUsedRecs_Valid;CommandStr:'CmDbUsedRecs_Valid'),
    (Active:True; Option_Basic:True; Command:CmDbDoBeforeInsert;CommandStr:'CmDbDoBeforeInsert'),
    (Active:True; Option_Basic:True; Command:CmDbDoBeforePost;CommandStr:'CmDbDoBeforePost'),
    (Active:True; Option_Basic:True; Command:CmDbDoBeforeDelete;CommandStr:'CmDbDoBeforeDelete'),
    (Active:True; Option_Basic:True; Command:CmDbDoAfterInsert;CommandStr:'CmDbDoAfterInsert'),
    (Active:True; Option_Basic:True; Command:CmTb_SelectRefCruzadaResume;CommandStr:'CmTb_SelectRefCruzadaResume'),
    (Active:True; Option_Basic:True; Command:CmTb_SelectSelect;CommandStr:'CmTb_SelectSelect'),
    (Active:True; Option_Basic:True; Command:CmTb_SelectResume;CommandStr:'CmTb_SelectResume'),
    (Active:True; Option_Basic:True; Command:CmSetAppending ;CommandStr:'CmSetAppending'),
    (Active:True; Option_Basic:True; Command:CmStartTransaction;CommandStr:'CmStartTransaction'),
    (Active:True; Option_Basic:True; Command:CmCommit;CommandStr:'CmCommit'),
    (Active:True; Option_Basic:True; Command:CmRollback;CommandStr:'CmRollback'),
    (Active:True; Option_Basic:True; Command:CmOnCalcRecord_All;CommandStr:'CmOnCalcRecord_All')

}


{***************************************************************************}
var
{  OkMsgDuplicidade : Boolean = True;} {<Se true dar messagem de chave em duplicidade}
  OkZeraFGetMem    : Boolean = True; {<True zera a memoria alocada por FGetMem}
  OkEscrevaParametrosDosRelatorios : TNao_sim= Ns_Nao;{<O padrao ‚ imprimir os parametros dos relat¢rios}
  OkEscrevaParametrosDosRelatoriosInd : PtString = nil;
  NumDeColunasDaImpressora : Byte = 80 ;

Type
  TEnumerado_Moeda = //<  Moeda padrão usada na base de dados:
    (En_Real,
     En_Dolares_Americano,
     En_Euro,
     En_Horas,
     En_Minutos);

{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
   Inicio das Variaveis que sao salvas em cada interropcao em LerCh
 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ }
Const
  WNumFator        : TEnumerado_Moeda  = En_Real {<1};   {<Usado nos relatorios}

  SinalDeMaisAtivo : Boolean = False; {<Mostra o sinal de + a direita dos campos numericos}


  NumTeclasDigitada : Longint = 0; {< Conta o numero de teclas digitada }
  Maiuscula     : Boolean = True;    {< Entrada de dados e todas em maiusculo}
  CursorLigado  : Boolean = True;
  ChaveProxima  : boolean = false;   {< Usado na Findrec indicando se Deve
                                      despresar chave distinta.
                                      False = Chave Destinta
                                      True  = Chave repetida        }

  opcaoRedireciona : AnsiChar = 'I'; {< Defaust  = impressora }
  RedirecionaImpressora  : boolean = false;
  redirecionaImpNul      : Boolean = False;
  NomeRedireciona        : PathStr = 'C:\Maricarai.Lst';
  contalinha   : Longint = 0;
  contaPagina  : Longint= 1;
  DVECabecario : boolean = True;
  ApartirDeQuePagina     : Longint= 1; {< Caso ApartirDeQuePagina > 1 entao redireciona para NUL
                                          todas as paginas dos relatorios ate que ContaPagina seja =  ApartirDeQuePagina}
  PaginaInicial          : Longint= 1; {< Pagina inicial na listagem }

  linMsg                 : Byte = 25;
  colMsg                 : Byte = 1;

  LM  : Byte                    = 7;
  CM  : Byte                    = 5;

  TamPagina               : byte = 63;
  EspacosEntreFormularios : Byte =  3; {< Espacos em branco entre os fomularios dos relatorios }

  HoraInicial : TipoHora = ( H    : 0; {< Usado em EscrevaTempoEstimado do indice }
                             M    : 0; {< Onde HoraInicialAux hora transcorrida  }
                             S    : 0; {< entre o inicio da indexacao e a atual}
                             S100 : 0 );



  UAnsiChar        : AnsiChar = ' '; {< Ultimo Caracter Digitado     }
  Cont         : Longint= 0;   {< Var para contar o numero de registros impressos }
  WCodigo      : tString   = '';

  { excutado no controle de pagina com objetivo de mostrar na pagina seguite
    do que se trata os lacamentos que serao impresos}
  ExecuteContinuacaoDeRelatorio : TipoProc = Nil;



var
//  DosLastMode  : SmallInt;
  Lst          : text;


const
  {$Region '---> Letras_da_ligua_Portuguesa <---'}
{a,A, ,µ, Æ, Ç, …, ·
e,E, ‚,,ˆ,Ò
o,O,¢,,“,â,
c,C,‡,€,
i,I,¡,Ö
u,U,£,é}
  Letras_da_ligua_Portuguesa = [
      //FONTES TERMINAL MODO CONSOLE
       '‡', //c cedilha minusculo
       '€', //C cedilha maiusculo

      'µ', //a com acento agudo
      'Æ', //A com acento agudo maiusculo
      '¶', //A acento agudo maiusculo

      'Æ', //a com til minusculo
      'Ç', //A com til maiusculo
      '…', //a com crase minusculo
      '·', //A com crase maiusculo
      'ƒ', //a acento circomflexo minusculo


      '‚', //e acento agudo minusculo
      '', //E acento agudo maiusculo
      'ˆ', //e acento circomflexo minusculo
      'Ò', //E acento agudo maiusculo

      '¡', //i acento agudo minusculo
      'Ö', //I acento agudo maiusculo

      '¢', //o acento agudo minusculo
      'O', //O acento agudo maiusculo      obs: nao pude gerar este simbolo

      '“', //o acento circomflexo minusculo
      'â', //O acento circomflexo maiusculo

      '£', //u acento agudo minusculo
      'é' //U acento agudo maiusculo

        ];

  {$EndRegion '---> Letras_da_ligua_Portuguesa <---'}

//  LF = ^M+^J;   {< Usado em write para passar a linha }


  AnsiCharSet_Alfabetico   : AnsiCharSet  = ['a'..'z','A'..'Z',' ','.',';'] +Letras_da_ligua_Portuguesa;
  AnsiCharSet_Alfanumerico = [#32..#127]+Letras_da_ligua_Portuguesa;



  Alfanumerico = 'A';
  ISmallInt    = 'I';
  LLongint    = 'L';
  RReal       = 'R';
  RRealP      = 'P';
  BByte       = 'B';
  TipoData    = 'D'; {<Tipo data dia,mes,ano:Byte}
  TipoTimeD   = 'T'; {<Tipo longint usado em LibGtObj no Display com data e hora compactada }
  TipoTimeH   = 'H'; {<Tipo longint usado em LibGtObj no display com data e hora compactada }
  EExtended   = 'E';
  DDouble     = 'O';


Const
  FuncTurboError  : TipoTurboError = Nil;
  EndProcMyExit : TipoProc = Nil; {< Executado em MyHalt }
  EndClearAll     : TipoProc = Nil;
  EndOpenFiles    : TipoProc = Nil; {< Rotina para abertura dos arquivos genericos }
  EndCloseFiles   : TipoProc = Nil; {< Rotina para Fechar os arquivos genericos }


Type
  TCollectionString = Class(Objects.TStringCollection)
  Public
                        Ordem:Boolean; {<Se True insere em ordem alfabetica}
                        FoundTesteCompleto:Boolean;

 {$Region '---> Declaração da propriedade Stringss <---'}

   Private Function GetAnsiStrings(Index: Sw_Integer):AnsiString; //Objetivo: Ler a string sem os caracteres de controle
   Public Property AnsiStrings[Index: Sw_Integer]: AnsiString Read GetAnsiStrings;//Objetivo: Ler a string sem os caracteres de controle

 {$EndRegion '---> Declaração da propriedade Stringss <---'}

   Public
      constructor Create(ALimit, ADelta: Sw_integer;AOrdem:Boolean);
      constructor CreateLista(AOrdem:Boolean;aLista:tString;const aFoundTesteCompleto:Boolean);

      Function NewStr(S : AnsiString):Boolean;
      Function Append(S : AnsiString):Boolean;

      procedure AddSItem(P : PSItem;OkDisposeSItems:Boolean);Overload;
      procedure AddSItem(P : PSItem);Overload;

      Function PListSItem : {<Dialogs.}PSItem;
      Function Get_Html_List:AnsiString;//< Retorna Uma sequencia de <li> </li>
      Function Found(const akey:tString):Boolean;

      Function GetMaiorString(Const aConjDespreze:AnsiCharSet;aIgnore_ShowWid:Boolean) : Byte;Overload;
      Function GetMaiorString(Const aConjDespreze:AnsiCharSet) : Byte;Overload;

      Function GetMaiorAnsiString() : Integer;Overload;

      Function Clone:TCollectionString;
      FUNCTION Search (Key: Pointer; Var Index: Sw_Integer): Boolean;Override;

      Procedure FormatStr(LengthMaxCol: Integer);

      PROCEDURE FreeItem (Item: Pointer); Override;

      Private
        OkInsert : Boolean;
    End;


Type
  PRect      = ^TRect;
  PViRect    = ^TViRect;
  TDirection = (North{<Nort},South{<Sul},West{<Oeste},East{<Leste},CenterX,CenterY,CenterXY);

  TViRect  =
  Object(Trect)
  Public
    R_Neighbor  : TRect;  {<Vizinho}
    R_New       : TRect;  {<Novo retangulo calculado por GetRec}
    Overflow    : Boolean; {<Se as coordenadas for negativa overflow=true}

    Procedure Create_Point_A(X,Y:Int64);
    Procedure Create_Point_B(X,Y:Int64);

    Procedure Calc_point_A_North;
    Procedure Calc_point_A_South;
    Procedure Calc_point_A_West;
    Procedure Calc_point_A_East;

    Procedure It_is_not_adjusted_valid(MinX,MinY:Int64; Var aRect: TRect);

    Function GetRect_Relative(
                   aR_Neighbor : TRect;  {<Vizinho}

                   aPerc_point_A : Byte;
                   adirection_point_A:Tdirection;

                   aPerc_point_B : Byte;
                   adirection_point_B: Tdirection;

                   Var aR_New : TRect {<Retorna o Ponto calculado}
                 ):Boolean;

    Function GetRect_Absolute(
                   aR_Neighbor : TRect;  {<Vizinho}
                   adirection_point_A:Tdirection;

                   aPoint_B : TPoint;
                   adirection_point_B: Tdirection;

                   Var aR_New : TRect {<Retorna o Ponto calculado}
                 ):Boolean;

    Procedure Set_Max_Ax_e_Max_BY(Max_X,Max_Y:Int64);
    procedure MoveTo(X, Y: Integer);
    Procedure MoveTo_Direction(adirection : Tdirection;
                               aOwner     : TRect {<Retorna o Ponto calculado }
                             );

    Procedure GetRect(Var aR_New : TRect); {<Retorna o Ponto calculado }
    Function Rect:TRect;
  end;



{Funcoes gerais}

Function StrHex( W :  SmallWord;
                 Str_Indicador:tString {<Caractere que indica código hexadecial. % para HTML e $ para pascal}
               ) : tString;Overload;
Function StrHex( w :   SmallWord) : tString;Overload;
Function FPrimeiroHandleLivre : SmallInt;
function SeExiste( NomeArquivo :PathStr) :boolean;
Function DeleteFile( Const Nome : PathStr):Byte;
Procedure Cursor(Const Condicao : BooLean);
Procedure BufferDoTeclado (Const  Msg : tString );
Function FGetMem(Var Buff;Const TamBuff: Word) : Boolean;
Procedure FFreeMem(Var Buff;Const TamBuff: Word) ;
Function CGetMem(Const BuffOriginal:Pointer ;Const TamBuff: Word):Pointer;
Function CloseLst:SmallInt;
Procedure DesabilitaTabelasAberta(var wEndOpenFiles,wEndCloseFiles : TipoProc);
Procedure AbilitaTabelasAberta(var wEndOpenFiles,wEndCloseFiles : TipoProc);


{PROCEDURE DISCARD (Var aClass);}
{FUNCTION IsFileOpen(VAR F):BOOLEAN ;}

FUNCTION IsFileOpen(VAR F:FILE):BOOLEAN ;overload;
FUNCTION IsFileOpen(VAR F:Text):BOOLEAN ;overload;

FUNCTION IsAssignFile(VAR F:FILE):BOOLEAN ;overload;
FUNCTION IsAssignFile(VAR F:Text):BOOLEAN ;overload;

Function IStr   ( Const I : Longint; Const Formato : tString) : tString;Overload;
Function IStr   ( Const I : Longint) : tString;Overload;
Function IStr   ( Const I : tString; Const Formato : tString) : tString;Overload;

function conststr ( i : Longint;  Const a : AnsiChar     ) : AnsiString; {<Obsoleto}
function FillStr(Const aAnsiChar : AnsiChar ; Const Len : integer) : AnsiString;

Function FMb_Bits(Const aBit:Byte):Longint;

{Function SetOkMsgDuplicidade(Const aOkMsgDuplicidade:Boolean):Boolean;}

procedure DisposeStr(var P: PtString);

Function IsValid_DataBase_Filename(Const AFilename  : tString):Boolean;

Procedure UpperCase(Var S : AnsiString);
procedure ConverteMaiuscula( var str:AnsiString);
Function FMaiuscula(str:AnsiString):AnsiString;

Procedure LowerCase(Var S : AnsiString);
Function FMinuscula(str:AnsiString):AnsiString;


Function TypeFld(Const aTemplate : ShortString;Var aSize : SmallWord):AnsiChar;overload;
Function TypeFld(Const aTemplate : ShortString):AnsiChar;overload;
Function TypeFld_Size(Const aTemplate : ShortString):SmallWord;
Function IsNumber_Real(Const aTemplate : ShortString):Boolean;
Function IsNumber_Integer(Const aTemplate : ShortString):Boolean;
Function IsNumber(Const aTemplate : ShortString):Boolean;
Function IsData(Const aTemplate : ShortString):Boolean;
Function IsHora(Const aTemplate : ShortString):Boolean;


Function Get_List_Class_Of_Char:TNsStringList;
Function Get_List_Class_Of_Char_GUI:TNsStringList;

Function String_Asc_Console_to_Asc_HTML(Const S: String): String;
Function SCH(Const S: String): String;
Function SGH( S: String): String;

Function String_Asc_Console_to_Asc_GUI( S: String): String;
Function SCG( S: String): String;

Function String_Asc_GUI_to_Asc_Console( S: String): String;
Function SGC( S: String): String;




Function String_Asc_Console_to_Asc_Ingles(Const S: String): String;
Function SCI(Const S: String): String;


Function Clone_TStringList(Const aStrings:Classes.TStringList):Classes.TStringList;


function NewSItem(const Str: tString; ANext: PSItem): PSItem;

procedure DisposeSItems(vAR AItems: PSItem);overload;
procedure DisposeSItems(var AStrItems: PtString);overload;

function  MaxItemStrLen(AItems: PSItem) : integer;Overload;
function  MaxItemStrLen(PSItems: tString) : integer;Overload;

function  SItemsLen(S: PSItem) : integer;
function  GetItemByName      (AItems: PSItem; aValue: AnsiString) : PSItem;
function  GetLinha_ItemByName(AItems: PSItem; aValue: AnsiString) : Integer;

function  GetItemByNum(AItems: PSItem;i:Integer) : PSItem;


Function PS(Const S:PtString):tString;

function CentralizaStr(Const campo : AnsiString; Const tamanho : Integer) : AnsiString;
function  SpcC(Const campo : AnsiString; Const tamanho : byte) : Ansistring;
function MinL(Const a,b:Longint):Longint;
function SpcStrD (Const  campo : tString; Const Tam : Byte): tString;
function spc(Const campo:AnsiString;Const tam :Longint):AnsiString;
Function CopyTemplateFrom(Const aTemplate:tString): tString;
function  CreateTSItemFields(ATemplates: PSItem) : tString;
function  CreateEnumField(ShowZ: boolean; AccMode,Default: byte;AItems: PSItem) : tString;
procedure WriteSItems(var S: TCollectionString; Const Items: PSItem);
Function CloneSItems(Const Items: PSItem):PSItem;
Function SItems_to_CollectionString(Const Items: PSItem):TCollectionString;


Procedure Beep(Freq,Dur: LongInt);

Function StrAlinhado(aStrMsg:tString;Colunas : byte;Const Alinhamento:TAlinhamento):tString;

Function StrToSItem(Const StrMsg:AnsiString; Colunas : byte;Alinhamento:TAlinhamento):PSItem;


Function Set_FileModeDenyALLSalvaAnt(Const ModoDoArquivo : Boolean;Var _FileModeDenyALLAnt:Boolean):Boolean;
Function Set_FileModeDenyALL(Const ModoDoArquivo : Boolean):Boolean;

Function SetOkprocessing(aOkprocessing : Boolean) : Boolean;

Function SetCurrentModule(aCurrentModule : SmallWord; {<Numero do modulo corrente}
                          aStrCurrentModule : AnsiString ):Integer; {<Nome do modulo corrente atualizando em HandleEvent}


Procedure SetCurrentCommand(aCurrentCommand : SmallWord ; {<Numero do comando atual atualizando em HandleEvent}
                            aStrCurrentCommand,
                            aStrCurrentCommand_Topic : AnsiString);overload; {<Nome do comando atual atualizando em HandleEvent}


Procedure SetCurrentCommand(aCurrentCommand : SmallWord ; {<Numero do comando atual atualizando em HandleEvent}
                            aStrCurrentCommand: AnsiString);overload; {<Nome do comando atual atualizando em HandleEvent}


Function Set_Ok_Modo_relario_de_erros(wOk_Modo_relario_de_erros: Boolean) : Boolean;

Function Nome_da_Moeda(wMoeda:TEnumerado_Moeda):tString;

Function FShow_HTML(aURL:AnsiString):system.integer; //<  Retorna 0 se tiver sucesso ou o código do erro se for fracasso


Function AnsiString_to_TCollectionString(Msg: AnsiString): TCollectionString;


Function SetSinalDireita(wSinalDireita     : Boolean )  : Boolean ;
Function SinalDireita : Boolean ;

Function Str_Nao_Sim(const S:TNAo_sim):AnsiString;
Function  NewSItem_Nao_Sim : PSitem;

function GetBit(const Value: DWord; const Bit: Byte): Boolean;
function ClearBit(const Value: DWord; const Bit: Byte): DWord;
function SetBit(const Value: DWord; const Bit: Byte): DWord;
function EnableBit(const Value: DWord; const Bit: Byte; const TurnOn: Boolean): DWord;



Function CriaDiretorio(NomeDiretorio:PathStr): Boolean;
function ExisteDiretorio(Path :PathStr) : Boolean;
Function GetDirTemp(Const env:tString;Var path:PathStr):SmallInt;{Retorna o código do error se houver}
Function Alias_To_FileName(AFilename  : AnsiString):AnsiString;
Function Alias_To_Name(AAlias  : AnsiString):AnsiString;

fUNCTION StrToInt(aStr:String):Longint;
function Del_SpcED(campo : AnsiString): AnsiString;




Function ChangeSubStr(Const aSubStrOld : AnsiString; {SubString de S a ser trocada}
                      Const aSubStrNew : AnsiString; {a Nova SubString de S}
                      const S: AnsiString ):AnsiString; {Retorna S com o string Trocado}

Implementation

uses Unit_Versao_DB;


Const
  _SinalDireita     : Boolean = False;




function Del_SpcED(campo : AnsiString): AnsiString;
begin
  {Deleta brancos a esquerda }
  While (Length(Campo)>0) and (Campo[1] in [' ',#0..#31] ) do
    Delete(Campo,1,1);

  {Deleta brancos a direita}
  While (Length(Campo)>0) and (Campo[Length(Campo)] in [' ',#0..#31] )
  do Delete(Campo,Length(Campo),1);

  Del_SpcED := campo;
end;


fUNCTION StrToInt(aStr:String):Longint;
Begin
  if astr = ''
  then astr := '0';

  Result := sysUtils.StrToInt(aStr);
End;

Function Alias_To_FileName(AFilename  : AnsiString):AnsiString;
{<
  Troca as letras invalidas para nome de arquivo por _
}
 Var
  i : Integer;
Begin
 Result := AFilename;
 For I := 1 to length(Result) do
 If Result[i] in [' ','/','>','<','(',')',':',';','[',']','{','}','+','-','*','&','%','%','¨','$','@',{'#',}'"','!','|','\','/','?',',']
 Then Begin
        If Result[i] <> ':'
        Then Result[i] := '_'
        else If (Result[i] = ':') <> (I=2)
             Then Result[i] := '_'
      End;
   Result := String_Asc_Console_to_Asc_Ingles(Result)
end;

Function Alias_To_Name(AAlias  : AnsiString):AnsiString;
//  Troca as letras invalidas para nome de componentes por _

 const
    Alpha = ['A'..'Z', 'a'..'z', '_'];
    AlphaNumeric = Alpha + ['0'..'9'];
 Var
  i : Integer;
Begin
  //Deleta brancos a esquerda
  While (Length(AAlias )>0) and (AAlias [1] in [' ',#0..#31] ) do
    Delete(AAlias ,1,1);

  //Deleta brancos a direita
  While (Length(AAlias )>0) and (AAlias[Length(AAlias )] in [' ',#0..#31] )
  do Delete(AAlias ,Length(AAlias ),1);

 Result := String_Asc_Console_to_Asc_Ingles(AALias);

  For I := 1 to length(Result) do
  If Not (Result[i] in  AlphaNumeric)
  Then  Result[i] := '_';
end;

function GetBit(const Value: DWord; const Bit: Byte): Boolean;
begin
  Result := (Value and (1 shl Bit)) <> 0;
end;

function ClearBit(const Value: DWord; const Bit: Byte): DWord;
begin
	Result := Value and not (1 shl Bit);
end;

function SetBit(const Value: DWord; const Bit: Byte): DWord;
begin
	Result := Value or (1 shl Bit);
end;

function EnableBit(const Value: DWord; const Bit: Byte; const TurnOn: Boolean): DWord;
begin
	Result := (Value or (1 shl Bit)) xor (Integer(not TurnOn) shl Bit);
end;

Function ChangeSubStr(Const aSubStrOld : AnsiString; {SubString de S a ser trocada}
                      Const aSubStrNew : AnsiString; {a Nova SubString de S}
                      const S: AnsiString ):AnsiString; {Retorna S com o string Trocado}

  Var
    Pos1,Pos2  : Integer;
Begin
  Pos1 := Pos(FMaiuscula(aSubStrOld),FMaiuscula(S));
  If Pos1 <> 0
  Then Result := Copy(S,1,Pos1-1)
                      + aSubStrNew
                      + Copy(S,Pos1+Length(aSubStrOld),Length(s)-Pos1+Length(aSubStrOld) +1)
  Else Result := S;
end;

function ExisteDiretorio(Path : PathStr) : Boolean;
var F : File; Attr : Longint;
Begin
  ExisteDiretorio := False;
  TaStatus := 0;
  Path := FExpand(Path);

  Assign(F, Path);
  GetFAttr(F, Attr);

  Result := (DosError = 0) and (Attr and Directory <> 0);
  If Not Result
  then TaStatus := DosError;
End;

Function CriaDiretorio(NomeDiretorio:PathStr): Boolean;
Var
  Path,
  PathAtual,
  Drive    : PathStr;
  L,Poss    : Byte;
Begin
//  {$IFDEF TaDebug}Push_MsgErro('Db_generic.CriaDiretorio',ListaDeChamadas);{$ENDIF}
  TaStatus := 0;
  Result := False;
  If NomeDiretorio[length(NomeDiretorio)] <> '\'
  Then NomeDiretorio := sysutils.ExpandUNCFileName(NomeDiretorio)+'\'
  Else NomeDiretorio := sysutils.ExpandUNCFileName(NomeDiretorio);

  Path   := sysutils.ExtractFilePath(NomeDiretorio);
// Se o direeto existe então retorna true
  if ExisteDiretorio(ExtractFilePath(Path))
  Then Begin
         Ok := true;
         Result := ok;
         exit;
       end;


//  DelSpc(NomeDiretorio);
  If PathDelim+PathDelim = Copy(NomeDiretorio,1,2)  // Não tem drive porque é um path de rede.
  Then Begin
         Drive := Copy(NomeDiretorio,1,2);
         NomeDiretorio  := Copy(NomeDiretorio,3,length(NomeDiretorio));
         Drive          := Drive  + Copy(NomeDiretorio,1,pos(PathDelim,Copy(NomeDiretorio,3,length(NomeDiretorio)))+3);
         NomeDiretorio  := Copy(NomeDiretorio,Length(Drive)-1,length(NomeDiretorio));
       end
  Else Begin
         Poss := Pos(':',NomeDiretorio);
         if Poss <> 0
         Then Begin
                 Drive := Copy(NomeDiretorio,1,Poss);
                 Delete(NomeDiretorio,1,Poss);
               end
         Else Drive := '';
       End;

  PathAtual := '';
  While (NomeDiretorio <> '') and  (NomeDiretorio <> PathDelim) do
  Begin
    L := Pos(PathDelim,NomeDiretorio);
    If L = 0
    Then Begin
            If PathAtual <> ''
            Then Begin
                    if PathAtual[length(PathAtual)] <> PathDelim
                    Then PathAtual:= PathAtual+PathDelim+NomeDiretorio
                    Else PathAtual:= PathAtual+NomeDiretorio
                 End
            Else PathAtual:= NomeDiretorio;
            NomeDiretorio := '';
         End
    Else Begin
            If PathAtual <> ''
            Then Begin
                   If PathAtual[length(PathAtual)] <> PathDelim
                   Then PathAtual := PathAtual+PathDelim+Copy(NomeDiretorio,1,L-1)
                   Else PathAtual := PathAtual+Copy(NomeDiretorio,1,L-1);
                 End
            Else Begin
                   If L = 1
                   Then Begin
                           L := Pos(PathDelim,Copy(NomeDiretorio,2,length(NomeDiretorio)));
                           if L > 0
                           Then PathAtual := Copy(NomeDiretorio,1,L)
                           Else Begin
                                  PathAtual := NomeDiretorio;
                                  NomeDiretorio := '';
                                End;
                        End
                   Else PathAtual := Copy(NomeDiretorio,1,L-1);
                 End;
            Delete(NomeDiretorio,1,L);
         End;

    if (PathAtual[length(PathAtual)] <> PathDelim) and (PathAtual<>'')
    Then Begin
           {$I-}
           MkDir(Drive+PathAtual);
           {$I+}
           taStatus := IOResult;
           Ok  := taStatus= 0;
           Result := ok;
         End;
  End;


End;

Function GetDirTemp(Const env:tString;Var path:PathStr):SmallInt;{Retorna o código do error se houver}
   var Dir: DirStr; var Name: NameStr; var Ext: ExtStr;
Begin
  taStatus := 0;
  FSplit(ParamStr(0),Dir,Name,Ext);
  Path := GetEnv(env);
  Path := FExpand(Path)+PathDelim+Name+PathDelim;
  ok   := ExisteDiretorio(Path);
  IF Not ok
  Then Begin
         {Path := 'c:\temp';}
         ok := CriaDiretorio(Path);
       end;
  GetDirTemp := taStatus;
end;

Function Str_Nao_Sim(const S:TNAo_sim):AnsiString;
Begin
  if S = NS_nao
  then Result := Sgc('Não')
  Else Result := 'Sim';
end;

Function  NewSItem_Nao_Sim : PSitem;
Begin
  Result := NewSItem(sgc(' Não '),
            NewSItem(    ' Sim ',
            Nil));
end;

Function SinalDireita : Boolean ;
Begin
  Result := _SinalDireita;
End;

Function SetSinalDireita(wSinalDireita     : Boolean )  : Boolean ;
Begin
  Result := _SinalDireita;
  _SinalDireita := wSinalDireita;
End;



Function AnsiString_to_TCollectionString(Msg: AnsiString): TCollectionString;
  {RECEBER: Em MSG um string longo separado por
             ^M = Final de linha
             ^C = O string e centralizado
   RETORNA: TCollectionString formatado.
  }

  Var
    I      : Integer;
    S      : ShortString;
Begin
  Result  := TCollectionString.Create(1,1,false);
  I := 1;
  While i <=  Length(Msg) do
  Begin
    S := '';
    While (i <=  Length(Msg)) and (Not (Msg[i] in [^M,^J])) do
    Begin
      S := S + Msg[i] {+^M};
      Inc(i);
    end;
    Result.NewStr(S);
    Inc(i);
  end;
end;

Function Nome_da_Moeda(wMoeda:TEnumerado_Moeda):tString;
Begin
  Case WMoeda of
    En_Real                : Result := 'Real';
    En_Dolares_Americano   : Result := 'Dolares americano';
    En_Euro                : Result := 'Euro';
    En_Horas               : Result := 'Horas';
    En_Minutos             : Result := 'Minutos';

    Else                   Result := 'Moeda desconhecida';
  end; //< Case
end;

Function Set_Ok_Modo_relario_de_erros(wOk_Modo_relario_de_erros: Boolean) : Boolean;
  //<  Retorna o estado anterior de Ok_Modo_relario_de_erros
//<  Váriável global indicando que esta no modo analise dos erros e o committe deve executar roolback.
Begin
  Result := Ok_Modo_relario_de_erros;
  Ok_Modo_relario_de_erros := wOk_Modo_relario_de_erros;
end;

Function FShow_HTML(aURL:AnsiString):system.integer;
//<  Retorna 0 se tiver sucesso ou o código do erro se for fracasso
Begin
//  HLinkNavigateString(aURL);
//  SysShellExecute(Const lpOperation,FileName, Params, DefaultDir: AnsiString;ShowCmd: Integer): THandle;Overload;

//   SysShellExecute('iexplore.exe' ,aURL,'',SW_SHOWMAXIMIZED);
   SysShellExecute('iexplore.exe' ,aURL,'',SW_SHOW);
//   SysShellExecute('iexplore.exe' ,aURL,'',SW_SHOWNORMAL);
//   SysShellExecute('iexplore.exe' ,aURL,'',SW_SHOWDEFAULT	);


//  SysShellExecute('Edit',aURL,'','',SW_SHOW	); // Editar html


  Result := 0;
end;


Function SetCurrentModule(aCurrentModule : SmallWord; {<Numero do modulo corrente}
                          aStrCurrentModule : AnsiString ):Integer; {<Nome do modulo corrente atualizando em HandleEvent}
Begin
  Result            := CurrentModule;
  CurrentModule     := aCurrentModule;
  StrCurrentModule  := aStrCurrentModule ;
end;

Procedure SetCurrentCommand(aCurrentCommand : SmallWord ; {<Numero do comando atual atualizando em HandleEvent}
                            aStrCurrentCommand,
                            aStrCurrentCommand_Topic : AnsiString); {<Nome do comando atual atualizando em HandleEvent}
Begin
  CurrentCommand := aCurrentCommand;
  StrCurrentCommand := aStrCurrentCommand;
  StrCurrentCommand_Topic  := aStrCurrentCommand_Topic ;
end;

Procedure SetCurrentCommand(aCurrentCommand : SmallWord ; {<Numero do comando atual atualizando em HandleEvent}
                            aStrCurrentCommand: AnsiString);overload; {<Nome do comando atual atualizando em HandleEvent}
Begin
  SetCurrentCommand(aCurrentCommand,aStrCurrentCommand,'');
end;

Function SetOkprocessing(aOkprocessing : Boolean) : Boolean;
Begin
  Result := Okprocessing;
  Okprocessing := aOkprocessing;
end;



Function Set_FileModeDenyALL(Const ModoDoArquivo : Boolean):Boolean;
  Var
    WFmWait,
    WFmMemory,
    WFmMemory_Temp : Word;
Begin
  If GetStateFileMode(FmMemory)
  Then WFmMemory  := FmMemory
  Else WFmMemory  := 0;

  If GetStateFileMode(FmMemory_temp)
  Then WFmMemory_Temp := FmMemory_Temp
  Else WFmMemory_Temp := 0;

  If GetStateFileMode(FmWait)
  Then WFmWait := FmWait
  Else WFmWait := 0;


  Result := FileModeDenyALL;
  If ModoDoArquivo Then
  Begin {< Modo Exclusivo }
    FileModeAnt := SetFileMode(FmReadWrite or FmDenyALL or wFmWait or WFmMemory_Temp or WFmMemory {<or  FmChildProcesses});
    FileModeDenyALL := ModoDoArquivo ;
  end
  Else
  Begin { Nao Exclusivo }
    FileModeAnt := SetFileMode(FmReadWrite or fmDenyNone or wFmWait or WFmMemory_Temp or WFmMemory {<or  FmChildProcesses});
    FileModeDenyALL := ModoDoArquivo;
  End;
End;

Function  Set_FileModeDenyALLSalvaAnt(Const ModoDoArquivo : Boolean;Var _FileModeDenyALLAnt:Boolean):Boolean;
Begin
  _FileModeDenyALLAnt        := FileModeDenyALL;
  Set_FileModeDenyALLSalvaAnt := Set_FileModeDenyALL(ModoDoArquivo);
End;

Function StrToSItem(Const StrMsg:AnsiString; Colunas : byte;Alinhamento:TAlinhamento):PSItem;
Var
  aStrMsg  : AnsiString;
  i,MaxCol : Byte;
  S        : TCollectionString;
Begin
  aStrMsg := '';
  MaxCol  := 0;
  try
    S :=  TCollectionString.Create(1,1,False);{<Insere a tString em ordem sequencial}

    If S=Nil Then
    Begin
      StrToSItem := nil;
      exit;
    End;

    for i := 1 to length(StrMsg) do
    Begin
      if (strMsg[i] in [^J,^Z{,^C,^M}]) or (MaxCol > Colunas) Then
      Begin
        While (aStrMsg[1] = ' ') and (length(aStrMsg)>0) do
          Delete(aStrMsg,1,1);

        If strMsg[i] in [^J,^Z{<,^C,^M}]
        Then S.NewStr(StrAlinhado(aStrMsg,Colunas,Alinhamento))
        Else S.NewStr(StrAlinhado(aStrMsg+ StrMsg[i],Colunas,Alinhamento));

        aStrMsg := '';
        MaxCol := 0;
      end
      Else
      Begin
        aStrMsg := aStrMsg + StrMsg[i];
        Inc(MaxCol);
      End;
    End;

  Finally
    If S <> nil
    Then Begin
           S.NewStr(aStrMsg);
           StrToSItem :=S.PListSItem;
         End;
    Discard(TObject(s));
  End;
End;

Function StrAlinhado(aStrMsg:tString;Colunas : byte;Const Alinhamento:TAlinhamento):tString;
Begin
  While (aStrMsg[1] = ' ') and (Byte(aStrMsg[0])>0) do
    Delete(aStrMsg,1,1);

  While (aStrMsg[Byte(aStrMsg[0])] = ' ') and (Byte(aStrMsg[0])>0) do
    Delete(aStrMsg,Byte(aStrMsg[0]),1);

  Case Alinhamento of
    Alinhamento_Direita  : StrAlinhado := SpcStrD(aStrMsg,Colunas);
    Alinhamento_Central  : StrAlinhado := CentralizaStr(aStrMsg,Colunas);
    Alinhamento_Esquerda : StrAlinhado := Spc(aStrMsg,Colunas);
    else Begin
           Result := aStrMsg;
         End;
  End;
End;

Procedure Beep(Freq,Dur: LongInt);
Begin
  try
   SysBeepEx(Freq,Dur);
  except
  end;
End;

{======================================================================}

procedure WriteSItems(var S: TCollectionString; Const Items: PSItem);
  {<Obs:
    S : Deve ser passado nao inicializado mais deve ser NIL
  }
var
  P : PSItem;
begin
  If (S = nil) And (Items<>nil) Then
  Begin
    S :=  TCollectionString.Create(1,1,False);{<Insere a tString em ordem sequencial}
    P := Items;
    While (P <> nil) do
    begin
      If P.Value <> nil
      Then S.NewStr(P.Value^);
      P := P.Next;
    end;
  End;
end;

Function CloneSItems(Const Items: PSItem):PSItem;
var
  S : TCollectionString;
Begin
  S := nil;
  WriteSItems(S,Items);
  If S <> nil
  Then Begin
          Result := S.PListSItem;
          Discard(TObject(S));
       End
  else Result := nil;
End;

Function SItems_to_CollectionString(Const Items: PSItem):TCollectionString;
Begin
  Result := nil;
  WriteSItems(Result,Items);
End;



function  CreateEnumField(ShowZ: boolean; AccMode,Default: byte;AItems: PSItem) : tString;
var  S : tString;
begin
  S := fldENUM + #0#0#0#0 + AnsiChar(ShowZ) + chr(AccMode) + chr(Default);
// S := fldENUM + #0#0#0#0 + AnsiChar(ord(ShowZ)) + chr(AccMode) + chr(Default);
  Move(AItems, S[2], 4);
  CreateEnumField := S;
end;

function  CreateTSItemFields(ATemplates: PSItem) : tString;
var  S : tString;
begin
  S := fldSItems + #0#0#0#0#0#0#0;
  Move(ATemplates, S[2], 4);
  CreateTSItemFields := S;
end;

Function CopyTemplateFrom(Const aTemplate:tString): tString;


 {
   Esta funcao se faz necessario porque um Template pode ser uma lista de Strings onde esta lista pode
   ser inserida em um objeto e discartada ao destruir o objeto.
 }
   Var P1  : PSItem;
Begin
  If aTemplate <> ''
  Then Case aTemplate[1] of
           {<Os Campos abaixo pode ser uma lista de PSItem}
           fldENUM   : Begin
                         Move(ATemplate[2],P1,4);
                         Result := CreateEnumField({ShowZ  } boolean(Byte(aTemplate[6])),
                                                   {AccMode} Byte(aTemplate[7]),
                                                   {Default} Byte(aTemplate[8]),
                                                   {AItems}  CloneSItems(P1));

                        if length(aTemplate) > Length(Result)
                        then Begin
                               Result := Result + copy(aTemplate,length(result)+1,length(aTemplate) - Length(Result));
                             End;
                       End;
           fldSItems : Begin
                         Move(ATemplate[2],P1,4);
                         Result := CreateTSItemFields(CloneSItems(P1));

                         if length(aTemplate) > Length(Result)
                         then Begin
                                Result := Result + copy(aTemplate,length(result)+1,length(aTemplate) - Length(Result));
                              End;
                       end;
         Else Result := aTemplate;
       end
  else Result := '';
End;

function spc(Const campo:AnsiString;Const tam :Longint):AnsiString;
begin
  {Result := '';}
  if Length(campo) < tam
  then Result := Campo + ConstStr(tam-Length(campo),' ')
  else Result := Copy(Campo,1,Tam);
end;

function MinL(Const a,b:Longint):Longint;
Begin
  If b < a  Then MinL := b Else MinL := a;
End;

function SpcStrD (Const  campo : tString; Const Tam : Byte): tString;
{<
==========================================================
       *** SpcStrD ***
    devolve uma tString alinhada pela direita
==========================================================
}
Var Len : SmallInt;
begin
  Len := Tam-Byte(campo[0]);
  If Len > 0
  Then spcStrD  := constStr(Len,' ')+campo
  Else SpcStrD  := Copy(Campo,1,MinL(Tam,Byte(campo[0])));
end;

function CentralizaStr(Const campo : AnsiString; Const tamanho : Integer) : AnsiString;
var
  campoAux : tString;
begin
  If (tamanho - length(campo)) > 0
  Then campoAux := constStr(((tamanho - length(campo)) div 2),' ') + campo
  else campoAux := ''+campo;

  If (Tamanho-length(campoAux)) > 0
  Then centralizaStr := campoAux + constStr(Tamanho-length(campoAux),' ')
  else centralizaStr := campoAux;
end;

function  SpcC(Const campo : AnsiString; Const tamanho : byte) : Ansistring;
Begin
  SpcC := CentralizaStr(campo,tamanho);
End;

Function PS(Const S:PtString):tString;
Begin
  If S <> nil
  Then PS := S^
  Else Ps := '';
End;

Function Clone_TStringList(Const aStrings:Classes.TStringList):Classes.TStringList;
  Var
    I : Integer;
Begin
  Result := Classes.TStringList.create;
  For i := 0 to aStrings.count-1 do
     Result.Add(aStrings[i]);
end;
{
Constructor TNsStringList.Create;
Begin
  Inherited Create;
End;}

(*
function TNsStringList.CompareStrings(const S1, S2: AnsiString): Integer;
Begin
   If (S1 = S2)            {< String1 = String2 }
   Then Result := 0
   Else  If (S1 < S2)
         Then Result := -1 {< String1 < String2 }
         Else Result := 1; {< String1 > String2 }
end;
*)
                     /// <since>
                     ///   ?    Redefini pq a instancia anterior nao funciona com com caractere #254
                     /// </since>
function TNsStringList.IndexOf(const S: string): Integer;
  //var ws : string;
begin
  for Result := 0 to GetCount - 1 do
  begin
//    ws := Get(Result);
//    if (S='•') and (Result > 30 )
//    then ShowMessage(S);

    if Get(Result) = S
    then Exit;
  end;
  Result := -1;
end;

{function TNsStringList.IndexOf_AnsiChar(const aChar: AnsiChar): Integer;
  Var
//    wAchar : AnsiChar;
    s : AnsiString;
Begin
  for Result := 0 to GetCount - 1 do
  begin
    s := Get(Result);              
    if s <> ''
    then begin
          if s[1] = aChar
          then Exit;
        end;
  end;
  Result := -1;
End;}

procedure TNsStringList.Delete(Index: Integer);
  Var
    Obj : TObject;
Begin
  If _OkDestroy_Object
  Then Obj := GetObject(index)
  Else Obj := nil;

  Inherited delete(Index);

  If Obj<>nil Then  obj.Free;
End;

Destructor TNsStringList.Destroy;
Begin
  While Count-1 >= 0  do
    Delete(count-1);
  Inherited Destroy;
end;

Procedure TNsStringList.SetKeyMaster(w_KeyMaster : String);
  {< Deve executar goBof}
Begin
  _KeyMaster  := FMaiuscula(w_KeyMaster) ;
  ClearKey;
end;

Function TNsStringList.AddKey(WKey:String;wNr:Longint):Boolean;
Begin
  Try
    Result := true;
    AddObject(FMaiuscula(WKey),Pointer(wNr));

  except
    Result := false;
  end;
end;

Function TNsStringList.FindKey(WKey:String):Boolean;
  Var
    WIndex_Currente : Longint;
Begin
//  wIndex_Currente := Index_Currente;
  Result := Find(FMaiuscula(WKey),Index_Currente);

{ Teste.
Find(FMaiuscula(WKey),Index_Currente);
  If wIndex_Currente <> Index_Currente
  Then Result := FMaiuscula(WKey) = Strings[Index_Currente]
  Else Result := true;}

  If Result
  Then Begin
         If Objects[Index_Currente] <> nil
         Then Begin
                Nr := Longint(Objects[Index_Currente]);
                Result := true;
              end
         Else Result :=  False;
       end;

  OkBof      := False;
  OkEof      := False;
end;

Function TNsStringList.SearchKey(WKey:String):Boolean;
Begin
  Result := FindKey(WKey);
  If Not Result
  Then Begin
         Result :=  NextKey;
       //Verifica se a chava é igual  WKey
         If Result
         Then Result := Copy(Strings[Index_Currente],1,length(WKey)) = FMaiuscula(WKey);

         OkEof := Not Result;
         okBof := False;
       end;
end;

Function TNsStringList.ClearKey : Boolean;
 //<  Posiciona no inicio do bloco de registro do tipo default

  Function ClearKeyLocal : Boolean;
  Begin
    Result := SearchKey(KeyMaster);
  end;

Begin
  try
  // Se relacionando executar ClearKeyLocal
    If KeyMaster <> ''
    Then Begin
           Result := ClearKeyLocal();
           Exit;
         end;

    //posiciona no primeiro;
    Result := True;
    Index_Currente := 0;
    If Count-1 >= 0
    Then Begin
           Nr := Longint(Objects[Index_Currente]);
           Result := true;
         end
    else Begin
           Nr     := 0;
           Result := false;
         end;

  Finally
    OkBof := True;
    OkEof := False;
  end;
end;

Function TNsStringList.BofKey : Boolean;
//<  Posiciona no inicio do bloco de registro do tipo default

{  Function BofKeyLocal : Boolean;
  Begin
    Result := Index_Currente <= 0;
    If Not Result
    Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) <> KeyMaster
  end;}

Begin
// Se relacionando executar ClearKeyLocal
{  If KeyMaster <> ''
  Then Result := BofKeyLocal()
  Else Result := Index_Currente <= 0;}
  Result := OkBof;
end;

Function TNsStringList.LastKey : Boolean;
//<  Posiciona no fin do bloco de registro do tipo default
  Function LastKeyLocal : Boolean;
  Begin
    Result := ClearKey;
    If Result
    Then While Not EofKey Do
         Begin
           Result := NextKey;
           If Not Result Then Break;
         end;
  end;

Begin
  Result := true;

// Se relacionando executar ClearKeyLocal
  If KeyMaster <> ''
  Then Begin
         Result := LastKeyLocal();
         Exit;
       end
  Else Begin
         If Count > 0
         Then Begin
                Index_Currente := Count-1;
                Nr := Longint(Objects[Index_Currente]);
              end
         Else Nr := 0;

         OkBof := False;
         OkEof := true;
       end;
end;

Function TNsStringList.Eofkey : Boolean;
 //<  Checa se o pinteiro esta no ultimo registro
Begin
// Se relacionando executar ClearKeyLocal
{  If KeyMaster <> ''
  Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) <> KeyMaster
  Else Result := Index_Currente >= Count-1;}
  Result := OkEof  ;
end;

Function TNsStringList.NextKey  : Boolean;
 //<  Posiciona no proximo registro do tipo default

Begin
  Result := okEof;
  If Not Result
  Then Begin
         Inc(Index_Currente);
         If Index_Currente < Self.Count
         Then Begin
                Nr := Longint(Objects[Index_Currente]);
                Result := true;
              end
         Else Result := false;

        // Critica se a chave atual é igual a chave mestre
         If Result and (KeyMaster <> '')
         Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) =  KeyMaster;

         OkEof := Not Result;
         okBof := False;
       end;
end;

Function TNsStringList.PrevKey  : Boolean;
//<  Posiciona no registro anterior do tipo default
Begin
  Result := okBof;
  If Not Result
  Then Begin
          If Index_Currente > 0
          Then Begin
                 Dec(Index_Currente);
                 Nr := Longint(Objects[Index_Currente]);
                 Result := true;
               end
          Else Result := false;

        // Critica se a chave atual é igual a chave mestre
          If Result and (KeyMaster <> '')
          Then Result := Copy(Strings[Index_Currente],1,length(KeyMaster)) =  KeyMaster;

          OkBof := Not Result;
          okEof := false;
       end;
end;


Function TNsStringList.NewStr(S : String):Boolean;

     Function Insert_Not_Duplicates:Boolean;
       var
         I: Integer;
     Begin
//       TDuplicates = (dupIgnore, dupAccept, dupError);
        _OkInsert  := (not SearchKey(S)) or (Duplicates = dupAccept);
        If _OkInsert
        Then Begin
               If Sorted
               Then Add(S)
               Else Insert(Count,S);//<TCollection.Insert(Objects.NewStr(S));
             End;
        Insert_Not_Duplicates := _OkInsert;
     end;

Begin
  If S = ''
  Then S := ' ';

  If Not (Duplicates=dupAccept)
  Then  Result := Insert_Not_Duplicates
  else  Begin
          If Sorted
          Then Add(S)
          Else Insert(Count,S);//<TCollection.Insert(Objects.NewStr(S));
          Result := true;
        End;
End;


Function TNsStringList.Append(S : String):Boolean;
Begin
  Result := Add(S)=0;
end;


procedure TNsStringList.AddSItem(P : PSItem;
                                 ConvertIdioma:TConvertIdioma;
                                 OkDisposeSItems:Boolean); //Adiciona a lista a lista passada por aSItem e desaloca a lista se OkDisposeSItems = true;

//Adiciona a lista a lista passada por aSItem e desaloca a lista se OkDisposeSItems = true;
  {<Insere uma lista de SItems na collection }
  Var
    Aux : PSItem;
Begin
  Aux := P;
  while aux <> nil do
  Begin
    If Aux^.Value<> nil
    Then  Begin
            if @ConvertIdioma<>nil
            then NewStr(ConvertIdioma(Aux^.Value^))
            Else NewStr(Aux^.Value^);
          End;
    Aux := Aux^.next;
  End;

  If OkDisposeSItems
  Then DisposeSItems(P);
End;

procedure TNsStringList.AddSItem(P : PSItem);
Begin
  AddSItem(P,ConvertIdioma_Nil,true); {<Default deve destruir a lista passada}
end;



Constructor TClass_Of_Char.Create( aAsc_Ingles  : Char;
                                   aAsc_Console : Char;
                                   aAsc_GUI     : Char;
                                   aAsc_HTML    : String);
Begin
  Inherited Create;
  _Asc_Ingles  := aAsc_Ingles;
  _Asc_Console := aAsc_Console;
  _Asc_GUI     := aAsc_GUI;
  _Asc_HTML    := aAsc_HTML;
end;


Function TypeFld(Const aTemplate : tString;Var aSize : SmallWord):AnsiChar;overload;


  Function If_fldData:Boolean;

    //<  fldData   = 'D';  {< D = TipoData DD/DD/DD}
    //<  TypeDate = '\ ZB'^F^U+AnsiChar(31)+#0+'/'+'ZB'^U+AnsiChar(12)+#0+'/'+'ZB'+#0+^F;
    //<  _TypeDate = '\ ZB'^F^U+AnsiChar(31)+#0+'/'+'ZB'^U+AnsiChar(12)+#0+'/'+'ZB'{+#0}+^F;

  Begin
    Result := (aTemplate=fldData) or
              ((Pos('DD/DD/DD',aTemplate) <> 0) OR
              (Pos(TypeDate,aTemplate) <> 0) OR
              (Pos(_TypeDate,aTemplate) <> 0) OR
              (Pos(_TypeDate,aTemplate) <> 0));
    If Result
    Then Begin
           aSize := 3;
           TypeFld  := fldData;
         end;
  end;

  Function If_fld_LData:Boolean;
    //<  fld_LData = 'd' ;  {< d = Longint;Guarda a data compactada 'dd/dd/dd'}
  Begin
    Result := (aTemplate=fld_LData) or (Pos('dd/dd/dd',aTemplate) <> 0);
    If Result
    Then Begin
           aSize := sizeof(Longint);
           TypeFld  := fld_LData;
         end
  end;

  Function If_fld_DateTimeDos:Boolean;
  Begin
    Result := (aTemplate = FldDateTimeDos) or (Pos(FldSDateTimeDos,aTemplate) <> 0);
    If Result
    Then Begin
           aSize := sizeof(Longint);
           TypeFld  := fldDateTimeDos;
         end;
  end;

  Function If_fldLData:Boolean;
    //<  fldLData  = #1  ;  {< #1 = Longint;Guarda a data compactada '##/##/##'=FldSData}
  Begin
    Result := (aTemplate = fldLData) or (Pos(FldSData,aTemplate) <> 0);
    If Result
    Then Begin
           aSize := sizeof(Longint);
           TypeFld  := fldLData;
         end;
  end;
  Var
    I,j : Byte;
Begin
    If Not If_fld_DateTimeDos Then //retorna fldData
    If Not If_fldData Then // retorna fldData
    If Not If_fld_LData Then // retorna fld_LData
    If Not If_fldLData //fldLData
    Then Begin
            For i := 1 to length(aTemplate) do
            {$REGION '--->'}
              If Not (aTemplate[i] in [' ','z','Z',#0]) //Carateres de formatazao e separacao de campos
              Then
              Case aTemplate[i] of
                fldStrNumber,
                fldStr_Minuscula,
                fldStr             : Begin
                                       aSize := 1;
                                       For j := 1 to Length(aTemplate) do
                                         If  aTemplate[j] in [fldStrNumber,fldStr_Minuscula,fldStr]
                                         then Inc(aSize);

                                       Result := aTemplate[i];
                                       Exit;
                                     End;

                fldAnsiChar,
                fldAnsiChar_Minuscula,
                fldDoublePositive,{<'o'. Obs: O "o" minusculo e usado para real Positivo}
                fldDouble        : Begin
                                       aSize := 0;
                                       For j := 1 to Length(aTemplate) do
                                         If  aTemplate[j] in [fldAnsiChar,fldAnsiChar_Minuscula,fldDoublePositive,fldDouble]
                                         then Inc(aSize);

                                       Result := aTemplate[i];
                                       Exit;
                                     End;
                FldOperador,
                fldENUM,
                ^X,  {<Boolean Especial}
                fldBoolean,

                fldByte,
                fldShortInt        : Begin
                                       aSize := Sizeof(byte);
                                       Result := aTemplate[i];
                                       Exit;
                                     End;

                fldSmallWord       : Begin
                                       aSize := Sizeof(SmallWord);
                                       Result := aTemplate[i]; Exit;
                                     End;
                fldSmallInt        : Begin
                                       aSize := Sizeof(SmallInt);
                                       Result := aTemplate[i]; Exit;
                                     End;
                CharExecProc,
                fldAPPEND   ,
                fldSItems   ,

                fldLData,
                fld_LData,
                fldLHora,
                fld_LHora,
                fldLongInt         : Begin
                                       aSize := Sizeof(Longint);
                                       Result := aTemplate[i];
                                       Exit;
                                     End;

                fldDouble,
                fldDoublePositive
                                   : Begin
                                       aSize := Sizeof(TRealNum);
                                       Result := aTemplate[i]; Exit;
                                     End;

                fldReal6,
                fldReal6Positivo,
                fldReal6P,
                fldReal6PPositivo  : Begin
                                       aSize := Sizeof(Real);
                                       Result := aTemplate[i]; Exit;
                                     End;
                fldExtended        : Begin
                                       aSize := Sizeof(Extended);
                                       Result := aTemplate[i]; Exit;
                                     End;

                fldCheckBox,
                FldRadioButton
                {fldCheckBox,FldRadioButton}       : Begin
                                       aSize := SizeOffldCluster ;
                                       Result := aTemplate[i]; Exit;
                                     end;
                FldMemo,
                fldBLOb            : Begin
                                       Move(aTemplate[i+1]  ,aSize, sizeof(Integer));
                                       Result := aTemplate[i]; Exit;
                                     End;

                fldData            : Begin
                                       aSize := Sizeof(TypeData);
                                       Result := aTemplate[i]; Exit;
                                     End;

                CharShowPassword,
                fldXSPACES  ,
                fldZEROMOD         ,
                fldCONTRACTION     ,

          {      fldXTABTO          , Obs: Este tipo esta igual a fldSItems}

                fldXFieldNUM       ,

                fldHexValue        {<O HexValue nao entendi o seu tamanho???}
                                   : Begin
                                       aSize := 0;
                                       Result := aTemplate[i];
                                       Exit;
                                     end;
              End; //<  for;
              Result := #0; {<Tipo indefinido}
           {$ENDREGION}
         End; //<  If Not If_fldLData Then Begin.
end;

Function TypeFld_Size(Const aTemplate : ShortString):SmallWord;
Begin
  TypeFld(aTemplate,result);
end;

Function TypeFld(Const aTemplate : ShortString):AnsiChar;overload;
  Var aSize : SmallWord;
Begin
  Result := TypeFld(aTemplate,aSize);
end;

Function IsNumber_Real(Const aTemplate : ShortString):Boolean;
Begin
  Case TypeFld(aTemplate) of
    fldExtended,
    fldDouble         ,
    fldDoublePositive,
    fldReal6           ,
    fldReal6P          : Result := True
    Else                 Result := false;
  End;
end;

Function IsNumber_Integer(Const aTemplate : ShortString):Boolean;
Begin
  Case TypeFld(aTemplate) of
    fldByte      ,
    fldShortInt  ,
    fldSmallWord ,
    fldSmallInt  ,
    fldLongInt   ,
    fldENUM      ,
    fldCheckBox  ,
    FldRadioButton : Result := True
    Else             Result := false;
  End;
end;

Function IsNumber(Const aTemplate : ShortString):Boolean;
Begin
  Case TypeFld(aTemplate) of
    fldByte,
    fldShortInt,
    fldSmallWord,
    fldSmallInt,
    fldLongInt,
    fldDouble,
    fldDoublePositive,
    fldReal6,
    fldReal6P,
    fldENUM,
    fldCheckBox,
    FldRadioButton : IsNumber:= True
    else         IsNumber:= False
  end;
end;

Function IsData(Const aTemplate : ShortString):Boolean;
begin
  Result := TypeFld(aTemplate) in [fldData,fldLData,fld_LData,fldDateTimeDos,fldDateTimeDos];
end;

Function IsHora(Const aTemplate : ShortString):Boolean;
begin
  Result := TypeFld(aTemplate) in [fld_LHora,fldLHora];
end;

Procedure UpperCase(Var S : AnsiString);
 var
   I : Integer;
begin
  for i := 1 to length(s) do
  begin
    case s[i] of
      'a'..'z' : s[i] := AnsiChar(ord(s[i])-32);
      ' '      : s[i] := 'µ'; //A Maiusculo com agudo
      'ƒ'      : s[i] := '¶'; //A Maiusculo com circonflexo
      '…'      : s[i] := '·'; //A Maiusculo com crase
      'Æ'      : s[i] := #143; //A Maiusculo com til
//    (Asc_Console : #143;Asc_Ingles :'A';Asc_GUI :'Ã';Asc_HTML :'&Atilde;'), // 07 A Maiusculo com til

      '‡'      : s[i] := '€'; //C cedilha maiusculo               
      
      '‚'      : s[i] := ''; //E maiusculo com agudo

      'ˆ'      : s[i] := 'Ò'; //E maiusculo com circonflexo

      '¡'      : s[i] := 'Ö'; //I maiusculo com agudo

      '¢'      : s[i] := 'à'; //O maiusculo com agudo

      
      'ä'      : s[i] := 'å'; //O maiusculo com til

      '“'      : s[i] := 'â'; //O maiusculo com circonflexo

      '£'      : s[i] := 'é'; //U maiusculo com agudo

      ''      : s[i] := 'š'; //U maiusculo com trema                          
    end;   
  end;
end;



    
procedure ConverteMaiuscula( var str:AnsiString);
begin
  //str := Sgc(AnsiUpperCase(scg(Str)));
  UpperCase(Str);
end;

Function FMaiuscula(str:AnsiString):AnsiString;
var
  i : integer;
begin
//  Result := Sgc(AnsiUpperCase(scg(Str)));
  Result := Str;
  UpperCase(Result);
end;

Procedure LowerCase(Var S : AnsiString);
 var
   I : Integer;
begin
  for i := 1 to length(s) do
  begin
    case s[i] of
      'A'..'Z' : s[i] := AnsiChar(ord(s[i])+32);
      'µ'      : s[i] := ' '; //A Maiusculo com agudo
      '¶'      : s[i] := 'ƒ'; //A Maiusculo com circonflexo
      '·'      : s[i] := '…'; //A Maiusculo com crase         
      'Ç'      : s[i] := 'Æ'; //A Maiusculo com til               

      '€'      : s[i] := '‡'; //C cedilha maiusculo               
      
      ''      : s[i] := '‚'; //E maiusculo com agudo

      'Ò'      : s[i] := 'ˆ'; //E maiusculo com circonflexo

      'Ö'      : s[i] := '¡'; //I maiusculo com agudo

      'à'      : s[i] := '¢'; //O maiusculo com agudo

      
      'å'      : s[i] := 'ä'; //O maiusculo com til

      'â'      : s[i] := '“'; //O maiusculo com circonflexo

      'é'      : s[i] := '£'; //U maiusculo com agudo

      'š'      : s[i] := ''; //U maiusculo com trema                          
    end;   
  end;
end;

//: 'µ';   // 04 A Maiusculo com agudo
//: ' ';   // 00 a Minuscolo com agudo

//: 'ƒ';   // 01 a Minuscolo com circonflexo
//: '¶';   // 06 A Maiusculo com circonflexo

//: '…';  // 02 a Minuscolo com crase
//: '·';   // 05 A Maiusculo com crase

//: 'Æ';   // 03 a Minuscolo com til
//: 'Ç';   // 07 A Maiusculo com til

//: '‡';  // 08 c cedilha Minuscolo
//: '€';  // 09 C cedilha maiusculo

//: '‚';  // 10 e Minuscolo com agudo
//: '';  // 12 

//: 'ˆ';   // 11 e Minuscolo com circonflexo
//: 'Ò';   // 13 E maiusculo com circonflexo

//: '¡';   // 14 i Minuscolo com agudo
//: 'Ö';   // 15 I maiusculo com agudo

//: '¢';   // 16 o Minuscolo com agudo
//: 'à';   // 17 O maiusculo com agudo

//: 'ä';   // 18 o Minuscolo com til
//: 'å';   // 19 O maiusculo com til

//: '“';  // 20 o Minuscolo com circonflexo
//: 'â';   // 21 O maiusculo com circonflexo

//: '£';   // 22 u minusculo com agudo
//: 'é';   // 23 U maiusculo com agudo

//: '';   // 24 u minusculo com trema
//: 'š';   // 25 U maiusculo com trema


Function FMinuscula(str:AnsiString):AnsiString;
var
  i:Integer;
  S : tString;
begin
  result := str;
  LowerCase(result );
  
 {  if Str <> ''
  Then Begin
//        Mantém a primeira letra em Maiuscula
        S := Sgc(AnsiUpperCase(scg(copy(Str,1,1))));
        if length(str)>1
        then Begin
              Result := Copy(str,2,length(str)-1);
              Result := s + Sgc(AnsiLowerCase(scg(Result)));
             end
        Else Result := s;
       End
  Else Result := '';
}
end;

Function IsValid_DataBase_Filename(Const AFilename  : tString):Boolean;
   {<Retorna True Se a extencao de AFilename pertence um dos tipos de arquivo do Data Base}
  Var
    i : Byte;
Begin
  Result := False;
  For i := 1 to High(Const_Ext_Array) do
  Begin
     If Pos(FMaiuscula(Const_Ext_Array[i]),FMaiuscula(AFilename))<>0
     Then Begin
            Result := true;
            break;
          end;
  end;
end;


(*
FUNCTION IsValidPtr(Const ADDR:POINTER):BOOLEAN ;
Begin
    ASM
        XOR eAX , eAX               {<IsValidPtr=False}
        MOV eDX , Dword PTR ADDR    {<eDx = @Addr     }
        CMP eDX , 0                 {<Testa ADDR = nil}
        JE @@exit                   {<If ADDR = nil Then exit }
        VERR eDX                    {<Checa se addr e um ponteiro valido}
        JNE @@exit                  {<Se nao e valido sai }
        INC eAX                     {<IsValidPtr=True}
      @@exit :
    END;
End;*)


procedure DisposeStr(var P: PtString);
Begin
  Try
    if (P <> nil)
    then FreeMem(P, Length(P^) + 1);
  Except
  End;
  P := nil;
end;

{Function SetOkMsgDuplicidade(Const aOkMsgDuplicidade:Boolean):Boolean;
Begin
  SetOkMsgDuplicidade := OkMsgDuplicidade;
  OkMsgDuplicidade    := aOkMsgDuplicidade;
end;}

Function FMb_Bits(Const aBit:Byte):Longint;
Begin
  If aBit <> 0
  Then Result := Mb_Bit01 Shl aBit
  else Result := Mb_Bit00;

(*  Case aBit of
    0 : FMb_Bits := Mb_Bit00;
    1 : FMb_Bits := Mb_Bit01;
    2 : FMb_Bits := Mb_Bit02;
    3 : FMb_Bits := Mb_Bit03;
    4 : FMb_Bits := Mb_Bit04;
    5 : FMb_Bits := Mb_Bit05;
    6 : FMb_Bits := Mb_Bit06;
    7 : FMb_Bits := Mb_Bit07;
    8 : FMb_Bits := Mb_Bit08;
    9 : FMb_Bits := Mb_Bit09;
   10 : FMb_Bits := Mb_Bit10;
   11 : FMb_Bits := Mb_Bit11;
   12 : FMb_Bits := Mb_Bit12;
   13 : FMb_Bits := Mb_Bit13;
   14 : FMb_Bits := Mb_Bit14;
   15 : FMb_Bits := Mb_Bit15;
   16 : FMb_Bits := Mb_Bit16;
   17 : FMb_Bits := Mb_Bit17;
   18 : FMb_Bits := Mb_Bit18;
   19 : FMb_Bits := Mb_Bit19;
   20 : FMb_Bits := Mb_Bit20;
   21 : FMb_Bits := Mb_Bit21;
   22 : FMb_Bits := Mb_Bit22;
   23 : FMb_Bits := Mb_Bit23;
   24 : FMb_Bits := Mb_Bit24;
   25 : FMb_Bits := Mb_Bit25;
   26 : FMb_Bits := Mb_Bit26;
   27 : FMb_Bits := Mb_Bit27;
   28 : FMb_Bits := Mb_Bit28;
   29 : FMb_Bits := Mb_Bit29;
   30 : FMb_Bits := Mb_Bit30;
   31 : FMb_Bits := Mb_Bit31;{< O longint tem o bit do sinal nao posso usalo}
   else Begin FMb_Bits := 0;runError(87{<ParametroInvalido});end;
   end;*)
end;

FUNCTION IsFileOpen(VAR F:FILE):BOOLEAN ;
BEGIN
  Result  := (FILEREC (F ).MODE = System.FmInOut )  OR
             (FILEREC (F ).MODE = System.FmOutput ) OR
             (FILEREC (F ).MODE = System.FmInput )  ;

END ;

FUNCTION IsFileOpen(VAR F:Text):BOOLEAN ;
  (*
const fmClosed = $D7B0;  //<  closed file
const fmInput  = $D7B1;  //<  reset file (TTextRec)
const fmOutput = $D7B2;  //<  rewritten file (TTextRec)
const fmInOut  = $D7B3;  //<  reset or rewritten file (TFileRec)
const fmCRLF   = $8      //<  DOS-style EoL and EoF markers (TTextRec)
const fmMask   = $D7B3;  //<  mask out fmCRLF flag (TTextRec)
  *)
BEGIN
  Result := (TextRec(F).MODE = System.FmInOut )  OR
            (TextRec(F).MODE = System.FmOutput ) OR
            (TextRec(F).MODE = System.FmInput );
END ;

FUNCTION IsAssignFile(VAR F:FILE):BOOLEAN ;overload;
BEGIN
  Result := SysWideStringToString(FILEREC(F).name) <> '';
  If Result
  Then
  Result :=     (FILEREC (F ).MODE = System.FmInOut )  OR
                (FILEREC (F ).MODE = System.FmOutput ) OR
                (FILEREC (F ).MODE = System.FmInput )  OR
                (FILEREC (F ).MODE = System.fmClosed) ;
END ;

FUNCTION IsAssignFile(VAR F:Text):BOOLEAN ;overload;
BEGIN
  Result := SysWideStringToString(TextRec(F).name) <> '';
  If Result
  Then
  Result := (TextRec(F).MODE = System.FmInOut )  OR
            (TextRec(F).MODE = System.FmOutput ) OR
            (TextRec(F).MODE = System.FmInput ) OR
            (TextRec(F).MODE = System.fmClosed) ;
END ;



(*
FUNCTION IsValidPtr (ADDR:POINTER):BOOLEAN ;ASSEMBLER;
ASM {}
{$IFNDEF MsDos} {No ‚ DOS modo Real}
    XOR AX , AX { Faz IsValidPtr=False}
    MOV DX , SmallWord PTR ADDR+ 2 { Inicializa DX com ADDR}
    CMP DX , 0 {Teste se addr igual a NIL}
    JE @@exit  {Se sim sai com IsValidPtr=False}
    VERR DX    {Testa se addr ‚ um endreco valido}
    JNE @@exit {Se nao ‚ valido sai}
    INC AX     {IsValidPtr=True}
@@exit :       {Retorna com IsValidPtr=False}
{$ELSE} {}
    MOV AX , 1 {Retorna com IsValidPtr=true}
{$ENDIF} {}
END;
*)

{PROCEDURE DISCARD (Var AClass);
BEGIN
 IF TClass(AClass) <> NIL THEN
 BEGIN
   DISPOSE (TClass(AClass), Destroy );
   TClass(AClass) := NIL ;
 END ;
END ;}
(*
PROCEDURE DISCARD (AClass:TClass);
BEGIN
  {Esta funcao so deve ser usada para debugar se todos os objetos
   passado para discard sao realmente objetos erdados de TClass
  }
END ;
*)

(*
PROCEDURE DISCARD (VAR AClass);
{   Versao do discard usando aobsolute}
  VAR Objeto : TClass ABSOLUTE AClass;
BEGIN
 IF IsValidPtr(Objeto)
 THEN DISPOSE (Objeto ,Destroy);
 Objeto := NIL ;
END ;
*)

Function FGetMem(Var Buff ;Const TamBuff: Word) : Boolean;
Begin
  FGetMem := False; {<Pointer(Buff) := Nil;}
  if MaxAvail > TamBuff
  Then Begin
          GetMem(Pointer(Buff),TamBuff);
          If Pointer(Buff) <> Nil Then
          Begin
            If OkZeraFGetMem Then
              FillChar(Pointer(Buff)^,TamBuff,0);
            FGetMem := True;
          End;
        End
  Else Result := False;
End;

Procedure FFreeMem(Var Buff;Const TamBuff: Word) ;
Begin
Try

  If (Pointer(Buff) <> Nil) and (TamBuff>0) Then
  Begin
    Try
      FreeMem(Pointer(Buff),TamBuff);
    Finally
      Pointer(Buff) := Nil;
    End;

  End;

Except
  Pointer(Buff) := Nil;
end;

End;

Function CGetMem(Const BuffOriginal:Pointer ;Const TamBuff: Word):Pointer;
{<Retorna um ponteiro para a memoria alocada e este ponteiro aponta para
uma copia dos dados passado por BuffOriginal }
{Var
  P : Pointer;  }
Begin
  If (TamBuff > 0) and (BuffOriginal<>nil) Then
  Begin
    GetMem(Result,TamBuff);
    If (Result <> nil) Then
      Move(BuffOriginal^,Result^,TamBuff);
  End
  Else Result := nil;
End;

(*
Function CFreeMem(Const BuffOriginal:Pointer ;Const TamBuff: SmallWord):Boolean;
{Desaloca um ponteiro para a memoria alocada e este ponteiro aponta para
uma copia dos dados passado por BuffOriginal }
Var
  P : Pointer;
Begin

  If (TamBuff > 0) and (BuffOriginal<>nil) Then
  Begin
    FreeMem(P,TamBuff);
    CFreeMem := True;
  End
  Else CFreeMem := False;
End;*)

{**************************************************************************}


Function Strhex( w:   SmallWord;
                 Str_Indicador:tString {<Caractere que indica código hexadecial. % para HTML e $ para pascal}
               ) : tString;Overload;

  const
      hex : Array[0..$F] of AnsiChar = '0123456789ABCDEF';
BEGIN
  result := Str_Indicador+Hex[HI(w) SHR 4]+
                          Hex[HI(w) AND $F]+
                          Hex[LO(w) SHR 4]+
                          hex[LO(w) AND $F];
END;

Function Strhex( w :   SmallWord) : tString; Overload;
  const
      hex : Array[0..$F] of AnsiChar = '0123456789ABCDEF';
BEGIN
  result := '$'+Hex[HI(w) SHR 4]+Hex[HI(w) AND $F]+Hex[LO(w) SHR 4]+hex[LO(w) AND $F];
END;


(*Procedure Cursor(Const Condicao : BooLean);
  Var
    regIntr      : Registers;
begin
  if Condicao then
  with regIntr do begin
    ah := 1;ch := 4;cl := 6;
    CursorLigado := True;
  end
  Else with regIntr do begin
{    ah := 1;ch := 15;cl := 15;}
     ah := 1;ch := 17;cl := 16;
    CursorLigado := False;
  end;
  Intr($10,regIntr);
end;*)

Procedure Cursor(Const Condicao : BooLean);
begin
end;

Function FPrimeiroHandleLivre : SmallInt;
  {<Retorna o numero de arquivos abertos no sistema operacional}
  {<TaStaus : Retorna o numero do error se ouver}
Var F   : File; {< Devolve o Numero de arquivos arbertos }
  {$I-}
Begin
  If IoResult=0 Then;
  Assign(f,'FHandle.$$$');

  {$I-}rewrite(F);{$I+}
  TaStatus := IoResult;
  If TaStatus = 0 Then
  Begin
    FPrimeiroHandleLivre:= FileRec(F).Handle;
    {$I-} Close(f); {$I+}
    {$I-} erase(f); {$I+}
  End
  Else
    FPrimeiroHandleLivre:= 0;
End;


function SeExiste( NomeArquivo :PathStr) :boolean;
  VAR
    F         : FILE of byte;
    Attr      : Word;
BEGIN
(*  Try
    Assign   (F, NomeArquivo);
    {$I-}
    GetFAttr (F ,Attr);
    {$I+}

  Except
  end;
    TaStatus := DosError;
   SeExiste := TaStatus= 0;
//  If System.IoResult = 0 Then;{<Obrigatorio ser chamando se nao InOutRes ser  usado nao proximo acesso ao arquivo}
*)
  NomeArquivo := ExpandFileName(NomeArquivo);
  If Sysutils.FileExists(NomeArquivo)
  Then TaStatus := 0
  Else TaStatus := 2;//  ArquivoNaoEncontrado2 = 002;
  Result := TaStatus = 0;
End ;

Function DeleteFile( Const Nome : PathStr):Byte;
  {$I-}
var
  F         : file;
  WNome : tString;
Begin
  WNome := Nome;

  If (nome = 'LPT1') OR (nome = 'LPT2') OR (nome = 'COM1') OR (nome = 'COM2') OR (nome = 'COM3') OR (nome = 'COM4')
  THEN BEGIN
         RESULT := 0;
         EXIT;
      END;

  Assign(F,Nome);
  Try
    if SeExiste (Nome) then
    begin
      If IoResult=0 Then; {<Zera InOutRes}
      {$I-}
      Erase(f);
      {$I+}
      TaStatus := IoResult;
    end;

  Except
    TaStatus := IoResult;
  end;
  DeleteFile := TaStatus;
End;

(*
Procedure BufferDoTeclado (Const  Msg : tString ); {< Buffer do teclado }
{$F+}
  Var
    Al, { Al = 1 Se buffer do teclado cheio. Al = 0 caso contrario }
    L,TamMsg : Byte;

  Function BufferOrd ( SmallWord,ScanCod : Byte) : Byte; {< Retorna AL }
    { Scan Cod = 0 Entao teclas especiais
      Scan Cod <> 0 Entao carcater normais }
    Var Regs : Registers;
  Begin
    with regs do
    Begin
      ah := $05; ch := SCanCod; cl := SmallWord;
      intr($16,regs);
      BufferOrd := Al;
    End;
  end;

Begin
  L := 1;
  TamMsg := Byte(Msg[0]);
  Repeat
    Al := BufferOrd(Ord(Msg[L]),1);
    Inc(L);
  until (L = TamMsg+1) or ( Al = 1) ;

end;
*)

Procedure BufferDoTeclado (Const  Msg : tString ); {< Buffer do teclado }
{$F+}
  Var
    Al, {< Al = 1 Se buffer do teclado cheio. Al = 0 caso contrario }
    L,TamMsg : Byte;

  Function BufferOrd ( SmallWord,ScanCod : Byte) : Byte; {< Retorna AL }
    {< Scan Cod = 0 Entao teclas especiais
      Scan Cod <> 0 Entao carcater normais }

  Begin
(*    ASM
      Mov ah,$05
      Mov ch,SCanCod;
      Mov cl,SmallWord;
      int $16;
      {BufferOrd := Al;}
    End;*)
  end;

Begin
  L := 1;
  TamMsg := length(Msg);
  Repeat
    Al := BufferOrd(Ord(Msg[L]),1);
    Inc(L);
  until (L = TamMsg+1) or ( Al = 1) ;

end;


function conststr ( i : Longint;  Const a : AnsiChar     ) : AnsiString;
begin
  if i > 0
  then Begin
         SetLength(Result,i);
         FillChar(Result[1],i,a);
//         writeLn(Length(Result))
       End
  else Result := '';

  end;

function FillStr(Const aAnsiChar : AnsiChar ; Const Len : integer) : AnsiString;
  {<
    Retorna uma constante de tamanho Len
  }
begin
  if Len > 0
  then Begin
         SetLength(Result,len);
         FillChar(Result[1],Len,aAnsiChar);
       End
  else Result := '';
end;


Function IStr(Const I : Longint; Const Formato : tString) : tString;
Var IAux : tString;
    Tam  : Longint;
Begin
  Str(I:0,Iaux);
  Tam := length(formato)-length(IAux);
  If Tam > 0
  Then IStr := ConstStr(Tam,'0') + IAux
  Else IStr := IAux;
End;

Function IStr( Const I : Longint) : tString;
Begin
  Str(I:0,Result);
End;


Function IStr   (Const I : tString; Const Formato : tString) : tString;
Begin
  Result := I;
  While (Pos(' ',Result )<>0) and (Length(Result)>0)
  do delete(Result,Pos(' ',Result ),1);

  While Length(Result) < Length(Formato)
  do Insert('0',Result,1);
end;


Function CloseLst:SmallInt;
Begin
  If IsFileOpen(Db_Global.Lst)
  Then Begin
          Try
            Try
              {$I-}
              Close(Db_Global.lst);
               {$I+}

            Finally
              TaStatus := IoResult;
              TextRec(Db_Global.Lst ).MODE := fmClosed;
              Result   := TaStatus;
            End;

          Except
          End;
       End
  Else CloseLst   := 0;
End;

(*
Function Get_List_Class_Of_Char:TNsStringList;

// Retorna uma a lista de fontes usando a chave font Console.

{<
  OBS : A Chave de AddObject esta usando a FONT TERMINAL
  Var
    Index : integer;
    SCh   : AnsiString;
    Ch    : AnsiChar;
  Begin
      If Byte(Ch) >= 127
      Then Begin
             Index := List_Class_Of_Char.IndexOf(ch);
             If Index >= 0
             Then SCh := TClass_Of_Char( List_Class_Of_Char.Objects[Index]).Asc_HTML
             Else SCh := ch;
           End
      Else SCh := ch;
  End;
}

{

Tabela de acentos e caracteres especiais em HTML
Á ............. &Aacute;
á ............. &aacute;
Â ............. &Acirc;
â ............. &acirc;
À ............. &Agrave;
à ............. &agrave;
Å ............. &Aring;
å ............. &aring;
Ã ............. &Atilde;
ã ............. &atilde;
Ä ............. &Auml;
ä ............. &auml;
Æ ............. &AElig;
æ ............. &aelig;

É ............. &Eacute;
é ............. &eacute;
Ê ............. &Ecirc;
ê ............. &ecirc;
È ............. &Egrave;
è ............. &egrave;
Ë ............. &Euml;
ë ............. &euml;
Ð ............. &ETH;
ð ............. &eth;

Í ............. &Iacute;
í ............. &iacute;
Î ............. &Icirc;
î ............. &icirc;
Ì ............. &Igrave;
ì ............. &igrave;
Ï ............. &Iuml;
ï ............. &iuml;

Ó ............. &Oacute;
ó ............. &oacute;
Ô ............. &Ocirc;
ô ............. &ocirc;
Ò ............. &Ograve;
ò ............. &ograve;
Ø ............. &Oslash;
ø ............. &oslash;
Õ ............. &Otilde;
õ ............. &otilde;
Ö ............. &Ouml;
ö ............. &ouml;

Ú ............ &Uacute;
ú ............ &uacute;
Û ............ &Ucirc;
û ............ &ucirc;
Ù ............ &Ugrave;
ù ............ &ugrave;
Ü ............ &Uuml;
ü ............ &uuml;

Ç ............ &Ccedil;
ç ............ &ccedil;


Ñ ............ &Ntilde;
ñ ............ &ntilde;


< ............ &lt;
> ............ &gt;
& ............ &amp;
" ............ &quot;
® ............ &reg;
© ............ &copy;


Ý ............ &Yacute;
ý ............ &yacute;


Þ ............ &THORN;
þ ............ &thorn;


ß ............ &szlig;


}


Begin
{Inicializa a tabela de caracter}
  Result := TNsStringList.Create;
  With Result do
  Begin
    OkDestroy_Object := true;
    Sorted           := true;

            {Terminal}                 {<IO TER GUI {HTML}
    AddObject(' ',TClass_Of_Char.Create('a',' ','á','&aacute;'));{<a Minuscolo com agudo}
    AddObject('ƒ',TClass_Of_Char.Create('a','ƒ','â','&acirc;')); {<a Minuscolo com circonflexo}
    AddObject('…',TClass_Of_Char.Create('a','…','à','&agrave;'));{<a Minuscolo com crase}
    AddObject('Æ',TClass_Of_Char.Create('a','Æ','ã','&atilde;'));{<a Minuscolo com til}
    AddObject('µ',TClass_Of_Char.Create('A','µ','Á','&Aacute;')); {<A Maiusculo com agudo}
    AddObject('·',TClass_Of_Char.Create('A','·','À','&Agrave;')); {<A Maiusculo com crase}
    AddObject('Ç',TClass_Of_Char.Create('A','Ç','Ã','&Atilde;')); {<A Maiusculo com til  }

    AddObject('‡',TClass_Of_Char.Create('c','‡','ç','&ccedil;')); {<c cedilha Minuscolo}
    AddObject('€',TClass_Of_Char.Create('C','€','Ç','&Ccedil;')); {<C cedilha maiusculo    }

    AddObject('‚',TClass_Of_Char.Create('e','‚','é','&eacute;'));{<e Minuscolo com agudo}
    AddObject('ˆ',TClass_Of_Char.Create('e','ˆ','ê','ê'));       {<e Minuscolo com circonflexo}
    AddObject('',TClass_Of_Char.Create('E','','É','&Eacute;'));{<E maiusculo com agudo}
    AddObject('Ò',TClass_Of_Char.Create('E','Ò','Ê','&Ecirc;')); {<E maiusculo com circonflexo}

    AddObject('¡',TClass_Of_Char.Create('i','¡','í','&iacute;'));{<i Minuscolo com agudo}
    AddObject('Ö',TClass_Of_Char.Create('I','Ö','Í','&Iacute;')); {<I maiusculo com agudo}

    AddObject('¢',TClass_Of_Char.Create('o','¢','ó','ó'));        {<o Minuscolo com agudo}
    AddObject('à',TClass_Of_Char.Create('O','à','Ó','&Oacute;')); {<O maiusculo com agudo}
    AddObject('ä',TClass_Of_Char.Create('o','ä','õ','õ'));         {<o Minuscolo com til}
    AddObject('å',TClass_Of_Char.Create('O','å','Õ','Õ'));         {<O maiusculo com til}
    AddObject('“',TClass_Of_Char.Create('o','“','ô','ô'));         {<o Minuscolo com circonflexo}
    AddObject('â',TClass_Of_Char.Create('O','â','Ô','Ô'));         {<O maiusculo com circonflexo}

    AddObject('£',TClass_Of_Char.Create('u','£','ú','ú'));        {<u minusculo com agudo}
    AddObject('é',TClass_Of_Char.Create('U','é','Ú','&Uacute;')); {<U maiusculo com agudo}
    AddObject('',TClass_Of_Char.Create('u','','ü','&#252;')); {<u minusculo com trema}
    AddObject('š',TClass_Of_Char.Create('U','š','Ü','&#220;')); {<U maiusculo com trema}
  End;
End;
*)

//========================================================================================================
{$REGION '--> O Programa gcic_ec.exe modo console não está aceitando caracteres em português.'}
//========================================================================================================
{ DONE 1  -oGCIC_ec.EXE.2010/11/17 -cBUGS DO CÓDIGO :
 2010/11/17
   •  As rotinas de conversão de caracteres de Terminal para GUI e GUI para HTML não está funcionando como
      deveria. Ou seja o Ã é convertido para ã.

   •  SOLUÇÃO:
        • Em Get_List_Class_Of_Char setar a propriedade CaseSensitive  := true;
        • Em Get_List_Class_Of_Char_GUI setar a propriedade CaseSensitive  := true;

}
{$ENDREGION}
//========================================================================================================

Function Get_List_Class_Of_Char:TNsStringList;
 {
  Retorna uma a lista de fontes usando a chave font GUI.
 }
 VAR
   I : Integer;
Begin
{Inicializa a tabela de caracter}
  Result := TNsStringList.Create;
  With Result do
  Begin
    OkDestroy_Object := true;
    Sorted           := true;
    CaseSensitive    := true;
    i:=0;
    For i := 0 to high(Array_Of_Char)-1 do
    With Array_Of_Char[i] do
    begin
      AddObject(Asc_Console,TClass_Of_Char.Create(Asc_Ingles,Asc_Console,Asc_GUI,Asc_HTML));{<a Minuscolo com agudo}
    end;
  End;
End;



Function Get_List_Class_Of_Char_GUI:TNsStringList;
 {
  Retorna uma a lista de fontes usando a chave font GUI.
 }
 VAR
   I : Integer;
Begin
{Inicializa a tabela de caracter}
  Result := TNsStringList.Create;
  With Result do
  Begin
    OkDestroy_Object := true;
    Sorted           := true;
    CaseSensitive    := true;

    For i := 0 to high(Array_Of_Char)-1 do
    With Array_Of_Char[i] do
    begin
      AddObject(Asc_GUI,TClass_Of_Char.Create(Asc_Ingles,Asc_Console,Asc_GUI,Asc_HTML));{<a Minuscolo com agudo}
    end;
  End;
End;

Function String_Asc_Console_to_Asc_HTML(Const S: String): String;
    {
     Convert os caracteres acentuados do formato console para códigos HTML;

     Obs:
       Está conversão desabilita os código html
    }
  Var
    Index,I : integer;
Begin
  Result := '';
  For I := 1 to Length(S) do
  Begin
{    If S[i] >= #127
    Then Begin}
           Index := List_Class_Of_Char.IndexOf(S[i]);
           If Index >= 0
           Then Begin
                  Result := Result + TClass_Of_Char( List_Class_Of_Char.Objects[Index]).Asc_HTML;
                End
           Else Result := Result + S[i];
{         End
    Else Result := Result + S[i];}
  End;
End;

Function SCH(Const S: String): String;
Begin
  Result := String_Asc_Console_to_Asc_HTML(S);
end;


Function SCG( S: String): String;
    {<
     Convert os caracteres acentuados para codigos da interface gráfica GUI;
    }
  Var
    Index,I : integer;

Begin
{  if S<>''
  Then SysOemToAnsiChar(S,Result)
  Else Result := '';
}  

  Result := '';
  For I := 1 to Length(S) do
  Begin
    If S[i] >= #127
    Then Begin
           Index := List_Class_Of_Char.IndexOf(S[i]);
           If Index >= 0
           Then Begin
                  Result := Result + TClass_Of_Char( List_Class_Of_Char.Objects[Index]).Asc_GUI;
                End
           Else Result := Result + S[i];
         End
    Else Result := Result + S[i];
  End;


End;

Function String_Asc_Console_to_Asc_GUI( S: String): String;
Begin
  Result := SCG(S);
end;

Function SGC( S: String): String;

 {DONE 3 -o/\/\ar/\carai -cBUGS DO CÓDIGO : 06/11/28
  . A chave de pesquisa deve ser GUI e não terminal.
  . PASSOS
      . ok - Criar a constante List_Class_Of_Char_GUI : TNsStringList = nil;
      . ok - Em Procedure Create excutar List_Class_Of_Char_GUI := Get_List_Class_Of_Char_GUI;
      . OK - Criar array com as seguintes colunas:
              . Col1 = Fonte Console.
              . Col2 = Fonte Ingles.
              . Col3 = Fonte GUI.
              . Col4 = Font HTML.
      . ok - Criar Get_List_Class_Of_Char_GUI e preenncher a coleção com TArray_Of_AnsiChar. Nota: Chave = TArray_Of_AnsiChar.Col3
      . ok - Em String_Asc_GUI_to_Asc_Console usar a classe Class_Of_AnsiChar_GUI.
      . ok - Em Get_List_Class_Of_Char preenncher a coleção com TArray_Of_AnsiChar. Nota: Chave = TArray_Of_AnsiChar.Col1
  }

  Var
    Index,I : integer;
Begin
{ desative pq as vezes dar certo e outras vezes não.
  if S<>''
  then SysAnsiCharToOem(S,Result)
  Else Result := '';
}

  if List_Class_Of_Char_Gui = NIL
  then BEGIN
           RESULT := s;
           EXIT;
       END
  ELSE Result := '';

  For I := 1 to Length(S) do
  Begin
    If ord(S[i]) >= 127
    Then Begin
           Index := List_Class_Of_Char_Gui.IndexOf(S[i]);
           If Index >= 0
           Then Begin
                  Result := Result + TClass_Of_Char( List_Class_Of_Char_gui.Objects[Index]).Asc_Console;
                End
           Else Result := Result + S[i];
         End
    Else Result := Result + S[i];
  End;

end;

Function String_Asc_GUI_to_Asc_Console( S: String): String;
Begin
  Result := SGC(S);
end;



Function SGH( S: String): String;
//Converte ASC II tipo GUI para tipo HTML
begin
  Result := SCH(SGC(S));
end;

Function SCI(Const S: String): String;
    {<
     Convert os caracteres acentuados para codigos ASC equivalente em Ingles;
    }
  Var
    Index,I : integer;
Begin
  Result := '';
  For I := 1 to Length(S) do
  Begin
    If S[i] >= #127
    Then Begin
           Index := List_Class_Of_Char.IndexOf(S[i]);
           If Index >= 0
           Then Begin
                  Result := Result + TClass_Of_Char( List_Class_Of_Char.Objects[Index]).Asc_Ingles;
                End
           Else Result := Result + S[i];
         End
    Else Result := Result + S[i];
  End;
  Result := Result;
End;

Function String_Asc_Console_to_Asc_Ingles(Const S: String): String;
Begin
  Result := SCI(S);
end;


Procedure DesabilitaTabelasAberta(var wEndOpenFiles,wEndCloseFiles : TipoProc);
Begin
  wEndOpenFiles  := EndOpenFiles ;
  wEndCloseFiles := EndCloseFiles;
  If @EndCloseFiles <> Nil Then
  Begin
    EndCloseFiles;
    EndOpenFiles  := nil;
    EndCloseFiles := nil;
  End;
  CloseLst;
End;

Procedure AbilitaTabelasAberta(var wEndOpenFiles,wEndCloseFiles : TipoProc);
Begin
  If (@wEndOpenFiles <>nil) and (@wEndCloseFiles<>nil)
  Then Begin
    EndOpenFiles  := wEndOpenFiles ;
    EndCloseFiles := wEndCloseFiles;
    If @EndOpenFiles<> Nil Then EndOpenFiles;
  End;
End;

function NewSItem(const Str: tString; ANext: PSItem): PSItem;
var
  Item: PSItem;
begin
  New(Item);
  Item^.Value := Objects.NewStr(Str);
  Item^.Next := ANext;
  NewSItem := Item;
end;

procedure DisposeSItems(VAR AItems: PSItem);overload;
var  P : PSItem;
begin
  Try
    While (AItems <> nil) do
    begin
      P := AItems^.Next;
      If (AItems^.Value<>nil) then DisposeStr(AItems^.Value);
      Dispose(AItems);

      AItems := P;
    end;
    AItems := nil;
  Except
    AItems := nil;
    Raise;
  end;

end;

procedure DisposeSItems(Var AStrItems: PtString);overload;
  Var
    P : PSItem;
Begin
  try
    If (AStrItems <> nil) and (AStrItems^ <> '') and (AStrItems^[1] in [fldSItems,fldENUM])
    Then Begin
           Case AStrItems^[1] of
             fldSItems,
             fldENUM : Begin
                           Move(AStrItems^[2],P,4);

                           if IsValidPtr(P)
                           then DisposeSItems(P);
                         End;


           end;
         end
    Else DisposeStr(AStrItems);

  AStrItems := nil;
  Except
    AStrItems := nil;
    //Igonora a exceção porque AStrItems pode ter sido desalocador em outro local que nao foi criado.
    Raise;
  end;


end;

function  MaxItemStrLen(AItems: PSItem) : integer; Overload;
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

function  MaxItemStrLen(PSItems: tString) : integer;Overload;
  Var
    P : PSitem;
Begin
  if PSItems <> ''
  then Begin
         Move(PSItems[2],P,Sizeof(Pointer));
         if P<>nil
         then Result := MaxItemStrLen(p)
         Else Result := -1;

       End
  Else Result := -1;

End;

function  SItemsLen(S: PSItem) : integer;
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

function  GetItemByName(AItems: PSItem; aValue: AnsiString) : PSItem;
  //Se se achar retorna PSItem onde: UpperCase(AItems^.Value^) = Uppercase(aValue)
  //Se não achar retorna nil
begin
  While (AItems <> nil) do
  begin
    If (AItems^.Value <> nil)
    Then If sysUtils.UpperCase(AItems^.Value^) = sysUtils.Uppercase(aValue)
         then Begin
                Result := AItems;
                exit;
              End;

    AItems := AItems^.Next;
  end;
  //Se não achar retorna nil
  Result := nil;
end;

function  GetLinha_ItemByName(AItems: PSItem; aValue: AnsiString) : Integer;
  //Se se achar retorna o número da linha onde: UpperCase(AItems^.Value^) = Uppercase(aValue)
  //Se não achar retorna -1
begin
  result := 0;
  While (AItems <> nil) do
  begin
    If (AItems^.Value <> nil)
    Then If sysUtils.UpperCase(Del_SpcED(AItems^.Value^)) = sysUtils.Uppercase(Del_SpcED(aValue))
         then Begin
                exit;
              End;
    AItems := AItems^.Next;
    result  := result + 1;
  end;
  //Se não achar retorna nil
  result := -1;
end;


function  GetItemByNum(AItems: PSItem;i:Integer) : PSItem;
  //Se se achar retorna PSItem onde: n  = i
  //Se não achar retorna nil

  var n : Integer;
begin
  n := -1;
  While (AItems <> nil) do
  begin
    inc(n);
    If (AItems^.Value <> nil)
    Then If n  = i
         then Begin
                Result := AItems;
                exit;
              End;
    AItems := AItems^.Next;
  end;
  //Se não achar retorna nil
  Result := nil;
end;

{$REGION '---> Inicio da Implementacao de TCollectionString'}

  Function TCollectionString.GetAnsiStrings(Index: Sw_Integer):AnsiString;
    //Objetivo: Ler a string sem os caracteres de controle.
    //          Precisei em 29/06/2009 quando implementei a classe: TCollectionString_TTb____Table

    Function FS(S:tString):tString;
      Var
       I : Integer;
    Begin
      Result := '';
      for I := 1 to Length(S)
      do  if Not (S[i] in AnsiChar_Control_Template + ['`'] )
      then Result := Result + S[i];
    end;

    Var
      I,PosFldNum : Byte;
      S : PtString;
      P : PSItem;

  Begin
    Result := '';
    If (Index >= 0) And (Index<Count)
    Then Begin
           S := At(Index);
           if S<>nil
           then Begin
                  PosFldNum := Pos('\'+fldENUM,S^);
                  if PosFldNum<>0
                  then Begin
                         Move(S^[PosFldNum+2],P,4);
                         If P<>nil
                         Then Begin // Concactena a lista de PSITEM
                                while P <> nil do
                                Begin
                                  if P^.Value<>nil
                                  then Begin
                                         if Result=''
                                         then Result := FS(P^.Value^)
                                         Else Result := Result + ' ; '+ FS(P^.Value^);
                                       End;
                                  P := P.Next;
                                End
                               End
                         else Result := Fs(S^);
                       End
                  Else Result := Fs(S^);
                End
           Else Result := '';
         End
    Else Result := '';
  end;

  constructor TCollectionString.Create(ALimit, ADelta: Sw_integer;AOrdem:Boolean);
  Begin
    Inherited Create(ALimit, ADelta);
    Ordem := AOrdem; {<Se True insere em ordem alfabetica}
    Duplicates := True; {<O padrao aceita duplicatas}
  End;

  constructor TCollectionString.CreateLista(AOrdem:Boolean;aLista:tString;const aFoundTesteCompleto:Boolean);
  {< Recebe uma lista de strings separados por ponto e virgula e cria
    a colecao com os subStrings da lista

    Exemplo:
      Create1(1,1,true,'1;123;456;4566')
      Iniciliza a colecao com os numeros
      1
      123
      456
      4566
  }
  Var
    S : tString;
    p : byte;
  Begin
    If  {Inherited ??? } Create(1,1,aOrdem)=nil Then
      Abort;

    FoundTesteCompleto := aFoundTesteCompleto;
    While Length(aLista) <> 0 do
    Begin
      p := Pos(';',aLista);
      if p <> 0 Then
      Begin
        S := System.Copy(aLista,1,p-1);
        NewStr(S);
        System.delete(aLista,1,p);
      End
      else
      Begin
        If Length(aLista) <> 0 Then
        Begin
          NewStr(aLista);
          aLista := ''; {<fim da lista}
        End;
      End;
    End;
  End;

  Function TCollectionString.NewStr(S : AnsiString):Boolean;
    Var
       WS : TString;

       Function Insert_Not_Duplicates:Boolean;
         var
           I: Integer;

       Begin
  //==========================================================================================================
  {$REGION ' ---> 2011/12/03 - Tarefa: Verificar porque a rotina de processamento está gerando exceção quando a contabilidade não está habilitada.'}
  //=============================================================================================3============

    { DONE 1 -oTCollectionString.NewStr -cBUG DO CÓDIGO :
 2011/12/07. Criado em: 2011/12/03. Versão: 9.27.13.1908
   <ul>
     • Verificar porque a rotina de processamento está gerando exceção quando a contabilidade não está habilitada.<BR>
       • Solução:
          • O problema foi criado quando troquei NewStr(S : TString) para NewStr(S : AnsiString), pois o aquivo ficava duplicado na lista de arquivos a serem renomeados.<BR>
          • Para resolver o problema é necessário criar a varivel Ws : TString para que a pesquisa funcione.<BR>
   </ul>
    }
  {$ENDREGION}
  //==========================================================================================================

          OkInsert  := not Search(KeyOf(@wS), I) or Duplicates;
          If OkInsert
          Then Begin
                 If Ordem
                 Then AtInsert(I,Objects.NewStr(wS))
                 Else AtInsert(Count,Objects.NewStr(wS));{<TCollection.Insert(Objects.NewStr(wS));}
               End;
          Insert_Not_Duplicates := OkInsert;
       end;
  Begin

    Assert(length(s) <=255);
    WS := S;
    If wS = ''
    Then wS := ' ';

    If Not Duplicates
    Then  NewStr := Insert_Not_Duplicates
    else  Begin
            If Ordem
            Then Insert(Objects.NewStr(wS))
            Else AtInsert(Count,Objects.NewStr(wS));{<TCollection.Insert(Objects.NewStr(S));}
            NewStr := true;
          End;
  End;

  Function TCollectionString.Append(S : AnsiString):Boolean;
  Begin
    Result := newStr(S);
  end;

  procedure TCollectionString.AddSItem(P : PSItem;OkDisposeSItems:Boolean);
    {<Insere uma lista de SItems na collection }
    Var
      Aux : PSItem;
  Begin
    Aux := P;
    while aux <> nil do
    Begin
      If Aux^.Value<> nil Then
        NewStr(Aux^.Value^);
      Aux := Aux^.next;
    End;

    If OkDisposeSItems
    Then DisposeSItems(P);
  End;

  procedure TCollectionString.AddSItem(P : PSItem);
  Begin
    AddSItem(P,true); {<Default deve destruir a lista passada}
  end;

  Function TCollectionString.PListSItem : {<Dialogs.}PSItem;
    var
     S:TString;
     n : Integer;
  begin
    Result := nil;

    if Count>0 then
    For n := Count-1 downto 0 do
       If TItemList(Items^)[n] <> nil
       Then  Begin
//                Result := NewSitem(tString(TItemList(Items^)[n]^),Result);
//                Result := NewSitem(CopyTemplateFrom(tString(TItemList(Items^)[n]^)),Result);
                S := tString(TItemList(Items^)[n]^);
                Result := NewSitem(CopyTemplateFrom(S),Result);
             End;

  //  PListSItem:= P;
  end;

  Function TCollectionString.Get_Html_List:AnsiString;//< Retorna Uma sequencia de <li> </li>
    { RETORNA: Um uma lista de string no formato html onde cada linha fica entre <li>l inha </li>
      Nota: O final da lista termina com "<br>&nbsp;" para que passe uma linha em branco no final da lista
    }
    Var
      i,J,n_brancos_iniciais : Integer;
      S : AnsiString;
      PosSpace : Integer;
  Begin
    Result := '';
    For i := 0 to Count -1 do
    begin
      S := tStrings[i];
      n_brancos_iniciais := 0;


      //Troca o  espaco pelo código html do espaco.
      while (LENGTH(S) > 0) AND (S[1] = ' ')  do
      begin
        system.delete(S,1,1);
        n_brancos_iniciais := n_brancos_iniciais+1;
      end;

      //Acresssenta o números de brancos deletados usando código html.
      For j := 1 to n_brancos_iniciais do
        S := '&nbsp;' + S;

      //Troca o  espaco pelo código html do espaco.
  {   Desativei por que desta forma o texto não aceita código HTML
       PosSpace := Pos(' ', S);
      while PosSpace <> 0  do
      begin
        system.delete(S,PosSpace,1);
        System.insert('&nbsp;',S,PosSpace);
        PosSpace := Pos(' ', S);
      end;}


  { //Desativei porque a fonte era arredada na lista
       If i < count-1
       Then Result := Result + '<li>'+'<font face="Lucida Console">'+S +'</font>'+ '</li>'
       Else Result := Result + '<li>'+'<font face="Lucida Console">'+S+ '<br>&nbsp;'+'</font>'+'</li>';
  }
  {    //Desativei porque o browser mostra marcas em textos do mesmo paragrafo.
       If i < count-1
       Then Result := Result + '<li>'+S + '</li>'
       Else Result := Result + '<li>'+S+ '<br>&nbsp;</li>';
  }

  //     Result := Result+'<TR><TD>'+ S +'</TD> </TR>' ;  //Não dar certo pq caso o usuário coloque o comando <PRE> e </Pre> o mesmo não funciona.

       If i < count-1
       Then Result := Result + S +'<BR> '
       Else Result := Result + S+ '<BR>&nbsp; ';

    end;

  //  Result := '<table>'+Result+'</table>' //Não dar certo pq caso o usuário coloque o compando <PRE> e </Pre> o mesmo não funciona.
  End;


  Function TCollectionString.Found(const akey:tString):Boolean;
  Var
    I   : SmallInt;
    key : tString;
  Begin
    For I := 0 to count -1 do
    Begin
      If FoundTesteCompleto Then
      Begin
        If  aKey = PtString(At(i))^ Then
        Begin
          Found := true;
          exit;
        End
      End
      else
      Begin
        Key := PtString(At(i))^;
        If Byte(Key[0])  <  byte(aKey[0]) Then
        Begin
          If  Key = copy(akey,1,Byte(Key[0])) Then
          Begin
            Found := true;
            exit;
          End;
        End
        Else
        Begin
          If  aKey = copy(key,1,Byte(aKey[0])) Then
          Begin
            Found := true;
            exit;
          End;
        End
      End;
    End;
    Found := False;
  End;

procedure TCollectionString.FreeItem(Item: Pointer);
//Caso o item seja uma lista de PSITEM o mesmo deve ser destruido.
   Var P1  : PSItem;
Begin
  If (Item<>nil) and (ptString(Item)^ <> '')
  Then Case ptString(Item)^[1] of
           //<Os Campos abaixo pode ser uma lista de PSItem
           fldENUM   : Begin
                         Move(ptString(Item)^[2],P1,4);
                         DisposeSItems(p1);
                       End;
           fldSItems : Begin
                         Move(ptString(Item)^[2],P1,4);
                         DisposeSItems(p1);
                       end;
         Else inherited FreeItem(Item);
       end;
end;

Function TCollectionString.GetMaiorString(Const aConjDespreze:AnsiCharSet;aIgnore_ShowWid:Boolean) : Byte;
  Var
    I,Len,aGetMaiorString   : SmallInt;
    S                         : PtString;
    P : PSItem;


    Procedure Calc_Len;
      Var
        J   : SmallInt;
    Begin
      Len  := 0;
      For j := 1 to length(S^) do
      Begin
        If Not (S^[j] in aConjDespreze)
        Then Inc(Len)
        Else Begin
               if Not aIgnore_ShowWid
               then Begin
                      If (S^[j] ='`') and (S^[j] in aConjDespreze)
                      Then Break; {<Despreza o resto da linha}
                   End
             End;
      End;
    end;

  Begin
    aGetMaiorString  := 0;
    For I := 0 to count -1 do
    Begin
      S := At(i);
      If S <> nil
      Then Begin
             Len := Pos('\'+fldENUM,S^);
             If Len  <> 0
             Then Begin
                    Move(S^[Len+2],P,4);
                    If P<>nil
                    Then Len := Len + MaxItemStrLen(P)
                    else Len := 0;
                  End
             Else Calc_Len;

              If Len > aGetMaiorString Then
                aGetMaiorString := Len;
           End;
    End;
    GetMaiorString := aGetMaiorString;
  End;

  Function TCollectionString.GetMaiorString(Const aConjDespreze:AnsiCharSet) : Byte;
  Begin
    Result := GetMaiorString(aConjDespreze,False);
  End;

  Function TCollectionString.GetMaiorAnsiString() : Integer;
   Var
     I,Len : Integer;

  Begin
    Result := 0;
    for I := 0 to Count - 1 do
    Begin
      Len := Length(Self.AnsiStrings[i]);
      if Result < Len
      then Result := Len;
    End;
  End;

  Function TCollectionString.Clone:TCollectionString;
    Var
      i : Integer;
      S : PtString;
  Begin
    Result := TCollectionString.Create(Limit,delta,ordem);
    Result.FoundTesteCompleto := FoundTesteCompleto;

    For I := 0 to count -1 do
    Begin
      S := At(i);
      If S <> nil
      Then Begin
             Result.NewStr(S^);
           End;
    End;
  end;

  FUNCTION TCollectionString.Search (Key: Pointer; Var Index: Sw_Integer): Boolean;
    Var
      WIndex: Sw_Integer;
  Begin
    If Ordem
    Then Result := Inherited Search (Key, Index)
    Else begin
           For WIndex := 0 to Count-1 do
           Begin
             If (TItemList(Items^)[wIndex] <> nil) And (Compare(Key,TItemList(Items^)[wIndex] ) = 0 )
             Then Begin
                    Index := wIndex;
                    Result := true;
                    exit;
                  End;
           End;
         end;
    Result := False;
  End;

  Procedure TCollectionString.FormatStr(LengthMaxCol: Integer);

      Function GetUltPalavra(Const Ws : AnsiString ) : AnsiString;
        Var
          I : Integer;
      Begin
        Result := '';
        For I := Length(Ws) downto  1 do
        Begin
          If Ws[i] <> ' '
          Then System.Insert(Ws[i],Result,1)
          Else Break;
        End
      end;


    Var
      i,J,aCount : Sw_Integer;

      SItem  : tString;
      S      : tString;
      P      : PtString;

      Crtl_C : Boolean;



      Procedure Insert_Strings;
        Var
          SUlt : AnsiString;
      Begin
         SItem := Copy(SItem,length(s)+1,Length(SItem));

         If Crtl_C
         Then Begin
                If (S[Length(S)] <> ' ' ) And
                   ((Length(SItem)>0) And
                    (SItem[1]<> ' '))
                Then Begin
                       SUlt := GetUltPalavra(S);
                       System.Insert(SUlt,SItem,1);

                       S := System.Copy(S,1,Length(S) - Length(SUlt) );
                     End;

                tStrings[i] := CentralizaStr(S,LengthMaxCol)
              end
         ELse tStrings[i] := S;

         If (Sitem<> '')
         Then Begin
                P := Objects.NewStr(SItem);
                AtInsert(I+1,P);
  {              Inc(i);}
              End;
         S := '';
         J := 1;
      end;


  Begin
    I := 0;


    While I <= Count-1 do
    Begin
      SItem  := tStrings[i];
      Crtl_C := False;
      If SItem <> ''
      Then Begin
             S := '';
             {
               esta faltando o código??????????????????? fazer depois
             }

             J := 1;
             While (j <= length(SItem)) AND (SItem[J] <> #0)  do
             Begin
               Case SItem[j] of
                 ^C  : Begin
                         S := S + ' ';
                         If (Length(S) >= LengthMaxCol) or (j >= length(SItem))
                         Then Begin
                                Insert_Strings;
                                Inc(i);
                                Continue;
                              End;

                         Crtl_C :=  {true} Not Crtl_C;

                       End;
                 ^M,#0
                     : Begin
                         S := S + ' ';
                         Insert_Strings;
                         Inc(i);
                         Continue
                       End;
                 Else  Begin
                         If Not Crtl_C
                         Then S := S + SItem[j]
                         Else Begin
                                If (Length(S) < LengthMaxCol) and (j <= length(SItem))
                                Then S := S + SItem[j];

                                If (Length(S) >= LengthMaxCol) or
                                    (j >= length(SItem)) OR
                                   (SItem[j]=#0)
                                Then Begin
                                       Insert_Strings;
                                       Inc(i);
                                       Continue;
                                     End;
                              End;
                       End;
               End;
               Inc(J);
             End;

           End;
      Inc(i);
    End;
  end;


{$ENDREGION}



//====================================================
{$REGION '---> TFile_StringGrid'}
//====================================================


  Constructor TFile_StringGrid.Create(aStringGrid : grids.TStringGrid);
  Begin
    Inherited Create(aStringGrid);
    StringGrid := aStringGrid;
    if aStringGrid <> nil
    then aStringGrid.InsertControl(Self);

  End;

  Function  TFile_StringGrid.CellsByFieldName(aFieldName: String;aRow:Longint):AnsiString;
    Var
      aCol : Integer;
  Begin
    for aCol  := 1 to Self.StringGrid.ColCount do
    Begin
      if Del_SpcED(sysUtils.UpperCase(Self.StringGrid.Cells[aCol,0])) = Del_SpcED(sysUtils.UpperCase(aFieldName))
      then begin
             Result := Del_SpcED(Self.StringGrid.Cells[aCol,aRow]);
             Exit;
           end;
    End;
    //Gera exceção porque nao encontrou o campo
    Abort;
  End;

  Function  TFile_StringGrid.CellsByFieldName(aFieldName: String):AnsiString;//;aRow := NrCurrent
  Begin
    Result := CellsByFieldName(aFieldName,NrCurrent);
  End;

  Function  TFile_StringGrid.FieldName(aCol:Longint):AnsiString; //Retorna o nome do campo da coluna
  Begin
    Result := Self.StringGrid.Cells[aCol,0];
  End;

  function TFile_StringGrid.FieldByName(aFieldName: String): AnsiString;
    Var
      aCol : Integer;
  Begin

    for aCol  := 1 to  Self.StringGrid.ColCount do
    Begin
      if Del_SpcED(sysUtils.UpperCase(Self.StringGrid.Cells[aCol,0])) = Del_SpcED(sysUtils.UpperCase(aFieldName))
      then begin
             Result := Del_SpcED(Self.StringGrid.Cells[aCol,NrCurrent]);
             Exit;
           end;
    End;
    //Gera exceção porque nao encontrou o campo
    Abort;
  End;

  Procedure TFile_StringGrid.SetFieldByName(aFieldName,aValue: String);
    Var
      aCol : Integer;
  Begin
    for aCol  := 1 to  Self.StringGrid.ColCount do
    Begin
      if Del_SpcED(sysUtils.UpperCase(Self.StringGrid.Cells[aCol,0])) = Del_SpcED(sysUtils.UpperCase(aFieldName))
      then begin
             Self.StringGrid.Cells[aCol,NrCurrent] := aValue;
             Exit;
           end;
    End;
    //Gera exceção porque nao encontrou o campo
    Abort;
  End;


  function TFile_StringGrid.FieldByNumber(aCol: Integer): AnsiString;
  begin
    Result := Del_SpcED(Self.StringGrid.Cells[aCol,NrCurrent]);
  end;

  Procedure TFile_StringGrid.SetFieldByNumber(aCol:Longint;aValue: String);
  begin
    Self.StringGrid.Cells[aCol,NrCurrent] := aValue;
  end;

  function TFile_StringGrid.Bof: Boolean;
  begin
    Result := Self.NrCurrent = 2;
  end;

  function TFile_StringGrid.Eof: Boolean;
  begin
    Result := Self.NrCurrent = Self.StringGrid.RowCount;
  end;


  function TFile_StringGrid.GoBof: Boolean;
  begin
    Result := true;
    _NrCurrent := 2;
  end;

  function TFile_StringGrid.GoEof: Boolean;
  begin
    Result := true;
    _NrCurrent := Self.StringGrid.RowCount;
  end;

  function TFile_StringGrid.NextRec: boolean;
  begin
    if  _NrCurrent < Self.StringGrid.RowCount
    then Begin
            inc(_NrCurrent);
            Result := True;
         End
    Else Result := False;
  end;

  function TFile_StringGrid.PrevRec: boolean;
  begin
    if  _NrCurrent > 2
    then Begin
            Dec(_NrCurrent);
            Result := True;
         End
    Else Result := False;
  end;

  function TFile_StringGrid.Valid : boolean;
  Begin
    Result := (_NrCurrent >= 2) and (_NrCurrent <= Self.StringGrid.RowCount);

    if (@OnValid<>nil)
    then result := result and OnValid(Self);

  End;

{$ENDREGION}
//====================================================

//===================================================================
{$REGION '---> Implementação de TViRect'}
//===================================================================

    Procedure TViRect.Create_Point_A(X,Y:Int64);
    Begin
      R_New.A.X := X;
      R_New.A.Y := Y;
      If Not Overflow
      Then Overflow := (R_New.A.X<0) or
                       (R_New.A.Y<0) or
                       (R_New.A.X> A.X) or
                       (R_New.A.Y> A.Y);
    end;

    Procedure TViRect.Create_Point_B(X,Y:Int64);
    Begin
      R_New.B.X := X;
      R_New.B.Y := Y;
      If Not Overflow
      Then Overflow := (R_New.B.X<0) or
                       (R_New.B.Y<0) or
                       (R_New.B.X> B.X) or
                       (R_New.B.Y> B.Y);
    end;

    Procedure TViRect.Calc_point_A_North;{<Norte}
    Begin
      Create_Point_A(R_Neighbor.A.X,R_Neighbor.A.Y{<-1});
    end;

    Procedure TViRect.Calc_point_A_South;{<Sul}
    Begin
      Create_Point_A(R_Neighbor.A.X,R_Neighbor.B.Y{<+1});
    end;

    Procedure TViRect.Calc_point_A_West; {<Oeste}
    Begin
      Create_Point_A(R_Neighbor.A.X{<-1},R_Neighbor.A.Y);
    end;

    Procedure TViRect.Calc_point_A_East;{<Leste}
    Begin
      Create_Point_A(R_Neighbor.B.X{<+1},R_Neighbor.A.Y);
    end;

    Procedure TViRect.It_is_not_adjusted_valid(MinX,MinY:Int64; Var aRect: TRect);
     {Ajusta aRect se o retangulo nao obdecer os tamanhos passados por MinX,MinY }


    Begin
      With aRect do
        If (B.Y - A.Y) < MinY Then B.Y := A.Y+MinY;

      With aRect do
        If (B.X - A.X) < MinX Then B.X := A.X+MinX;
    end;

    Function TViRect.GetRect_Relative(
                   aR_Neighbor : TRect;  {<Vizinho}

                   aPerc_point_A : Byte;
                   adirection_point_A:Tdirection;

                   aPerc_point_B : Byte;
                   adirection_point_B: Tdirection;

                   Var aR_New : TRect {<Retorna o Ponto calculado}
                 ):Boolean;
        {Q-}
    Begin
       Try
//         Try except
           R_Neighbor := aR_Neighbor;//Vizinho do novo ponto a ser calculado
           R_New      := aR_New;    //Inicializa R_new com endereco no buffer a ser retornado

      {     If R_New = nil Then RunError(ParametroInvalido);
           If R_Neighbor = nil Then RunError(ParametroInvalido);}

           Case aDirection_point_A of
             North : Begin //Acima no retangulo vizinho.
                       Calc_point_A_North;
                       Case aDirection_point_B of //Só permitido a direita ou esquerda do retangulo vizinho.
                         North ,
                         South : Begin
                                   abort;
{                                   Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                          'ViDialog.Pas',
                                          'TViRect',
                                          'GetRect_Absolute()',
                                           '',
                                           '',
                                          ParametroInvalido);}
                                 End;
                         East  : Create_point_B(Integer(R_New.A.X + Round(Extended((B.X        - R_New.A.X)*(aPerc_point_B/100)))),
                                                Integer(R_New.A.Y - Round(Extended((R_New.A.Y - A.Y)       *(aPerc_point_A/100)))));

                         West  : Create_point_B(R_New.A.X - Round(Extended((R_New.A.X - A.X )      *(aPerc_point_B/100))),
                                              R_New.A.Y - Round(Extended((R_New.A.Y - A.Y)       *(aPerc_point_A/100))));
                       end;
                     end;
             South : Begin //A baixo do retangulo vizinho.
                       Calc_point_A_South;
                       Case aDirection_point_B of //Só permitido a direita ou esquerda do retangulo vizinho.
                         North ,
                         South : Begin
                                   abort;
{                                   Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                          'ViDialog.Pas',
                                          'TViRect',
                                          'GetRect_Absolute()',
                                           '',
                                           '',
                                          ParametroInvalido);}
                                 End;
                         East  : Begin
                                   Create_point_B(Integer(R_New.A.X      + Round((B.X - R_New.A.X     ) * (aPerc_point_B/100))),
                                                  Integer(R_Neighbor.B.Y + Round((B.Y - R_Neighbor.B.Y) * (aPerc_point_A/100))));
                                 End;

                         West  : Create_point_B(Integer(R_New.A.X    - Round((R_Neighbor.A.X - A.X ) * (aPerc_point_B/100))),
                                                Integer(R_Neighbor.B.Y + Round((B.Y - R_Neighbor.B.Y ) * (aPerc_point_A/100))));
                       end;

                     end;
             East  : Begin //A direita do retangulo vizinho.
                       Calc_point_A_East;
                       Case aDirection_point_B of //Só permitido acima ou abaixo do retangulo vizinho.
                         North : Create_point_B(R_New.A.X + Round((B.X - R_New.A.X)*(aPerc_point_A/100)),
                                              R_New.A.Y - Round((R_New.A.Y - A.Y)*(aPerc_point_B/100)));

                         South : Create_point_B(R_New.A.X + Round((B.X - R_New.A.X)*(aPerc_point_A/100)),
                                              R_New.A.Y + Round((B.Y - R_New.A.Y)*(aPerc_point_B/100)));
                         East,
                         West : Begin
                                  abort;
{                                  Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                  'ViDialog.Pas',
                                  'TViRect',
                                  'GetRect_Absolute()',
                                   '',
                                   '',
                                  ParametroInvalido);}
                                End;
                       end;
                     end;

             West  : Begin // A esquerda do retângulo vizinho
                         Begin
                           abort;
{                           Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                  'ViDialog.Pas',
                                  'TViRect',
                                  'GetRect_Absolute()',
                                   '',
                                   '',
                                  ParametroInvalido);}
                         End;
  //                     Calc_point_A_West;
  //                     Case aDirection_point_B of
  //                       North : Create_point_B(R_New.A.X - Round((R_New.A.X - A.X)*(aPerc_point_A/100)),
  //                                            R_New.A.Y - Round((R_New.A.Y - A.Y)*(aPerc_point_B/100)));
  //
  //                       South : Create_point_B(R_New.A.X - Round((R_New.A.X - A.X       )*(aPerc_point_A/100)),
  //                                            R_New.A.Y + Round((B.Y        - R_New.A.Y)*(aPerc_point_B/100)));
  //                       East,
  //                       West : Begin
  //                                 App.Application.Push_MsgErro('Error em:   Function TViRect.GetRect_Relative();');
  //                                 RunError(ParametroInvalido);
  //                              End;
  //                     end;
                     end;
           end;

{         Except

            Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                    'ViDialog.Pas',
                                    'TViRect',
                                    'TViRect.GetRect_Relative',
                                    '',
                                    '',
                                    Erro_Excecao_inesperada);
         end;}

       Finally
         It_is_not_adjusted_valid(3,2,R_New);
         GetRect_Relative := Overflow;
         aR_New      := R_New;
       End;

    end;

     Function TViRect.GetRect_Absolute(
                    aR_Neighbor : TRect;  {<Vizinho}
                    adirection_point_A:Tdirection;

                    aPoint_B : TPoint;
                    adirection_point_B: Tdirection;

                    Var aR_New : TRect {<Retorna o Ponto calculado}
                  ):Boolean;
      {Q-}
    Begin
       R_Neighbor := aR_Neighbor;//Vizinho do novo ponto a ser calculado
       R_New      := aR_New;    //Inicializa R_new com endereco no buffer a ser retornado
       Case aDirection_point_A of
         North : Begin //Acima no retangulo vizinho.
                   Calc_point_A_North;
                   Case aDirection_point_B of  //Só permitido a direita ou esquerda do retangulo vizinho.
                     North ,
                     South : Begin
                               abort;
{                                Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'ViDialog.Pas',
                                'TViRect',
                                'GetRect_Absolute()',
                                 '',
                                 '',
                                 ParametroInvalido);}
                             End;
                     East  : Create_point_B(R_New.A.X + aPoint_B.X,R_New.A.Y - aPoint_B.Y);
                     West  : Create_point_B(R_New.A.X - aPoint_B.X,R_New.A.Y - aPoint_B.Y);
                   end;
                 end;
         South : Begin //A baixo do retangulo vizinho.
                   Calc_point_A_South;
                   Case aDirection_point_B of //Só permitido a direita ou esquerda do retangulo vizinho.
                     North ,
                     South : Begin
                               abort;
{                                Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'ViDialog.Pas',
                                'TViRect',
                                'GetRect_Absolute()',
                                 '',
                                 '',
                                 ParametroInvalido);}
                             End;
                     East  : Create_point_B(R_New.A.X      + aPoint_B.X,R_Neighbor.B.Y + aPoint_B.Y);
                     West  : Create_point_B(R_New.A.X      - aPoint_B.X,R_Neighbor.B.Y + aPoint_B.Y);
                   end;
                 end;

         East  : Begin //A direita do retangulo vizinho.
                   Calc_point_A_East;
                   Case aDirection_point_B of  //Só permitido acima ou abaixo do retangulo vizinho.
                     North : Create_point_B(R_New.A.X + aPoint_B.X,R_New.A.Y - aPoint_B.Y);
                     South : Create_point_B(R_New.A.X + aPoint_B.X,R_New.A.Y + aPoint_B.Y);
                     East,
                     West : Begin
                              abort;
{                                Raise TException.Create(Name_Type_App_MarIcaraiV1,
                                'ViDialog.Pas',
                                'TViRect',
                                'GetRect_Absolute()',
                                 '',
                                 '',
                                ParametroInvalido);}
                            End;
                   end;
                 end;

         West  : Begin // A esquerda do retângulo vizinho
                   Begin
                     abort;
{                      Raise TException.Create(Name_Type_App_MarIcaraiV1,
                      'ViDialog.Pas',
                      'TViRect',
                      'GetRect_Absolute()',
                       '',
                       '',
                      ParametroInvalido);}
                   End;

  //                 Calc_point_A_West;
  //                 Case aDirection_point_B of
  //                   North : Create_point_B(R_New.A.X - aPoint_B.X,R_New.A.Y - aPoint_B.Y);
  //                   South : Create_point_B(R_New.A.X - aPoint_B.X,R_New.A.Y + aPoint_B.Y);
  //                   East,
  //                   West : Begin
  //                            App.Application.Push_MsgErro('Error em: Function TViRect.GetRect_Absolute();');
  //                            RunError(ParametroInvalido);
  //                          End;
  //                 end;

                 end;
       end;
       GetRect_Absolute := Overflow;
       aR_New      := R_New;
    End;

    Procedure TViRect.Set_Max_Ax_e_Max_BY(Max_X,Max_Y:Int64);
    Begin
      If (B.X - A.X) > Max_X Then B.X := A.X + Max_X;
      If (B.Y - A.Y) > Max_Y Then B.Y := A.Y + Max_Y;
    End;

    procedure TViRect.MoveTo(X, Y: Integer);
    begin
      Assign(X, Y, X + (B.X-A.X), Y + (B.Y-A.Y));
    end;

    Procedure TViRect.MoveTo_Direction(adirection : Tdirection;
                                       aOwner     : TRect {<Retorna o Ponto calculado }
                             );

        //***
        //   Ajusta o retangulo filho dentro do retangulo aOwner levando em
        //   consideracao as coordenadas geograficas.
        //***

      {*****************************************

           Exemplos do uso deste metodo:

      *****************************************}

      // *** Centraliza no centro de Y ***
      //        RViDlg.MoveTo_Direction(CenterY,aOwner);

      // *** Centraliza no centro de X ***
      //        RViDlg.MoveTo_Direction(CenterX,aOwner);

      // *** Centraliza no centro de X e no Centro de Y ***
      //        RViDlg.MoveTo_Direction(CenterXY,aOwner);

      // *** Move para o canto Superior esquerdo ***
      //         RViDlg.MoveTo_Direction(North,aOwner);
      //         RViDlg.MoveTo_Direction(West,aOwner);

      // *** Move para o canto Inferior esquerdo ***
      //         RViDlg.MoveTo_Direction(South,aOwner);
      //         RViDlg.MoveTo_Direction(West,aOwner);

      // *** Move para o canto Superior direito ***
      //         RViDlg.MoveTo_Direction(East,aOwner);
      //         RViDlg.MoveTo_Direction(North,aOwner);

      // *** Move para o canto Inferior Direito ***
      //         RViDlg.MoveTo_Direction(East,aOwner);
      //         RViDlg.MoveTo_Direction(South,aOwner);


    Begin
      Case aDirection of
        CenterX : MoveTo(((aOwner.B.X - aOwner.A.X)-(B.X-A.X) ) DIV 2,A.Y);
        CenterY : MoveTo(A.X,((aOwner.B.Y - aOwner.A.Y)-(B.Y - A.Y)) DIV 2);
        CenterXY: Begin
                    MoveTo_Direction(CenterX,aOwner);
                    MoveTo_Direction(CenterY,aOwner);
                  end;
        North   : MoveTo(A.X,0);
        South   : MoveTo(A.X,(aOwner.B.Y -(B.Y-A.Y)));
        East    : MoveTo(aOwner.B.X -(B.X-A.X),A.Y);
        West    : MoveTo(0,A.Y);
      end;
    End;

    function TViRect.Rect: TRect;
    begin
      GetRect(Result);
    end;

    Procedure TViRect.GetRect(Var aR_New : TRect); {<Retorna o Ponto calculado }
      Begin
        aR_New.Assign(A.X,A.Y,B.X,B.Y);
      end;



{$ENDREGION}
//===================================================================



Procedure Create;
Begin
  Show_HTML := FShow_HTML;
  redirecionaImpressora := False;
  OpcaoRedireciona      := 'I';
  AssignFile(LST,PRN);

{$REGION '--->Tb_Metodo'}

    Tb_Metodo  := TNsStringList.Create;
    Tb_Metodo.Sorted := true;
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_NewRecord)^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_AddRec   )^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_UpDateRec)^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_DeleteRec)^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_Next     )^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_Prev     )^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_Find     )^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_Search   )^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_Bof      )^);
    Tb_Metodo.Add(Objects.NewStr(Tb_Metodo_Eof      )^);

{$ENDREGION}
  List_Class_Of_Char     := Get_List_Class_Of_Char;
  List_Class_Of_Char_GUI := Get_List_Class_Of_Char_GUI;
  MemIniFile := TMemIniFile.Create('MarIcaraiV1.ini');

  if Not IsConsole
  then Tipo_de_Codigo_Fonte := TCF_Grafico;

End;



Procedure Destroy;
Begin
  EndOpenFiles := Nil; {<Nao deve abrir novamente os arquivos que permanecem
                        aberto todo o tempo.
                        A Chamdada de EndClearAll fecha os arquivos
                        e se  EndOpenFiles <> Nil ele abre novamente.
                       }
  If @EndProcMyExit <> Nil Then
  Begin
    EndProcMyExit; {<Obs. Deve desalocar a memoria usada na aplicacao bem como restorar a tela inicial}
    EndProcMyExit := nil;
  End;

  If @EndClearAll <> Nil Then
  Begin
    EndClearAll;
    EndClearAll := Nil;
  End;

  CloseLst;

  freeandNil(List_Class_Of_Char);
  FREEANDNIL(List_Class_Of_Char_GUI);
  FreeAndNil(Tb_Metodo);
  FreeAndNil(MemIniFile);
end;




Initialization


  Create;



Finalization
  Destroy;


end.
