unit mi.rtl.Objects.Methods;
{:< - A Unit **@name** implementa a classe **TObjectsMethods** do pacote **mi.rtl**.

  - **NOTAS**
    - Esta unit foi testada nas plataformas: win32, win64 e linux.

  - **VERSÃO**
    - Alpha - Alpha - 0.8.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
    - **19/11/2021**
      - 21:25 a 23:15 Criar a unit mi.rtl.objects.TObjectsMethods.pas

    - **20/11/2021**
      - 18:00 a 19:15 Criar a unit mi.rtl.objects.tStream.pas
    - **27/07/2023**
      - 09:00 a 12:00 Criar método StringReplaceTgLink

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
  ,macuuid
  ,System.UITypes
//  ,StrUtils

  ,Process
//  ,Math
  ,dos

  ,sqlDB
  ,SQLite3Conn
  ,PQConnection

  ,FpHttpClient
  ,mi.rtl.Class_Of_Char
  ,mi.rtl.types
  ,mi.rtl.Consts
  ,mi.rtl.objects.consts
  ,mi.rtl.objects.consts.MI_MsgBox
  ,mi.rtl.objects.consts.progressdlg_if
  ,mi.rtl.objects.Consts.logs
  ,mi.rtl.MiStringList

  ;

  type
//    TObjectsMethods = class;
  {: - A classe **@name** implementa os método de classe comum a todas as classes de TObjects do pacote **mi.rtl**.}
  TObjectsMethods =
  class(TObjectsConsts)

  //Construção da propriedade Alias
  {$REGION '--->Construção da propriedade Alias'}
    Private  _Alias    : AnsiString;
    Protected Function GetAlias:AnsiString;Virtual;
    Protected Procedure SetAlias(Const aAlias:AnsiString);Virtual;
    Published  Property Alias : AnsiString Read GetAlias Write SetAlias;
  {$ENDREGION}
    public type TMI_MsgBox = mi.rtl.objects.consts.MI_MsgBox.TMI_MsgBox;
    public const MI_MsgBox: TMI_MsgBox = nil;
//    public Class Procedure Set_MI_MsgBox(aMI_MsgBox: TMI_MsgBox);virtual;abstract;

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
    Public class function MessageBox(const Msg: AnsiString): Word;Virtual;overload;

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
                                     DlgType: TMsgDlgType;
                                     Buttons: TMsgDlgButtons): TModalResult;Virtual;overload;


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

    public class FUNCTION IsValidPtr( ADDR:POINTER):BOOLEAN ;overload;

    public class FUNCTION IsValidPtr( const aClass: Tobject):BOOLEAN ;overload;

    public class  Function Name_Type_App_MarIcaraiV1 :AnsiString;

    public class Function Set_IsApp_VCL(aIsApp_VCL:Boolean):Boolean;

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

    {: O método **@name** ler um valor na tela e retorna em **aValue** o valor e em result
       retorna **MrOk** ou **MrCancel**}
    Public Class function InputValue(const aTitle,aLabel: AnsiString;var aValue : Variant): TModalResult;

    {: - A função **@name** mostra um dialogo com dois botões **OK** e **Cancel** e um campo input solicitando
         que o usuário digite um valor.

       - **RETORNA:**
         - **True** : Se o botão **ok** foi pŕessionando;
         - **False** : Se o botão **cancel** foi pŕessionando.
         - **aResult** : Retorna a string digitada no formulário;
    }
    Public Class Function Prompt(aTitle: AnsiString;aPergunta:AnsiString;Var aResult: Variant):Boolean;

    {: - A função **@name** mostra um dialogo solicitando o login do usuário e a senha e dois botões **OK**
         e **Cancel**

       - **RETORNA:**
         - **True** : Se o botão **ok** foi pŕessionando;
         - **False** : Se o botão **cancel** foi pŕessionando.
         - **aUsername** : Retorna a string com nome do usuário.
         - **apassword** : Retorna a string com a senha do usuário.
    }
    Public Class Function InputPassword(aTitle: AnsiString;out aUsername:AnsiString;out apassword:AnsiString):Boolean;Overload;

    Public Class Function InputPassword(aTitle: AnsiString;out apassword:AnsiString):Boolean;Overload;



    public class procedure DisposeSItems(VAR AItems: PSItem);overload;

    public class procedure DisposeSItems(Var AStrItems: PtString);overload;


    public class function  MaxItemStrLen(AItems: PSItem) : integer; Overload;

    public class function  MaxItemStrLen(PSItems: tString) : integer;Overload;

    public class function conststr ( i : Longint;  Const a : AnsiChar) : AnsiString;

    public class function centralizesStr(Const campo : AnsiString; Const tamanho : Integer) : AnsiString;

    public class Function TypeFld(Const aTemplate : tString;Var aSize : SmallWord):AnsiChar;overload;
    public class Function TypeFld(Const aTemplate : ShortString):AnsiChar;overload;

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
    public class Function SIF(Const Logica : Boolean; Const E1 , E2 : AnsiString ) : AnsiString ;

    public class function MinL(Const a,b:Longint):Longint;
    public  class function MaxL(Const a,b:Longint):Longint;

    public class function NumToStr(Const formato : AnsiString;buffer:Variant; Const Tipo : AnsiChar;Const OkSpc:Boolean):AnsiString;

    public class Function InsertCrtlJ(Const StrMsg:tString):tString;

    Private  const _Progress1Passo : TProgressDlg_If = nil;

    Public class procedure Create_Progress1Passo(ATitle : tstring;Obs:tstring ; ATotal : Longint);Virtual;

    Public class procedure Set_Progress1Passo(aNumber : Longint);Virtual;

    Public class procedure Destroy_Progress1Passo;Virtual;

    public class procedure LogError(const Fmt: String; Args: array of const);overload;
    public class procedure LogError (const Msg:AnsiString );overload;

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
      public class Function StringToSItem( StrMsg:AnsiString; Colunas : byte;Alinhamento:TAlinhamento):PSItem;virtual;overload;
      public class Function StringToSItem( StrMsg:AnsiString; Colunas : byte):PSItem;virtual;overload;

      public class function SItemsLen(S: PSItem) : SmallInt;
      public class Function SItemToString(Items: PSItem):AnsiString;

      {: A classe procedure **@name** retorna um TStringList com a lista passado por items

       - **NOTA**
         - S : Deve ser passado não inicializado, ouseja deve ser NIL.
      }
      Public class procedure WriteSItems(var S: TMiStringList;const Items: PSItem);
      Public class Function PSItem_ListaDeMsgErro:PSItem;virtual;
      Public class Procedure MessageError;virtual;

      {: O Método @name retorna uma lista de erros da pilha de erros;

      }
      Public class Function String_ListaDeMsgErro(Separador:String):AnsiString;Overload;

      {: A procedure **@name** esvazia a pilha de mensagens de error caso as mensagen não tenhão sido tratadas antes de encerrar TMI_Application.
      }
      public class Procedure Dispose_ListaDeMsgErro;virtual;

    {$ENDREGION}

    public class Function FMaiuscula(str:AnsiString):AnsiString;

    {: A função **@name** remove os acentos do texto pText

       - **REFERÊNCIA**
         - Exemplo completo: https://showdelphi.com.br/dica-funcao-para-remover-acentos-de-uma-string-delphi/
    }
    public class function AnsiString_to_USASCII(const pText: string): string;

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
    public class function Delspace(campo : Ansistring):AnsiString;
    Public class function GetNameValid(aName:AnsiString):AnsiString;
    public class Function IsNumber_Real(Const aTemplate : ShortString):Boolean;
    public class Function IsNumber(Const aTemplate : ShortString):Boolean;
    public class Function IsData(Const aTemplate : ShortString):Boolean;
    public class Function IsHora(Const aTemplate : ShortString):Boolean;
    public procedure HandleEvent(var Event: TEvent); Virtual;
    public procedure ClearEvent(var Event: TEvent);Virtual;

    public class Function Change_AnsiChar(campo : AnsiString; Const AnsiChar_Font,AnsiChar_Dest : AnsiChar):AnsiString;

    public class Function DeleteMask(S : tString;ValidSet: AnsiCharSet):AnsiString;overload;
    public class function DeleteMask(S: ShortString;aMask:ShortString): AnsiString;overload;
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

    {: O método @name remove as mascaras do número e retorna somente números

    }
    class function StrNumberValid(S: AnsiString): AnsiString;

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

    {$REGION '---> Construção da propriedade ID_Dinamic'}
      Private _ID_Dinamic   : AnsiString; //
      private Function GetID_Dinamic:AnsiString;
      {: - A propriedade **@name** retorno um string com um registro tipo
         [**TGuid**](https://www.freepascal.org/docs-html/rtl/system/tguid.html) para
         representar a classe.
      }
      Public  Property ID_Dinamic : AnsiString Read GetID_Dinamic;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgcustom'}
      Private _OnHTMLTag_tgcustom : THTMLTagEvent;

      {: - O evento **@name** retorna em *ReplaceText* o código preechido passado por
           *TagString* e *TagParams*.

         - **DESCRIÇÃO**
           - O método @name foi criado para processar todo template criado pelo
             usuário e que não tem relação com tags html.

         - **EXEMPLO DE TEMPLATE CUSTOMIZADO**
           - O template abaixo dentro de TPageProducer.FileName, informa para o
             método *@name* que a função *ListFilesText* deve retornar um texto
             com a lista de nomes de arquivos.

             ```pascal
                 <!-- Arquivo: template.txt -->

                 <!--# tgCustom [- ListFilesText=Arquivo: - "~FileName" -] #-->

             ```

           - O método *@name* retorna no prâmetro em **ReplaceText** a lista de texto.

             ```pascal

                 procedure TFPWebModule.@name(Sender: TObject; const TagString:  String; TagParams: TStringList; Out ReplaceText: String);override;

                   function ListFilesText(const atemplate,aPath,aMask :String) : string;
                     var
                       ListFiles : TStringList;
                       i : Integer;
                   begin
                     ListFiles := TStringList.Create;
                     try
                       with TObjectss do
                       begin
                         Result := New_Line;
                         FindFilesAll(aPath,aMask,faArchive ,ListFiles );// Retorna todos os arquivos da pasta e subpastas
                         For i := 0 to ListFiles.Count-1 do
                         begin
                           Result := result + StringReplace(atemplate,'~FileName'  , ListFiles.Strings[i]  , [rfReplaceAll]);// +  New_Line;
                         end;
                       end;

                     finally
                       FreeAndNil(ListFiles);
                     end;
                   end;

               begin

                  if AnsiCompareText(TagString, 'tgCustom') = 0 then
                  begin
                    s1 := TagParams.Values['ListFilesText'];
                    if s1 <> ''
                    Then begin //Retorna a lista de links.
                           ReplaceText:=ListFilesText(s1,'','*');
                         end;
                  end else
               end;


             ```
      }
      Public Property OnHTMLTag_tgcustom : THTMLTagEvent Read _OnHTMLTag_tgcustom write _OnHTMLTag_tgcustom ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgLink'}
      Private _OnHTMLTag_tgLink : THTMLTagEvent;

      {: - O evento **@name** retorna em *ReplaceText* o código preechido passado por *TagString* e *TagParams* onde
         *TagString* contém a tag *tgLink* e *TagParams* contém o template de um link html com os atributos
         hRef, target, title, text.

         - **DESCRIÇÃO**
           - O método **@name** foi criado para processar todos os templates referentes a links
             cuja a tag seja *tgLink* dentro do arquivo de templates.html

         - **EXEMPLO DE TEMPLATE **
           - O template abaixo dentro de TPageProduce.FileName, informa para o evento *@name*
             que os parâmetros BlogPsspAppBr e PsspAppBr deve ser preenchido com um link e
             a função *FindFilesAll* deve retornar um código html com uma lista de links de
             todos os nomes de arquivos dentro da pasta corrente e subpastas.

             ```pascal
                 <!-- Arquivo: template.html -->

                 <html>
                   <head>
                       <meta charset="UTF-8">
                       <title>Teste do componente mi.rtl.Objects.Methods.TPageProduce</title>

                       <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

                   </head>

                 <body>
                   <h3> Meu Blog </h3>

                   <p> A tag abaixo deve ser preenchida com o endereço: http://www.pssp.app.br
                        onde o destino da visualização é uma nova aba do browser<p>
                   <!--# tgLink [- BlogPsspAppBr=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->

                   <p> A tag abaixo deve ser preenchida com o endereço: http://www.pssp.app.br
                        onde o destino da visualização é uma variável definida no ato da produção
                        da página</p>
                   <!--# tgLink [-     PsspAppBr=[a href="~url" target="~target" title="~title"] ~text [/a]  -] #-->

                   <br>

                   <h3> Link com a lista de arquivos .html da pasta corrente</h3>
                   <!--# tgLink [- FindFilesAll=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->
                   <br>
                 </body>
                 </html>

             ```

           - O método *@name* retorna no prâmetro em **ReplaceText** o template acima preenchido.

             ```pascal

                 procedure TFPWebModule.@name(Sender: TObject; const TagString:  String; TagParams: TStringList; Out ReplaceText: String);override;
                 begin
                   if AnsiCompareText(TagString, 'tgLink') = 0 then
                   begin
                     s1 := TagParams.Values['BlogPsspAppBr'];
                     ReplaceText := TObjectss.StringReplaceTgLink('BlogPsspAppBr',
                                                                   s1,
                                                                   'http://www.pssp.app.br',
                                                                   '', // Mantém o destino definido no ptemplate
                                                                   'Blog do Paulo Sérgio da Silva Pacheco',
                                                                   'http://www.pssp.app.br  ➚');

                     s1 := TagParams.Values['PsspAppBr'];
                     if s1 <> ''
                     then ReplaceText := TObjectss.StringReplaceTgLink('PsspAppBr',
                                                                       s1,
                                                                       'http://www.pssp.app.br',
                                                                       '_self', //Abre o documento na mesma aba
                                                                       'Blog do Paulo Pacheco',
                                                                       'http://www.pssp.app.br')
                     else begin
                            s1 := TagParams.Values['FindFilesAll'];
                            if s1 <> ''
                            Then begin //Retorna a lista de links.
                                   ReplaceText:=ListFilesURLs(s1);
                                 end;
                          end;

                   end


                 end;

             ```

           - Notas:
             - A ação padrão de @name é executar o evento *OnHTMLTag_tgLink*, porém
               é possível ser redefinido para ter outro tipo de comportamento
               conforme preferência da aplicação que o utiliza.
      }
      Public Property OnHTMLTag_tgLink : THTMLTagEvent Read _OnHTMLTag_tgLink write _OnHTMLTag_tgLink ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgImage'}
      Private _OnHTMLTag_tgImage : THTMLTagEvent;
      Public Property OnHTMLTag_tgImage : THTMLTagEvent Read _OnHTMLTag_tgImage write _OnHTMLTag_tgImage ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgTable'}

      Private _OnHTMLTag_tgTable : THTMLTagEvent;

      {: O método **@name**  retorna em *ReplaceText* o código preechido passado
         por *TagString* e *TagParams*.

         - **EXEMPLO DE TEMPLATE**

           ```pascal
              <html>
                <head>
                     <meta charset="UTF-8">
                     <title>Teste do componente fptemplate</title>

                     <meta name="viewport" content="width=device-width, initial-scale=1.0"/>

                </head>

                <body>

                 List of records:
                 <table class="beautify1">
                   <tr class="beautify2">
                     <td class="beautify3">

                       <!--# tgTable

                         [- Header=
                           <table bordercolorlight="#6699CC" bordercolordark="#E1E1E1" class="Label">
                             <tr class="Label" align=center bgcolor="#6699CC">
                               <th>
                                 <font color="white">~Column1</font>
                               </th>
                               <th>
                                 <font color="white">~Column2</font>
                               </th>
                             </tr>
                         -]

                         [- OneRow=
                           <tr bgcolor="#F2F2F2" class="Label3" align="center">
                             <td>~Column1Value</td>
                             <td>~Column2value</td>
                           </tr>
                         -]
                         .
                         .snip, and so on more parameters if needed
                         .
                         [- NotFound=
                           <tr class="Error">
                             <td>There are no entries found.</td>
                           </tr>
                         -]

                         [- Footer=
                           </table>
                         -]

                       #-->

                      </td>
                    </tr>
                  </table>
                </body>

              </html>

           ```

           - **PARÂMETROS ESPERADOS EM  TagParams**
             - Header
             - OneRow
             - NotFound
             - Footer

         - **EXEMPLO DE CÓDIGO PARA PREENCHE O TEMPLATE ACIMA**

           ```pascal

               procedure TFPWebModule2.DoOnHTMLTag_tgTable(Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);

                 var
                   header, footer, onerow:String;
                   NoRecordsToShow:Boolean;
                   ColumnHeaders:array[1..2] of String;
                   ColumnValues:array[1..3,1..2]of String;
                   I:Integer;

               begin //Manipulação de tags de modelo HTML para um arquivo de modelo html

                 //Substitui a tag html tgTable usando seus parâmetros de tag
                 if AnsiCompareText(TagString, 'tgTable') = 0 then
                 begin
                   //preenche alguns arrays com dados (pode vir de uma consulta SQL)
                   NoRecordsToShow := false;

                   ColumnHeaders[1] := 'Amount';
                   ColumnHeaders[2] := 'Percentage';

                   ColumnValues[1,1] := '10.00';
                   ColumnValues[1,2] := '5';

                   ColumnValues[2,1] := '15.00';
                   ColumnValues[2,2] := '4';

                   ColumnValues[3,1] := '20.00';
                   ColumnValues[3,2] := '3';

                   //NoRecordsToShow pode ser algo como SQL1.IsEmpty , etc.
                   if NoRecordsToShow then
                   begin
                     //se não houver nada para listar, basta substituir toda a tag pelo
                     //Mensagem "Not Found" que o template contém
                     ReplaceText := TagParams.Values['NotFound'];
                     Exit;
                   end;

                   header := TagParams.Values['Header'];
                   //inserir parâmetros de cabeçalho
                   header := StringReplace(header, '~Column1', ColumnHeaders[1], []);
                   header := StringReplace(header, '~Column2', ColumnHeaders[2], []);

                   ReplaceText := header; //concluído com o cabeçalho (poderia estar em loop
                                          //através dos nomes dos campos da tabela também)

                   //inserir as linhas
                   onerow := TagParams.Values['OneRow'];//modelo para 1 linha

                   //percorre as linhas, pode ser algo como "while not SQL1.EOF do"
                   for I := 1 to 3 do
                   begin
                     ReplaceText := ReplaceText +
                                    StringReplace(StringReplace(onerow ,'~Column1Value', '$' + ColumnValues[I, 1], []),
                                                                        '~Column2value', ColumnValues[I, 2] + '%', []) +
                                    #13#10;
                   end;

                   //inserir o rodapé
                   footer := TagParams.Values['FOOTER'];

                   //substitua os parâmetros do rodapé se necessário
                   //...

                   ReplaceText := ReplaceText + footer;
                 end
                 else begin
                         //Valor não encontrado para tag -> TagString
                         ReplaceText := 'Etiqueta de modelo <!--#' + TagString + '#--> ainda não está implementado.';
                      end;
               end;

           ```

         - @url("#" 🔝)
      }
      Public Property OnHTMLTag_tgTable : THTMLTagEvent Read _OnHTMLTag_tgTable write _OnHTMLTag_tgTable ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgImageMap'}
      Private _OnHTMLTag_tgImageMap : THTMLTagEvent;
      Public Property OnHTMLTag_tgImageMap : THTMLTagEvent Read _OnHTMLTag_tgImageMap write _OnHTMLTag_tgImageMap ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgObject'}
      Private _OnHTMLTag_tgObject : THTMLTagEvent;
      Public Property OnHTMLTag_tgObject : THTMLTagEvent Read _OnHTMLTag_tgObject write _OnHTMLTag_tgObject ;
    {$ENDREGION}

    {$REGION '---> Construção da propriedade OnHTMLTag_tgEmbed'}
      Private _OnHTMLTag_tgEmbed : THTMLTagEvent;
      Public Property OnHTMLTag_tgEmbed : THTMLTagEvent Read _OnHTMLTag_tgEmbed write _OnHTMLTag_tgEmbed ;
    {$ENDREGION}

    {: - O método **@name** é usado para preencher templates html **tgLink** usado nos templates do componente *TPageProducer*.

       - PARÂMETROS
         - aAlias     = Apelido do template
         - atemplate  = <!--# tgLink [- %s=[a href="~url" target="_blank" title="~title"] ~text [/a]  -] #-->
         - aURL       = Endereço do link
         - atarget    = Destino onde a página deve ser aberta, se vazio abre na aba atual.
         - aTitle     = Documentação do link
         - aText      = Descrição do link

       - ATRIBUTOS DO TEMPLATE
         - ~alias     = Apelido do template;
         - ~url       = Endereço do link
         - ~target    = Destino onde a página deve ser aberta, se vazio abre na aba atual.
         - ~title     = Documentação do link
         - ~text      = Descrição do link
    }
    public class function StringReplaceTgLink(const aAlias, atemplate,aURL,atarget,aTitle,aText:String):string;

    protected procedure DoOnHTMLTag_tgCustom (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;

    protected procedure DoOnHTMLTag_tgLink    (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
    protected procedure DoOnHTMLTag_tgImage   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
    protected procedure DoOnHTMLTag_tgTable   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
    protected procedure DoOnHTMLTag_tgImageMap(Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
    protected procedure DoOnHTMLTag_tgObject  (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
    protected procedure DoOnHTMLTag_tgEmbed   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
    protected procedure DoReplaceTag(Sender: TObject; const TagString: String; TagParams: TStringList; out ReplaceText: String);Virtual;

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
      vidis : boolean = false;

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

  class function TObjectsMethods.MessageBox(const Msg: AnsiString): Word;
  begin
    if not vidis then
      with Mi_MsgBox do
      begin
        vidis := true;
        Result := MessageBox('',Msg,mtWarning, [mbOK],mbOk);
        vidis := false;
      end;
  end;

  class function TObjectsMethods.MessageBox(const aMsg: AnsiString;DlgType: TMsgDlgType; Buttons: TMsgDlgButtons): TModalResult;
  begin
    if not vidis then
      with Mi_MsgBox do
      begin
        vidis := true;
        Result := MessageBox(aMsg,DlgType,Buttons);
        vidis := false;
      end;
  end;

  class procedure TObjectsMethods.Abstracts;
    var s : AnsiString;
  begin
    s := TStrError.ErrorMessage5('mi.rtl','mi.rtl.Obejcts.Methods','TObjectsMethods','Abstracts','Método abstrato não implementado...' );
    LogError(TStrError.ErrorMessage(s));
    MessageBox(s);

    //raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.objects.Methods','TObjectsMethods','Abstract',211 ));
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

    class procedure TObjectsMethods.NNewStr(var PS: ptstring; const S: AnsiString
    );
    {Cria um novo string se Ps=nil do contrario troca Ps por S}
  Begin
    if Length(S)> 255
    then Begin
            LogError(TStrError.ErrorMessage('Exceção em Objects..function nNewStr(): String maior que 255'));
            raise  EArgumentException.Create('Exceção em Objects..function nNewStr(): String maior que 255');
  //         SysMessageBox(PAnsiChar('Exceção em Objects.NNewStr(): String maior que 255'),'Run time error',true);
  //         abort;
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
    Try
      Try

        If (P <> Nil)
        Then FreeMem(P, Length(P^) + 1);     { Release memory }

      Finally
        P  := nil;
      end;
    Except
    End;
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


  class function TObjectsMethods.IsValidPtr(ADDR: POINTER): BOOLEAN;
  Begin
   Try
     Result := (addr <> nil);
   Except
     Result := False;
   end;
  END;

  class function TObjectsMethods.IsValidPtr(const aClass: Tobject): BOOLEAN;
  Begin
   Try
     Result := (aClass <> nil)
  //              And (aClass Is TObject)
               and aClass.ClassNameIs(aClass.ClassName);      //Acessa um metodo do objeto se gerar excessao retorna false
   Except
  //    aClass := nil;
     Result := False;
   end;
  END;


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

    {$IFDEF App_ISAPI} // Aplicação web compilada como dll deve ser executada em conjunto com browser.
      Result := '/\/\ar/\carai - App_CGI '; //
    {$ENDIF}

    if Result = ''
    then begin
           RunError(ParametroInvalido);
         end;

  End;

  class function TObjectsMethods.Set_IsApp_VCL(aIsApp_VCL: Boolean): Boolean;
  Begin
    Result := IsApp_VCL;
    {$IFDEF GUI} //Aplicação Grafica .
      IsApp_VCL := aIsApp_VCL;
      IsApp_TV  := False;
    {$ELSE}
      if IsConsole
      then Begin
            IsApp_VCL := aIsApp_VCL;
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
    if MI_MsgBox <> nil
    then with MI_MsgBox do
         begin
           MI_MsgBox.MessageBox(aTitle,aMsg,mtWarning,[mbOk],mbOk);
         end;
  end;

    class procedure TObjectsMethods.ShowMessage(const aMsg: string);
  begin
    Alert('ATENÇÂO', aMsg);
  end;

  class function TObjectsMethods.Confirm(aTitle: AnsiString;aPergunta: AnsiString): Boolean;
  begin
    if MI_MsgBox <> nil
    then with MI_MsgBox do
         begin
           result := MI_MsgBox.MessageBox(aTitle,aPergunta,mtConfirmation,mbYesNo,mbYes)=mrYes;
         end;
  end;

  class function TObjectsMethods.InputValue(const aTitle, aLabel: AnsiString;var aValue: Variant): TModalResult;
  begin
    if MI_MsgBox <> nil
        then with MI_MsgBox do
             begin
               result := MI_MsgBox.InputValue(aTitle,aLabel,aValue);
             end;
  end;

  class function TObjectsMethods.Prompt(aTitle: AnsiString;aPergunta: AnsiString; var aResult: Variant): Boolean;
  begin
    Result := InputValue(aTitle,aPergunta,aResult)=MrOk;
  end;

  class function TObjectsMethods.InputPassword(aTitle: AnsiString; out aUsername: AnsiString; out apassword: AnsiString): Boolean;
  begin
    if MI_MsgBox <> nil
    then with MI_MsgBox do
         begin
//           result := MI_MsgBox.InputPassword(aTitle,aUsername,apassword)=MrOk;
           result := MI_MsgBox.InputPassword(aTitle,apassword)=MrOk;
         end;
  end;

  class function TObjectsMethods.InputPassword(aTitle: AnsiString; out apassword: AnsiString): Boolean;
  begin
    if MI_MsgBox <> nil
    then with MI_MsgBox do
         begin
//           result := MI_MsgBox.InputPassword(aTitle,aUsername,apassword)=MrOk;
           result := MI_MsgBox.InputPassword(aTitle,apassword)=MrOk;
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

  class procedure TObjectsMethods.DisposeSItems(var AItems: PSItem);
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
      LogError(TStrError.ErrorMessage8('',UnitName,ClassName,'DisposeSItems','','','Error ao desalocar lista PSitem',''));
      Raise;
    end;
  end;

  class procedure TObjectsMethods.DisposeSItems(var AStrItems: PtString);
    Var
      P : PSItem;
  Begin
    try
      If (AStrItems <> nil) and (AStrItems^ <> '') and (AStrItems^[1] in [fldSItems,fldENUM])
      Then Begin
             Case AStrItems^[1] of
               fldSItems,
               fldENUM : Begin
                            {$IFDEF CPU32}
                               Move(AStrItems^[2],P,4);
                            {$ENDIF}
                            {$IFDEF CPU64}
                               Move(AStrItems^[2],P,4+4);
                            {$ENDIF}

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
      LogError(TStrError.ErrorMessage8('',UnitName,ClassName,'DisposeSItems','','','Error ao desalocar lista PtString',''));
      Raise;
    end;
  end;

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


  class function TObjectsMethods.TypeFld(const aTemplate: tString;var aSize: SmallWord): AnsiChar;

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
                  fldSTRNUM,
                  fldSTR_Minuscula,
                  fldSTR             : Begin
                                         aSize := 1;
                                         For j := 1 to Length(aTemplate) do
                                           If  aTemplate[j] in [fldSTRNUM,fldSTR_Minuscula,fldSTR]
                                           then Inc(aSize);

                                         Result := aTemplate[i];
                                         Exit;
                                       End;

                  fldAnsiChar,
                  fldAnsiChar_Minuscula,
                  fldAnsiCharNUM,{<'o'. Obs: O "o" minusculo e usado para real Positivo}
                  fldAnsiCharVAL        : Begin
                                         aSize := 0;
                                         For j := 1 to Length(aTemplate) do
                                           If  aTemplate[j] in [fldAnsiChar,fldAnsiChar_Minuscula,fldAnsiCharNUM,fldAnsiCharVAL]
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

                  fldLData,
                  fld_LData,
                  fldLHora,
                  fld_LHora,
                  fldENUM,
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
                                         aSize := SizeOffldCluster ;
                                         Result := aTemplate[i]; Exit;
                                       end;
                  FldMemo,
                  fldBLOb            : Begin
                                         Move(aTemplate[i+1]  ,aSize, sizeof(Integer));
                                         Result := aTemplate[i];
                                         Exit;
                                       End;

                  fldData            : Begin
                                         aSize := Sizeof(TypeData);
                                         Result := aTemplate[i]; Exit;
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
           End; //<  If Not If_fldLData Then Begin.
  end;

  class function TObjectsMethods.TypeFld(const aTemplate: ShortString): AnsiChar;
    Var aSize : SmallWord;
  Begin
    Result := TypeFld(aTemplate,aSize);
  end;

  class function TObjectsMethods.IStr(const I: Longint; const Formato: tString
      ): tString;
    Var IAux : tString;
        Tam  : Longint;
  Begin
    Str(I:0,Iaux);
    Tam := length(formato)-length(IAux);
    If Tam > 0
    Then IStr := ConstStr(Tam,'0') + IAux
    Else IStr := IAux;
  End;

  class function TObjectsMethods.IStr(const I: Longint): tString;
  Begin
    Str(I:0,Result);
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
            If Formato[i] = Comma//','{'.'}
            Then Inc(NPontos);

          PosVirgula := pos(DecPt,Formato);//'.' {','}
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
  Begin
    Try
      divide(PIF,PFF,Pontos) ;
      case Tipo of
        fldRealNum,
        fldRealNum_Positivo : str(TRealNum(Buffer):PIF:PFF,Result);

        fldReal4,
        fldReal4P     : str(Real(Buffer):PIF:PFF,Result);

        fldBYTE       : Str(Byte(Buffer):PIF,Result);

        fldSHORTINT   : Str(SHORTINT(Buffer):PIF,Result);
        fldSmallInt   : Str(SmallInt(Buffer):PIF,Result);

        {fldWORD}
        FldSmallWord  : Str(SmallWord(Buffer):PIF,Result);
        
        fldENUM       : Str(LongInt(Buffer):PIF,Result);
        fldLONGINT    : Str(Longint(Buffer):PIF,Result);

        fldExtended : str(Extended(Buffer):PIF:PFF,Result);
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

     if True then


      If (PFF <> 0) and OkSpc {OkSpc foi implementado em tempo diferente do projeto inicial}
      Then Result[Pos(DecPt,Result)] := showDecPt{','};

    Except
      LogError(TStrError.ErrorMessage8('',UnitName,ClassName,'StrNum','','','Erro_Excecao_inesperada',''));
      raise EArgumentException.Create(TStrError.ErrorMessage5('mi.rtl','mi.rtl.objects.Methods','TObjectsMethods','StrNum',Erro_Excecao_inesperada));
      //Raise TException.Create(Name_Type_App_MarIcaraiV1,
      //                        'Db_Generic.Pas',
      //                        'StrNum(Formato: '+formato+' ,Valor: '+{buffer+}', Tipo: '+Tipo+')',
      //                        Erro_Excecao_inesperada);
      //
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


  class function TObjectsMethods.NumToStr(const formato: AnsiString;buffer: Variant; const Tipo: AnsiChar; const OkSpc: Boolean): AnsiString;
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
      If Formato[i] = showComma {',''.'}
      Then Insert(showComma,Result,j+1)
      else Begin
             Dec(j);
             If J <= 0
             Then break;{i := 1;}
           End;
    End;

    Pos_Z := Pos('Z',Formato);
    If Pos_z = 0 Then Pos_Z := Pos('z',Formato);
    If (Pos_Z <>0) and (Pos_Z < Pos(decPt{'.'},Formato))
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


  ///<summary>
  ///  :Converts Unicode string to Ansi string using specified code page.
  ///  <  @param   ws       Unicode string.
  ///  <  @param   codePage Code page to be used in conversion.
  ///  <  @returns Converted Ansi string.
  ///</summary>

        class function TObjectsMethods.WideStringToString(const ws: WideString
      ): AnsiString;
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



                class function TObjectsMethods.Set_FileModeDenyALL(
          const ModoDoArquivo: Boolean): Boolean;
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
             if s[i] in [#0..#31,'\','|','~','`']
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

    class function TObjectsMethods.StringToSItem( StrMsg: AnsiString;Colunas: byte; Alinhamento: TAlinhamento): PSItem;
      Var
        aStrMsg,ws  : AnsiString;
        MaxCol : Byte;
        S        : TMiStringList;
        i,LenStrMsg : Integer;
    Begin
      aStrMsg := '';
      MaxCol  := 0;
      try
        S :=  TMiStringList.Create;{<Insere a tString em ordem sequencial}
        s.Sorted := False;

        If (S=Nil) or (strMsg='') Then
        Begin
          result := nil;
          exit;
        End;

        LenStrMsg := length(StrMsg);

        for i := 1 to LenStrMsg do
        Begin
          if (strMsg[i] in [#13,#10,^Z{,^C,^M}]) or (MaxCol > Colunas) Then
          Begin
            While (aStrMsg<>'') and (aStrMsg[1] = ' ')  do
            begin
              Delete(aStrMsg,1,1);
            end;

            If strMsg[i] in [#13,#10,^Z{<,^C,^M}]
            Then begin
                   ws := StrAlinhado(aStrMsg,Colunas,Alinhamento)+constStr(NumberCharControl(aStrMsg),#0);
                   S.NewStr(ws)
                 end
            Else begin
                   ws := StrAlinhado(aStrMsg+ StrMsg[i],Colunas,Alinhamento)+constStr(NumberCharControl(aStrMsg),#0);
                   S.NewStr(ws);
                 end;

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
               S.NewStr(StrAlinhado(aStrMsg,Colunas,Alinhamento)+constStr(NumberCharControl(aStrMsg),#0));
               result := S.PListSItem;
             End;
        Discard(TObject(s));
      End;
    End;

    class function TObjectsMethods.StringToSItem(StrMsg: AnsiString;Colunas: byte): PSItem;
    begin
      result := StringToSItem(StrMsg,Colunas,Alinhamento_Justificado);
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
                        Result := StringToSItem(ListaDeMsgErro^.Value^,255,Alinhamento_Esquerda);
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
      MessageError_vidis :Boolean = False;
                class procedure TObjectsMethods.MessageError;
      {Este procedimento imprime a sequencia de mesagems de erro}
       Var
         I               : Integer;
         Wok             : Boolean;
         S               : AnsiString;
    Begin
      If MessageBoxOff or (Self = nil)
      then exit;

      try
        Wok := ok;
        If (Not ok_Set_Transaction) and (not MessageError_vidis)
        Then Begin
               Try
                 MessageError_vidis := true;
                  If ListaDeMsgErro <>  nil Then
                  with MI_MsgBox do
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
                 MessageError_vidis := false;
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

                class function TObjectsMethods.FMaiuscula(str: AnsiString): AnsiString;
  begin
    Result := Str;
    UpperCase(Result);
  end;

  class function TObjectsMethods.AnsiString_to_USASCII(const pText: string): string;
    //Exemplo completo: https://showdelphi.com.br/dica-funcao-para-remover-acentos-de-uma-string-delphi/
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

    If Mi_MsgBox <> nil
    Then with Mi_MsgBox do
         begin
            MessageBox(s,
                       mtInformation,
                       mbOKButton,
                        mbOk
                        );
         end
  end;

    class function TObjectsMethods.FGetMem(var Buff; const TamBuff: Word
    ): Boolean;
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

    class function TObjectsMethods.CGetMem(const BuffOriginal: Pointer;
    const TamBuff: Word): Pointer;
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
      If Mi_MsgBox <> nil
      Then with Mi_MsgBox do
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

        class function TObjectsMethods.ChangeSubStr(aSubStrOld: AnsiString;
      aSubStrNew: AnsiString; S: AnsiString): AnsiString; {:< Retorna S com o tString Trocado}
    Var
      Pos1,Pos2  : Integer;
  Begin
    Pos1 := Pos(FMaiuscula(aSubStrOld),FMaiuscula(S));
    If Pos1 <> 0
    Then begin
           if Pos1-1>0
           then Result := Copy(S,1,Pos1-1)
                        + aSubStrNew
                        + Copy(S,Pos1+Length(aSubStrOld),Length(s)-Pos1+Length(aSubStrOld) +1)
           Else Result :=
                          aSubStrNew
                        + Copy(S,Pos1+Length(aSubStrOld),Length(s)-Pos1+Length(aSubStrOld) +1)
        end
    Else Result := S;
  end;

        class function TObjectsMethods.Alias_To_Name(AAlias: AnsiString
      ): AnsiString;
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
  end;

  class function TObjectsMethods.GetNameValid(aName: AnsiString): AnsiString;
  begin
    Result := RemoveAccents(delspace(aName));
  end;

  class function TObjectsMethods.IsNumber_Real(const aTemplate: ShortString): Boolean;
  Begin
    Case TypeFld(aTemplate) of
      fldExtended,
      fldRealNum         ,
      fldRealNum_Positivo,
      fldReal4           ,
      fldReal4P          : Result := True
      Else                 Result := false;
    End;
  end;

  class function TObjectsMethods.IsNumber(const aTemplate: ShortString): Boolean;
  Begin
    Case TypeFld(aTemplate) of
      fldBYTE,
      fldSHORTINT,
      FldSmallWord,
      fldSmallInt,
      fldLONGINT,
      fldRealNum,
      fldRealNum_Positivo,
      fldReal4,
      fldReal4P,
      fldENUM,

      FldRadioButton : IsNumber:= True
      else         IsNumber:= False
    end;
  end;

  class function TObjectsMethods.IsData(const aTemplate: ShortString): Boolean;
  begin
    Result := TypeFld(aTemplate) in [fldData,fldLData,fld_LData,fldDateTimeDos];
  end;

  class function TObjectsMethods.IsHora(const aTemplate: ShortString): Boolean;
  begin
    Result := TypeFld(aTemplate) in [fld_LHora,fldLHora];
  end;

  procedure TObjectsMethods.HandleEvent(var Event: TEvent);
  Begin
    if (Event.What = evCommand) //and (Event.Command = CmTime) // nortsoft implementou o evento time
    then Begin
           If (Event.Command = CmTime) // nortsoft implementou o evento time
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

   class function TObjectsMethods.DeleteMask(S: tString;ValidSet: AnsiCharSet): AnsiString;
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

   class function TObjectsMethods.DeleteMask(S: ShortString; aMask: ShortString): AnsiString;
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

     For i :=  1 to LenS   do
     Begin
         if i <= Len_aMask then
         case aMask[i] of
           fldAnsiChar,fldAnsiChar_Minuscula,fldAnsiCharVAL
           ,fldSTRNUM,fldSTR,fldSTR_Minuscula
                : begin
                    Result := Result + S[i];
                  end;
            fldRealNum,fldReal4,fldReal4P,fldRealNum_Positivo,fldExtended
           ,fldENUM,fldBOOLEAN,fldBYTE,fldSHORTINT,fldSmallWORD,fldSmallInt,fldLONGINT,FldRadioButton
           ,fldData,fldLData,fld_LData,FldDateTimeDos
           ,fldLHora,fld_LHora
                : begin
                   if S[i] in ['0'..'9']
                   then Result := Result + S[i];
                 end;
         end;
     end;
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
    Begin
      Result := '';
      LenS := length(s);
      PosS := 0;
      Len_aMask := length(aMask);

      For i :=  1 to Len_aMask   do
      Begin
        case aMask[i] of
          fldAnsiChar,fldAnsiChar_Minuscula,fldAnsiCharVAL
          ,fldSTRNUM,fldSTR,fldSTR_Minuscula
          , fldRealNum,fldReal4,fldReal4P,fldRealNum_Positivo,fldExtended
          ,fldENUM,fldBOOLEAN,fldBYTE,fldSHORTINT,fldSmallWORD,fldSmallInt,fldLONGINT,FldRadioButton
          ,fldData,fldLData,fld_LData,FldDateTimeDos
          ,fldLHora,fld_LHora
               : begin
                   inc(posS);
                   if PosS <= LenS
                   then result := Result + s[posS];
//                   else result := Result + aMask[i];
                end;
          else begin
                 if aMask[i] = ' '
                 then system.Insert('_',result,i)  //O caractere deve ser passado como parâmetro. amanhã eu faço.
                 else system.Insert(aMask[i],result,i);

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

   class function TObjectsMethods.StrNumberValid(S: AnsiString): AnsiString;
    begin
      Result  := DeleteMask(S,['0'..'9','-','+',showDecPt]);
      if (pos(showDecPt ,Result)<>0) and (showDecPt<>DecPt)
      then begin
             Result := Change_AnsiChar(s,showDecPt,DecPt);
           end;
   end;

   class function TObjectsMethods.CheckRanger(S : AnsiString; aHigh, aLow: Int64; out aErr:Integer): Int64;
   begin
     aErr := 0;
     s := StrNumberValid(s);
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
         fldENUM ,
         fldLONGINT  : CheckRanger(s,High(Longint),Low(Longint),err);
         fldBOOLEAN,
         fldBYTE     : CheckRanger(s,High(byte),Low(byte),err);
         fldSHORTINT : CheckRanger(s,High(SHORTINT),Low(SHORTINT),err);
         fldSmallWORD: CheckRanger(s,High(SmallWord),Low(SmallWord),err);
         FldRadioButton: CheckRanger(s,High(TCluster),Low(TCluster),err);
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

   function TObjectsMethods.GetID_Dinamic: AnsiString;
   begin
     if _ID_Dinamic = ''
     then _ID_Dinamic := _ID_Dinamic;

     result := _ID_Dinamic;
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

   class  function TObjectsMethods.StringReplaceTgLink(const aAlias,atemplate,aURL,atarget,aTitle,aText:String):string;
   begin
      result :=  atemplate;
      Result := StringReplace(Result, '~alias'  , aAlias  , [rfReplaceAll]);
      Result := StringReplace(Result, '~url'    , aURL    , [rfReplaceAll]);
      Result := StringReplace(Result, '~target' , atarget , [rfReplaceAll]);
      Result := StringReplace(Result, '~title'  , aTitle, [rfReplaceAll]);
      Result := StringReplace(Result, '~text'   , aText, [rfReplaceAll]);
      Result := StringReplace(Result, '['       , '<', [rfReplaceAll]);
      Result := StringReplace(Result, ']'       , '>', [rfReplaceAll]);
   end;

   procedure TObjectsMethods.DoOnHTMLTag_tgCustom(Sender: TObject;const TagString: String; TagParams: tStrings; var ReplaceText: String);
   begin
     if Assigned(OnHTMLTag_tgCustom)
     then OnHTMLTag_tgCustom(Sender,TagString,TagParams,ReplaceText);
   end;

   procedure TObjectsMethods.DoOnHTMLTag_tgLink(Sender: TObject; const TagString: String; TagParams: tStrings; var ReplaceText: String);
   begin
     if Assigned(OnHTMLTag_tgLink)
     then OnHTMLTag_tgLink(Sender,TagString,TagParams,ReplaceText);
   end;

   procedure TObjectsMethods.DoOnHTMLTag_tgImage(Sender: TObject;  const TagString: String; TagParams: tStrings; var ReplaceText: String);
   begin
     if Assigned(OnHTMLTag_tgImage)
     then OnHTMLTag_tgImage(Sender,TagString,TagParams,ReplaceText);
   end;

   procedure TObjectsMethods.DoOnHTMLTag_tgTable   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);

    {Original:
      tgTable  = The TagString parameter is TABLE.
                 The TagParams describe a desired tabular image.
                 The event handler should return a sequence of HTML commands beginning with a
                 <TABLE> tag and ending with a </TABLE> tag.

      tgTable = O parametro de TagString e TABELA.
                O TagParams descrevem uma imagem tabelar desejada.
                O manipulador de evento deveria devolver uma sucessão de comandos de HTML que comecam com um
                <TABLE> etiqueta e terminando com um </TABLE> etiqueta.

      TAG=<#TABLE#>
    }

    Begin
      if Assigned(OnHTMLTag_tgTable)
      then OnHTMLTag_tgTable(Sender,TagString,TagParams,ReplaceText);
    end;

    procedure TObjectsMethods.DoOnHTMLTag_tgImageMap(Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
    Begin
      if Assigned(OnHTMLTag_tgImageMap)
      then OnHTMLTag_tgImageMap(Sender,TagString,TagParams,ReplaceText);
    end;

    procedure TObjectsMethods.DoOnHTMLTag_tgObject  (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
    Begin
      if Assigned(OnHTMLTag_tgObject)
      then OnHTMLTag_tgObject(Sender,TagString,TagParams,ReplaceText);

    end;

    procedure TObjectsMethods.DoOnHTMLTag_tgEmbed   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
    Begin
      if Assigned(OnHTMLTag_tgEmbed)
      then OnHTMLTag_tgEmbed(Sender,TagString,TagParams,ReplaceText);
    end;

    procedure TObjectsMethods.DoReplaceTag(Sender: TObject; const TagString: String; TagParams: TStringList; out ReplaceText: String);
    Begin
      {  If TagParams.Count = 0
        Then wTagString := Fmaiuscula(ShortString(TagString))
        Else wTagString := Fmaiuscula(ShortString(TagString+TagParams[0]));
      }

      If TagString = 'ACAO' // A Acao deve retorna o nome do executável +/+nome do comando+/+operacao
      Then Begin
             ReplaceText := '';
           end
      Else
      If TagString = 'ALIAS'
      Then Begin
             ReplaceText := Self.ALIAS;
           end
      Else
      If TagString = 'ID'
      Then Begin
             ReplaceText := ID_Dinamic;
           end
      Else
    {  If wTagString = 'SIZE'
      Then Begin
             ReplaceText := IntToStr(self.Size.X);
           end
      Else}
      If TagString = 'ACCESSKEY'
      Then Begin
             ReplaceText := ''; // Não tenho atalho baseado no inputLine
           end
      else
      If TagString = 'TIPODEACESSO'   //Deveria retorna ReadOnly DISABLED
      Then Begin
             ReplaceText := ''; // Não tenho tipo de acesso em tinputLine
           end
      else
      If TagString = 'ALIGN'   //deveria retorna "left" OU "center"  OU "right" OU "justify"
      Then Begin
             ReplaceText := ''; // Como inputLine e um texto como não tenho como determinar o alinhamento
           end;
    {  else
      If TagString = 'TABINDEX' // Deve retornar o numero de orden do botão
      Then Begin
             ReplaceText := IntToStr(tabindex);
           end;}

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
     Else Result := '';
   end;

   procedure TObjectsMethods.SetAlias(const aAlias: AnsiString);
   begin
     If aAlias <> ''
     Then _Alias   := AAlias
     else _Alias   := ClassName;
   end;

   class function TObjectsMethods.ShellScript(aCommand: String): String;
   begin
     RunCommand('/bin/bash',['-c',aCommand],result);
   end;





Initialization

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




