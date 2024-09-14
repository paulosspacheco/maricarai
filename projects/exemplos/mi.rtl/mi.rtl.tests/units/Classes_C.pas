unit Classes_C;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

  //Uses
  //  DBXJSON, DBXJSONReflect,
  //  HTTPProd,
  //  Web_HTTPProd,
  //  DB,
  //  SysUtils,
  //  Classes,
  //  VpSysLow,
  //  VpUsrLow,
  //  Memory,
  //  Strings,
  //  Unit_HTML_Interfaces,
  //  objects,
  //  //db_Global,
  //  //Tb_Access,
  //  use32;
  //

 
{---------------------------------------------------------------------------}
{                  TClass Class - BASE ANCESTOR Class                    }
{---------------------------------------------------------------------------}
TYPE

    TJSON_BaseObject = class
    public
      { public declarations }
      class function ObjectToJSON<T : class>(myObject: T): TJSONValue;
      class function JSONToObject<T : class>(json: TJSONValue): T;
    end;

  TNSComponent = Class(TComponent)
      private var FRefCount: Integer;
      Public function QueryInterface(const IID: TGUID; out Obj): Integer; stdcall;
      Public function _AddRef: Integer; stdcall;
      Public function _Release: Integer; stdcall;

      Public Function Owner_Component:TComponent; //Retorna o dono de TNSComponent.


      {$REGION '--->Constru��o da propriedade Alias'}
        Private  _Alias    : AnsiString;
        Protected Function GetAlias:AnsiString;Virtual;
        Protected Procedure SetAlias(Const aAlias:AnsiString);Virtual;
        Published  Property Alias : AnsiString Read GetAlias Write SetAlias;
      {$ENDREGION}

      //Constru��o da propriedade Path
      Private _Path  : AnsiString; {<Nome do diretorio}
      Protected Procedure SetPath(Const aPath:AnsiString);virtual;
      Public Property Path : AnsiString Read _Path Write SetPath;

      //Constru��o da propriedade Alias
      Private _ID_Dynamic   : AnsiString; // Usado para gerar paginas html dinamicamente
      Protected Function GetID_Dynamic:AnsiString;
      Public  Property ID_Dynamic : AnsiString Read GetID_Dynamic;

      //Protected
