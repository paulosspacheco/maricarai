unit mi.rtl.Types;
{:< - A Unit **@name** reune os tipos globais usados pelo pacote **mi.rtl**.
      Esta unit foi testada nas plataformas: no linux.

  - **NOTA**
    - O Método **TTypes.TPointer.Get_Mem** ignora alocação de memória real porque não sei como fazer nas plataformas diferentes do Windows.

  - **VERSÃO**
    - Alpha - 0.7.1.621

  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.types.pas">mi.rtl.types.pas</a>)          
  
  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **Period** : June to September of 2001)
      - **14/09/2001** : I begin of the version:  Windows 98
      - **29/10/2021** : Portado para o compilador free pascal para os sistemas operacionais: 1. x86_64-linux 2. x86_64-win64 3. i386-win32
      - **02/11/2021** : Trabalhei na documentação com pasdoc.
      - **12/11/2021**
        - A Unit **mi.rtl.types** foi convertida para unit **mi.types**.
        - Criado a class **TTypes** com todos os tipos definidos em **mi.rtl.types** com objetivo de encapsular os tipos globais do pacote mi.rtl.
      - **13/11/2021**
        - Documentação da unit @name.
      - **15/12/2021**
        - Criado o tipo registro TIndentificação.
}

{$H+}

{$IFDEF FPC}
  {$mode Delphi}
{$ENDIF}

interface

uses
  {$IFDEF Windows}Windows,  {$ENDIF}
  Classes,Dos
  , SysUtils
