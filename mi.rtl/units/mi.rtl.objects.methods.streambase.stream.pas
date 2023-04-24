unit mi.rtl.Objects.Methods.StreamBase.Stream;
{:< - A Unit **@name** implementa a classe TStream do pacote **mi.rtl**.

  - **NOTAS**
    - Está unit foi testada nas plataformas: win32, win64 e linux.
    - Como o linux não tem opção de travar a região de uma arquivo eu removi as classes **_TRecLock** e **TCollRecsLocks**.

  - **VERSÃO**
    - Alpha - 0.7.1.621

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **20/11/2021** - 09:10 a ??:?? Criar a unit mi.rtl.objects.methods.StreamBase.Stream.pas
      - **22/11/2021**
        - 09:44 a 12:05 Adaptar **TStream** ao free pascal;
        - 14:10 a 19:05 Adaptar **_TStream** e **TStream** ao free pascal;


      -
  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.methods.StreamBase.Stream.pas">mi.rtl.objects.methods.StreamBase.Stream.pas</a>)

}

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}


interface

uses
  Classes, SysUtils
  ,mi.rtl.types
  ,mi.rtl.consts
  ,mi.rtl.files
  ,mi.rtl.objects.types
  ,mi.rtl.objects.Methods
  ,mi.rtl.objects.methods.StreamBase
  ;

  type
    {: - A class **@name** é a classe base da classes **_TStream** do pacote **mi.rtl**.
    }
    TStream =
    Class (TStreamBase )
      Private _Numero_Segundos_que_deve_esperar : longint;
      Private _Ok_Aguarde  : Boolean;
      Private _FileMode    : Word;
      private _ShareMode    : Cardinal;

      protected _Base : Pointer;
      private Ok_FreeMem_Base :Boolean;
      Private _BaseSize:Longint;
      Private _RecSize:Longint;
      protected _Rec  : Pointer;

      Public Status_Rewrite : Byte;                       {0= O arquivo nao foi criado; 1= O Arquivo foi criado}
      Public ClockBegin     : DWord;
      Public Last_Mode      : TLast_Mode_Read_Write;      { Last buffer mode }
      Public var State      : Longint;
     

      protected Ok_FreeMem_Rec :Boolean;

      public procedure Set_BaseSize(a_Base  : Pointer;a_BaseSize:Longint);Overload;Virtual;
      Protected procedure SetBaseSize(a_BaseSize : Longint);Overload;Virtual;
      published Property BaseSize:Longint  Read _BaseSize write SetBaseSize;

      public procedure Set_RecSize(a_Rec  : Pointer;a_RecSize:Longint);Overload;Virtual;
      Protected procedure SetRecSize(a_RecSize : Longint);Overload;Virtual;
      published Property RecSize:Longint  Read _RecSize write SetRecSize;
      public Function Calc_Pos(NR: LongInt;a_RecSize:Longint):Longint;
      Public function FileSize: Longint; overload; Virtual;
      Public procedure Seek(NR: LongInt;a_RecSize:Longint);Overload; override;

      //constructor / destructor
      Public constructor Create();overload;override ;
      Public destructor Destroy;Override;

      //Protected
      Protected procedure Set_Ok_Aguarde(a_Ok_Aguarde: Boolean);Virtual;

      //Public
      Public function CloseOpen:Integer; VIRTUAL;
      Public function Flush_Disk:Integer;   Virtual;
      Public procedure Flush;   Override;
      Public procedure Read (Var Buf; Count: Sw_Word;Var BytesRead:Sw_Word)  ;Overload;Virtual;
      Public procedure Write (Var Buf; Count: Sw_Word;Var BytesWrite:Sw_Word); Overload;Virtual;

      Public procedure SetFileMode(Const aFileMode:Word);virtual;
      public procedure SetShareMode(Const aShareMode:Cardinal);virtual;

      Public function SetStateFileMode(Const AState: Longint; Const Enable: boolean):Boolean;
      Public function GetStateFileMode(Const AState: Longint): Boolean;


      Public procedure Reset;                  overload;    Override;
      Public procedure Reset(aFileMode: Word;ShareMode : Cardinal); overload;Virtual;abstract;

      Public procedure Rewrite;                                overload;    override;
      Public procedure Rewrite(aFileMode: Word;ShareMode : Cardinal);Overload;Virtual;abstract;

      Public function SetBufSize(Const aBufSize : Sw_Word):Sw_Word;Overload;Virtual;
      Public function IsFileOpen:Boolean;Virtual;
      Public function GetRecBase(Var RecBase):Integer;Overload;Virtual;
      Public function PutRecBase(Var RecBase):Integer;Overload;Virtual;
      Public function GetRecBase:Integer;Overload;Virtual;
      Public function PutRecBase:Integer;Overload;Virtual;
      Public function GetRec(Nr: Longint;Var Rec):Integer;Overload;Virtual;
      Public function PutRec(Nr: Longint;Var Rec):Integer;Overload;Virtual;
      Public function GetRec(Nr: Longint):Integer;Overload;Virtual;
      Public function PutRec(Nr: Longint):Integer;Overload;Virtual;
      Public function BlockRead (Nr: Longint;Var Blocks ; Const Count: Longint):Longint;Virtual;
      Public function BlockWrite(Nr: Longint;Var Blocks ; Const Count: Longint):Longint;Virtual;
    //    Public function FileSize: Longint;Virtual;overload;
      Public procedure Error (Code, Info: Integer);Override;


      Public procedure Truncate(Pos: LongInt);Overload;                     Virtual;
      Public procedure CopyFrom (Var S: TStream; Count: LongInt);Overload;Virtual;
      Public procedure CopyFrom (Var S: TStream );Overload;Virtual;
      Public function  Bof:Boolean;Virtual;
      Public function  Eof:Boolean;Virtual;
      Public function goBof:Boolean;
      Public function goEof:Boolean;

      //published
      published Property Ok_Aguarde: Boolean Read _Ok_Aguarde write Set_Ok_Aguarde;

      published Property FileMode : Word Read _FileMode write SetFileMode;
      published Property ShareMode : Cardinal read _ShareMode write SetShareMode;

      protected _FileName: AnsiString;
      Protected procedure SetFileName(a_FileName: AnsiString);Virtual;
      Protected function GetFileName: AnsiString;Virtual;
      published Property FileName   :  AnsiString read GetFileName write SetFileName;


   END;