//      protected Function ID :AnsiString; Virtual;Abstract;//< Deve retorna o Identificador est�tico do objeto.
      public Function GetCurrentField:Pointer;overload;Virtual;//< Deve retornar o endere�o do corrente campo do registro
      public Function GetCurrentField(FieldNum:Longint):Pointer;overload;Virtual;//< Deve retornar o endere�o do corrente campo do registro

      //Implementa��o de produtores de p�ginas html
      Protected Function  TabIndex:Longint;Virtual; //< Retorna o numero de ordem do controlo no grupo.
      Function GetAcao():AnsiString;Virtual; //Retorna o link da a��o da classe
      protected procedure DoOnHTMLTag_tgLink    (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
      protected procedure DoOnHTMLTag_tgImage   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
      protected procedure DoOnHTMLTag_tgTable   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
      protected procedure DoOnHTMLTag_tgImageMap(Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
      protected procedure DoOnHTMLTag_tgObject  (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
      protected procedure DoOnHTMLTag_tgEmbed   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;
      protected procedure DoOnHTMLTag_tgCustom  (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);Virtual;

      //Aten��o: O m�todo DoOnHTMLTag deve ser declarado obrigatoriamente como: Public. Do contr�rio nao sera possivel pegar o endere�o do m�todo dinamicamente.
      Public procedure DoOnHTMLTag(Sender: TObject; Tag: TTag; const TagString: String;TagParams: tStrings; var ReplaceText: String);

      Protected function GetHelpCtx_Path: AnsiString;Virtual;

      Public function GetHelpCtx_Doc_HTML: AnsiString;Virtual; //Se quem herdar esta classe n�o for do tipo campo ent�o este metodo deve ser redefinido.

      /// <since>
      ///   �  Visualiza o texto associado ao corrnte campo da tabela.
      /// </since>
      Public function ExecViewHelpCtx_F1:Word;Virtual;
      
      /// <since>
      ///   �  Visualiza o arquivo HTML associado a tabela e posiciona o foco no campo corrente selecionado no formul�rio de edi��o.
      /// </since>
      Public function ExecViewHelpCtx_Alt_F1:Word;Virtual;

      /// <since>
      ///   �  Edita o arquivo HTML associado a tabela.
      /// </since>
      Public function ExecViewHelpCtx_Crtl_F1:Word;Virtual;
      
      Public function ExecViewHelpCtx:Word; //Se quem herdar esta classe n�o for do tipo campo ent�o este metodo deve ser redefinido.

      Const
        /// <since>
        ///   �  Se _EditViewHelpCtx_Ok_Create_File_HTML = true o m�todo EditViewHelpCtx deleta o arquivo HTML associado e cria um novo.
        /// </since>
      Protected          _EditViewHelpCtx_Ok_Create_File_HTML  : Boolean;// = false;     
      Protected function EditViewHelpCtx:Word;Virtual;

      function EventAvail: Boolean;Virtual;
      Protected procedure GetEvent(var Event: TEvent); Virtual;
      Protected procedure PutEvent(var Event: TEvent); Virtual;

      Protected function GetOwner: TPersistent; override;
      protected Function SetRecordAltered(Const aRecordAltered: Boolean):Boolean;Virtual;//< Set a propriedade RecordAltered e retorna o valor anterior
      protected procedure ChangeMadeOnOff(const aValue:Boolean);Virtual;

//Public - Atributos
      Public State    : Int64;{<Usado para controlar o estado do objeto}


      {$REGION ' ---> Property RecPosition : Longint '}
        Private var _RecPosition  : Longint;   //< Posi��o relativa ao inicio do arquivo independente da ordem
        Protected   Procedure SetRecPosition (aRecPosition : Longint );Virtual;

                  ///<since> Propriedade RecPosition do tipo Longint </since>
        Public property  RecPosition: Longint Read _RecPosition   Write  SetRecPosition;

      {$ENDREGION}


      {$REGION ' ---> Property CurrentRecord : Longint '}
        Private var _CurrentRecord : integer;  //< Posi��o absoluta do registro no arquivo.
        Protected   Procedure SetCurrentRecord (aCurrentRecord : Longint );Virtual;

                  ///<since> Propriedade CurrentRecord do tipo Longint </since>
        Public property  CurrentRecord: Longint Read _CurrentRecord   Write  SetCurrentRecord;

      {$ENDREGION}


//Cria��o da propriedade Procedure_GlobalStr. Obs: Nome da procedure global que executou a classe.
      private _Procedure_GlobalStr :AnsiString;
      protected Function GetProcedure_GlobalStr :AnsiString;virtual;
      Public property Procedure_GlobalStr: AnsiString read GetProcedure_GlobalStr write _Procedure_GlobalStr;

//Public - Metodos
      Public _HTMLContent : AnsiString; //< Nortsoft Usado gerar HTML final do dialogo

//   Public _Command   : Integer; // Comando que deve ser disparado quando Alt F7 for disparado.
//   Public StrCommand : AnsiString; // Nome do Comando que deve ser disparado quando Alt F7 for disparado.

   //Procedure SetCommand(aModulo,aCommand);
     {$REGION ' ---> Property Command : Integer '}
       strict Private Var _Command : Integer;
  //     strict Private Function  GetCommand : Integer;
       protected Procedure Set_Command(a_Command : Integer);Virtual;
       Published
                   ///<since>
                   ///  . Propriedade Command : Integer
                   ///  . Objetivo:  Comando acionado ao pressiona na tecla alt f7.
                   ///</since>
       property  Command: Integer Read _Command   Write  Set_Command;

       Public Procedure SetCommand (aModule:Byte;aCommand : Integer;AStrModule,aStrCommand:AnsiString);
     {$ENDREGION}

      {$REGION ' ---> Property Module : Byte '}
        Private _Module : Byte;

        Protected
                    ///<since>Pode ser redefinido para ler o molule informado na class dona da atual.</since>
          Function  GetModule : Byte;Virtual;

                    ///<since>Pode ser redefinido para gravar o molule informado na class dona da atual.</since>
          Procedure SetModule (aModule : Byte );Virtual;

        Published
                  ///<since>
                  ///  . Propriedade Module do tipo Byte.
                  ///  . Usado para separar os tipos de programas
                  ///  . Varia 0 a N modulos.
                  ///</since>
        property  Module: Byte Read GetModule   Write  SetModule;

      {$ENDREGION}



//Cria��o da propriedade HelpCtx_StrModule. Obs: Nome do M�dulo que est� utilizando esta classe.
      private _HelpCtx_StrModule :AnsiString;
      protected Function GetHelpCtx_StrModule :AnsiString;virtual;
      Public property HelpCtx_StrModule: AnsiString read GetHelpCtx_StrModule write _HelpCtx_StrModule;

//Cria��o da propriedade HelpCtx_StrCommand. Obs: Nome do comando que est� utilizando esta classe.
      Private _HelpCtx_StrCommand: AnsiString;
      protected Function GetHelpCtx_StrCommand: AnsiString; Virtual;
      Public property HelpCtx_StrCommand: AnsiString read GetHelpCtx_StrCommand write _HelpCtx_StrCommand;

//Cria��o da propriedade HelpCtx_StrCommand_Topic
      private _HelpCtx_StrCommand_Topic: AnsiString; //< Obs: Ao criar o objeto deve ser inicicializado pelo Alias da classe
      protected Function GetHelpCtx_StrCommand_Topic: AnsiString;virtual;
      Public property HelpCtx_StrCommand_Topic: AnsiString read GetHelpCtx_StrCommand_Topic write _HelpCtx_StrCommand_Topic;


//Cria��o da propriedade HelpCtx_StrCurrentModule. Obs: Corrente m�dulo em execu��o independente do m�dulo da classe.
      private _HelpCtx_StrCurrentModule :AnsiString;
      protected Function GetHelpCtx_StrCurrentModule :AnsiString;virtual;   //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentModule
      Public property HelpCtx_StrCurrentModule: AnsiString read GetHelpCtx_StrCurrentModule write _HelpCtx_StrCurrentModule;        //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentModule

//Cria��o da propriedade HelpCtx_StrCurrentCommand
      Private _HelpCtx_StrCurrentCommand: AnsiString;
      protected Function GetHelpCtx_StrCurrentCommand: AnsiString; Virtual;      //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand
      Public property HelpCtx_StrCurrentCommand: AnsiString read GetHelpCtx_StrCurrentCommand write _HelpCtx_StrCurrentCommand; //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand

//cria��o da propriedade HelpCtx_StrCurrentCommand_Opcao
      Private _HelpCtx_StrCurrentCommand_Opcao : AnsiString;
      Protected Function GetHelpCtx_StrCurrentCommand_Opcao: AnsiString; virtual; //< Nome da opcao ativa dentro do comando
      Public property HelpCtx_StrCurrentCommand_Opcao: AnsiString read GetHelpCtx_StrCurrentCommand_Opcao write _HelpCtx_StrCurrentCommand_Opcao; //< Nome da opcao ativa dentro do comando

//Cria��o da propriedade HelpCtx_StrCurrentCommand_Topic
      private _HelpCtx_StrCurrentCommand_Topic: AnsiString; //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic
      protected Function GetHelpCtx_StrCurrentCommand_Topic: AnsiString;virtual;
      Public property HelpCtx_StrCurrentCommand_Topic: AnsiString read GetHelpCtx_StrCurrentCommand_Topic write _HelpCtx_StrCurrentCommand_Topic;

//Cria��o da propriedade HelpCtx_StrCurrentCommand_Topic_Content_Run
      private _HelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run; //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic_Content_run;
      protected Function GetHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;virtual;
      Protected Procedure SetHelpCtx_StrCurrentCommand_Topic_Content_Run(wHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run);virtual;
      Public property HelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run read GetHelpCtx_StrCurrentCommand_Topic_Content_Run write SetHelpCtx_StrCurrentCommand_Topic_Content_Run;

//Cria��o da Propriedade Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File
//Cria��o da propriedade HelpCtx_StrCurrentCommand_Topic
      private _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean; //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic
      Protected  Function Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;Virtual;
      Protected  procedure Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);Virtual;
      Public property Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean read _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File write Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;

//Cria��o da propriedade HelpCtx_StrCurrentCommand_Topic_Content
      private _HelpCtx_StrCurrentCommand_Topic_Content: AnsiString; //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand_topic_Content;
      protected Function GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;virtual;
      protected Procedure SetHelpCtx_StrCurrentCommand_Topic_Content(wHelpCtx_StrCurrentCommand_Topic_Content:AnsiString);virtual;
      Public property HelpCtx_StrCurrentCommand_Topic_Content: AnsiString read GetHelpCtx_StrCurrentCommand_Topic_Content write SetHelpCtx_StrCurrentCommand_Topic_Content;

//Cria��o da propriedade HelpCtx_Hint
      Private _HelpCtx_Hint : AnsiString; //< NortSoft Obs: Texto com uma breve descri��o do objeto.
      Protected Function GetHelpCtx_Hint : AnsiString;VIRTUAL;
      Public property HelpCtx_Hint : AnsiString read GetHelpCtx_Hint write _HelpCtx_Hint; //< NortSoft Obs: Texto com uma breve descri��o do objeto.

//Cria��o da propriedade HelpCtx_Historico
      Private _HelpCtx_Historico : AnsiString;
      Protected Function GetHelpCtx_Historico : AnsiString;VIRTUAL;
      Public property HelpCtx_Historico : AnsiString read GetHelpCtx_Historico write _HelpCtx_Historico; //< NortSoft Obs: Texto com uma breve descri��o do objeto.

//Cria��o da propriedade HelpCtx_Porque
      Private _HelpCtx_Porque : AnsiString;
      Protected Function GetHelpCtx_Porque : AnsiString;VIRTUAL;
      Public property HelpCtx_Porque : AnsiString read GetHelpCtx_Porque write _HelpCtx_Porque; //< NortSoft Obs: Texto com uma breve descri��o do objeto.

//Cria��o da propriedade HelpCtx_Onde
      Private _HelpCtx_Onde : AnsiString;
      Protected Function GetHelpCtx_Onde : AnsiString;VIRTUAL;
      Public property HelpCtx_Onde : AnsiString read GetHelpCtx_Onde write _HelpCtx_Onde; //< NortSoft Obs: Texto com uma breve descri��o do objeto.

//Cria��o da propriedade HelpCtx_Como
      Private _HelpCtx_Como : AnsiString;
      Protected Function GetHelpCtx_Como : AnsiString;VIRTUAL;
      Public property HelpCtx_Como : AnsiString read GetHelpCtx_Como write _HelpCtx_Como; //< NortSoft Obs: Texto com uma breve descri��o do objeto.

//Cria��o da propriedade HelpCtx_Quais
      Private _HelpCtx_Quais : AnsiString;
      Protected Function GetHelpCtx_Quais : AnsiString;VIRTUAL;
      Public property HelpCtx_Quais : AnsiString read GetHelpCtx_Quais write _HelpCtx_Quais; //< NortSoft Obs: Texto com uma breve descri��o do objeto.


      Public Procedure DoBeforeCreate();Virtual;
      Public Procedure DoAfterCreate;Virtual;

      Public Function GetSelf : TNSComponent;
      Public Function BeforeOpen(Const APath,AAlias : tString):Boolean;Virtual;
      Public Function AfterOpen:Boolean;Virtual;
//      Public Constructor Create(Const APath,AAlias : tString);{verload;}override;
      Public Constructor Create(AOwner: TComponent);Overload;override;

      //Private _InstanceClass : TComponentClass; //deve se inicializado na classe herdeira
      Private Function GetInstanceClass : TComponentClass;
      Published Property InstanceClass : TComponentClass Read GetInstanceClass;

      Public Function CCreate(wInstanceClass : TComponentClass):TNSComponent;overload;Virtual;
      Public function CloneComponent (): TComponent;Virtual;


      Public Destructor Destroy; Override;
      Public function GetState(Const AState: Longint): Boolean;Virtual;

      Public Function SetState(Const AState: Int64; Const Enable: boolean):Boolean;overload;  Virtual;

      Public PROCEDURE Abort_Create;Virtual;
      //Declara��o das rotinas publicas de transa��o de banco de dados
      Public  function IsDB :Boolean;Virtual; //< Retorna Se True os m�todos abstratos de banco de dados foram implementados na classe filha de TNSComponent.

//      public Function RegIgualRegAnt:Boolean;VIRTUAL;


      //M�todos indicativo do tipode controle
      Public Function IsTable :ITable;Virtual;//<O objeto filho que implementar um tabela deve anular e retornar true;
      Public Function IsField :IHTML_Base;Virtual;//<O objeto filho que implementar um campo deve anular e retornar true;

      public Function IsGroup :Boolean;Virtual;//<O objeto filho que implementar um Groupdeve anular e retornar true;

      public Function IsFrame:IFrame;Virtual;//<O objeto filho que implementar uma windows deve anular e retornar o ponteiro de Self;

      public Function IsDialog:Boolean;Virtual;//<O objeto filho que implementar um dialogo deve anular e retornar true;

      Public function IsInputText:IInputText;Virtual;//< O objeto filho que implementar um campo de entrada de texto deve anular e retornar true;

      public function IsInputButton:IInputButton;Virtual;//< O objeto filho que implementar um bot�o deve anular e retornar true;
      public function IsInputRadio:IInputRadio;Virtual;//< O objeto filho que implementar um InputRadio deve anular e retornar true;

      public function IsInputCheckbox:IInputCheckbox;Virtual;//< O objeto filho que implementar um CheckBoxes deve anular e retornar true;
      public function isInputPassword:IInputPassword;Virtual;//< O objeto filho que implementar um InputPassword deve anular e retornar a interface IInputPassword;
      public function isInputHidden:IInputHidden;Virtual;//< O objeto filho que implementar um InputPassword deve anular e retornar a interface IInputPassword;
      public function IsSelect:ISelect;Virtual;//< O objeto filho que implementar um ISelect deve anular e retornar a interface ISelect;
      public function IsComboBox:Boolean;Virtual;//< O objeto filho que implementa um TComboBox deve anular e retornar true;
      public function IsMultiCheckBoxes:Boolean;Virtual;//< O objeto filho que implementar um MultiCheckBoxes deve anular e retornar true;
      public function IsListBox:Boolean;Virtual;//< O objeto filho que implementar um ListBox deve anular e retornar true;
      public function IsStaticText:Boolean;Virtual;//< O objeto filho que implementar um StaticText deve anular e retornar true;
      public function IsLabel:Boolean;Virtual;//< O objeto filho que implementar um Label deve anular e retornar true;
      public function IsWindow:Boolean;Virtual;//< O objeto filho que implementar um Window deve anular e retornar true;
      public function IsHistoryWindow:Boolean;Virtual;//< O objeto filho que implementar um HistoryWindow deve anular e retornar true;
      public function IsHistory:Boolean;Virtual;//< O objeto filho que implementar um THistory deve anular e retornar true;
      public function IsScroller:Boolean;Virtual;//< O objeto filho que implementa um TScroller deve anular e retornar true;
      public function IsGrid:Boolean;Virtual;//< O objeto filho que implementa um TGrid deve anular e retornar true;
      public function IsScrollBar:Boolean;Virtual;//< O objeto filho que implementa um TScrollBar deve anular e retornar true;

//      public procedure HandleEvent_PreProcess(var Event: TEvent); Virtual; //Executando antes de Inherited HandleEvent(var Event: TEvent)
      public procedure HandleEvent(var Event: TEvent); Virtual;
//      public procedure HandleEvent_PosProcess(var Event: TEvent); Virtual; //Executando depois de Inherited HandleEvent(var Event: TEvent)

      public procedure ClearEvent(var Event: TEvent);Virtual;
      Public Procedure ClearEvents;// Elimina todos os eventos pendentes.


      //*** Fim da declara��o abstratas de banco de dados. ***

    //Public
    //Constru��o da propriedade OkCreate
      //Constru��o da propriedade Alias
      Private  var _okCreate : Boolean;//<True   : A class foi inicializada completamente. ~ False  : A Class foi inicializa parcialmente.
      public Property OkCreate : Boolean Read _okCreate Default false;


      Public Function Top_Owner_NSComponent:TNSComponent;

      //Constru��o na propriedade Owner_NSComponent
      Private var _Owner_NSComponent : TNSComponent;
      Protected Procedure SetOwner_NSComponent(aOwner_NSComponent : TNSComponent);Virtual;
      Public property Owner_NSComponent : TNSComponent read _Owner_NSComponent write SetOwner_NSComponent;

      //Constru��o da propriedade RecordSelected
      Private var _RecordSelected  : boolean;
      protected Function GetRecordSelected : boolean;Virtual;

      protected Procedure SetRecordSelected(a_RecordSelected  : boolean);Virtual;
      Public property RecordSelected  : boolean read GetRecordSelected  Write SetRecordSelected;// default false;

      //Constru��o da propriedade FieldSelected
      Private var _FieldSelected : boolean;
      protected Procedure SetFieldSelected(a_FieldSelected : boolean);Overload;Virtual;
      protected Function GetFieldSelected: boolean;Overload;Virtual;
      Public property FieldSelected  : boolean read GetFieldSelected Write SetFieldSelected default false;

      //Contru��o da propriedade HTMLContent
      protected Function GetHTMLContent : AnsiString;Virtual;
      Public Property HTMLContent : AnsiString Read GetHTMLContent;// write SetHTMLContent;

      //Contru��o da propriedade OnHTMLTag
      Private  var _OnHTMLTag    : Boolean;
      Private Procedure SetOnHTMLTag(const aOnHTMLTag    : Boolean);
      Public Property OnHTMLTag  : Boolean Read _OnHTMLTag Write SetOnHTMLTag;

      //Contru��o da propriedade HTMLDoc
      Private Procedure SetHTMLDoc(Const aHTMLDoc: tStrings);
      Private Function GetHTMLDoc: tStrings;
      Public Property HTMLDoc  : tStrings Read GetHTMLDoc Write SetHTMLDoc;

      //Contru��o da propriedade PageProducer
      Protected Procedure SetHTMLFile(Const aHTMLFile: TFileName );Overload;Virtual;
      Protected Private Function GetHTMLFile : TFileName;Virtual;
      Public Property HTMLFile : TFileName read GetHTMLFile Write SetHTMLFile;

      Public Procedure SetHTMLFile();Overload;Virtual;//< Deve se definido em cada objeto herdado.

      //Contru��o da propriedade PageProducer

      Public Function  SaveHTMLContentToFile(FileNameDest:AnsiString):Integer;overload ;Virtual;
      Public Function  SaveHTMLContentToFile:Integer;overload ;Virtual;

      Private _PageProducer : Web_HTTPProd.TPageProducer;
      Public Property PageProducer : TPageProducer read _PageProducer write _PageProducer;

      Protected function CreateHTML : AnsiString;Overload;Virtual;

      //Contru��o da propriedade RecordAltered
      Private _RecordAltered  : Boolean; {Indica que o registro foi alterado. Deve ser atualizado na visao caso a tabela esteja em modo de edicao.}
      protected Procedure Set_RecordAltered(aSetRecordAltered:Boolean);VIRTUAL;
      Public Property RecordAltered   : Boolean read _RecordAltered write Set_RecordAltered;

      //Contru��o da propriedade FieldAltered
      Private _FieldAltered   : Boolean; {Indica que o corrente campo foi alterado. Deve ser atualizado na visao caso a tabela esteja em modo de edicao.}
      protected Function Get_FieldAltered:Boolean;VIRTUAL;
      protected Procedure Set_FieldAltered(aFieldAltered:Boolean);VIRTUAL;
      Public Property FieldAltered  : Boolean read Get_FieldAltered write Set_FieldAltered;

      //Contru��o da propriedade KeyAltered
      Private _KeyAltered   : Boolean; {Indica que o corrente campo foi alterado. Deve ser atualizado na visao caso a tabela esteja em modo de edicao.}
      protected Function Get_KeyAltered:Boolean;VIRTUAL;
      protected Procedure Set_KeyAltered(aKeyAltered:Boolean);VIRTUAL;
      Public Property KeyAltered      : Boolean read Get_KeyAltered write Set_KeyAltered;

      {$Region '---> Constru��o da propriedade Appending <---'

          TRUE  = Indica que um novo registro esta sendo editado.
          False = Indica que um registro existente est� sendo editado ou visualizado.

        Obs: Deve ser atualizado na visao caso a tabela esteja sendo editada
      }

        Private  _Appending        : Boolean; {}
        protected Function Get_Appending:Boolean;VIRTUAL;
        protected Procedure Set_Appending(aAppending:Boolean);VIRTUAL;
        Public Property Appending : Boolean read Get_Appending write Set_Appending;

      {$EndRegion '---> Constru��o da propriedade Appending <---'}


      {$Region '---> Constru��o da propriedade Append <---'

         // True = Adiciona o registro no final do arquivo.
         // False = Adiciona o registro na posi��o do primeiro registro livre do banco de dados.
      }

        Private _Append : Boolean;
        Protected Procedure SetAppend (aAppend:Boolean);Virtual;
        Public Property Append : Boolean Read _Append write SetAppend;

      {$EndRegion '---> Constru��o da propriedade Append <---'}


//Contru��o da propriedade Appending
      protected Function  Get_RecordLimit : longint;overload;Virtual;
      Public Property RecordLimit : longint read Get_RecordLimit;

  End;

  TClass = Class(TPersistent)
   Private
{True   : A class foi inicializada completamente.
 False  : A Class foi inicializa parcialmente.}
      _okCreate : Boolean;
{Apelido}
     _Alias  : AnsiString;// ptString;//
     Function GetAlias:AnsiString;
     Function GetClassName:String;
     Function GetMethodName:String;
     Procedure SetAlias(Const aAlias:AnsiString);

   Public
   {Usado para controlar o estado do objeto }
     State          : Longint;
      Function GetSelf : TClass;
      CONSTRUCTOR Create;Virtual;
      PROCEDURE Free;
      PROCEDURE Abort_Create;Virtual;
      DESTRUCTOR Destroy; Override;
      function GetState(Const AState: Longint): Boolean;Virtual;
      Function SetState(Const AState: Int64; Const Enable: boolean):Boolean;overload;  Virtual;
      Property OkCreate : Boolean Read _okCreate Write _okCreate Default false;

    Public
      Property Alias : AnsiString Read GetAlias Write SetAlias;
      Property ClassName : String read GetClassName ;
   END;

  function Message(Receiver: TNSComponent; What, Command: Word;InfoPtr: Pointer): Pointer;

//procedure Register;

function CloneComponent (aComponent: TComponent): TComponent;

//============================================================================
{$REGION '---> Function Convert Json '}
//============================================================================
        //Unserialize a string directly to a TJSONObject
        Function StrJSonToJSONObject(StrJSon: String):TJSONObject;

        //serialize a string directly from TJSONObject
        Function JSONObjectToStrJSon(aJSONObject :TJSONObject): String;
      //============================================================================

      /// <since>
      ///   . Receber um string json e retorna 2 arrays sendo um com o nomes e outro cam o valor dos pares
      ///   . Ex: Json = {"Cidade":"Fortaleza", "Estado":"cear�"}
      ///         Retorna:
      ///            . aNames = ['cidade,Estado']
      ///            . aValues =  ['Fortaleza','Ceara']
      /// </since>
      procedure StrJSonToArrays(StrJSon: String;Var aNames,aValues: TArrayOpenVariant);


      /// <since>
      ///   . Receber 2 arrays sendo um com o nomes e outro cam o valor dos pares e retorna um TJSONValue
      ///   . Ex:
      ///         Recebe:
      ///            . aNames = ['cidade,Estado']
      ///            . aValues =  ['Fortaleza','Ceara']
      ///         Retorna:
      ///            Json = {"Cidade":"Fortaleza", "Estado":"cear�"}
      /// </since>

      /// <since>
      ///   . Receber 2 arrays sendo um com o nomes e outro cam o valor dos pares e retorna um TJSONValue
      ///   . Ex:
      ///         Recebe:
      ///            . aNames = ['cidade,Estado']
      ///            . aValues =  ['Fortaleza','Ceara']
      ///         Retorna:
      ///            Json = {"Cidade":"Fortaleza", "Estado":"cear�"}
      /// </since>
      Function ArraysToJSONValue(Const aNames,aValues: TArrayOpenVariant ):TJSONValue;


{$ENDREGION}

FUNCTION IsValidPtr( aClass:TNSComponent):BOOLEAN ;Overload;
PROCEDURE DISCARD (Var AClass);

implementation

uses Db_Global, App;

{R *.dfm}

//uses App;

FUNCTION IsValidPtr (aClass:TNSComponent):BOOLEAN ;Overload;
Begin
  Try
    Result := (aClass <> nil)
              and (aClass.ClassNameIs(aClass.ClassName));      //Acessa um metodo do objeto se gerar excessao retorna false
  Except
//    aClass := nil;
    Result := False;
  end;
END;

PROCEDURE DISCARD (Var AClass);
 var
   Temp: TObject;
   WTaStatus : Integer;
   s : string;
begin
  try //Except
    try //Finally
      Temp := TObject(AClass);
      if Temp Is TNSComponent
      then begin
             if (Temp <> nil) and (temp.ClassNameIs(temp.ClassName))
             then Begin
                    S := (Temp as TNSComponent).Alias;
                    Pointer(AClass) := nil;
                    Temp.Free;
                  End
             Else begin
                    Pointer(AClass) := nil;
                    S := 'invalido';
                  end;
           end
      Else Begin
             if (Temp <> nil) and (temp.ClassNameIs(temp.ClassName))
             then Begin
                    S := (Temp as TObject).ClassName;
                    Pointer(AClass) := nil;
                    Temp.Free;
                  End
             Else begin
                    Pointer(AClass) := nil;
                    S := 'invalido';
                  end;
           End;

    Finally
       TaStatus := wTaStatus;
    end;

  Except
    if s<>'' then;
  end;

end;


Function DeleteAllAnsiChar(ConjNaoValido:AnsiCharSet;S:AnsiString):AnsiString;
  {
    Escluir um conjunto de caracateres do tString

    Exemplo
       S := '"Paulo.Sergio"';
       DeleteAllAnsiChar(['"','.'],S);

       Resultado: PauloSergio
  }
  Var
    i : Integer;
Begin
  Result := '';
  For i := 1 to length(S) do
     If Not (s[i] in ConjNaoValido)
     Then Result := Result + S[i];
end;

procedure Register;
begin
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TNSComponent]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TClass]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TCollection ]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TSortedCollection]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TStringCollection]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TStrCollection]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TUnSortedStrCollection]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TResourceCollection]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TResourceFile]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TStringList]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TStrListMaker]);

