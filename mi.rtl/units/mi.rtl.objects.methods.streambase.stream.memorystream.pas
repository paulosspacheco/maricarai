unit mi.rtl.Objects.Methods.StreamBase.Stream.MemoryStream;
{:< - A Unit **@name** implementa a classe TMemoryStream do pacote **mi.rtl**.

  - **NOTAS**
    - Implementa um fluxo de dados em memória.

  - **VERSÃO**
    - Alpha - 0.8.0

  - **HISTÓRICO**
    - Criado por: Paulo Sérgio da Silva Pacheco e-mail: paulosspacheco@@yahoo.com.br
      - **23/11/2021**
        - 06:10 a 07:17 - Criar a unit @name
        - 07:43 a       - Documentar a unit @name.


  - **CÓDIGO FONTE**:
    - @html(<a href="../units/mi.rtl.objects.methods.StreamBase.Stream.MemoryStream.pas">mi.rtl.objects.methods.StreamBase.Stream.MemoryStream</a>)

}

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
  Classes, SysUtils

  ,mi.rtl.files
  ,mi.rtl.objects.methods.StreamBase.Stream
  ,mi.rtl.objects.methods.StreamBase.Stream.FileStream;

TYPE
    {: - A classe @name é usada para gerenciar um fluxo de dados em memória.

      - **NOTA**
        - Todas as alterações aqui devem ser completamente transparentes para os códigos existentes.
          Basicamente, os blocos de memória não precisam ser segmentos de base mas isso significa
          que nossa lista se torna blocos de memória em vez de segmentos.
          O stream também se expandirá como os outros streams padrão
   }
   TMemoryStream = Class (TStream)
      private function ChangeListSize (ALimit: Sw_Word): Boolean;

      protected function LoadFromFile(aFileName:AnsiString):Boolean; Virtual;

     //Public
     Public BlkCount: Sw_Word;                           {:< Number of segments }
     Public BlkSize : Word;                              {:< Memory block size }
     Public MemSize : LongInt;                           {:< Memory alloc size }
     Public BlkList : PPointerArray;                     {:< Memory block list }
     Public Handle  : THandle;                           {:< Quando Handle=HANDLE_INVALID o bloco de memória não foi alocado }

     Public Function SetBufSize(Const aBufSize : Sw_Word):Sw_Word;Override;
     Public Function SetBufSize(ALimit: LongInt; ABlockSize: Word):Sw_Word;Overload;Virtual;

     Public Procedure SetFileName(a_FileName: AnsiString);Override;
     Public CONSTRUCTOR Create (ALimit, ABlockSize: Longint);overload;virtual;
     Public DESTRUCTOR Destroy;Override;
     Public PROCEDURE Truncate;Override;

     Public PROCEDURE Read (Var Buf; Count: Sw_Word;Var BytesRead:Sw_Word);Overload;override;
     Public PROCEDURE Read (Var Buf; Count: Sw_Word);Overload;Override;

     Public PROCEDURE Write (Var Buf; Count: Sw_Word;Var BytesWrite:Sw_Word);Overload;override;
     Public PROCEDURE Write (Var Buf; Count: Sw_Word);Overload;Override;

     //{: A classe **@name** deve ser implementada no pacote mi.ui.
     //
     //   - **NOTA**
     //     - Anular **@name** box anterior e implementar messabox para controlar a constante
     //       ok_Set_Transaction := false porque não existe transações em memória.
     //}
     //Public function MessageBox(const Msg: AnsiString): Word;override;

   END;



implementation