implementation


  {+++TStream++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}
  {$Region 'TStream METHODS                                                ' }
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}

    {$REGION 'Trazido de _Stream'}
    
      Function TStream.Calc_Pos(NR: LongInt;a_RecSize:Longint):Longint;
      Begin

        If (Nr > 0) or (Self.BaseSize=0)
        Then Begin
               If (FileMode And FmDenyNone) <> 0
               Then Begin
                      If (Nr <= FileSize) //Forca a atualizacao do tamanho da  stream}
                      Then begin
                             if (Self.BaseSize > 0)
                             then Result := BaseSize+(a_RecSize* (Nr-1))
                             else if (Self.BaseSize = 0)
                                  then Result := a_RecSize* Nr
                                  else begin
                                         Error(stSeekError,Seek_fora_da_faixa_do_arquivo);
                                         
                                         raise  EArgumentException.Create('Em: TStream.Calc_Pos()'+TstrError.ErrorMessage(Seek_fora_da_faixa_do_arquivo));
                                       end;

                           end
                      Else Begin
                             Error(stSeekError,Seek_fora_da_faixa_do_arquivo);
                             raise  EArgumentException.Create('Em: TStream.Calc_Pos()'+TStrError.ErrorMessage(Seek_fora_da_faixa_do_arquivo));
                           End
                    End
               Else Result := BaseSize+(a_RecSize* (Nr-1))
             End
        else Result := 0;
      end;

      function TStream.FileSize: Longint;
      Begin
          Result := ((GetSize - BaseSize) div RecSize)+1;
      end;

      procedure TStream.Set_BaseSize(a_Base  : Pointer;a_BaseSize:Longint);
      Begin
        Flush;

        If (_Base <> nil) and Ok_FreeMem_Base
        Then FreeMem(_Base,BaseSize);

        _BaseSize := a_BaseSize;

        If a_Base = Nil
        Then Begin
               GetMem(_Base,BaseSize);
               Ok_FreeMem_Base := true
             end
        Else Begin
               Ok_FreeMem_Base := false;
               _Base         := a_Base;
             End;

        If (Status = StOk) 
        Then Seek(0,BaseSize);
      end;

      procedure TStream.SetBaseSize(a_BaseSize:Longint);
      Begin
        Set_BaseSize(nil,a_BaseSize);
      end;

      procedure TStream.Set_RecSize(a_Rec  : Pointer;a_RecSize:Longint);
      Begin
        Flush;

        If a_RecSize <=0
        Then a_RecSize := 1;

        If (_Rec <> nil) and Ok_FreeMem_Rec
        Then FreeMem(_Rec,RecSize);

        _RecSize := a_RecSize;

        If a_Rec = Nil
        Then Begin
               GetMem(_Rec,RecSize);
               Ok_FreeMem_Rec := true
             end
        Else Begin
               Ok_FreeMem_Rec := false;
               _Rec         := a_Rec;
             End;

        If (Status = StOk) 
        Then Seek(0,RecSize);
      end;

      procedure TStream.SetRecSize(a_RecSize:Longint);
      Begin
        Set_RecSize(nil,a_RecSize);
      end;

      procedure TStream.Seek(NR: LongInt;a_RecSize:Longint);
      Begin
        inherited Seek(Calc_Pos(NR,a_RecSize));
      end;


    {$ENDREGION}

    procedure TStream.Error(Code, Info: Integer);
      Var
        wCtrlSleep_Enable: Boolean;
    Begin
      Status    := Code;                                 { Hold error code }
      ErrorInfo := Info;                                 { Hold error info }
      TaStatus  := ErrorInfo;
      ok        := TaStatus = 0;

      If Status <> StOk
      Then  CASE ErrorInfo  OF
              AcessoNegado5,
              AcessoNegado32,
              ErroViolacaoDeLacre
                 : Begin
                       If Not Ok_Aguarde
                       Then Begin
                              ClockBegin := GetDosTicks;
                              Create_Progress1Passo('Aguarde...('+ExtractFileName(FileName)+')','',TempoDeTentativas*1000);
                            End;
                       wCtrlSleep_Enable := Set_CTRL_SLEEP_ENABLE(true);
                       CtrlSleep (1);

                       _Numero_Segundos_que_deve_esperar := GetDosTicks - ClockBegin;
                       Set_Progress1Passo(_Numero_Segundos_que_deve_esperar);

                       Ok_Aguarde := (_Numero_Segundos_que_deve_esperar <= Round(TempoDeTentativas*1000));
                       Set_CTRL_SLEEP_ENABLE(wCtrlSleep_Enable);
                   end;
              Else Begin
                     Ok_Aguarde := False;

    {                 SysCtrlSleep (1); Nao precisa a aguardar porque o erro e critico e nao vai estabilizar. }

                     //Str(ErrorInfo,Str_ErrorInfo);
                     //MessageBox ('Modulo....: MarIcaraiV1'+^M+
                     //            'Unit......: Objects.pas'+^M+
                     //            'Objeto....: TStream'+^M+
                     //            'Metodo....: procedure TStream.Error(Code, Info: Integer);'+^M+
                     //            ^M+
                     //            'Arquivo...: '+FileName+^M+
                     //            ^M+
                     //            'Alias.....: '+Alias+^M+
                     //            ^M+
                     //            'Error.... : '+Str_ErrorInfo);
                   end;
            END;
    end;

    constructor TStream.Create;
    Begin
      Inherited Create;//(nil);
      _FileMode  := fmOpenReadWrite;
      _ShareMode := fmShareCompat or fmShareDenyNone;
    end;

    destructor TStream.Destroy;
    Begin