//  ,Math

  ;


 type
   {: A classe **@name** declara todos os tipos globais do pacote MarIcarai
   }
   TTypes = class(TComponent)
     public Alias : AnsiString;
     public Type TAlign = (Align_Original, {<O Texto original}
                           Align_Left,
                           Align_Center,
                           Align_Right,
                           Fill_with_spaces);
     public type TAlinhamento = (Alinhamento_Direita,
                                 Alinhamento_Central,
                                 Alinhamento_Esquerda,
                                 Alinhamento_Justificado);

     {: - A constant **@name** indica se o processo está dentro de uma transação.}
     public const ok_Set_Transaction   : BOOLEAN = false;

     public constructor Create(aowner:TComponent);Overload;Override;
     {$IFDEF Windows}
       public type TCOORD = Windows.COORD;
       public type DWord  = Windows.DWord;
     {$ENDIF}

     type TQuad = Comp;
     type TSemHandle = Longint;

     {:  CodePage 20127 = US ASCII (0-127)
     }
     type AnsiString_USASCII  = type AnsiString(20127);

     type Char               = System.AnsiChar;
     type pChar              = System.PAnsiChar;
     type tstring            = String[255];//Shortstring;

     type AnsiCharSet        = set of AnsiChar;
     type TRealNum           = Double;
     type Real               = single;
     type PRealNum           = ^TRealNum;
     type TSizeOffldCluster  = SmallInt;
     type LongInt            = System.Longint;
     type Integer            = Longint;
     type Word               = System.Longword;
     type SmallWord          = System.word;
     type LongWord           = System.LongWord;
     type int64              = System.Int64;

       //: https://www.freepascal.org/docs-html/rtl/system/ptruint.html
     type PtrUInt            = system.PtrUInt;

       //: https://www.freepascal.org/docs-html/rtl/system/valuint.html
     type ValUInt = system.ValUInt;

     type PByte       = ^Byte;
     type PWord       = ^Word;
     type PLongint    = ^Longint;
     type PSmallInt   = ^SmallInt;
     type PSmallWord  = ^SmallWord;
     type PBoolean    = ^Boolean;
     type PShortInt   = ^Shortint;
     type PReal       = ^Real;

     {: O tipo **@name** é um tipo de campo bit, onde cada bit pode estar ligado
        e desligado, por isso o mesmo pode contar 16 opções diferente se as opções
        forem multuamente exclusivas e 65535 caso contrário.

        - **NOTA**
          - Este tipo de informação é representado em um formulário pelo controle
            TRadioButton. No meu ponto de vista não sei porque foi criado porque
            acaba gastando mais espaço do que representar essas informações em um byte
            se o campo fosse enumerado.
          - O tipo byte também pode resentar as mesmas informações usando o controle
            TListaBox.

        - **EXEMPLO**
          - SEXO
            - Masculino
            - Feminino
            - Indefinido

          - Estado Civil
            - Soulteiro
            - Casado
            - Divorciado
            - Amigado
     }
     type TCluster = Byte;
     type PCluster = ^TCluster;


     type TipoOfsSeg = Record
                         Ofs,
                         Seg: SmallWord;
                       End;
     type MatrizStr64 = array[1..3] of string[64]; //:< Usado na ConvValorExt


     type TArrayAnsiChar  = Array[0..254] of AnsiChar;
     type PArrayAnsiChar  = ^TArrayAnsiChar;

     type TArrayOpenAnsiString = Array of AnsiString;
     type TArrayOpenVariant    = Array of Variant;
     type TArrayOpenByte       = Array of Byte;
     type TArrayOpenInteger    = Array of Integer;
     type TArrayOpenLongint    = Array of Longint;
     type TArrayOpenWord       = Array of Word;

     {---------------------------------------------------------------------------}
     {                               GENERAL ARRAYS                              }
     {---------------------------------------------------------------------------}
     Const MAX_BYTE         = high(SmallWord);
     Const MAX_ARRAY_BYTE   = MAX_BYTE div sizeof(byte);

     Const MAX_INT          = high(Integer);
     Const MAX_ARRAY_INT    = MAX_INT div sizeof(integer);

     Const MAX_SMALL_INT    = high(SmallInt);
     Const MAX_ARRAY_SMALL_INT  = MAX_SMALL_INT div sizeof(SmallInt);

     Const MAX_LONG_INT     = high(LongInt);
     Const MAX_ARRAY_LONG_INT  = MAX_LONG_INT div sizeof(Longint);

     Const MAX_WORD         = high(Word);
       {$IFDEF WIN32}
     Const  MAX_ARRAY_WORD  = (MAX_WORD div sizeof(word)) div 2;
       {$ELSE }
     Const  MAX_ARRAY_WORD  = MAX_WORD div sizeof(word);
       {$ENDIF}


     Const MAX_SMALL_WORD   = high(system.word);
     Const MAX_ARRAY_SMALL_WORD  = MAX_SMALL_WORD div sizeof(system.word);

     Const MAX_LONG_WORD    = high(LongWord);
     Const MAX_ARRAY_LONG_WORD  = MAX_LONG_WORD div sizeof(LongWord);