{--TMemoryStream------------------------------------------------------------}
{$Region ' TMemoryStream Class METHODS  '                                   }
{---------------------------------------------------------------------------}

  Function TMemoryStream.SetBufSize(ALimit: LongInt; ABlockSize: Word):Sw_Word;
    VAR
      W: Word;
  Begin
    Result := BlkCount;

    If (ABlockSize = 0)
    Then BlkSize := 8192                                 { Default blocksize }
    Else BlkSize := ABlockSize;                          { Set blocksize }

    If (ALimit = 0)                                      { At least 1 block }
    Then W := 1
    Else W := (ALimit + BlkSize - 1) DIV BlkSize;        { Blocks needed }

    If NOT ChangeListSize(W)                            { Try allocate blocks }
    Then Error(stCreateError,MemOverflow);               { Initialize error }
  end;

  Function TMemoryStream.SetBufSize(Const aBufSize : Sw_Word):Sw_Word;
  Begin
    Result := BlkCount;
    SetBufSize(1,aBufSize);
  end;

  CONSTRUCTOR TMemoryStream.Create (ALimit,ABlockSize: Longint);
  BEGIN
    Inherited Create;                                    { Call ancestor }
    Handle    := Self.HANDLE_INVALID;
    SetBufSize(aLimit,ABlockSize);
  END;


  DESTRUCTOR TMemoryStream.Destroy;
  BEGIN
    ChangeListSize(0);                                 { Release all memory }
    Handle    := Self.HANDLE_INVALID;
    State     :=  0;
    ErrorInfo :=  0;
    Inherited Destroy;                                    { Call ancestor }
  END;


  PROCEDURE TMemoryStream.Truncate;
  VAR W: Word;
  BEGIN
    If (Status = stOk) Then Begin                      { Check status okay }
      If (Position = 0) Then W := 1 Else               { At least one block }
        W := (Position + BlkSize - 1) DIV BlkSize;     { Blocks needed }
      If ChangeListSize(W) Then StreamSize := Position { Set stream size }
        Else Error(stError, MemOverflow);              { Error truncating }
    End;
  END;


  PROCEDURE TMemoryStream.Read (Var Buf; Count: Sw_Word;Var BytesRead:Sw_Word);
    VAR W, CurBlock, BlockPos: Word; Li: LongInt; P, Q: PByteArray;
  BEGIN
    BytesRead := 0;
    If (Position + Count > StreamSize) Then            { Insufficient data }
      Error(stReadError, ErroDeLeituraEmDisco);        { Read beyond end!!! }

    P := @Buf;                                         { Transfer address }
    While (Count > 0) AND (Status = stOk) Do
    Begin  { Check status & count }
      CurBlock := Position DIV BlkSize;                { Current block }
      { * REMARK * - Do not shorten this, result can be > 64K }
      Li := CurBlock;                                  { Transfer current block }
      Li := Li * BlkSize;                              { Current position }
      { * REMARK END * - Leon de Boer }
      BlockPos := Position - Li;                       { Current position }
      W := BlkSize - BlockPos;                         { Current block space }

      If (W > Count)
      Then W := Count;                                 { Adjust read size }

//      Q := Pointer(Longword(BlkList^[CurBlock]) + BlockPos); { Calc pointer }
      Q := BlkList^[CurBlock] + BlockPos; { Calc pointer }
      Move(Q^, P^, W);                                      { Move data to buffer }

      Inc(Position, W);                                     { Adjust position }
      Inc(BytesRead,W);