//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TStream]);

//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TCollRecsLocks]);
//  RegisterComponents(Name_Type_App_MarIcaraiV1, [TDosRecLock]);

{  RegisterComponents(Name_Type_App_MarIcaraiV1, [TDosStream]);
  RegisterComponents(Name_Type_App_MarIcaraiV1, [TBufStream]);
  RegisterComponents(Name_Type_App_MarIcaraiV1, [TMemoryStream]);
}

end;

//============================================================================
{$REGION '---> Function Convert JSON'}
//============================================================================
//      Exemplo de uso de StrJSonToJSONObject e StrJSonToJSONObject
//      function TServerMethods1.Locate(const KeyValues: TJSONValue;Options: integer): TJSONValue;
//
//      //function TServerMethods1.Locate(const KeyFields: String; const KeyValues: TJSONValue;Options: integer): TJSONValue;
//
//       //{"Nome":"Paulo","Cidade":"Fortaleza", "Estado":"cear�",  "Bairro":"Parquel�ndia"}
//
//        var
//          C : TClasse;
//        var
//         jo : TJSONObject;
//         p : TJSONPair;
//         i:integer;
//      begin
//        try
//         If KeyValues.Value<>''
//         Then begin
//                ShowMessage(KeyValues.Value);
//                Result := StrJSonToJSONObject(KeyValues.Value);
//
//                 ShowMessage(JSONObjectToStrJSon(Result as TJSONObject));
//
//                exit;
//
//              end;
//
//
//         jo := TJSONObject.Create;
//
//         //Na nota��o JSON, objetos s�o delimitados por
//         //e podem conter diversos pares separados por ,
//         //sendo que cada par � formado por chave e valor
//         jo.AddPair('Nome', TJSONString.Create('DELMAR')); //AddPair adiciona ao JSONObject um par com chave Nome e Valor DELMAR
//         jo.AddPair(TJSONPair.Create('Cidade', 'AJURICABA')); //Tamb�m podemos usar TJSONPair para criar um par
//         jo.AddPair(TJSONPair.Create('Bairro', 'CENTRO'));
//
//         p := jo.Get('Cidade');
//         ShowMessage(p.ToString);
//
//         Result := jo;
//
//
//        finally
//        end;
//      end;



      //Unserialize a string directly to a TJSONObject
      Function StrJSonToJSONObject(StrJSon: String):TJSONObject;


      //        down vote  I tried this but it didn't work: ...
      //
      //        var
      //
      //         j:TJSONObject;
      //
      //        begin
      //
      //         j := TJSONObject.Create;
      //         j.ParseJSONValue( BytesOf('{name:"francis", surname:"lee"}'),0);
      //        ...
      //
      //        end;



            //  Exemplo de uso:
            //procedure TForm1.Button1Click(Sender: TObject);
            //  var
            //    JSON: TJSONObject;
            //    I : Byte;
            //Begin
            //  JSON := StrJSonToJSONObject('{"Cidade":"Fortaleza","Estado":"Cear�","Bairro":"Parquel�ndia"}');
            //
            //  for I := 0 to JSON.Size - 1 do
            //    Memo1.Lines.Add(JSON.Get(I).JsonString.Value +
            //       ' : ' + JSON.Get(I).JsonValue.Value);
            //End;
      begin
        Result := TJSONObject.Create;
        Result.Parse(TEncoding.ASCII.GetBytes(StrJSon), 0);
  //    Assert(Result.ToString = StrJSon, 'Conversion test');
      end;

      //serialize a string directly from TJSONObject
      Function JSONObjectToStrJSon(aJSONObject :TJSONObject): String;
        var
         jo : TJSONObject;
         p : TJSONPair;
         I : Integer;

      begin
        Result := '';
        if aJSONObject=nil
        then exit;

        For i := 0 to aJSONObject.Size do
        begin
          p := aJSONObject.Get(i);
          if p<>nil
          then if Result<>''
               then Result := Result + ','+p.ToString
               Else Result := Result + p.ToString;
        end;
      end;


      /// <since>
      ///   . Receber um string json e retorna 2 arrays sendo um com o nomes e outro cam o valor dos pares
      ///   . Ex: Json = {"Cidade":"Fortaleza", "Estado":"cear�"}
      ///         Retorna:
      ///            . aNames = ['cidade,Estado']
      ///            . aValues =  ['Fortaleza','Ceara']
      /// </since>
      procedure StrJSonToArrays(StrJSon: String;Var aNames,aValues: TArrayOpenVariant);
        var
         JSONObject  : TJSONObject;
         P           : TJSONPair;
         i           : integer;
      Begin
        JSONObject := nil;
        If StrJSon <> ''
        Then Begin
                 {$REGION '---> Try finally'}
                      try
                        JSONObject := StrJSonToJSONObject(StrJSon);
                        Setlength(aNames,JSONObject.Size);
                        Setlength(aValues,JSONObject.Size);
                        for i := 0 to JSONObject.Size-1 do
                        begin
                          p := JSONObject.Get(i);
                           if P<>nil
                          then begin
                                 aNames [i] := DeleteAllAnsiChar(['"'],p.JsonString.ToString);
                                 aValues[i] := DeleteAllAnsiChar(['"'],p.JsonValue.ToString);
                               end;
                        end;

                      finally
                        Freeandnil(JSONObject);
                      end;
                 {$ENDREGION}
             End
        Else Begin
                Setlength(aNames,0);
                Setlength(aValues,0);
             End;
      End;


      /// <since>
      ///   . Receber 2 arrays sendo um com o nomes e outro cam o valor dos pares e retorna um TJSONValue
      ///   . Ex:
      ///         Recebe:
      ///            . aNames = ['cidade,Estado']
      ///            . aValues =  ['Fortaleza','Ceara']
      ///         Retorna:
      ///            Json = {"Cidade":"Fortaleza", "Estado":"cear�"}
      /// </since>
      Function ArraysToJSONValue(Const aNames,aValues: TArrayOpenVariant ):TJSONValue;
        var
         JSONObject  : TJSONObject;
         i           : integer;
      Begin
        Result := nil;
        JSONObject := nil;

        if high(aNames) <> high(aValues)
        then Abort;

        if high(aNames) = 0
        then exit;

        JSONObject := TJSONObject.Create;
        for i := 0 to high(aNames) do
        begin
          JSONObject.AddPair(TJSONPair.Create(aNames[i],aValues[i]));
        end;
        Result := JSONObject;
      End;