//      Discard(TObject(_CollRecsLocks));
      Try
        If (_Rec<>nil)  and
           Ok_FreeMem_Rec
        Then Begin
               Try
                 FreeMem(_Rec,RecSize);
               Finally
                 _Rec := nil;
               End;
             End;
      Except

      end;

      Try
        If (_Base<>nil)  and
           Ok_FreeMem_Base
        Then Begin
               FreeMem(_Base,BaseSize);
               _Base := nil;
             End;
      Except end;

      inherited Destroy;
    End;

    function TStream.GetRecBase(Var RecBase):Integer;
    Begin
      If (Status = StOk) 
      Then Begin
             Seek(0,BaseSize);
             If Status = StOk
             Then Begin
                    Read(RecBase,BaseSize);
                    If Status = StOk
                    Then Result := 0
                    Else Result := ErrorInfo;
                  End
             Else Result := ErrorInfo;
           end
      Else Result := ErrorInfo;
    end;

    function TStream.PutRecBase(Var RecBase):Integer;
    Begin
      If (Status = StOk) 
      Then Begin
             Seek(0,BaseSize);
             If Status = StOk
             Then Begin
                    Write(RecBase,BaseSize);
                    If Status = StOk
                    Then Result := 0
                    Else Result := ErrorInfo;
                  End
             Else Result := ErrorInfo;
           end
      Else Result := ErrorInfo;
    end;

    function TStream.GetRec(Nr: Longint):Integer;
    Begin
      Result := GetRec(Nr,_rec^);
    end;

    function TStream.PutRec(Nr: Longint):Integer;
    Begin
      Result := PutRec(Nr,_rec^);
    end;

    function TStream.GetRecBase:Integer;
    Begin
      Result := GetRecBase(_Base^);
    end;

    function TStream.PutRecBase:Integer;
    Begin
      Result := PutRecBase(_Base^);
    end;

    function TStream.GetRec(Nr: Longint;Var Rec):Integer;
    Begin
      If (Status = StOk) 
      Then Begin
             Seek(Nr,RecSize);
             If Status = StOk
             Then Begin
                    if BaseSize > 0
                    then Begin
                           If NR <> 0
                           Then Read(Rec,RecSize)
                           else Read(Rec,BaseSize)
                         end
                    else Read(Rec,RecSize);

                    If (Status <>StOk) and  (ErrorInfo=0)
                    Then Error(stGetError,ErroDeLeituraEmDisco);
                  End
             Else If ErrorInfo = 0
                  Then Error(stGetError,ErroDeLeituraEmDisco);
           end
      Else Result := ErrorInfo;
      result := ErrorInfo;
    end;

    function TStream.PutRec(Nr: Longint; Var Rec):Integer;
    Begin
      If (Status = StOk) 
      Then Begin
             Seek(Nr,RecSize);
             If Status = StOk
             Then Begin
                    if BaseSize> 0
                    then begin
                           If NR <> 0
                           Then Write(Rec,RecSize)
                           else Write(Rec,BaseSize);
                         end
                    else begin
                           Write(Rec,RecSize);
                         end;

                    If (Status <>StOk) and  (ErrorInfo=0)
                    Then Error(stPutError,ErroDeGravacaoEmDisco);
                  End
             Else If ErrorInfo = 0
                  Then Error(stPutError,ErroDeGravacaoEmDisco);

             If (Status = 0) and FlushBuffer
             Then Flush;

           end;
      Result := ErrorInfo;
    end;

    function TStream.BlockRead (Nr: Longint;Var Blocks ; Const Count: Longint):Longint;
      {Retorna o numero de registros lidos}
       Var BytesRead:Sw_Word;
    Begin
      Seek(Nr,RecSize);
      If Status = Stok
      Then Begin
             Read (Blocks,Count*RecSize,BytesRead);

             If Status=0
             Then Result := BytesRead Div RecSize
             Else Result := 0;
           end
      Else Result := 0;
    end;

    function TStream.BlockWrite(Nr: Longint;Var Blocks ; Const Count: Longint):Longint;
      {Retorna o numero de registros escritos}
       Var BytesWrite:Sw_Word;
    Begin
      Seek(Nr,RecSize);
      If Status = Stok
      Then Begin
             Write (Blocks,Count*RecSize,BytesWrite);
             If Status=0
             Then Result := BytesWrite Div RecSize
             Else Result := 0;
           end
      Else Result := 0;
    end;

