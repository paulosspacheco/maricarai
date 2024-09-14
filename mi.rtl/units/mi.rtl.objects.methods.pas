unit mi.rtl.Objects.Methods;
{:< - A Unit **@name** implementa a classe **TObjectsMethods** do pacote **mi.rtl**.

  - **DESCRIÇÃO**:
    - Está unit é base para a class TObjetss

  - **NOTAS**
    - Esta unit foi testada nas plataformas: win32, win64 e linux.

  - **VERSÃO**
    - Alpha - 1.0.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
    - **19/11/2021**
      - 21:25 a 23:15 Criar a unit mi.rtl.objects.TObjectsMethods.pas

    - **20/11/2021**
      - 18:00 a 19:15 Criar a unit mi.rtl.objects.tStream.pas
    - **27/07/2023**
      - 09:00 a 12:00 Criar método StringReplaceTgLink

    - **10/08/2023**
       - 08:10 a 12:00: Implementar componente TPageProducer
       - 14:47 a 14:54: O método GetAlias deve retornar o nome da classe
                        caso o atributo _Alias se igual a vazio.


  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.Methods.pas">mi.rtl.objects.Methods.pas</a>)

}
{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes
  ,SysUtils
  ,StrUtils
  ,Variants
  ,System.UITypes
  ,TypInfo
  ,fpHTTP, HttpProtocol
  ,fpjson

  ,jsonparser
  ,fpjsondataset
  ,PropEdits
  ,Process
  ,dos
  ,db
  ,sqlDB
  ,SQLite3Conn
  ,PQConnection
  ,FpHttpClient
  ,HTTPDefs
  ,mi.rtl.Class_Of_Char
  ,mi.rtl.types
  ,mi.rtl.Consts
  ,mi.rtl.objects.consts
  ,mi.rtl.objects.consts.MI_MsgBox
  ,mi.rtl.objects.consts.progressdlg_if
  ,mi.rtl.objects.Consts.logs
  ,mi.rtl.MiStringList
  ,mi.rtl.Consts.Transaction

  ;

  type
    THTMLTagEvent = mi.rtl.types.TTypes.THTMLTagEvent;

//    TObjectsMethods = class;
  {: - A classe **@name** implementa os método de classe comum a todas as classes de TObjects do pacote **mi.rtl**.}
  TObjectsMethods =
  class(TObjectsConsts)
    public constructor Create(aOwner:TComponent);override;
    public Destructor destroy;Override;

    {: A classe método **@name** redireciona a saida de vídeo para
       arquivo passado como parâmetro.
    }
    public class Function redirectOutput(Var OutputFile: text;aFileName:TFileName):integer;

    {$REGION '--->Construção da propriedade Alias'}
      Private  _Alias    : AnsiString;
      Protected Function GetAlias:AnsiString;Virtual;
      Protected Procedure SetAlias(Const aAlias:AnsiString);Virtual;
      Published  Property Alias : AnsiString Read GetAlias Write SetAlias;
    {$ENDREGION}
    public type TMI_MsgBox = mi.rtl.objects.consts.MI_MsgBox.TMI_MsgBox;
    private const _MI_MsgBox: TMI_MsgBox = nil;

    {: O método **@name** deve ser implementado que  se possoa criar formulários
       MI_MsgBox diferente do padrão setado por Tapplication.}
    public Function create_MI_MsgBox:TMI_MsgBox;virtual;abstract;
    public class function MI_MsgBox: TMI_MsgBox;


//    public Class Procedure Set_MI_MsgBox(aMI_MsgBox: TMI_MsgBox);virtual;abstract;

    public type TMi_Transaction = mi.rtl.consts.Transaction.TMi_Transaction;
    {: A constante **@name** deve ser iniciada ao criar conexão com o banco de dados.}
    public Mi_Transaction : TMi_Transaction;

    //{: A constante **@name** deve ser iniciada ao criar conexão com o banco de dados.}
    //Public const Mi_Transaction : TMi_Transaction = nil;

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
                    then Roolback;

                    Raise TException.Create(Self,'AddRec',E.Message);
                  end;
              end;

           ```

    }
    protected function StartTransaction:Boolean;virtual; Overload;

    {: O método **@name** confirme a transação no banco de dados}
    protected function COMMIT:Boolean;virtual;Overload;

    {: O método **@name** anula a transação do banco de dados}
    protected procedure Rollback;virtual;

    public type TProgressDlg_If = mi.rtl.objects.consts.progressdlg_if.TProgressDlg_If;
    public type TProgressDlg_If_Class = mi.rtl.objects.consts.progressdlg_if.TProgressDlg_If_Class;

    public type TFilesLogs     = mi.rtl.objects.Consts.logs.TFilesLogs;
    public const _Logs : TFilesLogs = nil; //:< - Logs é inicializado em Initialization e destruído em finalization
    class function Logs: TFilesLogs;
    //{: A constante **@name** é usada para salvar uma instancia da classe mi.ui.dialogs
    //}
    //protected const _Dialogs : TDialogs = nil;

    //{: - A função **@name**  seta o dialogo usado para comunicação com o usuário
    //
    //   - **RETORNA**
    //     - O Dialogo atualmente em uso.
    //}
    //public class Function SetDialogs(aDialogs : TDialogs): TDialogs ;
    //
    //{: - O método de classe virtual **@name** retorna um ponteiro para uma instacia da classe TDialogs.
    //}
    //public class function Dlgs: TDialogs;virtual;

    {: - O método de classe @name executa o diálogo MessageBox do Lazarus;

      - **REFERÊNCIA**
        - https://wiki.lazarus.freepascal.org/Dialog_Examples#MessageBox
    }
    public class procedure SysMessageBox(Msg, Title: AnsiString; Error: Boolean);

    {: A classe **@name** deve ser implementada no pacote mi.ui.}
    Public class function MessageBox(const Msg: AnsiString): TMI_MsgBoxTypes.TModalResult;Virtual;overload;

    public class function MessageBox(const aMsg: AnsiString;
                                     DlgType: TMI_MsgBoxTypes.TMsgDlgType;
                                     Buttons: TMI_MsgBoxTypes.TMsgDlgButtons): TMI_MsgBoxTypes.TModalResult;Virtual;overload;

    {: O método **@name** recebe 3 parâmetros. Criar um dialogo e retrona as opções escolhidas.

       - **Exemplo de uso**

         ```pascal

           If MessageBox('O arquivo '+TMI_DataFile(DatF).nomeArq+' não existe.'+^M+
                         ^M+
                         'Cria o arquivo agora?'
                         ,MtConfirmation,mbYesNoCancel,mbYes)= MrYes
           Then begin
                end;
         ```
    }
    public class function MessageBox(const aMsg: AnsiString;
                                     DlgType: TMI_MsgBoxTypes.TMsgDlgType;
                                     Buttons: TMI_MsgBoxTypes.TMsgDlgButtons;
                                     ButtonDefault: TMI_MsgBoxTypes.TMsgDlgBtn): TMI_MsgBoxTypes.TModalResult;Virtual;overload;


    {: - A classe método **@name** encerra o programa com um erro de tempo de execução 211.
      - **NOTA**
        - Ao implementar um tipo de classe abstrato, chame Abstract nesses métodos Override que
          deve ser substituído em tipos descendentes. Isso garante que qualquer tentativa de usar
          instâncias do tipo abstrato de classe falhará.
    }
    public class procedure Abstracts;


    public Class procedure RegisterError;

    {: - A classe método **@name** registra o tipo de classe fornecido com os fluxos do Free Vision,
        criando uma lista de objetos conhecidos. Streams só podem armazenar e retornar esses  Tipos de classe.
      - Cada classe registrada precisa de um registro de stream único registro, do tipo TStreamRec.
    }
    public class procedure RegisterType (Var S: TStreamRec);

    {: - A class function @name retorna o valor inteiro longo de valores inteiros X * Y.
    }
    public class function LongMul (X, Y: Integer): LongInt;

    {: A classe function **@name** retorna o valor inteiro do inteiro longo X dividido pelo inteiro Y.
    }
    public class function LongDiv (X: LongInt; Y: Integer): Integer;

    //{: -
    //}
    //public class function NewStr (Const S: AnsiString): ptstring;

    {: -
    }
    public class procedure NNewStr(Var PS : ptstring;Const S : AnsiString);

    public class function CallPointerLocal(Func: codepointer; Frame: Pointer; Param1: pointer): pointer;inline;

    public class PROCEDURE DisposeStr ( Var P: ptstring);

    public class  Function Name_Type_App_MarIcaraiV1 :AnsiString;

    public class Function Set_IsApp_LCL(aIsApp_LCL:Boolean):Boolean;

    public class Procedure PopSItem(Var Items: PSItem);

    public class PROCEDURE DISCARD(Var AClass); overload;

    public class PROCEDURE DISCARD(Var AClass:TObject);overload;

    public class Function SetFlushBuffer_Disk(Const aFlushBuffer_Disk : Boolean): Boolean;

    public class Function SetFlushBuffer(Const aFlushBuffer : Boolean): Boolean;

    {: - returns ticks at 18.2 Hz, just like DOS }
    public class Function GetDosTicks:DWord; { returns ticks at 18.2 Hz, just like DOS }

    {: A função **@name** converte segundos para milisegundos.

       - **NOTA**
         - 1 Milliseconds = 1/1000 segundos -> 1 segundo = 1000 Milliseconds
    }
    public class Function Seg_to_MillSeg(aSegundos:Longint):DWord;

    public class Procedure RunError(Error:Word);
    Public class Procedure Run_Error(Error:Word;Procedimento_que_Executou:AnsiString);
    {: - A procedure **@name** executa um dialogo com botão **OK**
    }
    Public Class Procedure Alert(aTitle: AnsiString;aMsg:AnsiString);
    Public Class procedure ShowMessage(const aMsg: string);

    {: - A função **@name** executa um dialogo com os botões **OK** e **Cancel** fazendo uma pergunta.

       - **RETORNA:**
         - **True** : Se o botão **OK** foi pŕessionando;
         - **False** : Se o botão **Cancel** foi pŕessionando.
    }
    Public Class Function Confirm(aTitle: AnsiString;aPergunta:AnsiString):Boolean;

    public class function  MaxItemStrLen(AItems: PSItem) : integer; Overload;

    public class function  MaxItemStrLen(PSItems: tString) : integer;Overload;

    public class function conststr ( i : Longint;  Const a : AnsiChar) : AnsiString;

    public class function centralizesStr(Const campo : AnsiString; Const tamanho : Integer) : AnsiString;

    public class function MaskEdit_to_Mask(const aMaskEdit: AnsiString ): TMask;virtual;
    public class function isDateTime(Const aTemplate : AnsiString):Boolean;
    public class Function TypeFld(Const aTemplate : tString;Var aSize : SmallWord):AnsiChar;overload;
    public class Function TypeFld(Const aTemplate : tString):AnsiChar;overload;

    public class Function IStr   ( Const I : Longint; Const Formato : tString) : tString;Overload;
    public class Function IStr   ( Const I : Longint) : tString;Overload;
    public class Function IStr   ( Const I : tString; Const Formato : tString) : tString;Overload;


    public class function StrNum(formato : AnsiString;{Var} buffer :Variant; Const Tipo : AnsiChar;Const OkSpc:Boolean) : AnsiString;overload;
    public class function StrNum(formato : AnsiString;{Var} buffer:Variant; Const Tipo : AnsiChar) : AnsiString;overload;


    public class function IIF(Const Logica : Boolean; Const E1 , E2 : Boolean) : Boolean;overload;
    public class function IIF(Const Logica : Boolean; Const E1 , E2 : AnsiChar) : AnsiChar;overload;
    public class function IIF(Const Logica : Boolean; Const E1 , E2 : Longint ) : Longint;overload;
    public class function IIF(Const Logica : Boolean; Const E1 , E2 : Extended ) : Extended;overload;
    public class function IIF(Const Logica : Boolean; Const E1 , E2 : AnsiString ) : AnsiString ;overload;

    {:A class método **@name** avalia uma condição lógica e retorna um dos dois
      valores com base no resultado da condição.

      - Parâmetros
        - `Logica`
          - Uma expressão booleana que determina qual valor será retornado.
        - `E1`
          - O valor a ser retornado se @code(Logica) for @code(True).
        - `E2`
          - O valor a ser retornado se @code(Logica) for @code(False).
      - returns
        - Retorna o valor de @code(E1) se @code(Logica) for @code(True);
          caso contrário, retorna o valor de @code(E2).

      - @note
        - Esta função é genérica e pode ser usada com diferentes tipos de dados,
          desde que @code(E1) e @code(E2) sejam do mesmo tipo.

      - Example

        ```pascal
          var
            intResult: Longint;
            strResult: AnsiString;
            boolResult: Boolean;
            charResult: AnsiChar;
            enumResult: TDayOfWeek;  // Supondo que você tenha uma enumeração chamada TDayOfWeek
          begin
            intResult := TObjectsMethods.IIF<Longint>(True, 10, 20);  // Retorna 10
            strResult := TObjectsMethods.IIF<AnsiString>(False, 'Hello', 'World');  // Retorna 'World'
            boolResult := TObjectsMethods.IIF<Boolean>(True, True, False);  // Retorna True
            charResult := TObjectsMethods.IIF<AnsiChar>(False, 'A', 'B');  // Retorna 'B'
            enumResult := TObjectsMethods.IIF<TDayOfWeek>(True, Sunday, Monday);  // Retorna Sunday
          end;
        ```

    }
    public class function IIF<T>(const Logica: Boolean; const E1, E2: T): T; static;

    public class Function SIF(Const Logica : Boolean; Const E1 , E2 : AnsiString ) : AnsiString ;

    public class function MinL(Const a,b:Longint):Longint;
    public  class function MaxL(Const a,b:Longint):Longint;

    public class function NumToStr(Const formato : AnsiString;const buffer:Variant; Const Tipo : AnsiChar;Const OkSpc:Boolean):AnsiString;

    public class Function InsertCrtlJ(Const StrMsg:tString):tString;

    Private  const _Progress1Passo : TProgressDlg_If = nil;

    Public class procedure Create_Progress1Passo(ATitle : tstring;Obs:tstring ; ATotal : Longint);Virtual;

    Public class procedure Set_Progress1Passo(aNumber : Longint);Virtual;

    Public class procedure Destroy_Progress1Passo;Virtual;

    public class procedure LogError(const Fmt: String; Args: array of const);overload;
    public class procedure LogError (const Msg:AnsiString );overload;
//    public class Procedure Push_MsgErro(Const Str: AnsiString);override;

    public class function WideStringToString(const ws: WideString): AnsiString;

    public class Function Set_FileModeDenyALLSalvaAnt(Const ModoDoArquivo : Boolean;Var _FileModeDenyALLAnt:Boolean):Boolean;

    public Class Function Set_FileModeDenyALL(Const ModoDoArquivo : Boolean):Boolean;

    {$REGION '---> Sitems_MsgErro'}

      public class Function Sitems_MsgErro()   : PSItem;


      {: Retire o ultimo string na pilha}
      public class Function Pop_MsgErro:PSItem; //Retira um string da pilha.

      public class function SpcStrD (Const  campo : tString; Const Tam : Byte): tString;
      public class function CentralizaStr(Const campo : AnsiString; Const tamanho : Integer) : AnsiString;
      public class function spc(Const campo:AnsiString;Const tam :Longint):AnsiString;

      {: O método **@name** retorna o número de caracteres de controle da string s}
      public class function NumberCharControl(s:AnsiString):Integer;

      public class Function StrAlinhado(aStrMsg:tString;Colunas : byte;Const Alinhamento:TAlinhamento):tString;
      public class Function StringToSItem( StrMsg:AnsiString; Alinhamento:TAlinhamento):PSItem;virtual;overload;
      public class Function StringToSItem( StrMsg:AnsiString ):PSItem;virtual;overload;

      public class function SItemsLen(S: PSItem) : SmallInt;
      public class Function SItemToString(Items: PSItem):AnsiString;

      {: A classe procedure **@name** retorna um TStringList com a lista passado por items

       - **NOTA**
         - S : Deve ser passado não inicializado, ouseja deve ser NIL.
      }
      Public class procedure WriteSItems(var S: TMiStringList;const Items: PSItem);
      Public class Function PSItem_ListaDeMsgErro:PSItem;virtual;

      {: O método **@name** imprime a sequência de mesagems de erro da pilha de
         mensagens.
      }
      Public class Procedure MessageError;virtual;

      {: O Método @name retorna uma lista de erros da pilha de erros;

      }
      Public class Function String_ListaDeMsgErro(Separador:String):AnsiString;Overload;

      {: A procedure **@name** esvazia a pilha de mensagens de error caso as mensagen não tenhão sido tratadas antes de encerrar TMI_Application.
      }
      public class Procedure Dispose_ListaDeMsgErro;virtual;

    {$ENDREGION}

    public class Function UpperCase(str:AnsiString):AnsiString;

    public class function Lowcase(str:AnsiString):AnsiString;//inline;

    {: A função **@name** remove os acentos do texto pText

       - **REFERÊNCIA**
         - Exemplo completo: https://showdelphi.com.br/dica-funcao-para-remover-acentos-de-uma-string-Delphi/
    }
  public
    class function AnsiString_to_USASCII(const pText: string): string;

    {: A class function **@name** converte caracteres acentuados para caracteres não acentuados

       - **POR QUE?**
         - Preciso que as chaves dos índices não tenha acentos para evitar confusão nas pesquisas.
    }
    public class function RemoveAccents (const str: String ): String;

    public class Function String_Asc_GUI_to_Asc_Ingles(Const S: String): String;
    public class Function SGI(Const S: String): String;

    public class Function String_Asc_GUI_to_Asc_HTML(Const S: String): String;
    public class Function SGH(Const S: String): String;

    private Const List_Class_Of_Char     : TMiStringList = nil;
    private class Function Get_List_Class_Of_Char:TMiStringList;

    private Const List_Class_Of_Char_GUI : TMiStringList = nil;
    private class Function Get_List_Class_Of_Char_GUI:TMiStringList;

    public class Procedure Show_GetEnv_System;

    public class Function FGetMem(Var Buff;Const TamBuff: Word) : Boolean;
    public class Procedure FFreeMem(Var Buff;Const TamBuff: Word) ;

    {: Retorna um ponteiro para a memória alocada e este ponteiro aponta para
       uma copia dos dados passado por BuffOriginal }
    public class Function CGetMem(Const BuffOriginal:Pointer ;Const TamBuff: Word):Pointer;

    public class function isfileopen(var f:file):boolean ;overload;
    public class function isfileopen(var f:text):boolean ;overload;

    public class Function CloseLst:SmallInt;

    public class Procedure RedirecionaParaImpressora;

    public class Procedure RedirecionaRelatorio;

    {: O método **name** troca todos os aSubStrOld para aSubStrNew em S }
    public class Function ChangeSubStr(aSubStrOld : AnsiString; {:< SubtString de S a ser trocada}
                                       aSubStrNew : AnsiString; {:< a Nova SubtString de S}
                                       S: AnsiString ):AnsiString; {:< Retorna S com o tString Trocado}
    public class Function Alias_To_Name(AAlias  : AnsiString):AnsiString;

    {: A class método **@name** cria um novo valor de GUID (Globally Unique Identifier).

       - **RETORNA**
         - **GUID**    : Novo GUID se sucesso ou string vazia se fracasso.
    }
    public class function CreateGUID():TString;

    private Const ExecAsync : Byte = efAsync;// Não Espera que o processo chamando termine

    public class Function SetExecAsync(aExecAsync:Byte):Byte;

    public class Function GetExecAsync():Byte;       //Retorna o valor de ExecAsync

    {: O método @name executa o shell do sistema operacional e retorna o Buffer da Tela

       ```Pascal

           program Project1;
             uses
               mi.rtl.objectss;

             var
               s : string;
           begin
             s := TObjectss.ShellScript('ls *.res');
             if s <>''
             then WriteLn(s);
           end.

       ```
    }
    Public class function ShellScript(aCommand:String): String;


    public class function ShellExecute(Const lpOperation,
                                       FileName,
                                       Params,
                                       DefaultDir: AnsiString;
                                       ShowCmd: Integer): THandle;Overload;

    public class function ShellExecute(const FileName, Params, DefaultDir: AnsiString;ShowCmd: Integer): THandle;Overload;
    public class function ShellExecute(const FileName, Params: AnsiString): THandle;Overload;

    {: A classe function **@name**  retorna o ip publico da máquina local}
    public class Function GetIpPub:String;
    public class function StrToInt(aStr:String):Int64;
    public class Function BooleanToStr(Const FieldData:Boolean):AnsiString;
    public class function DelSpcED(campo : Ansistring): AnsiString;

    {: O método **@name** exclui de campo os caracteres contidos em
       CharInvalid

       - Exemplo de uso
         ``` pascal

            //inclui um conjunto de caracateres a tString
              Var
                s : String;
            Begin
              S := '"Paulo.Sergio Idade: 1958"';
              DelChars(S,['"']);
              Resultado: Paulo.Sergio Idade: 1958
            end;

         ```

    }
    public class function DeleteChars(campo: Ansistring;CharInvalid:TAnsiCharSet): AnsiString;

    public class function Delspace(campo : Ansistring):AnsiString;
    Public class function GetNameValid(aName:AnsiString):AnsiString;

    public class function IsNumberReal(const aTemplate: ShortString): Boolean;
    public class function IsNumberInteger(const aTemplate: ShortString): Boolean;
    public class Function IsNumber(Const aTemplate : ShortString):Boolean;
    public class Function IsBoolean(Const aTemplate : ShortString):Boolean;
    public class Function IsData(Const aTemplate : ShortString):Boolean;
    public class Function IsHora(Const aTemplate : ShortString):Boolean;
    public procedure HandleEvent(var Event: TEvent); Virtual;
    public procedure ClearEvent(var Event: TEvent);Virtual;
    public class Function Change_AnsiChar(campo : AnsiString; Const AnsiChar_Font,AnsiChar_Dest : AnsiChar):AnsiString;
    public class Function DeleteMask(S:AnsiString;ValidSet: AnsiCharSet):AnsiString;overload;
    public class function DeleteMask(S:AnsiString;aMask:TString): AnsiString;overload;
    public class function AddMask(S: ShortString;aMask:ShortString): AnsiString;

    {: A função **@name** é usada para criar ou apagar um banco de dados

        - **Banco de dados possíveis:**
          - PostreSQL;
          - SqlLite;

       - **Retorna**
         - True  : Conseguiu criar o  banco de dados;
         - False : Error na ação
           - Error possiveis:
             - Banco de dados já existe quando se quer criar;
             - Banco de dados não existe quando se quer apagar;
             - Banco de dados usado por outro usuário.

       - **EXEMPLO**

         ```pascal

           // Cria banco de dados maricarai no postgresSql
           Procedure TForm1.Button2sqlPQConectionClick ( Sender : TObject ) ;
             var
               s : String;
           begin
             s := CreateDB_or_DropDB(PostgresSQL,'127.0.0.1',
                                               'postgres',
                                               'masterkey',
                                               'maricarai',
                                               true);
             if s = ''
             then ShowMessage('Banco de dados maricarai foi criado no postgresSql')
             else ShowMessage(s);
           End;

           // Apaga banco de dados maricarai no SqLite3
           Procedure TForm1.Button2sqlPQConectionClick ( Sender : TObject ) ;
             var
               s : String;
           begin
             s:= CreateDB_or_DropDB(PostgresSQL,'127.0.0.1',
                                               'SqLite3',
                                               'masterkey',
                                               'maricarai',
                                               false);
             if s = ''
             then ShowMessage('Banco de dados maricarai foi apagado SqLite3')
             else ShowMessage(s);
           End;


         ```
    }
    class function CreateDB_or_DropDB(aConnectorType : TConnectorType;
                                      aHostname,
                                      aUserName,
                                      aPassword,
                                      aDataBaseName : String;

                                      okCreateDB:Boolean //True cria; False : apaga
                                     ):string;

    {: O método @name remove as mascaras do número e retorna somente números e seprador decimal default }
//    class function StrNumberValid(S: AnsiString): AnsiString;

    {: O método @name converte um string com mascara e ponto decimar default em
       string com ponto decimal='.'.
       - Motivo de sua existência.
         - A função system.val e system.str não reconhecem o registro DefaultFormatSettings.
    }
    class function StrToStrNumberForProcVal(S: AnsiString): AnsiString;

    {: o classe método **@name** checa se s está entre aHigh e aLow retorna zero se houver erro
       e em aErr o código do erro.
    }
    Public class function CheckRanger(S : AnsiString; aHigh, aLow: Int64; out aErr:Integer): Int64;

    {: O método @name retorna **TRUE** se o parâmetro S for número inteiro ou **FALSE** caso contrário.}
    Public class function IntValid(S : AnsiString; TypeCode:AnsiChar):Boolean;

    {: O método @name Executa o browser padrão do sistema operacional.
    }
    Public class Procedure ShowHtml(URL:string);virtual;  //Deve ser redefinido onde a LCL for declarada.

    //Criação da propriedade HelpCtx_StrCurrentModule. Obs: Corrente módulo em execução independente do módulo da classe.
    private _HelpCtx_StrCurrentModule :AnsiString;
    protected Function GetHelpCtx_StrCurrentModule :AnsiString;virtual;   //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentModule

    {: A propriedade **@name** contém o nome do corrente módudo do projeto
      - NOTAS
        - Ao criar o objeto inicializa com Db_Global.StrCurrentModule
    }
    Public property HelpCtx_StrCurrentModule: AnsiString read GetHelpCtx_StrCurrentModule write _HelpCtx_StrCurrentModule;


    {: - A propriedade **@name** contém o nome do corrente comando do projeto

       - NOTAS
         - Ao criar o objeto inicializa com Db_Global.StrCurrentCommand
    }
    Private _HelpCtx_StrCurrentCommand: AnsiString;
    protected Function GetHelpCtx_StrCurrentCommand: AnsiString; Virtual;
    Public property HelpCtx_StrCurrentCommand: AnsiString read GetHelpCtx_StrCurrentCommand write _HelpCtx_StrCurrentCommand;

    {: - A propriedade **@name** contém o nome da opção do corrente comando do projeto

       - NOTAS
         - Nome da opcao ativa dentro do comando
    }
    Private _HelpCtx_StrCurrentCommand_Opcao : AnsiString;
    Protected Function GetHelpCtx_StrCurrentCommand_Opcao: AnsiString; virtual; //< Nome da opcao ativa dentro do comando
    Public property HelpCtx_StrCurrentCommand_Opcao: AnsiString read GetHelpCtx_StrCurrentCommand_Opcao write _HelpCtx_StrCurrentCommand_Opcao;
    {: O método **@name** retorna o número de ordem do controlo no grupo.}
    public Function  TabIndex:Longint;Virtual;

    Protected function CreateHTML : AnsiString;Overload;Virtual;
    Protected Function GetAcao():AnsiString;Virtual; //Retorna o link da ação da classe

    Protected function GetHelpCtx_Path: AnsiString;Virtual;

    {$REGION '---> Construção da propriedade ID_Dinamic'}
      Private _HelpCtx_StrCommand: AnsiString;
      protected Function GetHelpCtx_StrCommand: AnsiString; Virtual;
      {: A propriedade **@name** retorna o nome do comando que está
         utilizando esta classe}
      Public property HelpCtx_StrCommand: AnsiString read GetHelpCtx_StrCommand write _HelpCtx_StrCommand;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade HelpCtx_StrCurrentCommand_Topic'}
        private _HelpCtx_StrCurrentCommand_Topic: AnsiString;
        protected Function GetHelpCtx_StrCurrentCommand_Topic: AnsiString;virtual;
        {: A propriedade **@name** retorna o nome do tópico corrente do comando que está utilizando esta classe
           - NOTAS
             - Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic
        }
        Public property HelpCtx_StrCurrentCommand_Topic: AnsiString read GetHelpCtx_StrCurrentCommand_Topic write _HelpCtx_StrCurrentCommand_Topic;

    {$ENDREGION}

    {$REGION '---> Construção da propriedade HelpCtx_StrCommand_Topic'}
      private _HelpCtx_StrCommand_Topic: AnsiString;
      protected Function GetHelpCtx_StrCommand_Topic: AnsiString;virtual;

      {: A propriedade **@name** retorna o nome do tópico corrente do comando que está utilizando esta classe
         - NOTAS
           - Ao criar o objeto deve ser inicicializado pelo Alias da classe
      }
      Public property HelpCtx_StrCommand_Topic: AnsiString read GetHelpCtx_StrCommand_Topic write _HelpCtx_StrCommand_Topic;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade HelpCtx_StrCurrentCommand_Topic_Content_Run'}
      private _HelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;
      protected Function GetHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;virtual;
      Protected Procedure SetHelpCtx_StrCurrentCommand_Topic_Content_Run(wHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run);virtual;
      {: A propriedade **@name** retorna o nome StrCurrentCommand_topic_Content_run do comando que está utilizando esta classe
         - NOTAS
           - Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic_Content_run;
      }
      Public property HelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run read GetHelpCtx_StrCurrentCommand_Topic_Content_Run write SetHelpCtx_StrCurrentCommand_Topic_Content_Run;

    {$ENDREGION}

    {$REGION '---> Construção da propriedade Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File'}
      private _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean;
      Protected  Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;Virtual;
      Protected  procedure Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);Virtual;

      {: A propriedade **@name** é usado para indica a propriedade **HelpCtx_StrCurrentCommand_Topic_Content_Run** que existe documento referente a visão corrente. Ou seja help sencível ao contexto.
         - **NOTAS**
           - Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic
           - Se HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File então:
             - Retorna true;
           - Se HelpCtx_StrCurrentCommand_Topic_Content_Run <> HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File então:
             - Retorna false;
      }
      Public property Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean read _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File write Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade HelpCtx_StrCurrentCommand_Topic_Content'}
      private _HelpCtx_StrCurrentCommand_Topic_Content: AnsiString;
      protected Function GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;virtual;
      protected Procedure SetHelpCtx_StrCurrentCommand_Topic_Content(wHelpCtx_StrCurrentCommand_Topic_Content:AnsiString);virtual;

      {: A propriedade **@name** contém o conteúdo do campo no qual será criado um arquivo .html
         - **NOTAS**
           - Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic_Content;
      }
      Public property HelpCtx_StrCurrentCommand_Topic_Content: AnsiString read GetHelpCtx_StrCurrentCommand_Topic_Content write SetHelpCtx_StrCurrentCommand_Topic_Content;
    {$ENDREGION}
    Public function GetHelpCtx_Doc_HTML: AnsiString;Virtual; //Se quem herdar esta classe não for do tipo campo então este metodo deve ser redefinido.

    {: A classe método **@name** recebe em aInputString uma string separada pelo delimitador informado em aDelimiter e retorna um arrey de strings }
    public class function SplitString(aInputString:string; aDelimiter: Char):TStringArray;

    {: O Método **@name** converte código HTML em cor da LCL

       - Exemplo de usado da função

         ```pascal

              unit Unit1;

                interface

                uses
                  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
                  Dialogs, ExtCtrls, StdCtrls;

                type
                  TForm1 = class(TForm)
                    Edit1: TEdit;
                    Button1: TButton;
                    Shape1: TShape;
                    procedure Button1Click(Sender: TObject);
                  private

                  public

                  end;

                var
                  Form1: TForm1;

              implementation

                $R *.dfm


                function HTMLToTColor(const HTML: String): Integer;
                var
                  Offset: Integer;
                begin
                  try
                    // check for leading '#'
                    if Copy(HTML, 1, 1) = '#' then
                      Offset := 1
                    else
                      Offset := 0;
                    // convert hexa-decimal values to RGB
                    Result :=
                      Integer(StrToInt('$' + Copy(HTML, Offset + 1, 2))) +
                      Integer(StrToInt('$' + Copy(HTML, Offset + 3, 2))) shl 8 +
                      Integer(StrToInt('$' + Copy(HTML, Offset + 5, 2))) shl 16;
                  except
                    // try for color names
                //    Result := TranslateColorName(LowerCase(HTML));
                  end;
                end;



                function RGBToColor(R,G,B:Byte): TColor;
                begin
                  Result:= B Shl 16 Or  //Blue
                           G Shl 8  Or  //Verde
                           R;           //Vermelho
                end;

                procedure TForm1.Button1Click(Sender: TObject);
                begin
                //  Shape1.Brush.Color:= rgbtocolor(107,183,239);
                  Shape1.Brush.Color:= HTMLToTColor(Edit1.Text);

                  Shape1.Invalidate;
                end;

           ```
    }
    class function HTMLToTColor(const HTML: TString): Integer;

    {: O método **@name** retorna true se avalue for vazio ou null }
    public Class function IsEmptyOrNull(const aValue: Variant): Boolean;

    {: O método **@name** usado para ocultar a propriedade de um componente.

      - Criei esse método na minha classe base com objetivo de tornar a propriedade
        de uma classe invisível.

      - O mesmo deve se usado ao registrar um componente;
        - Exemplo

          ```pascal
               procedure Register;
                begin
                    RegisterComponents('Mi.Rtl',[TMi_SQLQuery]);
                    Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'Options');
                    Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'FileName');
                    Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'DataSource');
                    Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'UniDirecional');
                    Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'Tag');
                    Tmi_rtl.UnlistPublishedProperty(TMi_SQLQuery,'PacketRecords');
               end;
          ```

      - Se essas propriedades forem alteradas pelo usuário do componente certamente o
      componente dará problema, por isso precisei remove-lo da lista de propriedade
      para evitar problema.

      - Para que não de problema, no constructor create da classe seto o que preciso,
      porém se essa propriedade fossem visíveis  o usuário perderia muito tempo para
      entender porque o que ele informou o que ele queria e o comportamento do componente
      não mudaria.
    }
    public class procedure UnlistPublishedProperty (ComponentClass:TPersistentClass; const PropertyName:String);

    public class Procedure str(v : variant; var s : String);

    public class Procedure Print_info_compile;

//    public class Function GetPropInfo(AClassInfo: Pointer;AName:String):PPropInfo;

    {:O classe método converte um array of const em um string separado por virgula.

      - **NOTAS**
        - Iteração sobre o array: A função VarRecArrayToStr percorre cada elemento
          do array Args e converte-o em uma string usando um case para identificar
          o tipo de dado.

        - Construção da string de resultado: Para cada elemento do array, a string
          correspondente é concatenada ao Result. Entre os elementos, é adicionada
          uma vírgula e um espaço.

      - **EXMPLO DE USO**

        ```pascal

          var
            S: string;
          begin
            S := VarRecArrayToStr([1, 'Ola Mundo', 3.14, True]);
            WriteLn(S);  // Saída: 1, Hello, 3.14, True
          end.

        ```
    }
    class function VarRecArrayToStr(const Args: array of const): string;

    {: O método **@name** Salva o array JSONString para aJSONDataSet.rows }
    class procedure JsonToDataSet(const JSONString: string; var aJSONDataSet: TJSONDataSet );

    Class Function DataSetToJson(Const aJSONDataSet: TJSONDataSet):String;

    {:A classe método **@name** converter um jsonData em Variant

      - **Exemplo de uso**

        ```pascal

          program test;

            uses
              SysUtils, fpjson, jsonparser, Variants;

            var
              JSONStr: string;
              JSONData: TJSONData;
              JSONVariantArray: Variant;
              i: Integer;
          begin
            // Exemplo de string JSON contendo um array
            JSONStr := '[1, "Texto", true, null,3.56 ]';

            try
              // Parseando o JSON
              JSONData := GetJSON(JSONStr);

              // Convertendo JSON para array de Variant
              JSONVariantArray := JSONToVariantArray(JSONData);

              // Exibindo os valores convertidos
              for i := VarArrayLowBound(JSONVariantArray, 1) to VarArrayHighBound(JSONVariantArray, 1) do
                WriteLn('JSONVariantArray[', i, '] = ', JSONVariantArray[i]);
            finally
              JSONData.Free;
            end;
          end.

        ```

    }
    class function JSONToVariantArray(JSONData: TJSONData): Variant;

     {:A classe método **@name** recebe em a value um array e retorna um array de string

       - **EXEMPLO DE USO

         ```pascal

           program ArrayToVariantExample;
             uses
               Variants, SysUtils;

             var
               aKeyValues: array of string;
               vKeyValues: Variant;
               i: Integer;
           begin
             // Inicializando o array
             SetLength(aKeyValues, 3);
             aKeyValues[0] := 'Valor1';
             aKeyValues[1] := 'Valor2';
             aKeyValues[2] := 'Valor3';

             vKeyValues := ArrayToVariant(aKeyValues);

             // Exemplo de acesso aos valores do Variant
             for i := VarArrayLowBound(vKeyValues, 1) to VarArrayHighBound(vKeyValues, 1) do
               WriteLn('vKeyValues[', i, '] = ', vKeyValues[i]);

             // Tentativa de acessar os elementos do array Variant para verificar
             for i := 0 to VarArrayHighBound(vKeyValues, 1) do
             begin
               // Atribua cada elemento a uma variável string (s) para teste
               WriteLn('Elemento ', i, ': ', VarToStr(vKeyValues[i])); // Exibe os elementos no console para verificação
             end;
           end.
         ```
     }
    class function ArrayToVariant(aValues: array of string):Variant;

    {:A classe método **@name** percorre a lista de strings fornecida em `aQueryFields`,
      que normalmente contém pares chave-valor no formato `chave=valor`, e separa as
      chaves e os valores.

      - As chaves são concatenadas em uma única string, separadas por ponto e
        vírgula (`;`), e retornadas como resultado da função. Os valores
        correspondentes são armazenados no array `Values`, que é passado como um
        parâmetro de saída.

      - Parâmetros
        - param(aQueryFields)
          - Uma lista de strings contendo pares chave-valor no formato `chave=valor`.)
        - param(Values)
          - Um array de strings que conterá os valores extraídos dos pares
            `chave=valor`.)
      - Returns()
        - A string contendo todas as chaves extraídas dos pares, separadas por
          ponto e vírgula.)

      - **Por que foi criado**
        - O método locate precisa de uma lista de nome de campos e uma array de variantes

      - Exemplo de uso:

         ```pascal

            uses
              SysUtils, Classes;

            procedure TestGetFieldsKeys;
            var
              QueryFields: TStringList;
              Values: array of string;  // Array dinâmico de strings
              Keys: AnsiString;
              I: Integer;
            begin
              QueryFields := TStringList.Create;
              try
                // Adicione pares chave=valor
                QueryFields.Add('key1=value1');
                QueryFields.Add('key2=value2');
                QueryFields.Add('key3=value3');

                // Chame a função passando a lista e o array dinâmico.
                Keys := TObjectsMethods.getFieldsKeys(QueryFields, Values);

                // Exibir as chaves extraídas
                Writeln('Keys: ', Keys);

                // Exibir os valores extraídos
                for I := Low(Values) to High(Values) do
                begin
                  Writeln('Value ', I, ': ', Values[I]);
                end;
              finally
                QueryFields.Free;
              end;
            end;

            begin
              TestGetFieldsKeys;
            end.

         ```
    }
    class function getFieldsKeys(aQueryFields: TStrings;out Values: TArray<string>): AnsiString;overload;

    {:A classe método **@name** Codifica uma string para ser usada em uma URL

      **Parâmetros:**
        - `AStr`: A string que será codificada, do tipo `Ansistring`.

      **Retorno:**
        - Retorna a string codificada no formato `UTF8String`, onde caracteres especiais são convertidos para sua representação hexadecimal (%XX) conforme o padrão de codificação de URLs.

      **Descrição:**
        - Este método percorre a string fornecida e codifica os caracteres que
          não são seguros para URLs (como espaços e caracteres especiais). A
          codificação usa o formato hexadecimal, precedido pelo símbolo `%`.
          Caracteres dentro da faixa ASCII imprimível (32-126) são mantidos,
          exceto para `[' ', '&', '=', '?', '#', '%']`, que são codificados.

        - A função converte a string de entrada para UTF-8 antes de realizar a
          codificação, garantindo que seja compatível com a codificação de URL
          padrão.

      **Exceções:**
        - Não lança exceções diretamente, mas pode haver problemas se uma string
          não for adequadamente codificada para UTF-8.

      **Exemplo:**

        ```pascal
           var
             EncodedStr: UTF8String;
           begin
             EncodedStr := TObjectsMethods.URLEncode('name=John Doe & age=30');
             // EncodedStr resultará em "name=John%20Doe%20%26%20age%3D30"
           end;
        ```
    }
    class function URLEncode(AStr: Ansistring): UTF8String;

    {:O método **@name** converte um objeto JSON em uma string de query para URLs

      **Parâmetros:**
      - `Params`: O objeto JSON do tipo `TJSONObject` contendo os parâmetros a serem convertidos.

      **Retorno:**
      - Retorna uma string formatada como uma query de URL, onde cada chave-valor do JSON é convertido no formato `chave=valor`, e pares múltiplos são concatenados usando `&`.

      **Descrição:**
      Este método percorre cada par chave-valor de um objeto JSON e o converte para uma string de query. Diferentes tipos de valores JSON são tratados da seguinte forma:

      - `jtNull`: A chave é incluída sem valor.
      - `jtString`: A chave e o valor são codificados para URL.
      - `jtNumber`: O valor é convertido para string com suporte a números.
      - `jtBoolean`: O valor booleano é convertido para 'true' ou 'false'.
      - `jtArray`: Os valores do array são concatenados por vírgulas, como `valor1,valor2`.

      **Exceções:**
      - Uma exceção é lançada se um tipo de valor JSON não suportado for encontrado.

      **Exemplo:**

        ```pascal
           var
             JSONObject: TJSONObject;
             QueryString: string;
           begin
             JSONObject := TJSONObject.Create;
             JSONObject.Add('name', 'John');
             JSONObject.Add('age', 30);
             JSONObject.Add('active', True);

             QueryString := TObjectsMethods.JSONObjectToQueryString(JSONObject);
             // QueryString resultará em "name=John&age=30&active=true"
           end;
        ```
    }
    class function JSONObjectToQueryString(const Params: TJSONObject): string;

    {:O método **@name** usado para converter strings separadas por vírgulas em
      um array JSON.

      - **Descrição**
        - Este método de classe converte uma string no formato CSV
          (Comma-Separated Values) em um array JSON (`TJSONArray`). A string
          CSV é dividida usando a vírgula como delimitador, e cada item
          resultante é adicionado ao array JSON. Espaços extras ao redor dos
          valores são removidos.

      - **Parâmetros**
        - **CSV**: `string`
          - A string no formato CSV que será convertida em um array JSON.

      - **Retorno**
        - `TJSONArray`
           - Um array JSON contendo os valores extraídos da string CSV.

      - **Fluxo de Execução**
        1. Cria um novo objeto `TJSONArray` e um `TStringList`.
        2. Configura o `TStringList` para usar a vírgula como delimitador e
           desativa o tratamento de espaços como parte dos valores.
        3. Divide a string CSV em uma lista de valores.
        4. Itera sobre a lista e adiciona cada item ao array JSON, removendo
           espaços extras.
        5. Libera a memória alocada para o `TStringList`.

      - **Exceções**
        - Não há tratamento específico de exceções implementado neste método.

      - **Ver Também**
        - `TJSONArray`
        - `TStringList`
        - `DelimitedText`
    }
    Class function ConvertCSVToJSONArray(const CSV: string): TJSONArray;

    {:A classe método **@name** extrae de aRequest.QueryFields os parâmetros
      abaixo:

      - **PARAMETROS**
        - aKeyFields: string;
          - Espera uma lista de nome dos campos separados por virgula.

        - aKeyValues: Variant;
         - Espera uma lista de valores dos campos separados por virgula.

        - aOptions   : TLocateOptions
          - Espera uma lista de opções separados por vírgula onde as opções podem
            ser: 'loCaseInsensitive','loPartialKey'
            - Obs:
              - Pode ser um ou outros ou ambos.
              - São parâmetros espardos no função .TDataSet.Locate

    }
    class Procedure GetQueryFieldsLocate(var aRequest: TRequest;
                                         out aKeyFields: string;
                                         Out aKeyValues: Variant;
                                         Out aOptions   : TLocateOptions
                                         );

     {:O método **@name** converte os parâmetros de uma chamada TDataSet.Locate()
      em TJSonObject para ser enviado para o servidor para pesquisar o registro.

      - **EXEMPLO**

        ```pascal

          Procedure LocateParamsToJsonTest;
          var
            JsonLocateParams: TJSONObject;
            s:string;
          begin
            JsonLocateParams := LocateParamsToJson('Company;Contact;Phone',
              VarArrayOf(['Sight Diver', 'P', '408-431-1000']), [loPartialKey]);
            try
              s := JsonLocateParams.AsJSON;
              writeln(JsonLocateParams.AsJSON);
            finally
              JsonLocateParams.Free;
            end;
          end;

        ```
    }
    Class function LocateParamsToJson(KeyFields: string; KeyValues: Variant; Options: TLocateOptions): TJSONObject;

    {:O método **@name** tem como objetivo construir e validar uma URL a partir
      de três partes: a URL base (`BaseURL`), uma ação (`Action`), e uma string
      de consulta (`QueryString`). Ela garante que a junção dessas partes ocorra
      de maneira correta, removendo duplicações de barras (`/`) e verificando a
      formatação da string de consulta.

      - Parâmetros
        - `BaseURL`: A URL base, geralmente fornecida pelo método `GetURL()`.
           Pode ou não terminar com uma barra (`/`).
        - `Action`: O caminho ou ação que será anexado à `BaseURL`. Pode ou não
           começar com uma barra (`/`).
        - `QueryString`: A string de consulta que será anexada à URL final,
          representando os parâmetros da requisição. Se fornecida, deve começar
          com um ponto de interrogação (`?`), o qual será verificado pela função.

      - Retorno
        - A função retorna uma `string` contendo a URL completa e validada,
          pronta para ser utilizada em requisições HTTP.

      - Exemplo de Uso

        ```pascal
           var
             CompleteURL: string;
           begin
             CompleteURL := ValidateAndNormalizeURL('http://example.com', '/api/resource', '?id=123&name=test');
             // Resultado: http://example.com/api/resource?id=123&name=test
           end;
        ```
    }
    Class function ValidateAndNormalizeURL(const BaseURL, Action, QueryString: string): string;

    {:O método **@name** faz o parsing de uma resposta JSON recebida e extrai os
      campos de chave e seus respectivos valores. O campo `keyFields` é uma string
      que contém os nomes dos campos separados por vírgula, e o campo `keyValues`
      pode ser um array de valores ou um único valor.

      - **Parâmetros**
        -`AResponse`:
          - String contendo o JSON da resposta do servidor.
        - `KeyFields`:
          - String de saída que armazenará os campos de chave extraídos do JSON.
        - `KeyValues`: Variável de saída que armazenará os valores dos campos de
          chave. Pode ser um array de variantes ou um valor único.

      - **Fluxo de Execução**
        1. Inicializa as variáveis `KeyFields` e `KeyValues` com valores padrão
           (`''` e `Null`, respectivamente).
        2. Realiza o parsing do JSON contido em `AResponse`.
        3. Extrai o valor de `keyFields`, que deve ser uma string no JSON.
        4. Verifica se `keyValues` é um array:
           - Se for, cria um array de variantes e itera pelos itens do array,
             armazenando-os em `KeyValues`.
           - Se não for, `KeyValues` recebe um único valor extraído do JSON.
        5. Libera o objeto JSON ao final da execução.
        6. Caso ocorra um erro durante o parsing, o método captura a exceção e
           exibe uma mensagem de erro.

      - Exceções
        - `E: Exception`:
          - Exceção capturada se ocorrer algum erro durante o processamento do
            JSON. A mensagem de erro é exibida no console.

      - **Ver Também**
        - `TJSONObject`
        - `TJSONArray`
        - `GetJSON`
        - `VarArrayCreate`
    }
    class procedure ParseServerResponse(const AResponse: string; out KeyFields: string; out KeyValues: Variant);
  end;



(*     tStream = class(TObjectsMethods)
       //Atributos public
          public Status    : Integer;   {:< Stream status }
          public ErrorInfo : Integer;   {:< Stream error info }
          public StreamSize: LongInt;   {:< Stream current size }
          public Position  : LongInt;   {:< Current position }
     end;   *)

implementation
  const
      reintrance : boolean = false;

constructor TObjectsMethods.Create(aOwner: TComponent);
begin
  inherited Create(aOwner);
  Mi_Transaction := TMi_Transaction.Create(self);
end;

destructor TObjectsMethods.destroy;
begin
  FreeAndNil(Mi_Transaction);
  inherited destroy;
end;

  class function TObjectsMethods.redirectOutput(var OutputFile:text;  aFileName:TFileName):integer;
  begin
    if not isfileopen(OutputFile)
    Then Begin
           AssignFile(OutputFile,aFileName );
           Rewrite(OutputFile);//  abrir arquivo para gravação, destruindo conteúdo, se houver
         end;
    //Result := DuplicateHandle(TTextRec(OutputFile).Handle,TTextRec(output).Handle);
    Result := DuplicateHandle(OutputFile, output);

    if Result <>0 then
    begin
      raise Exception.CreateFmt('O método '+{$I %CURRENTROUTINE%}+' falhou: %s', [Result]);
    end;
  end;

  class function TObjectsMethods.Logs: TFilesLogs;
  begin
    if _Logs = nil
    then _Logs := TFilesLogs.Create(nil);
    result := _Logs;
  end;

  class procedure TObjectsMethods.SysMessageBox(Msg, Title: AnsiString;Error: Boolean);
  begin
    if error
    then Alert('Error: '+title,msg)
    else Alert(title,msg);
  end;

  class function TObjectsMethods.MessageBox(const Msg: AnsiString): TMI_MsgBoxTypes.TModalResult;
  begin
    if reintrance
    then begin
           Result := 0;
         end;

    if Assigned(_MI_MsgBox)
    then with _MI_MsgBox do
         begin
           reintrance := true;
           Result := MessageBox('',Msg,mtWarning, [mbOK,mbCancel],mbOk);
           reintrance := false;
         end
    else Result := MrOk;
  end;

  class function TObjectsMethods.MessageBox(const aMsg: AnsiString;
                                            DlgType: TMI_MsgBoxTypes.TMsgDlgType;
                                            Buttons: TMI_MsgBoxTypes.TMsgDlgButtons): TMI_MsgBoxTypes.TModalResult;
  begin
    if not reintrance and Assigned(_MI_MsgBox)
    then with _MI_MsgBox do
         begin
           reintrance := true;
           Result := MessageBox(aMsg,DlgType,Buttons);
           reintrance := false;
         end
    else Result := MrCancel;
  end;

  class function TObjectsMethods.MessageBox(const aMsg: AnsiString;
                                              DlgType: TMI_MsgBoxTypes.TMsgDlgType;
                                               Buttons: TMI_MsgBoxTypes.TMsgDlgButtons;
                                               ButtonDefault: TMI_MsgBoxTypes.TMsgDlgBtn): TMI_MsgBoxTypes.TModalResult;
  begin
    if not reintrance and Assigned(_MI_MsgBox)
    then with _MI_MsgBox do
         begin
           reintrance := true;
           Result := MessageBox(aMsg,DlgType,Buttons,ButtonDefault);
           reintrance := false;
         end
    else Result := MrCancel;
  end;

  class procedure TObjectsMethods.Abstracts;
    var s : AnsiString;
  begin
    s := TStrError.ErrorMessage5('mi.rtl','mi.rtl.Obejcts.Methods','TObjectsMethods','Abstracts','Método abstrato não implementado...' );
    LogError(TStrError.ErrorMessage(s));
    //MessageBox(s);

    raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.objects.Methods','TObjectsMethods','Abstract',211 ));
     //SysMessageBox(PAnsiChar( '' ),'Error: 211 - Abstract error',true);
  end;


  class procedure TObjectsMethods.RegisterError;
  BEGIN
     RunError(212);                                     { Register error }
  END;

  class procedure TObjectsMethods.RegisterType(var S: TStreamRec);
    VAR P: pStreamRec;
  BEGIN
     P := StreamTypes;                                  { Current reg list }
     While (P <> Nil) AND (P^.ObjType <> S.ObjType)
       Do P := P^.Next;                                 { Find end of chain }
     If (P = Nil) AND (S.ObjType <> 0) Then Begin       { Valid end found }
       S.Next := StreamTypes;                           { Chain the list }
       StreamTypes := @S;                               { We are now first }
     End Else RegisterError;                            { Register the error }
  END;

        class function TObjectsMethods.LongMul(X, Y: Integer): LongInt;
  BEGIN
      LongMul:=Longint(X)*Y;                            { Multiply integers }
  END;

  {: A classe function **@name** retorna o valor inteiro do inteiro longo X dividido pelo inteiro Y.
  }
    class function TObjectsMethods.LongDiv(X: LongInt; Y: Integer): Integer;
  BEGIN
     LongDiv := Integer(X DIV Y);                       { Divid longint }
  END;

  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {                    DYNAMIC String INTERFACE ROUTINES                      }
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

  //class function TObjectsMethods.NewStr(const S: AnsiString): ptstring;
  ////VAR P: ptstring;
  //BEGIN
  //  if Length(S)> 255
  //  then Begin
  //          LogError(TStrError.ErrorMessage('Exceção em Objects.function NewStr(): String maior que 255'));
  //          raise  EArgumentException.Create('Exceção em Objects.function NewStr(): String maior que 255');
  //
  ////         SysMessageBox(PAnsiChar('Exceção em Objects.NewStr(): String maior que 255'),'Run time error',true);
  ////         abort;
  //       end;
  //
  //   If (S = '')
  //   Then Result := Nil
  //   Else Begin               { Empty returns nil }
  //          GetMem(Result, Length(S) + 1);                        { Allocate memory }
  //          Result^[0] := Ansichar(Length(S));
  //          Move(S[1],Result^[1],Length(S));
  //
  //        //If (Result <> Nil) Then Result^ := S;                      { Transfer string }
  //   End;
  ////   NewStr := P;                                       { Return result }
  //END;

   class procedure TObjectsMethods.NNewStr(var PS: ptstring; const S: AnsiString);
    //Cria um novo string se Ps=nil do contrario troca Ps por S
  Begin
    if Length(S)> 255
    then Begin
            LogError(TStrError.ErrorMessage('Exceção em Objects..function nNewStr(): String maior que 255'));
            raise  EArgumentException.Create('Exceção em Objects..function nNewStr(): String maior que 255');
         end;

    If Ps = nil Then
      Ps := NewStr(S)
    Else
    Begin
      DisposeStr(ps);
      Ps := NewStr(S)
    End;
  End;

  class procedure TObjectsMethods.DisposeStr(var P: ptstring);
  BEGIN
    SysUtils.DisposeStr(p);

    //If Assigned(P)
    //Then begin
    //       FreeMem(P, Length(P^) + 1);     { Release memory }
    //       P  := nil;
    //     end;
  END;

  class function TObjectsMethods.CallPointerLocal(Func: codepointer;
                           Frame: Pointer; Param1: pointer): pointer;
  begin
    {$ifdef cpui8086}
      CallPointerLocal := PointerLocal(Func)(Ofs(Frame^), Param1)
    {$else cpui8086}
      CallPointerLocal := PointerLocal(Func)(Frame, Param1)
    {$endif cpui8086}
  end;



  class function TObjectsMethods.Name_Type_App_MarIcaraiV1: AnsiString;
  Begin
    result := '';

    {$IFDEF CONSOLE} // Uma aplicação CGI deve ser compilado no modo console.
      Result := '/\/\ar/\carai - Console';
    {$ENDIF}

    {$IFDEF GUI} // Aplicação gráfica independente de usar vcl ou não.
      Result := '/\/\ar/\carai - GUI';
    {$ENDIF}

    {$IFDEF App_Tv} // Aplicação turbo vision deve ser atualizado em APP.PAS e é uma aplicação console.
      Result := '/\/\ar/\carai - App_Tv';
    {$ENDIF}

    {$IFDEF App_WS_Soap} // Aplicação web publicado com serviço XML com Protocolo Soap
      Result := '/\/\ar/\carai - App_WS_Soap';
    {$ENDIF}

    {$IFDEF App_VCL} //Aplicação VCL pode ser mista console e gráfica.
      Result := '/\/\ar/\carai - App_VCL';
    {$ENDIF}

    {$IFDEF App_VCL_IE} // Aplicação gráfica usando os componentes VCL e webBrowser como entrada de dados.
      Result := '/\/\ar/\carai - App_VCL_IE';
    {$ENDIF}

    {$IFDEF App_CGI} //Aplicação CGI ignora todo acesso do teclado e video do console usada como aplicações web, console ou GUI quando usado como pacote em tempo de designer.
      Result := '/\/\ar/\carai - App_CGI';
    {$ENDIF}

    {$IFDEF App_FastCgi} // Aplicação web compilada como dll deve ser executada em conjunto com browser.
      Result := '/\/\ar/\carai - App_CGI '; //
    {$ENDIF}

    if Result = ''
    then begin
           RunError(ParametroInvalido);
         end;

  End;

  class function TObjectsMethods.Set_IsApp_LCL(aIsApp_LCL: Boolean): Boolean;
  Begin
    Result := IsApp_LCL;
    {$IFDEF GUI} //Aplicação Grafica .
      IsApp_LCL := aIsApp_LCL;
      IsApp_TV  := False;
    {$ELSE}
      if IsConsole
      then Begin
            IsApp_LCL := aIsApp_LCL;
    //         IsApp_TV  := True;
          end;
    {$ENDIF}
  end;

  class procedure TObjectsMethods.PopSItem(var Items: PSItem);
     var  auxItems : PSItem;
  begin
    try
      If IsValidPtr(Items)  Then
      begin
        CtrlSleep(0);

        auxItems := Items^.Next;

        If IsValidPtr(Items^.Value)
        then DisposeStr(Items^.Value);


        Dispose(Items);


        Items := auxItems;
      end;

    Except
      Items := nil;
    end;
  end;



  class procedure TObjectsMethods.DISCARD(var AClass);
   var
     Temp: TObject;
     WTaStatus : Integer;
     s : string;
  begin
    try //Except
      try //Finally
         wTaStatus := TaStatus;
         Temp := TObject(AClass);
         if (Temp <> nil) and temp.ClassNameIs(temp.ClassName)
         then Begin
                S := (Temp as TObject).ClassName;
                Pointer(AClass) := nil;
                Temp.Free;
              End
         Else begin
                Pointer(AClass) := nil;
                S := 'invalido';
              end;

      Finally
         TaStatus := wTaStatus;
      end;

    Except
      if s<>'' then;
    end;

  end;


  class procedure TObjectsMethods.DISCARD(var AClass: TObject);
    Var
      WTaStatus : Integer;
  BEGIN
    try
      WTaStatus := TaStatus;
      Try
        if IsValidPtr(AClass)
        Then FreeandNil(AClass)
        else AClass := nil;

      Except
        aClass := nil;
      end;
    Finally
         TaStatus := wTaStatus;
    end;
   END ;



  class function TObjectsMethods.SetFlushBuffer_Disk(const aFlushBuffer_Disk: Boolean): Boolean;
  Begin
    Result := FlushBuffer_Disk;
    FlushBuffer_Disk := aFlushBuffer_Disk;
  end;

  class function TObjectsMethods.SetFlushBuffer(const aFlushBuffer: Boolean): Boolean;
  Begin
    Result := FlushBuffer;
    FlushBuffer := aFlushBuffer;
  end;



  class function TObjectsMethods.GetDosTicks: DWord;
  begin
    result := GetTickCount64 {GetCurrentTime}; {Delphi}
  end;
  {: A função **@name** converte segundos para milisegundos.

     - **NOTA**
       - 1 Milliseconds = 1/1000 segundos -> 1 segundo = 1000 Milliseconds
  }
                class function TObjectsMethods.Seg_to_MillSeg(aSegundos: Longint
          ): DWord;
  Begin
    Result := Round(aSegundos*1000);
  End;

  class procedure TObjectsMethods.RunError(Error: Word);
  Begin
    try
      Sysutils.ShowException(Exception.Create(TStrError.ErrorMessage(Error)),nil);
    finally
      system.RunError(Error);      
    end;
  end;

  class procedure TObjectsMethods.Run_Error(Error: Word;Procedimento_que_Executou: AnsiString);
  Begin
    Procedimento_que_Executou := 'Origem: '+
                                  Procedimento_que_Executou+' '+LF+
                                  ' Error: '+
                                  IntToStr(Error) ;
    SysMessageBox(Procedimento_que_Executou,'Run time error',true);
  end;

  class procedure TObjectsMethods.Alert(aTitle: AnsiString; aMsg: AnsiString);
  begin
    if Assigned(_MI_MsgBox)
    then with _MI_MsgBox do
         begin
           _MI_MsgBox.MessageBox(aTitle,aMsg,mtWarning,[mbOk],mbOk);
         end;
  end;

  class procedure TObjectsMethods.ShowMessage(const aMsg: string);
  begin
    Alert('ATENÇÂO', aMsg);
  end;

  class function TObjectsMethods.Confirm(aTitle: AnsiString;aPergunta: AnsiString): Boolean;
  begin
    if Assigned(_MI_MsgBox)
    then with _MI_MsgBox do
         begin
           result := _MI_MsgBox.MessageBox(aTitle,aPergunta,mtConfirmation,mbYesNo,mbYes)=mrYes;
         end;
  end;

  //class function TObjectsMethods.NewSItem(const Str: tString; ANext: PSItem): PSItem;
  //var
  //  Item: PSItem;
  //begin
  //  New(Item);
  //  Item^.Value := NewStr(Str);
  //  Item^.Next := ANext;
  //  NewSItem := Item;
  //end;




  class function TObjectsMethods.MaxItemStrLen(AItems: PSItem): integer;
   //Retorna o tamanho da maior length(AItems^.Value^)

    var  len : integer;
  begin
    len := 0;
    While (AItems <> nil) do
    begin
      try
        If (AItems^.Value <> nil)
        Then If (length(AItems^.Value^) > len)
             then len := length(AItems^.Value^);

        AItems := AItems^.Next;

      Except
      end;
    end;
    MaxItemStrLen := len;
  end;

  class function TObjectsMethods.MaxItemStrLen(PSItems: tString): integer;
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

  class function TObjectsMethods.conststr(i: Longint; const a: AnsiChar): AnsiString;
  begin
    if i > 0
    then Begin
           SetLength(Result,i);
           FillChar(Result[1],i,a);
         End
    else Result := '';
  end;

  class function TObjectsMethods.centralizesStr(const campo: AnsiString;const tamanho: Integer): AnsiString;
    var
      campoAux : tString;
  begin
    If (tamanho - length(campo)) > 0
    Then campoAux := constStr(((tamanho - length(campo)) div 2),' ') + campo
    else campoAux := ''+campo;

    If (Tamanho-length(campoAux)) > 0
    Then centralizesStr := campoAux + constStr(Tamanho-length(campoAux),' ')
    else centralizesStr := campoAux;
  end;

  class function TObjectsMethods.MaskEdit_to_Mask(const aMaskEdit: AnsiString ): TMask;
  begin
    case AnsiIndexStr(aMaskEdit,['##/99/99',                    //0
                                 '99/99/##',                    //1
                                 '####/99/99',                  //2
                                 '99/99/####',                  //3
                                 '99/##',                       //3
                                 '99/####',                     //4
                                 'ssssssssssssssssssssssssss',  //5
                                 'dd/nn/## hh:nn:ss',           //6
                                 'dd/nn/## hh:nn',              //7
                                 'dd/nn/#### hh:nn:ss'          //9
                                ])
      of
       0 : result := TMask.Mask_yy_mm_dd ;
       1 : result := TMask.Mask_dd_mm_yy;
       2 : result := TMask.Mask_yyyy_mm_dd;
       3 : result := TMask.Mask_dd_mm_yyyy;
       4 : result := TMask.Mask_dd_mm_yyyy_hh_nn;//TMask.Mask_mm_yy;
       5 : result := TMask.Mask_mm_yyyy;
       6 : result := TMask.Mask_Extenco;
       7 : result := TMask.Mask_dd_mm_yy_hh_nn_ss;
       8 : result := TMask.Mask_dd_mm_yy_hh_nn;
       9 : result := TMask.Mask_dd_mm_yyyy_hh_nn_ss;
       else Result := TMask.Mask_Invalid;
     end;

  end;

  class function TObjectsMethods.isDateTime(const aTemplate: AnsiString): Boolean;
  begin
    result := MaskEdit_to_Mask(aTemplate) <> TMask.Mask_Invalid ;
  end;


  class function TObjectsMethods.TypeFld(const aTemplate: tString;var aSize: SmallWord): AnsiChar;
      Var
        I,j : Byte;
    Begin
      If IsDateTime(aTemplate)
      Then Begin
             aSize := sizeof(TDateTime);
             Result := FldDateTime;
           end
      else Begin
              For i := 1 to length(aTemplate) do
              {$REGION '--->'}
                If Not (aTemplate[i] in [' ','z','Z',#0]) //Carateres de formatazao e separacao de campos
                Then
                Case aTemplate[i] of
                  fldSTRNUM,
                  fldSTR_Lowcase,
                  fldSTR             : Begin
                                         aSize := 1;
                                         For j := 1 to Length(aTemplate) do
                                           If  aTemplate[j] in [fldSTRNUM,fldSTR_Lowcase,fldSTR]
                                           then Inc(aSize);

                                         Result := aTemplate[i];
                                         Exit;
                                       End;

                  fldAnsiChar,
                  fldAnsiChar_Lowcase,
                  fldAnsiCharNUM,{<'o'. Obs: O "o" minusculo e usado para real Positivo}
                  fldAnsiCharVAL        : Begin
                                         aSize := 0;
                                         For j := 1 to Length(aTemplate) do
                                           If  aTemplate[j] in [fldAnsiChar,fldAnsiChar_Lowcase,fldAnsiCharNUM,fldAnsiCharVAL]
                                           then Inc(aSize);

                                         Result := aTemplate[i];
                                         Exit;
                                       End;
                  
                  FldOperador,                 
                  ^X,  {<Boolean Especial}
                  fldBOOLEAN,

                  fldBYTE,
                  fldSHORTINT        : Begin
                                         aSize := Sizeof(byte);
                                         Result := aTemplate[i];
                                         Exit;
                                       End;

                  fldSmallWORD       : Begin
                                         aSize := Sizeof(SmallWord);
                                         Result := aTemplate[i];
                                         Exit;
                                       End;
                  fldSmallInt        : Begin
                                         aSize := Sizeof(SmallInt);
                                         Result := aTemplate[i]; Exit;
                                       End;
                  CharExecAction,
                  fldAPPEND   ,
                  fldSItems   ,

                  FldDateTime,
                  fldLHora,
                  fld_LHora
                                      : Begin
                                         aSize := Sizeof(TDateTime);
                                         Result := aTemplate[i];
                                         Exit;
                                       End;
                  fldENum,fldENum_db,
                  fldLONGINT         : Begin
                                         aSize := Sizeof(Longint);
                                         Result := aTemplate[i];
                                         Exit;
                                       End;

                  fldRealNum,
                  fldRealNum_Positivo
                                     : Begin
                                         aSize := Sizeof(TRealNum);
                                         Result := aTemplate[i]; Exit;
                                       End;

                  fldReal4,
                  fldReal4Positivo,
                  fldReal4P,
                  fldReal4PPositivo  : Begin
                                         aSize := Sizeof(Real);
                                         Result := aTemplate[i]; Exit;
                                       End;
                  fldExtended        : Begin
                                         aSize := Sizeof(Extended);
                                         Result := aTemplate[i]; Exit;
                                       End;


                  FldRadioButton
                  {fldCheckBox,FldRadioButton}       : Begin
                                         aSize := Sizeof(Byte);
                                         Result := aTemplate[i]; Exit;
                                       end;
                  FldMemo,
                  fldBLOb            : Begin
                                         Move(aTemplate[i+1]  ,aSize, sizeof(Integer));
                                         Result := aTemplate[i];
                                         Exit;
                                       End;


                  CharShowPassword,
//                  fldXSPACES  ,
                  fldZEROMOD         ,
                  fldCONTRACTION     ,

            {      fldXTABTO          , Obs: Este tipo esta igual a fldSItems}

//                  fldXFieldNUM       ,

                  fldHexValue        {<O HexValue nao entendi o seu tamanho???}
                                     : Begin
                                         aSize := 0;
                                         Result := aTemplate[i];
                                         Exit;
                                       end;
                End; //<  for;
                Result := #0; {<Tipo indefinido}
             {$ENDREGION}
           End; //<  If Not If_FldDateTime Then Begin.
  end;

    class function TObjectsMethods.TypeFld(const aTemplate: tString): AnsiChar;
    Var aSize : SmallWord;
  Begin
    Result := TypeFld(aTemplate,aSize);
  end;

  class function TObjectsMethods.IStr(const I: Longint; const Formato: tString
      ): tString;
    Var IAux : tString;
        Tam  : Longint;
  Begin
    system.Str(I:0,Iaux);
    Tam := length(formato)-length(IAux);
    If Tam > 0
    Then IStr := ConstStr(Tam,'0') + IAux
    Else IStr := IAux;
  End;

  class function TObjectsMethods.IStr(const I: Longint): tString;
  Begin
    system.Str(I:0,Result);
  End;

  class function TObjectsMethods.IStr(const I: tString; const Formato: tString): tString;
  Begin
    Result := I;
    While (Pos(' ',Result )<>0) and (Length(Result)>0)
    do delete(Result,Pos(' ',Result ),1);

    While Length(Result) < Length(Formato)
    do Insert('0',Result,1);
  end;


  class function TObjectsMethods.StrNum(formato: AnsiString;buffer: Variant; const Tipo: AnsiChar; const OkSpc: Boolean): AnsiString;

        procedure divide (var  PI,PF,Npontos:Byte);

          {Formato: RRR,RRR,RRR,RRR.RR}
          {Formato: EEE,EEE,EEE,EEE.EE}

          Var PosVirgula,i : Byte;
        begin
          PI :=  0;
          PF :=  0;
          NPontos := 0;

          For i := 1 to length(Formato) do
            If Formato[i] = ShowThousandSeparator//','{'.'}
            Then Inc(NPontos);

          PosVirgula := pos(ShowDecimalSeparator ,Formato);//'.' {','}
          If PosVirgula <> 0
          Then Begin
                 PI := PosVirgula - NPontos - 1;

                 For i := PosVirgula to length(Formato) do
                   If UpCase(Formato[i]) in [fldExtended,fldReal4,fldReal4P,fldRealNum,
                                             fldRealNum_Positivo,fldReal4Positivo,
                                             fldReal4PPositivo,fldZEROMOD]
                   Then inc(PF);
               End
          Else Begin
                 PI := length(Formato)-NPontos;
               end
        end;

      {Formato: RRR,RRR,RRR,RRR.RR}
      {Formato: EEE,EEE,EEE,EEE.EE}
    Var
      PiF,PfF,Pontos:Byte;
      valorExtended : Extended;

  Begin
    Try
      divide(PIF,PFF,Pontos) ;
      case Tipo of
        fldReal4,
        fldReal4P,
        fldExtended,// : str(Extended(Buffer):PIF:PFF,Result);
        fldRealNum,
        fldRealNum_Positivo :
           begin
            valorExtended := Buffer;
            //system.str(valorExtended:PIF:PFF,Result); //A função str não obdece o parâmetro DefaultFormatSettings.DecimalSeparator
            //Result := FloatToStrf(valorExtended,ffGeneral,PIF,PFF);
//            Result := FloatToStrf(valorExtended,ffNumber,PIF,PFF);
            Result := FloatToStrf(valorExtended,ffFixed,PIF,PFF);
           end;

        fldBYTE       : system.Str(Byte(Buffer):PIF,Result);

        fldSHORTINT   : system.Str(SHORTINT(Buffer):PIF,Result);
        fldSmallInt   : system.Str(SmallInt(Buffer):PIF,Result);

        {fldWORD}
        FldSmallWord  : system.Str(SmallWord(Buffer):PIF,Result);
        
        fldENum,
        fldENum_db    : system.Str(LongInt(Buffer):PIF,Result);
        fldLONGINT    : system.Str(Longint(Buffer):PIF,Result);


        else Begin
               Push_MsgErro('Error em: Function StrNum(formato : AnsiString;Var buffer; Const Tipo : AnsiChar) : AnsiString;');
               RunError(ParametroInvalido);
             End;
      end; { case }

      while (length(Result)>0) and (Result[1] = ' ')
      do Delete(Result,1,1);

  //    If Buffer = '-'
  //      If Buffer < 0
  //      Then Result := '-'+Result;

      //If (PFF <> 0) and OkSpc {OkSpc foi implementado em tempo diferente do projeto inicial}
      //Then Result[Pos(DecimalSeparator ,Result)] := showDecimalSeparator {','};

    Except
      LogError(TStrError.ErrorMessage8('',UnitName,ClassName,'StrNum','','','Erro_Excecao_inesperada',''));
      raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.objects.Methods','TObjectsMethods','StrNum',Erro_Excecao_inesperada));
    end;
  End;

  class function TObjectsMethods.StrNum(formato: AnsiString; buffer: Variant;const Tipo: AnsiChar): AnsiString;
  Begin
    Result := StrNum(formato,buffer,Tipo,true {True mantem a compatibilidade com passado porque okSpc foi criado depois de StrNum ter sido usado.});
  end;

  class function TObjectsMethods.IIF(const Logica: Boolean; const E1,E2: Boolean): Boolean;
  Begin
     If Logica Then result := E1 Else result := E2;
  End;

  class function TObjectsMethods.IIF(const Logica: Boolean; const E1,E2: AnsiChar): AnsiChar;
  Begin
     If Logica Then result := E1 Else result := E2;
  End;

  class function TObjectsMethods.IIF(const Logica: Boolean; const E1,E2: Longint): Longint;
  Begin
     If Logica Then IIF := E1 Else IIF := E2;
  End;

  class function TObjectsMethods.IIF(const Logica: Boolean; const E1,E2: Extended): Extended;
  Begin
    If Logica Then result := E1 Else result := E2;
  End;

  class function TObjectsMethods.IIF(const Logica: Boolean; const E1,E2: AnsiString): AnsiString;
  Begin
     If Logica Then Result := E1 Else Result := E2;
  End;

  class function TObjectsMethods.IIF<T>(const Logica: Boolean; const E1, E2: T): T;
  begin
    if Logica
    then Result := E1
    else Result := E2;
  end;
  class function TObjectsMethods.SIF(const Logica: Boolean; const E1,
      E2: AnsiString): AnsiString;
  Begin
    If Logica Then Result := E1 Else Result := E2;
  End;



  class function TObjectsMethods.MinL(const a, b: Longint): Longint;
  Begin
    result := IIF(b < a , b , a );
  End;

  class function TObjectsMethods.MaxL(const a, b: Longint): Longint;
  Begin
    result := IIF(b > a , b , a );
  End;


    class function TObjectsMethods.NumToStr(const formato: AnsiString;
    const buffer: Variant; const Tipo: AnsiChar; const OkSpc: Boolean
    ): AnsiString;
   //Formato   RRR,RRR,RRR,RRR.RR

  var
    Sinal : AnsiChar;
    i,j,Len,Pos_Z   : SmallInt;

  begin
    Result := StrNum(formato,buffer,tipo,OkSpc);

    If Pos('-',Result) <> 0
    Then Begin
           Sinal := '-';
           Delete(Result,Pos('-',Result),1)
         end
    Else Sinal := '+';

    j := length(Result);
    for i :=  length(formato) downto 1 do
    begin
      If Formato[i] = ShowThousandSeparator {',''.'}
      Then Insert(ShowThousandSeparator,Result,j+1)
      else Begin
             Dec(j);
             If J <= 0
             Then break;{i := 1;}
           End;
    End;

    Pos_Z := Pos('Z',Formato);
    If Pos_z = 0 Then Pos_Z := Pos('z',Formato);
    If (Pos_Z <>0) and (Pos_Z < Pos(ShowDecimalSeparator {'.'},Formato))
    Then Begin
           If length(Formato) - length(Result) <0
           Then Len := 0
           Else len := length(Formato) - length(Result);
           Result := ConstStr(Len,'0')+Result;
         end;

    If SinalDireita
    Then Begin
           If Sinal = '-'
           Then Result := Result + Sinal
           Else If SinalDeMaisAtivo
                Then Result := Result + '+'
                Else Result := Result + ' ';
         End
    Else If Sinal = '-' Then Result := Sinal + Result;

    If OkSpc Then
    Begin
      Len := length(Formato)-length(Result);
      If Len > 0
      Then Result := constStr(Len,' ')+Result
      Else Result := Copy(Result,1,MinL(length(Formato),length(Result)));
    End;

  {  NumToStr:= Result;}
  end ;

  class function TObjectsMethods.InsertCrtlJ(const StrMsg: tString): tString;
  Var
    aStrMsg  : tString;
    i,MaxCol : Byte;
  Begin
    aStrMsg := '';
    MaxCol  := 0;
    for i := 1 to length(StrMsg) do
    Begin
      if (strMsg[i] = ^M) or (MaxCol > 50) Then
      Begin
        If (strMsg[i] = ^M)  Then
        Begin
          aStrMsg := aStrMsg + StrMsg[i]+^J;
          Inc(MaxCol);
        end
        else  {A Mensagem esta > que 70}
          aStrMsg := aStrMsg + StrMsg[i]+^M+^J;
        MaxCol := 0;
      end
      Else
      Begin
        aStrMsg := aStrMsg + StrMsg[i];
        Inc(MaxCol);
      end;
    End;
    aStrMsg := aStrMsg+^J;
    InsertCrtlJ := aStrMsg;
  End;

  class procedure TObjectsMethods.Create_Progress1Passo(ATitle: tstring;
      Obs: tstring; ATotal: Longint);
  Begin
    Discard(TObject(_Progress1Passo)); {Descarta se tiver pendente}

    If ErrorInfo <> 0
    Then _Progress1Passo := TProgressDlg_If.Create(ATitle,TStrError.ErrorMessage(ErrorInfo),Delta_Locate,ATotal)
    Else _Progress1Passo := TProgressDlg_If.Create(ATitle,Obs ,Delta_Locate,ATotal);
  end;

        class procedure TObjectsMethods.Set_Progress1Passo(aNumber: Longint);
  Begin
    If _Progress1Passo <> nil
    Then _Progress1Passo.IncPosition(aNumber);
  end;

        class procedure TObjectsMethods.Destroy_Progress1Passo;
  Begin
    Discard(TObject(_Progress1Passo)); {Descarta se tiver pendente}
  end;

        class procedure TObjectsMethods.LogError(const Fmt: String;
      Args: array of const);
  begin
     if Logs<> nil
     then Logs.LogError(Fmt,Args)
     else raise Exception.Create('A constante TObjectss.Logs não inicializada!');
  end;

  class procedure TObjectsMethods.LogError(const Msg: AnsiString);
  begin
   if Logs<> nil
   then Logs.LogError(Msg)
   else raise Exception.Create('A constante TObjectss.Logs não inicializada!');
  end;

  //class procedure TObjectsMethods.Push_MsgErro(Const Str: AnsiString);
  //begin
  //  inherited Push_MsgErro(Str);
  //  LogError(str);
  //end;


  ///<summary>
  ///  :Converts Unicode string to Ansi string using specified code page.
  ///  <  @param   ws       Unicode string.
  ///  <  @param   codePage Code page to be used in conversion.
  ///  <  @returns Converted Ansi string.
  ///</summary>

  class function TObjectsMethods.WideStringToString(const ws: WideString    ): AnsiString;
  //var
  //  l: integer;
  //  codePage: Word;
  begin
    result := ws;

    //  CodePage := GetConsoleCP;
    //  if ws = '' then
    //    Result := ''
    //  else
    //  begin
    //    l := WideCharToMultiByte(codePage,
    //      WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
    //      @ws[1], - 1, nil, 0, nil, nil);
    //    SetLength(Result, l - 1);
    //    if l > 1 then
    //      WideCharToMultiByte(codePage,
    //        WC_COMPOSITECHECK or WC_DISCARDNS or WC_SEPCHARS or WC_DEFAULTCHAR,
    //        @ws[1], - 1, @Result[1], l - 1, nil, nil);
    //  end;
  end; { WideStringToString }



  class function TObjectsMethods.Set_FileModeDenyALL(      const ModoDoArquivo: Boolean): Boolean;
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

    class function TObjectsMethods.Set_FileModeDenyALLSalvaAnt(const ModoDoArquivo: Boolean; var _FileModeDenyALLAnt: Boolean): Boolean;
    Begin
      _FileModeDenyALLAnt        := FileModeDenyALL;
      Set_FileModeDenyALLSalvaAnt := Set_FileModeDenyALL(ModoDoArquivo);
    End;

  {$REGION '---> SItems_MsgErro'}

    class function TObjectsMethods.Sitems_MsgErro: PSItem;
    Begin
       Result := ListaDeMsgErro ;
    end;


    class function TObjectsMethods.Pop_MsgErro: PSItem;
    begin
      PopSItem(ListaDeMsgErro);
      Result := ListaDeMsgErro;
    end;

    class function TObjectsMethods.SpcStrD(const campo: tString;const Tam: Byte): tString;
      {<
      ==========================================================
             *** SpcStrD ***
          devolve uma tString alinhada pela direita
      ==========================================================
      }
      Var Len : SmallInt;
    begin
      Len := Tam-length(campo);
      If Len > 0
      Then result  := constStr(Len,' ')+campo
      Else result  := Copy(Campo,1,MinL(Tam,length(campo)));
    end;

    class function TObjectsMethods.CentralizaStr(const campo: AnsiString; const tamanho: Integer): AnsiString;
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

    class function TObjectsMethods.spc(const campo: AnsiString;const tam: Longint): AnsiString;
    begin
      {Result := '';}
      if Length(campo) < tam
      then Result := Campo + ConstStr(tam-Length(campo),' ')
      else Result := Copy(Campo,1,Tam);
    end;

    class function TObjectsMethods.NumberCharControl(s: AnsiString): Integer;
      var
        i : Integer;
    begin
      result := 0;
      if s<>''
      then For i := 1 to length(s) do
           begin
             if s[i] in [#0..#31,'\','|','~',fldCONTRACTION]
             then result := result +1;
           end;
    end;

    class function TObjectsMethods.StrAlinhado(aStrMsg: tString;Colunas: byte; const Alinhamento: TAlinhamento): tString;
    Begin
      While (aStrMsg<>'')  and (aStrMsg[1] = ' ')  do
        Delete(aStrMsg,1,1);

      While (aStrMsg<>'') and (aStrMsg[length(aStrMsg)] = ' ')  do
        Delete(aStrMsg,length(aStrMsg),1);

      Case Alinhamento of
        Alinhamento_Direita  : result := SpcStrD(aStrMsg,Colunas);
        Alinhamento_Central  : result := CentralizaStr(aStrMsg,Colunas);
        Alinhamento_Esquerda : result := Spc(aStrMsg,Colunas);
        else Begin
               Result := aStrMsg;
             End;
      End;
    End;

    class function TObjectsMethods.StringToSItem( StrMsg: AnsiString; Alinhamento: TAlinhamento): PSItem;

        function GetTamCol:Integer;
          var
            i,posAnt,tamLinha : Integer;
            s : string;
        begin
          result := 0;
          posAnt := 0;
          i      := 1;
          while i <= length(StrMsg) do
          begin
            case StrMsg[i] of
             fldENum,
             fldENum_db: begin

                          {$IFDEF CPU32} {$Region cpu32}
                            inc(i,7);
                          {$ENDIF} {$EndRegion cpu32}

                          {$IFDEF CPU64} {$Region cpu64}
                            inc(i,11);
                          {$ENDIF} {$EndRegion cpu64}
                          inc(i);
                          s := system.copy(StrMsg,posAnt,i-posAnt);
                          tamLinha := length(s);
                          result := maxL(result,tamLinha) ;
                          posAnt := i;

                        end;
            ^M : begin
                   s := system.copy(StrMsg,posAnt,i-posAnt);
                   tamLinha := length(s);
                   result := maxL(result,tamLinha) ;
                   posAnt := i;
                 end;

            end;
            inc(i);
          end;

          if result = 0
          Then result := length(StrMsg);
        end;

      Var
        List      : TMiStringList;
        i,TamCol  : Integer;
        s         : AnsiString;

    begin
      List :=  TMiStringList.Create;//<Insere a tString em ordem sequencial
      s    := '';
      TamCol := GetTamCol;
      for i := 1 to Length(StrMsg) do
      begin
        case StrMsg[i] of
          ^M,^Z,^J : begin
                       s := StrAlinhado(s,TamCol,Alinhamento)+constStr(NumberCharControl(s),#0);
                       List.Add(s);
                       s := '';
                     end;
          else begin
                 S := s + StrMsg[i];
               end;
        end;
      end;

      if s<>''
      Then begin
             s := StrAlinhado(s,TamCol,Alinhamento)+constStr(NumberCharControl(s),#0);
             List.Add(s);
           end;

      result := List.PListSItem;
    end;


    class function TObjectsMethods.StringToSItem(StrMsg: AnsiString): PSItem;
    begin
      result := StringToSItem(StrMsg,Alinhamento_Justificado);
    end;

    class function TObjectsMethods.SItemsLen(S: PSItem): SmallInt;var  Len : integer;
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

    class function TObjectsMethods.SItemToString(Items: PSItem): AnsiString;
       Var
         Len : Longint;
    Begin
      Result := '';
      Len := SItemsLen(Items);
      If (Len > 0) then
        While (Items <> nil) do
        begin
          If (Items.Value <> nil) then
              begin
                Result := Result + Items.Value^+^M;
              end;
          Items := Items.Next;
        end;
    end;

    {: A classe procedure **@name** retorna um TMiStringList com a lista passado por items

       - **NOTA**
         - S : Deve ser passado não inicializado, ouseja deve ser NIL.
    }
    class procedure TObjectsMethods.WriteSItems(var S: TMiStringList;const Items: PSItem);
      var
        P : PSItem;
      begin
        If (S = nil) And (Items<>nil) Then
        Begin
          S :=  TMiStringList.Create;{<Insere a tString em ordem sequencial}
          s.sorted := False;

          P := Items;
          While (P <> nil) do
          begin
            If P.Value <> nil
            Then S.NewStr(P.Value^);
            P := P.Next;
          end;
        End;
    end;

    class function TObjectsMethods.PSItem_ListaDeMsgErro: PSItem;
        Var
          S1 : TMiStringList;
           L : Integer;
      Begin
        Try
          L := 0;
          If (ListaDeMsgErro <> nil)  Then
          Begin
            S1     := nil;
            While (ListaDeMsgErro <> nil)   do
            Begin
                inc(L);
                if L > 20
                then CtrlSleep(0);

                IF  (ListaDeMsgErro<>nil) and (ListaDeMsgErro^.Value<>NIL)
                THEN BEGIN
                        Result := StringToSItem(ListaDeMsgErro^.Value^,Alinhamento_Esquerda);
                        If S1 = nil
                        Then WriteSItems(S1,Result )
                        Else S1.AddSItem(Result);
                        PopSItem(ListaDeMsgErro);
                     END
                Else PopSItem(ListaDeMsgErro);
            End; //while

            If S1 <> nil
            Then Begin
      //              If ListaDeChamadas <> nil
      //              Then Begin
      //                      S1.AddSItem(CopySItems(ListaDeChamadas));
      //                   End;

                   Result := S1.PListSItem;
                   S1.Destroy;
                 end
            Else Result := nil;
          end
          Else Result := nil;

        finally
        end;
      end;


    var
      MessageError_reintrance :Boolean = False;
    class procedure TObjectsMethods.MessageError;
      {Este procedimento imprime a sequência de mesagems de erro}
       Var
         I               : Integer;
         Wok             : Boolean;
         S               : AnsiString;
    Begin
      If MessageBoxOff or (Self = nil)
      then exit;

      try
        Wok := ok;
        If (Not Get_ok_Set_Transaction)
//            and(Not ok_Set_Server_Http)
           and (not MessageError_reintrance)
        Then Begin
               Try
                 MessageError_reintrance := true;
                  If (ListaDeMsgErro <>  nil) and Assigned(_MI_MsgBox) Then
                  with _MI_MsgBox do
                  Begin
                    s := SitemToString(ListaDeMsgErro);
                    if s <> ''
                    then begin
                           LogError(s);
                           MessageBox(s,mtWarning,mbOkButton,MbOk);
                         end;

                    DisposeSItems(ListaDeMsgErro);
                  End;

               Finally
                 MessageError_reintrance := false;
               End;
            End;

      finally
        ok := wok;
      end;

    End;


    class function TObjectsMethods.String_ListaDeMsgErro(Separador: String): AnsiString;
      Var
        SItem:PSItem;
        L : Integer;
    Begin
      Result := '';
      L := 0;
      SItem := ListaDeMsgErro;
      While SItem <> nil do
      Begin
        inc(L);
        if L > 20
        then CtrlSleep(0);

        Result := Result + SItem.Value^+Separador;
        SItem := SItem.Next;
      end;
      DisposeSItems(SItem);

      if Result = ''
      then Result := 'ATENÇÃO: Mensagem de erro não encontrada!';

    end;


    {: A procedure **@name** esvazia a pilha de mensagens de error caso as mensagen não tenhão sido tratadas antes de encerrar TMI_Application.
    }
    class procedure TObjectsMethods.Dispose_ListaDeMsgErro;
      Var
        I : SmallInt;
        P : PSItem;
    Begin
      P := Pop_MsgErro;
      if P <>nil
      then with logs do
           Begin
              WriteLnFErr(' ' );
              WriteLnFErr(    '===============================================================================');
             //if Self.ParamExecucao<>nil
             //then begin
             // WriteLnFErr(    'ID Filial......: ' +intToStr(Self.ParamExecucao.Identificacao.Filial));
             // WriteLnFErr(sgc('Razão Social...: ')+Self.ParamExecucao.Identificacao.RazaoSocial);
             // WriteLnFErr(sgc('Usuário logado.: ')+Self.ParamExecucao.Identificacao.Nome_Compreto_do_Usuario);
             // WriteLnFErr(    'Pasta Raiz.....: ' +Self.ParamExecucao.PathRaiz);
             //end;

//              WriteLnFErr('Data e hora....: ' +GetDateSystem(DateMask_DD_MM_AAAA)+ ' - '+GetHourSystem(HourMask_HH_MM_SS_S100));
//              WriteLnFErr('Módulo.........: '+Alias);

              WriteLnFErr('===================================================================================');

              While IsValidPtr(P) do
              Begin
                 //Deve escrever em arquivo pois os erros não forão tratados antes de detruir  a classe
                 if WriteLnFErr(p.Value^)<>0
                 then Break;

                 P := Pop_MsgErro;
              End;
              WriteLnFErr('=============================================================');
           End;
    end;


  {$ENDREGION}

  class function TObjectsMethods.UpperCase(str: AnsiString): AnsiString;
  begin
//    Result := Str;
    Result := SysUtils.UpperCase(Str);
  end;

  class function TObjectsMethods.Lowcase(str: AnsiString): AnsiString;
  begin
    result :=  SysUtils.LowerCase(str);
  end;

  class function TObjectsMethods.AnsiString_to_USASCII(const pText: string): string;
    //Exemplo completo: https://showdelphi.com.br/dica-funcao-para-remover-acentos-de-uma-string-Delphi/
  type
    USAscii20127 = type AnsiString(20127);
  begin
    Result := string(USAscii20127(pText));
  end  ;

  class function TObjectsMethods.RemoveAccents(const str: String): String;
    const
      AccentedChars : array[0..25] of string = ('á','à','ã','â','ä','é','è','ê','ë','í','ì','ï','î','ó','ò','õ','ô','ö','ú','ù','ü','û','ç','ñ','ý','ÿ');
      NormalChars   : array[0..25] of string = ('a','a','a','a','a','e','e','e','e','i','i','i','i','o','o','o','o','o','u','u','u','u','c','n','y','y');
    var
      i: Integer;
  begin
    Result := str;
    for i := 0 to 25 do
      Result := StringReplace(Result, AccentedChars[i], NormalChars[i], [rfReplaceAll]);
  end;

  class function TObjectsMethods.SGI(const S: String): String;
    {<
     Convert os caracteres acentuados para codigos ASC equivalente em Ingles;
    }
    Var
      Index,I,len : integer;
      ws : AnsiString;
  Begin
    i := 1;
    len := Length(S);
    Result := '';
    while i <= len do
    Begin
      If S[i] >= #127
      Then Begin
             ws := s[i]+s[i+1];
             Index := List_Class_Of_Char.IndexOf(ws);
             If Index >= 0
             Then Begin
                    Result := Result + TClass_Of_Char( List_Class_Of_Char.Objects[Index]).Asc_Ingles;
                  End
             Else Result := Result + ws;
             inc(i,2);
           End
      Else begin
             Result := Result + S[i];
             inc(i);
           end;
    End;

  End;

        class function TObjectsMethods.String_Asc_GUI_to_Asc_Ingles(const S: String
      ): String;
  Begin
    Result := sgi(S);
  end;


        class function TObjectsMethods.String_Asc_GUI_to_Asc_HTML(const S: String
      ): String;
    {<
     Convert os caracteres acentuados para codigos ASC equivalente em html;
    }
    Var
      Index,I,len : integer;
      ws : AnsiString;
  Begin
    i := 1;
    len := Length(S);
    Result := '';
    while i <= len do
    Begin
      If S[i] >= #127
      Then Begin
             ws := s[i]+s[i+1];
             Index := List_Class_Of_Char.IndexOf(ws);
             If Index >= 0
             Then Begin
                    Result := Result + TClass_Of_Char( List_Class_Of_Char.Objects[Index]).Asc_html;
                  End
             Else Result := Result + ws;
             inc(i,2);
           End
      Else begin
             Result := Result + S[i];
             inc(i);
           end;
    End;

  End;

        class function TObjectsMethods.SGH(const S: String): String;
  Begin
    Result := String_Asc_GUI_to_Asc_HTML(S);
  end;

  class function TObjectsMethods.Get_List_Class_Of_Char: TMiStringList;
   {
    Retorna uma a lista de fontes usando a chave font GUI.
   }
   VAR
     I : Integer;
  Begin
  {Inicializa a tabela de caracter}
    Result := TMiStringList.Create;
    With Result do
    Begin
      OkDestroy_Object := true;
      Sorted           := true;
      CaseSensitive    := true;
      i:=0;
      For i := 0 to high(Array_Of_Char)-1 do
      With Array_Of_Char[i] do
      begin
        AddObject(Asc_Gui,TClass_Of_Char.Create(Asc_Ingles,Asc_GUI,Asc_HTML));{<a Minuscolo com agudo}
      end;
    End;
  End;

  class function TObjectsMethods.Get_List_Class_Of_Char_GUI: TMiStringList;
   {
    Retorna uma a lista de fontes usando a chave font GUI.
   }
   VAR
     I : Integer;
  Begin
  {Inicializa a tabela de caracter}
    Result := TMIStringList.Create;
    With Result do
    Begin
      OkDestroy_Object := true;
      Sorted           := true;
      CaseSensitive    := true;

      For i := 0 to high(Array_Of_Char)-1 do
      With Array_Of_Char[i] do
      begin
        AddObject(Asc_GUI,TClass_Of_Char.Create(Asc_Ingles,Asc_GUI,Asc_HTML));{<a Minuscolo com agudo}
      end;
    End;
  End;

    class procedure TObjectsMethods.Show_GetEnv_System;
    var
      i : integer;
      s : AnsiString;
  begin
     s:= '';
    for i := 0 to EnvCount do
    begin
      s := s + EnvStr(i)+lf;
    end;

    If Assigned(_MI_MsgBox)
    Then with _MI_MsgBox do
         begin
            MessageBox(s,
                       mtInformation,
                       mbOKButton,
                        mbOk
                        );
         end
  end;

  class function TObjectsMethods.FGetMem(var Buff; const TamBuff: Word   ): Boolean;
  Begin
    try

      if TamBuff >0
      then GetMem(Pointer(Buff),TamBuff)
      else Pointer(Buff) := nil;

      If Pointer(Buff) <> Nil Then
      Begin
        If OkZeraFGetMem
        Then FillChar(Pointer(Buff)^,TamBuff,0);
        Result := True;
      End
      else Result := false;

    Except
      Result := false;
    End;
  End;

  class procedure TObjectsMethods.FFreeMem(var Buff; const TamBuff: Word);
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

  class function TObjectsMethods.CGetMem(const BuffOriginal: Pointer;   const TamBuff: Word): Pointer;
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

  class function TObjectsMethods.isfileopen(var f: file): boolean;
  begin
    Result  := (FILEREC (F ).MODE = System.FmInOut )  OR
               (FILEREC (F ).MODE = System.FmOutput ) OR
               (FILEREC (F ).MODE = System.FmInput )  ;
  end;

    class function TObjectsMethods.isfileopen(var f: text): boolean;
  begin
    Result := (TextRec(F).MODE = System.FmInOut )  OR
              (TextRec(F).MODE = System.FmOutput ) OR
              (TextRec(F).MODE = System.FmInput );
  end;

  class function TObjectsMethods.CloseLst: SmallInt;
  Begin
    If IsFileOpen(Lst)
    Then Begin
            Try
              Try
                {$I-}
                Close(lst);
                 {$I+}

              Finally
                TaStatus := IoResult;
                TextRec(Lst ).MODE := fmClosed;
                Result   := TaStatus;
              End;

            Except
            End;
         End
    Else CloseLst   := 0;
  End;

  class procedure TObjectsMethods.RedirecionaParaImpressora;
    {$I-}
  Begin
    CloseLst;
    opcaoRedireciona      := 'I';
    redirecionaImpressora := False;
    redirecionaImpNul     := False;
    TaStatus              := IoResult;
    AssignFile(lst,PortaDaImpressora);
    System.rewrite(lst);
    TaStatus := IoResult;
    If TaStatus <> 0 Then
    Repeat
      If Assigned(_MI_MsgBox)
      Then with _MI_MsgBox do
           begin
              MessageBox('Impressora Error',
                         'A impressora não está pronta!.'+^M,
//                         'Ajuste a impressora e tecle OK para continuar.',
                          mtError,
                          mbOKButton,
                          mbOk
                          );
           end
      Else
      Begin
        WriteLn(TStrError.ErrorMessage(TaStatus));
       raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl',
                                                               'mi.rtl.objects.Methods',
                                                               'TObjectsMethods','RedirecionaParaImpressora',
                                                               ErroDeEscritaNoDispositivoDeSaidaImpressora ));
      End;

      System.rewrite(lst);
      TaStatus := IoResult;
    Until TaStatus = 0;
  End;

  class procedure TObjectsMethods.RedirecionaRelatorio;
  begin
    abstracts;
  end;


  class function TObjectsMethods.ChangeSubStr(aSubStrOld: AnsiString;    aSubStrNew: AnsiString; S: AnsiString): AnsiString;
//
//    Var
//      Pos1,Pos2  : Integer;
  Begin
    //Pos1 := Pos(UpperCase(aSubStrOld),UpperCase(S));
    //If Pos1 <> 0
    //Then begin
    //       if Pos1-1>0
    //       then Result := Copy(S,1,Pos1-1)
    //                    + aSubStrNew
    //                    + Copy(S,Pos1+Length(aSubStrOld),Length(s)-Pos1+Length(aSubStrOld) +1)
    //       Else Result :=
    //                      aSubStrNew
    //                    + Copy(S,Pos1+Length(aSubStrOld),Length(s)-Pos1+Length(aSubStrOld) +1);
    //
    //       // troca todas recursivamente
    //       result := ChangeSubStr(aSubStrOld, aSubStrNew,result);
    //    end
    //Else Result := S;
    result := StringReplace(s, aSubStrOld  , aSubStrNew , [rfReplaceAll])
  end;

  class function TObjectsMethods.Alias_To_Name(AAlias: AnsiString     ): AnsiString;
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

   Result := String_Asc_gui_to_Asc_Ingles(AALias);

    For I := 1 to length(Result) do
    If Not (Result[i] in  AlphaNumeric)
    Then  Result[i] := '_';
  end;

  {: A class método **@name** cria um novo valor de GUID (Globally Unique Identifier).

     - **RETORNA**
       - **GUID**    : Novo GUID se sucesso ou string vazia se fracasso.
  }
  class function TObjectsMethods.CreateGUID: TString;
    var
      GUID : TGuid;
      err: integer;
  begin
    err := SysUtils.CreateGUID( GUID);
    if err = 0
    then result := GUIDToString(GUID)
    else begin
           result := '';
           SetLastError(err);
         end;
  end;


  class function TObjectsMethods.SetExecAsync(aExecAsync: Byte): Byte;
  //Retorna o estado anterior;
  Begin
    Result := ExecAsync;
    ExecAsync := aExecAsync;
  end;

        class function TObjectsMethods.GetExecAsync: Byte;       //Retorna o valor de ExecAsync
  begin
    Result := ExecAsync;
  end;

  class function TObjectsMethods.ShellExecute(const lpOperation, FileName,
                      Params, DefaultDir: AnsiString; ShowCmd: Integer): THandle;
    (*
      SysShellExecute('Z:\GCIC\GCIC_Vcl.exe',{FileName}
                      ''{Params},
                      'z:\GCIC\DataBase_Template\Industria_de_software\' {DefaultDir} ,
                      SW_NORMAL)  ;
    *)
       {
        Type TProcessOption = (
          poRunSuspended ,   // Inicie o processo no estado suspenso.
          poWaitOnExit ,     // Aguarde o processo terminar antes de retornar.
          poUsePipes ,       //Use pipes para redirecionar a entrada e a saída padrão.
          postderrToOutPut , //Redirecione o erro padrão para o fluxo de saída padrão.
          poNoConsole ,      //Não permitir acesso à janela do console para o processo (somente Win32)
          poNewConsole ,     //Inicie uma nova janela de console para o processo (somente Win32)
          poDefaultErrorMode , //Use o tratamento de erros padrão.
          poNewProcessGroup ,  //Inicie o processo em um novo grupo de processos (somente Win32)
          poDebugProcess ,     //Permitir a depuração do processo (somente Win32)
          poDebugOnlyThisProcess, //Não siga os processos iniciados por este processo (somente Win32)
          poDesanexado , //Executa um processo usando o sinalizador de criação DETACHED_PROCESS no Windows
          poPassInput ,  //Passe o identificador de entrada padrão para o novo processo
          poRunIdle      // Sinaliza um manipulador de eventos para aguardar a saída no loop de execução de um processo.
        );

      }

      {
        Type TShowWindowOptions = (
          swoNone , //Permitir que o sistema posicione a janela.
          swoHIDE , //A janela principal está oculta.
          swoMaximize , //A janela principal é maximizada.
          swoMinimizar ,//A janela principal é minimizada.
          swoRestaurar ,//Restaure a posição anterior.
          swoShow , //Mostra a janela principal.
          swoShowDefault,//Ao mostrar Mostrar a janela principal em
          swoShowMaximizado,//A janela principal é mostrada maximizada
          swoShowMinimized , //A janela principal é mostrada minimizada
          swoshowMinNOActive , //A janela principal é mostrada minimizada, mas não ativada
          swoShowNA , //A janela principal é mostrada, mas não ativada
          swoShowNoActivate ,// A janela principal é mostrada, mas não ativada
          swoShowNormal      //A janela principal é mostrada normalmente
         );
      }

      {https://www.freepascal.org/docs-html/fcl/process/tprocess.execute.html
      }

      var
        AProcess: TProcess; {https://www.freepascal.org/docs-html/fcl/process/tprocess.html}
    begin
       abstracts;
       AProcess := TProcess.Create(nil);

       freeandnil(AProcess);

    end;

   class function TObjectsMethods.ShellExecute(const FileName, Params,
      DefaultDir: AnsiString; ShowCmd: Integer): THandle;
  Begin
    Result := ShellExecute('open',FileName, Params, DefaultDir,ShowCmd);
  end;

  class function TObjectsMethods.ShellExecute(const FileName,
      Params: AnsiString): THandle;
  Begin
    Result := ShellExecute(FileName, Params, ''{DefaultDir} , SW_SHOWNORMAL{ShowCmd}  );
  end;

  {: A classe function@name retorna o ip publico da máquina local}
                class function TObjectsMethods.GetIpPub: String;
  var
    IdGetIP: TFPHTTPClient;
    Html : String;
  const
    gUrlIpA= 'http://dynupdate.no-ip.com/ip.php';
    gUrlIpB= 'http://www.networksecuritytoolkit.org/nst/tools/ip.php';
  begin
    try
    IdGetIP:=TFPHTTPClient.Create(nil);
    Result := '';
    try
      Html := IdGetIP.Get(gUrlIpA);
    except
      Html := IdGetIP.Get(gUrlIpB);
    end;
    Result := html;
    finally
      IdGetIP.Free;
    end;
  end;

  class function TObjectsMethods.StrToInt(aStr: String): Int64;
  Begin
    if astr = ''
    then astr := '0';
    Result := sysUtils.StrToInt64(aStr);
  End;

  class function TObjectsMethods.BooleanToStr(const FieldData: Boolean): AnsiString;
  Begin
    If FieldData Then
      result := 'TRUE'
    Else
      result := 'FALSE';
  End;

  class function TObjectsMethods.DelSpcED(campo: Ansistring): AnsiString;
  begin
    {Deleta brancos a esquerda }
    While (Length(Campo)>0) and (Campo[1] in [' ',#0..#31] ) do
      Delete(Campo,1,1);

    {Deleta brancos a direita}
    While (Length(Campo)>0) and (Campo[Length(Campo)] in [' ',#0..#31] )
    do Delete(Campo,Length(Campo),1);

    result := campo;
  end;

  class function TObjectsMethods.DeleteChars(campo: Ansistring;CharInvalid:TAnsiCharSet): AnsiString;
    Var
      I : Integer;
      ch : WideChar;
  Begin
    Result := '';
    For i :=  1 to Length(campo)   do
    Begin
      ch := campo[i];
      if (not(ch in CharInvalid )) and (ord(ch)>0)
      Then Begin
             Result := Result + campo[i];
           end;
    end;
  end;

  class function TObjectsMethods.Delspace(campo: Ansistring): AnsiString;
    var
      p : integer;
  begin
    result := campo;
    P := pos(' ',result,1);
    while p <> 0 do
    begin
      delete(result,p,1);
      P := pos(' ',result,1);
    end;

    P := pos(#0,result,1);
    while p <> 0 do
    begin
      delete(result,p,1);
      P := pos(#0,result,1);
    end;

  end;

  class function TObjectsMethods.GetNameValid(aName: AnsiString): AnsiString;
  begin
    Result :=  RemoveAccents(delspace(aName));

    ////Remove espaço do inicio
    //if Length(Result)>0
    //then while (Result[1]=' ') do
    //         System.delete(Result,1,1);
    //
    ////Remove espaço do fim
    //if Length(Result)>0
    //then while (Result[length(Result)]=' ') do
    //         System.delete(Result,length(Result),1);
  end;

  class function TObjectsMethods.IsNumberReal(const aTemplate: ShortString): Boolean;
  Begin
    Case TypeFld(aTemplate) of
      fldExtended,
      fldRealNum         ,
      fldRealNum_Positivo,
      fldReal4Positivo,
      fldReal4PPositivo,
      fldReal4           ,
      fldReal4P          : Result := True
      Else                 Result := false;
    End;
  end;

  class function TObjectsMethods.IsNumberInteger(const aTemplate: ShortString): Boolean;
  begin
    Case TypeFld(aTemplate) of
      fldBYTE,
      fldSHORTINT,
      fldSmallWORD,
      fldSmallInt,
      fldLONGINT,
      fldHexValue,
      fldENum,
      fldENum_db : Result := true
      else Result := false;
    end;

  end;

  class function TObjectsMethods.IsNumber(const aTemplate: ShortString): Boolean;
  Begin
    result := IsNumberInteger(aTemplate) or IsNumberReal(aTemplate);
  end;

  class function TObjectsMethods.IsBoolean(const aTemplate: ShortString): Boolean;
  begin
    Result := TypeFld(aTemplate) in [fldBoolean];
  end;

  class function TObjectsMethods.IsData(const aTemplate: ShortString): Boolean;
  begin
    Result := TypeFld(aTemplate) in [FldDateTime];
  end;

  class function TObjectsMethods.IsHora(const aTemplate: ShortString): Boolean;
  begin
    Result := TypeFld(aTemplate) in [fld_LHora,fldLHora];
  end;

  procedure TObjectsMethods.HandleEvent(var Event: TEvent);
  Begin
    if (Event.What = evCommand) //and (Event.Command = CmTime) // nortsoft implementou o evento time
    then Begin
           If (Event.StrCommand = CmTime) // nortsoft implementou o evento time
           Then Begin
                  CtrlSleep(TimeCmTime);
                  ClearEvent(Event);
                end;
  {         Else
           If (Event.Command = CmHelp)
           Then Begin
                  ExecViewHelpCtx;
                  ClearEvent(Event);
                end }

         end;
   end;

   procedure TObjectsMethods.ClearEvent(var Event: TEvent);
   Begin
     Event.What       := evNothing;
     Event.Command    := 0;
     Event.StrModule  := '';
     Event.StrCommand := '';
     Event.InfoPtr    := Self;
   end;

   class function TObjectsMethods.Change_AnsiChar(campo: AnsiString;const AnsiChar_Font, AnsiChar_Dest: AnsiChar): AnsiString;
   Begin
     if AnsiChar_Font <> AnsiChar_Dest
     Then Begin
            While Pos(AnsiChar_Font,campo)<>0  do
            begin
              campo[Pos(AnsiChar_Font,Campo)] := AnsiChar_Dest;
            end;
     end;

     Result := Campo;
   end;

   class function TObjectsMethods.DeleteMask(S: AnsiString;ValidSet: AnsiCharSet): AnsiString;
     {
       inclui um conjunto de caracateres a tString

       Exemplo
          S := '"Paulo.Sergio Idade: 1958"';
          DeleteMask(S,['0'..'9']);

          Resultado: 1958
     }
     Var
       I : Integer;
   Begin
     Result := '';
     For i :=  1 to Length(S)   do
     Begin
       if (s[i] in ValidSet )
       Then Begin
              Result := Result + S[i];
            end;
     end;
   end;

   class function TObjectsMethods.DeleteMask(S: AnsiString; aMask: TString): AnsiString;
      {
       Mask1: ssssssssssssssss    Obs: Cada posição com s ou S aceita [#0..#255] e ignora os digitos da mascara.
       Mask2: (##) # #### ####    Obs: Cada posição com # aceita ['0'..'9'] e ignora os digitos da mascara.

       Nota:
         Se S não tem mascara, o que fazer?
      }
      Var
        I,LenS,Len_aMask : Integer;
   Begin
      Result := '';
      LenS := length(s);
      Len_aMask := length(aMask);

      if LenS = Len_aMask
      Then begin
              For i :=  1 to LenS   do
              Begin
                  if i <= Len_aMask then
                  case aMask[i] of
                    fldAnsiChar,fldAnsiChar_Lowcase,fldAnsiCharVAL
                    ,fldSTRNUM,fldSTR,fldSTR_Lowcase
                         : begin
                             Result := Result + S[i];
                           end;
                     fldRealNum,fldReal4,fldReal4P,
                     fldReal4Positivo,fldReal4PPositivo,
                     fldRealNum_Positivo,fldExtended
                    ,fldENum,fldENum_db,fldBOOLEAN,fldBYTE,fldSHORTINT,
                     fldSmallWORD,fldSmallInt,fldLONGINT,FldRadioButton
                    ,FldDateTime
                    ,fldLHora,fld_LHora
                         : begin
                            if S[i] in ['0'..'9']
                            then Result := Result + S[i];
                          end;
                  end;
              end;
           end
      else Result := S;
   end;

   class function TObjectsMethods.AddMask(S: ShortString;aMask:ShortString): AnsiString;
      {
       Mask1: ssssssssssssssss    Obs: Cada posição com s ou S aceita [#0..#255] e ignora os digitos da mascara.
       Mask2: (##) # #### ####    Obs: Cada posição com # aceita ['0'..'9'] e ignora os digitos da mascara.

       Nota:
         Se S não tem mascara, o que fazer?
      }
      Var
        I,LenS,PosS,Len_aMask : Integer;
        ws:AnsiString;
    Begin
      Result := '';

      if  aMask[1] = FldDateTime
      then begin
             //ws := Copy(aMask,2,Length(aMask)-1);
             //Result := TDates.FormatMask(s,MaskDateTime_to_Mask(ws));
             Result := s;
           end
      else begin
              LenS := length(s);
              PosS := 0;
              Len_aMask := length(aMask);

              For i :=  1 to Len_aMask   do
              Begin
                case aMask[i] of
                  fldAnsiChar,
                  fldAnsiChar_Lowcase,
                  fldAnsiCharVAL,
                  fldSTRNUM,
                  fldSTR,
                  fldSTR_Lowcase,
                  fldRealNum,
                  fldReal4,
                  fldReal4P,
                  fldRealNum_Positivo,
                  fldExtended,
                  fldENum,fldENum_db,
                  fldBOOLEAN,
                  fldBYTE,
                  fldSHORTINT,
                  fldSmallWORD,
                  fldSmallInt,
                  fldLONGINT,
                  FldRadioButton  : begin
                                      inc(posS);
                                      if PosS <= LenS
                                      then result := Result + s[posS];
                                    end;

                  else begin
                         if aMask[i] = ' '
                         then system.Insert('_',result,i)  //O caractere deve ser passado como parâmetro. amanhã eu faço.
                         else system.Insert(aMask[i],result,i);
                       end;
                end;
              end;
           end;

    end;


   class function TObjectsMethods.CreateDB_or_DropDB(aConnectorType: TConnectorType;
                                                     aHostname, aUserName, aPassword,aDataBaseName: String;
                                                     okCreateDB: Boolean): string;
     Var
       conn  : TSQLConnection;
   Begin
    Result := '';
     try
       case aConnectorType of
         PostgresSQL : conn := TPQConnection.Create(nil);
         SqLite3     : conn := TSQLite3Connection.Create(nil);
         else begin
                Result := 'Banco de dados desconhecido';
              end ;
       End;

       conn.HostName := aHostName;
       conn.UserName := aUserName;
       conn.Password := aPassword;
       conn.DatabaseName:= aDatabaseName;

       if okCreateDB
       then begin
              try
              conn.CreateDB

              except
                on e : exception do Result := e.Message;
              End;

            End
       else begin
              try
               conn.DropDB;
              except
                on e : exception do Result := e.Message;
              End;
            End;

     Finally
       freeandnil(conn);
     End;

   End;

   //class function TObjectsMethods.StrNumberValid(S: AnsiString): AnsiString;
   // begin
   //   Result  := DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
   //end;

   class function TObjectsMethods.StrToStrNumberForProcVal(S: AnsiString): AnsiString;
   begin
     Result  := DeleteMask(S,['0'..'9','-','+',showDecimalSeparator ]);
     if (pos(showDecimalSeparator  ,Result)<>0) and (showDecimalSeparator <>'.' )
     then begin
            Result := Change_AnsiChar(s,showDecimalSeparator ,'.');
          end;
  end;

   class function TObjectsMethods.CheckRanger(S : AnsiString; aHigh, aLow: Int64; out aErr:Integer): Int64;
   begin
     aErr := 0;
     s := DeleteMask(s,['0'..'9','-','+',showDecimalSeparator ]);
     If S<>''
     Then begin
            Result := StrToInt(s);
            if not ((Result<=aHigh) and (Result >= aLow ))
            Then with TMI_MsgBoxConsts do
                 Begin
                   aErr := ErrorNaChecagemDeFaixa;
                   MessageBox(Format(sErr201,[ord(aErr),s,aLow,aHigh]),MtError, mbOKButton);
                   Result := 0;
                 end;
          end
     Else Result := 0;

     TaStatus := aErr ;
   end;

   class function TObjectsMethods.IntValid(S: AnsiString; TypeCode: AnsiChar): Boolean;
     Var
       err : Integer;
   begin
     err := 0;
     case TypeCode of
         fldENum ,
         fldENum_db,
         fldLONGINT  : CheckRanger(s,High(Longint),Low(Longint),err);
         fldBOOLEAN,
         fldBYTE     : CheckRanger(s,High(byte),Low(byte),err);
         fldSHORTINT : CheckRanger(s,High(SHORTINT),Low(SHORTINT),err);
         fldSmallWORD: CheckRanger(s,High(SmallWord),Low(SmallWord),err);
         FldRadioButton: CheckRanger(s,High(Byte),Low(Byte),err);
         fldSmallInt : CheckRanger(s,High(SmallInt),Low(SmallInt),err);
      end;
     Result := err = 0;
   end;

   class procedure TObjectsMethods.ShowHtml(URL: string);
   begin
   end;

   function TObjectsMethods.GetHelpCtx_StrCurrentModule: AnsiString;
   begin
      Result := _HelpCtx_StrCurrentModule;
   end;

   function TObjectsMethods.GetHelpCtx_StrCurrentCommand: AnsiString;
   begin
     Result := _HelpCtx_StrCurrentCommand;
   end;

   function TObjectsMethods.GetHelpCtx_StrCurrentCommand_Opcao: AnsiString;
   begin
     Result :=  _HelpCtx_StrCurrentCommand_Opcao;
   end;

   function TObjectsMethods.TabIndex: Longint;
   begin
     result := -1;
   end;

   function TObjectsMethods.CreateHTML: AnsiString;
   begin
     result := '';
   end;

   function TObjectsMethods.GetAcao(): AnsiString;

     Function GetSubAcao(SubAcao:AnsiString):AnsiString;
     //<a href="/cgi-bin/GCIC.exe/XX">Cadastrar planos de pagamentos</a>
     //"/cgi-bin/GCIC.exe/CSistemaIntegrado,Cm_Arq_Plano_de_PagamentoI"
     Begin
       If SubAcao <> ''
       Then Result :=','+SubAcao
       Else Result := '';
     end;
     {
       Deve tornar um link para ação
     }
   Begin
     //Result :=  Application.ParamExecucao.HostName+
     //           ExtractFileName(Application.ParamExecucao.NomeDeArquivosGenericos.NomeArqExe)+
     //           '/'+
     //           HelpCtx_StrCurrentModule+
     //           GetSubAcao(HelpCtx_StrCurrentCommand)+
     //           GetSubAcao(HelpCtx_StrCurrentCommand_Opcao);

   end;


  function TObjectsMethods.GetHelpCtx_StrCommand: AnsiString;
  Begin
    Result := _HelpCtx_StrCommand;

    if Result = ''
    then Result := HelpCtx_StrCurrentCommand;
  end;

  function TObjectsMethods.GetHelpCtx_StrCurrentCommand_Topic: AnsiString;
  Begin
    if ExtractFileDrive(_HelpCtx_StrCurrentCommand_Topic) = ''
    then Result := _HelpCtx_StrCurrentCommand_Topic
    Else Result := ExtractFileName(_HelpCtx_StrCurrentCommand_Topic);
  End;

  function TObjectsMethods.GetHelpCtx_StrCommand_Topic: AnsiString;
  Begin
    if ExtractFileDrive(_HelpCtx_StrCommand_Topic) = ''
    then Result := _HelpCtx_StrCommand_Topic
    Else ExtractFileName(HelpCtx_StrCurrentCommand_Topic);


    if Result = ''
    then Begin
           if ExtractFileDrive(HelpCtx_StrCurrentCommand_Topic) = ''
           then Result := HelpCtx_StrCurrentCommand_Topic
           Else Result := ExtractFileName(HelpCtx_StrCurrentCommand_Topic);
         end;
  End;



  function TObjectsMethods.GetHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;
  Begin
    Result := _HelpCtx_StrCurrentCommand_Topic_Content_Run;
  end;

  procedure TObjectsMethods.SetHelpCtx_StrCurrentCommand_Topic_Content_Run(
      wHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run
    );
  Begin
    _HelpCtx_StrCurrentCommand_Topic_Content_Run := wHelpCtx_StrCurrentCommand_Topic_Content_Run;
  end;


  function TObjectsMethods.Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean;
  Begin
    Result := _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
  end;

  procedure TObjectsMethods.Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);
  Begin
    _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File := a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
  End;


    function TObjectsMethods.GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;
  Begin
    Result := _HelpCtx_StrCurrentCommand_Topic_Content;
  end;

    procedure TObjectsMethods.SetHelpCtx_StrCurrentCommand_Topic_Content(
    wHelpCtx_StrCurrentCommand_Topic_Content: AnsiString);
  Begin
    _HelpCtx_StrCurrentCommand_Topic_Content := wHelpCtx_StrCurrentCommand_Topic_Content;
  end;

  function TObjectsMethods.GetHelpCtx_Doc_HTML: AnsiString;
      {ATENÇAO:

      Está um Implemntação só funciona se o objeto que herdar TNSComponent for do tipo campo.
      Caso a classe que herdar TNSComponent seja tabela, então este método deve ser redefinido
      para que os dados sejão pegos do corrente campo.
      }

     {
      Retorna nome do documento associando a visao.
     }
     Var
       wHelpCtx_StrCommand,wHelpCtx_StrCommand_Topic : AnsiString;

  Begin
    result := '';
     //Dar prioride a HelpCtx_StrCommand
     wHelpCtx_StrCommand := HelpCtx_StrCommand;
     if wHelpCtx_StrCommand = ''
     then wHelpCtx_StrCommand := HelpCtx_StrCurrentCommand;

     //Dar prioride a HelpCtx_StrCommand_Topic
     wHelpCtx_StrCommand_Topic := HelpCtx_StrCommand_Topic;

     //Se não foi definido um topico para o comando, então usa o corrente.
     if wHelpCtx_StrCommand_Topic = ''
     then wHelpCtx_StrCommand_Topic := HelpCtx_StrCurrentCommand_Topic;

     If HelpCtx_StrCurrentCommand_Opcao <> ''
     Then Result := GetHelpCtx_Path + wHelpCtx_StrCommand+'_'+HelpCtx_StrCurrentCommand_Opcao+'.htm'
     Else If wHelpCtx_StrCommand <> ''
          Then Begin
                 if HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File
                 Then Begin {$Region '// HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File'}
                        Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File := true;
                       //HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File. Nota: Para cada campo o conteudo do campo é criado um arquivo.
                        Result := GetHelpCtx_Path + wHelpCtx_StrCommand+'_'+wHelpCtx_StrCommand_Topic+'_'+Alias_To_Name(HelpCtx_StrCurrentCommand_Topic_Content+'.htm') //
                      end   {$EndRegion '// HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File'}
                 Else Begin
                        Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File := False;
                        Result := GetHelpCtx_Path + wHelpCtx_StrCommand+'.htm'
                      End;
              end
          Else Result := '';
   end;


    function TObjectsMethods.GetHelpCtx_Path: AnsiString;
      {
       Retorna path do documento associando a visao.
      }
     //Function SIF(Const Logica : Boolean; Const E1 , E2 : String ) : String ;
     //Begin
     //  If Logica Then SIF := E1 Else SIF := E2;
     //End;

    Begin
      result := '';
      //if HelpCtx_StrCommand <>''
      //then Result := application.ParamExecucao.NomeDeArquivosGenericos.DirHTML+
      //               SIF(HelpCtx_StrModule<>'',HelpCtx_StrModule+PathDelim,'')+
      //               SIF(HelpCtx_StrCommand<>'',HelpCtx_StrCommand+PathDelim,'')
      //Else Result := application.ParamExecucao.NomeDeArquivosGenericos.DirHTML+
      //               SIF(HelpCtx_StrCurrentModule<>'',HelpCtx_StrCurrentModule+PathDelim,'')+
      //               SIF(HelpCtx_StrCurrentCommand<>'',HelpCtx_StrCurrentCommand+PathDelim,'');
    end;

   function TObjectsMethods.GetAlias: AnsiString;
   begin
     If _Alias <> ''
     Then Result := _Alias
     Else Result := ClassName;
   end;

   procedure TObjectsMethods.SetAlias(const aAlias: AnsiString);
   begin
     If aAlias <> ''
     Then _Alias   := AAlias
     else _Alias   := ClassName;
     //writeLn(ClassName +'--> '+ _Alias);
   end;

   class function TObjectsMethods.MI_MsgBox: TMI_MsgBox;
   begin
     If Assigned(_MI_MsgBox)
     Then result := _MI_MsgBox
     else Raise Exception.Create('A class MI_MsgBox precisa ser assinalada com Set_MI_MsgBox na plataforma destino!');
   end;

   function TObjectsMethods.StartTransaction: Boolean;
   begin
     if Assigned(Mi_Transaction)
     then result := Mi_Transaction.StartTransaction
     else result := false;
   end;


   function TObjectsMethods.COMMIT: Boolean;
   begin
     if Assigned(Mi_Transaction)
     then begin
           result := Mi_Transaction.COMMIT
         end
     else result := false;
   end;

   procedure TObjectsMethods.Rollback;
   begin
     if Assigned(Mi_Transaction)
     then Mi_Transaction.Rollback;
   end;

   class function TObjectsMethods.ShellScript(aCommand: String): String;
   begin
     RunCommand('/bin/bash',['-c',aCommand],result);
   end;


   class function TObjectsMethods.SplitString(aInputString:string; aDelimiter: Char):TStringArray;

      procedure AddStringToArray(var A: TStringArray; const B: String);
      begin
        SetLength(A, Length(A) + 1);
        A[High(A)] := B;
      end;

    var
      StringList: TStringList;
      Part: string;

   begin
     Result := [];
     StringList := TStringList.Create;
     try
       StringList.Delimiter := aDelimiter;
       StringList.DelimitedText := aInputString;

       for Part in StringList do
       begin
         AddStringToArray(Result,Part);
       end;

     finally
        StringList.Free;
     end;
   end;

   class function TObjectsMethods.HTMLToTColor(const HTML: TString): Integer;
     var
       Offset: Integer;
   begin
       // check for leading '#'
       if Copy(HTML, 1, 1) = '#'
       then Offset := 1
       else Offset := 0;

       // convert hexa-decimal values to RGB
       Result :=
         Integer(StrToInt('$' + Copy(HTML, Offset + 1, 2))) +
         Integer(StrToInt('$' + Copy(HTML, Offset + 3, 2))) shl 8 +
         Integer(StrToInt('$' + Copy(HTML, Offset + 5, 2))) shl 16;
   end;

   class function TObjectsMethods.IsEmptyOrNull(const aValue: Variant): Boolean;

   begin
     Result := VarIsClear(aValue) or
               VarIsEmpty(aValue) or
               VarIsNull(aValue) or
               (VarCompareValue(aValue, Unassigned) = vrEqual);

     if (not Result) and VarIsStr(aValue)
     then Result := aValue = '';
   end;

   class procedure TObjectsMethods.UnlistPublishedProperty (ComponentClass:TPersistentClass; const PropertyName:String);
    var
      pi : PPropInfo;
    begin
      pi := TypInfo.GetPropInfo (ComponentClass, PropertyName);
      if (pi <> nil) then
        RegisterPropertyEditor (pi^.PropType, ComponentClass, PropertyName, PropEdits.THiddenPropertyEditor);
    end;

   class procedure TObjectsMethods.str(v: variant; var s: String);
   begin

   end;

   class procedure TObjectsMethods.Print_info_compile;
     var
      HeapStatus: THeapStatus;
   begin
     Writeln('Unit name is ',UnitName);
     Writeln('Name is ', {$I %CURRENTROUTINE%});
     Writeln ('This program was compiled ',DateCompiler);
     Writeln ('By ',User);
     Writeln ('Compiler version: ',FPC_Version);
     Writeln ('Target CPU: ',FPC_Target);
     Writeln ('HOME: ',{$I %HOME%});
     // Obter o status da heap
     HeapStatus := GetHeapStatus;
     // Exibir informações sobre a memória heap
     Writeln('Free heap size: ', HeapStatus.TotalFree, ' bytes');
     Writeln('Used heap size: ', HeapStatus.TotalAllocated, ' bytes');
     // Exibir informações sobre a memória heap
     Writeln('');
   end;

   //class function TObjectsMethods.GetPropInfo(AClassInfo: Pointer; AName: String     ): PPropInfo;
   //  var
   //    PropList: PPropList;
   //    PropCount, I: Integer;
   //    PropInfo: PPropInfo;
   //begin
   //  if Assigned(aClassInfo)
   //  Then begin
   //          PropCount := GetPropList(aClassInfo, PropList);
   //          try
   //            for I := 0 to PropCount - 1 do
   //            begin
   //              PropInfo := PropList^[I];
   //              if upCase(PropInfo^.Name)= UpCase(aName)
   //              Then begin
   //                     result := PropInfo;
   //                     exit;
   //                   end;
   //            end;
   //          finally
   //            FreeMem(PropList);
   //          end;
   //       end;
   //  Result := nil;
   //end;

  class function TObjectsMethods.VarRecArrayToStr(const Args: array of const): string;
  var
    I: Integer;
    V: TVarRec;
  begin
    Result := '';
    for I := 0 to High(Args) do
    begin
      V := Args[I];
      case V.VType of
        vtInteger:        Result := Result + IntToStr(V.VInteger);
        vtBoolean:        Result := Result + BoolToStr(V.VBoolean, True);
        vtChar:           Result := Result + V.VChar;
        vtExtended:       Result := Result + FloatToStr(V.VExtended^);
        vtString:         if V.VString <> nil then Result := Result + string(V.VString^);
        vtPChar:          if V.VPChar <> nil then Result := Result + string(V.VPChar);
        vtObject:         if Assigned(V.VObject) then Result := Result + V.VObject.ClassName;
        vtAnsiString:     if V.VAnsiString <> nil then Result := Result + AnsiString(V.VAnsiString);
        vtCurrency:       Result := Result + CurrToStr(V.VCurrency^);
        vtVariant:        if V.VVariant <> nil then Result := Result + string(V.VVariant^);
        vtWideString:     if V.VWideString <> nil then Result := Result + WideString(V.VWideString);
        vtInt64:          Result := Result + IntToStr(V.VInt64^);
        vtUnicodeString:  if V.VUnicodeString <> nil then Result := Result + UnicodeString(V.VUnicodeString);
      else
        Result := Result + '[unknown type]';
      end;

      if I < High(Args) then
        Result := Result + ', ';
    end;
  end;


   //class function TObjectsMethods.VarRecArrayToStr(const Args: array of const): string;
   // var
   //   I: Integer;
   //   V: TVarRec;
   //begin
   //   Result := '';
   //   for I := 0 to High(Args) do
   //   begin
   //     V := Args[I];
   //     case V.VType of
   //       vtInteger:        Result := Result + IntToStr(V.VInteger);
   //       vtBoolean:        Result := Result + BoolToStr(V.VBoolean, True);
   //       vtChar:           Result := Result + V.VChar;
   //       vtExtended:       Result := Result + FloatToStr(V.VExtended^);
   //       vtString:         if V.VString <> nil then Result := Result + string(V.VString^);
   //       vtPChar:          if V.VPChar <> nil then Result := Result + string(V.VPChar);
   //       vtObject:         if Assigned(V.VObject) then Result := Result + V.VObject.ClassName;
   //       vtAnsiString:     if V.VAnsiString <> nil then Result := Result + AnsiString(V.VAnsiString);
   //       vtCurrency:       Result := Result + CurrToStr(V.VCurrency^);
   //       vtVariant:        if V.VVariant <> nil then Result := Result + string(V.VVariant^);
   //       vtWideString:     if V.VWideString <> nil then Result := Result + WideString(V.VWideString);
   //       vtInt64:          Result := Result + IntToStr(V.VInt64^);
   //       vtUnicodeString:  if V.VUnicodeString <> nil then Result := Result + UnicodeString(V.VUnicodeString);
   //     else
   //       Result := Result + '[unknown type]';
   //     end;
   //
   //     if I < High(Args) then
   //       Result := Result + ', ';
   //   end;
   //end;


  //class function TObjectsMethods.VarRecArrayToStr(const Args: array of const): string;
  //  var
  //    I: Integer;
  //    V: TVarRec;
  //begin
  //  Result := '';
  //  for I := 0 to High(Args) do
  //  begin
  //    V := Args[I];
  //    case V.VType of
  //      vtInteger:        Result := Result + IntToStr(V.VInteger);
  //      vtBoolean:        Result := Result + BoolToStr(V.VBoolean, True);
  //      vtChar:           Result := Result + V.VChar;
  //      vtExtended:       Result := Result + FloatToStr(V.VExtended^);
  //      vtString:         Result := Result + string(V.VString^);
  //      vtPChar:          Result := Result + string(V.VPChar);
  //      vtObject:         Result := Result + V.VObject.ClassName;
  //      vtAnsiString:     Result := Result + AnsiString(V.VAnsiString);
  //      vtCurrency:       Result := Result + CurrToStr(V.VCurrency^);
  //      vtVariant:        Result := Result + string(V.VVariant^);
  //      vtWideString:     Result := Result + WideString(V.VWideString);
  //      vtInt64:          Result := Result + IntToStr(V.VInt64^);
  //      vtUnicodeString:  Result := Result + UnicodeString(V.VUnicodeString);
  //    else
  //      Result := Result + '[unknown type]';
  //    end;
  //
  //    // Adiciona uma vírgula e espaço entre os itens, exceto no último
  //    if I < High(Args) then
  //      Result := Result + ', ';
  //  end;
  //end;

  class procedure TObjectsMethods.JsonToDataSet(const JSONString: string;var aJSONDataSet: TJSONDataSet);
  begin
    aJSONDataSet.Rows.AsString:=JSONString;
  end;

  class function TObjectsMethods.DataSetToJson(const aJSONDataSet: TJSONDataSet): String;
  begin
    Result := aJSONDataSet.Rows.AsString;
  end;

  class function TObjectsMethods.JSONToVariantArray(JSONData: TJSONData): Variant;
    var
      i: Integer;
      JSONArray: TJSONArray;
  begin
    if JSONData.JSONType = jtArray then
    begin
      JSONArray := TJSONArray(JSONData);
      Result := VarArrayCreate([0, JSONArray.Count - 1], varVariant);
      for i := 0 to JSONArray.Count - 1 do
      begin
        case JSONArray.Items[i].JSONType of
          jtNumber: Result[i] := JSONArray.Items[i].AsFloat;
          jtString: Result[i] := JSONArray.Items[i].AsString;
          jtBoolean: Result[i] := JSONArray.Items[i].AsBoolean;
          jtNull: Result[i] := 'null'; // Representando null como string 'null'
          jtArray, jtObject:
            // Recursivamente converte arrays e objetos aninhados.
            Result[i] := JSONToVariantArray(JSONArray.Items[i]);
        end;
      end;
    end
    else
      raise Exception.Create('O JSON fornecido não é um array.');
  end;

  class function TObjectsMethods.ArrayToVariant(aValues: array of string    ): Variant;
    var
      i : Integer;
      s : String;
      V : Variant;
  begin
    // Criação do Variant com o array
    Result := VarArrayCreate([0, Length(aValues) - 1],varVariant);
    for i := 0 to High(aValues) do
      Result [i] := aValues[i];

    // Tentativa de acessar os elementos do array Variant para verificar
    //for i := 0 to VarArrayHighBound(Result, 1) do
    //begin
    //  // Atribua cada elemento a uma variável string (s) para teste
    //  WriteLn('Elemento ', i, ': ', VarToStr(Result[i])); // Exibe os elementos no console para verificação
    //end;
  end;

  class function TObjectsMethods.getFieldsKeys(aQueryFields: TStrings;out Values: TArray<string>): AnsiString;
    var
      posigual: Integer;
      V_Count: Integer = 0;
      s: string;
  begin
    result := '';
    SetLength(Values, 0); // Inicializa o array Values
    for s in aQueryFields do
    begin
      posigual := Pos('=', s);
      if posigual > 0 then
      begin
        result := result + System.Copy(s, 1, posigual - 1) + ';';
        Inc(V_Count);
        SetLength(Values, V_Count);
        Values[V_Count - 1] := System.Copy(s, posigual + 1, Length(s) - posigual);
      end;
    end;

    // Remove o último ponto e vírgula, se existir.
    if result <> '' then
      System.Delete(result, Length(result), 1);
  end;


  class function TObjectsMethods.URLEncode(AStr: Ansistring): UTF8String;
    const
      HexMap: array[0..15] of Char = '0123456789ABCDEF';
    var
      i: Integer;
      Code: Word;
  begin
    Result := '';
    AStr := UTF8Encode(AStr);
    for i := 1 to Length(AStr) do
    begin
      Code := Ord(AStr[i]);
      if (Code >= 32)
         and (Code <= 126)
         and not (AStr[i] in [' ', '&', '=', '?', '#', '%'])
      then Result := Result + AStr[i]
      else Result := Result + '%' + HexMap[(Code shr 4) and $0F] + HexMap[Code and $0F];
    end;
  end;

  class function TObjectsMethods.JSONObjectToQueryString(const Params: TJSONObject): string;
    var
      Pair: TJSONEnum;
      ArrayValue: TJSONArray;
      i: Integer;
      TempStr: string;
  begin
    Result := '';
    for Pair in Params do
    begin
      if Result <> '' then
        Result := Result + '&';

      // Tratamento para diferentes tipos de valor JSON
      case Pair.Value.JSONType of
        jtNull:
          Result := Result + URLEncode(Pair.Key) + '=';

        jtString:
          Result := Result + URLEncode(Pair.Key) + '=' + URLEncode(Pair.Value.AsString);

        jtNumber:
          Result := Result + URLEncode(Pair.Key) + '=' + URLEncode(FloatToStr(Pair.Value.AsFloat));

        jtBoolean:
          Result := Result + URLEncode(Pair.Key) + '=' + URLEncode(BoolToStr(Pair.Value.AsBoolean, True));

        jtArray:
          begin
            // Trata arrays, concatenando valores separados por vírgula
            ArrayValue := Pair.Value as TJSONArray;
            TempStr := '';
            for i := 0 to ArrayValue.Count - 1 do
            begin
              if i > 0 then
                TempStr := TempStr + ',';
              TempStr := TempStr + URLEncode(ArrayValue.Items[i].AsString);
            end;
            Result := Result + URLEncode(Pair.Key) + '=' + URLEncode(TempStr);
          end;

        else
          raise Exception.CreateFmt('Tipo de valor JSON não suportado: %s', [Pair.Key]);
      end;
    end;
  end;

  // Função auxiliar para converter strings separadas por vírgulas em um array JSON
    class function TObjectsMethods.ConvertCSVToJSONArray(const CSV: string
    ): TJSONArray;
  var
    Items: TStringList;
    i: Integer;
  begin
    Result := TJSONArray.Create;
    Items := TStringList.Create;
    try
      // Divide a string CSV em uma lista usando a vírgula como separador
      Items.Delimiter := ',';
      Items.StrictDelimiter := True; // Evita que espaços sejam considerados parte dos valores
      Items.DelimitedText := CSV;

      // Adiciona cada item da lista ao JSONArray
      for i := 0 to Items.Count - 1 do
      begin
        Result.Add(Items[i].Trim); // Remove espaços extras
      end;
    finally
      Items.Free;
    end;
  end;

  class procedure TObjectsMethods.GetQueryFieldsLocate(
                                    var aRequest: TRequest;
                                    out aKeyFields: string;
                                    out aKeyValues: Variant;
                                    out aOptions: TLocateOptions);


      // Função auxiliar para decodificar strings de URL
      function URLDecode(const AStr: string): string;
      begin
        Result := HTTPDecode(AStr);
      end;

  var
    JSONArray: TJSONArray;
    aKeyValuesStr, aOptionsStr: String;
    i: Integer;
  begin
    // Extração dos parâmetros da query string com decodificação de URL
    aKeyFields := URLDecode(aRequest.QueryFields.Values['KeyFields']);
    aKeyValuesStr := URLDecode(aRequest.QueryFields.Values['KeyValues']);
    aOptionsStr := URLDecode(aRequest.QueryFields.Values['Options']);

    // Verificação se o campo de chave foi informado
    if aKeyFields = '' then
      raise Exception.Create('O parâmetro "KeyFields" não pode ser vazio!');

    // Parse de KeyValues (tratando como um array de valores)
    if aKeyValuesStr <> '' then
    begin
      JSONArray := ConvertCSVToJSONArray(aKeyValuesStr);
      if JSONArray.Count = 1 then
        aKeyValues := JSONArray.Items[0].AsString
      else
      begin
        aKeyValues := VarArrayCreate([0, JSONArray.Count - 1], varVariant);
        for i := 0 to JSONArray.Count - 1 do
          aKeyValues[i] := JSONArray.Items[i].AsString;
      end;
    end
    else
      raise Exception.Create('O parâmetro "KeyValues" não pode ser vazio!');

    // Parse de Options (tratando como um array de opções)
    aOptions := [];
    if aOptionsStr <> '' then
    begin
      JSONArray := ConvertCSVToJSONArray(aOptionsStr);
      for i := 0 to JSONArray.Count - 1 do
      begin
        if JSONArray.Strings[i] = 'loCaseInsensitive' then
          Include(aOptions, loCaseInsensitive);

        if JSONArray.Strings[i] = 'loPartialKey' then
          Include(aOptions, loPartialKey);
      end;
    end;
  end;

  class function TObjectsMethods.LocateParamsToJson(KeyFields: string;
                     KeyValues: Variant; Options: TLocateOptions): TJSONObject;

    var
      JsonOptions: TJSONArray;
      JsonKeyValues: TJSONArray;
      Option: TLocateOption;
      i: Integer;
  begin
    Result := TJSONObject.Create;

    // Adiciona KeyFields
    Result.Add('KeyFields', KeyFields);

    // Adiciona KeyValues
    JsonKeyValues := TJSONArray.Create;
    if VarIsArray(KeyValues)
    then begin
           for i := VarArrayLowBound(KeyValues, 1) to VarArrayHighBound(KeyValues, 1) do
             JsonKeyValues.Add(VarToStr(KeyValues[i]));
         end
    else JsonKeyValues.Add(VarToStr(KeyValues));

    Result.Add('KeyValues', JsonKeyValues);

    // Adiciona Options
    JsonOptions := TJSONArray.Create;
    for Option in Options do
    begin
      case Option of
        loCaseInsensitive: JsonOptions.Add('loCaseInsensitive');
        loPartialKey: JsonOptions.Add('loPartialKey');
      end;
    end;
    Result.Add('Options', JsonOptions);
  end;

  class function TObjectsMethods.ValidateAndNormalizeURL(const BaseURL, Action,
    QueryString: string): string;
  begin
    Result := BaseURL;

    // Remover '/' duplicadas entre BaseURL e Action
    if (Result.EndsWith('/')) and (Action.StartsWith('/')) then
      Result := Result + Action.Substring(1)
    else if (not Result.EndsWith('/')) and (not Action.StartsWith('/')) then
      Result := Result + '/' + Action
    else
      Result := Result + Action;

    // Adicionar QueryString, garantindo que ela comece com '?'
    if QueryString <> '' then
    begin
      if not QueryString.StartsWith('?') then
        Result := Result + '?' + QueryString
      else
        Result := Result + QueryString;
    end;
  end;

  class procedure TObjectsMethods.ParseServerResponse(const AResponse: string;out KeyFields: string; out KeyValues: Variant);
    var
      JSONObject: TJSONObject=nil;
      ValueArray: TJSONArray=nil;
      i: Integer;
      TempArray: Variant;
      s:string;
  begin
    // Inicializa os valores
    KeyFields := '';
    KeyValues := Null;

    try
      // Faz o parsing do JSON recebido
      JSONObject := TJSONObject(GetJSON(AResponse));

      try
        // Extrai o valor de "keyFields" (uma string)
        KeyFields := JSONObject.Get('keyFields', '');

        // Extrai o valor de "keyValues" (pode ser um array)
        if JSONObject.Find('keyValues') is TJSONArray then
        begin
          ValueArray := JSONObject.Arrays['keyValues'];
          if ValueArray.Count > 0 then
          begin
            // Cria um array variante para armazenar os valores
            TempArray := VarArrayCreate([0, ValueArray.Count - 1], varVariant);

            // Itera pelos valores no array JSON e os armazena no array variante
            for i := 0 to ValueArray.Count - 1 do
            begin
              TempArray[i] := ValueArray.Items[i].AsString;
              s:= TempArray[i];
            end;

            KeyValues := TempArray;
          end;
        end
        else
        begin
          // Se keyValues não for array, trata como valor único
          KeyValues := JSONObject.Get('keyValues', '');
        end;
      finally
        JSONObject.Free;
      end;
    except
      on E: Exception do
      begin
        // Lida com qualquer erro que possa ocorrer durante o parsing
        Writeln('Erro ao processar o JSON: ' + E.Message);
      end;
    end;
  end;

  //  class procedure TObjectsMethods.GetQueryFieldsLocate(var aRequest: TRequest;
  //                                                       out aKeyFields: string;
  //                                                       out aKeyValues: Variant;
  //                                                       out aOptions: TLocateOptions);
  //
  //    //Converte strings separados por virgulas em array json
  //    function ConvertCSVToJSONArray(const CSV: string): TJSONArray;
  //    var
  //      Items: TStringList;
  //      i: Integer;
  //      s:string;
  //    begin
  //      Result := TJSONArray.Create;
  //      Items := TStringList.Create;
  //      try
  //        // Divide a string CSV em uma lista usando a vírgula como separador
  //        Items.Delimiter := ',';
  //        Items.StrictDelimiter := True; // Evita que espaços sejam considerados parte dos valores
  //        Items.DelimitedText := CSV;
  //
  //        // Adiciona cada item da lista ao JSONArray
  //        for i := 0 to Items.Count - 1 do
  //        begin
  //           Result.Add(Items[i].Trim); // Remove espaços extras
  //        end;
  //      finally
  //        Items.Free;
  //      end;
  //    end;
  //
  //var
  //  JSONArray: TJSONArray;
  //  aKeyValuesStr, aOptionsStr: String;
  //  i: Integer;
  //begin
  //  // Extração dos parâmetros da query string
  //  aKeyFields := aRequest.QueryFields.Values['KeyFields'];
  //  aKeyValuesStr := aRequest.QueryFields.Values['KeyValues'];
  //  aOptionsStr := aRequest.QueryFields.Values['Options'];
  //
  //  // Parse KeyValues (tratando como um array de valores)
  //  if aKeyValuesStr <> '' then
  //  begin
  //    // Verifica se o KeyValues é um array JSON (começa com '[' e termina com ']')
  //    JSONArray := ConvertCSVToJSONArray(aKeyValuesStr);
  //    if JSONArray.Count = 1
  //    then aKeyValues := JSONArray.Items[0].AsString
  //    else begin
  //           aKeyValues := VarArrayCreate([0, JSONArray.Count - 1], varVariant);
  //           for i := 0 to JSONArray.Count - 1 do
  //             aKeyValues[i] := JSONArray.Items[i].AsString;
  //         end;
  //  end
  //  else
  //    raise Exception.Create('O parâmetro "KeyValues" não pode ser vazio!');
  //
  //  // Parse Options (tratando como um array de opções)
  //  aOptions := [];
  //  if aOptionsStr <> '' then
  //  begin
  //    // Verifica se o Options é um array JSON (começa com '[' e termina com ']')
  //    JSONArray := ConvertCSVToJSONArray(aOptionsStr);
  //    for i := 0 to JSONArray.Count - 1 do
  //    begin
  //      if JSONArray.Strings[i] = 'loCaseInsensitive' then
  //        Include(aOptions, loCaseInsensitive);
  //
  //      if JSONArray.Strings[i] = 'loPartialKey' then
  //        Include(aOptions, loPartialKey);
  //    end;
  //  end;
  //end;

procedure OnShowException(Msg: ShortString);
begin
  TObjectsMethods.MessageBox(Msg);
end;


Procedure Push_MsgErro(Const Str: AnsiString);
begin
  TObjectsMethods.Push_MsgErro(str);
  TObjectsMethods.LogError(str);
end;

Initialization
  PushMsgErro := @Push_MsgErro;
//  SysUtils.OnShowException := OnShowException;
  with TObjectsMethods do
  begin
    List_Class_Of_Char     := Get_List_Class_Of_Char;
    List_Class_Of_Char_GUI := Get_List_Class_Of_Char_GUI;
  end;

finalization


  with TObjectsMethods do
  begin
    freeandnil(List_Class_Of_Char);
    freeandnil(List_Class_Of_Char_GUI );
  end;




end.