//    P := Pointer(Longword(P) + W);                         { Transfer address }

      Dec(Count, W);                                        { Adjust count left }
    End;

    If (Count <> 0)
    Then FillChar(P^, Count, #0);     { Error clear buffer }
  END;

  PROCEDURE TMemoryStream.Read (Var Buf; Count: Sw_Word);
    Var
      BytesRead:Sw_Word;
  Begin
    Read(Buf,Count,BytesRead);
  end;

  PROCEDURE TMemoryStream.Write (Var Buf; Count: Sw_Word;Var BytesWrite:Sw_Word);
    VAR W,
        CurBlock,
        BlockPos: Word;
        Li: LongInt;
        P,
        Q: PByteArray;
  BEGIN
    BytesWrite := 0;
    If (Position + Count > MemSize)
    Then Begin         { ExpAnsion needed }
          If (Position + Count = 0)
          Then W := 1                                         { At least 1 block }
          Else W := (Position+Count+BlkSize-1) DIV BlkSize;   { Blocks needed }

          If NOT ChangeListSize(W)
          Then Error(stWriteError, MemOverflow);              { ExpAnsion failed!!! }
        End;

    P := @Buf;                                                { Transfer address }
    While (Count > 0) AND (Status = stOk) Do
    Begin     { Check status & count }
      CurBlock := Position DIV BlkSize;                       { Current segment }
      { * REMARK * - Do not shorten this, result can be > 64K }
      Li := CurBlock;                                         { Transfer current block }
      Li := Li * BlkSize;                                     { Current position }
      { * REMARK END * - Leon de Boer }
      BlockPos := Position - Li;                              { Current position }
      W := BlkSize - BlockPos;                                { Current block space }

      If (W > Count)
      Then W := Count;                                        { Adjust write size }

//      Q := Pointer(Longword(BlkList^[CurBlock]) + BlockPos);   { Calc pointer }

      Q := BlkList^[CurBlock] + BlockPos;   { Calc pointer }

      Move(P^, Q^, W);                                        { Transfer data }

      Inc(Position, W);                                       { Adjust position }
      Inc(BytesWrite,W);

//      P := Pointer(Longword(P) + W);                          { Transfer address }
      Dec(Count, W);                                          { Adjust count left }

      If (Position > StreamSize)                              { File expanded }
      Then StreamSize := Position;                            { Adjust stream size }
    End;
  END;

  PROCEDURE TMemoryStream.Write (Var Buf; Count: Sw_Word);
    Var BytesWrite:Sw_Word;
  Begin
    Write (Buf,Count,BytesWrite);
  end;

  {***************************************************************************}
  {                      TMemoryStream PRIVATE METHODS                        }
  {***************************************************************************}
  FUNCTION TMemoryStream.ChangeListSize (ALimit: Sw_Word): Boolean;
    VAR I, W: Word; Li: LongInt; P: PPointerArray;
  BEGIN
    Try
      If (ALimit <> BlkCount)
      Then Begin                 { Change is needed }
              ChangeListSize := False;                         { Preset failure }
              If (ALimit > MaxPtrs)
              Then begin
                     result := false;
                     Exit;                 { To many blocks req }
                   end;

              If (ALimit <> 0)
              Then Begin                      { Create segment list }
                    Li := ALimit * SizeOf(Pointer);                { Block array size }
                    try
                      GetMem(P, Li);                               { Allocate memory }
                      FillChar(P^, Li, #0);                        { Clear the memory }

                    // Insufficient memory
                    except
                      result := false;
                      exit;
                    end;

                    If (BlkCount <> 0) AND (BlkList <> Nil)    { Current list valid }
                    Then If (BlkCount <= ALimit)
                          Then Move(BlkList^,P^, BlkCount * SizeOf(Pointer)){ Move whole old list }
                          Else Move(BlkList^, P^, Li);                      { Move partial list }
                  End
              Else P := Nil;                               { No new block list }

              If (ALimit < BlkCount)                     { Shrink stream size }
              Then For W := BlkCount-1 DownTo ALimit Do
                    FreeMem(BlkList^[W], BlkSize);               { Release memory block }

              If (P <> Nil) AND (ALimit > BlkCount)
              Then Begin // Expand stream size
                    For W := BlkCount To ALimit-1 Do
                    Begin
                      try
                        GetMem(P^[W], BlkSize);             { Allocate memory }
                      except
                        result := false;
                        exit;
                      end;
                    End;
                  End;

              If (BlkCount <> 0) AND (BlkList<>Nil)
              Then FreeMem(BlkList, BlkCount * SizeOf(Pointer));  { Release old list }

              BlkList  := P;                                    { Hold new block list }
              BlkCount := ALimit;                              { Hold new count }

              { * REMARK * - Do not shorten this, result can be > 64K }
              MemSize  := BlkCount;                             { Block count }
              MemSize  := MemSize * BlkSize;                    { Current position }
              { * REMARK END * - Leon de Boer }
            End;

      ChangeListSize := True;                            { Successful }

    Except
      Result := false;
    end;
  END;

  function TMemoryStream.LoadFromFile(aFileName:AnsiString):Boolean;
    Var
      F  : TFileStream;
      Nr : Longint;
  Begin
    Try
      Try
        F := TFileStream.Create('',stOpen or FmDenyNone);


        If aFileName = ''
        Then Begin
                Error(stOpenError,ParametroInvalido);
                exit;
             End;

        F.FileName := aFileName;
        F.Reset;
        If F.Status <> 0 Then Exit;

        F.Set_BaseSize(_Base,BaseSize);  {Seta a Ponteiro da base do arquivo F com o ponteiro da base de Self}
        If F.Status <> 0 Then Exit;

        F.Set_RecSize(_Rec,RecSize);     {Seta a Ponteiro do registro do arquivo F com o ponteiro do registro de Self}
        If F.Status <> 0 Then Exit;

        F.GetRecBase;                    {Ler a base de aFileName}
        If F.Status <> 0 Then exit;

        PutRecBase;                      {Grava a base de Self em Self}
        If Status <> 0 Then exit;

        Create_Progress1Passo('Carregando arquivo...',aFileName,FileSize-1);
        For Nr := 1 to F.FileSize-1 do
        Begin
           Set_Progress1Passo(Nr);
           F.GetRec(nr);             {Ler o Rec de aFileName}
           If F.Status <> 0 Then exit;

           PutRec(Nr);               {Grava o Rec em Self}
           If Status <> 0 Then exit;
        end;

      Finally
        If F.Status <> 0
        Then Error(F.Status,F.ErrorInfo);

        If Status <> 0
        Then Result := False
        Else Result := True;
        F.Free;

        Destroy_Progress1Passo;
      end;

   Except
     Result := False;
   end;
  end;


  Procedure TMemoryStream.SetFileName(a_FileName: AnsiString);
  Begin
    Try
      If (RecSize > 0) And (FileSize-1 = 0)
           And FileExists(FileName) and
           (TFiles.FileSize(a_FileName) > BaseSize)
      Then Begin
            If Not LoadFromFile(a_FileName)
            Then Abort;
          End;
    Except
      Error(StOk,0);
      If (FileSize-1 > 0)
      Then Truncate;
    end;

  end;

  //function TMemoryStream.MessageBox(const Msg: AnsiString): Word;
  //begin
  //  with Mi_MsgBox do
  //  begin
  //    Result := MessageBox(Msg,nil,MtError, [mbOK]);
  //  end;
  //end;


{$EndRegion ' TMemoryStream Class METHODS                                      }
{---------------------------------------------------------------------------}


end.