//============================================================================
{$ENDREGION}
//============================================================================

function Message(Receiver: TNSComponent; What, Command: Word;InfoPtr: Pointer): Pointer;
var
  Event: TEvent;
begin
  if Receiver <> nil
  then begin

          Event.What    := What;
          Event.Command := Command;
          Event.StrModule := '';
          Event.StrCommand := '';

          Event.InfoPtr := InfoPtr;

          Receiver.HandleEvent(Event);

          if Event.What = evNothing
          then Result := Event.InfoPtr
          Else Result := nil;
       end
  else Result := nil;
end;




{$REGION '---> TClass'}
    Function TClass.GetAlias:AnsiString;
    Begin
      If _Alias <> ''
      Then Result := _Alias
      Else Result := ClassName;
    end;

    Procedure TClass.SetAlias(Const aAlias:AnsiString);
    Begin
      If aAlias <> ''
      Then _Alias   := AAlias
      else _Alias   := ClassName;
    end;

    Function TClass.GetSelf : TClass;
    Begin
      Result := Self;
    end;

    Function TClass.GetClassName:String;
    Begin
      Result := Inherited ClassName;
    end;

    Function TClass.GetMethodName:String;
    Begin
      Result := Inherited MethodName(Self);
    end;


    CONSTRUCTOR TClass.Create;

    {VAR LinkSize: LongInt;
        Dummy: DummyClass;}
    BEGIN
     inherited Create;
     Alias := 'TClass.Create';
     okCreate := true;
    (*   LinkSize := LongInt(@Dummy.Data)-LongInt(@Dummy);  { Calc VMT link size }
       FillChar(Pointer(LongInt(Self)+LinkSize)^,SizeOf(Self)-LinkSize,#0); { Clear data Fields }
    *)
    END;

    {--TClass------------------------------------------------------------------}
    {  Free -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB              }
    {---------------------------------------------------------------------------}
    PROCEDURE TClass.Free;
    BEGIN
      { Dispose(TClass(Self), Destroy);}                     { Dispose of Self }
    {  Try}
       Inherited Free;
    {  Except
      end;}
    END;

    {--TClass------------------------------------------------------------------}
    {  Free -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 13Out01                  }
    {---------------------------------------------------------------------------}
    PROCEDURE TClass.Abort_Create;
    BEGIN
    //  DisposeStr(_Alias);
      okCreate := False;

      SysUtils.Abort;
    END;

    {--TClass------------------------------------------------------------------}
    {  Destroy -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB              }
    {---------------------------------------------------------------------------}
    DESTRUCTOR TClass.Destroy;
    BEGIN                                                 { Abstract method }
      okCreate := False;
      State    := 0;

      Try
    //    DisposeStr(_Alias);
        Inherited Destroy;
      Except
      end;
    END;

    function TClass.GetState(Const AState: Longint): Boolean;
    Begin
    {  If State and aState <> 0
      Then Result := True
      Else Result := false;}
      GetState := State and AState = AState;
    End;

    Function TClass.SetState(Const AState: Int64; Const Enable: boolean):Boolean;
      {Retorna o estado anterior do Mapa de bits passado por aState}
    Begin
    {  If State and aState <> 0
      Then Result := True
      Else Result := false;               }
      Result := State and AState = AState;

      if Enable
      then State := State or AState
      else State := State and not AState;
    End;

{$ENDREGION}


//*************************************************************************
 {$Region 'Implementa��o de TNSComponent ITMS '}
//*************************************************************************}


function TNSComponent.QueryInterface(const IID: TGUID; out Obj): Integer;
begin
  if GetInterface(IID, Obj) then
    Result := S_OK
  else
    Result := E_NOINTERFACE;
end;

function TNSComponent._AddRef: Integer;
begin
  Inc(FRefCount);
  Result := FRefCount;
end;

function TNSComponent._Release: Integer;
begin
  Dec(FRefCount);
  Result := FRefCount;
end;

Procedure TNSComponent.SetRecordSelected(a_RecordSelected  : boolean);
Begin
  _RecordSelected := a_RecordSelected;
end;

procedure TNSComponent.SetRecPosition(aRecPosition: Integer);
begin
  _RecPosition := aRecPosition;
end;

Function TNSComponent.Owner_Component:TComponent;
//Retorna o dono de TNSComponent.
Begin
  Result := inherited owner;
End;

Function TNSComponent.GetRecordSelected  : boolean;
Begin
  Result :=  _RecordSelected ;
end;

Procedure TNSComponent.SetFieldSelected(a_FieldSelected : boolean);
Begin
  _FieldSelected := a_FieldSelected;
end;


Function TNSComponent.GetFieldSelected: boolean;
Begin
  Result := _FieldSelected;
end;

Function TNSComponent.IsDB :Boolean;
//< Retorna Se True os m�todos abstratos de banco de dados foram implementados na classe filha de TNSComponent.
Begin
  Result := False;
end;

Function TNSComponent.GetHelpCtx_Hint : AnsiString;
Begin
  Result := _HelpCtx_Hint;
end;

Function TNSComponent.GetHelpCtx_Historico : AnsiString;
Begin
  Result := _HelpCtx_Historico;
end;

Function TNSComponent.GetHelpCtx_Porque : AnsiString;
Begin
  Result := _HelpCtx_Porque;
end;

Function TNSComponent.GetHelpCtx_Onde : AnsiString;
Begin
  Result := _HelpCtx_Onde;
end;

Function TNSComponent.GetHelpCtx_Como : AnsiString;
Begin
  Result := _HelpCtx_Como;
end;

Function TNSComponent.GetHelpCtx_Quais : AnsiString;
Begin
  Result := _HelpCtx_Quais;
end;

Function TNSComponent.GetSelf : TNSComponent;
Begin
  Result := Self;
end;


Procedure TNSComponent.DoBeforeCreate();
Begin

End;

Procedure TNSComponent.DoAfterCreate;
Begin

End;

Function TNSComponent.BeforeOpen(Const APath,AAlias : tString):Boolean;
  {OBJETIVO:
     Este � um metodo Override cujo a finalidade � inicializar as
     instacias dos objetos e em seguida inicializa as variáveis de instacias
     passados como parametro de Constructor.
  }
begin
  BeforeOpen := true;
End;

Function TNSComponent.AfterOpen:Boolean;
Begin
  AfterOpen := true;
End;

PROCEDURE TNSComponent.Abort_Create;
BEGIN
//  DisposeStr(Path);
//  DisposeStr(_Alias);
  _okCreate := False;
  SysUtils.Abort;
END;


Function TNSComponent.GetProcedure_GlobalStr :AnsiString;
Begin
  Result := _Procedure_GlobalStr;
end;

                    ///<since>Pode ser redefinido para ler o molule informado na class dona da atual.</since>
Function  TNSComponent.GetModule : Byte;
begin
  result := Self._Module;
end;

                    ///<since>Pode ser redefinido para gravar o molule informado na class dona da atual.</since>
Procedure TNSComponent.SetModule (aModule : Byte );
begin
 _Module := aModule;
end;

Procedure TNSComponent.SetCommand (aModule:Byte;aCommand : Integer;AStrModule,aStrCommand:AnsiString);
Begin
  Module := aModule;
  Command := aCommand;
  HelpCtx_StrModule   := AStrModule;
  HelpCtx_StrCommand  := aStrCommand;
End;

Function TNSComponent.GetHelpCtx_StrModule :AnsiString;
Begin
  Result := _HelpCtx_StrModule;

  if (Result = '') and (IsField<>nil)
  then Begin
         //Pega o nome do modulo na tabela dona
         if IsTable <> nil
         then Result := IsTable.HelpCtx_StrModule;
       end;
end;

Function   TNSComponent.GetHelpCtx_StrCurrentModule :AnsiString;
Begin
  Result := _HelpCtx_StrCurrentModule;
End;

Function TNSComponent.GetHelpCtx_StrCommand: AnsiString;

Begin
  Result := _HelpCtx_StrCommand;

  if Result = ''
  then Result := HelpCtx_StrCurrentCommand;
end;

Function TNSComponent.GetHelpCtx_StrCurrentCommand: AnsiString;
 //< Nortsoft Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand
Begin
  Result := _HelpCtx_StrCurrentCommand;
end;

Function TNSComponent.GetHelpCtx_StrCurrentCommand_Opcao: AnsiString;
 //< Nome da opcao ativa dentro do comando
Begin
  Result :=  _HelpCtx_StrCurrentCommand_Opcao;
End;

Function TNSComponent.GetHelpCtx_StrCommand_Topic: AnsiString;
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

Function TNSComponent.GetHelpCtx_StrCurrentCommand_Topic: AnsiString;
Begin
  if ExtractFileDrive(_HelpCtx_StrCurrentCommand_Topic) = ''
  then Result := _HelpCtx_StrCurrentCommand_Topic
  Else Result := ExtractFileName(_HelpCtx_StrCurrentCommand_Topic);
End;

Function TNSComponent.GetHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run;
Begin
  Result := _HelpCtx_StrCurrentCommand_Topic_Content_Run;
end;

Procedure TNSComponent.SetHelpCtx_StrCurrentCommand_Topic_Content(wHelpCtx_StrCurrentCommand_Topic_Content:AnsiString);
Begin
  _HelpCtx_StrCurrentCommand_Topic_Content := wHelpCtx_StrCurrentCommand_Topic_Content;
end;

Procedure TNSComponent.SetHelpCtx_StrCurrentCommand_Topic_Content_Run(wHelpCtx_StrCurrentCommand_Topic_Content_Run: TEnum_HelpCtx_StrCurrentCommand_Topic_Content_run);
Begin
  _HelpCtx_StrCurrentCommand_Topic_Content_Run := wHelpCtx_StrCurrentCommand_Topic_Content_Run;
end;

Function TNSComponent.Get_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File:Boolean;
Begin
  Result := _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
end;


function TNSComponent.Get_RecordLimit: longint;
begin
  Result := 0;
end;

procedure TNSComponent.Set_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File(a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File: Boolean);
Begin
  _Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File := a_Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File;
End;

Function TNSComponent.GetHelpCtx_StrCurrentCommand_Topic_Content: AnsiString;
Begin
  Result := _HelpCtx_StrCurrentCommand_Topic_Content;
end;

Constructor TNSComponent.Create(AOwner: TComponent);
{
  Para criar clones id�nticos � necess�rio usar padr�o:  constructor Create(AOwner: TComponent); virtual;
  e s� assim a chamada ao m�todo:
           Result :=  CCreate(InstanceClass) as TTabela;
  criar� a inst�ncia da class de forma correta.

  Obs: A Instancia deve iniciar a variável InstanceClass.

      Exemplo: InstanceClass : TArqProduto;

}

Begin
  if Not okCreate
  then Begin
         Inherited Create(AOwner);
         SetOwner_NSComponent(TNSComponent(AOwner));
         if Alias=''  // O alias sera <> '' quando antes de inicializar tnscomponent o alias for definido
         then If InstanceClass = nil
              Then Alias := Self.className
              Else Alias := InstanceClass.className;

         _ID_Dynamic := Alias+'_'+SysCreateGUID;
         Name := Alias_To_Name(_ID_Dynamic); //Obs: Name n�o pode ser repetido. Por isso � necess�rio criar uma fun��o para criar nome de componente de forma distinta.
       End;

  _okCreate := true;

//  Alias := AAlias;
//Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentModule
  HelpCtx_StrCurrentModule        := Db_Global.StrCurrentModule;

//Obs: Ao criar o objeto inicializa com Db_Global.StrCurrentCommand
  HelpCtx_StrCurrentCommand       := Db_Global.StrCurrentCommand;

  HelpCtx_StrCurrentCommand_Opcao := Db_Global.StrCurrentCommand_opcao;

  HelpCtx_StrCurrentCommand_Topic := Db_Global.StrCurrentCommand_Topic;

  HelpCtx_Hint                    := Db_Global.StrCurrentCommand_HelpCtx_Hint;
  _Recordselected := true;
End;

function TNSComponent.CreateHTML: AnsiString;
begin
  Result := '';
end;

Function TNSComponent.CCreate(wInstanceClass : TComponentClass):TNSComponent;//(InstanceClass: TComponentClass):TNSComponent; deve se inicializado na classe herdeira
{
  Para criar clones id�nticos � necess�rio usar padr�o:  constructor Create(AOwner: TComponent); virtual;
  e s� assim a chamada ao m�todo:
           Result :=  CCreate(InstanceClass) as TTabela;
  criar� a inst�ncia da class de forma correta.

  Obs: A Instancia deve iniciar a variável InstanceClass.

      Exemplo: InstanceClass : TArqProduto;

  Para vc criar Forms ou outros objetos sabendo apenas o nome da classe, vc tem que registrar essas
  classes pelo RegisterClass e depois acess�-las pelo nome(string), utilizando GetClass ou FindClass.
}

{

Procedure Teste_CCreate;
    ///Teste do m�todo: TNSComponent.CCreate
    ///
    /// Obs:
    ///   N�o funciona porque MarIcaraiV1 herdou as tecnicas do turbo vision e o mesmo
    ///   usar os constructor create com parametro variável e n�o usa o recurso de virtual e override .
    ///
    ///   Por isso o TArqBReceitas.Create; n�o � executado com este m�todo.

  Var
    Arq : TNsComponent;
Begin
   Arq := Arq.CCreate(TArqBReceitas);
   WriteLn(arq.alias);
   arq.free;
End;
}

var
  Instance: TNSComponent;
begin
  if wInstanceClass<>nil
  then Begin
         Instance := TNSComponent(wInstanceClass.NewInstance);
         TNSComponent(Result) := Instance;
         try
           Instance.Create(Self);
         except
            TNSComponent(Result) := nil;
            raise;
         end;
      end
 Else Result := nil;
end;

Function TNSComponent.GetInstanceClass : TComponentClass;
Begin
  Result := TComponentClass(ClassType);
End;

function CloneComponent (aComponent : TComponent): TComponent;
  /// <since>
  ///  Clona o objeto tipo TComponent;
  ///  Obs: Caso o costructor n�o seja override ent�o as propriedades e m�todos iniciais nas estancias
  ///  superiores a TComponet n�o ser�o inicializadas.
  ///
  /// Exemplo de uso
  ///
  /// Procedure TForm1.Button1Click(Sender: TObject);
  /// begin
  ///   with Clone (Edit1) as TControl do
  ///   begin
  ///     Parent := Self;
  ///     SetBounds (Edit1.Left,Edit1.Top + 30, Edit1.Width,Edit1.height);
  ///   end;
  /// end;
  /// </since>


  var
    mStream: Classes.TMemoryStream;
begin
  mStream := Classes.TMemoryStream.Create;
  try
    //Salva as propriedades atuais de aComponent em MStream
    mStream.WriteComponentRes(aComponent.Name, aComponent);
    mStream.Position := 0;

    //Gera um novo nome baseado no nome passado por aComponent
    randomize;
    aComponent.Name := aComponent.Name + IntToStr (random(10000));
//      aComponent.Name := aComponent.Name +'_'+SysCreateGUID; 

    //Cria uma nova instacia de aComponent
    Result := TComponentClass(aComponent.ClassType).Create(aComponent.Owner);

    //Restora as propriedades de mStream para Result
    mStream.ReadComponentRes(Result);

  finally
    mStream.Free;
  end;
end;

function TNSComponent.CloneComponent (): TComponent;

    //-------------------------------------------------------------------------------------
      {$Region '---> Exemplo de uso 1'
      -------------------------------------------------------------------------------------

        Procedure TForm1.Button1Click(Sender: TObject);
        begin
          with Edit1.CloneComponent as TControl do
            begin
              Parent := Self;
              SetBounds (Edit1.Left,Edit1.Top + 30, Edit1.Width,Edit1.height);
            end;
        end;

     }{$EndRegion '---> Exemplo de uso 1'}
    //-------------------------------------------------------------------------------------

    //-------------------------------------------------------------------------------------
      {$Region '---> Exemplo de uso 2  '
      -------------------------------------------------------------------------------------
       Type
         TObj = Class(TNSComponent)
           Private
             _x1,
             _x2 : Integer;
           Published property  x1 : Integer read _x1  Write _x1;
           Published property  x2 : Integer read _x2  Write _x2;

           Procedure Escreva;virtual;
      //     Constructor Create(ax1,ax2:integer); N�o funcionar� o clone caso o constructo seja desta forma
           Constructor Create(owner : TComponent);Override;
         End;

         TObj2 = Class(TObj)
           private
             _O : TObj;
           Published property  O : TObj read _o  Write _o ;

           Constructor Create(owner : TComponent);Override;
      //     Constructor Create(ax1,ax2:integer);N�o funcionar� o clone caso o constructo seja desta forma
           Procedure Escreva;Override;
         End;

         Constructor TObj.Create(owner : TComponent);
      //   Constructor TObj.Create(ax1,ax2:integer); N�o funcionar� o clone caso o constructo seja desta forma
         Begin
           Inherited Create(nil); //obs: Se passar owner para Inherited Create ent�o o clone n�o funcionar� direito.


           x1 := 1;//ax1;
           x2 := 2;//ax2;
         End;

         Procedure TObj.Escreva;
         Begin
           WriteLn('X1 =',x1,' -- X2 = ',x2);
         End;

         Constructor TObj2.Create(owner : TComponent);
      //   Constructor TObj2.Create(ax1,ax2:integer); N�o funcionar� o clone caso o constructo seja desta forma
         Begin
           inherited Create(owner );
      //     inherited Create(ax1,ax2 );

           O := TObj.Create(Self);
      //     O := TObj.Create(ax1,ax2);N
           o.X1 := x1+ 10; //ax1;
           o.x2 := x2+ 10; //ax2;
         End;

         Procedure TObj2.Escreva;
         Begin
           Inherited Escreva;
           if o<>nil
           then WriteLn('o.X1 =',o.x1,' -- o.X2 = ',o.x2);
         End;


        Procedure testeCloneComponent;
          Var
            Obj1,
            obj2  : TObj2;
        begin
          Obj1 := TObj2.Create(nil);
      //    Obj1 := TObj2.Create(1,2);
          obj1.Escreva;

          obj2 := obj1.CloneComponent() as Tobj2;
          obj2.Escreva;
        end;

      }{$EndRegion '---> Exemplo de uso 2  '}
    //-------------------------------------------------------------------------------------

begin
  Result := classes_C.CloneComponent(Self);
end;



Destructor TNSComponent.Destroy;
Begin
  _okCreate := False;
  State := 0;
  objects.Discard(TObject(_PageProducer));{<NortSoft}
  Inherited Destroy;
End;

function TNSComponent.GetState(Const AState: Longint): Boolean;
Begin
  If State and aState <> 0
  Then Result := True
  Else Result := false;
End;

Function TNSComponent.SetState(Const AState: Int64; Const Enable: boolean):Boolean;
  {Retorna o estado anterior do Mapa de bits passado por aState}
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

{         if (aState and Mb_Bit20 <> 0 ) and Not Enable
         then Begin
                WriteLn(False);
              end;}
       end;
End;

Function TNSComponent.GetAlias:AnsiString;
Begin
  If _Alias <> ''
  Then Result := _Alias
  Else Result := '';
end;

function TNSComponent.GetCurrentField: Pointer;
begin
  Result := nil;
end;

function TNSComponent.GetCurrentField(FieldNum: Integer): Pointer;
begin
   Result := nil;
end;

Procedure TNSComponent.SetAlias(Const aAlias:AnsiString);
Begin
  If aAlias <> ''
  Then _Alias   := AAlias
  else _Alias   := 'Alias Indefinido';

//  SELF.Name := Alias_To_Name(_Alias);
end;

Procedure TNSComponent.SetPath(Const aPath:AnsiString);
Begin
  If aPath <> ''
  Then _Path    := aPath
  else _Path    := '.\';
end;

Function TNSComponent.GetID_Dynamic:AnsiString;
Begin
  Result := _ID_Dynamic;
end;

Procedure TNSComponent.SetOnHTMLTag(Const aOnHTMLTag:Boolean);
{  Var
    Method            : TMethod;
    DoOnHTMLTagEvent  : THTMLTagEvent absolute Method;}
Begin
   If aOnHTMLTag
   Then Begin
          //se tiver assinalado deve ser descartado
          If objects.isValidPtr(_PageProducer)
          Then objects.Discard(TObject(_PageProducer));

//          Method.code := Self.MethodAddress('DoOnHTMLTag');
{          If Method.code <> nil
          Then Begin}
                 If PageProducer=nil
                 Then Begin
                        PageProducer := TPageProducer.Create(Self);
                        PageProducer.StripParamQuotes := false;
                      End;
//                 Method.Data  := Self;
                 PageProducer.OnHTMLTag := DoOnHTMLTag;//DoOnHTMLTagEvent;
                 _OnHTMLTag := True;
{               End
          Else _OnHTMLTag := false;}
        End
   Else Begin
          objects.Discard(TObject(_PageProducer));
          _OnHTMLTag := false;
        End;
End;

Procedure TNSComponent.SetHTMLFile(Const aHTMLFile: TFileName );

Begin
  If (aHTMLFile='') or (SeExiste(aHTMLFile))
  Then Begin
         OnHTMLTag := true;
         If OnHTMLTag
         Then begin
                 //function ExtractRelativePath(const BaseName, DestName: string): string; overload;
                 PageProducer.HTMLFile:= aHTMLFile
              end;
       End
  Else Begin
         OnHTMLTag := False;
         TaStatus  := ArquivoNaoEncontrado2;
       end;
end;

Function TNSComponent.GetHTMLFile : TFileName ;
Begin
  If OnHTMLTag
  Then Result := PageProducer.HTMLFile
  Else Result := '';
end;

Function  TNSComponent.SaveHTMLContentToFile(FileNameDest:AnsiString):Integer;
  Var
    PathDest : AnsiString;
    F        : Text;

begin
  Result := -1;
  If OnHTMLTag
  Then Begin
         Try  //Except
           PathDest := ExtractFileDir(FileNameDest);

           if Not ExisteDiretorio(PathDest)
           Then ok := CriaDiretorio(PathDest)
           Else ok := true;

           If ok
           Then Begin
                  AssignFile(F,FileNameDest);

                  {$I+}
                  rewrite(f);
                  {$I-}

                  Result := IoResult ;

                  If Result = 0
                  Then Begin
                         {$I+}
                         write(F,Self.HTMLContent);
                         {$I-}
                         Result := IoResult;

                         close(f) ;
                       End;

                End;
         Except
           if Result = 0
           then Result :=   Erro_Excecao_inesperada ;
           Raise
         end;
       End;
end;

Function  TNSComponent.SaveHTMLContentToFile:Integer;
Begin
  Result := -1;
End;

Procedure TNSComponent.SetHTMLDoc(Const aHTMLDoc: tStrings);
Begin
  OnHTMLTag := true;
  If OnHTMLTag
  Then PageProducer.HTMLDoc := aHTMLDoc;
end;

procedure TNSComponent.SetHTMLFile;
begin

end;

Function TNSComponent.GetHTMLDoc: tStrings;
Begin
  If OnHTMLTag
  Then Result := PageProducer.HTMLDoc
  Else Result := nil;
end;

Function TNSComponent.GetHTMLContent : AnsiString;
{< NortSoft
   Retorna O c�digo HTML implementados em:
     1 - TvDialogs.TButton      Retorna o c�digo Html associado ao bot�o
     2 - ViEditor.TDmxEditor    Retorna o código Html associado ao Dmx
     3 - ViEditor.TLIsDialog   Retorna a lista html
     4 - tvDMXBUF.TDmxEditBuf;  Retorna o formul�rio em forma de gride
     5 - View.TWindow           Retorna todos os c�digos html dentro da windows
     6 - TvDialogs.TDialog      Retorna o formul�rio completo <html lang="pt-BR"><head> </head> <bodY>  </body></html
}
Begin
  If OnHTMLTag
  Then Result := PageProducer.Content
  Else Result := '';
end;

Function  TNSComponent.TabIndex:Longint;
 //< Retorna o numero de ordem do controle no grupo.
Begin
  Result := -1;
end;

procedure TNSComponent.DoOnHTMLTag_tgLink    (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);

 {<
   O padr�o � substituir o link relativo a pasta ./html/Template/manual_d0_usuario.html
 }
Begin
 //Abstract
end;

procedure TNSComponent.DoOnHTMLTag_tgImage   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
Begin
 //Abstract
end;

Function TNSComponent.GetAcao():AnsiString;

  Function GetSubAcao(SubAcao:AnsiString):AnsiString;
  //<a href="/cgi-bin/GCIC.exe/XX">Cadastrar planos de pagamentos</a>
  //"/cgi-bin/GCIC.exe/CSistemaIntegrado,Cm_Arq_Plano_de_PagamentoI"
  Begin
    If SubAcao <> ''
    Then Result :=','+SubAcao
    Else Result := '';
  end;
  {
    Deve tornar um link para a��o
  }
Begin
  Result :=  Application.ParamExecucao.Dominio_Host+
             ExtractFileName(Application.ParamExecucao.NomeDeArquivosGenericos.NomeArqExe)+'/'+
             HelpCtx_StrCurrentModule+
             GetSubAcao(HelpCtx_StrCurrentCommand)+
             GetSubAcao(HelpCtx_StrCurrentCommand_Opcao);
end;

procedure TNSComponent.DoOnHTMLTag_tgTable   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
{Original:
  tgTable  = The TagString parameter is TABLE.
             The TagParams describe a desired tabular image.
             The event handler should return a sequence of HTML commands beginning with a
             <TABLE> tag and ending with a </TABLE> tag.

  tgTable = O parametro de TagString e TABELA.
            O TagParams descrevem uma imagem tabelar desejada.
            O manipulador de evento deveria devolver uma sucess�o de comandos de HTML que comecam com um
            <TABLE> etiqueta e terminando com um </TABLE> etiqueta.

  TAG=<#TABLE#>
}

 Var
   wTagString : AnsiString;


Begin
  If TagParams.Count = 0
  Then wTagString := Fmaiúscula(ShortString(TagString))
  Else wTagString := Fmaiúscula(ShortString(TagString+TagParams[0]));

  If wTagString = 'ACAO' // A Acao deve retorna o nome do execut�vel/+nome do comando/+operacao
  Then Begin
         ReplaceText := GetAcao;
       end
  Else
  If wTagString = 'SIZE'
  Then Begin
         ReplaceText := '';//IntToStr(Self.Size.X);
       end
  Else
  If wTagString = 'ACCESSKEY'
  Then Begin
         ReplaceText := ''; // N�o tenho atalho baseado no inputLine
       end
  else
  If wTagString = 'TIPODEACESSO'   //Deveria retorna ReadOnly DISABLED
  Then Begin
         ReplaceText := ''; // N�o tenho tipo de acesso em tinputLine
       end
  else
  If wTagString = 'ALIGN'   //deveria retorna "left" OU "center"  OU "right" OU "justify"
  Then Begin
         ReplaceText := ''; // Como inputLine e um texto como n�o tenho como determinar o alinhamento
       end
  else
  If wTagString = 'ALIAS'
  Then Begin
         ReplaceText := Self.ALIAS;
       end
  Else
  If wTagString = 'ID'
  Then Begin
         ReplaceText := ID_Dynamic;
       end
  Else
  If wTagString = 'TABINDEX' // Deve retornar o numero de orden do bot�o
  Then Begin
         If tabindex >= 0
         Then ReplaceText := IntToStr(tabindex)
         Else ReplaceText := '';
       end;
end;

procedure TNSComponent.DoOnHTMLTag_tgImageMap(Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
Begin
 //Abstract
end;

procedure TNSComponent.DoOnHTMLTag_tgObject  (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
Begin
 //Abstract
end;

procedure TNSComponent.DoOnHTMLTag_tgEmbed   (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
Begin
 //Abstract
end;

procedure TNSComponent.DoOnHTMLTag_tgCustom  (Sender: TObject; const TagString: String;TagParams: tStrings; var ReplaceText: String);
{<Original:
  tgCustom = The TagString parameter is an application-defined string.
             The event handler can convert the HTML-transparent tag in an application-specific manner.

  tgCustom = O par�metro de TagString � um string aplica��o-definido.
             O manipulador de evento pode converter a etiqueta HTML-transparente de uma maneira
             aplica��o-espec�fica.
}

Begin
{  If TagParams.Count = 0
  Then wTagString := Fmaiúscula(ShortString(TagString))
  Else wTagString := Fmaiúscula(ShortString(TagString+TagParams[0]));
}


  If TagString = 'ACAO' // A Acao deve retorna o nome do execut�vel +/+nome do comando+/+operacao
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
         ReplaceText := ID_Dynamic;
       end
  Else
{  If wTagString = 'SIZE'
  Then Begin
         ReplaceText := IntToStr(Self.Size.X);
       end
  Else}
  If TagString = 'ACCESSKEY'
  Then Begin
         ReplaceText := ''; // N�o tenho atalho baseado no inputLine
       end
  else
  If TagString = 'TIPODEACESSO'   //Deveria retorna ReadOnly DISABLED
  Then Begin
         ReplaceText := ''; // N�o tenho tipo de acesso em tinputLine
       end
  else
  If TagString = 'ALIGN'   //deveria retorna "left" OU "center"  OU "right" OU "justify"
  Then Begin
         ReplaceText := ''; // Como inputLine e um texto como n�o tenho como determinar o alinhamento
       end;
{  else
  If TagString = 'TABINDEX' // Deve retornar o numero de orden do bot�o
  Then Begin
         ReplaceText := IntToStr(tabindex);
       end;}

end;

procedure TNSComponent.DoOnHTMLTag(Sender: TObject; Tag: TTag; const TagString:  String;TagParams: tStrings; var ReplaceText :  String) ;


{ Original:
   The TagString parameter is the tag name of the HTML-transparent tag.
   If the Tag parameter is tgCustom, TagString should be used to determine what conversion to perform.
   The TagParams parameter gives the parameter portion of the HTML-transparent tag.
   Each string in the tStrings object has the form ParamName=Value.
   Use the Names and Values properties of the tStrings object to parse these parameters.

   The DoOnHTMLTag event handler should return the converted HTML commands in the ReplaceText parameter.
   The returned value can contain HTML-transparent tags for another page producer to convert.
   For example, one page producer might have a Template that represents the format of the final HTTP
   response. It could read the HTTP request and for each section in the request assemble a set of
   HTML-transparent tags with parameters based on the request.
   Another page producer might take the content of the first page producer, and interpret those
   parameters.

  Traduzido:
     O par�metro de TagString � o nome de etiqueta da etiqueta HTML-transparente.
     Se o par�metro de Etiqueta � tgCustom, TagString deveria ser usado para determinar que convers�o
     para executar.
     O par�metro de TagParams d� a por��o de par�metro da etiqueta HTML-transparente.
     Cada string no objeto de tStrings tem a forma ParamName=Value.
     Use os Nomes e Estima propriedades do tStrings objetam para analisar gramaticalmente estes
     par�metros.

     O DoOnHTMLTag evento manipulador deveria devolver os comandos de HTML
     convertidos no par�metro de ReplaceText.
     O valor devolvido pode conter etiquetas HTML-transparentes para outro produtor de p�gina converter.
     Por exemplo, um produtor de p�gina poderia ter um modelo que representa o formato da resposta de
     HTTP final. Poderia ler o HTTP pedem e para cada se��o no pedido ajunte um jogo de etiquetas
     HTML-transparentes com par�metros baseado no pedido. Outro produtor de p�gina poderia levar
     o conte�do do primeiro produtor de p�gina, e interpreta esses par�metros.
}


{

 Evento OnHTMLTag
     O componente PageProducer apresenta apenas um evento: o evento OnHTMLTag.
     � nesse evento que � definido o c�digo HTML usado para substituir os tags transparentes lidos pelo PageProducer.
     O evento � chamado uma vez para cada tag transparente encontrado.

     OnHTMLTag recebe v�rios par�metros importantes. Veja quais s�o, no seguinte c�digo b�sico do evento.

     Procedure TwebModule1.pageProducer1HTMLTag(Sender: Tobject; Tag: Ttag; const      TagString:String; TagParams: Tstring; var ReplaceText: String);
     Begin

     end;

     O par�metro TagString recebe o nome do tag transparente. Para o tag transparente <#data> por exemplo,
     TagString seria �data�. O texto no par�metro TagString deve ser verificado pelo programa, para determinar
     o c�digo HTML a ser usado para a substitui��o do tag transparente.

     O par�metro ReplaceText � passado por referencia para o c�digo do evento OnHTMLTag. � inicialmente um
     String vazio. Dentro do c�digo para evento, ReplaceText deve receber um String com o c�digo HTML
     usado para substituir o tag transparente.

     Em TagParams s�o armazenados os par�metros do tag transparente. Os par�metros s�o armazenados na forma
     Nome=Valor e podem ser acessados usando as propriedades Names e Values. Por exemplo, para o tag:

     <#calend�rio ano=2001 m�s=12>

     Ter�amos o seguinte: TagParams.Names[0] = �m�s�
     TagParams.Names[1] = �ano�
     TagParams.Values[�ano�] = �1999�
     TagParams.Values[�m�s�] = �12�

     Caso o tag transparente n�o apresente par�metros, os valores retornados para Values e Names ser�o tStrings vazios.
}
Begin
  Case Tag of
    tgCustom   : DoOnHTMLTag_tgCustom  (Sender,TagString,TagParams, ReplaceText);
    tgLink     : DoOnHTMLTag_tgLink    (Sender,TagString,TagParams, ReplaceText);
    tgImage    : DoOnHTMLTag_tgImage   (Sender,TagString,TagParams, ReplaceText);
    tgTable    : DoOnHTMLTag_tgTable   (Sender,TagString,TagParams, ReplaceText);
    tgImageMap : DoOnHTMLTag_tgImageMap(Sender,TagString,TagParams, ReplaceText);
    tgObject   : DoOnHTMLTag_tgObject  (Sender,TagString,TagParams, ReplaceText);
    tgEmbed    : DoOnHTMLTag_tgEmbed   (Sender,TagString,TagParams, ReplaceText);
  End;
end;

//Contru��o da propriedade RecordAltered
Function TNSComponent.SetRecordAltered(Const aRecordAltered: Boolean):Boolean;
Begin
  Result := RecordAltered;
  RecordAltered:= aRecordAltered;
End;

Procedure TNSComponent.Set_RecordAltered(aSetRecordAltered:Boolean);
Begin
  _RecordAltered := aSetRecordAltered;
end;

//Contru��o da propriedade FieldAltered
Function TNSComponent.Get_FieldAltered:Boolean;
Begin
  Result := _FieldAltered;
end;

Procedure TNSComponent.Set_FieldAltered(aFieldAltered:Boolean);
Begin
  _FieldAltered := aFieldAltered;
  if _FieldAltered
  then Self.RecordAltered := true;
end;

//Contru��o da propriedade KeyAltered
Function TNSComponent.Get_KeyAltered:Boolean;
Begin
  Result := _KeyAltered;
end;

Procedure TNSComponent.Set_KeyAltered(aKeyAltered:Boolean);
Begin
  _KeyAltered := aKeyAltered;
end;


//Contru��o da propriedade Appending
Function TNSComponent.Get_Appending:Boolean;
Begin
  Result := _Appending;
End;

Procedure TNSComponent.Set_Appending(aAppending:Boolean);
Begin
  _Appending := aAppending;
end;

procedure TNSComponent.Set_Command(a_Command: Integer);
begin
  _Command := a_Command;
end;

Procedure TNSComponent.SetAppend (aAppend:Boolean);
Begin
  _Append  := aAppend;
End;


procedure TNSComponent.SetCurrentRecord(aCurrentRecord: Integer);
begin
//  _CurrentRecord := aCurrentRecord;
  if aCurrentRecord>0
  then begin
         _CurrentRecord := aCurrentRecord;
       end
  Else Begin
          _CurrentRecord := aCurrentRecord;
       End;

end;

{Function TNSComponent.RegIgualRegAnt:Boolean;
Begin
  Result := true;
end;}

procedure TNSComponent.ChangeMadeOnOff(const aValue:Boolean);
Begin
  FieldAltered  := aValue;
  RecordAltered := aValue;
  KeyAltered    := aValue;
{ N�o posso alterar as variáveis abaixo porque SetupRecord chama ChangeMadeOnOff(false;
  RecordSelected := false;
  FieldSelected  := false;
}
End;
{
function TNSComponent.IsFirstField : Boolean;
Begin
  If GetCurrentField <> nil
  Then Result := GetCurrentField = FirstField
  Else Result := False;
end;

function TNSComponent.IsLastField: Boolean;
Begin
  If GetCurrentField <> nil
  Then Result := GetCurrentField = LastField
  Else Result := False;
end;}

//M�todos indicativo do tipode controle

Function TNSComponent.IsTable :ITable;//<O objeto filho que implementar um tabela deve anular e retornar true;
Begin
   result := nil;
end;
Function TNSComponent.IsField :IHTML_Base;
//<O objeto filho que implementar um campo deve anular e retornar true;
Begin
   result := nil;
end;


Function TNSComponent.IsGroup :Boolean;//<O objeto filho que implementar um Groupdeve anular e retornar true;
 { M�todos e atributos b�sicos de um grupo:
     1 -
 }
Begin
  result := false;
end;

Function TNSComponent.IsFrame:IFrame;
//<O objeto filho que implementar uma windows deve anular e retornar o ponteiro de Self;
begin
  Result := nil;
end;

Function TNSComponent.IsDialog:Boolean;//O objeto filho que implementar um dialogo deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsInputText:IInputText;//O objeto filho que implementar um campo de entrada de texto deve anular e retornar true;
Begin
  Result := nil;
end;

Function TNSComponent.IsInputButton:IInputButton;//O objeto filho que implementar um bot�o deve anular e retornar true;
Begin
  Result := nil;
end;

Function TNSComponent.IsInputRadio:IInputRadio;//O objeto filho que implementar um InputRadio deve anular e retornar true;
Begin
  Result := nil;
end;

Function TNSComponent.IsInputCheckbox:IInputCheckbox;//O objeto filho que implementar um CheckBoxes deve anular e retornar true;
Begin
  Result := nil;
end;

function TNSComponent.IsInputPassword:IInputPassword;//< O objeto filho que implementar um InputPassword deve anular e retornar a interface IInputPassword;
Begin
  Result := nil;
end;

function TNSComponent.isInputHidden:IInputHidden;//< O objeto filho que implementar um InputPassword deve anular e retornar a interface IInputPassword;
Begin
  Result := nil;
end;

function TNSComponent.IsSelect:ISelect;//< O objeto filho que implementar um ISelect deve anular e retornar a interface ISelect;
Begin
  Result := nil;
end;

Function TNSComponent.IsMultiCheckBoxes:Boolean;//O objeto filho que implementar um MultiCheckBoxes deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsListBox:Boolean;//O objeto filho que implementar um ListBox deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsStaticText:Boolean;//O objeto filho que implementar um StaticText deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsLabel:Boolean;//O objeto filho que implementar um Label deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsWindow:Boolean;//O objeto filho que implementar um Window deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsHistoryWindow:Boolean;//O objeto filho que implementar um HistoryWindow deve anular e retornar true;
Begin
  Result := False;
end;

Function TNSComponent.IsHistory:Boolean;//O objeto filho que implementar um THistory deve anular e retornar true;
Begin
  Result := False;
end;

function TNSComponent.IsScroller:Boolean;//< O objeto filho que implementar um TDmxEditor deve anular e retornar true;
Begin
  Result := False;
end;

function TNSComponent.IsComboBox:Boolean;//< O objeto filho que implementa um TComboBox deve anular e retornar true;
Begin
  Result := False;
end;

function TNSComponent.IsGrid:Boolean;
//< O objeto filho que implementa um TGrid deve anular e retornar true;
Begin
  Result := False;
end;

function TNSComponent.IsScrollBar:Boolean;//< O objeto filho que implementa um TScrollBar deve anular e retornar true;
Begin
  Result := False;
end;


//Executando antes de Inherited HandleEvent(var Event: TEvent)
//procedure TNSComponent.HandleEvent_PreProcess(var Event: TEvent);
//begin
//
//end;


procedure TNSComponent.HandleEvent(var Event: TEvent);
Begin
  if (Event.What = evCommand) //and (Event.Command = CmTime) // nortsoft implementou o evento time
  then Begin
         If (Event.Command = CmTime) // nortsoft implementou o evento time
         Then Begin
                SysCtrlSleep(TimeCmTime);
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

//Executando depois de Inherited HandleEvent(var Event: TEvent)
//procedure TNSComponent.HandleEvent_PosProcess(var Event: TEvent);
//begin
//
//end;
//

procedure TNSComponent.ClearEvent(var Event: TEvent);
Begin
  Event.What       := evNothing;
  Event.Command    := 0;
  Event.StrModule  := '';
  Event.StrCommand := '';
  Event.InfoPtr    := Self;
end;

Procedure TNSComponent.ClearEvents;
// Elimina todos os eventos pendentes.
  Var Event : TEvent;
Begin
  While EventAvail do
  Begin
    GetEvent(Event);
    ClearEvent(Event);
    PutEvent(Event);
  end;
end;

function TNSComponent.GetHelpCtx_Path: AnsiString;
  {
   Retorna path do documento associando a visao.
  }
 Function SIF(Const Logica : Boolean; Const E1 , E2 : String ) : String ;
 Begin
   If Logica Then SIF := E1 Else SIF := E2;
 End;

Begin
  if HelpCtx_StrCommand <>''
  then Result := application.ParamExecucao.NomeDeArquivosGenericos.DirHTML+
                 SIF(HelpCtx_StrModule<>'',HelpCtx_StrModule+PathDelim,'')+
                 SIF(HelpCtx_StrCommand<>'',HelpCtx_StrCommand+PathDelim,'')
  Else Result := application.ParamExecucao.NomeDeArquivosGenericos.DirHTML+
                 SIF(HelpCtx_StrCurrentModule<>'',HelpCtx_StrCurrentModule+PathDelim,'')+
                 SIF(HelpCtx_StrCurrentCommand<>'',HelpCtx_StrCurrentCommand+PathDelim,'');
end;

function TNSComponent.GetHelpCtx_Doc_HTML: AnsiString;
   {ATEN�AO:

   Est� um Implemnta��o s� funciona se o objeto que herdar TNSComponent for do tipo campo.
   Caso a classe que herdar TNSComponent seja tabela, ent�o este m�todo deve ser redefinido
   para que os dados sej�o pegos do corrente campo.
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

  //Se n�o foi definido um topico para o comando, ent�o usa o corrente.
  if wHelpCtx_StrCommand_Topic = ''
  then wHelpCtx_StrCommand_Topic := HelpCtx_StrCurrentCommand_Topic;

  If HelpCtx_StrCurrentCommand_Opcao <> ''
  Then Result := GetHelpCtx_Path + wHelpCtx_StrCommand+'_'+HelpCtx_StrCurrentCommand_Opcao+'.htm'
  Else If wHelpCtx_StrCommand <> ''
       Then Begin
              if HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File
              Then Begin {$Region '// HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File'}
                     Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File := true;
                    //HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File. Nota: Para cada campo o conteudo do campo � criado um arquivo.
                     Result := scg(GetHelpCtx_Path + wHelpCtx_StrCommand+'_'+wHelpCtx_StrCommand_Topic+'_'+Alias_To_Name(HelpCtx_StrCurrentCommand_Topic_Content)+'.htm') //
                   end   {$EndRegion '// HelpCtx_StrCurrentCommand_Topic_Content_Run = HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File'}
              Else Begin
                     Ok_HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File := False;
                     Result := scg(GetHelpCtx_Path + wHelpCtx_StrCommand+'.htm')
                   End;
           end
       Else Result := '';
end;


/// <since>
///   �  Visualiza o texto associado ao corrnte campo da tabela.
/// </since>
function TNSComponent.ExecViewHelpCtx_F1:Word;
Begin      

End;

/// <since>
///   �  Visualiza o arquivo HTML associado a tabela e posiciona o foco no campo corrente selecionado no formul�rio de edi��o.
/// </since>
function TNSComponent.ExecViewHelpCtx_Alt_F1:Word;
   {ATEN�AO:

   Est� um Implemnta��o s� funciona se o objeto que herdar TNSComponent for do tipo campo.
   Caso a classe que herdar TNSComponent seja tabela, ent�o este m�todo deve ser redefinido
   para que os dados sej�o pegos do corrente campo.
   }

  Var
    S,wHelpCtx_StrCommand,wHelpCtx_StrCommand_Topic : AnsiString;

Begin      
  If SeExiste(GetHelpCtx_Doc_HTML)
  Then Begin
         If @Show_HTML <>nil
         Then Begin
                //Dar prioride a HelpCtx_StrCommand
                wHelpCtx_StrCommand := HelpCtx_StrCommand;
                if wHelpCtx_StrCommand = ''
                then wHelpCtx_StrCommand := HelpCtx_StrCurrentCommand;

                //Dar prioride a HelpCtx_StrCommand_Topic
                wHelpCtx_StrCommand_Topic := HelpCtx_StrCommand_Topic;
                if wHelpCtx_StrCommand_Topic = ''
                then wHelpCtx_StrCommand_Topic := HelpCtx_StrCurrentCommand_Topic;

                If (wHelpCtx_StrCommand_Topic <> '')
                Then Begin
                       if HelpCtx_StrCurrentCommand_Topic_Content<>''
                       then Begin
                              Case HelpCtx_StrCurrentCommand_Topic_Content_Run of
                                HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_indefinido:
                                Begin
                                  S := GetHelpCtx_Doc_HTML+'#'+wHelpCtx_StrCommand_Topic;
                                  Result := Show_HTML(SCG(S));
                                end;

                                HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_indicator:
                                Begin
                                  //Para cada campo e conteudo ele espera encontrar um indicador dentro do arquivo.
                                  S := GetHelpCtx_Doc_HTML+'#'+wHelpCtx_StrCommand_Topic+'_'+Alias_To_Name(HelpCtx_StrCurrentCommand_Topic_Content);
                                  Result := Show_HTML(SCG(S));
                                end;

                                HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File     :
                                Begin
                                  S := GetHelpCtx_Path + wHelpCtx_StrCommand+'_'+HelpCtx_StrCommand_Topic+'_'+Alias_To_Name(HelpCtx_StrCurrentCommand_Topic_Content)+'.htm';
                                  //HelpCtx_StrCurrentCommand_Topic_Content_run_Parameter_File. Nota: Para cada campo o conteudo do campo � criado um arquivo.
                                  Result := Show_HTML(SCG(S) );//
                                end;
                              end;//case
                            end
                       Else Begin
                              S := GetHelpCtx_Doc_HTML+'#'+wHelpCtx_StrCommand_Topic;
                              Result := Show_HTML(SCG(S));
                            end;
                     end
                Else Begin
                       S := GetHelpCtx_Doc_HTML;
                       Result := Show_HTML(SCG(S));
                     end;
              end
         Else Result := 0;
       end
  Else Result := EditViewHelpCtx;// TaStatus;
End;

/// <since>
///   �  Edita o arquivo HTML associado a tabela.
/// </since>
function TNSComponent.ExecViewHelpCtx_Crtl_F1:Word;
Begin      
  Result := EditViewHelpCtx;
End;

Function TNSComponent.ExecViewHelpCtx:Word; // Nortsoft
Begin
  Result := ExecViewHelpCtx_F1;
end;

Function TNSComponent.EditViewHelpCtx:Word; // Nortsoft
  {<
   RETORNA:
     Retorna 0 (zero) se tiver sucesso ou o c�digo do erro se fracassar.

   ESPERA
     1 - Espera que exista o modelo ./html/Template/manual_do_usuario.htm
     2 - Espera que o usu�rio tenha acesso a escrita  a pasta ./html e suas subpastas.
  }

{  Var
    HtmlDest      : AnsiString;
    Template_HTML : TTemplate_HTML;}

Begin

//Edita o documento sencivel ao contexto.
  IF GetHelpCtx_Doc_HTML <> ''
  THEN Result := SysShellExecute('Edit',GetHelpCtx_Doc_HTML,'','',SW_SHOW	) // Editar html
  ELSE RESULT := 087;  //  ParametroInvalido  = 087;

end;

procedure TNSComponent.GetEvent(var Event: TEvent);
begin
  if Owner_NSComponent <> nil then Owner_NSComponent.GetEvent(Event);
end;

function TNSComponent.EventAvail: Boolean;
var
  Event: TEvent;
begin
  ClearEvent(Event);
  GetEvent(Event);
  if Event.What <> evNothing
  then PutEvent(Event);
  Result := Event.What <> evNothing;
end;

procedure TNSComponent.PutEvent(var Event: TEvent);
begin
  if Owner_NSComponent <> nil then Owner_NSComponent.PutEvent(Event);
end;

Function TNSComponent.Top_Owner_NSComponent:TNSComponent;
 {
  Retorna a raiz da ierarquia caso um component seja inserido em outro.
 }
  Var
    p :TNSComponent;
begin
  Result := nil;
  P := Self;
  while (p <> nil) do
  begin
    P := P.Owner_NSComponent;
    If P <> nil
    Then Result := P;
  end;
end;

Procedure TNSComponent.SetOwner_NSComponent(aOwner_NSComponent : TNSComponent);
Begin
 _Owner_NSComponent := aOwner_NSComponent;
end;

Function TNSComponent.GetOwner: TPersistent;
Begin
  Result := Owner_NSComponent;
end;


{$EndRegion 'Reeri� de implementa��o de TNSComponent NortSoft'}
//*************************************************************************}


{$REGION '---> TJSON_BaseObject para convers�o de Json e TObject'}

  { TJSON_BaseObject }
  class function TJSON_BaseObject.JSONToObject<T>(json: TJSONValue): T;
  var
    unm: TJSONUnMarshal;
  begin
    if json is TJSONNull then
      exit(nil);
    unm := TJSONUnMarshal.Create;
    try
      exit(T(unm.Unmarshal(json)))
    finally
      unm.Free;
    end;

  end;

  class function TJSON_BaseObject.ObjectToJSON<T>(myObject: T): TJSONValue;
  var
    m: TJSONMarshal;
  begin

    if Assigned(myObject) then
    begin
      m := TJSONMarshal.Create(TJSONConverter.Create);
      try
        exit(m.Marshal(myObject));
      finally
        m.Free;
      end;
    end
    else
      exit(TJSONNull.Create);
  end;

{$ENDREGION}

end.