{
    function TStream.FileSize: Longint;
    Begin
      Result := ((GetSize - BaseSize) div RecSize)+1;
    end;
}
    function TStream.CloseOpen:Integer;
    Begin
      Result := 0;
    end;

    function TStream.Flush_Disk:Integer;
    Begin
      Result := 0;
    end;

    procedure TStream.Flush;
    Begin
      Last_Mode  := En_Last_Mode_Flush; { Last buffer mode }
    end;

    procedure TStream.Read (Var Buf; Count: Sw_Word;Var BytesRead:Sw_Word);
    begin
      abstracts;                            { Abstract error }
    end;

    procedure TStream.Write (Var Buf; Count: Sw_Word;Var BytesWrite:Sw_Word);
    begin
      abstracts;                            { Abstract error }
    end;

    procedure TStream.Reset;
    Begin
      abstracts;                            { Abstract error }
    end;


    procedure TStream.Rewrite;
    Begin
      abstracts;                            { Abstract error }
    end;

    function TStream.SetBufSize(Const aBufSize : Sw_Word):Sw_Word;
    Begin
      abstracts;
    end;


    procedure TStream.SetFileMode(Const aFileMode:Word);
    Begin
      _FileMode    := aFileMode;//_FileMode or aFileMode ;
    End;

    procedure TStream.SetShareMode(Const aShareMode:Cardinal);
    begin
      _ShareMode    := aShareMode;//_ShareMode or aShareMode;
    end;

    function TStream.SetStateFileMode(Const AState: Longint; Const Enable: boolean):Boolean;
      {Retorna o estado anterior do Mapa de bits passado por aState}
    Begin
      If FileMode and aState <> 0
      Then Result := True
      Else Result := false;

      if Enable
      then FileMode := FileMode or AState
      else FileMode := FileMode and not AState;
    End;

    function TStream.GetStateFileMode(Const AState: Longint): Boolean;
    Begin
      If FileMode and aState <> 0
      Then Result := True
      Else Result := false;
    End;