//     Const MAX_Real           = high(real);
//     Const MAX_ARRAY_MAX_Real = MAX_Real div sizeof(Real);

     Const MAX_POINTER        = MAX_ARRAY_WORD;    //:< O ideal seria memAvail, porém esta função não é multiplataforma;
     Const MAX_ARRAY_PTR      = MAX_POINTER  div sizeof(Pointer);

     type TArrayByte  = array[0..MAX_ARRAY_BYTE - 1] of Byte;
     type PArrayByte = ^TArrayByte;

     type TAnsiCharArray  =  array[0..MAX_ARRAY_INT-1] of AnsiChar;
     type PAnsiCharArray  = ^TAnsiCharArray;

     type TArrayInt   = array[0..MAX_ARRAY_INT-1] of integer ;
     type PArrayInt  = ^TArrayInt;

     type TArrayLong  = array[0..MAX_ARRAY_LONG_INT-1] of Longint;
     type PArrayLong = ^TArrayLong;


     type TArrayPtr  = array[0..MAX_ARRAY_PTR  - 1] of Pointer;
     type PArrayPtr  = ^TArrayPtr;

     type TWordArray = ARRAY [0..MAX_ARRAY_WORD-1] Of Word;//:< Word array
     type PWordArray = ^TWordArray; //:< Word array pointer

     type TSmallWordArray = ARRAY [0..MAX_ARRAY_SMALL_WORD-1] Of SmallWord;//:< Word array
     type PSmallWordArray = ^TSmallWordArray;//:< Word array pointer

     type PDouble    = ^Double;
     type PExtended  = ^Extended;

     {---------------------------------------------------------------------------}
     {                               AnsiCharACTER SET                               }
     {---------------------------------------------------------------------------}
     type TAnsiCharSet = SET Of AnsiChar;//:< AnsiCharacter set
     type PAnsiCharSet = ^TAnsiCharSet;//:< AnsiCharacter set ptr

     {---------------------------------------------------------------------------}
     {                             POINTER TO tstring                             }
     {---------------------------------------------------------------------------}

     type Ptstring = ^tstring;//: String pointer

     {: Define os tipos usados no Turbo Vision e nao declarados em QDialogs}
     type PSItem = ^TSItem;
          //: - Difine os tipos usados no Turbo Vision e não declarados em QDialogs
          TSItem = record
                    Value: ptstring;
      //              Value: AnsiString; Muito trabalho para converte este tipo
                    Next: PSItem;
                 End;

     //type
     //  PtrRec = record
     //    Ofs: Longint;
     //  end;

      //: - O tipo **@name** é usado para padronizar o tipo usado nos handles de acesso a arquivos.
      Type THandle = System.THandle;

      {: O registro @name é usado para guardar as coordenadas da tela. Usado no turbo vision}
      public
      Type TPoint = record
                     //: O @name salva a coordenada da linha
                     X: Integer;

                     //: O @name salva a coordenada da coluna
                     Y: Integer;

                     procedure SetX(a_X:Integer);
                     procedure SetY(a_Y:Integer);
                  end;
      public
      Type PPoint = ^TPoint;

      {---------------------------------------------------------------------------}
      {$REGION ' CONSTRUÇÃO DA ESTRUTURA TEvent ' }
        //: O tipo TMsg é usado para transmitir mensagem para o windows
        Type TMsg = Record
                       hwnd    : THandle; //:< Handle da Janela do windows
                       Message : Word;
                       WParam  : Word;
                       LParam  : LongInt;
                       time    : Longint;
                       pt      : TPoint;
                    End;

        //: - O tipo @name é usado para acessar o tipo AnsiChar de 255 caracteres
        Type _TStr255 = record
                          Len       : Byte;//:< Número de caractere de str. Usado para compatibiliza com os tstrings da linguagem C
                          ArrayAnsiChar : Array[0..255] of AnsiChar;  //:< Array de 256 elementos.
                        end;

        //: - O tipo @name é usado para chamadas das API do windows
        Type TStr255 = Record
                          Case Integer of
                             0 : (Str : tstring);
                             1 : (Str_Win : _TStr255);
                       end;

        {: Usado para compatibilidade com o passado;}

        Const FileNameLen : integer = Dos.FileNameLen;
        type ComStr  = Dos.ComStr;
        type PathStr = Dos.PathStr;
        type DirStr  = Dos.DirStr;
        type NameStr = Dos.NameStr;
        type ExtStr  = Dos.ExtStr;

        //: - Registro usado para enviar mensagem entre classes
        Type TWebMsg = Record
                          //WebModule   : TObject;
                          WebModule   : TClass;
                          User_Name   : String[125];  //:< |  Cliente  | Identificação do usuário
                          Password    : String[ 10];  //:< |  Cliente  | Senha de acesso
                          Name_Module : String[125];  //:< |  Cliente  | Usado para identifica a DLL a que o evento deve ser enviado
                          Acao_actual : String[125];  //:< |  Cliente  | São métodos do objeto que a página pode executar:
                          Acao_Old    : String[125];  //:< |  CGI      | São métodos do objeto que a página executou na chamada anterior.
                       End;


        { Event codes }
        Const evNothing   = $0000;
        Const evMouseDown = $0001;
        Const evMouseUp   = $0002;
        Const evMouseMove = $0004;
        Const evMouseAuto = $0008;

        Const evKeyDown   = $0010;
        Const evCommand   = $0100;
        Const evBroadcast = $0200;

        Const EvAplCliSvr = $0400; {10000000000} { Event codes PauloSSPacheco}

        { Event masks}


        Const evMouse     = $000F;
        Const evKeyboard  = $0010;
        Const evMessage   = $FF00;

        { Event record }
        type PEvent = ^TEvent;
        {: - O tipo **@name** é usado enviar mensagem para uma classe inserida em um grupo de classes.  }
             TEvent = record
                        What: SmallWord;
                        case Word of
                          evNothing: ();
                          evMouse: (
                            Buttons: Byte;
                            Double: Boolean;
                            Where: TPoint);
                          evKeyDown: (
                            case Integer of
                              0: (KeyCode: SmallWord;ShiftState: Byte);
                              1: (AnsiCharCode: AnsiChar;ScanCode: Byte));
                          evMessage: (
                    {        View_Owner : Pointer;} {Ponteiro para a visão dona do evento}
                            StrModule : String[100];
                            StrCommand : String[100];
                            Module,
                            Command    : Word;

                            {: evMessage}
                            case Word of
                              //Turbo Vision
                               0: (InfoPtr : Pointer );
                               1: (InfoLong: Longint);
                               2: (InfoWord: Word   );
                               3: (InfoInt : Integer );
                               4: (InfoByte: Byte   );
                               5: (InfoAnsiChar: AnsiChar   );

                               //custom
                               6: (InfoStr           : tstring   );
                               7: (InfoArrayStr      : Array[1..2] of tstring);
                               8: (InfoStr255        : TStr255);//:< Usada para acessar a tstring referenciada por InfoStr
                               9: (InfoArrayStr255   : Array[1..2] of TStr255);//:< Usado para acessar a tstring referenciada por InfoStr
                              10: (InfoArrayAnsiChar512  : Array[1..512] of AnsiChar);
                              11: (InfoArrayByte     : Array[1..512] of Byte);
                              12: (InfoArrayInteger  : Array[1..256] of Integer);
                              13: (InfoArrayLongint  : Array[1..128] of Longint);
                              14: (InfoArrayPointer  : Array[1..128] of Pointer);
                              15: (InfoArrayPAnsiChar    : Array[1..  2] of array[0..255] of AnsiChar);
                              16: (InfoMsgWin        : TMsg);
                              17: (InfoPoint         : TPoint);
                              18: (InfoWeb           : TWebMsg);
                              19: (InfoComponent     : TComponent);
                              20: (InfoPEvent        : PEvent;);

                            );{evMessage}
                      end;
      {$ENDREGION}
      {---------------------------------------------------------------------------}


      //: - Tipo enumerado usado para identificar o tipo de dispositivo de leitura e gravação.
      type TDriveType = ( dt_Invalid,
                          dt_Floppy,
                          dt_Memory_Stream,
                          dt_RamDisk,
                          dt_CDRom,
                          dt_PenDriver,
                          dt_LAN,
                          dt_HD,
                          dt_SSd,
                          dt_Unknown,
                          dt_DRIVE_NO_ROOT_DIR);

      {:- O Tipo **@name** é usado para informar o modo de abertura do arquivo.

        - **NOTA**:
          - As constantes tipo @name (exceto fmCreate ) podem ser combinados com operador **OR** para
            indicar os possíveis modos de abertura de arquivos.
      }
      type TFileMode = (fmmOpenRead      = SysUtils.fmOpenRead ,
                        fmmOpenWrite     = SysUtils.fmOpenWrite,
                        fmmOpenReadWrite = SysUtils.fmOpenReadWrite,
                        fmmShareCompat    = SysUtils.fmShareCompat,
                        fmmShareExclusive = SysUtils.fmShareExclusive,
                        fmmShareDenyWrite = SysUtils.fmShareDenyWrite,
                        fmmShareDenyRead  = SysUtils.fmShareDenyRead,
                        fmmShareDenyNone  = SysUtils.fmShareDenyNone);


      const SizeOffldCluster    : TSizeOffldCluster = sizeof(TSizeOffldCluster);
      const SizeOffldDbCluster  = 50;




      {***************************************************************************}
      {$REGION '---> TIPO TPOINTER '                                              }

        type TEnumMemory = (MemoryNull,MemoryReal,MemoryVirtual);
        type TArray      = Array[0..(1024 * 1024 * 2)] of byte;

        {: - A classe **@name** é usada para alocar memória no heap.

           - **NOTA**
             - A função **SysTVGetSrcBuf** usa para ler a memória de vídeo do console.
             - O Método **TTypes.TPointer.Get_Mem** ignora alocação de memória real porque não sei
               como fazer nas plataformas diferentes do Windows.
        }
        type TPointer = Class(TObject)
                            Private
                               _Pointer      : Pointer;
                               _Size         : ValUInt ;
                               _Type_Memory  : TEnumMemory;
                               _Sizeof_Value : ValUInt  ; {:< Guarda o tamanho da variável do último setValue}


                               procedure Get_Mem(const a_Size: ValUInt );
                               procedure Free_Mem;

                               procedure SetSize(const a_Size: ValUInt );
                               procedure SetType_Memory(a_Type_Memory: TEnumMemory);

                        {       procedure SetValue(Const AValue : Variant);
                               function GetValue : Variant;  }

                               function GetPointer : Pointer;

                               procedure SetByte(Index:PtrUInt ; aValue : Byte);
                               function GetByte(Index:PtrUInt ): Byte;

                            Protected
                               procedure FCreate (Const a_Size:PtrUInt ;a_Type_Memory : TEnumMemory);

                            Public
                              Property Byte[Index : PtrUInt ]  : Byte Read GetByte write SetByte;
                              Property Size        : PtrUInt  Read _Size    write SetSize;
                              Property Pointer     : Pointer Read _Pointer;
                              Property Type_Memory : TEnumMemory Read _Type_Memory write SetType_Memory;

                              procedure FillByte(aByte:Byte);
                              constructor Create(Const a_Size:Longint);Overload;
                              constructor Create(Const a_Size:Longint;a_Type_Memory : TEnumMemory);Overload;
                              destructor Destroy;override;
                          End;
      {$ENDREGION}
      {***************************************************************************}

     type WordRec = packed Record
                    Case Integer of
                      0 : (Lo, Hi: Byte);
                      1 : (SW : SmallWord);
                      2 : (Ch : AnsiChar; Attr:Byte);//:< Quando usado em telas
                    end;

     type LongRec = packed Record
                    Case Integer of
                        0 : (Lo, Hi: SmallWord);
                        1 : (L     :Longint);
                    end;

     //type PtrRec = packed Record
     //                Ofs: Word; //:< Pointer to words
     //              end;


     type PRect = ^TRect;
          {: - TRect Class - RECTANGLE Class}
          TRect = record//Object //Retirei Object do turbo pascal porque o lazarus não depura.
             Public
                 A,B     : TPoint;                                { Corner points }
              FUNCTION Empty: Boolean;
              FUNCTION Equals (R: TRect): Boolean;
              FUNCTION Contains (P: TPoint): Boolean;
              PROCEDURE Copy ( R: TRect);
              PROCEDURE Union (R: TRect);
              PROCEDURE Intersect (R: TRect);
              PROCEDURE Move (ADX, ADY: Integer);
              PROCEDURE Grow (ADX, ADY: Integer);
              PROCEDURE Assign (XA, YA, XB, YB: Integer);

              Procedure SetLeft(aLeft:Integer);
              Procedure SetTop(aTop  : Integer);
              Procedure SetWidth(aWidth:Integer);
              Procedure SetHeight(aHeight: Integer);

           END;



      class procedure CheckEmpty (Var Rect: TTypes.TRect);


     type TIdentification = record
                           //Dados do usuario logado
                            Id_branch       : SmallWord;  //:< Número da filial do usuário logado
                            Id_user         : word;       //:< Número do usuário Logado;
                            UserName        : AnsiString; //:< Nome do usuário logado
                            FullUserName    : AnsiString; //:< Nome completo do usuario logado
                            password        : AnsiString; //:< Senha do usuario logado
                          end;

     type TParamExecucao_Tipo_de_Execucao = (TParamExecucao_Tipo_de_Execucao_Normal, {<O sistema trabalha com menu do turbo Vision}
                                             TParamExecucao_Tipo_de_Execucao_Normal_Sem_Pedir_Senha, {<O sistema trabalha com menu do turbo Vision}
                                             TParamExecucao_Tipo_de_Execucao_Normal_Exec_Command,    {<O sistema executa um comando depois de pedir a senha. Usado para execusão em lote }
                                             TParamExecucao_Tipo_de_Execucao_VCL,    {<O sistema trabalha com menu Grafico}
                                             TParamExecucao_Tipo_de_Execucao_CGI,   {<O sistema trabalha com chamadas do Browse}
                                             TParamExecucao_Tipo_de_Execucao_ISAPI); //O Sistema trabalha como um serviço DLL

     Type TNao_Sim = (NS_Nao,NS_Sim);

     {: O tipo **@name** é usada para passar como parâmetro na conversão de idioma de listas de string.
     }
     type TConvertIdioma =  Function (S: AnsiString): AnsiString;

     {: O tipo **@name** é usado para calcular os caracteres equivalentes sem acentos quando os mesmos tiverem acentos}
     Type TReg_Of_Char = Record
                           Asc_Ingles  : AnsiChar;
                           Asc_GUI     : Ansistring;
                           Asc_HTML    : AnsiString;
                         end;

    {: O tipo **@name** é uma tabela de equivalência de caractere sem acentos quando os mesmos tiverem acentos.}
     type TArray_Of_Char = Array[0..26] of TReg_Of_Char;

     {: O tipo **@name** é usado quando se precisa de procedures anônimas sem parâmetros }
     type TipoProc   = Procedure;

      {: O tipo **@name** é usado quando se precisa de eventos anônimas dentro de componentes}
     Type TOnProcedure = Procedure(Const aNameMethod:String) of object unimplemented;

     type
       { A class **@name** é usada para criar lista de objetos onde os mesmo são destruidos
         ao destruir a lista de objetos}
       TObjectList = class(TFPList)
                        public destructor Destroy; override;
                     end;

     Type
       {: Tipos de banco de dados reconhecidos pela função CreateDB_or_DropDB}
       TConnectorType = (PostgresSQL,SqLite3);

  end;





implementation


{ TTypes.TObjectList }
destructor TTypes.TObjectList.Destroy;

  var
    i: Integer;
begin
  for i := 0 to Count - 1 do
    TObject(Items[i]).Free;

  inherited Destroy;
end;


constructor TTypes.Create(aowner: TComponent);
begin
  inherited Create(aowner);
  Alias := ClassName;
end;


{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{$REGION '---> TIPO TPOINT '                                              }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

  procedure TTypes.TPoint.SetX(a_X: Integer);
  begin
    X := a_X;
  end;

  procedure TTypes.TPoint.SetY(a_Y: Integer);
  begin
    Y := a_Y;
  end;

{$ENDREGION}

{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{$REGION '---> TIPO TPOINTER '                                              }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}


  procedure TTypes.TPointer.FCreate (Const a_Size:PtrUInt ;a_Type_Memory : TEnumMemory);
  Begin
  //  _Type_Memory := a_Type_Memory;
    _Type_Memory := MemoryVirtual;
    Get_Mem(a_Size);
  end;

  procedure TTypes.TPointer.FillByte(aByte:Byte);
    Var i : Longint;
  Begin
    for i := 0 to Size-1 do
     Self.Byte[i] := aByte;
  End;

  constructor TTypes.TPointer.Create(Const a_Size:Longint);
  Begin
    Inherited Create;
    FCreate (a_Size,MemoryVirtual);
  end;

  constructor TTypes.TPointer.Create(Const a_Size:Longint;a_Type_Memory : TEnumMemory);
  Begin
    Inherited Create;
    FCreate (a_Size,a_Type_Memory);
  end;

  procedure TTypes.TPointer.Get_Mem(const a_Size: ValUInt);
  Begin
    If _Pointer <> nil
    Then Free_Mem;



    Case _Type_Memory of
        MemoryVirtual  : Begin
                           GetMem(_Pointer,a_Size);
                           if _Pointer<>nil then _Size := a_Size;

                         End;
        MemoryReal     : Begin
  //                        _Pointer := System.Pointer(SysLocalAlloc(LMEM_FIXED,a_Size));
                           _Pointer := nil;

                            if _Pointer<>nil then _Size := a_Size;

                           If _Pointer = nil
                           Then Begin
                                  _Type_Memory := MemoryVirtual;
                                  Get_Mem(a_Size);

                                  exit;
                               End;
                         End;
        Else Abort;
    End;
  End;

  procedure TTypes.TPointer.Free_Mem;
  Begin
    Try
      Try
        If (_Pointer <> nil) and (_Size>0)
        Then Case _Type_Memory of
                MemoryVirtual  : FreeMem(_Pointer,_Size);
                MemoryReal     : begin
                                    {SysLocalFree(_Pointer);}
                                    //SysVirtualFree(_Pointer,_Size,MEM_DECOMMIT);
                                    FreeMem(_Pointer,_Size);
                                 end;

                Else Abort;
             End;
      Finally
        _Pointer := nil;
        _Size    :=   0;
      End;

    Except end;
  End;

  destructor TTypes.TPointer.Destroy;
  Begin
    Free_Mem;
    Inherited Destroy;
  end;

  procedure TTypes.TPointer.SetSize(const a_Size: ValUInt);
  Begin
    Get_Mem(a_Size);
  end;

  procedure TTypes.TPointer.SetType_Memory(a_Type_Memory: TEnumMemory);
    Var
      WSize : Longint;
  Begin
    WSize := Size;

    If _Pointer <> nil
    Then Free_Mem;

    _Type_Memory := a_Type_Memory;

    If WSize > 0
    Then Get_Mem(WSize);
  End;

  function TTypes.TPointer.GetByte(Index:ValUInt): Byte;
    Type
      TArray = Array[0..1024*1024 * 2] of system.byte;
  Begin
    Result := TArray(_pointer^)[Index];
  end;

  procedure TTypes.TPointer.SetByte(Index:ValUInt; aValue : Byte);
    Type
      TArray = Array[0..1024*1024 * 2] of system.byte;
  Begin
    TArray(_pointer^)[Index] := aValue;
  end;

  {procedure TTypes.TPointer.SetValue(Const AValue : Variant);
    Var
      aLength : Longint;
  Begin
    aLength := Length(aValue);

    If aLength > Size
    Then Size := aLength;

    _Pointer^ := aValue;
    _Sizeof_Value := aLength;
  end;


  function TTypes.TPointer.GetValue : Variant;
  Begin
    If _Pointer <> nil
    Then Result := _Pointer^
    Else Result := '';
  end;
  }

  function TTypes.TPointer.GetPointer : Pointer;
  Begin
    If _Pointer <> nil
    Then Result := _Pointer
    Else Result := nil;
  end;

{$EndRegion '---> TIPO TPOINTER  <---' }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
{$Region '---> TTypes.TRect <---' }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

    {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
    {                           TTypes.TRect Class METHODS                            }
    {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
    class PROCEDURE TTypes.CheckEmpty (Var Rect: TTypes.TRect);
    BEGIN
       With Rect Do Begin
         If (A.X >= B.X) OR (A.Y >= B.Y) Then Begin       { Zero or reversed }
           A.X := 0;                                      { Clear a.x }
           A.Y := 0;                                      { Clear a.y }
           B.X := 0;                                      { Clear b.x }
           B.Y := 0;                                      { Clear b.y }
         End;
       End;
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Empty -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB             }
    {---------------------------------------------------------------------------}
    FUNCTION TTypes.TRect.Empty: Boolean;
    BEGIN
       Empty := (A.X >= B.X) OR (A.Y >= B.Y);             { Empty result }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Equals -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB            }
    {---------------------------------------------------------------------------}
    FUNCTION TTypes.TRect.Equals (R: TTypes.TRect): Boolean;
    BEGIN
       Equals := (A.X = R.A.X) AND (A.Y = R.A.Y) AND
         (B.X = R.B.X) AND (B.Y = R.B.Y);                 { Equals result }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Contains -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB          }
    {---------------------------------------------------------------------------}
    FUNCTION TTypes.TRect.Contains (P: TPoint): Boolean;
    BEGIN
       Contains := (P.X >= A.X) AND (P.X < B.X) AND
         (P.Y >= A.Y) AND (P.Y < B.Y);                    { Contains result }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Copy -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB              }
    {---------------------------------------------------------------------------}
    PROCEDURE TTypes.TRect.Copy (R: TTypes.TRect);
    BEGIN
       A := R.A;                                          { Copy point a }
       B := R.B;                                          { Copy point b }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Union -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB             }
    {---------------------------------------------------------------------------}
    PROCEDURE TTypes.TRect.Union (R: TTypes.TRect);
    BEGIN
       If (R.A.X < A.X) Then A.X := R.A.X;                { Take if smaller }
       If (R.A.Y < A.Y) Then A.Y := R.A.Y;                { Take if smaller }
       If (R.B.X > B.X) Then B.X := R.B.X;                { Take if larger }
       If (R.B.Y > B.Y) Then B.Y := R.B.Y;                { Take if larger }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Intersect -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB         }
    {---------------------------------------------------------------------------}
    PROCEDURE TTypes.TRect.Intersect (R: TTypes.TRect);
    BEGIN
       If (R.A.X > A.X) Then A.X := R.A.X;                { Take if larger }
       If (R.A.Y > A.Y) Then A.Y := R.A.Y;                { Take if larger }
       If (R.B.X < B.X) Then B.X := R.B.X;                { Take if smaller }
       If (R.B.Y < B.Y) Then B.Y := R.B.Y;                { Take if smaller }
       CheckEmpty(Self);                                  { Check if empty }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Move -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB              }
    {---------------------------------------------------------------------------}
    PROCEDURE TTypes.TRect.Move (ADX, ADY: Integer);
    BEGIN
       Inc(A.X, ADX);                                     { Adjust A.X }
       Inc(A.Y, ADY);                                     { Adjust A.Y }
       Inc(B.X, ADX);                                     { Adjust B.X }
       Inc(B.Y, ADY);                                     { Adjust B.Y }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Grow -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB              }
    {---------------------------------------------------------------------------}
    PROCEDURE TTypes.TRect.Grow (ADX, ADY: Integer);
    BEGIN
       Dec(A.X, ADX);                                     { Adjust A.X }
       Dec(A.Y, ADY);                                     { Adjust A.Y }
       Inc(B.X, ADX);                                     { Adjust B.X }
       Inc(B.Y, ADY);                                     { Adjust B.Y }
       CheckEmpty(Self);                                  { Check if empty }
    END;

    {--TTypes.TRect--------------------------------------------------------------------}
    {  Assign -> Platforms DOS/DPMI/WIN/NT/OS2 - Updated 10May96 LdB            }
    {---------------------------------------------------------------------------}
    PROCEDURE TTypes.TRect.Assign (XA, YA, XB, YB: Integer);
    BEGIN
       A.X := XA;                                         { Hold A.X value }
       A.Y := YA;                                         { Hold A.Y value }
       B.X := XB;                                         { Hold B.X value }
       B.Y := YB;                                         { Hold B.Y value }
    END;

    Procedure TTypes.TRect.SetLeft(aLeft:Integer);
    Begin
      a.X := aLeft;
    End;

    Procedure TTypes.TRect.SetTop(aTop  : Integer);
    Begin
      a.Y := aTop;
    End;

    Procedure TTypes.TRect.SetWidth(aWidth:Integer);
    Begin
      b.X := a.X + aWidth;
    End;

    Procedure TTypes.TRect.SetHeight(aHeight: Integer);
    Begin
      b.Y := a.Y + aHeight;
    End;



{$EndRegion '---> TTypes.TRect <---' }
{+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}


end.