{    function LowerCase(str:AnsiString):AnsiString;
    var
      i : integer;
    begin
      for i:= 1 to Length(str) do
        If (Byte(Str[i]) > 96) And (Byte(Str[i]) <= 123) Then
          str[i] := AnsiChar(Byte(str[i])-32);
      LowerCase := Str;
    end; }

    procedure TStream.SetFileName(a_FileName: AnsiString);
    Begin
      _FileName := a_FileName;
    end;

    function TStream.GetFileName: AnsiString;
    Begin
      Result := _FileName;
    end;

    procedure TStream.Set_Ok_Aguarde(a_Ok_Aguarde: Boolean);
    Begin
      _Ok_Aguarde := a_Ok_Aguarde;
      If Not a_Ok_Aguarde
      Then Destroy_Progress1Passo;
    end;

    function TStream.IsFileOpen:Boolean;
    Begin
      Result := true;
    end;


    procedure TStream.Truncate(Pos: LongInt);
    Begin
      Seek(Pos,RecSize);
      If Status=0
      Then Truncate
      Else Abort;
    end;

    procedure TStream.CopyFrom (Var S: TStream; Count: LongInt);

    VAR  W,NR      : Longint;
         Buffer : Array[0..4096-1] of Byte;
    BEGIN
      Try
         S.Flush;
         If S.Status <> 0 Then Abort;

         Flush;

         Nr := 0;
         Create_Progress1Passo('Copiando...',FileName,Count div SizeOf(Buffer));

         While (Status =StOk) And (Count > 0) Do
         Begin
           Inc(Nr);
           Set_Progress1Passo(Nr);

           If (Count > SizeOf(Buffer))                  { To much data }
           Then W := SizeOf(Buffer)
           Else W := Count;                            { Size to transfer }

           S.Read(Buffer, W);                               { Read from stream }
           IF S.State <> StOk Then Abort;

           Write(Buffer, W);                                { Write to stream }
           If Status <> StOk Then Abort;

           Dec(Count, W);                                   { Dec write count }
         End;

       Finally
         If S.Status <>0
         Then Error(S.Status,S.ErrorInfo);
         Destroy_Progress1Passo;

         If Status <> StOk
         Then Abort;
       End;

    END;

    procedure TStream.CopyFrom (Var S: TStream );
    Begin

      S.Seek(0);

      If S.Status <> StOk
      Then Error(S.Status,S.ErrorInfo);

      If Status = StOk
      Then Seek(0);

      If Status = Stok
      Then CopyFrom (S,S.GetSize)
      else abort;
    end;

    function  TStream.Bof:Boolean;
    Begin
      Result := (Status = StOk);
      If Result
      Then Result := Position <= 0;
    end;

    function  TStream.Eof:Boolean;
    Begin
      If (Status = StOk)
      Then Begin
             Result := BaseSize + Position >= GetSize;
           End
      Else Result := true;
    end;

    function TStream.goBof:Boolean;
    Begin
      Seek(0);
      Result := (Status = StOk) and Bof;
    end;

    function TStream.goEof:Boolean;
    Begin
      Seek(FileSize);
      Result := (Status = StOk) and Eof;
    end;


  {$EndRegion 'TStream Class METHODS                                          ' }
  {+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++}




end.

